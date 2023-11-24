Return-Path: <dmaengine+bounces-231-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E297F7753
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA456B212FF
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7352E640;
	Fri, 24 Nov 2023 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PKlUHei4"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08019A2
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 07:09:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E99D40016;
	Fri, 24 Nov 2023 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700838564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdneLdQtosT/1Jsu3ffIIlGLAwKem6GqvHil4BjQ5vY=;
	b=PKlUHei4HMuOdPC0gO0/8wbvWRsY09RLrQZDqljb2e113q5tDn9+FxmwmIQ5c/+VInBJMx
	I6aVp1jNK8rSgZ7wbL0CqcrH/EFq8Roj6YVyfYP9Kw2i0RaqhDMocLuRLS494BMDj7eAhe
	3HyK+0xkERgz5BcC4zAgy/QiheRiV8J9F10RMIPO8Q5PdkjVjoLhBxkWRsUIUaTbZwKgit
	2t7ddWpNADhDKvqNkcXhT6L+nVwZZFlUdfgpmsqm0KSq91rwP8cYAvMKbNuYPR1K2TVJAK
	odyu0trY1JD4etZ8MBRYqvI4M4zbbZuAXrMa9o9wtYUFR8v6KZ/RaZs0FaRITQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/3] dmaengine: xilinx: xdma: Better handling of the busy variable
Date: Fri, 24 Nov 2023 16:09:22 +0100
Message-Id: <20231124150923.257687-3-miquel.raynal@bootlin.com>
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

The driver internal scatter-gather logic is:
- set busy to true
- start transfer
<irq>
- set busy to false
- trigger next transfer if any
  - set busy to true

Setting busy to false in cyclic transfers does not make any sense and is
conceptually wrong. In order to ease the integration of additional
callbacks let's move this change to a scatter-gather-only path.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
---
 drivers/dma/xilinx/xdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 75533e787414..caddd741a79c 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -745,7 +745,6 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	if (!vd)
 		goto out;
 
-	xchan->busy = false;
 	desc = to_xdma_desc(vd);
 	xdev = xchan->xdev_hdl;
 
@@ -768,6 +767,8 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 		goto out;
 	}
 
+	xchan->busy = false;
+
 	/*
 	 * if all data blocks are transferred, remove and complete the request
 	 */
-- 
2.34.1


