# Nixos on OpenBSD's VMM/VMD

This builds out the [virtio_vmmci](https://github.com/voutilad/virtio_vmmci) and [vmm_clock](https://github.com/voutilad/vmm_clock) Linux kernel modules.

Both modules improve the Linux experience on OpenBSD's hypervisor.

To use:

```
let
  vmm-config = builtins.fitchGet {
    url = "https://github.com/qbit/nix-conf.git"
  };

...

in {
  imports = [
    (import "${vmm-config}/vmm")
    ...
  ];
```
