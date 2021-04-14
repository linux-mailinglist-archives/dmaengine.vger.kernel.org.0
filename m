Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAEB35F90C
	for <lists+dmaengine@lfdr.de>; Wed, 14 Apr 2021 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhDNQgD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Apr 2021 12:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhDNQgC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Apr 2021 12:36:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B619F6113B;
        Wed, 14 Apr 2021 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618418140;
        bh=Yk43lQt3xONHQ5mcQacuvBpjQEzfRMYBnN12EuEhqzk=;
        h=Date:From:To:Cc:Subject:From;
        b=HVAjvvZPZg1FGeF0GyMhjlgweFtOfb7q9guzW769W2QEn6562VmynrgyKIkSlkWT2
         0QxzL+A0ZFGMg2vcx6k2eBODIkvh9b6l8cDykhOkTyWDIr43MgGAAh7DkYQahJpgdn
         9yH6/IHvm6h/okRtZz9z88k+ejIWibnqiY6sL7tGx3tMzqALg8ciU8Oj3fZhRgV/vq
         EGBN8H9EIsZFqN38TSGpoipZ9N0pX7z1mui1wolFO30Df+MdWWKYg9/TygQ+1vm8CF
         LJjPloH45rh40HbM/TWcmgP16tNFKYvmgON8yyW1YpxB+at2wnz/SyxXtdn5eEOWgA
         dWVzCsFWR5T1Q==
Date:   Wed, 14 Apr 2021 22:05:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for 5.12
Message-ID: <YHcZ2Kylq+RuDzPg@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RpyAts/MSfBWytVk"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--RpyAts/MSfBWytVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive the fixes for dmaengine for v5.12. Mostly bunch
of driver fixes.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.12

for you to fetch changes up to ea9aadc06a9f10ad20a90edc0a484f1147d88a7a:

  dmaengine: idxd: fix wq cleanup of WQCFG registers (2021-04-12 22:08:39 +=
0530)

----------------------------------------------------------------
dmaengine fixes for v5.12

Couple of dmaengine driver fixes for:
- race and descriptor issue for xilinx driver
- fix interrupt handling, wq state & cleanup, field sizes for
  completion, msix permissions for idxd driver
- rumtim pm fix for tegra driver
- double free fix in dma_async_device_register

----------------------------------------------------------------
Andy Shevchenko (1):
      dmaengine: dw: Make it dependent to HAS_IOMEM

Dan Carpenter (1):
      dmaengine: plx_dma: add a missing put_device() on error path

Dave Jiang (6):
      dmaengine: idxd: Fix clobbering of SWERR overflow bit on writeback
      dmaengine: idxd: fix delta_rec and crc size field for completion reco=
rd
      dmaengine: idxd: fix opcap sysfs attribute output
      dmaengine: idxd: fix wq size store permission state
      dmaengine: idxd: clear MSIX permission entry on shutdown
      dmaengine: idxd: fix wq cleanup of WQCFG registers

Dinghao Liu (1):
      dmaengine: tegra20: Fix runtime PM imbalance on error

Laurent Pinchart (2):
      dmaengine: xilinx: dpdma: Fix descriptor issuing on video group
      dmaengine: xilinx: dpdma: Fix race condition in done IRQ

Lv Yunlong (1):
      dmaengine: Fix a double free in dma_async_device_register

 drivers/dma/dmaengine.c           |  1 +
 drivers/dma/dw/Kconfig            |  2 ++
 drivers/dma/idxd/device.c         | 65 ++++++++++++++++++++++++++++++++---=
----
 drivers/dma/idxd/idxd.h           |  3 ++
 drivers/dma/idxd/init.c           | 11 ++-----
 drivers/dma/idxd/irq.c            |  4 ++-
 drivers/dma/idxd/sysfs.c          | 19 ++++++------
 drivers/dma/plx_dma.c             | 18 ++++++-----
 drivers/dma/tegra20-apb-dma.c     |  4 +--
 drivers/dma/xilinx/xilinx_dpdma.c | 31 +++++++++++--------
 include/uapi/linux/idxd.h         |  4 +--
 11 files changed, 109 insertions(+), 53 deletions(-)

Thanks
--=20
~Vinod

--RpyAts/MSfBWytVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmB3GdcACgkQfBQHDyUj
g0e73xAAh92P0bnd2ehiDqCIgDzQdh/A7neBQIFoJZyW9wT+YabAWpmqQmLdOAPq
d7t5s5yUUW6uKyyRu7pQumCnVrD+dIM+FheXN3QDqqfp4cwxJeEavCTUkL/AhNgE
aclWQozwFdtbzjWqrpTM2+bS7Ef8tFHeOzeXhtfjdsFZztAavtCnAUAhfgNZmB9I
cafm8HWUeUiylsEU1mV3E6cSFLMIlsAImyisS2DYroZbvXqmMOnmnxO/p0524t3F
9BGvTHg8QdEJ73D/PS1s9q4M+9V4E2ZK9yth8RB0n8PUmWARgRr3lNEjDgFLqupS
eppisRYmRruaDscG4mex2javW2hqyJaCF1zXS1fyo3bNR3vdE6Oh8niLEVimozJ6
0+U/z/5jMulWpTkml/eOLIhAOO5gj5u9zwIkoax2jjIYaZH9nF5zEEZbi2WwKkzi
RgA5iSmcLlWWp6DdxCgK6sNsaFL6odr3VF9J/iLOscb7I4MhMMMFKyQr0b3JemVV
fnp+iOX+jjc9nArcfi/8mwB1iJbFSaPzn2I8ZsDEjsWJS1MkYye2b0ZswXOCHALh
6IJLtH6ZmIih+wdBvZRfBMk9lMvuHPq42K+5KctxE93camWM7HLDhIANh7UuANbl
0nWtgbJZeF2DD7goHvp8VqH8PDwKqwjn83wVfKcSosMrIG7W6MU=
=Ka6t
-----END PGP SIGNATURE-----

--RpyAts/MSfBWytVk--
