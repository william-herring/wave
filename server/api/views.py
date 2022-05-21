from rest_framework.response import Response
from rest_framework.generics import ListAPIView, CreateAPIView
from rest_framework.views import APIView
from rest_framework import permissions, filters
from rest_framework.status import *
from django.contrib.auth.models import User
from .serializers import *


class ListUserView(ListAPIView):
    permission_classes = [
        permissions.IsAdminUser
    ]

    queryset = User.objects.all()
    filter_backends = [filters.SearchFilter]
    search_fields = ['username']
    serializer_class = UserSerializer


class GetUserView(APIView):
    permission_classes = [
        permissions.IsAuthenticated
    ]

    def get(self, request, format=None):
        try:
            user = User.objects.filter(email=request.user.email)
            data = UserSerializer(
                data=user
            )

            return Response(data, status=HTTP_200_OK)
        except:
            return Response({'Not Found': 'Could not retrieve user data'}, status=HTTP_404_NOT_FOUND)


class CreateUserView(CreateAPIView):
    model = User
    serializer_class = UserSerializer
    permission_classes = [
        permissions.AllowAny  # This allows unauthenticated users to register an account
    ]
