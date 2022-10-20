from django.shortcuts import render
from rest_framework.views import APIView
from django.db.models import Q
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from .utils import *
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from login.views import get_user_from_access_token
from rest_framework.response import Response
from rest_framework import status
from .serializers import *

# Create your views here.

class history(APIView):
    @swagger_auto_schema(operation_summary='주행 기록 얻기', 
                         operation_description='''
                                            ---request---
                                               없음 : 요청한 토큰의 이용자 객체를 받아옴
                                            ---response---
                                               type: object
                                               model: History
                                               '''
                                               )
    def get(self, request):
        token = request.META['HTTP_AUTHORIZATION'][7:]
        user = get_user_from_access_token(token)
        historys = History.objects.filter(user_id=user.id)
        serializer = HistorySerializer(historys, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK) 
    
    @swagger_auto_schema(request_body=AddHistorySerializer, 
                         operation_summary="주행기록 작성하기",
                         operation_description='''
                                                ---request---
                                                car_id: (int)탑승한 차의 id / ex) 1111001
                                                departure: (string) 출발지 / ex) 서울
                                                arrival: (string) 도착지 / ex) 진해
                                                datetime: (datetime) 운행한 날짜 / ex) 2022-10-10T13:54:39.700000+09:00
                                                total_time: (int) 운행한 총 시간 / ex) 7
                                                total_range: (int) 운행한 총 거리 / ex) 412
                                                ---response---
                                                type: object
                                                model: History
                                               ''')
    def post(self, request):
        serializer = AddHistorySerializer(data=request.data)  # user_id를 빼고 입력 받는 serializer
        if serializer.is_valid():  # serializer가 유효 하다면
            token = request.META['HTTP_AUTHORIZATION'][7:]
            user_id = get_user_from_access_token(token)
            serializer.save(user_id = user_id)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter(
            "history_id",
            openapi.IN_QUERY,
            description="history_id",
            type=openapi.TYPE_INTEGER,
            default=""
    	)], 
                        operation_summary='주행기록 삭제하기',
                        operation_description= '''
                                               ---request---
                                               history_id: (int) 삭제하고 싶은 History의 id
                                               ---reponse---
                                               None
                                               ''')
    def delete(self, request):
        try:
            history_id = request.GET['history_id']
            History.objects.get(id=history_id).delete()
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)
