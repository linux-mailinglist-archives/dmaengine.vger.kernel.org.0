Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFA17A194
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2020 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgCEInL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Mar 2020 03:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgCEInL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Mar 2020 03:43:11 -0500
Received: from localhost (unknown [106.201.121.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC77208CD;
        Thu,  5 Mar 2020 08:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583397790;
        bh=DlwmQmp/mwTHAZamG/vOYPxGoDK0+BIIYn++idLjXr0=;
        h=Date:From:To:Cc:Subject:From;
        b=vviui3Qi8EmVg7dqGtudm4TC9foxyWMckpMTaeH7SSSR/qAvhyhjoo8jBqnYg3mS/
         kPD3BxJB7lbH9fEGi0hTwyDoQFjfPROsfy5bVvUeMf4oNrdzMUg3wpWpclSppfNv4p
         tpKuTNFJLvNog4CkdJPO5664dy4i70m3ahm9UIxo=
Date:   Thu, 5 Mar 2020 14:13:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.6-rc5
Message-ID: <20200305084304.GY4148@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive fixes for dmaengine.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.6-=
rc5

for you to fetch changes up to 25962e1a7f1d522f1b57ead2f266fab570042a70:

  dmaengine: imx-sdma: Fix the event id check to include RX event for UART6=
 (2020-02-25 14:15:26 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.6-rc5

Bunch of driver fixes:
 - Doc updates to clean warnings for dmaengine
 - Fixes for newly added Intel idxd driver
 - More fixes for newly added TI k3-udma driver
 - Fixes for IMX and Tegra drivers.

----------------------------------------------------------------
Changbin Du (1):
      dmaengine: doc: fix warnings/issues of client.rst

Dan Carpenter (2):
      dmaengine: idxd: Fix error handling in idxd_wq_cdev_dev_setup()
      dmaengine: coh901318: Fix a double lock bug in dma_tc_handle()

Dave Jiang (4):
      dmaengine: idxd: fix runaway module ref count on device driver bind
      dmaengine: idxd: correct reserved token calculation
      dmaengine: idxd: sysfs input of wq incorrect wq type should return er=
ror
      dmaengine: idxd: wq size configuration needs to check global max size

Dmitry Osipenko (2):
      dmaengine: tegra-apb: Fix use-after-free
      dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list

Frieder Schrempf (1):
      dmaengine: imx-sdma: Fix the event id check to include RX event for U=
ART6

Martin Fuzzey (1):
      dmaengine: imx-sdma: fix context cache

Peter Ujfalusi (5):
      dmaengine: ti: k3-udma: Workaround for RX teardown with stale data in=
 peer
      dmaengine: ti: k3-udma: Move the TR counter calculation to helper fun=
ction
      dmaengine: ti: k3-udma: Use the TR counter helper for slave_sg and cy=
clic
      dmaengine: ti: k3-udma: Use the channel direction in pause/resume fun=
ctions
      dmaengine: ti: k3-udma: Fix terminated transfer handling

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma: Use ktime/usleep_range based TX completion ch=
eck

 Documentation/driver-api/dmaengine/client.rst |  14 +-
 drivers/dma/coh901318.c                       |   4 -
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/dma/idxd/sysfs.c                      |  27 +-
 drivers/dma/imx-sdma.c                        |   5 +-
 drivers/dma/tegra20-apb-dma.c                 |   6 +-
 drivers/dma/ti/k3-udma.c                      | 493 +++++++++++++++++++---=
----
 7 files changed, 400 insertions(+), 153 deletions(-)

Thanks
--=20
~Vinod

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl5gu5IACgkQfBQHDyUj
g0fdZRAAiryLPp2bODYPcHDiJjdfWr3teNjTpcFn84VaAfR6GwOSnTyVA3o84VtV
JCJtDRc9SJKqCcUiQ9n2vgyIpJKTQra8LxoeodPyCbNBmS1q1+Jr3qzBZ1PM43ir
DmTDmrGkkqHvcvJYYi74ADTQ8JWA5r8EJTFSsmhocEuGpOM8I8yUikD2iQu+YoBd
T9aj2HtwUpjiWfx+mz+z+ISGcNXr2e2tzwY1XUvKAWt8A9c+7pDvB6jbS78siSAQ
jNujLED8HkcAZdCszgOg6iRG2B3LBmc/ds7O8UT0sz0I4dPsXdl2CYbe897K17q+
Mu3PBw7Is9K8n4bD89PMv39O5PAa10fcA3Iv2oAWrfouFZehCpBJIaqlz8ngx6MN
2yZefR5wkgUgITN1AtT5uakqTOek59UGcUR5GY0U8IeOMreVRw+m5I0d3q2hG1bi
+Z2T+KYyvdlc8yvsn9KoIMxW7AE77CaMlCmETqUrxL+/VoUXR9BoiLRqxcYjDFgy
5+WDyAbFDZxIkAG1ES7kM+muvI4GO7frlssu0qwY9J2zH8zdOtiWymP//p/MSV9+
F6/CX+HVzMRILCwV73xB9V+F2m/pnCI5qRXyy0FsNuGwzgSuy3TprOZHJS/M2VyG
J1FRox7eeUNociqoswliGhXmV4ttpGPjih/cv1DHVvHJgf9Wi+A=
=zhDQ
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
