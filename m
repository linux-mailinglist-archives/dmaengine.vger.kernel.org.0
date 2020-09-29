Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0861227CFB0
	for <lists+dmaengine@lfdr.de>; Tue, 29 Sep 2020 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgI2Nox (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Sep 2020 09:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgI2Nox (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 29 Sep 2020 09:44:53 -0400
Received: from localhost (unknown [122.171.202.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C08207C4;
        Tue, 29 Sep 2020 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601387092;
        bh=zQe71h3hMDkcO3lGqxJ6ObZpKisB/OGPDNWyeteTzEo=;
        h=Date:From:To:Cc:Subject:From;
        b=zKdfmLXthdd+oLmftCSbCbxhfOLhsGSNcw0PY/0onUdGAWgf7vmQV1gAiPoxKXCs1
         AN225AEUu6F5OqndkeHblPeNk7gue/vYI/epseg56m3/7+gR0Q4+l1e2j5RVRLIgoW
         IbZgBxVL2jikaV+LjNHDz03zRgJjNRGBhWlWLoho=
Date:   Tue, 29 Sep 2020 19:14:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine late fixes for v5.9
Message-ID: <20200929134443.GL2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please consider pulling to receive one small fix for dmatest module
misconfigured channels

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.9

for you to fetch changes up to ce65d55f92a67e247f4d799e581cf9fed677871c:

  dmaengine: dmatest: Prevent to run on misconfigured channel (2020-09-22 2=
0:18:05 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.9

Dmatest:
 - Fix for misconfigured channel

----------------------------------------------------------------
Vladimir Murzin (1):
      dmaengine: dmatest: Prevent to run on misconfigured channel

 drivers/dma/dmatest.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

Thanks
--=20
~Vinod

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl9zOksACgkQfBQHDyUj
g0c27g/9HPauEG6SSsu72bsK6e/AogG2ppsRpaIUT01nJ444k4zB5YKS3eD7B7g9
c/iuEALJ/62aBDzWQVwxI5o0HS6oz8fDJ7bKhx7VZ2W5qSGVVqDeZs89qBam48XA
NmDFo12jFp4Jx/ClPRvh7O2pSY9o/RyxkUVa4XOTqAp1+2Wd03699ovuxFOY5mFq
q3AtfxLbeuXbAu2+AzNl9910ln5L4S53zaAFYxTR2ZKsHEcysotx0f1CzS7n4ZoS
R9GVjMaSvdcyKV1a9/2LhqHJ5tpiN/n57ehwkd/jWH9X5KAW6Z/ofge9XIynDPwI
0+RLkiCwym7NK3G72lO7+tECivy0sulqX6pOc9rEwJIYyFOxBd7TqpCPgxxMJtdB
uZ72yKabO8AdGNUa1DbujYRwk7g+39pkEdOjRYyzaiTg7xWfqrrw/SDncNkr8ROk
xF3N3DEiKP78FevpWgwsV+b/NZA3uwxQIBF4uqOoYu7a4qhmhdS7iPgmkD3Td6qr
5hpnEU+Z7YkOZ699zeEDgVMyMkD5f0RjTxBZniwhaJ59hE1jZptygptpvcR+iZRW
BLjGtwn8XG06W4Va4NVtyR7g0RBBFxkJ+bWADqZ4YZ7JhPjJxyBG0CWsgd7wDOy1
14mMoUrETbYwx2r9/Gz10AbR4RDIxo9vOEDC5j0QUEjiIJgLpso=
=bVYi
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
