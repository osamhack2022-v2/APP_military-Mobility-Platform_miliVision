from django.contrib import admin
from django.utils.html import format_html

# Register your models here.
class MapAdmin(admin.ModelAdmin):
    
    def show_firm_url(self, obj):
        return format_html("<a href='{url}'>{url}</a>", url="http://20.214.203.20:8000/map/")
    
#admin.site.register(MapAdmin)