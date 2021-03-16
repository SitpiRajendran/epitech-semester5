FROM jenkins/jenkins:latest
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV USER_CHOCOLATEEN_PASSWORD user
ENV USER_VAUGIE_G_PASSWORD user
ENV USER_I_DONT_KNOW_PASSWORD user
ENV USER_NASSO_PASSWORD user
ENV CASC_JENKINS_CONFIG /var/jenkins_home/configuration.yml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY ./configuration.yml /var/jenkins_home/configuration.yml