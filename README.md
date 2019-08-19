# Portable Python - No Installation Required!

Have you ever had any problems installing multiple versions of Python on your machine?

Did you need multiple Python patch releases on your machine for some reason at the same time?

You uninstalled Python but it still showed up in installed apps?

If you answered yes at least once, then this project will have you covered!

This project contains a bunch of Python releases packaged in zip archives. The archives are created from files installed by the official Python installer, nothing else. Each version will have a 32-bit and 64-bit version available.

Check out [releases](https://github.com/oswjk/portablepython/releases) for downloads!

# Recreating scripts

A normal Python installation can be configured to have a Scripts directory that contains `pip` and `easy_install` scripts that you can invoke directly.

The portable zip file does not contain this directory. If you need it, it is easy to recreate with the `ensurepip` package.

First, you need to uninstall pip and setuptools:

```
python -m pip uninstall setuptools pip
```

Now you can run the `ensurepip` package to install `pip` and `setuptools` and to create the scripts:

```
python -m ensurepip --default-pip
```

Make sure that the Python you are invoking, is the correct one! You can do this for example by specifying the full path to the Python executable when entering the commands above.

That should be all!
