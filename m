Return-Path: <dmaengine+bounces-107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5192A7EB2CC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080A828124F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0184123A;
	Tue, 14 Nov 2023 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CcEo/VcS"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44064121A
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 14:52:09 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7C9114;
	Tue, 14 Nov 2023 06:52:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27E2B240002;
	Tue, 14 Nov 2023 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699973526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Qhez83D04lqPrphmv+D5bpPc2p/1oEARmA8MsTrJgs=;
	b=CcEo/VcSTQOJAj9E1r+SviFWQrmQe/uQ1bUTGRXUw9tnNqVDTVS/+/DJglKUGWhyKMw+yp
	A6pR4z9sY41YQaqS6CRNz9TL8RmR0ydk2/totJWn2buXEm02HrTmF1ltG4TaLijMqJRcgk
	eYG/nLbq80vgWTi3lbps/oNhtfkoniL99qQswCdpcazDV5aRMDJj+TljqxNYdLssssT6bk
	idFVJVO8ZfiAxG+M94gnFBGqW/rt8VoGvM2vt1F2YDXs/YV+A71VPDk8ROLnuw+DYXX9RK
	sMMRLfPNEVtbbElolJlk0Ae9jHR19PlTmpZncJzfStYDpC6LZ2P3WWn1Jz4AGA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 15:51:58 +0100
Subject: [PATCH v5 5/6] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-feature_hdma_mainline-v5-5-7bc86d83c6f7@bootlin.com>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Cai Huoqing <cai.huoqing@linux.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

The Linked list element and pointer are not stored in the same memory as
the HDMA controller register. If the doorbell register is toggled before
the full write of the linked list a race condition error will occur.
In remote setup we can only use a readl to the memory to assure the full
write has occurred.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Move the sync read in a function.
- Add commments

Changes in v4:
- Update git commit message.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 04b0bcb6ded9..13b6aec6a6de 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -222,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	/*
+	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internals
+	 * configuration registers and Application memory are normally accessed
+	 * over different buses. Ensure LL-data reaches the memory before the
+	 * doorbell register is toggled by issuing the dummy-read from the remote
+	 * LL memory in a hope that the posted MRd TLP will return only after the
+	 * last MWr TLP is completed
+	 */
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chunk->ll_region.vaddr.io);
+}
+
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -252,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+
+	dw_hdma_v0_sync_ll_data(chunk);
+
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }

-- 
2.25.1


