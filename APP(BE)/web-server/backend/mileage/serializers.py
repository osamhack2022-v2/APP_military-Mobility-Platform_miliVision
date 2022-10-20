from rest_framework import serializers
from .models import *

class HistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = History
        fields = '__all__'
        
class AddHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = History
        fields = ('car_id', 'department', 'arrival', 'datetime', 'total_time', 'total_range')
    