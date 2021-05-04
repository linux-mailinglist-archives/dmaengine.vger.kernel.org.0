Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3A372E2D
	for <lists+dmaengine@lfdr.de>; Tue,  4 May 2021 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhEDQjv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 May 2021 12:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231602AbhEDQjv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 May 2021 12:39:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A333761177;
        Tue,  4 May 2021 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620146336;
        bh=WGHPPs4w6bWsewmYioHaBuzh4xo3duDHdMH9cbOnfxA=;
        h=Date:From:To:Cc:Subject:From;
        b=UY3PyfwLqNhAxfHYAmHrr1RiTI0ej1EIaFv30R6RMb6+2Awa4QA/npohfjoUKETpv
         D4Om3vdM4o6zAhwIDU2R1DJ6IgYg3NHqmd0tMHAazmstiof3NNm4PyF5OhzjWLE81N
         fG1M6YeaweQ2m+0IZGPzMi48YNiGYBbAwJNTD75+zHzbLZIoxXPSXqjXI3EWiR1HFG
         wWFxik+Y9flC97nW2GwfGuBsmwPiK3FICn7w8FkQPxwU6urRl1RLbQTIZ42R2oUuPf
         rmTpQsZeUMOPAp5MChtQSR+CMNieLHm09LTXc6iANQ6NqjC+PMlL9Ur4N7e+XcNqH8
         11e8KFkpzrglw==
Date:   Tue, 4 May 2021 22:08:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.13-rc1
Message-ID: <YJF4nAJ/XXY9qUuI@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WzQOajWiqVg22n3c"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--WzQOajWiqVg22n3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the dmaengine pull request for this cycle. Please pull:

The following changes since commit ea9aadc06a9f10ad20a90edc0a484f1147d88a7a:

  dmaengine: idxd: fix wq cleanup of WQCFG registers (2021-04-12 22:08:39 +=
0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.13-rc1

for you to fetch changes up to 0bde4444ec44b8e64bbd4af72fcaef58bcdbd4ce:

  dmaengine: idxd: Enable IDXD performance monitor support (2021-04-25 21:4=
6:12 +0530)

----------------------------------------------------------------
dmaengine updates for v5.13-rc1

New drivers/devices
 - Support for QCOM SM8150 GPI DMA

Updates:
 - Big pile of idxd updates including support for performance monitoring
 - Support in dw-edma for interleaved dma
 - Support for synchronize() in Xilinx driver

----------------------------------------------------------------
Colin Ian King (1):
      dmaengine: idxd: Fix potential null dereference on pointer status

Dave Jiang (19):
      dmaengine: idxd: fix dma device lifetime
      dmaengine: idxd: cleanup pci interrupt vector allocation management
      dmaengine: idxd: removal of pcim managed mmio mapping
      dmaengine: idxd: use ida for device instance enumeration
      dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime
      dmaengine: idxd: fix wq conf_dev 'struct device' lifetime
      dmaengine: idxd: fix engine conf_dev lifetime
      dmaengine: idxd: fix group conf_dev lifetime
      dmaengine: idxd: fix cdev setup and free device lifetime issues
      dmaengine: idxd: iax bus removal
      dmaengine: idxd: remove detection of device type
      dmaengine: idxd: add percpu_ref to descriptor submission path
      dmaengine: idxd: add support for readonly config mode
      dmaengine: idxd: add interrupt handle request and release support
      dmaengine: idxd: convert sprintf() to sysfs_emit() for all usages
      dmaengine: idxd: enable SVA feature for IOMMU
      dmaengine: idxd: support reporting of halt interrupt
      dmaengine: idxd: device cmd should use dedicated lock
      dmaengine: idxd: remove MSIX masking for interrupt handlers

Felipe Balbi (1):
      dt-bindings: dmaengine: qcom: gpi: add compatible for sm8150

Gustavo Pimentel (15):
      dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures
      dmaengine: dw-edma: Fix comments offset characters' alignment
      dmaengine: dw-edma: Add support for the HDMA feature
      PCI: Add pci_find_vsec_capability() to find a specific VSEC
      dmaengine: dw-edma: Add PCIe VSEC data retrieval support
      dmaengine: dw-edma: Add device_prep_interleave_dma() support
      dmaengine: dw-edma: Improve number of channels check
      dmaengine: dw-edma: Reorder variables to keep consistency
      dmaengine: dw-edma: Improve the linked list and data blocks definition
      dmaengine: dw-edma: Change linked list and data blocks offset and siz=
es
      dmaengine: dw-edma: Move struct dentry variable from static definitio=
n into dw_edma struct
      dmaengine: dw-edma: Fix crash on loading/unloading driver
      dmaengine: dw-edma: Change DMA abbreviation from lower into upper case
      dmaengine: dw-edma: Revert fix scatter-gather address calculation
      dmaengine: dw-edma: Add pcim_iomap_table return check

Hao Fang (1):
      dmaengine: k3dma: use the correct HiSilicon copyright

Jiapeng Chong (1):
      dmaengine: qcom_hidma: remove unused code

Lars-Peter Clausen (1):
      dmaengine: xilinx: Introduce synchronize() callback

Tom Zanussi (2):
      dmaengine: idxd: Add IDXD performance monitor support
      dmaengine: idxd: Enable IDXD performance monitor support

Vinod Koul (1):
      Merge branch 'fixes' into next

YueHaibing (1):
      dmaengine: at_xdmac: Remove unused inline function at_xdmac_csize()

 .../ABI/testing/sysfs-bus-event_source-devices-dsa |  30 +
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   1 +
 drivers/dma/Kconfig                                |  12 +
 drivers/dma/at_xdmac.c                             |  11 -
 drivers/dma/dw-edma/dw-edma-core.c                 | 178 +++--
 drivers/dma/dw-edma/dw-edma-core.h                 |  37 +-
 drivers/dma/dw-edma/dw-edma-pcie.c                 | 277 ++++++--
 drivers/dma/dw-edma/dw-edma-v0-core.c              | 300 ++++++--
 drivers/dma/dw-edma/dw-edma-v0-core.h              |   2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c           |  77 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h           |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-regs.h              | 291 +++++---
 drivers/dma/idxd/Makefile                          |   2 +
 drivers/dma/idxd/cdev.c                            | 132 ++--
 drivers/dma/idxd/device.c                          | 283 +++++++-
 drivers/dma/idxd/dma.c                             |  77 +-
 drivers/dma/idxd/idxd.h                            | 168 ++++-
 drivers/dma/idxd/init.c                            | 485 +++++++++----
 drivers/dma/idxd/irq.c                             |  29 +-
 drivers/dma/idxd/perfmon.c                         | 662 ++++++++++++++++++
 drivers/dma/idxd/perfmon.h                         | 119 ++++
 drivers/dma/idxd/registers.h                       | 120 +++-
 drivers/dma/idxd/submit.c                          |  42 +-
 drivers/dma/idxd/sysfs.c                           | 776 +++++++++--------=
----
 drivers/dma/k3dma.c                                |   4 +-
 drivers/dma/qcom/gpi.c                             |   1 +
 drivers/dma/qcom/hidma.c                           |   6 -
 drivers/dma/xilinx/xilinx_dma.c                    |   8 +
 drivers/pci/pci.c                                  |  30 +
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/pci.h                                |   1 +
 31 files changed, 3030 insertions(+), 1136 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-device=
s-dsa
 create mode 100644 drivers/dma/idxd/perfmon.c
 create mode 100644 drivers/dma/idxd/perfmon.h
--=20
~Vinod

--WzQOajWiqVg22n3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmCReJwACgkQfBQHDyUj
g0fkbA/+I5Q7qI8gUWbFr7y/Kmk9Sq3c51Lk+JuLlguK0EzqjFuMrLp8DEuWnXsx
pjMcb3XWfEB6gmMmpnRT1co/vbzYUf2x4CGBCIro1TdvtmL1+5+R3vFw9ha1/sSo
l/KczIyDFCESoHZyolw8rNvUlhxG0xl/RJbnKzaEFfDNOoKuk28TIlCuG2eL5VIN
GIG8JsTk1BKQs9Lf3nS0gkzvt28lIQTvIpelfwH7si4+EKoOlbM6t5LT3Ap0mQW5
5hy6kDPIT/7Q8wYkLZk8yJ/3z6PQMmzgiqpyY21ijdu1mG24h10TSvApvVT2GMPM
R+72q+M67wIztbh2d3duJYhcHEXLNq1U8BGGGh9CsbzxSlHwVYiiz8r9mOSPVG6n
vYqB8kuuGGwbe+DvKEhqPfvOCiZEtDqyEW59fskd6XoxfGgEiI/F1G4xT7SggUqt
+JWjIBPTFJVjbtR/qibKTtePcevNrp+UdBT3Un5r9Cihr0ztigPOSFXlgjz7U2Wf
jEujdfMfKtNRZlUDubeXyNuO7tmsqLQHsIbXWrRKInYIWBkEmsk4msjupo/xa06A
4DVAGGWiwY9ygZy++ZSAWKrn/vPzLssacb/Diiptgqbo74xG1eWSRIjOAsJpx+xv
WL0Jmau2ReJIIN9tBR8hO+x8/dQ986Hr3pGm09HjV+bGhMGOw7Q=
=jYQL
-----END PGP SIGNATURE-----

--WzQOajWiqVg22n3c--
