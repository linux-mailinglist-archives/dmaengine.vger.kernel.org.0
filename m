Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975551534DD
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 17:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBEQA0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 11:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgBEQA0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 5 Feb 2020 11:00:26 -0500
Received: from localhost (unknown [122.178.239.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4922E217BA;
        Wed,  5 Feb 2020 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580918426;
        bh=5n48n/+OAPherCXDe5xUSgmLMSiX8vRhB9CPtYCE74g=;
        h=Date:From:To:Cc:Subject:From;
        b=NVAJQONiMOM1z7OAABC7HAxWgUNJyYtd+RCV+qxhPOoHZn3ppONL/l+dLNIO8sqCl
         WtwnYsh1QISFWOtOLz7dzwLbK/OHOYVsrxpll08tFmvSzjr+4TftnbnK1hIvlbRX+k
         p6/Ns0E/y4R7Np8VHjBlR8ln3Nr/o2ihBKORDg30=
Date:   Wed, 5 Feb 2020 21:30:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine fixes for v5.6-rc1
Message-ID: <20200205160021.GL2618@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Couple of fixes came for the earlier dmaengine pull request for
v5.6-rc1, so here is the pull request with fixes. Please pull.

The following changes since commit 71723a96b8b1367fefc18f60025dae792477d602:

  dmaengine: Create symlinks between DMA channels and slaves (2020-01-24 11=
:41:32 +0530)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.6-=
rc1

for you to fetch changes up to bad83565eafe8a00922ad4eed6920625a10a2126:

  dmaengine: Cleanups for the slave <-> channel symlink support (2020-02-03=
 09:49:20 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.6-rc1

Fixes for:
 - Documentation build error fix
 - Fix dma_request_chan() error return
 - Remove unneeded conversion in idxd driver
 - Fix pointer check for dma_async_device_channel_register()
 - Fix slave-channel symlink cleanup

----------------------------------------------------------------
Dave Jiang (1):
      dmaengine: fix null ptr check for __dma_async_device_channel_register=
()

Marek Szyprowski (1):
      dmaengine: Fix return value for dma_request_chan() in case of failure

Peter Ujfalusi (1):
      dmaengine: Cleanups for the slave <-> channel symlink support

Vinod Koul (1):
      dmaengine: doc: Properly indent metadata title

kbuild test robot (1):
      dmaengine: idxd: fix boolconv.cocci warnings

 Documentation/driver-api/dmaengine/client.rst |  4 ++--
 drivers/dma/dmaengine.c                       | 21 ++++++++++++---------
 drivers/dma/idxd/sysfs.c                      |  2 +-
 3 files changed, 15 insertions(+), 12 deletions(-)

Thanks
--=20
~Vinod

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl465o8ACgkQfBQHDyUj
g0dh3RAA04DRH3vka6sjdAOE88NrH02Oot32lrC/BWJXuT7w8k3MwzY+KaQwP1nD
kNKbEYd4bSloKTDXCGUWuK1dwYFlOwLI/eAeZ1L8qeyGLJfJvPQD01BLpTQpdkIv
QzxBwRlRhuYErpbYn5IzfDTvxrG3gcF06CoK4Ds7FGLj10rtxZljeX8tsXr/nVPB
LiVZwrJHb1mpgphDVFVF/zRCuilaFIdNmgvVco5uF8ggkQOjHqcvzpwKWla7Rofp
n/TICMNOv4gGYYjJIWrhPdAcwEMiaYc6qGDJ0t6Ljogcr4v7fuIMCwH4EB1S8toy
MXoQ10XR5CLYgjlKq+4G4rzonVate1mqOVyJXy2YmRJruz4TeA7P7pJTkysJUJ5W
kVHWNRsqYZekhX+NkSm97WLXO2QopdaI8TiAjVqDT1wymo66VQ7wTfzavNl2Bn28
6Z0v6efenhrWoBUV8jHh/xz0RX9hyXeGCQL4R9xOfQSHs/9kEWPqXBAoinH2Rnch
ZhSzFGOwvV6Ost5g9CNz0Pw0iqX7jcRC8pkTqDG/RgqYcnZQCraOThlg3LEKSpIB
kuegi3H77QcRpaYUGS8IK+S/kUyvfkLZPSRyselJo6z8JSdydKxwZzUV2gNSkmBx
t3fUC07XyY+1wkpjlUd8vxFWckT6JCKwOEhseaN6jvZC9FBntvY=
=wA0N
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
