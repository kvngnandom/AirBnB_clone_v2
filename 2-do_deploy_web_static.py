#!/usr/bin/python3

"""
Deploying the archive
base file -> 1-pack_web_static.py
"""

import os
from fabric.api import env, put, run

# Set the web servers' IP addresses and username
env.hosts = ['100.26.166.45', '100.25.198.207']
env.user = 'ubuntu'


def do_deploy(archive_path):
    """Deploys an archive to the servers"""
    if not os.path.exists(archive_path):
        return False

    try:
        # Upload the archive to /tmp/ directory on the web server
        put(archive_path, '/tmp/')

        # Extract the archive to /data/web_static/releases/
        archive_filename = os.path.basename(archive_path)
        release_dir = '/data/web_static/releases/' + archive_filename[:-4]
        run('sudo mkdir -p {}'.format(release_dir))
        run('tar -xzf /tmp/{} -C {}'.format(archive_filename, release_dir))

        # Remove the uploaded archive
        run('sudo rm /tmp/{}'.format(archive_filename))

        # Move the extracted files to the correct location
        run('sudo mv {}/web_static/* {}'.format(release_dir, release_dir))

        # Remove the web_static symbolic link
        run('sudo rm -rf {}/web_static'.format(release_dir))

        # Delete the current symbolic link
        run('sudo rm -rf /data/web_static/current')

        # Create a new symbolic link
        run('ln -s {} /data/web_static/current'.format(release_dir))

        print('New version deployed!')
        return True

    except Exception as e:
        print('Deployment failed:', e)
        return False
