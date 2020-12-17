Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5B2DD60A
	for <lists+dmaengine@lfdr.de>; Thu, 17 Dec 2020 18:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLQRZQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Dec 2020 12:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgLQRZP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Dec 2020 12:25:15 -0500
Date:   Thu, 17 Dec 2020 22:54:27 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608225873;
        bh=2zF9VCHpGsLu120EcDkzYaah8zbeXQl9mQQzsl0eNS4=;
        h=From:To:Cc:Subject:From;
        b=FRZJBOAJ9ZFBk4Ee0PDILsoqVr1KtdFwpbdOMGtBsUKXTs2C0qAwzpf+xEd4AygWA
         89Kp0j+QTVqeqY4FrNlCYd/iIxU/pWZYt35MjEPC89QcU85/P8MW96G0rsALftsgoX
         46exkVrIM55819556OLAuXeYcR33t1TApPT0zlHU5/t4BGr2cFLtRzS1n0U8lnwzzQ
         0gtY61c0g9/LSZ2nJ1pxGjvnsFgWQHEdINe3SOQC7jH0HofPS6gtNUYLf0+VCoFmJc
         rapCslw2irITJfusD4bWGsmx6hGy6u7F8uiowl9TmPpgws0Kh+xGQep4j3gb/rHo28
         o6iIEAaRAwlxg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine update for v5.11-rc1
Message-ID: <20201217172427.GG8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive last dmaengine updates for this year :) This
contains couple of new drivers, new device support and updates to bunch
of drivers.

SFR reminded me to tell you that there will be a merge conflict which I
am pretty sure would be easy for you. Nevertheless correct resolution is
already in linux-next by SFR.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.11-rc1

for you to fetch changes up to 115ff12aecfd55376d704fa2c0a2d117e5827f9f:

  soc: ti: k3-ringacc: Use correct error casting in k3_ringacc_dmarings_ini=
t (2020-12-14 12:33:09 +0530)

----------------------------------------------------------------
dmaengine updates for v5.11-rc1

New drivers/devices
  - Qualcomm ADM driver
  - Qualcomm GPI driver
  - Allwinner A100 DMA support
  - Microchip Sama7g5 support
  - Mediatek MT8516 apdma

- Updates:
  - more updates to idxd driver and support for IAX config
  - runtime PM support for dw driver

- TI keystone drivers for 5.11 included here due to dependency for TI
  drivers

----------------------------------------------------------------
Amelie Delaunay (4):
      dmaengine: stm32-dma: rework irq handler to manage error before xfer =
events
      dmaengine: stm32-dma: clean channel configuration when channel is fre=
ed
      dmaengine: stm32-dma: take address into account when computing max wi=
dth
      dmaengine: stm32-mdma: rework interrupt handler

Andy Shevchenko (2):
      dmaengine: dw: Enable runtime PM
      dmaengine: idma64: Switch to use __maybe_unused instead of ifdeffery

Barry Song (10):
      dmaengine: ipu_idmac: remove redundant irqsave and restore in hardIRQ
      dmaengine: ti: k3-udma: remove redundant irqsave and irqrestore in ha=
rdIRQ
      dmaengine: sf-pdma: remove redundant irqsave and irqrestore in hardIRQ
      dmaengine: tegra210-adma: remove redundant irqsave and irqrestore in =
hardIRQ
      dmaengine: milbeaut-xdmac: remove redundant irqsave and irqrestore in=
 hardIRQ
      dmaengine: k3dma: remove redundant irqsave and irqrestore in hardIRQ
      dmaengine: hisi_dma: remove redundant irqsave and irqrestore in hardI=
RQ
      dmaengine: moxart-dma: remove redundant irqsave and irqrestore in har=
dIRQ
      dmaengine: ste_dma40: remove redundant irqsave and irqrestore in hard=
IRQ
      dmaengine: pxa_dma: remove redundant irqsave and irqrestore in hardIRQ

Dave Jiang (8):
      dmaengine: idxd: fix wq config registers offset programming
      dmaengine: idxd: Add shared workqueue support
      dmaengine: idxd: Clean up descriptors with fault error
      dmaengine: idxd: Add ABI documentation for shared wq
      dmaengine: idxd: Update calculation of group offset to be more readab=
le
      dmaengine: idxd: define table offset multiplier
      dmaengine: idxd: add ATS disable knob for work queues
      dmaengine: idxd: add IAX configuration support in the IDXD driver

Eugen Hristev (4):
      dt-bindings: dmaengine: at_xdmac: add compatible with microchip,sama7=
g5
      dmaengine: at_xdmac: adapt perid for mem2mem operations
      dmaengine: at_xdmac: add support for sama7g5 based at_xdmac
      dmaengine: at_xdmac: add AXI priority support and recommended settings

Fabien Parent (1):
      dt-bindings: dma: mtk-apdma: add bindings for MT8516 SOC

Fabio Estevam (3):
      dmaengine: imx-sdma: Remove unused .id_table support
      dmaengine: imx-dma: Remove unused .id_table
      dmaengine: mxs-dma: Remove the unused .id_table

Grygorii Strashko (2):
      dmaengine: ti: k3-udma-glue: move psi-l pairing in channel en/dis fun=
ctions
      soc: ti: k3-ringacc: add AM64 DMA rings support.

Grzegorz Jaszczyk (1):
      soc: ti: pruss: Remove wrong check against *get_match_data return val=
ue

Gustavo A. R. Silva (1):
      dmaengine: stm32-mdma: Use struct_size() in kzalloc()

Jonathan McDowell (2):
      dmaengine: qcom: Add ADM driver
      dmaengine: qcom: Fix ADM driver kerneldoc markup

Krzysztof Kozlowski (8):
      dmaengine: ppc4xx: make ppc440spe_adma_chan_list static
      dmaengine: ppc4xx: remove xor_hw_desc assignment without reading
      dmaengine: jz4780: drop of_match_ptr from of_device_id table
      dmaengine: dw-axi-dmac: drop of_match_ptr from of_device_id table
      dmaengine: mv_xor: drop of_match_ptr from of_device_id table
      dmaengine: sf: drop of_match_ptr from of_device_id table
      dmaengine: stm32: mark of_device_id table as maybe unused
      dmaengine: ti: drop of_match_ptr and mark of_device_id table as maybe=
 unused

Lee Jones (6):
      soc: ti: knav_qmss_queue: Remove set but unchecked variable 'ret'
      soc: ti: knav_qmss_queue: Fix a whole host of function documentation =
issues
      soc: ti: knav_dma: Fix a kernel function doc formatting issue
      soc: ti: pm33xx: Remove set but unused variable 'ret'
      soc: ti: wkup_m3_ipc: Document 'm3_ipc' parameter throughout
      soc: ti: k3-ringacc: Provide documentation for 'k3_ring's 'state'

Nishanth Menon (1):
      soc: ti: Kconfig: Drop ARM64 SoC specific configs

Parth Y Shah (1):
      dmaengine: bam_dma: fix return of bam_dma_irq()

Peter Ujfalusi (30):
      firmware: ti_sci: rm: Add support for tx_tdtype parameter for tx chan=
nel
      firmware: ti_sci: Use struct ti_sci_resource_desc in get_range ops
      firmware: ti_sci: rm: Add support for second resource range
      soc: ti: ti_sci_inta_msi: Add support for second range in resource ra=
nges
      firmware: ti_sci: rm: Add support for extended_ch_type for tx channel
      firmware: ti_sci: rm: Remove ring_get_config support
      firmware: ti_sci: rm: Add new ops for ring configuration
      soc: ti: k3-ringacc: Use the ti_sci set_cfg callback for ring configu=
ration
      firmware: ti_sci: rm: Remove unused config() from ti_sci_rm_ringacc_o=
ps
      soc: ti: k3-ringacc: Use correct device for allocation in RING mode
      soc: ti: k3-socinfo: Add entry for AM64X SoC family
      dmaengine: ti: k3-udma: Correct normal channel offset when uchan_cnt =
is not 0
      dmaengine: ti: k3-udma: Wait for peer teardown completion if supported
      dmaengine: ti: k3-udma: Add support for second resource range from sy=
sfw
      dmaengine: ti: k3-udma-glue: Add function to get device pointer for D=
MA API
      dmaengine: ti: k3-udma-glue: Get the ringacc from udma_dev
      dmaengine: ti: k3-udma-glue: Configure the dma_dev for rings
      dmaengine: of-dma: Add support for optional router configuration call=
back
      dmaengine: Add support for per channel coherency handling
      dmaengine: doc: client: Update for dmaengine_get_dma_device() usage
      dmaengine: dmatest: Use dmaengine_get_dma_device
      dt-bindings: dma: ti: Add document for K3 BCDMA
      dt-bindings: dma: ti: Add document for K3 PKTDMA
      dmaengine: ti: k3-psil: Extend psil_endpoint_config for K3 PKTDMA
      dmaengine: ti: k3-psil: Add initial map for AM64
      dmaengine: ti: Add support for k3 event routers
      dmaengine: ti: k3-udma: Initial support for K3 BCDMA
      dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling
      dmaengine: ti: k3-udma: Initial support for K3 PKTDMA
      soc: ti: k3-ringacc: Use correct error casting in k3_ringacc_dmarings=
_init

Surendran K (1):
      dmaengine: pl330: Remove unreachable code

Tony Lindgren (1):
      soc: ti: omap-prm: Do not check rstst bit on deassert if already deas=
serted

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA

Vinod Koul (4):
      dt-bindings: dmaengine: Document qcom,gpi dma binding
      dmaengine: add peripheral configuration
      dmaengine: qcom: Add GPI dma driver
      Merge tag 'tags/drivers_soc_for_5.11' into dmaengine/next

Yangtao Li (2):
      dt-bindings: dma: allwinner,sun50i-a64-dma: Add A100 compatible
      dmaengine: sun6i: Add support for A100 DMA

Zhang Qilong (2):
      soc: ti: knav_qmss: fix reference leak in knav_queue_probe
      soc: ti: Fix reference imbalance in knav_dma_probe

Zhihao Cheng (2):
      drivers: soc: ti: knav_qmss_queue: Fix error return code in knav_queu=
e_probe
      dmaengine: mv_xor_v2: Fix error return code in mv_xor_v2_probe()

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (2):
      dt-bindings: dmaengine: Add JZ4775 bindings.
      dt-bindings: dmaengine: Add X2000 bindings.

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |   21 +
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |    5 +-
 .../devicetree/bindings/dma/atmel-xdma.txt         |    3 +-
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |    1 +
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   88 +
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml       |  164 ++
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml      |  172 ++
 Documentation/driver-api/dmaengine/client.rst      |    4 +-
 drivers/dma/Kconfig                                |   10 +
 drivers/dma/at_xdmac.c                             |  163 +-
 drivers/dma/dma-jz4780.c                           |    2 +-
 drivers/dma/dmatest.c                              |   13 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |    2 +-
 drivers/dma/dw/core.c                              |    6 +
 drivers/dma/hisi_dma.c                             |    5 +-
 drivers/dma/idma64.c                               |    8 +-
 drivers/dma/idxd/cdev.c                            |   50 +-
 drivers/dma/idxd/device.c                          |  168 +-
 drivers/dma/idxd/dma.c                             |    9 -
 drivers/dma/idxd/idxd.h                            |   61 +-
 drivers/dma/idxd/init.c                            |  128 +-
 drivers/dma/idxd/irq.c                             |  146 +-
 drivers/dma/idxd/registers.h                       |   51 +-
 drivers/dma/idxd/submit.c                          |   37 +-
 drivers/dma/idxd/sysfs.c                           |  207 +-
 drivers/dma/imx-dma.c                              |   33 +-
 drivers/dma/imx-sdma.c                             |   38 +-
 drivers/dma/ipu/ipu_idmac.c                        |   11 +-
 drivers/dma/k3dma.c                                |    9 +-
 drivers/dma/milbeaut-xdmac.c                       |    5 +-
 drivers/dma/moxart-dma.c                           |    5 +-
 drivers/dma/mv_xor.c                               |    2 +-
 drivers/dma/mv_xor_v2.c                            |    4 +-
 drivers/dma/mxs-dma.c                              |   37 +-
 drivers/dma/of-dma.c                               |   10 +
 drivers/dma/pl330.c                                |    2 -
 drivers/dma/ppc4xx/adma.c                          |    4 +-
 drivers/dma/pxa_dma.c                              |    5 +-
 drivers/dma/qcom/Kconfig                           |   23 +
 drivers/dma/qcom/Makefile                          |    2 +
 drivers/dma/qcom/bam_dma.c                         |    2 +-
 drivers/dma/qcom/gpi.c                             | 2303 ++++++++++++++++=
++++
 drivers/dma/qcom/qcom_adm.c                        |  905 ++++++++
 drivers/dma/sf-pdma/sf-pdma.c                      |   12 +-
 drivers/dma/ste_dma40.c                            |    5 +-
 drivers/dma/stm32-dma.c                            |   47 +-
 drivers/dma/stm32-dmamux.c                         |    2 +-
 drivers/dma/stm32-mdma.c                           |   66 +-
 drivers/dma/sun6i-dma.c                            |   25 +
 drivers/dma/tegra210-adma.c                        |    7 +-
 drivers/dma/ti/Makefile                            |    3 +-
 drivers/dma/ti/dma-crossbar.c                      |    6 +-
 drivers/dma/ti/k3-psil-am64.c                      |  158 ++
 drivers/dma/ti/k3-psil-priv.h                      |    1 +
 drivers/dma/ti/k3-psil.c                           |    1 +
 drivers/dma/ti/k3-udma-glue.c                      |  383 +++-
 drivers/dma/ti/k3-udma-private.c                   |   45 +
 drivers/dma/ti/k3-udma.c                           | 1966 +++++++++++++++--
 drivers/dma/ti/k3-udma.h                           |   28 +-
 drivers/firmware/ti_sci.c                          |  213 +-
 drivers/firmware/ti_sci.h                          |   72 +-
 drivers/soc/ti/Kconfig                             |   18 -
 drivers/soc/ti/k3-ringacc.c                        |  423 +++-
 drivers/soc/ti/k3-socinfo.c                        |    1 +
 drivers/soc/ti/knav_dma.c                          |   15 +-
 drivers/soc/ti/knav_qmss_queue.c                   |   66 +-
 drivers/soc/ti/omap_prm.c                          |    4 +
 drivers/soc/ti/pm33xx.c                            |    4 +-
 drivers/soc/ti/pruss.c                             |    6 -
 drivers/soc/ti/ti_sci_inta_msi.c                   |   12 +
 drivers/soc/ti/wkup_m3_ipc.c                       |    8 +-
 include/dt-bindings/dma/jz4775-dma.h               |   44 +
 include/dt-bindings/dma/qcom-gpi.h                 |   11 +
 include/dt-bindings/dma/x2000-dma.h                |   54 +
 include/linux/dma/k3-event-router.h                |   16 +
 include/linux/dma/k3-psil.h                        |   16 +
 include/linux/dma/k3-udma-glue.h                   |   12 +
 include/linux/dma/qcom-gpi-dma.h                   |   83 +
 include/linux/dmaengine.h                          |   19 +
 include/linux/soc/ti/k3-ringacc.h                  |   22 +
 include/linux/soc/ti/ti_sci_protocol.h             |   85 +-
 include/uapi/linux/idxd.h                          |   79 +
 82 files changed, 8037 insertions(+), 925 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,gpi.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
 create mode 100644 drivers/dma/qcom/gpi.c
 create mode 100644 drivers/dma/qcom/qcom_adm.c
 create mode 100644 drivers/dma/ti/k3-psil-am64.c
 create mode 100644 include/dt-bindings/dma/jz4775-dma.h
 create mode 100644 include/dt-bindings/dma/qcom-gpi.h
 create mode 100644 include/dt-bindings/dma/x2000-dma.h
 create mode 100644 include/linux/dma/k3-event-router.h
 create mode 100644 include/linux/dma/qcom-gpi-dma.h


--=20
~Vinod

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl/blEsACgkQfBQHDyUj
g0e2LBAAz+uw9RYbhieXiy2kCblvET3Uw/Xkg7jjDKxoYj6UHgSdPIgv2UmNDcOa
wFuCtMxsu9Cr848LQCWsXoiUC3b6rLuUmENG3K1jV8AjoFqdqsUgYmc/Wz9oVOMh
IpF4YRJwnx5JTzbgFHxWnHhQEBwozea+o3MxOey/DtTeSo2XGY/P8wP3+5k1Z97I
KvF4wHW4j5tA/StPrD2h0OW3qxOccBwcnhSwespTrw5gaIPclOugEhZbYOxRRSP1
GhzcOj7e3GzWiHrUzE1r2JD1w6WFj8L8q3O80BUpuh6lrf7Y5B/auvz8AvsIkhxd
BFqrI3wJhhZkvYiHGE+1wnH2JhIKUzv5JSsDy30D9vxzy7hqELV+Y8D/3ZCPawpB
XmrE6HvEfnB8lc5yripVNcP/aALH7HmCEDmdFzrenKwwcsXIGo1sE9ddoxBybDzg
wc0EGWybPAutrOV/RgUWHGCcVys8IuLI4YKGsbOE0nnASTyS113QBla+KnQp53XB
08SPqY8p7GJ7p1UK+4GoQzEQFIn11CMLgt9q4khKsodgwcKkA3htU7ALG+n5ApzX
WfXGVgmcZSt+42YVAKa7qow5D4meV3X0aeQktGHBOVQ+os6FzbIhGCJn78hSLsOH
2tDm7nBKmi+hnkYjTqaRxuNAdEuAHF45Rbf0yFI/jb8nsrVHzdI=
=dCnh
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
