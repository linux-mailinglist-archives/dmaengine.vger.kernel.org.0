Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8CB219152
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2020 22:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGHUTX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jul 2020 16:19:23 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41740 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgGHUTW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jul 2020 16:19:22 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 27A8CFD1;
        Wed,  8 Jul 2020 22:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594239557;
        bh=zadiGrmIK4RPFmXNcRX1aZwa0CtbrTe0VAYQPDiAEkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIivDMLG2i5h5s/z1FBL4xgKJAnpP84oyQuk/4SmkiqpA4ninA5diUXvj5VXIPb6a
         V4qfWvoTp9grwBFIE2ECGuZNYRUurSzzOblArQ4dZkwGbiQ4XGY1b+tVl8k8uw5x2Z
         BKWwirRz6KhP8mQEv/iB7dMshLOZjq1+anBbTSbQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6 3/6] dmaengine: Add support for repeating transactions
Date:   Wed,  8 Jul 2020 23:19:03 +0300
Message-Id: <20200708201906.4546-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
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
Changes since v5:

- Document the API in Documentation/driver-api/dmaengine/
- Small improvements to documentation in header file

Changes since v4:

- Add DMA_LOAD_EOT and DMA_PREP_LOAD_EOT flags
---
 Documentation/driver-api/dmaengine/client.rst |  4 +-
 .../driver-api/dmaengine/provider.rst         | 49 +++++++++++++++++++
 include/linux/dmaengine.h                     | 17 +++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index 2104830a99ae..41938aa2bdeb 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -86,7 +86,9 @@ The details of these operations are:
   - interleaved_dma: This is common to Slave as well as M2M clients. For slave
     address of devices' fifo could be already known to the driver.
     Various types of operations could be expressed by setting
-    appropriate values to the 'dma_interleaved_template' members.
+    appropriate values to the 'dma_interleaved_template' members. Cyclic
+    interleaved DMA transfers are also possible if supported by the channel by
+    setting the DMA_PREP_REPEAT transfer flag.
 
   A non-NULL return of this transfer API represents a "descriptor" for
   the given transaction.
diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 56e5833e8a07..f896acccdfee 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -239,6 +239,27 @@ Currently, the types available are:
     want to transfer a portion of uncompressed data directly to the
     display to print it
 
+- DMA_REPEAT
+
+  - The device supports repeated transfers. A repeated transfer, indicated by
+    the DMA_PREP_REPEAT transfer flag, is similar to a cyclic transfer in that
+    it gets automatically repeated when it ends, but can additionally be
+    replaced by the client.
+
+  - This feature is limited to interleaved transfers, this flag should thus not
+    be set if the DMA_INTERLEAVE flag isn't set. This limitation is based on
+    the current needs of DMA clients, support for additional transfer types
+    should be added in the future if and when the need arises.
+
+- DMA_LOAD_EOT
+
+  - The device supports replacing repeated transfers at end of transfer (EOT)
+    by queuing a new transfer with the DMA_PREP_LOAD_EOT flag set.
+
+  - Support for replacing a currently running transfer at another point (such
+    as end of burst instead of end of transfer) will be added in the future
+    based on DMA clients needs, if and when the need arises.
+
 These various types will also affect how the source and destination
 addresses change over time.
 
@@ -531,6 +552,34 @@ DMA_CTRL_REUSE
     writes for which the descriptor should be in different format from
     normal data descriptors.
 
+- DMA_PREP_REPEAT
+
+  - If set, the transfer will be automatically repeated when it ends until a
+    new transfer is queued on the same channel with the DMA_PREP_LOAD_EOT flag.
+    If the next transfer to be queued on the channel does not have the
+    DMA_PREP_LOAD_EOT flag set, the current transfer will be repeated until the
+    client terminates all transfers.
+
+  - This flag is only supported if the channel reports the DMA_REPEAT
+    capability.
+
+- DMA_PREP_LOAD_EOT
+
+  - If set, the transfer will replace the transfer currently being executed at
+    the end of the transfer.
+
+  - This is the default behaviour for non-repeated transfers, specifying
+    DMA_PREP_LOAD_EOT for non-repeated transfers will thus make no difference.
+
+  - When using repeated transfers, DMA clients will usually need to set the
+    DMA_PREP_LOAD_EOT flag on all transfers, otherwise the channel will keep
+    repeating the last repeated transfer and ignore the new transfers being
+    queued. Failure to set DMA_PREP_LOAD_EOT will appear as if the channel was
+    stuck on the previous transfer.
+
+  - This flag is only supported if the channel reports the DMA_LOAD_EOT
+    capability.
+
 General Design Notes
 ====================
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e1c03339918f..328e3aca7f51 100644
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
@@ -176,6 +178,16 @@ struct dma_interleaved_template {
  * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
  *  data and the descriptor should be in different format from normal
  *  data descriptors.
+ * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
+ *  repeated when it ends until a transaction is issued on the same channel
+ *  with the DMA_PREP_LOAD_EOT flag set. This flag is only applicable to
+ *  interleaved transactions and is ignored for all other transaction types.
+ * @DMA_PREP_LOAD_EOT: tell the driver that the transaction shall replace any
+ *  active repeated (as indicated by DMA_PREP_REPEAT) transaction when the
+ *  repeated transaction ends. Not setting this flag when the previously queued
+ *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
+ *  to never be processed and stay in the issued queue forever. The flag is
+ *  ignored if the previous transaction is not a repeated transaction.
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -186,6 +198,8 @@ enum dma_ctrl_flags {
 	DMA_PREP_FENCE = (1 << 5),
 	DMA_CTRL_REUSE = (1 << 6),
 	DMA_PREP_CMD = (1 << 7),
+	DMA_PREP_REPEAT = (1 << 8),
+	DMA_PREP_LOAD_EOT = (1 << 9),
 };
 
 /**
@@ -980,6 +994,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
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

