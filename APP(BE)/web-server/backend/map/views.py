from django.shortcuts import render
from rest_framework.renderers import TemplateHTMLRenderer
from rest_framework.generics import RetrieveAPIView
from rest_framework.decorators import authentication_classes, api_view, permission_classes, renderer_classes
# from .models import Post
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.views import APIView

from django.contrib.auth.models import User
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
from rest_framework.views import APIView


from rest_framework.permissions import IsAuthenticated
from rest_framework.renderers import (
    AdminRenderer, BaseRenderer, BrowsableAPIRenderer, DocumentationRenderer,
    HTMLFormRenderer, JSONRenderer, SchemaJSRenderer, StaticHTMLRenderer
)

from django.shortcuts import render
#from django.http import httpResponse
# Create your views here.

@api_view(['GET'])
@permission_classes([permissions.AllowAny],)
@renderer_classes([StaticHTMLRenderer],)
def simple_html_view(request):
    data = "base.html"
    return Response(data)


def total_map(request):
    return render(request, 'base.html')