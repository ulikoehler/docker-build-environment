# buildock
*Reproducible build environments for local builds using Docker*

Do you need to make your builds (e.g. using *make* and *cmake*) or software (e.g. using *node* or *python3*) to reliably work on a wide range of different host systems, but you still want to keep your actual application's files locally on the host system?

## What does it do?

*buildock* is for your. *buildock* provides two sets of tools:
 - A shell function `buildock` that wraps `docker` to facilitate easy local builds
 - Several pre-built docker images that have software like `make` and `gcc`. These images are just for convenience!

## How to install

**If you just want to try it out:**
```sh
git clone https://github.com/ulikoehler/buildock
source buildock/buildock.sh
```

**Permanent installation:**

For `bash`:
```sh
curl -s https://raw.githubusercontent.com/ulikoehler/buildock/master/buildock.sh >> ~/.bashrc
```

For `zsh`:
```sh
curl -s https://raw.githubusercontent.com/ulikoehler/buildock/master/buildock.sh >> ~/.zshrc
```

This will add a [`buildock` function](https://github.com/ulikoehler/buildock/blob/master/buildock.sh) to your `~/.bashrc` or  `~/.zshrc`.

This function will be automatically loaded once you restart your shell. To load `buildock` in already active shells, run `source ~/.bashrc` or `source ~/.zshrc`, else you'll see `command not found: buildock`

## How to use

Usage:

```
buildock <image name> <command(s)>
```

Example: To compile a C++ application using `make`:
```sh
buildock ulikoehler/ubuntu-gcc-make make
```
cmake
This command is mostly equivalent to just running `make` locally, however using the *docker*-based approach you don't have to deal with different compiler/make versions on different host systems producing.

By default, *buildock* does not enable interactive mode (`docker run --interactive/-i`) or allocate a pseudo-TTY (`docker run --tty/-t`) to facilitate easy automated builds in non-TTY environments like Gitlab runners.
In case you need to run in **interactive mode** (e.g. if you need to interact with the program being run), use this syntax:
```sh
buildock -it ulikoehler/ubuntu-gcc-make make
```

## How does it work`

`buildock` creates a new container using the given imamage an mounts the current working directory (`$(pwd)`) to `/app` on said container. It then runs the user-defined command on the container (e.g. `make`).
Additionally it ensures that the `docker` container runs under the current user using `--user $(id -u):$(id -g)`. This prevents the output files (if any) to be created as `root` user, instead they will be created with the user and group running `buildock`.

## How to make custom *buildock* images

Easy: Just use any docker container with the software you need installed. The only requirement is that `/app` is not used for anything relevant in the image, since `/app` is where `buildock` will mount the current directory to.

## More reading

* The post that started it all: [Towards a docker-based build of C/C++ applications](https://techoverflow.net/2019/06/27/towards-a-docker-based-build-of-c-c-applications/)