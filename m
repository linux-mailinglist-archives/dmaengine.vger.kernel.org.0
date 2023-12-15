Return-Path: <dmaengine+bounces-540-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857188148D5
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 14:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A34D285F23
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58EB30346;
	Fri, 15 Dec 2023 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="3r0VeLvc"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABE30333;
	Fri, 15 Dec 2023 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702646031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZDpp4w6x3Qe5YwK/dl5k4LHlomX4XHjxnuuTbRgfVA=;
	b=3r0VeLvc+diNuJCQ549YKzeVipFNByVP6djLsD20mm7iuqlmv/dAO415SlHWgLomrGZejG
	Wu9jBwmb8Fxxu2gYB1V7gcWIoRPEYObosJdkYoLyZGKdMTX6057PnYXEs8zeEDx7zFR2ik
	M7KqINO1qBecKD/eGbLBfbc0X+OVMM8=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/5] dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gather
Date: Fri, 15 Dec 2023 14:13:12 +0100
Message-ID: <20231215131313.23840-5-paul@crapouillou.net>
In-Reply-To: <20231215131313.23840-1-paul@crapouillou.net>
References: <20231215131313.23840-1-paul@crapouillou.net>
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
v2: Make sure cyclic buffers are restarted as well
---
 drivers/dma/dma-axi-dmac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5109530b66de..f63acae511fb 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -411,10 +411,12 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 	if (chan->hw_sg) {
 		if (active->cyclic) {
 			vchan_cyclic_callback(&active->vdesc);
+			start_next = true;
 		} else {
 			list_del(&active->vdesc.node);
 			vchan_cookie_complete(&active->vdesc);
 			active = axi_dmac_active_desc(chan);
+			start_next = !!active;
 		}
 	} else {
 		do {
@@ -1000,6 +1002,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	struct axi_dmac *dmac;
 	struct regmap *regmap;
 	unsigned int version;
+	u32 irq_mask = 0;
 	int ret;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
@@ -1067,7 +1070,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
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


