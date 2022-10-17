from channels.generic.websocket import WebsocketConsumer,AsyncWebsocketConsumer
from channels.db import database_sync_to_async
from channels.layers import get_channel_layer
from channels.exceptions import StopConsumer
from asgiref.sync import async_to_sync,sync_to_async
from .models import Notification, Reservation
from login.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from .utils import get_notification
from .serializers import NotificationSerializer

import json


@receiver(post_save, sender=Notification) #Notification model에 새로운 데이터가 추가되면 자동으로 websocket channel에 알림
def send_update(sender, instance, created, **kwargs):
    notification_serializer = NotificationSerializer(instance)

    if created:
        channel_layer=get_channel_layer()
        async_to_sync(channel_layer.group_send)(
            f"battalion_{notification_serializer.data['battalion_receiver']}_1", { #테스트용 group = 1
                "type": "notify",
                "data": notification_serializer.data,

            }
        )

class NotificationConsumer(WebsocketConsumer):
    def connect(self):
        self.battalion = self.scope['url_route']['kwargs']['battalion']
        self.user_id = self.scope['url_route']['kwargs']['user_id']
        self.user = User.objects.get(id=self.user_id)
        self.group_name = f'battalion_{self.battalion}_{self.user.permission}'
        
        print(self.group_name)

        async_to_sync(self.channel_layer.group_add)( # group 참여
            self.group_name,
            self.channel_name
        )
        self.accept() # websocket 연결 

    def disconnect(self, close_code):
        async_to_sync(self.channel_layer.group_discard)(
            self.group_name,
            self.channel_name
        )
        raise StopConsumer()
    
    def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json['message']

        # 같은 대대에게 메세지 send
        async_to_sync(self.channel_layer.group_send)(
            self.group_name,
            {
                'type': 'notify',
                'data': message
            }
        )

    def notify(self, data):
        self.send(text_data=json.dumps(data))