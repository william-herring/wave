# Wave
This app is being built for the Science Talent Search Victoria 2022.

Wave is an app for viewing sound in waveforms (commonly known as sound waves) and constructing soundwaves with a visual editor. It also features educational resources and online capabilities such as publication of waves for others to use.

## Table of Contents
1. [Concept](#concept)
2. [Science](#science)
3. [Technology](#technology)
    - [Setup](#setup)
4. [Contributing](#contributing)

## Concept
Wave is envisioned as a highly-capable sound editor and sampler. The app is built around the concept of waveforms to represent sound visually. The two key features of the app involve both the recording of sound waves, as well as creating sound waves with the use of a visual editor. Aimed to appeal to the scientific/physics community, 'waves' may be shared online and cloned by other users to allow for the scientific community to analyse the same wave(s) and perform individual experiments.
## Science
Sound travels in mechanical waves that are formed from the various frequencies in which particles vibrate. <br><br>
![An example of physical sound waves](http://www.physicsclassroom.com/Class/sound/tfl.gif) <br>
Source: https://www.physicsclassroom.com/ <br><br>
A wavelength is the distance which a sound wave must travel to complete one wave cycle (one repetition of the pattern). This can also be thought of as the length of the pattern. There are three basic components that make up a sound wave; frequency, wavelength and amplitude. <br><br>
![A diagram demonstrating the three basic components of a sound wave](https://oceanexplorer.noaa.gov/explorations/sound01/background/acoustics/media/sinewave_261.jpg) <br>
Source: https://oceanexplorer.noaa.gov <br><br>
Wavelength has already been defined above, but what are frequency and amplitude? Frequency is the rate at which a cycle occurs. In the example above, this is 2 cycles per second or 2 Hz. The amplitude of a sound wave is represented by its height. The higher a wave is, the louder it is.
## Technology
Wave is built with Flutter and Django. Flutter is used to build the UI of the app, while Django is used in the back-end. To serve and receive data, Django REST Framework is used to build out a functional API. The back-end is designed for a PostgreSQL database. Files will likely be stored in AWS S3.
### Setup
Prerequisites: Python 3.x, Flutter 3, pretty much any version of PostgreSQL

1. Create a new database ```createdb wavedb```
2. Install Python packages
```
cd ~/path/to/wave/server
pip3 install -r requirements.txt
```
3. Install Flutter/Dart packages
```
cd ~/path/to/wave/client
flutter pub get
```
4. Edit database settings in server/server/settings.py
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'wavedb',
        'USER': '{ YOUR USER }',
        'PASSWORD': os.environ.get('DATABASE_PASSWORD'),
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```
5. Create server/server/.env and add database password
```
DATABASE_PASSWORD={ POSTGRES USER PASSWORD }
```
6. Start the server
```
cd ~/path/to/wave/server
python3 manage.py migrate
python3 manage.py runserver
```
7. Run the app (ensure simulator/device is connected)
```
cd ~/path/to/wave/client
flutter run
```
## Contributing
Since this is being built for the Science Talent Search Victoria, it would not be right to accept code contributions at this stage. However, anyone who is willing to help test the app can reach out to me at [my email](mailto:william.herring.au@gmail.com).
