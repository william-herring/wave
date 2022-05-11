from rest_framework.serializers import ModelSerializer, CharField, EmailField, StringRelatedField
from django.contrib.auth.models import User


class UserSerializer(ModelSerializer):
    password = CharField(write_only=True)
    email = EmailField()

    def create(self, validated_data):

        user = User.objects.create_user(
            email=validated_data['email'],
            username=validated_data['username'],
            password=validated_data['password'],
        )

        return user

    class Meta:
        model = User
        fields = ('id', 'username', 'password', 'email')