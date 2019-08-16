Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E2F8FF61
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfHPJrl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Aug 2019 05:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfHPJrl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Aug 2019 05:47:41 -0400
Received: from localhost (unknown [117.99.90.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B172020644;
        Fri, 16 Aug 2019 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565948860;
        bh=YEmxXkiikw9Il4bR7+fmneVfLCggRlkVRGUMcR+NDZQ=;
        h=Date:From:To:Cc:Subject:From;
        b=NS0G69P6qoNzqar+xEdDHce5ghJZrZKLBBwfJ6shhZE7r7okJPs6ef8q4+Pg1es62
         Tvv1B1utASayXblaEE0YdHYGSUNf3yKtLd3DDhjrbIiQtkMjPDxw1deKfWycnIiE24
         cd4gIXxi/U+GG7opGipeV2Rp+1HqkIfz+PuGOfqk=
Date:   Fri, 16 Aug 2019 15:16:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.3-rc5
Message-ID: <20190816094627.GB12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull the fixes for dmaengine drivers as listed below.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.3-=
rc5

for you to fetch changes up to d555c34338cae844b207564c482e5a3fb089d25e:

  omap-dma/omap_vout_vrfb: fix off-by-one fi value (2019-08-09 16:33:41 +05=
30)

----------------------------------------------------------------
dmaengine fixes for v5.3-rc5

Fixes in dmaengine drivers for:
 - dw-edma endianess, _iomem type and stack usages
 - ste_dma40 unneeded variable and null-pointer dereference
 - tegra210-adma unused function
 - omap-dma off-by-one fix

----------------------------------------------------------------
Arnd Bergmann (4):
      dmaengine: dw-edma: fix unnecessary stack usage
      dmaengine: dw-edma: fix __iomem type confusion
      dmaengine: dw-edma: fix endianess confusion
      dmaengine: ste_dma40: fix unneeded variable warning

Hans Verkuil (1):
      omap-dma/omap_vout_vrfb: fix off-by-one fi value

Jia-Ju Bai (1):
      dmaengine: stm32-mdma: Fix a possible null-pointer dereference in stm=
32_mdma_irq_handler()

YueHaibing (1):
      dmaengine: tegra210-adma: Fix unused function warnings

 drivers/dma/dw-edma/dw-edma-core.h           |  2 +-
 drivers/dma/dw-edma/dw-edma-pcie.c           | 18 +++++++--------
 drivers/dma/dw-edma/dw-edma-v0-core.c        | 34 ++++++++++++------------=
----
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c     | 29 ++++++++++++------------
 drivers/dma/ste_dma40.c                      |  4 ++--
 drivers/dma/stm32-mdma.c                     |  2 +-
 drivers/dma/tegra210-adma.c                  |  4 ++--
 drivers/dma/ti/omap-dma.c                    |  4 ++--
 drivers/media/platform/omap/omap_vout_vrfb.c |  3 +--
 9 files changed, 48 insertions(+), 52 deletions(-)

Thanks
--=20
~Vinod

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdVntzAAoJEHwUBw8lI4NHWXQP/2VfNGr1LKUZ4tW4oGEBb4Ea
VsbgWPMSPJ9L2b+Yi/cnElIrf+E7Az8wwAUn+R+JQbwW0FaBGHcp7AUzLelXT+lj
/enlQV4bcMY+M2C3ClD0KmH2BOdtj0O1q8DiVSWU9hQnjZMIIZzdQ5ygjUqZrBEh
sA7b6orb9DD/aSLuRHCJrpF0jT7KczmVEP8uFswr2m83uPsXCTwyWi+KU7Tt9z0U
8vt5rnBTOt9cg1+Wwo95cOPIKqP0Ki16OfE1e17bEbwlb2qmQeYihU+sM1xvsxau
swbpZkdMfjZ8hHokMbGU/MXRdroZZv0QIVrU31Tt/o7vzlOTkfDtPNfMrIQRjSuB
Mp+se62CLbhtdYJSbkqSD+90jaX8a7XP1El4jMOp85E1twlPndVfuBjKl4jLph+5
DABmgmqJNpyaRjUInBDP/OqVNX0t3DnAFgYL1PkB334boMrzYjaYay7A5WFJCtbi
XIZXaTLqPcLaTVU+V9zjoY6eOfxmTXHjZnk3NrE7kEGBMdl3oPItWssn55YkmRMk
S1sMpqH/SPLMplLPG+GuxThyfedQP5BuF+v9xww+W45AcX9l0lKj1AA/50CHyT0j
3uqG4vojjEHBWgnvxAGqp7CAuv1XYoxph75EhpcZwbdjeciSLkrZMbbsx8mawBGP
1NoktcFmFvFC/iNAXu/C
=ikF9
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
