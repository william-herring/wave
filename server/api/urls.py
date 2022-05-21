from django.contrib import admin
from .views import *
from django.urls import path, include

urlpatterns = [
    path('users', ListUserView.as_view()),
    path('create-user', CreateUserView.as_view()),
    path('get-user', GetUserView.as_view())
]
