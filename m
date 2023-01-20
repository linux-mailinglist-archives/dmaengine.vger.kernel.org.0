Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48D675817
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jan 2023 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjATPF6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 10:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjATPF6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 10:05:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919C81013;
        Fri, 20 Jan 2023 07:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83ACFB82842;
        Fri, 20 Jan 2023 15:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944E8C433D2;
        Fri, 20 Jan 2023 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674227154;
        bh=FqjL3F2Ya/S3lL+BRiUlJ9b0elqmquFuzg6zPSnT0iQ=;
        h=Date:From:To:Cc:Subject:From;
        b=iUgbL1TRBNSw6Zm03vqBFSyf0WjxqzAbhiWwfwp5ub97egrULOCpPc1ywN+f5vTj1
         rAHGZdj0o+VKSlgJmFce344IqWzDkSFCrZiLcBd/KL/Ev6PAY9PkZf3wt2p1C5NPsM
         IRa/dgttxN0ydLXKvCp8721kzN93C8LQKGPY9MMokHPORALYS3p9+Z8mo+ZGqxeqyF
         6BvmWP2mv0noUxrBaMobPIWWXVKwkZh/Vqs6avVm2fDvH8wNgTyD7xoRusWVnyJMOk
         7V6DeqwUwDBFQogBMMFE1Ut/e3qjyrqPuA6Aydvn8h06QFJBfDqzEh05r99l7laHAW
         7C/yRPqPGe5Vw==
Date:   Fri, 20 Jan 2023 20:35:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.2
Message-ID: <Y8qtzmmIEH+zN7Bm@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wmtoc3QEgDe/wWfF"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--wmtoc3QEgDe/wWfF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the dmaengine fixes pull request for v6.2. This brings one core
fix, one email update and bunch of small driver fixes.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.2

for you to fetch changes up to 95e5fda3b5f9ed8239b145da3fa01e641cf5d53c:

  ptdma: pt_core_execute_cmd() should use spinlock (2023-01-19 18:59:34 +05=
30)

----------------------------------------------------------------
dmaengine fixes for v6.2

- Jie Hai's email address Update
- double increment of client_count in dma_chan_get()
- Driver fixes for:
  - Bunch of idxd driver fixes use after free, probe error handling and
    callback on wq disable
  - Go tre fix for qcom gpi driver
  - ptdma locking fix
  - tegra & imx-sdma mem leak fix

----------------------------------------------------------------
Akhil R (1):
      dmaengine: tegra: Fix memory leak in terminate_all()

Eric Pilmore (1):
      ptdma: pt_core_execute_cmd() should use spinlock

Hui Wang (1):
      dmaengine: imx-sdma: Fix a possible memory leak in sdma_transfer_init

Jayesh Choudhary (1):
      dmaengine: ti: k3-udma: Do conditional decrement of UDMA_CHAN_RT_PEER=
_BCNT_REG

Jie Hai (1):
      MAINTAINERS: update Jie Hai's email address

Koba Ko (1):
      dmaengine: Fix double increment of client_count in dma_chan_get()

Liu Shixin (1):
      dmaengine: xilinx_dma: call of_node_put() when breaking out of for_ea=
ch_child_of_node()

Mohan Kumar (1):
      dmaengine: tegra210-adma: fix global intr clear

Peter Harliman Liem (1):
      dmaengine: lgm: Move DT parsing after initialization

Reinette Chatre (3):
      dmaengine: idxd: Let probe fail when workqueue cannot be enabled
      dmaengine: idxd: Prevent use after free on completion memory
      dmaengine: idxd: Do not call DMX TX callbacks during workqueue disable

Shawn.Shao (1):
      Add exception protection processing for vd in axi_chan_handle_err fun=
ction

Vijaya Krishna Nivarthi (1):
      dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation

 MAINTAINERS                                    |  2 +-
 drivers/dma/dmaengine.c                        |  7 ++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  6 ++++++
 drivers/dma/idxd/device.c                      | 16 +++++++++++++---
 drivers/dma/imx-sdma.c                         |  4 +++-
 drivers/dma/lgm/lgm-dma.c                      | 10 +++++-----
 drivers/dma/ptdma/ptdma-dev.c                  |  7 ++++---
 drivers/dma/ptdma/ptdma.h                      |  2 +-
 drivers/dma/qcom/gpi.c                         |  1 +
 drivers/dma/tegra186-gpc-dma.c                 |  1 +
 drivers/dma/tegra210-adma.c                    |  2 +-
 drivers/dma/ti/k3-udma.c                       |  5 +++--
 drivers/dma/xilinx/xilinx_dma.c                |  4 +++-
 13 files changed, 46 insertions(+), 21 deletions(-)

--=20
~Vinod

--wmtoc3QEgDe/wWfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmPKrc0ACgkQfBQHDyUj
g0dyLRAAnZagD9FCZeGBRndBHJdLPo0xDxJchy4aGwKgKF4aMUL71M0T2sYJsL5N
DFFvBmJkyAwwkfOSZaJoLXX1RYkT37hsnN3MJ2iUftLhe7jpT+0CF/DQInRivB/W
e5xRfGV9kRS6EDql10bL+19LHuruLa1DF7V3rnssJHjdiChfg17BBErFZVmg2lJf
ORlAUyHm8skDYzm+0t+wZBQI6EUFO30PhmDjfgz+aXevXG8+Tw+jBCGa/2OPhA88
h8Zt24th8unlp+CapJMY7Y3lFklh5bgWwBI0m2337/RglK+o519dSxu8S246vvcv
t9I03/ePXd94XEaLzWeA6Vc4e6/1TSam39j2auVaZLZ509RuDdiBdgMKJe8fGqwK
ExbvnHHLAVSOyejV+wEzrrXd463dWdkkqlP/z5Qwf3CtymrHQFvs5oa+dxCGC6cm
bVHJhc12UYW5vWBbTTO/C4nol1lDwMKUkDw0Rk6SJTXKon4EYHJJdYHHZipuAA4B
SmmGdA2Fid0mHxtk1BvLFvLr9ySfvSirztGdCRQSGW4qXZgyNF0DT0DbH6nLtsHG
FTEi68XsAH0PLAltBXy6bZrJ2iWo0a0rKzcrfvawsMDPomPhD4pbcoH6y0g8eM4K
4J4dmTwf3WxwfHBITZqQDj9HC/MuolOq6OJ5xanYV85aKclrl8w=
=l4I+
-----END PGP SIGNATURE-----

--wmtoc3QEgDe/wWfF--
