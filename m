Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239776F567A
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjECKpb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjECKpZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 06:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA9527B;
        Wed,  3 May 2023 03:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4525762C9F;
        Wed,  3 May 2023 10:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FABC433D2;
        Wed,  3 May 2023 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683110722;
        bh=jFhJJzglMovoWeUdVs32BFDrfQeh19yt3oCYgTntU+M=;
        h=Date:From:To:Cc:Subject:From;
        b=jZUJUBlK+itvnZkSaYHjSQiY7fg6vhjNtM/Wbx3Vn1V9kdT1+XSm6jDOg+22PPu4I
         XM5/pVBbYU8FagDUxUmJmY3BmeU90gqq9k7YO5uRuhxt2mkJtXh0n7BChw0tj5kqJ5
         9vVNEan2JYe9TO1U04dtmFJfUu6XzEdamagLdpbI3Cm5YCcRdpPmkkFLT3rMvFSVH1
         DcfpunBQtO3LOPtVqE2FjtSbBoLEMdinMsQUg0NUkzPa/zgC6RNZVe/YXyCrUl4FBk
         CDCbheTQ0qcW9FchPCp12o9T7ymVjvXXrV81wB3oakBGAjH/CRD4u6l3moMCgzb2M3
         6TwMwZ4Wbqi3Q==
Date:   Wed, 3 May 2023 16:15:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.4-rc1
Message-ID: <ZFI7PrQHKum6Wuxf@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vbNFPw5MNjo4YBpY"
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--vbNFPw5MNjo4YBpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the Pull request for dmaengine subsystem. Sorry I was busy with
Linaro connect and travels last week so sending this and others a  bit
later that I would prefer

We have couple of controller additions, big pile of idxd support and
driver updates as usual for this cycle.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.4-rc1

for you to fetch changes up to f2dc327131b5cbb2cbb467cec23836f2e9d4cf46:

  dmaengine: idxd: add per wq PRS disable (2023-04-12 23:18:46 +0530)

----------------------------------------------------------------
dmaengine updates for v6.4

 New support:
 - Apple admac t8112 device support
 - StarFive JH7110 DMA controller

 Updates:
 - Big pile of idxd updates to support IAA 2.0 device capabilities, DSA
   2.0 Event Log and completion record faulting features and new DSA
   operations
 - at_xdmac supend & resume updates and driver code cleanup
 - k3-udma supend & resume support
 - k3-psil thread support for J784s4

----------------------------------------------------------------
Apurva Nandan (1):
      dmaengine: ti: k3-psil: Add PSI-L thread support for J784s4

Biju Das (2):
      dmaengine: sh: rz-dmac: Add reset support
      dt-bindings: dma: rz-dmac: Document clock-names and reset-names

Bjorn Helgaas (3):
      dmaengine: ioat: use PCI core macros for PCIe Capability
      dmaengine: ioat: Drop redundant pci_enable_pcie_error_reporting()
      dmaengine: idxd: Remove unnecessary aer.h include

Christophe JAILLET (3):
      dmaengine: imx-dma: Remove a redundant memset() call
      dmaengine: mv_xor_v2: Fix an error code.
      dmaengine: mv_xor_v2: Use some clk_ helper functions to simplify code

Claudiu Beznea (7):
      dmaengine: at_xdmac: disable/enable clock directly on suspend/resume
      dmaengine: at_xdmac: fix imbalanced runtime PM reference counter
      dmaengine: at_xdmac: do not resume channels paused by consumers
      dmaengine: at_xdmac: restore the content of grws register
      dmaengine: at_xdmac: do not enable all cyclic channels
      dmaengine: at_xdmac: add a warning message regarding for unpaused cha=
nnels
      dmaengine: at_xdmac: align declaration of ret with the rest of variab=
les

Dave Jiang (17):
      dmaengine: idxd: reformat swerror output to standard Linux bitmap out=
put
      dmaengine: idxd: expose IAA CAP register via sysfs knob
      dmaengine: idxd: make misc interrupt one shot
      dmaengine: idxd: add event log size sysfs attribute
      dmaengine: idxd: setup event log configuration
      dmaengine: idxd: add interrupt handling for event log
      dmanegine: idxd: add debugfs for event log dump
      dmaengine: idxd: add per DSA wq workqueue for processing cr faults
      dmaengine: idxd: create kmem cache for event log fault items
      dmaengine: idxd: process user page faults for completion record
      dmaengine: idxd: add descs_completed field for completion record
      dmaengine: idxd: process batch descriptor completion record faults
      dmaengine: idxd: add per file user counters for completion record fau=
lts
      dmaengine: idxd: add a device to represent the file opened
      dmaengine: idxd: expose fault counters to sysfs
      dmaengine: idxd: add pid to exported sysfs attribute for opened file
      dmaengine: idxd: add per wq PRS disable

Dmitry Baryshkov (1):
      dma: gpi: remove spurious unlock in gpi_ch_init

Fenghua Yu (4):
      dmaengine: idxd: Add descriptor definitions for 16 bytes of pattern i=
n memory fill operation
      dmaengine: idxd: Add descriptor definitions for DIX generate operation
      dmaengine: idxd: Add descriptor definitions for translation fetch ope=
ration
      dmaengine: idxd: add idxd_copy_cr() to copy user completion record du=
ring page fault handling

Geert Uytterhoeven (1):
      dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size

Harini Katakam (1):
      dmaengine: zynqmp_dma: Sync DMA and coherent masks

Janne Grunau (1):
      dt-bindings: dma: apple,admac: Add t8112-admac compatible

Konrad Dybcio (1):
      dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI DMA

Mark Salter (1):
      dmaengine: tegra: explicitly select DMA_VIRTUAL_CHANNELS

Rob Herring (4):
      dmaengine: Use of_property_present() for testing DT property presence
      dmaengine: bestcomm: Use of_address_to_resource()
      dmaengine: qcom_hidma: Add explicit platform_device.h and of_device.h=
 includes
      dt-bindings: dma: Drop unneeded quotes

Shunsuke Mie (2):
      dmaengine: dw-edma: Fix to change for continuous transfer
      dmaengine: dw-edma: Fix to enable to issue dma request on DMA process=
ing

Tom Rix (3):
      dmaengine: tegra-apb: remove unused tdma_read function
      dmaengine: ti: edma: remove unused edma_and function
      dmaengine: dw-edma: remove unused readq_ch and writeq_ch functions

Vignesh Raghavendra (2):
      dmaengine: ti: k3-udma: Add system suspend/resume support
      dmaengine: ti: k3-udma: Workaround errata i2234

Walker Chen (3):
      dmaengine: dw-axi-dmac: Add support for StarFive JH7110 DMA
      dmaengine: dw-axi-dmac: Increase polling time to DMA transmission com=
pletion status
      dt-bindings: dma: snps,dw-axi-dmac: constrain the items of resets for=
 JH7110 dma

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |  51 +++
 .../devicetree/bindings/dma/apple,admac.yaml       |   1 +
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   1 +
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |  14 +
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  |  23 +-
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |   2 +-
 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   |   2 +-
 .../bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml     |   2 +-
 drivers/dma/Kconfig                                |   1 +
 drivers/dma/at_xdmac.c                             | 107 +++++--
 drivers/dma/bestcomm/sram.c                        |  19 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  40 ++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |   1 +
 drivers/dma/dw-edma/dw-edma-core.c                 |  27 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c              |  56 ----
 drivers/dma/idxd/Makefile                          |   2 +-
 drivers/dma/idxd/cdev.c                            | 334 +++++++++++++++++=
--
 drivers/dma/idxd/debugfs.c                         | 138 ++++++++
 drivers/dma/idxd/device.c                          | 113 ++++++-
 drivers/dma/idxd/idxd.h                            |  67 ++++
 drivers/dma/idxd/init.c                            |  60 +++-
 drivers/dma/idxd/irq.c                             | 210 ++++++++++--
 drivers/dma/idxd/registers.h                       | 126 +++++++-
 drivers/dma/idxd/sysfs.c                           | 146 ++++++++-
 drivers/dma/imx-dma.c                              |   1 -
 drivers/dma/ioat/init.c                            |  12 +-
 drivers/dma/ioat/registers.h                       |   7 -
 drivers/dma/mv_xor_v2.c                            |  35 +-
 drivers/dma/of-dma.c                               |   2 +-
 drivers/dma/qcom/gpi.c                             |   1 -
 drivers/dma/qcom/hidma_mgmt.c                      |   2 +
 drivers/dma/sh/rz-dmac.c                           |  18 +-
 drivers/dma/tegra20-apb-dma.c                      |   5 -
 drivers/dma/ti/Makefile                            |   3 +-
 drivers/dma/ti/edma.c                              |   8 -
 drivers/dma/ti/k3-psil-j784s4.c                    | 354 +++++++++++++++++=
++++
 drivers/dma/ti/k3-psil-priv.h                      |   1 +
 drivers/dma/ti/k3-psil.c                           |   1 +
 drivers/dma/ti/k3-udma.c                           |  75 ++++-
 drivers/dma/xilinx/zynqmp_dma.c                    |   6 +-
 include/linux/dma/ti-cppi5.h                       |   1 +
 include/uapi/linux/idxd.h                          |  48 ++-
 42 files changed, 1863 insertions(+), 260 deletions(-)
 create mode 100644 drivers/dma/idxd/debugfs.c
 create mode 100644 drivers/dma/ti/k3-psil-j784s4.c

--=20
~Vinod

--vbNFPw5MNjo4YBpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmRSOz4ACgkQfBQHDyUj
g0dI5BAArCTgR/HDyVtV41nuYlKP8IEx5FgoKUE8Y/M1PCeL3fTn+gSkCTe3OAbA
sqJWUGBnd3MvxqSE0VCf9Yj612Y7YtQi3cxxC9F5BfJX3NBdKLJAYUyYUJfgvyNl
FhubNp1AUbzWZ7czf0zoEp2skt49CYQuYHixkF2uTysAgiDV89P9Jpz7QEYO6Vsh
ClUiLbx95JdPhxxenoJ4F++E20KspipLGz737Exf2NROMLNc5P6b+ZAW7Btbb6eR
a8sjZ+20pjN/LkjwSX68PB8iMz2PD1z7FfnhgfJrds2I/a47mISdzl6Vi9yQjIpV
59q7z5SJHBKsdbC0+c6fLJYz0/oCqOrnlIoFtkJ9PeRqcyysGbvcCvK85M2JF/qR
2cgyD6sTYbxhv0hDT0jtLvDuKyS2ekAJXIM7cVQsHKKHm8jSYGZ+NWdNA5ZCx6+R
WZ8VNYcmlkPUz0U0u7bA71QoSwihGCMi8TtYRWnESk+yUWzz95qYs7xQQkIfduhe
je5twu3EDWfaVLGMwvN4GYQYDznIzZsmAwEvZUERqdvoFG89CvIAeQKUvjZIDQv0
WJNBvKWUkKex7iefHb8cwGJP1hN0eFTYOl1S6y4ETK7fKTuj2qCfx5hrM8vYLoxd
BWQbfn0HYWjzuzUnhfsddPcQimZfLZpmhJ2KQItTuaf8/fEWt2U=
=CtCu
-----END PGP SIGNATURE-----

--vbNFPw5MNjo4YBpY--
