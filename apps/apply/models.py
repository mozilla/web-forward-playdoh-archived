import datetime

from django import forms
from django.conf import settings
from django.db import models
from django.db.models import Count, signals


PROGRAMS = (
    ('6-month Fellows Program', '6-month Fellows Program'),
    ('4-week Bootcamp', '4-week Bootcamp'),
    ("Don't know - you tell me", "Don't know - you tell me"),
)

class Application(models.Model):
    """
    An application to Web Forward containing personal information about the
    submitter and details of the propsed incubator project.
    """
    program_selection = models.CharField(max_length=50,
                                         choices=PROGRAMS,
                                         verbose_name='Which program do you want to apply for?')

    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.EmailField(verbose_name='Email Address')
    phone_number = models.CharField(max_length=30)

    teammates = models.TextField(verbose_name='Names of all Teammates',
                                 blank=True)
    team_info = models.TextField(verbose_name='For each of you, please list your name, age, year of graduation, school, degree and subject for each degree, email address, personal url, github url, employer and title (if applicable). Separate team members with blank lines.')
    location = models.TextField(verbose_name='Where do you live now?')

    video_url = models.URLField(verbose_name="Video Intro: Please send a brief video introducing yourself and your project. We don't care about the quality of the video ((hone video is fine), we just want to see and hear you.",
                                verify_exists=False, blank=True)

    pitch = models.TextField(verbose_name='What are you building? What is your product about?')
    idea_relevance = models.TextField(verbose_name='Why do you think your product matters? Why should anyone care?')

    interest = models.TextField(verbose_name='The WebFWD site lists areas of interest to Mozilla and relevant to the open, decentralized Web. How does your solution relate to these interest areas?')

    benefit = models.TextField(verbose_name='How do you hope to benefit from WebFWD?')

    progress = models.TextField(verbose_name="How long have you been working on your product and how many lines of code (if applicable) have been written?")

    launch_info = models.TextField(verbose_name="How far along are you? Do you have a alpha/beta/v1 yet? If not, when will you? Are you launched? If so, how many users do you have? If you've launched, what is your monthly growth rate?")

    demo_url = models.URLField(verbose_name="If you have an online demo, what's the URL?", verify_exists=False, blank=True)

    team_prior_commitments = models.TextField(verbose_name='Please describe any upcoming future commitments such as finishing college, going to grad school, or moving to a new location.',
                                              blank=True)

    source_code_info = models.TextField(verbose_name='Was any of your code written by someone who is not one of your founders or team members? If so, how can you safely use it? (Open Source is fine.)',
                                        blank=True)

    team_accomplishments = models.TextField(verbose_name="Tell us a bit more about yourself. What's the most amazing thing you've done so far? Separate team members with blank lines and submit individual answers with each person's name.")

    team_history = models.TextField(verbose_name="For team applications: Please tell us how long you've known each other, whether you've met in person, and whether you've worked together on other projects. (If you have stuff on the Web, please share an URL.)",
                                    blank=True)

    anecdote = models.TextField(verbose_name='Please tell us something surprising or amusing that one of you has discovered. (The answer need not be related to your project.)')

    other = models.TextField(verbose_name='Is there anything else we should know about you, your team, or your project?',
                             blank=True)

    want_designer = models.BooleanField(default=False, verbose_name="I'm interested in getting matched to a UI/UX designer.")

    # Legacy model fields that aren't used anymore or shown in forms.
    # Previous submissions have these fields though, so we keep them around
    # so the data is preserved.
    reason_for_idea = models.TextField(blank=True,
                                       verbose_name='Why did you choose this idea to work on? Why do you think you will be successful with your idea?')
    uniqueness_of_idea = models.TextField(blank=True,
                                          verbose_name="What's new and/or different about your product? What do people today without your product?")
    why_mozilla = models.TextField(blank=True,
                                   verbose_name='Why do you think Mozilla is the right place for you?')
    team_exclusive_members = models.TextField(blank=True,
                                              verbose_name='If we bring you into the program, who of you will commit working exclusively (no school, no other jobs) on this project for the duration of the project?')
    team_non_exclusive_members = models.TextField(blank=True,
                                                  verbose_name="For the people on your team who can't/don't want to commit full-time: Why not? What level of commitment are you willing to make?")
    legal = models.TextField(blank=True, verbose_name='Are any of you covered by noncompetes or intellectual property agreements which overlap with your project?')

    # Admin-only fields; not presented to the user and ignored in
    # the ApplicationForm class.
    accepted_date = models.DateTimeField(blank=True)
    reviewed_date = models.DateTimeField(blank=True)
    comments = models.TextField(blank=True, verbose_name='Internal comments for submission')

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
