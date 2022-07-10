Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123AF56D05A
	for <lists+dmaengine@lfdr.de>; Sun, 10 Jul 2022 19:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGJRNt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Jul 2022 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGJRNt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Jul 2022 13:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2732AB1FE;
        Sun, 10 Jul 2022 10:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F38560BB5;
        Sun, 10 Jul 2022 17:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED08FC3411E;
        Sun, 10 Jul 2022 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657473225;
        bh=p7ZhMlaQa68leGqforGtWW2/3COJqluhTCLhAdhajXw=;
        h=Date:From:To:Cc:Subject:From;
        b=E2J4EIri18lX5s82TKZJmbkPm/5+cxSflXbQqvdhNzIKYSBxc2mDBmmLJoWrfdiQU
         mwlaWKuttwWSHCqmWq7G5tQFynHrY/9CURmVl5ILsQiNWGCugIgp8sgXD4D+hB/NVs
         VP+jsqr/A/mgE8XvieFDPBBci+1cFyXTtWzUXXk+GS2O2qBgQKaxvRCRFQM1kTyWm7
         OlOfE/JYQr6kGyHu2Kmo92XiKDFq+apRkPdamBqOq/zdgA540KUgZ4MlIR7JsfZoSe
         wR26R5NgiJVRd+ivkCXXRCtyvp/6BKPZfrL/t3YxJ2Ea175ZjS62OLqRMeCntWQbC2
         dufVL21Dmjq8w==
Date:   Sun, 10 Jul 2022 22:43:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.19
Message-ID: <YssIxUbLKJ+wwlzG@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBO9pI3RWam3M84G"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--gBO9pI3RWam3M84G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull the following to receive dmaengine fixes for v5.19. This
include one core fix for DMA_INTERRUPT and rest driver fixes.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.19

for you to fetch changes up to 607a48c78e6b427b0b684d24e61c19e846ad65d6:

  dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max typo (2022-07-06 =
21:57:05 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.19

Core:
 - Revert verification of DMA_INTERRUPT capability as that was incorrect

Bunch of driver fixes for:
 - ti: refcount and put_device leak
 - qcom_bam: runtime pm overflow
 - idxd: force wq context cleanup and call idxd_enable_system_pasid() on
   success
 - dw-axi-dmac: RMW on channel suspend register
 - imx-sdma: restart cyclic channel when enabled
 - at_xdma: error handling for at_xdmac_alloc_desc
 - pl330: lockdep warning
 - lgm: error handling path in probe
 - allwinner: Fix min/max typo in binding

----------------------------------------------------------------
Caleb Connolly (1):
      dmaengine: qcom: bam_dma: fix runtime PM underflow

Christophe JAILLET (1):
      dmaengine: lgm: Fix an error handling path in intel_ldma_probe()

Dave Jiang (1):
      dmaengine: idxd: force wq context cleanup on device disable path

Dmitry Osipenko (1):
      dmaengine: pl330: Fix lockdep warning about non-static key

Emil Renner Berthing (1):
      dmaengine: dw-axi-dmac: Fix RMW on channel suspend register

Jerry Snitselaar (1):
      dmaengine: idxd: Only call idxd_enable_system_pasid() if succeeded in=
 enabling SVA feature

Miaoqian Lin (2):
      dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
      dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate

Michael Walle (1):
      dmaengine: at_xdma: handle errors of at_xdmac_alloc_desc() correctly

Peter Robinson (1):
      dmaengine: imx-sdma: Allow imx8m for imx7 FW revs

Samuel Holland (1):
      dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max typo

Sascha Hauer (1):
      dmaengine: imx-sdma: only restart cyclic channel when enabled

Vinod Koul (1):
      dmaengine: Revert "dmaengine: add verification of DMA_INTERRUPT capab=
ility for dmatest"

 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |  2 +-
 drivers/dma/at_xdmac.c                             |  5 +++
 drivers/dma/dmatest.c                              | 13 ++------
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  8 +++--
 drivers/dma/idxd/device.c                          |  5 +--
 drivers/dma/idxd/init.c                            | 13 ++++----
 drivers/dma/imx-sdma.c                             |  4 +--
 drivers/dma/lgm/lgm-dma.c                          |  3 +-
 drivers/dma/pl330.c                                |  2 +-
 drivers/dma/qcom/bam_dma.c                         | 39 ++++++------------=
----
 drivers/dma/ti/dma-crossbar.c                      |  5 +++
 11 files changed, 43 insertions(+), 56 deletions(-)

Thanks
--=20
~Vinod

--gBO9pI3RWam3M84G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmLLCMUACgkQfBQHDyUj
g0dNug/9E1eyqjTrlF5iOAWxf/nVCfe1PCwS2oKE9tyRc3XsSvg/GshqtBuOQ3wc
mK5PMrujrsb4xiu/IM6bFt4eG+5I5gHiT6MK24u2bJ+rLxIGsSq+dZiTU6lszScE
XlRaChSFJiDFO9lJNX9S9pr91rZszX9IyktDfSDFsMzM4zE9jN4MJzMSBpCdkP3I
qk2T+gCy29+LYUi0mUH/RsZ4hJ1zWHhgLaL7ldXAi/GwRYRK8DaxGAo6Q6s1qHfp
qwfmna4acSb769AGJkPjqb+bLOQDAHUdvcfXBC/3GNEMkmyoVbTuQE8ry6ePTJ/v
Ho6h6dshe5R9nhttqFvKtbbUdIKgNQHXewfgw1XI9Ws/G2JHmpPnvL+QNKT671Zk
VUOv7x2l5k1uDGMTCWpQpwS7f6tenCRgyI+Ide6XDCOtS8mTGNaZ8Ea0L92G5DZ0
9YG5gjQi6pmWw8tXlmb5F2fHib16p7/X98MNyX9dyfPKbW2RRhHsPGPoh3SelwrF
Vrhn26UZMaq4Xr5/1OOhKKnuwF7rDHZPBADvYPdbGRwIptW9MPIEW67k4Fxf6SE0
7QsI5xRDGtDE8G5GGMIASKZ0PZSwtwmZ6GxQ72+ZQ4jUAZeDZk0cQ2xIJs8k2Wso
awVa5xUSAGufyqDIKoNPdBtz/F5b6nnwJQF73pqH6jLLtz8Q2Mg=
=Aib6
-----END PGP SIGNATURE-----

--gBO9pI3RWam3M84G--
