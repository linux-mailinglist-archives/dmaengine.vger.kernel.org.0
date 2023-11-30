Return-Path: <dmaengine+bounces-324-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49267FED99
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 12:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE2CB21049
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672D3C09E;
	Thu, 30 Nov 2023 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q8UHR8wp"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8067D54
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 03:13:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5DD6E000B;
	Thu, 30 Nov 2023 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701342798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XClNDtyud7j7WgjvCaT6bz7tPpueCUv3M+YJKIhqVZU=;
	b=Q8UHR8wpehZGD+c07ORJulu8+guUSHLgAAZ1FiFV7KzzZN2rGHDL5OeMIf7UqG9ix+/LOs
	gdp0amtwKHCBI8S15LN6jxXGqTq7zCRyTXhGdYCEU/sxqUalAPNt4mt9hhhX+lPWngYcVr
	lZ/e0F3refEP5/qe5fb62M7lE9VyWvH6msZ/kh/UMeADV8lN4X2EpleAtAd3QdSHRd1kBL
	qRtzUaMs17Pbt/VFOoeI4owLFpe3eBKREShiKXHJsRx+Pg3GWYtdd3niHsdDOUQTJYBDyL
	Aa5Wd6K5Qa49KYRofIE79ggkUGrH8XVcT40Nm4r8O2SudrzbYJ3gtjfzpGhNWg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michal Simek <monstr@monstr.eu>,
	dmaengine@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/4] dmaengine: xilinx: xdma: Clarify the logic between cyclic/sg modes
Date: Thu, 30 Nov 2023 12:13:13 +0100
Message-Id: <20231130111315.729430-3-miquel.raynal@bootlin.com>
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

We support both modes, but they perform totally different taks in the
interrupt handler. Clarify what shall be done in each case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/xilinx/xdma.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 2c9c72d4b5a2..4efef1b5f89c 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -765,26 +765,23 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 		regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_STATUS, st);
 
 		vchan_cyclic_callback(vd);
-		goto out;
-	}
-
-	desc->completed_desc_num += complete_desc_num;
+	} else {
+		desc->completed_desc_num += complete_desc_num;
 
-	/*
-	 * if all data blocks are transferred, remove and complete the request
-	 */
-	if (desc->completed_desc_num == desc->desc_num) {
-		list_del(&vd->node);
-		vchan_cookie_complete(vd);
-		goto out;
-	}
+		/* if all data blocks are transferred, remove and complete the request */
+		if (desc->completed_desc_num == desc->desc_num) {
+			list_del(&vd->node);
+			vchan_cookie_complete(vd);
+			goto out;
+		}
 
-	if (desc->completed_desc_num > desc->desc_num ||
-	    complete_desc_num != XDMA_DESC_BLOCK_NUM * XDMA_DESC_ADJACENT)
-		goto out;
+		if (desc->completed_desc_num > desc->desc_num ||
+		    complete_desc_num != XDMA_DESC_BLOCK_NUM * XDMA_DESC_ADJACENT)
+			goto out;
 
-	/* transfer the rest of data (SG only) */
-	xdma_xfer_start(xchan);
+		/* transfer the rest of data */
+		xdma_xfer_start(xchan);
+	}
 
 out:
 	spin_unlock(&xchan->vchan.lock);
-- 
2.34.1


