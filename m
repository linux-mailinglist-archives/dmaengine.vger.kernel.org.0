Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D824BCEF4
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 15:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiBTOKt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 09:10:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243167AbiBTOKo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 09:10:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7F84B40F;
        Sun, 20 Feb 2022 06:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE6E61183;
        Sun, 20 Feb 2022 14:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C805C340F1;
        Sun, 20 Feb 2022 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645366222;
        bh=x1e9WpSJg6pvlqSnU+CmONdE9nG45brjpDmAsA5OPIs=;
        h=Date:From:To:Cc:Subject:From;
        b=HSzc5C+f500FabQaLUIL9WfnxM/e0LIj8Xqt62uA8JPFLQJMO6550p9Qe8OZ0MawZ
         bolGQTUNDSRhahq+7/rM6ZW59EZ0j7eBK5SABWUOfNoIM2+aNes+IDCg6QmvAtiPJ8
         c4VFSrYTPZryXv9RfNsYMSb3d6WgohmspCG+W0O35+VKrTQUH68JOo7sqO/MLYNEsl
         D8LG4oVc3G8B/Gwr6M3xJc4tQfhxgprQokGXIHwBbrq4g0mI2h9UTZ2iX2xHTuLAiw
         EQXJsWeopiiku4YWGMeuVJCg9M5wikxBzNBYf21eflQn7MO3KzmvBmbsNvB+KYydbD
         Q/ERIyK5QYMqw==
Date:   Sun, 20 Feb 2022 19:40:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.17
Message-ID: <YhJLyWF5PZvc242o@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z++uS9hCUogcDo3u"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--z++uS9hCUogcDo3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for v5.17.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.17

for you to fetch changes up to 455896c53d5b803733ddd84e1bf8a430644439b6:

  dmaengine: shdma: Fix runtime PM imbalance on error (2022-02-15 11:04:16 =
+0530)

----------------------------------------------------------------
dmaengine fixes for v5.17

Bunch of driver fixes for:
 - ptdma error handling in init
 - lock fix in at_hdmac
 - error path and error num fix for sh dma
 - pm balance fix for stm32

----------------------------------------------------------------
Christophe JAILLET (1):
      dmaengine: ptdma: Fix the error handling path in pt_core_init()

Jiasheng Jiang (2):
      dmaengine: sh: rcar-dmac: Check for error num after setting mask
      dmaengine: sh: rcar-dmac: Check for error num after dma_set_max_seg_s=
ize

Miaoqian Lin (1):
      dmaengine: stm32-dmamux: Fix PM disable depth imbalance in stm32_dmam=
ux_probe

Yang Yingliang (1):
      dmaengine: at_xdmac: Fix missing unlock in at_xdmac_tasklet()

Yongzhi Liu (1):
      dmaengine: shdma: Fix runtime PM imbalance on error

 drivers/dma/at_xdmac.c        |  4 +++-
 drivers/dma/ptdma/ptdma-dev.c | 17 +++++++++--------
 drivers/dma/sh/rcar-dmac.c    |  9 +++++++--
 drivers/dma/sh/shdma-base.c   |  4 +++-
 drivers/dma/stm32-dmamux.c    |  4 +++-
 5 files changed, 25 insertions(+), 13 deletions(-)

--=20
~Vinod

--z++uS9hCUogcDo3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmISS8kACgkQfBQHDyUj
g0fp3A/+PT/usHZaJ0/tT9uL4PpZnX75tDF6P/XlaGPpfN1L/EIqfQQI8+tYGHLf
BtTsoXW1Bm1GfzMrsf4GLD+K/qk/KOsaF9qOobys0bLy6uJNnBgPSNBQDwkLgsQY
82GO5z1rm1SQD+vHkPFStAQDIryUMFzgXcUQ3PjUnzpIk6zfvH82arReuGaSx18x
RB87ZdeFzjv7V8QFQ7qxNRdJXbQ2oLB7skY78jvfPrBVA8w7JcRTu/eLu7UeUh7q
THrdCYV/+a4gfYnWmW96H4j08sTgtnWiInPWWxnhAcg/2jDmgW7G9pcRXG1+gr4T
9FYwf3BVxU9QzGBH6jr+LpVUXI2bqmQOBG589gGmMreM0i1lMNyFJ0wQCYrGwlB+
F+t050oXaI/S+NkdVlxF+o4TeoLk6Q8e+3rSqzdfw/iUKwHtnytiN/+9Z5YvfMKL
5nCFOYcT1qFAohJh1TLCCJpY0LTxfsUwD/6goQ9AZ9LHYW93EITKBM9emmhOkABN
Ojb4VvY1ya+E3nae6Crhm33IrN2HidVTiuBSU29koj3s30cEyEEcNOyyaObPsAue
gsope9rpmB4JJXALwmWddpNCWCLwRKGM9TW8+YMGNVcvpwNh4HeAZXUyBTtdDjpl
jVNR5SDQU1MkRDjV46uGip6ZIbe/UbzkfssOi/dajhpn/hdA8JY=
=WeYy
-----END PGP SIGNATURE-----

--z++uS9hCUogcDo3u--
