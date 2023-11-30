Return-Path: <dmaengine+bounces-322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5F7FED96
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E4B281DF7
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C351D3C09A;
	Thu, 30 Nov 2023 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MzRXhGDF"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEEA1B3
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 03:13:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECE76E0002;
	Thu, 30 Nov 2023 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701342797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr9l/ohpsYqUsnTKIffKhuISxG6OBCvmKdftALlQWbg=;
	b=MzRXhGDFx1aKcGw2pj79yJFvsqy0O27rnfTvneb2m0Kgk4OcftiykHGFrrnvcGIx+B6HMC
	jPMNu1aFu4p5SeD/jz8PTqcBiOwpLsLraEHR6PpUyUIBKCeRuFSZLx3ZzHqByoMuAXgMyc
	D6Ju4QWDhBxrsThsK1vaAjcnk4BKMZc1hco92ZPpASlYjIVa7xxU7W5TLn4tuwI8iZj26u
	A8SZVLLx+pRvQMFyHrJxFJ2B3WjYUdBMtFZUY0/NBZtsevD7khGEJEBCJ3qg6RdtYFDF2c
	8LBd/PuO9j1MeeDTlTHJhPY/BeJD2a6v4j4srKIenEQzr4FfGnFr7qnUyj8u3g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michal Simek <monstr@monstr.eu>,
	dmaengine@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 1/4] dmaengine: xilinx: xdma: Fix the count of elapsed periods in cyclic mode
Date: Thu, 30 Nov 2023 12:13:12 +0100
Message-Id: <20231130111315.729430-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130111315.729430-1-miquel.raynal@bootlin.com>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Xilinx DMA engine is capable of keeping track of the number of elapsed
periods and this is an increasing 32-bit counter which is only reset
when turning off the engine. No need to add this value to our local
counter.

Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transfers")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Hello, so far all my testing was performed by looping the playback
output to the recording input and comparing the files using
FFTs. Unfortunately, when the DMA engine suffers from the same issue on
both sides, some issues may appear un-noticed, which is likely what
happened here as the tooling did not report any issue while analyzing
the output until I actually listened to real audio now that I have in my
hands the relevant hardware/connectors to do so.
---
 drivers/dma/xilinx/xdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 84a88029226f..2c9c72d4b5a2 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -754,9 +754,9 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	if (ret)
 		goto out;
 
-	desc->completed_desc_num += complete_desc_num;
-
 	if (desc->cyclic) {
+		desc->completed_desc_num = complete_desc_num;
+
 		ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,
 				  &st);
 		if (ret)
@@ -768,6 +768,8 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 		goto out;
 	}
 
+	desc->completed_desc_num += complete_desc_num;
+
 	/*
 	 * if all data blocks are transferred, remove and complete the request
 	 */
-- 
2.34.1


