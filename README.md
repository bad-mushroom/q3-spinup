# Q3 Spinup

Q3 Spinup is a simple way to run one or many Quake 3 servers without the need of installing and configuring Quake 3.

Builds ioquake3 from source and uses Docker containers for easy server management.

Run your own Master Server.

```
$ docker ps
IMAGE                  COMMAND                  PORTS                      NAMES
q3-spinup_quake3-dm    "/ioq3/build/release…"   0.0.0.0:27960->27960/udp   quake3-dm
q3-spinup_quake3-ctf   "/ioq3/build/release…"   0.0.0.0:27961->27960/udp   quake3-ctf
q3-spinup_quake3-tdm   "/ioq3/build/release…"   0.0.0.0:27962->27960/udp   quake3-tdm
q3-spinup_dpmaster     "/dpmaster/src/dpmas…"   0.0.0.0:27950->27950/udp   dpmaster
```

## Prerequisites

There's a few things you'll need from the get go.

* Docker
* Git or Unzip utility
* Quake 3 `pak0.pk3` file (from your Q3A CD or Steam installation)

## Setup Instructions

First step is to get this code on your server, or wherever you plan on hosting your Quake 3 server. The steps below will guide you through that process. These steps also assume a Linux environemnt but they should be simple enough to follow along with their Mac or Windows equivalents.

### Download

If you have Git installed you can clone this repo:

```
$ git clone https://github.com/bad-mushroom/q3-spinup.git ./path/to/q3-spinup
```

If you prefer, you could instead download and extract a zip file:

[https://github.com/bad-mushroom/q3-spinup/archive/refs/heads/main.zip](https://github.com/bad-mushroom/q3-spinup/archive/refs/heads/main.zip)

```
$ unzip main.zip -d ./path/to/q3-spinup
```

### pak0.pk3 File

Quake III is open source, but it's not free. ioquake3 requires your `pak0.pk3`, basically your "license file", to run. You can copy it from your Quake III Arena CD or if you installed through Steam, you can get it from the `baseq3` directory where Quake 3 is installed.

With the `pak0.pk3` available, copy it to `./path/to/q3-spinup/q3a-game/baseq3`.

### Game Config Files

In the `./q3a-game/baseq3/configs` folder are Quake 3 server configs for different game types. In these files is where you'll set things like "time limit", "max players", "server name", etc.

You can leave the default values, change them, or create new config files. If you change the name, make
sure to also update `docker-config.yml` so it knows what it's called:

```
command: "+set dedicated 2 +exec configs/my_new_server.cfg"
```

## Spinup

With your config files set to your liking and the `pak0.pk3` file in its place, you can fire up your quake instances.

```
docker-compose up
```

The first time your run this command it will likely take a few minutes to complete as it will dowload the latest ioquake3 source, compile it, and build a Docker image.

When it's ready, you'll see output similar to:

```
Attaching to quake3-dm
quake3-dm  | tty console mode disabled
quake3-dm  | ioq3 1.36_GIT_29b0cc3a-2022-01-04 linux-arm64 Sep  9 2022
quake3-dm  | ----- FS_Startup -----
quake3-dm  | We are looking in the current search path:
quake3-dm  | /home/ioq3/.q3a/baseq3
quake3-dm  | /home/ioq3/.q3a/baseq3/pak8.pk3 (9 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak7.pk3 (4 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak6.pk3 (64 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak5.pk3 (7 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak4.pk3 (272 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak3.pk3 (4 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak2.pk3 (148 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak1.pk3 (26 files)
quake3-dm  | /home/ioq3/.q3a/baseq3/pak0.pk3 (3539 files)
quake3-dm  | /ioq3/build/release-linux-arm64/baseq3
quake3-dm  |
```

More likely, you'll want to run all this in the background. You can add the `-d` flag to do so.

```
docker-compose up -d
```

## Master Server

Master Servers are directories of Quake servers (and compatible games) live on the internet. Q3 Spinup comes with its own.

If you only want to run a private instance of Quake 3 for you and your friends you can comment out
the "dpmaster" block in `docker-compose.yml`.

If you choose to leave dpmaster enabled you'll want to add it to the server config file(s) for your game types similar to the example below:

```
sv_master1 "master.quake3arena.com"
sv_master2 "<your-awesome-master.host.com"
```

## Running Multiple Servers

Docker makes this pretty easy for us right out of the box but Quake 3 has some requirements we'll need to address.

### Ports

By default, Quake 3 runs on port 27960. If you're hosting multiple servers you'll need to make sure each port is uniq


### Docker

The `docker-config.yml` is the configuration for your instances of Quake 3. Under the "services" section of this file is a config block for the most common game types. You're free to have has many instances as your hardware can handle - just copy and paste one of the blocks and rename and configure to your preference.

Just remember that each port number must be unique. If you want multiple Deathmatch instances for example, set your ports to something like 27960, 27961... and so on.


## Troubleshooting

> "pak0.pk3" is missing. Please copy it from your legitimate Q3 CDROM. Point Release files are missing. Please re-install the 1.32 point release. Also check that your ioq3 executable is in the correct place and that every file in the "baseq3" directory is present and readable

Make sure you copy a valid `pak0.pk3` to `./path/to/q3-spinup/baseq3`.


> I changed some values `docker-compose.yml` but nothing changed with my instances.

Any time you make modifications to `docker-compose.yml` you'll need to restart the Docker containers.

```
docker-compose down
docker-compose up -d
```


## Support the Project

Show some ❤️ and [buy me a coffee](https://ko-fi.com/g0dzuki99) 😄

<a href='https://ko-fi.com/H2H0CTMMB' target='_blank'>
<img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi2.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' />
</a>

You could also fix bugs, streamline the build, update documentation - pull requests are welcome!
