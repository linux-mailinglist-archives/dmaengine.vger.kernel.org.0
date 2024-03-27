Return-Path: <dmaengine+bounces-1553-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF188DAD2
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A545AB24EAD
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14155487B4;
	Wed, 27 Mar 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KrL2YKnb"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B439840;
	Wed, 27 Mar 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533555; cv=none; b=ojvR9LtR/R36lDwpOmYQxCcEJffX0iyIArYJAJtgSpkcaCSwvd61Ai1T4LQXkfLwQoCgJhNIYYeGHiG5Zys/cDjUEm4DYbmN0HKFE5jYfR4opbCac1wAn9Y00r4JMW+UkucA9ohR1qIylHXXf+H/9AH1FeMPnUO+qzl8BH2PLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533555; c=relaxed/simple;
	bh=tAAg740eQ7IlOAqxwVUt+FnDhBsraf8Wz/vF4jDolhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfPKt4O0nARJKQgpxq4QJM7FwMeQ7H/4gAG0gNDS8TrxX31BZ8CEyoIT2lv9VHAiT4TxuSM5OYGxld5AjTseoR+jVtp4sGHax3L66TGvK8DbL6sehb68ERCnQIvhFAV24BJqZoRsyIiZk0qptDRG8BULgx7JQZK2V+b+W1GXLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KrL2YKnb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D40920007;
	Wed, 27 Mar 2024 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711533550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fD9sOUsMc8Jqg8IRAVkvtFQ1xqLl4g/m6Ehzp79ZvKU=;
	b=KrL2YKnbp6PTiFdDWg0S2ONjAPircQgM+PNxXHoyQqJD+0yHWv+gEMov6oCXs+UaBMpuXL
	YreCdd8VZ4rT4j4rQAqoXS68UHgDyrhjJFn617gzxqjX59oadpXl03ZkEvv8inxyvUcCSA
	Pw87YEyJXUhqeB5E7WlJ7cmXUBeYY+AycPrkQ/UgjTsY9pzjavUEHlx06jKZpzLId9yCrN
	icJ9LdSTgpbp5KPZV1qQd4AzBVWGxNYNbQ5TNlnL9EAUpinGZzPqj2cevEcKcTxPGTzs34
	C2ClOyP6MQqQRIjUPCn82ewrV4zASU9hh/F6j01bs1A0hPUHLp0bdBrfy/lJMw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 27 Mar 2024 10:58:49 +0100
Subject: [PATCH 2/3] dmaengine: xilinx: xdma: Fix synchronization issue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com>
References: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
In-Reply-To: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Jan Kuliga <jankul@alatek.krakow.pl>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tAAg740eQ7IlOAqxwVUt+FnDhBsraf8Wz/vF4jDolhM=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA+3sEHyfBZjy1qGVBd85PxD2wQVHGXiv4/AXT2Hd
 I6hI1DGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPt7AAKCRAgrS7GWxAs4kM1EA
 Ci+9mkrXFSOWUajW81HMrAHmczDf8A2ntyeopy0Z37g0I3z7W53rJpj7ybqfFCauOBptuzM9TRZjMb
 Zg3x4cKUX2r9KAgAO9OAEvTNtkDmr8sjWNYUbJpRTg3CzXH80Q/HmrjmAQfR9yfn9H7N3U5h8Txorh
 CR+cogWRfOKCMwW37mSSxhI6Gu/i9HI9mM7uOW5HzB0SxCbfyIi5k0mVTH6CwI9FY5wgUtXEPI1m+M
 odWUpGBi9LbccM7/kTlFalOlRqxXu9EaZMCmqdt0OZ6MtXnBTPFCFSsczYRjbnR1NCA12koAPE33Az
 S0eGZkOnjeDFfDTd6WBqX+ykWzdtbXthLu2PGvJs6BJdrIBaR+mtFcHskKy3X4PREQLlggj9NXe1nT
 kUONpCcqfh7BTYbX+TA8MlfCXSACw2/3K/AnRFdrKjBCA0zV4NRHk1uEG4yhXqs8IfIrV381BvkzjF
 VpOOIXaHnU21MLIAI3YgZIuQlCn+aCreyG6FG9iGmvmghoX0kwOrpx99NoPtaootEAM3y4hCdy1tS1
 ZRaZqA6LrZ4B5DtSyz2Wd2F8YnA971pGq+zMWrBOFDsBdtJdzDeeVM3CVUmKB8/MbsJacnaP11dIzz
 oFK46h+k4VJr1z3RgAZtvESlQoa+l5vGdvES5cqIFMCNPbW680rUrymm9q9g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current xdma_synchronize method does not properly wait for the last
transfer to be done. Due to limitations of the XMDA engine, it is not
possible to stop a transfer in the middle of a descriptor. Said
otherwise, if a stop is requested at the end of descriptor "N" and the OS
is fast enough, the DMA controller will effectively stop immediately.
However, if the OS is slightly too slow to request the stop and the DMA
engine starts descriptor "N+1", the N+1 transfer will be performed until
its end. This means that after a terminate_all, the last descriptor must
remain valid and the synchronization must wait for this last descriptor to
be terminated.

Fixes: 855c2e1d1842 ("dmaengine: xilinx: xdma: Rework xdma_terminate_all()")
Fixes: f5c392d106e7 ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")
Cc: stable@vger.kernel.org
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/dma/xilinx/xdma-regs.h |  3 +++
 drivers/dma/xilinx/xdma.c      | 26 ++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index 98f5f6fb9ff9..6ad08878e938 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -117,6 +117,9 @@ struct xdma_hw_desc {
 			 CHAN_CTRL_IE_WRITE_ERROR |			\
 			 CHAN_CTRL_IE_DESC_ERROR)
 
+/* bits of the channel status register */
+#define XDMA_CHAN_STATUS_BUSY			BIT(0)
+
 #define XDMA_CHAN_STATUS_MASK CHAN_CTRL_START
 
 #define XDMA_CHAN_ERROR_MASK (CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |	\
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index b9788aa8f6b7..5a3a3293b21b 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -71,6 +71,8 @@ struct xdma_chan {
 	enum dma_transfer_direction	dir;
 	struct dma_slave_config		cfg;
 	u32				irq;
+	struct completion		last_interrupt;
+	bool				stop_requested;
 };
 
 /**
@@ -376,6 +378,8 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
 		return ret;
 
 	xchan->busy = true;
+	xchan->stop_requested = false;
+	reinit_completion(&xchan->last_interrupt);
 
 	return 0;
 }
@@ -387,7 +391,6 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
 static int xdma_xfer_stop(struct xdma_chan *xchan)
 {
 	int ret;
-	u32 val;
 	struct xdma_device *xdev = xchan->xdev_hdl;
 
 	/* clear run stop bit to prevent any further auto-triggering */
@@ -395,13 +398,7 @@ static int xdma_xfer_stop(struct xdma_chan *xchan)
 			   CHAN_CTRL_RUN_STOP);
 	if (ret)
 		return ret;
-
-	/* Clear the channel status register */
-	ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 /**
@@ -474,6 +471,8 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
 		xchan->xdev_hdl = xdev;
 		xchan->base = base + i * XDMA_CHAN_STRIDE;
 		xchan->dir = dir;
+		xchan->stop_requested = false;
+		init_completion(&xchan->last_interrupt);
 
 		ret = xdma_channel_init(xchan);
 		if (ret)
@@ -521,6 +520,7 @@ static int xdma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
 
 	xdma_chan->busy = false;
+	xdma_chan->stop_requested = true;
 	vd = vchan_next_desc(&xdma_chan->vchan);
 	if (vd) {
 		list_del(&vd->node);
@@ -542,6 +542,13 @@ static int xdma_terminate_all(struct dma_chan *chan)
 static void xdma_synchronize(struct dma_chan *chan)
 {
 	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
+	struct xdma_device *xdev = xdma_chan->xdev_hdl;
+	int st = 0;
+
+	/* If the engine continues running, wait for the last interrupt */
+	regmap_read(xdev->rmap, xdma_chan->base + XDMA_CHAN_STATUS, &st);
+	if (st & XDMA_CHAN_STATUS_BUSY)
+		wait_for_completion_timeout(&xdma_chan->last_interrupt, msecs_to_jiffies(1000));
 
 	vchan_synchronize(&xdma_chan->vchan);
 }
@@ -876,6 +883,9 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	u32 st;
 	bool repeat_tx;
 
+	if (xchan->stop_requested)
+		complete(&xchan->last_interrupt);
+
 	spin_lock(&xchan->vchan.lock);
 
 	/* get submitted request */

-- 
2.43.0


