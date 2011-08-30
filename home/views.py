from django.http import HttpResponse

def index(request):
  return HttpResponse('Abe !')

def login(request, error=None):
  return HttpResponse(error)

def do_login(request):
  if request.user.is_authenticated():
    return HttpResponseRedirect('/')
  else:
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
      if user.is_active:
        login(request, user)
        return HttpResponseRedirect('/')
      else:
        return HttpResponseRedirect('/login')
    else:
      return HttpResponseRedirect('/login/invalid')
