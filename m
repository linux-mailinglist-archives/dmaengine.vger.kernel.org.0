Return-Path: <dmaengine+bounces-7209-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E285C650E2
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0AD5028A4B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8392C027A;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRb3bUAw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826BE2BEC3A;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396004; cv=none; b=IJJgQW1vlWSqV3e8dTvLlAZel5c27CuEuWOYiSzsCvl9DFtsjaFmBEfELaZJRCE38iB2GZJAtj3+Med09RIfOiPir86NUSidZ1/N8nESHYkYPJrf67grJzHyTQa5CKhmLKMD+ZxYJ9tYCMuQKjeM4SoLZH2zmB3pTwBO8EnhXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396004; c=relaxed/simple;
	bh=sWZH8bLe6UHjk5MWDOzfHe/XfrJyl0iw8wSQvriDWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZl5xNHW83rDKuVWQuOJ7UsGW8NSWspUJ5BAPTh6rkGX7Z7Mt9QP3PPlDWY8tZNTwCUxv9AyLIjMSXKyrW95GgL1tkPGqIX5vDsI9TqeFs3MB2m2/jktCm+KJjSAP6PbH5Xg9K/6N1b2PxUwJXGr9c+Fo8iIi7R/7ie00bPaeac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRb3bUAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E7BC113D0;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=sWZH8bLe6UHjk5MWDOzfHe/XfrJyl0iw8wSQvriDWE0=;
	h=From:To:Cc:Subject:Date:From;
	b=rRb3bUAwWMn6btaPVzGiswlg1GI4fTZy7Iua108ArqcpQoUh1LjsP/87GCvxLBZCW
	 ug1CNdi+9AL+8b1pW/sGrNsr6z95zT4wgWQkGWoGh+Fh4b0r5gNkqQvhkOlj81TJok
	 obKk1X4t52qR2RqSMcDKFcuYec2rBSG8HFbE553a9fSEVT/07AvaQ8IwJZFx7sbwkm
	 U0llAztobqxff0BGqTHwbIkq5vPzW796DEsMXg1/0KI/a9zClrhmTdboIjT1jV1uPv
	 exNUgH24aIoTx7/btSGPCQZXGe52PTqrq5Fv3tP5XYYLrCoVnHWNVG/gGm7fA8EBG9
	 9XSBa0w3nVywA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002nS-0oPu;
	Mon, 17 Nov 2025 17:13:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/15] dmaengine: fix device leaks
Date: Mon, 17 Nov 2025 17:12:42 +0100
Message-ID: <20251117161258.10679-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dmaengine drivers pretty consistently failed to release references
taken when looking up devices using of_find_device_by_node() and similar
helpers.

Included are also two OF node leak fixes and a couple of related
cleanups.

Johan


Johan Hovold (15):
  dmaengine: at_hdmac: fix device leak on of_dma_xlate()
  dmaengine: bcm-sba-raid: fix device leak on probe
  dmaengine: cv1800b-dmamux: fix device leak on route allocation
  dmaengine: dw: dmamux: fix OF node leak on route allocation failure
  dmaengine: idxd: fix device leaks on compat bind and unbind
  dmaengine: lpc18xx-dmamux: fix device leak on route allocation
  dmaengine: lpc32xx-dmamux: fix device leak on route allocation
  dmaengine: sh: rz-dmac: fix device leak on probe failure
  dmaengine: stm32: dmamux: fix device leak on route allocation
  dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
  dmaengine: stm32: dmamux: clean up route allocation error labels
  dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
  dmaengine: ti: dma-crossbar: fix device leak on am335x route
    allocation
  dmaengine: ti: dma-crossbar: clean up dra7x route allocation error
    paths
  dmaengine: ti: k3-udma: fix device leak on udma lookup

 drivers/dma/at_hdmac.c           |  9 ++++++--
 drivers/dma/bcm-sba-raid.c       |  6 +++++-
 drivers/dma/cv1800b-dmamux.c     | 17 +++++++++-------
 drivers/dma/dw/rzn1-dmamux.c     |  4 +++-
 drivers/dma/idxd/compat.c        | 23 +++++++++++++++++----
 drivers/dma/lpc18xx-dmamux.c     | 19 ++++++++++++-----
 drivers/dma/lpc32xx-dmamux.c     | 19 ++++++++++++-----
 drivers/dma/sh/rz-dmac.c         | 13 ++++++++++--
 drivers/dma/stm32/stm32-dmamux.c | 31 +++++++++++++++++-----------
 drivers/dma/ti/dma-crossbar.c    | 35 ++++++++++++++++++--------------
 drivers/dma/ti/k3-udma-private.c |  2 +-
 11 files changed, 123 insertions(+), 55 deletions(-)

-- 
2.51.0


