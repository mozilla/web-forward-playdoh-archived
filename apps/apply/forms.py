from django import forms

from tower import ugettext as _

from apply.models import Application


class ApplicationForm(forms.ModelForm):
    """Public-facing Application form used in the web-interface for users."""
    class Meta:
        exclude = (
            'created_at',
            'updated_at',
        )
        model = Application
        widgets = {
            'first_name': forms.TextInput(
                attrs={'placeholder': _('First Name')}),
            'last_name': forms.TextInput(
                attrs={'placeholder': _('Last Name')}),
            'email': forms.TextInput(
                attrs={'placeholder': 'me@example.com'}),
            'phone': forms.TextInput(
                attrs={'placeholder': '+1 555-555-5555'}),
            'teammates': forms.Textarea(
                attrs={'placeholder': _('Names, separated by commas')}),
            'video_url': forms.TextInput(
                attrs={'placeholder': ('Introduce yourselves with a video, ' +
                'submit the URL to the video here')}),
            'pitch': forms.Textarea(
                attrs={'placeholder': _('Pitch your idea to us.')}),
        }
