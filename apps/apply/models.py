import datetime

from django import forms
from django.conf import settings
from django.db import models
from django.db.models import Count, signals


AREAS_OF_INTEREST = (
    ('Identity', 'Identity'),
    ('Social', 'Social'),
    ('User Mediated Data', 'User Mediated Data'),
    ('Personalization', 'Personalization'),
    ('Contextual Integrity', 'Contextual Integrity'),
    ('Read-Write Ability', 'Read-Write Ability'),
    ('Core', 'Core'),
)

class Application(models.Model):
    """
    An application to Web Forward containing personal information about the
    submitter and details of the propsed incubator project.
    """
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.EmailField(verbose_name='Email Address')
    phone_number = models.CharField(max_length=30)
    teammates = models.TextField(verbose_name='Names of all Teammates')
    video_url = models.URLField(verbose_name='Video Intro',
                                verify_exists=False)
    pitch = models.TextField(verbose_name='What is your team going to build?')
    interest = models.CharField(max_length=50, choices=AREAS_OF_INTEREST,
                                verbose_name='Within which of our interest areas does your solution play?')

    team_info = models.TextField(verbose_name='For each of you, please list your name, age, year of graduation, school, degree and subject for each degree, email address, personal url, github url, employer and title (if applicable). Separate team members with blank lines.')
    team_accomplishments = models.TextField(verbose_name="Tells us a bit about yourself - what's the most amazing thing each of you has done so far? Separate team members with blank lines and start each answer with your respective name.")
    team_history = models.TextField(verbose_name='How long have you known each other, have you all met in person yet and what have you done together before? (If you have stuff on the Web: add an URL.)')

    reason_for_idea = models.TextField(verbose_name='Why did you choose this idea to work on? Why do you think you will be successful with your idea?')
    uniqueness_of_idea = models.TextField(verbose_name="What's new and/or different about your product? What do people today without your product?")
    idea_relevance = models.TextField(verbose_name='Why does your product matter?')
    why_mozilla = models.TextField(verbose_name='Why do you think Mozilla is the right place for you?')
    progress = models.TextField(verbose_name="If you've already started working on your product, how long have you been working and how many lines of code (if applicable) have you written?")
    launch_info = models.TextField(verbose_name="How far along are you? Do you have a alpha/beta/v1 yet? If not, when will you? Are you launched? If so, how many users do you have? If you're launched, what is your monthly growth rate?")
    demo_url = models.URLField(verbose_name="If you have an online demo, what's the URL?", verify_exists=False)
    team_exclusive_members = models.TextField(verbose_name='If we bring you into the program, who of you will commit working exclusively (no school, no other jobs) on this project for the duration of the project?')
    team_non_exclusive_members = models.TextField(verbose_name="For the people on your team who can't/don't want to commit full-time: Why not? What level of commitment are you willing to make?")
    team_prior_commitments = models.TextField(verbose_name='Do any of you have commitments in the future (e.g. finishing college, going to grad school), and if so what?')
    location = models.TextField(verbose_name='Where do you live now?')

    legal = models.TextField(verbose_name='Are any of you covered by noncompetes or intellectual property agreements which overlap with your project?')
    source_code_info = models.TextField(verbose_name='Was any of your code written by someone who is not one of your founders? If so, how can you safely use it? (Open Source is fine.)')

    anecdote = models.TextField(verbose_name='Please tell us something surprising or amusing that one of you has discovered. (The answer need not be related to your project.)')
    other = models.TextField(verbose_name='Anything else we should or need to know?')
    
    # Timestamps!
    created_at = models.DateTimeField(editable=False)
    updated_at = models.DateTimeField(editable=False)

    def save(self, *args, **kwargs):
        """
        Override the save method to automatically set the created_at and
        updated_at fields with current date info.
        """
        if self.created_at == None:
            self.created_at = datetime.datetime.now()
        self.updated_at = datetime.datetime.now()

        super(Application, self).save(*args, **kwargs)

    def __unicode__(self):
        """Return the first/last name of the application submitter."""
        if self.first_name and self.last_name and self.created_at:
            return u'{first_name} {last_name}, on {date}'.format(
                first_name=self.first_name, last_name=self.last_name,
                date=self.created_at.strftime('%x'))
        else:
            return u'Incomplete/Invalid Application'
