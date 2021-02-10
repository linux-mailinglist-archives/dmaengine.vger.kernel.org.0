Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0726D316320
	for <lists+dmaengine@lfdr.de>; Wed, 10 Feb 2021 11:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBJKDj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Feb 2021 05:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhBJKB0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Feb 2021 05:01:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 094D660235;
        Wed, 10 Feb 2021 10:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612951240;
        bh=ztSbbp80YOWbAAbbvPuLSqTDjOdJ9Nw8DBZvAkpK63s=;
        h=Date:From:To:Cc:Subject:From;
        b=Dek8duigBvYQvfsUAy67eA2AHvg5bf5zJR04X9ax0ILJYQWvheLjqBuogm5l1PGmU
         kXeUtW9P5UuYAGDVbkTJPBnWZVsKGRya6yROMJiXm2j9mGUVxIUsEcLQ+/7t+n79q8
         s5MYxyrEms5N/dR5tT4oPadg+vASrwrR/NpDO3S/ryXa19k2TPfJnOQHihHBvjnOyT
         KoEOJ/SbOEZ7RAXikeC99LlN4jt91tSeaY2xfQmhyH6K8bYGPfZXPKUNO8h8UUCsdG
         s4aJbDpgzUxcoG17KHLA2K9Sx2XBDT7aW9cMyvXpyHg2yy9RLY+r8EHY3eFoTLWFDm
         jVEVu2rt2gqXg==
Date:   Wed, 10 Feb 2021 15:30:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine fixes for v5.11
Message-ID: <20210210100036.GD2774@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Few late fixes for dmaengine. This includes one core fix and couple of
driver fixes.

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix2-5.11

for you to fetch changes up to b6c14d7a83802046f7098e9bae78fbde23affa74:

  dmaengine dw: Revert "dmaengine: dw: Enable runtime PM" (2021-02-08 17:36=
:12 +0530)

----------------------------------------------------------------
dmaengine fixes-2 for v5.11

Some late fixes for dmaengine:
 - Core: fix channel device_node deletion
 - Driver fixes for:
   - dw: revert of runtime pm enabling
   - idxd: device state fix, interrupt completion and list corruption
   - ti: resource leak

----------------------------------------------------------------
Cezary Rojewski (1):
      dmaengine dw: Revert "dmaengine: dw: Enable runtime PM"

Christophe JAILLET (1):
      dmaengine: ti: k3-udma: Fix a resource leak in an error handling path

Dave Jiang (4):
      dmaengine: idxd: Fix list corruption in description completion
      dmaengine: idxd: fix misc interrupt completion
      dmaengine: move channel device_node deletion to driver
      dmaengine: idxd: check device state before issue command

 drivers/dma/dmaengine.c   |   1 -
 drivers/dma/dw/core.c     |   6 ---
 drivers/dma/idxd/device.c |  23 ++++++++-
 drivers/dma/idxd/dma.c    |   5 +-
 drivers/dma/idxd/idxd.h   |   2 +-
 drivers/dma/idxd/init.c   |   5 +-
 drivers/dma/idxd/irq.c    | 122 +++++++++++++++++++++++++++---------------=
----
 drivers/dma/ti/k3-udma.c  |   3 +-
 8 files changed, 104 insertions(+), 63 deletions(-)

Thanks
--=20
~Vinod

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmAjrsQACgkQfBQHDyUj
g0c+WRAAhDc6IiI6HY4zZTy+zYcEIwl8Pv1QifwuzR526+SSJJvAx1K+r7btZ4Nv
z+/BYd1aEIvYdQc/g7Myo2n279uA16l7U9WfRL2+8ElQPWa71q6t56vZUxX/90jL
cyv/NhFWHKXjCXf9lsjrrAbG6OMGMocx0D40EClHbn5JtLK6hWcm7my1iMxCRJEM
kGKvw9FKJkHHX/T+DpxxvHGP/n8HkG1FG27H3K7KIkuWMnuWhk5bD/7caRP55AWG
3tLBVxVG3DlW+858JdWZzD4sGqu5xhlRmYt7VtqalnqVpHEY9lFlYSRJPja9e+2t
egm97Ae0Kd6TZStLeqiBhWeTTs0PUWzZk9LcOZ67+2xjAdQTexwsqdE1qYbhmVap
v1FWMoBBAope3+8V+IdqWxcTOrSYG0Sl0gJI+UGL1N3XwtUle984OtWQYMwDivGM
qOStCBE6STI9tXsbFMYetbPC0QMMTWYZZ1WkQJImAeMJV3zWbQcRKumygmQ3vwpJ
wJQEVfdZDp17x77R4FOYRorP4H7SVr1fhMbCU8fCbeMpjIqXG3/O8earep2x/khf
d11XDu71ggSfc4YJErwisTbDTFMt3qjeSXiypP92PmHN2jSW8y67c2R1ENdiOOA5
wR2BRG+2QlnIH19JJlRK2Vm/dPtpI2OJMMBh8Onx4ojbRKbuwkY=
=Ak+o
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
