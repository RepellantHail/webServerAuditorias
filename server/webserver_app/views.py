from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.conf import settings


# Create your views here.
def home(request):
    return HttpResponse("Hello, World!")