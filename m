Return-Path: <dmaengine+bounces-366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E5A8035E9
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 15:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770011C20A91
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE725762;
	Mon,  4 Dec 2023 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="sqhSiRUn"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED6106;
	Mon,  4 Dec 2023 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1701698645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EauQ2wrK+wrLp0dftTWFW30qJjPlPW+KVuBL537ybvE=;
	b=sqhSiRUnlnoXtZWveiRp1jISoIWmyTlvKkcLmp5C07pvU84zyl6Q7NTsW13auL+QliM2WW
	9dKbELEL5y50o0nee7w61mwRwS8281vbiyKKMzADxg67OuPkfkADEvvCZGd3aM7S9YYVvl
	ZgkPq4XbNTsdIdVtknno/FA3aKeaRoY=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gather
Date: Mon,  4 Dec 2023 15:03:52 +0100
Message-ID: <20231204140352.30420-5-paul@crapouillou.net>
In-Reply-To: <20231204140352.30420-1-paul@crapouillou.net>
References: <20231204140352.30420-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Instead of notifying userspace in the end-of-transfer (EOT) interrupt
and program the hardware in the start-of-transfer (SOT) interrupt, we
can do both things in the EOT, allowing us to mask the SOT, and halve
the number of interrupts sent by the HDL core.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-axi-dmac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5109530b66de..beed91a8238c 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -415,6 +415,7 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 			list_del(&active->vdesc.node);
 			vchan_cookie_complete(&active->vdesc);
 			active = axi_dmac_active_desc(chan);
+			start_next = !!active;
 		}
 	} else {
 		do {
@@ -1000,6 +1001,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	struct axi_dmac *dmac;
 	struct regmap *regmap;
 	unsigned int version;
+	u32 irq_mask = 0;
 	int ret;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
@@ -1067,7 +1069,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
 
-	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
+	if (dmac->chan.hw_sg)
+		irq_mask |= AXI_DMAC_IRQ_SOT;
+
+	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, irq_mask);
 
 	if (of_dma_is_coherent(pdev->dev.of_node)) {
 		ret = axi_dmac_read(dmac, AXI_DMAC_REG_COHERENCY_DESC);
-- 
2.42.0


