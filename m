Return-Path: <dmaengine+bounces-541-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3558148D8
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 14:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4741F249D0
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E830D0C;
	Fri, 15 Dec 2023 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DIiMSFMx"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44693065B;
	Fri, 15 Dec 2023 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702646031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAeMuIy1XyR2uI2Lp4H2je64QseMIBGkzrSyKbKGd4Y=;
	b=DIiMSFMxTT1aXlDXsy/PFjuLsM+XpoHYg0O5x93fbK0H4ObtJC8KMmoG5cWrdP7CLuV480
	S8lKlFIBKgMSWMsyyCDK0whoT0VT03xXOTmqvGWPh3Z1LLgqLy5DfaF0oe8XdNfIl+nw6X
	aD/W6o2E4+ikDbHVRK0jH8lN3mUCMko=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/5] dmaengine: axi-dmac: Improve cyclic DMA transfers in SG mode
Date: Fri, 15 Dec 2023 14:13:13 +0100
Message-ID: <20231215131313.23840-6-paul@crapouillou.net>
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

For cyclic transfers, chain the last descriptor to the first one, and
disable IRQ generation if there is no callback registered with the
cyclic transfer.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v2: New patch
---
 drivers/dma/dma-axi-dmac.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f63acae511fb..4e339c04fc1e 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -285,12 +285,14 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 
 	/*
 	 * If the hardware supports cyclic transfers and there is no callback to
-	 * call and only a single segment, enable hw cyclic mode to avoid
-	 * unnecessary interrupts.
+	 * call, enable hw cyclic mode to avoid unnecessary interrupts.
 	 */
-	if (chan->hw_cyclic && desc->cyclic && !desc->vdesc.tx.callback &&
-		desc->num_sgs == 1)
-		flags |= AXI_DMAC_FLAG_CYCLIC;
+	if (chan->hw_cyclic && desc->cyclic && !desc->vdesc.tx.callback) {
+		if (chan->hw_sg)
+			desc->sg[desc->num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_IRQ;
+		else if (desc->num_sgs == 1)
+			flags |= AXI_DMAC_FLAG_CYCLIC;
+	}
 
 	if (chan->hw_partial_xfer)
 		flags |= AXI_DMAC_FLAG_PARTIAL_REPORT;
@@ -411,7 +413,6 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 	if (chan->hw_sg) {
 		if (active->cyclic) {
 			vchan_cyclic_callback(&active->vdesc);
-			start_next = true;
 		} else {
 			list_del(&active->vdesc.node);
 			vchan_cookie_complete(&active->vdesc);
@@ -667,7 +668,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
 {
 	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
 	struct axi_dmac_desc *desc;
-	unsigned int num_periods, num_segments;
+	unsigned int num_periods, num_segments, num_sgs;
 
 	if (direction != chan->direction)
 		return NULL;
@@ -681,11 +682,16 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
 
 	num_periods = buf_len / period_len;
 	num_segments = DIV_ROUND_UP(period_len, chan->max_length);
+	num_sgs = num_periods * num_segments;
 
-	desc = axi_dmac_alloc_desc(chan, num_periods * num_segments);
+	desc = axi_dmac_alloc_desc(chan, num_sgs);
 	if (!desc)
 		return NULL;
 
+	/* Chain the last descriptor to the first, and remove its "last" flag */
+	desc->sg[num_sgs - 1].hw->next_sg_addr = desc->sg[0].hw_phys;
+	desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
+
 	axi_dmac_fill_linear_sg(chan, direction, buf_addr, num_periods,
 		period_len, desc->sg);
 
-- 
2.42.0


