Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1E1D1BB6
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbgEMQ76 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 12:59:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37070 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389737AbgEMQ76 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 12:59:58 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8018FD9D;
        Wed, 13 May 2020 18:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1589389195;
        bh=+hbbt2PHJ4Bzx/QCeWIifwTcciMvD8u7nzUKHpowWsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEEu895nu+XDUEBY4D5dItbEINeImKU7ZbLmnNr3+jSTMAObEvHgs1zYV9uMhQM5t
         3GkPNlS63639nDiN44WlbxNTcAeJOaqQeEzqWDs0n/UY50HmDY17Sd8krPIiY/qO1P
         8MZM3TrZDpdyiRhQ3ZcjZUOnuPvSzyPACQDtq000=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 3/6] dmaengine: Add support for repeating transactions
Date:   Wed, 13 May 2020 19:59:40 +0300
Message-Id: <20200513165943.25120-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA engines used with displays perform 2D interleaved transfers to read
framebuffers from memory and feed the data to the display engine. As the
same framebuffer can be displayed for multiple frames, the DMA
transactions need to be repeated until a new framebuffer replaces the
current one. This feature is implemented natively by some DMA engines
that have the ability to repeat transactions and switch to a new
transaction at the end of a transfer without any race condition or frame
loss.

This patch implements support for this feature in the DMA engine API. A
new DMA_PREP_REPEAT transaction flag allows DMA clients to instruct the
DMA channel to repeat the transaction automatically until one or more
new transactions are issued on the channel (or until all active DMA
transfers are explicitly terminated with the dmaengine_terminate_*()
functions). A new DMA_REPEAT transaction type is also added for DMA
engine drivers to report their support of the DMA_PREP_REPEAT flag.

The DMA_PREP_REPEAT flag is currently supported for interleaved
transactions only. Its usage can easily be extended to cover more
transaction types simply by adding an appropriate check in the
corresponding dmaengine_prep_*() function.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
If this approach is accepted I can send a new version that updates
documentation in Documentation/driver-api/dmaengine/, and extend support
of DMA_PREP_REPEAT to the other transaction types, if desired already.

 include/linux/dmaengine.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 64461fc64e1b..9fa00bdbf583 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -61,6 +61,7 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_REPEAT,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };
@@ -176,6 +177,11 @@ struct dma_interleaved_template {
  * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
  *  data and the descriptor should be in different format from normal
  *  data descriptors.
+ * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
+ *  repeated when it ends if no other transaction has been issued on the same
+ *  channel. If other transactions have been issued, this transaction completes
+ *  normally. This flag is only applicable to interleaved transactions and is
+ *  ignored for all other transaction types.
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -186,6 +192,7 @@ enum dma_ctrl_flags {
 	DMA_PREP_FENCE = (1 << 5),
 	DMA_CTRL_REUSE = (1 << 6),
 	DMA_PREP_CMD = (1 << 7),
+	DMA_PREP_REPEAT = (1 << 8),
 };
 
 /**
@@ -967,6 +974,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 {
 	if (!chan || !chan->device || !chan->device->device_prep_interleaved_dma)
 		return NULL;
+	if (flags & DMA_PREP_REPEAT &&
+	    !test_bit(DMA_REPEAT, chan->device->cap_mask.bits))
+		return NULL;
 
 	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
 }
-- 
Regards,

Laurent Pinchart

