Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD493224E0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 05:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBWEQH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Feb 2021 23:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhBWEQG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Feb 2021 23:16:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3DE764E4B;
        Tue, 23 Feb 2021 04:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614053724;
        bh=69lPtH3Y3DLke0tOh7/oO2AGLDk/oyLjQPazIvD+MPM=;
        h=Date:From:To:Cc:Subject:From;
        b=qeZsi3HRtH5S62PmOS4ACxw/wNLxtHQluuqjVo3M/A+gAC1uLkl8C4gAKmyJ/giTq
         puisHj3gn+yMYzHGH5BLEfOAtk/HaBmPVAX5dPkb4X1IUFv2E2t4yXfeRbHpp2lsTB
         NXhf2ua94CDM0Ts5tvu5dukQhKe0s/5oVJdwZzMfNO0N2ZP0xS516bMeq7xMAha2Bt
         b+9NUhyDgotBlhGuF+6vXgOq4rTE9HzkvKBVDsr5QbSCBVyh+D+la22Tf9YjJwKUk0
         OwcSVd45Q+GVP+aVd0pwnCJlKP911SQQwjWjWbWqq7w/n05mC5WVA35ZBCqZOra1sJ
         ijpKvSW8iWNWA==
Date:   Tue, 23 Feb 2021 09:45:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL REQUEST]: dmaengine updates for 5.12-rc1
Message-ID: <20210223041520.GA2774@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please consider merging to get dmaengine updates for this cycle. We have
couple of drivers removed a new driver and bunch of new device support
and few updates to drivers for this round.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.12-rc1

for you to fetch changes up to eda38ce482b2c88b27e3a7c8aa1ddffa646f3e7f:

  dmaengine: dw-axi-dmac: remove redundant null check on desc (2021-02-08 1=
7:39:39 +0530)

----------------------------------------------------------------
dmaengine updates for v5.12-rc1

New drivers/devices
 - Intel LGM SoC DMA driver
 - Actions Semi S500 DMA controller
 - Renesas r8a779a0 dma controller
 - Ingenic JZ4760(B) dma controller
 - Intel KeemBay AxiDMA controller

Removed
 - Coh901318 dma driver
 - Zte zx dma driver
 - Sirfsoc dma driver

Updates:
 - mmp_pdma, mmp_tdma gained module support
 - imx-sdma become modern and dropped platform data support
 - dw-axi driver gained slave and cyclic dma support

----------------------------------------------------------------
Alexandre Belloni (1):
      dmaengine: at_hdmac: remove platform data header

Amireddy Mallikarjuna reddy (2):
      dt-bindings: dma: Add bindings for Intel LGM SoC
      dmaengine: Add Intel LGM SoC DMA support.

Arnd Bergmann (3):
      dmaengine: remove sirfsoc driver
      dmaengine: remove zte zx driver
      dmaengine: remove coh901318 driver

Bjorn Andersson (1):
      dt-bindings: dma: intel-ldma: Fix $ref specifier

Bjorn Helgaas (1):
      dmaengine: stedma40: fix 'physical' typo

Christophe JAILLET (3):
      dmaengine: fsldma: Fix a resource leak in the remove function
      dmaengine: fsldma: Fix a resource leak in an error handling path of t=
he probe function
      dmaengine: owl-dma: Fix a resource leak in the remove function

Colin Ian King (1):
      dmaengine: dw-axi-dmac: remove redundant null check on desc

Cristian Ciocaltea (2):
      dt-bindings: dma: owl: Add compatible string for Actions Semi S500 SoC
      dmaengine: owl: Add compatible for the Actions Semi S500 DMA controll=
er

Dave Jiang (2):
      dmaengine: idxd: set DMA channel to be private
      dmaengine: idxd: add module parameter to force disable of SVA

Fabio Estevam (2):
      dmaengine: imx-sdma: Remove platform data support
      dmaengine: imx-sdma: Use of_device_get_match_data()

Ferry Toth (1):
      dmaengine: hsu: disable spurious interrupt

Geert Uytterhoeven (5):
      dt-bindings: renesas,rcar-dmac: Add r8a779a0 support
      dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan() helper
      dmaengine: rcar-dmac: Add helpers for clearing DMA channel status
      dmaengine: rcar-dmac: Add support for R-Car V3U
      dmaengine: INTEL_LDMA should depend on X86

Grygorii Strashko (1):
      dmaengine: ti: k3-psil: optimize struct psil_endpoint_config for size

Lubomir Rintel (3):
      dmaengine: mmp_pdma: Remove mmp_pdma_filter_fn()
      dmaengine: mmp_pdma: Allow building as a module
      dmaengine: mmp_tdma: Allow building as a module

Nathan Chancellor (1):
      dmaengine: qcom: Always inline gpi_update_reg

Paul Cercueil (2):
      dt-bindings: dma: ingenic: Add compatible strings for JZ4760(B) SoCs
      dmaengine: jz4780: Add support for the JZ4760(B)

Peter Ujfalusi (3):
      dmaengine: Extend the dmaengine_alignment for 128 and 256 bytes
      dmaengine: ti: k3-udma: Add support for burst_size configuration for =
mem2mem
      dmaengine: ti: k3-udma: Do not initialize ret in tisci channel config=
 functions

Richard Fitzgerald (1):
      dmaengine: xilinx_dma: Alloc tx descriptors GFP_NOWAIT

Sia Jee Heng (17):
      dt-bindings: dma: Add YAML schemas for dw-axi-dmac
      dmaengine: dw-axi-dmac: simplify descriptor management
      dmaengine: dw-axi-dmac: move dma_pool_create() to alloc_chan_resource=
s()
      dmaengine: dw-axi-dmac: Add device_synchronize() callback
      dmaengine: dw-axi-dmac: Add device_config operation
      dmaengine: dw-axi-dmac: Support device_prep_slave_sg
      dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
      dmaengine: dw-axi-dmac: Support of_dma_controller_register()
      dmaengine: dw-axi-dmac: Support burst residue granularity
      dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
      dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
      dmaengine: drivers: Kconfig: add HAS_IOMEM dependency to DW_AXI_DMAC
      dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
      dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
      dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD re=
gisters
      dmaengine: dw-axi-dmac: Set constraint to the Max segment size
      dmaengine: dw-axi-dmac: Virtually split the linked-list

Thara Gopinath (1):
      dmaengine: qcom: bam_dma: Manage clocks when controlled_remotely is s=
et

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma: Set rflow count for BCDMA split channels

Vinod Koul (2):
      MAINTAINERS: dmaengine: add header files directory
      MAINTAINERS: ioat: remove dmaengine susbstem files

Xu Wang (1):
      dmaengine: qcom: gpi: Remove unneeded semicolon

Zheng Yongjun (1):
      dma: idxd: use DEFINE_MUTEX() for mutex lock

 Documentation/admin-guide/kernel-parameters.txt    |    6 +
 .../devicetree/bindings/dma/ingenic,dma.yaml       |    2 +
 .../devicetree/bindings/dma/intel,ldma.yaml        |  116 +
 Documentation/devicetree/bindings/dma/owl-dma.yaml |    7 +-
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   76 +-
 .../devicetree/bindings/dma/sirfsoc-dma.txt        |   44 -
 .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   |   39 -
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  |  126 +
 .../devicetree/bindings/dma/ste-coh901318.txt      |   32 -
 Documentation/devicetree/bindings/dma/zxdma.txt    |   38 -
 MAINTAINERS                                        |    4 +-
 drivers/dma/Kconfig                                |   30 +-
 drivers/dma/Makefile                               |    4 +-
 drivers/dma/at_hdmac.c                             |   19 +
 drivers/dma/at_hdmac_regs.h                        |   28 +-
 drivers/dma/coh901318.c                            | 2808 ----------------=
----
 drivers/dma/coh901318.h                            |  141 -
 drivers/dma/coh901318_lli.c                        |  313 ---
 drivers/dma/dma-jz4780.c                           |   14 +
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  698 ++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |   34 +-
 drivers/dma/fsldma.c                               |    6 +
 drivers/dma/hsu/pci.c                              |   21 +-
 drivers/dma/idxd/dma.c                             |    1 +
 drivers/dma/idxd/init.c                            |   11 +-
 drivers/dma/imx-sdma.c                             |   46 +-
 drivers/dma/lgm/Kconfig                            |   10 +
 drivers/dma/lgm/Makefile                           |    2 +
 drivers/dma/lgm/lgm-dma.c                          | 1739 ++++++++++++
 drivers/dma/mmp_pdma.c                             |   14 -
 drivers/dma/owl-dma.c                              |    4 +-
 drivers/dma/qcom/bam_dma.c                         |   29 +-
 drivers/dma/qcom/gpi.c                             |    4 +-
 drivers/dma/sh/rcar-dmac.c                         |  112 +-
 drivers/dma/sirf-dma.c                             | 1170 --------
 drivers/dma/ste_dma40.c                            |    2 +-
 drivers/dma/ti/k3-udma.c                           |  131 +-
 drivers/dma/xilinx/xilinx_dma.c                    |    2 +-
 drivers/dma/zx_dma.c                               |  941 -------
 include/linux/dma/k3-psil.h                        |   13 +-
 include/linux/dma/mmp-pdma.h                       |   16 -
 include/linux/dmaengine.h                          |    2 +
 include/linux/platform_data/dma-atmel.h            |   61 -
 include/linux/platform_data/dma-coh901318.h        |   72 -
 include/linux/platform_data/dma-imx-sdma.h         |   11 -
 include/linux/sirfsoc_dma.h                        |    7 -
 46 files changed, 3018 insertions(+), 5988 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.=
txt
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/ste-coh901318.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/zxdma.txt
 delete mode 100644 drivers/dma/coh901318.c
 delete mode 100644 drivers/dma/coh901318.h
 delete mode 100644 drivers/dma/coh901318_lli.c
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c
 delete mode 100644 drivers/dma/sirf-dma.c
 delete mode 100644 drivers/dma/zx_dma.c
 delete mode 100644 include/linux/dma/mmp-pdma.h
 delete mode 100644 include/linux/platform_data/dma-atmel.h
 delete mode 100644 include/linux/platform_data/dma-coh901318.h
 delete mode 100644 include/linux/sirfsoc_dma.h

--=20
~Vinod

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmA0gVgACgkQfBQHDyUj
g0dAiw//RPLet/jXNpPznQWGWIahEqFu2xTgzh/gBGFRsjfER8huyCc/NqLy2oS8
9yzJNxbRrFM+o0UmmzluaHpvaTogQikxJlrK/8padyB0b5LHNyHysNvtNT6vdQnk
JfyzbQQmk8rzM2k0wJkNt3IypTyP2u5Ub6m+Vz3CVbIZGqBrkAC+LL2+tseehkt+
4iuswQrlbkL48EStqdU7aQoTPPJ1RNLBxouYmBbGsqEBSGPSkwS7lI6nn0AUhPL9
dCtEkXk+EOlNz5bKLFCeJpBKID5MTPGD70r359IUKf7FEmxGAldpY+QwbkxTo8Rd
66ZXUErGOYdRpnIGchezqyYZD7RXPNLB+hztxp2yYGBVbjTgQFq9+vqcHOSlXA2F
yQqIrwfsI4EZLYD2NUxMDKilnjbBt3jhmT/+hiGRJmUSyJNXLn6bcwAUgcA2DelP
4E6GwZEkyjUJmZ8hTGpjHhrpN6xW1acKz533UO+p6p25M8UKH+nqR+8eX3Nqh/E2
y2Bg0/mo/gstm6Riobj5eJLsXfwXwYq+6zB6bcbEwpsXGM+1aKLShwEKApXLBRL/
HbQPeQM+/ENkEkDT2V7T5dcx/QV/t6LeoMXhOBH7K6fFZeSe99QYm9pyVUlfC0+v
j0jtOqsF0fuoKuoDcl6vyT8N201xubCEkpFV8f6cGe3MpkrTVuU=
=WwEw
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
