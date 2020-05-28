Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1F1E543A
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 04:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgE1Cwz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 22:52:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58408 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgE1Cwz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 22:52:55 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E30FC327;
        Thu, 28 May 2020 04:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590634372;
        bh=c8DHZcY8kYzq4gE998MlyzHTthKIVVoUEcGE7dMIQ5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvt7ZjzGwxoRMM+w7QE+i91qKSN150Ky1vos1n2/n2Tam4Js3MmL2SvuYrUHYmAml
         or2hraFI+tWDs3yWo5Uwtj7oV7uXHhzepG5ZzdLYp9ffeBErDeE67hmYSrClyjJZXU
         qQeowHPziWWG0OQQaeGl7YdjBJ3whW3l4awbEAms=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 3/6] dmaengine: Add support for repeating transactions
Date:   Thu, 28 May 2020 05:52:25 +0300
Message-Id: <20200528025228.31638-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
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

A new DMA_PREP_LOAD_EOT transaction flag is also introduced (with a
corresponding DMA_LOAD_EOT capability bit), as requested during the
review of v4. The flag instructs the DMA channel that the transaction
being queued should replace the active repeated transaction when the
latter terminates (at End Of Transaction). Not setting the flag will
result in the active repeated transaction to continue being repeated,
and the new transaction being silently ignored.

The DMA_PREP_REPEAT flag is currently supported for interleaved
transactions only. Its usage can easily be extended to cover more
transaction types simply by adding an appropriate check in the
corresponding dmaengine_prep_*() function.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v4:

- Add DMA_LOAD_EOT and DMA_PREP_LOAD_EOT flags
---
 include/linux/dmaengine.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 21065c04c4ac..8e3769c2b841 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -61,6 +61,8 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_REPEAT,
+	DMA_LOAD_EOT,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };
@@ -176,6 +178,18 @@ struct dma_interleaved_template {
  * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
  *  data and the descriptor should be in different format from normal
  *  data descriptors.
+ * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
+ *  repeated when it ends if no other transaction has been issued on the same
+ *  channel. If other transactions have been issued, this transaction completes
+ *  normally. This flag is only applicable to interleaved transactions and is
+ *  ignored for all other transaction types.
+ * @DMA_PREP_LOAD_EOT: tell the driver that the transaction shall replaced any
+ *  active repeated (as indicated by DMA_PREP_REPEAT) transaction when the
+ *  repeated transaction terminate. Not setting this flag when the previously
+ *  queued transaction is marked with DMA_PREP_REPEAT will cause the new
+ *  transaction to never be processed and stay in the issued queue forever.
+ *  The flag is ignored if the previous transaction is not a repeated
+ *  transaction.
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -186,6 +200,8 @@ enum dma_ctrl_flags {
 	DMA_PREP_FENCE = (1 << 5),
 	DMA_CTRL_REUSE = (1 << 6),
 	DMA_PREP_CMD = (1 << 7),
+	DMA_PREP_REPEAT = (1 << 8),
+	DMA_PREP_LOAD_EOT = (1 << 9),
 };
 
 /**
@@ -980,6 +996,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
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

