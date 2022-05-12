from rest_framework.generics import ListAPIView, CreateAPIView
from rest_framework.views import APIView
from rest_framework import permissions, filters
from rest_framework.status import *
from django.contrib.auth.models import User
from .serializers import *


class ListUserView(ListAPIView):
    permission_classes = [
        permissions.AllowAny
    ]

    queryset = User.objects.all()
    filter_backends = [filters.SearchFilter]
    search_fields = ['username']
    serializer_class = UserSerializer


class CreateUserView(CreateAPIView):
    model = User
    serializer_class = UserSerializer
    permission_classes = [
        permissions.AllowAny  # This allows unauthenticated users to register an account
    ]
