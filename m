Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7D61122
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jul 2019 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfGFOew (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jul 2019 10:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfGFOew (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jul 2019 10:34:52 -0400
Received: from localhost (unknown [49.207.57.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE17620828;
        Sat,  6 Jul 2019 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562423691;
        bh=LuMsXodBcIYO5eNJy1UWIhFx12cvKxOlb5oy7Fbn6K8=;
        h=Date:From:To:Cc:Subject:From;
        b=YJp27jL9evkZ2rCFcpAZRgbPh8U/ewi1VMH6aTN/QGrPYvyGUNFuitS/DJu/J7GM1
         c+OHKldgJpCh2OoBvNfnXmZUc3SP8Ht2hg/NMI8b+uh0OOyyClDatBVzwLm3rg/hEw
         8DDSLGifaCYbSTC3iIFfX/4jcnEEIPPOt++qRHu8=
Date:   Sat, 6 Jul 2019 20:01:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine fixes for 5.2
Message-ID: <20190706143142.GG2911@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Couple for fixes came for dmaengine drivers. One fixes a patch in
5.2-rc1 and others and cced stable.

Please pull to receive:

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.2

for you to fetch changes up to f6034225442c4a87906d36e975fd9e99a8f95487:

  dmaengine: qcom: bam_dma: Fix completed descriptors count (2019-07-05 13:=
18:27 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.2

The fixes for 5.2 are:
 - bam_dma fix for completed descriptor count
 - fix for imx-sdma remove BD_INTR for channel0 and use-after-free on
   probe error path
 - endian bug fix in jz4780 IRQ handler

----------------------------------------------------------------
Dan Carpenter (1):
      dmaengine: jz4780: Fix an endian bug in IRQ handler

Robin Gong (1):
      dmaengine: imx-sdma: remove BD_INTR for channel0

Sricharan R (1):
      dmaengine: qcom: bam_dma: Fix completed descriptors count

Sven Van Asbroeck (1):
      dmaengine: imx-sdma: fix use-after-free on probe error path

 drivers/dma/dma-jz4780.c   |  5 +++--
 drivers/dma/imx-sdma.c     | 52 ++++++++++++++++++++++++++----------------=
----
 drivers/dma/qcom/bam_dma.c |  3 +++
 3 files changed, 35 insertions(+), 25 deletions(-)

Thanks
--=20
~Vinod

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdILDOAAoJEHwUBw8lI4NHHGUQAL9/DG/9ImiN2Hhq1oiUJ6HU
atwOkfsa0/EWKnPPbdlaMHzYdSkCDYFUz7lxf6ASADVYdmvfuc5snDBV5XlAXf5M
CsCBSIZEukdGR+gaXLFctz56udwMxuUCaC/sf//GoY4dHcVA4ObUL14VV9PptnUu
VkgkZA/yVZfrUFDjxl14BTcm2pRZGpDXf4VNgXTWsX01hl3e29L6pIl9NEHprAvU
SXtmEVQlN23xI4foSK6b99LhSbuv2w2zdJqXbdIYrxee0o+Ybo/BCSgBk3Iq3yeu
yFDnknDRGOZ1FUwM4Dz+07oMePoGrEIsaycsXlKVksKXHQVxRB/tBOWbNi9YmiPz
BRq8JSR9XDE7c0iBHWUPPAlgZn+9AikBF7LZ1TX7+tmS2oofcPVCSAcpcZRuRkZ7
N7tFgIhY5cEstiCJTCvdnSIfOd3GQ0vBMd+OKs/XLyiEE/955SimwRuzroctsx4h
xxxwliNy4UgXADzL70ofDw2oiCO+37h9K4FQpApWg1pN4K7POc7V4r/IPiNC8+7X
H/czBZriHbxlMQqsyw9i1KrYX2taU7HZStDqZkV6Qd0IcemgyqLt+DuRUVJZyEU/
HaxWpMH7Iz1fMUnfQIi0f1zGehY4ozoWUzIbARA45JT+xz9f0hfBoiIKsFV0lPM6
IC5/XlSkCqKnMSJ3qZ6j
=zV0F
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
