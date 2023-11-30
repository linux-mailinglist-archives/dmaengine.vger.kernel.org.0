Return-Path: <dmaengine+bounces-325-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2733B7FED9A
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA32B21078
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5053C475;
	Thu, 30 Nov 2023 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EOaQ/YOT"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593CED66
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 03:13:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EE65E000E;
	Thu, 30 Nov 2023 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701342799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8VXs0i35kKTRXex7h+fTtLNSteHQdcsxDHFDj7VLIA=;
	b=EOaQ/YOT7w6JPe1KPaOJDduIloEBJTVTL8nbud2X5EXTlxPHZ5rAMmJh1FRU3DfU/hfEAz
	AS4ux0xX2fMwcV3zTW6SOuqtP+hehQwHAzL29IBcyHJOC0CXyyFSlbfeiFXh9xolYXEOux
	OjUjin9aRED3OU4Fkj1nZxEdmvDY1leW+mrk9Mbyydixm+cgCaEihy/5yJ/2XjsUy7OgHZ
	TCArMKdbDl0xKtHwAB0z/WJUxHepDaAzcIMAoA/BhobpNiiTmTR8OUo/VHDZlKj6berm+K
	7bTFUhIJk8OqGDOnLWS5X2xLqp96qCUm4Us6VRwzQpDwDBEaeNawl2X7Nixn0A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michal Simek <monstr@monstr.eu>,
	dmaengine@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 3/4] dmaengine: xilinx: xdma: Better handling of the busy variable
Date: Thu, 30 Nov 2023 12:13:14 +0100
Message-Id: <20231130111315.729430-4-miquel.raynal@bootlin.com>
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

The driver internal scatter-gather logic is:
* set busy to true
* start transfer
<irq>
  * set busy to false
  * trigger next transfer if any
    * set busy to true
</irq>

Setting busy to false in cyclic transfers does not make any sense and is
conceptually wrong. In order to ease the integration of additional
callbacks let's move this change to the scatter-gather path.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 4efef1b5f89c..e931ff42209c 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -745,7 +745,6 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	if (!vd)
 		goto out;
 
-	xchan->busy = false;
 	desc = to_xdma_desc(vd);
 	xdev = xchan->xdev_hdl;
 
@@ -766,6 +765,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 
 		vchan_cyclic_callback(vd);
 	} else {
+		xchan->busy = false;
 		desc->completed_desc_num += complete_desc_num;
 
 		/* if all data blocks are transferred, remove and complete the request */
-- 
2.34.1


