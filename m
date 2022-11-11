Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A096253F1
	for <lists+dmaengine@lfdr.de>; Fri, 11 Nov 2022 07:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiKKGlr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Nov 2022 01:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiKKGlq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Nov 2022 01:41:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81C5554FA;
        Thu, 10 Nov 2022 22:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58EE0B823E5;
        Fri, 11 Nov 2022 06:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FFAC433D6;
        Fri, 11 Nov 2022 06:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668148903;
        bh=imgg4tVLfCZ/GizDZDghCksoFItFXoconeGZjaDVqSU=;
        h=Date:From:To:Cc:Subject:From;
        b=axTqDXCflYHUNlkP2Y7f4TluUWsluykOAweRp7d+/Y3c1SH+FFhISP05Og42Tyrls
         NP6DQz0eYULyrzvYwW3NAupG3LDMLosoLt5bu/6sJl/v9OV7sTd2wh4QFbcjA9ZZop
         AvMHkrnZgIe5us6lmuILPkFDj5IK1hwFBJCGFZSttxk5QEDxzF+ko/fl+QVH6uRrj/
         o3W8dDjK5F/QFmNIlDjbDs/d6hmBqgGz7jUAduPUA9sI9Ry3uizx4eX+LcCIIoIRiG
         Lfspb0GgRHPWetumNKhSOkWWojV/I4T+62BOQQ5N+rGVAWf+OZ/P+hZnrHEE0+20me
         k/ytGJBBLioUQ==
Date:   Fri, 11 Nov 2022 12:11:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.1
Message-ID: <Y23uoaujTTOGvcwH@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1N6UD84RmFQ/IzO"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--k1N6UD84RmFQ/IzO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to consider fixes in dmaengine subsystem. These bring minor
driver fixes and a big pile of at_hdmac driver fixes. More work on this
driver is done and sitting in next.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.1

for you to fetch changes up to c47e6403fa099f200868d6b106701cb42d181d2b:

  dmaengine: at_hdmac: Check return code of dma_async_device_register (2022=
-11-08 10:43:57 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.1

Driver fixes for:
 - Pile of at_hdmac driver rework which fixes many long standing issues
   for this driver.
 - couple of stm32 driver fixes for clearing structure and race fix
 - idxd fixes for RO device state and batch size
 - ti driver mem leak fix
 - apple fix for grabbing channels in xlate
 - resource leak fix in mv xor

----------------------------------------------------------------
Amelie Delaunay (2):
      dmaengine: stm32-mdma: memset stm32_mdma_chan_config struct before us=
ing it
      dmaengine: stm32-dma: fix potential race between pause and resume

Christophe JAILLET (1):
      dmaengine: mv_xor_v2: Fix a resource leak in mv_xor_v2_remove()

Doug Brown (1):
      dmaengine: pxa_dma: use platform_get_irq_optional

Fenghua Yu (1):
      dmaengine: idxd: Do not enable user type Work Queue without Shared Vi=
rtual Addressing

Fengqian Gao (1):
      dmaengine: idxd: fix RO device state error after been disabled/reset

Martin Povi=C5=A1er (1):
      dmaengine: apple-admac: Fix grabbing of channels in of_xlate

Tudor Ambarus (15):
      dmaengine: at_hdmac: Fix at_lli struct definition
      dmaengine: at_hdmac: Don't start transactions at tx_submit level
      dmaengine: at_hdmac: Start transfer for cyclic channels in issue_pend=
ing
      dmaengine: at_hdmac: Fix premature completion of desc in issue_pending
      dmaengine: at_hdmac: Do not call the complete callback on device_term=
inate_all
      dmaengine: at_hdmac: Protect atchan->status with the channel lock
      dmaengine: at_hdmac: Fix concurrency problems by removing atc_complet=
e_all()
      dmaengine: at_hdmac: Fix concurrency over descriptor
      dmaengine: at_hdmac: Free the memset buf without holding the chan lock
      dmaengine: at_hdmac: Fix concurrency over the active list
      dmaengine: at_hdmac: Fix descriptor handling when issuing it to hardw=
are
      dmaengine: at_hdmac: Fix completion of unissued descriptor in case of=
 errors
      dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
      dmaengine: at_hdmac: Fix impossible condition
      dmaengine: at_hdmac: Check return code of dma_async_device_register

Xiaochen Shen (1):
      dmaengine: idxd: Fix max batch size for Intel IAA

Yang Yingliang (1):
      dmaengine: ti: k3-udma-glue: fix memory leak when register device fail

 drivers/dma/apple-admac.c     |   2 +-
 drivers/dma/at_hdmac.c        | 153 +++++++++++++++++---------------------=
----
 drivers/dma/at_hdmac_regs.h   |  10 +--
 drivers/dma/idxd/cdev.c       |  18 +++++
 drivers/dma/idxd/device.c     |  26 ++++---
 drivers/dma/idxd/idxd.h       |  32 +++++++++
 drivers/dma/idxd/init.c       |   4 +-
 drivers/dma/idxd/sysfs.c      |   2 +-
 drivers/dma/mv_xor_v2.c       |   1 +
 drivers/dma/pxa_dma.c         |   4 +-
 drivers/dma/stm32-dma.c       |  14 ++--
 drivers/dma/stm32-mdma.c      |   1 +
 drivers/dma/ti/k3-udma-glue.c |   3 +
 include/uapi/linux/idxd.h     |   1 +
 14 files changed, 150 insertions(+), 121 deletions(-)

Thanks
--=20
~Vinod

--k1N6UD84RmFQ/IzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmNt7qEACgkQfBQHDyUj
g0c7zhAAoD2ZfIGGL+Na3qnyXnzjKMw8/caySIW/AvYRPBqz8Oa3sMm2psSXwyWb
myJf0/CFg5HeoiaNWUK7b3utm1N66F9uGyt//fhTndklDdSWMIt77iPTfMPAyrXV
bA8Rw8179o812x8voNLJCivwImSNXLx5G/FlFVuVL1lqk3Z9nrox3ZjiI/OrQPfM
p3HbLxV0InDPxg4fIxvuKj5Z2Uj+XmSOYZBUIVMyBqy++e7yb9cM+4cjFclYtLJF
NdWtsxRw9XoxHUAIlsfdiwl/+9ho3WCw2TgOjHUZaIQcvin+W1w1R6eLVdQvTZe0
X5Q2/DGzadVum4u6vtS63tCvK9L3uQAE6Zd9/boqWj0w9zGZk0SA5M1frGsw9rN/
PX2zJdyj6o7/MEwRlbtBhvwLygUJBLWgA+DcHb3b2DPxrlS8zHJo3oZjR2XW9erJ
cxftTt58B2SBuijttl/fr0KtEKI7maRm+xbKLAy43SUngOiXBqgAvx+rWmb3N+yq
RDiitR+0I7/gggbztj/l9J95knDtxSvVd+m1VnTec+coZb2+6xqjkUk9XEEDq0Cr
lTaNp1PHu3KZGC4fxIyIWBlsXKc2h8hhq1B/O4tuo+LL3HEC9wcvi+2GZREIkVhs
8fTVFPe7Sk9FGRUsHzHLeywdjMrkqeNLUl2oMYfJy/8fsBSBnBQ=
=l+4V
-----END PGP SIGNATURE-----

--k1N6UD84RmFQ/IzO--
