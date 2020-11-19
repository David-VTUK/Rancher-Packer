# packer-ubuntu-2004

An example [Packer][] template for building Ubuntu 20.04 LTS (Focal
Fossa). Ubuntu 20.04 brings with it a new installer, replacing the previous
[Debian installer][1] with [`subiquity`][2].

This is the companion example to my notes on doing this, [_Automating Ubuntu
20.04 installs with Packer_][3].

## Usage

```sh
packer build ubuntu-2004.json
```

## Author

Copyright (c) 2020 Nick Charlton. MIT Licensed.

[Packer]: https://packer.io
[1]: https://www.debian.org/devel/debian-installer/
[2]: https://github.com/CanonicalLtd/subiquity
[3]: https://nickcharlton.net/posts/automating-ubuntu-2004-installs-with-packer.html
