Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82A91303C7
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jan 2020 18:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgADRcp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Jan 2020 12:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgADRcp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 Jan 2020 12:32:45 -0500
Received: from localhost (unknown [106.51.108.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EA52464E;
        Sat,  4 Jan 2020 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578159164;
        bh=mgrvlSBDUo99OlCWA23LLgyX9ga8hC+UzSWpQP8B+rA=;
        h=Date:From:To:Cc:Subject:From;
        b=UPXNtbHcWZ/JzEhPJCoxMZ22j3sm7n5Okuc22xVFl2JdF64Wydt8Jwel4o4lY/ksC
         bYgwNqhIHbSKTUfI/S/rEtjAuyDMD6/oXSLHU3Yj3ClvHbi17PnKGNgRTxSe5ZDhJ6
         2Fq69w+IqSvOppgvKhDVxwnOvKunyPAIymMASTQE=
Date:   Sat, 4 Jan 2020 23:02:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.5-rc5
Message-ID: <20200104173240.GH2818@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heya Linus,

Happy new year and new pull request for you to consider for v5.5-rc5
(nice version numbers!). Couple of core fixes and few driver fixes to be
considered.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.5-=
rc5

for you to fetch changes up to b0b5ce1010ffc50015eaec72b0028aaae3f526bb:

  ioat: ioat_alloc_ring() failure handling. (2019-12-27 12:06:06 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.5-rc5

Bunch of fixes for:
 - uninitialized dma_slave_caps access
 - virt-dma use after free in vchan_complete()
 - driver fixes for ioat, k3dma and jz4780

----------------------------------------------------------------
Alexander.Barabash@dell.com (1):
      ioat: ioat_alloc_ring() failure handling.

John Stultz (1):
      dmaengine: k3dma: Avoid null pointer traversal

Lukas Wunner (1):
      dmaengine: Fix access to uninitialized dma_slave_caps

Paul Cercueil (1):
      dmaengine: dma-jz4780: Also break descriptor chains on JZ4725B

Peter Ujfalusi (1):
      dmaengine: virt-dma: Fix access after free in vchan_complete()

 drivers/dma/dma-jz4780.c  |  3 ++-
 drivers/dma/ioat/dma.c    |  3 ++-
 drivers/dma/k3dma.c       | 12 +++++++++---
 drivers/dma/virt-dma.c    |  3 +--
 include/linux/dmaengine.h |  5 ++++-
 5 files changed, 18 insertions(+), 8 deletions(-)

Thanks
--=20
~Vinod

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl4QzDgACgkQfBQHDyUj
g0e2fQ/2I9343hEqKSxbQTGfVdxw1zJpM9d6MJuQwSnuyqn/Dvpi9AV7ixpnpFmq
Jw966sIkXXQ8/xUwrVSxkQLCRgIQD1vLi+533/2PZKLTOcBp5svSORoDgvMHLtSr
xi5LKM0DLVUSj1eKH/5vQPEoVGStAfQS8hBtFd+s8G3pCy16RS6DWoz/qDbB9zHT
yhp6TPQ85uhUbbFANF7hF/brHi6Vg+LtTuey9XORQ5MmIvfYRqm/0ZnIvJhF+kQi
qixgUqz+yVG2L5QYbCYPHPz3zvWbleC61VyDlthdG7GqD+DOoRiJD0xsGwZKta+a
2ocADPlwTyp8y0mnbCXrArl34kbMivs3aIukGzMpxqmxN3k1Wr+FicsD2RjI6l2g
3/W20V5L1qY4ddSc4Bs07yW9Y5tWFO2OSA9RsLMiFcD9lx1MllZsZAQRB4g6UWsQ
5shjWbx/xmdgucf6smoX/RZ35n4wNZ7SFFuL3OE3G/Vf09VAMA8O3SKTuN1QJ2FH
sVh5mwzJYi+bnszRTiLsaZEWuN25ro3ysSYLWa3u+2egsaMDZLgQW3mnzC7HNVa8
SveicRYm096GgY9F4Bj+ZV7xZU+/APVuerEbkw46E9f1EctIVFisyqIiH6Iklije
BhAg1sLAuL6PmD9ruoNtuwvSrHAcuG0KdUzuaNYSoEXNBN5SNw==
=G97I
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
