Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF13EAAED
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2019 08:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfJaHVe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Oct 2019 03:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfJaHVd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 31 Oct 2019 03:21:33 -0400
Received: from localhost (unknown [122.178.193.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3FF20873;
        Thu, 31 Oct 2019 07:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572506492;
        bh=qCon8K5Z6WyPR8X++QomshtwrUjQBPIxnj6jAOhAbCI=;
        h=Date:From:To:Cc:Subject:From;
        b=IeYqvRDO4wFmeG0ESpm52u35jFpkXL/RPdo3FqqCOwR3OmMo3DLOENLGQVDrh8XWH
         mPLaDdOLNlq7YPhs/bPedd4fMTPy54IIc8LMGKsK+wveJE0yboF3Fz2EDhzSJ4sWao
         Sj1hduL/TgW/tdfMQ/u7yKpl4/mI5G+D9pyGSsqk=
Date:   Thu, 31 Oct 2019 12:51:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.4-rc6
Message-ID: <20191031072127.GA2695@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive fixes for dmaengine drivers:

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.4-=
rc6

for you to fetch changes up to bacdcb6675e170bb2e8d3824da220e10274f42a7:

  dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle (2019-10-23 2=
1:15:21 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.4-rc6

Few fixes on the dmaengine drivers:
 - fix in sprd driver for link list and potential memory leak
 - tegra transfer failure fix
 - imx size check fix for script_number
 - xilinx fix for 64bit AXIDMA and control reg update
 - qcom bam dma resource leak fix
 - cppi slave transfer fix when idle

----------------------------------------------------------------
Baolin Wang (1):
      dmaengine: sprd: Fix the possible memory leak issue

Jeffrey Hugo (1):
      dmaengine: qcom: bam_dma: Fix resource leak

Radhey Shyam Pandey (2):
      dmaengine: xilinx_dma: Fix 64-bit simple AXIDMA transfer
      dmaengine: xilinx_dma: Fix control reg update in vdma_channel_set_con=
fig

Robin Gong (1):
      dmaengine: imx-sdma: fix size check for sdma script_number

Sameer Pujar (1):
      dmaengine: tegra210-adma: fix transfer failure

Tony Lindgren (1):
      dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle

Zhenfang Wang (1):
      dmaengine: sprd: Fix the link-list pointer register configuration iss=
ue

 drivers/dma/imx-sdma.c                     |  8 ++++++++
 drivers/dma/qcom/bam_dma.c                 | 19 +++++++++++++++++++
 drivers/dma/sprd-dma.c                     | 27 +++++++++++++++++++++++++--
 drivers/dma/tegra210-adma.c                |  7 +++++++
 drivers/dma/ti/cppi41.c                    | 21 ++++++++++++++++++++-
 drivers/dma/xilinx/xilinx_dma.c            | 10 +++++++++-
 include/linux/platform_data/dma-imx-sdma.h |  3 +++
 7 files changed, 91 insertions(+), 4 deletions(-)

Thanks
--=20
~Vinod

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl26i20ACgkQfBQHDyUj
g0cCUxAArqgz1fof/9+JMVr8KP6EtOjU/j0bDqUNIzf+ySVxQaCAkXWI2vHqxRr7
0SoFKQQN0KuxuQyNnExXS7VUG1mFg3x15jauvYY0ZV8V/PZcv/ztqjutYKxDd8s0
XqLQMI4KLE0FF/wRDnFA0FefpnxdxD14/9ae8Bc3zJkhWU2l799jldv/4ORsr0jE
pAenfYxzD7ioVIyxBBiu6nVdvVL2V/3gDSi5MtFIBPAI/aM7aH1yW/HYG+AtBXFY
bpN6vPkP6VTQpRXLCsPK5ENa20/IUpBC39lm7YeLYYfvTYFiCqilKWnh+ijetwOp
2UpJXgpHy2PGLPbct+JyZmrx865yt1fDZxsSXea048EOfz0xR2IPO2pJj9XN9kii
DuUzQ0u87SVtbPSXyqem8xRvgqhuYU1Y+WVUGgp4Z+QOgfMzclH27/OWamkag8/B
rh1baAJ1h0rU/atV+Zjc7G2oODw5oMw6oB0lSTd+Wy7oSjhf2ijnIJxE6Aj1Ra/w
5ry3gXTG0xFDQb/fzoB5idXEyFvwHxJhx+IdsY0YI1zUiBTI5VxtFpwhl2JOhdFA
dSxe2pRLXFI36RH8BjtBYZsQj0JNc839BfWu6s8ulNO7o0VdR2QXHYIACZhUChbA
28gnm74nhtdSB/A5T7sDACAU3RA9EQTQoz4MJazjQIy8k1iQqLE=
=esKd
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
