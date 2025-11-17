Return-Path: <dmaengine+bounces-7211-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A489CC6514C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B341352CA9
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495A2C235B;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQgsC16k"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E312C11D6;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=GsGGpPdEFOE23NP5+bSg/TCzT1U//2JgzvI9xZMoI0B6vlk6ho+V/mmG16+Yr5DfD09qdZCa0P9kkote3QwWs098SAuhcsUi5aq+MQBD3YRMYTO7ESrZqzTtDgnA8nJXIqg261fCy28wnci28TpNoAee63qJn25ZgjN2DVC5ga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=xqte167/CtIiIs1bxGMyVe2Cfffz/PRiyeDV54//dVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVEFmyn8PlqvtQgxbgfoyxkikyEUUYJI6GNTvS0lV1haZs/kAPr9et/wdaIqgd9lDebZuIrQUvQNIg8xreA/CyfZmDpxl812h5excitR1Z3gYvGnCynxUc9/K/YTJH65R1dMpXQ4L7qZAhqIx89k/k/lYLcJaiNvPKPjiPuoS+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQgsC16k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54272C4AF09;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=xqte167/CtIiIs1bxGMyVe2Cfffz/PRiyeDV54//dVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQgsC16k8V6Sg/ucP2QIqWr6agZawMt+/N1u9gIP2aQrY1wNwAtMqxVdGwm+87MAT
	 En/J3fuXzlir+xgHP5fIa9FWITpGKOZx8BYfOHSWKVjNUK/7tRlKYu7p9BGvygwzzZ
	 MFxWmTNsDuMwPr01w6/YsuQ3H6YdhXdp6KbpdpvBi+WwLcHDI+oKn4KRIk2P9Gq+pO
	 9Iwk7SiKGMRbg4inIQuicCAbeAb8/Sd4OxDjZTYAF41VCaN4La/MZWNRmNCg2Jzw4F
	 DpZIFfkYcoGOdtnYNDu6KHK/hLp4g9z/QRdwd7F/xzLHbO4J11kaHXEGsHLjJ5hzc5
	 PuX25ssfmY3UQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002nW-1gOj;
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
Subject: [PATCH] dmaengine: ti: k3-udma: enable compile testing
Date: Mon, 17 Nov 2025 17:12:44 +0100
Message-ID: <20251117161258.10679-3-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There does not seem to be anything preventing the K3 UDMA drivers from
being compile tested (on arm64 as one dependency depends on ARM64) so
enable compile testing for wider build coverage.

Note that the ring accelerator dependency can only be selected when
"TI SOC drivers support" (SOC_TI) is enabled so select that option too.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/ti/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index dbf168146d35..cbc30ab62783 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -36,11 +36,12 @@ config DMA_OMAP
 
 config TI_K3_UDMA
 	tristate "Texas Instruments UDMA support"
-	depends on ARCH_K3
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_SCI_PROTOCOL
 	depends on TI_SCI_INTA_IRQCHIP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select SOC_TI
 	select TI_K3_RINGACC
 	select TI_K3_PSIL
         help
@@ -49,7 +50,7 @@ config TI_K3_UDMA
 
 config TI_K3_UDMA_GLUE_LAYER
 	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
-	depends on ARCH_K3
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_K3_UDMA
 	help
 	  Say y here to support the K3 NAVSS DMA glue interface
-- 
2.51.0


