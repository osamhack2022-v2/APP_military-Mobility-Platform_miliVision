from django.contrib import admin
from mileage.models import *

# Register your models here.

@admin.display(description="Firm URL")
class HistoryAdmin(admin.ModelAdmin):
    model = History
    list_display = ('id', 'user_id', 'car_id', 'department', 'arrival', 'datetime', 'total_time', 'total_range')
    list_filter = ('id', 'user_id', 'car_id', 'department', 'arrival', 'datetime', 'total_time', 'total_range')
    fieldset = (
    	(None, {'fields': ('id', 'user_id', 'car_id', 'department', 'arrival', 'datetime', 'total_time', 'total_range')})	
    )
    add_fieldsets = (
    	(None, {
            'classes': ('wide',),
            'fields': ('id', 'user_id', 'car_id', 'department', 'arrival', 'datetime', 'total_time', 'total_range')}
    	),
    )
    search_fields = ('id', 'user_id')
    ordering = ('id', 'user_id')
    
    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        is_superuser = request.user.is_superuser

        if not is_superuser:
            pass

        return form
    
    
admin.site.register(History, HistoryAdmin)