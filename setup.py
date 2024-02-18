#!/usr/bin/env python
# -*- coding: UTF-8 -*-
from setuptools import setup, find_packages

with open("README.md", "r") as f:
    long_description = f.read()

setup(
    name='cvbench',
    version="0.0",
    description='Explorations in OpenCV',
    long_description=long_description,
    license='MIT',
    author='Ilja Heitlager',
    # author_email='',
    maintainer='Ilja Heitlager',
    maintainer_email='iheitlager@schubergphilis.com',
    keywords=["development-tools"],
    url='https://github.com/iheitlager/cv-bench',
    packages=find_packages('src'),
    package_dir={'': 'src'},
    test_suite="tests",
    platforms=["any"],
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "Environment :: Console",
        "Operating System :: OS Independent",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.11",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Natural Language :: English"
    ],
    install_requires=[],
    zip_safe=True,
)