Return-Path: <dmaengine+bounces-8081-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 978DACF97DE
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFFB730312F4
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D3337BA2;
	Tue,  6 Jan 2026 16:59:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB5337B8E;
	Tue,  6 Jan 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718770; cv=none; b=hyLtQsaJCBylgY/jF9pdn0+0sY6q+GkOxG+nJUKhurtTCNLQTkDfG1XobpayKdzXBN2l//4P66sGkFsC7bPeYrmE+w4JbXoXsKRF2wv0qCQMO0TINEnut2ftuDm3j0hI/tEE+FCUCgGnyhXpxghS+Qsfvbk2QZRjJvdKiyU+pGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718770; c=relaxed/simple;
	bh=4fW1Mx/sy0Z9zfngc+UpQ9a9Q0C7o3rpe9+gZj5JhpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCXhXlHEl2qrZO+LiDqf2cLqGRrUxQV4lZhBGg+8hsw8ci6YpayreTjG2Rd6tcJ/2yR0DmnDwNxhBBMtM4uetMA6E7VtYOMLbNrLmHdRrWdlWoxAjQERn3pP9LqYlf+/9+Ft615sn6f1MpO0bRRcysr4AL5AC3SX1kJqfT4E2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB4AC16AAE;
	Tue,  6 Jan 2026 16:59:28 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: sh: rz-dmac: Make channel irq local
Date: Tue,  6 Jan 2026 17:59:25 +0100
Message-ID: <312c2e3349f4747e0bca861632bfc3592224b012.1767718556.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The channel IRQ is only used inside the function rz_dmac_chan_probe(),
so there is no need to store it in the rz_dmac_chan structure for later
use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rz-dmac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3087bbd11d59d597..fddeb827452f91cb 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -65,7 +65,6 @@ struct rz_dmac_chan {
 	void __iomem *ch_base;
 	void __iomem *ch_cmn_base;
 	unsigned int index;
-	int irq;
 	struct rz_dmac_desc *desc;
 	int descs_allocated;
 
@@ -800,29 +799,27 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	struct rz_lmdesc *lmdesc;
 	char pdev_irqname[6];
 	char *irqname;
-	int ret;
+	int irq, ret;
 
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
 
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
-	channel->irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (channel->irq < 0)
-		return channel->irq;
+	irq = platform_get_irq_byname(pdev, pdev_irqname);
+	if (irq < 0)
+		return irq;
 
 	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
 	if (!irqname)
 		return -ENOMEM;
 
-	ret = devm_request_threaded_irq(dmac->dev, channel->irq,
-					rz_dmac_irq_handler,
+	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
 					rz_dmac_irq_handler_thread, 0,
 					irqname, channel);
 	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
-			channel->irq, ret);
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
 		return ret;
 	}
 
-- 
2.43.0


