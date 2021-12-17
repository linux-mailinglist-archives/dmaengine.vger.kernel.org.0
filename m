Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1E4784A8
	for <lists+dmaengine@lfdr.de>; Fri, 17 Dec 2021 06:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhLQFtC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Dec 2021 00:49:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59894 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhLQFtC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Dec 2021 00:49:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE306B826F3;
        Fri, 17 Dec 2021 05:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB8FC36AE1;
        Fri, 17 Dec 2021 05:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639720139;
        bh=ydzG2zIgQsWBNpyzfdxjKlQ0X202UtZWG0YBtLKpMIU=;
        h=Date:From:To:Cc:Subject:From;
        b=o/ep/K41NgBq9irO3oGoQL5v/UDvxSkWdy7NTADZMU5n0HdxMISG0N7GnralXm4o8
         pAOPR6/MSe1VpY/utQfr3sIEbPm4k+o6GR3r6X9NOBvHy8cpy2vsowdpVylWFx5ZXL
         ac5UdjgiG+O02uZyquIXxaMNX/jvtM32dTVBHe4YryNYMTV0PHmWcoh+oXgXhr1UBU
         My3orC7X9OiiX8TkJnAYhE4AI2NGRAvEHrTNhFLh9MYF8oba2K7U7Mv3b8u35FKd1O
         zp884iYlqNXqGorCi9gL007hioXKwKWtQVhSdZmIz4KCx5DTy2eWzJbenw2inNqsWj
         zpm4mkOG78XDw==
Date:   Fri, 17 Dec 2021 11:18:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.16
Message-ID: <Ybwkx9ZapFijTpqX@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvuO0Yesg5hJsVpm"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--mvuO0Yesg5hJsVpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to recieve bunch of driver fixes for dmaengine subsystem.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.16

for you to fetch changes up to 822c9f2b833c53fc67e8adf6f63ecc3ea24d502c:

  dmaengine: st_fdma: fix MODULE_ALIAS (2021-12-13 13:18:48 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.16

Bunch of driver fixes, notably:
 - uninit variable fix for dw-axi-dmac driver
 - return value check dw-edma driver
 - calling wq quiesce inside spinlock and missed completion for idxd driver
 - mod alias fix for st_fdma driver

----------------------------------------------------------------
Alyssa Ross (1):
      dmaengine: st_fdma: fix MODULE_ALIAS

Christophe JAILLET (1):
      dmaengine: dw-edma: Fix return value check for dma_set_mask_and_coher=
ent()

Dave Jiang (2):
      dmaengine: idxd: fix calling wq quiesce inside spinlock
      dmaengine: idxd: fix missed completion on abort path

Tim Gardner (1):
      dmaengine: dw-axi-dmac: Fix uninitialized variable in axi_chan_block_=
xfer_start()

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma: Fix smatch warnings

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |   4 +-
 drivers/dma/dw-edma/dw-edma-pcie.c             |  10 +-
 drivers/dma/idxd/irq.c                         |   2 +-
 drivers/dma/idxd/submit.c                      |  18 ++-
 drivers/dma/st_fdma.c                          |   2 +-
 drivers/dma/ti/k3-udma.c                       | 157 +++++++++++++++++----=
----
 6 files changed, 129 insertions(+), 64 deletions(-)


Thanks
--=20
~Vinod

--mvuO0Yesg5hJsVpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmG8JMcACgkQfBQHDyUj
g0cslBAAu8nQ8EbmkhkF8DvCY7mS2cAA3sqhHTMmRy1gE2FBkPn0XQqw4BLk+9rS
wIObUjzrR0zBUnknMfAsN4Kgr1s9OXg/A7yKiKKKqmP8ikpoSxNhGBm3ZMnEyVpR
D4jm/91P+3QhETwGzt3zgs6lJsFcHqugWefeFfyk4vR14MrgXyxsCt0m6fQV4HyV
dI+3EH+b270e41iNTVLG+ySO8x96Axrha9oB9IA3FX25EzZDgTe0tTlXx66Xydyy
k4Oao2zzdfVI4SAL8GVZ03/9vioNqt9PxP8mDVmU+h2PQ80sXcxsANOx3TKC0azW
nDmVrAarJa9aKPxO76+DsQhqc2aOcEh4xb0Y1lKaFuw7TzSlJusHZLwEFH68PNDJ
2iXxXMxMnZ1hHjMxQqrmXhr410yJawJCQnpbIUhuP2Pe+wvWKdfng/ciPHngKTp4
JxtI+23J5cLCRlWg1HaD2cYVgxhk43SAtAEhsrMRDyeGkHy3aNUCgOWLFT7DvDDb
ySJitml/KWTT862LIKcU+ChrJ9D/y3TmIdsp8wtrinbhhA6HqvzW8mc0q9/SWUaF
PlVjJgPnnvJKlSygQeYw9X7nnoc/U/ZQe21DPLw4IZ9qrr2j6WvoZqqU6W0eCr1m
wx36mBSccj/YPLEvEaMSiNka/1SlhmmocMV21dO9NpYHqZC+FuA=
=enPn
-----END PGP SIGNATURE-----

--mvuO0Yesg5hJsVpm--
