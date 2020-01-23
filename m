Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F04B1460BC
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 03:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAWCaD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 21:30:03 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59068 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgAWCaD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jan 2020 21:30:03 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BB4D9C2;
        Thu, 23 Jan 2020 03:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579746600;
        bh=mw7rfcZjYlgNDtZIDmgGI7XjMY4QNyPE/raHuj89oTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uc0ljCJFOL09aRg9uU6hh1JnlgJLcL4u843REzgSyHt3NgafiUiQ2hoMLHXj+dluT
         sDk9WH7qSk0yFiUxhqIUfTcQgo282O0kTTMUnEwDfGfIrIoZmmzad+dkKTQaRotq6j
         JXw+mot/xq2T4nG3vFU0bvx7PmQtsQyn8PHllcAc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Date:   Thu, 23 Jan 2020 04:29:35 +0200
Message-Id: <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The new interleaved cyclic transaction type combines interleaved and
cycle transactions. It is designed for DMA engines that back display
controllers, where the same 2D frame needs to be output to the display
until a new frame is available.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/dmaengine.c   |  8 +++++++-
 include/linux/dmaengine.h | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 03ac4b96117c..4ffb98a47f31 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -981,7 +981,13 @@ int dma_async_device_register(struct dma_device *device)
 			"DMA_INTERLEAVE");
 		return -EIO;
 	}
-
+	if (dma_has_cap(DMA_INTERLEAVE_CYCLIC, device->cap_mask) &&
+	    !device->device_prep_interleaved_cyclic) {
+		dev_err(device->dev,
+			"Device claims capability %s, but op is not defined\n",
+			"DMA_INTERLEAVE_CYCLIC");
+		return -EIO;
+	}
 
 	if (!device->device_tx_status) {
 		dev_err(device->dev, "Device tx_status is not defined\n");
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8fcdee1c0cf9..e9af3bf835cb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -61,6 +61,7 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_INTERLEAVE_CYCLIC,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };
@@ -701,6 +702,10 @@ struct dma_filter {
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
+ * @device_prep_interleaved_cyclic: prepares an interleaved cyclic transfer.
+ *	This is similar to @device_prep_interleaved_dma, but the transfer is
+ *	repeated until a new transfer is issued. This transfer type is meant
+ *	for display.
  * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
  *	code
@@ -785,6 +790,9 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_interleaved_cyclic)(
+		struct dma_chan *chan, struct dma_interleaved_template *xt,
+		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
@@ -880,6 +888,16 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_cyclic(
+		struct dma_chan *chan, struct dma_interleaved_template *xt,
+		unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_interleaved_cyclic)
+		return NULL;
+
+	return chan->device->device_prep_interleaved_cyclic(chan, xt, flags);
+}
+
 static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
 		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
 		unsigned long flags)
-- 
Regards,

Laurent Pinchart

