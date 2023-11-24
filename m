Return-Path: <dmaengine+bounces-234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C27F7752
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C3E28234B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE02E653;
	Fri, 24 Nov 2023 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mn28l1hd"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1155199B
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 07:09:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2C6D4000A;
	Fri, 24 Nov 2023 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700838564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO52fbsCOZFdHIXi/jDGUrQo9botuIhFbs+S183F+ko=;
	b=mn28l1hdMReN3fjO9JtSoasc9agrAHGsPrpMfFLZ65tzY1kdA0yP89qma7QtK9bjpwV0GN
	I++5pBsrCjCkcnPuS/z8JaErzkmeI9amXHeCHOQIrqbGx2cxUTepXlPsuCbkrCM0Y0W4sC
	1CZ0vpfBVzSdk9msGWbjBXjS4e3NV8QO2OhO0shjEyQk7AjP+WO9KtuIrgWpVe2Jk7VybS
	9XG7oqd/ACYytvZEtWCd1b2/bY80DfQx6onEZu8IAMlYHrWnOeNl4ugY4EeGzXL/EBN6u+
	ELdytyBByAySmDnGKSCDRvN8E3EHI3P2QQhg73lMR5bjLBg1hrUmNsto9a6WnQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/3] dmaengine: xilinx: xdma: Fix the count of elapsed periods in cyclic mode
Date: Fri, 24 Nov 2023 16:09:21 +0100
Message-Id: <20231124150923.257687-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124150923.257687-1-miquel.raynal@bootlin.com>
References: <20231124150923.257687-1-miquel.raynal@bootlin.com>
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
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 84a88029226f..75533e787414 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -754,7 +754,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	if (ret)
 		goto out;
 
-	desc->completed_desc_num += complete_desc_num;
+	desc->completed_desc_num = complete_desc_num;
 
 	if (desc->cyclic) {
 		ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,
-- 
2.34.1


