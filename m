Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA05F7818
	for <lists+dmaengine@lfdr.de>; Fri,  7 Oct 2022 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJGMlN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Oct 2022 08:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJGMlI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Oct 2022 08:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E53DED1C;
        Fri,  7 Oct 2022 05:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4014E61CD5;
        Fri,  7 Oct 2022 12:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18725C433D6;
        Fri,  7 Oct 2022 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665146460;
        bh=k3p4RHAw+QEwWScHrKYPvoyEhjLHmOZX8Y1a0KB/8QI=;
        h=Date:From:To:Cc:Subject:From;
        b=frxn9l6htA+lZY3KAZ0sobWHjhr4tl3aodtOyUP3fc58WJqXX4XErG1KB+AvZ+/5X
         SYQNCcQrV3MA6Kzr+Id8ImeC0pyCjdENlqx4egGWvheEWO/OYbTttdTzmth3DMjPzU
         0tHhOc5290vJEpN0c6CrOYpgGOMEcJk1qH5RGJUlZlWz6piCE8wzJMn/9ykoXDk7ie
         g908tMeDARLvempxyKIOWgmEQ9CoOQlKYje+B+sWq4viTriwFhEgj+EjFITe8OBh2j
         bgOsyc0/e0k0I6YEg4OS5Ux5iFwel0WdoLHUSXp/jzMqQ3v6sG35fjSbCCVlzFGSMv
         uxxylEN+A2nIg==
Date:   Fri, 7 Oct 2022 18:10:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.1-rc1
Message-ID: <Y0AeWM7UabE2ZK34@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YwH7OzFFF1YwJZMw"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--YwH7OzFFF1YwJZMw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine updates for v6.1-rc1. Bunch of new
device/driver support and updates to drivers this time around.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.1-rc1

for you to fetch changes up to b957df98469240d459bcfae6904b36d6ecea9bee:

  dmaengine: ioat: remove unused declarations in dma.h (2022-09-29 22:46:09=
 +0530)

----------------------------------------------------------------
dmaengine updates for v6.1-rc1

New Support:
 - AngeloGioacchino Del Regno added support for MT6795 SoC dma controller
 - Christian Marangi updated qcom-adm controller binding to yaml
 - Geert Uytterhoeven added yaml binding for Renesas r8a779g0 dma controller
 - Luca Weiss added support for Qualcomm SM6350 GPI dma controller

Updates:
 - Amelie Delaunay provided STM32 DMA-MDMA chaining support
 - Andy Shevchenko updated hsu driver to use managed resources
 - Dave Jiang & Jerry Snitselaar provided usual round of idxd driver updates
 - Janne Grunau & Martin Povi=C5=A1er updated apple dma driver for iommu an=
d pd
   properties and removed use of devres for irqs
 - Swati Agarwal added device_synchronize support for Xilinx zynqmp driver

----------------------------------------------------------------
Amelie Delaunay (6):
      dmaengine: stm32-dma: introduce 3 helpers to address channel flags
      dmaengine: stm32-dma: use bitfield helpers
      docs: arm: stm32: introduce STM32 DMA-MDMA chaining feature
      dmaengine: stm32-dmamux: set dmamux channel id in dma features bitfie=
ld
      dmaengine: stm32-dma: add support to trigger STM32 MDMA
      dmaengine: stm32-mdma: add support to be triggered by STM32 DMA

Andy Shevchenko (4):
      dmaengine: hsu: Finish conversion to managed resources
      dmaengine: hsu: using for_each_set_bit to simplify the code
      dmaengine: hsu: Use GENMASK() consistently
      dmaengine: hsu: Include headers we are direct user of

AngeloGioacchino Del Regno (1):
      dt-bindings: dma: mediatek,uart-dma: Add binding for MT6795 SoC

Bhupesh Sharma (1):
      dt-bindings: dma: Make minor fixes to qcom,bam-dma binding doc

Christian Marangi (4):
      dmaengine: qcom-adm: fix wrong sizeof config in slave_config
      dmaengine: qcom-adm: fix wrong calling convention for prep_slave_sg
      dt-bindings: dma: rework qcom,adm Documentation to yaml schema
      dt-bindings: dma: add additional pbus reset to qcom,adm

Christophe JAILLET (1):
      dmaengine: stm32-dmamux: Simplify code and save a few bytes of memory

Dario Binacchi (1):
      dmaengine: mxs: use platform_driver_register

Dave Jiang (6):
      dmaengine: ioat: stop mod_timer from resurrecting deleted timer in __=
cleanup()
      dmaengine: idxd: convert ats_dis to a wq flag
      dmanegine: idxd: reformat opcap output to match bitmap_parse() input
      dmaengine: idxd: add WQ operation cap restriction support
      dmaengine: idxd: add configuration for concurrent work descriptor pro=
cessing
      dmaengine: idxd: add configuration for concurrent batch descriptor pr=
ocessing

Deming Wang (1):
      Documentation: devicetree: dma: update the comments

Gaosheng Cui (1):
      dmaengine: ioat: remove unused declarations in dma.h

Geert Uytterhoeven (1):
      dt-bindings: renesas,rcar-dmac: Add r8a779g0 support

Gustavo A. R. Silva (1):
      dmaengine: sh: rcar-dmac: Replace zero-length arrays with DECLARE_FLE=
X_ARRAY() helper

Harini Katakam (1):
      dmaengine: pl330: Remove unused flags

Janne Grunau (1):
      dt-bindings: dma: apple,admac: Add iommus and power-domains properties

Jason Wang (1):
      dmaengine: stm32-dmamux: Fix comment typo

Jean Delvare (1):
      dmaengine: dw-axi-dmac: Drop obsolete dependency on COMPILE_TEST

Jerry Snitselaar (3):
      dmaengine: idxd: avoid deadlock in process_misc_interrupts()
      dmaengine: idxd: Set wq state to disabled in idxd_wq_disable_cleanup()
      dmaengine: idxd: track enabled workqueues in bitmap

Jiapeng Chong (1):
      dmaengine: ti: edma: Remove some unused functions

Jie Hai (7):
      dmaengine: hisilicon: Disable channels when unregister hisi_dma
      dmaengine: hisilicon: Fix CQ head update
      dmaengine: hisilicon: Add multi-thread support for a DMA channel
      dmaengine: hisilicon: Use macros instead of magic number
      dmaengine: hisilicon: Adapt DMA driver to HiSilicon IP09
      dmaengine: hisilicon: Dump regs to debugfs
      MAINTAINERS: Add myself as maintainer for hisi_dma

Luca Weiss (2):
      dt-bindings: dmaengine: qcom: gpi: add compatible for SM6350
      dmaengine: qcom: gpi: Add SM6350 support

Manivannan Sadhasivam (1):
      dmaengine: dw-edma: Remove runtime PM support

Martin Povi=C5=A1er (2):
      dmaengine: apple-admac: Do not use devres for IRQs
      dmaengine: apple-admac: Trigger shared reset

Matt Ranostay (2):
      dmaengine: ti: k3-psil: add additional TX threads for j7200
      dmaengine: ti: k3-psil: add additional TX threads for j721e

Rob Herring (1):
      dt-bindings: dma: arm,pl330: Add missing 'iommus' property

Shaomin Deng (2):
      dmaengine: virt-dma: Fix double word in comments
      dmaengine: pl08x: Fix double word

Swati Agarwal (1):
      dmaengine: zynqmp_dma: Add device_synchronize support

Tudor Ambarus (1):
      dmaengine: at_xdmac: Replace two if statements with only one with two=
 conditions

Tuo Cao (1):
      dmaengine: qcom: gpi: move read_lock_bh to read_lock in tasklet

Vaishnav Achath (2):
      dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to prevent o=
verflow
      dmaengine: ti: k3-udma: Respond TX done if DMA_PREP_INTERRUPT is not =
requested

Yuan Can (1):
      dmaengine: idxd: Remove unused struct idxd_fault

ye xingchen (1):
      dmaengine: sf-pdma:Remove the print function dev_err()

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |  35 ++
 Documentation/arm/index.rst                        |   1 +
 .../arm/stm32/stm32-dma-mdma-chaining.rst          | 415 +++++++++++++
 .../devicetree/bindings/dma/apple,admac.yaml       |   7 +
 .../devicetree/bindings/dma/arm,pl330.yaml         |   6 +
 .../devicetree/bindings/dma/mediatek,uart-dma.yaml |   1 +
 .../devicetree/bindings/dma/qcom,adm.yaml          |  99 ++++
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |   8 +-
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   1 +
 Documentation/devicetree/bindings/dma/qcom_adm.txt |  61 --
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   1 +
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |   2 +-
 MAINTAINERS                                        |   1 +
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/amba-pl08x.c                           |   2 +-
 drivers/dma/apple-admac.c                          |  45 +-
 drivers/dma/at_xdmac.c                             |   5 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  12 -
 drivers/dma/hisi_dma.c                             | 650 +++++++++++++++++=
+---
 drivers/dma/hsu/hsu.c                              |   8 +
 drivers/dma/hsu/hsu.h                              |  12 +-
 drivers/dma/hsu/pci.c                              |  47 +-
 drivers/dma/idxd/device.c                          |  38 +-
 drivers/dma/idxd/idxd.h                            |  10 +-
 drivers/dma/idxd/init.c                            |  36 ++
 drivers/dma/idxd/irq.c                             |  13 +-
 drivers/dma/idxd/registers.h                       |  35 +-
 drivers/dma/idxd/sysfs.c                           | 187 +++++-
 drivers/dma/ioat/dma.c                             |   6 +-
 drivers/dma/ioat/dma.h                             |   2 -
 drivers/dma/mxs-dma.c                              |  11 +-
 drivers/dma/pl330.c                                |   4 -
 drivers/dma/qcom/gpi.c                             |   7 +-
 drivers/dma/qcom/qcom_adm.c                        |  22 +-
 drivers/dma/s3c24xx-dma.c                          |   2 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |   8 +-
 drivers/dma/sh/rcar-dmac.c                         |   4 +-
 drivers/dma/stm32-dma.c                            | 136 +++--
 drivers/dma/stm32-dmamux.c                         |  12 +-
 drivers/dma/stm32-mdma.c                           |  70 ++-
 drivers/dma/ti/edma.c                              |  40 --
 drivers/dma/ti/k3-psil-j7200.c                     |  67 +++
 drivers/dma/ti/k3-psil-j721e.c                     |  79 +++
 drivers/dma/ti/k3-udma.c                           |  37 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |  12 +
 include/linux/dma/hsu.h                            |   6 +-
 include/linux/platform_data/dma-hsu.h              |   2 +-
 47 files changed, 1854 insertions(+), 413 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt

--=20
~Vinod

--YwH7OzFFF1YwJZMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmNAHlgACgkQfBQHDyUj
g0cRLg//RDmZ4PcCxFoaBcFRhkLl5otjpgR5WMN9WgMDIt+8rZOS1X2wkpZICEle
c1O9fxgJyDLkrOf4CBWuCoKZGO2iSV7+YvNKNHk6jkYsPzFEZB+HUrhIXrtYXAOQ
V3qqKP+rwCrvbfmksSa01hq40GQZFrJioZ7YGhm376G8+2TdZvBuBUNuTcu192NM
0DVMfziY77lXgUUGqMrNlMq4C+wqry/iLidpZ+M/wH5ebR+lbZRAG5iqvfc9mDkL
KU2WJLRWYYYC5kJ5lZ8gOPYiAhd32JcNb432FWcS01nMlHeqvuj5zWmqV8/1mJVd
76rOyWLAv9e7hNr7dSMrF7ATN4c/D50zafJLaJV1bi38wBNpeVaFajRDZYUbiEUP
kTD73K65/IUqsAirbLxE5Hv5liDyS7HkS/nNabow6/bl1ksiVlGQToN8+sD9G4Qx
0vTN2vVLcsQxvtQKvo5D8uCEWfuB4L3JQGy7lGG3Z/p6uxn6c9TY7sNmMJzBZu1c
OMPPuU9B5/QNxBmrOaCVrTe8hY9nwVqQyhamOEiLxEeepX+Y3wabj9cUayErXyuz
dKdla4AGV7kw9hS+X4ryHsH+0Szqt6j7SY8bmUEgoy20KApjYTO5sr0FdOOdEKzj
YNcEesbarOCXIV42SEyXmHEiKVhLVedm5TB0eaDI5OC4Ho/pUso=
=vED+
-----END PGP SIGNATURE-----

--YwH7OzFFF1YwJZMw--
