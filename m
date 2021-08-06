Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89E33E2C11
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhHFOFu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 10:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234249AbhHFOFM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 10:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A650F61165;
        Fri,  6 Aug 2021 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258696;
        bh=nOeqoZn8UQ9BVEka9KU7+i9GJrN+dCRgqG5/Hc6H2ZQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ni13E3ScKr7FFe64ipHP+3YYYtv/WIZRBAVN6TUVM2b6w/A2sKLvRuEU+7LLrAuqO
         Phiy7gq50V04fG2LzBKZCgYjKUlzWlX+gDy6xXOH5Tgp+2n+VbwOBQSUStbVYCISeE
         SEQjVei2VTXe/SUpxOVO1wCmvrpNTRJCjwOBbqEFAJ1OHPWxem60ZEo2/nGgMEBGu+
         J4phQCVv0TTwWZbTDUy34sDyDQ5cNbpCNGf39VZbXH9E2dwFO90ep8TWZcgAIOPjOZ
         qveZe4xyyWVmsQfV1Fuz8g/h+GBNdPsPSZ/BCskg3vzp7jvtL4RIAFHsdtcb/4fPSk
         2h1L3GO+amhAA==
Date:   Fri, 6 Aug 2021 19:34:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.14
Message-ID: <YQ1BhK0C9utGOOIn@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ETnmIs0C6mvGLkCx"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--ETnmIs0C6mvGLkCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Some odd fixes for dmanegine which icludes couple fo driver fixes.

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.14

for you to fetch changes up to 7199ddede9f0f2f68d41e6928e1c6c4bca9c39c0:

  dmaengine: imx-dma: configure the generic DMA type to make it work (2021-=
08-02 12:31:19 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.14

Bunch of driver fixes, notably:
 - idxd driver fixes for submission race, driver remove sequence, setup
   sequence for MSIXPERM, array index and updating descriptor vector
 - usb-dmac, pm reference leak fix
 - xilinx_dma, read-after-free fix
 - uniphier-xdmac fix for using atomic readl_poll_timeout_atomic()
 - of-dma, router_xlate to return
 - imx-dma, generic dma fix

----------------------------------------------------------------
Adrian Larumbe (1):
      dmaengine: xilinx_dma: Fix read-after-free bug when terminating trans=
fers

Dave Jiang (5):
      dmaengine: idxd: fix array index when int_handles are being used
      dmaengine: idxd: fix setup sequence for MSIXPERM table
      dmaengine: idxd: fix desc->vector that isn't being updated
      dmaengine: idxd: fix sequence for pci driver remove() and shutdown()
      dmaengine: idxd: fix submission race window

Juergen Borleis (1):
      dmaengine: imx-dma: configure the generic DMA type to make it work

Kunihiko Hayashi (1):
      dmaengine: uniphier-xdmac: Use readl_poll_timeout_atomic() in atomic =
state

Peter Ujfalusi (1):
      dmaengine: of-dma: router_xlate to return -EPROBE_DEFER if controller=
 is not yet available

Yu Kuai (1):
      dmaengine: usb-dmac: Fix PM reference leak in usb_dmac_probe()

Zhang Qilong (2):
      dmaengine: stm32-dma: Fix PM usage counter imbalance in stm32 dma ops
      dmaengine: stm32-dmamux: Fix PM usage counter unbalance in stm32 dmam=
ux ops

 drivers/dma/idxd/idxd.h         | 14 +++++++
 drivers/dma/idxd/init.c         | 30 +++++++++-----
 drivers/dma/idxd/irq.c          | 27 ++++++++----
 drivers/dma/idxd/submit.c       | 92 +++++++++++++++++++++++++++++++------=
----
 drivers/dma/idxd/sysfs.c        |  2 -
 drivers/dma/imx-dma.c           |  2 +
 drivers/dma/of-dma.c            |  9 +++-
 drivers/dma/sh/usb-dmac.c       |  2 +-
 drivers/dma/stm32-dma.c         |  4 +-
 drivers/dma/stm32-dmamux.c      |  6 +--
 drivers/dma/uniphier-xdmac.c    |  4 +-
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++
 12 files changed, 151 insertions(+), 53 deletions(-)

Thanks
--=20
~Vinod

--ETnmIs0C6mvGLkCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmENQYQACgkQfBQHDyUj
g0cIcw//bMPu/pjFs/BZ2vvPlvvynJ+Mag4YaPj8HF/Do/ZhqnpnETZGiyh3keP9
YXlnlQDN+HrM5Iu/Re+vpASxx4EP8lZmfnnAhCfF2DhTGIrB5LzkuX9Oxmm/2sqI
eaEtHQzuKwvWnMDuaRRqqvoeJEw/ncxdwsv628nhpnfTlx5UAMOU+vps65rMRtQo
Cwyv7qTLiwzS2CTLmZdRLjKe4S43lupOYTCHw0iyNHGGru0CdQiQq2PSIBrZEFPr
YwWQ56XC5uXemovl67seJSvTz6hjYq2gBXm6iQVxRiGEs1hHt8n8wgcB62+nbHnG
F9ftgRWZor62oDeFO/jcIJm0Wn5b0ShIGwWyPK7R6tR+7VinZMATwnyH1jHdIQMb
4lCiA9HWCuN5sgFo5zGwQEna6yiDISydjHgFvdEs+wDCfsbR6cA5zomwGsr3kTlo
ufbeAHtxMe45p/iFoErPQCX3hBf/3ndvHswouKcIOMATcqa0pWGvG3/EiCksbBPS
lWJAfFiv1Ou9Rhfa2K9fq/XgAw5lsNy5BU1kUnBJ+m0txCskSoy7gRKExJTmwln2
N0MGcKbRjawuD+ppL7AuhBKi6cCTe042IYRTXunfzzfz/Ut2994UfbIgDt6OsknI
GydNmCjnXrGTgg6RuYn8/6lpWFPUVOCrdH1IhVdrFGW7FJBjo70=
=1WuL
-----END PGP SIGNATURE-----

--ETnmIs0C6mvGLkCx--
