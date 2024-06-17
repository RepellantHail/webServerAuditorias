from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.conf import settings

# Create your views here.
def home(request):
    some_data = "This is some static data"
    context = {'data': some_data}
    return render(request, 'home.html', context)