Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB81F28EDBF
	for <lists+dmaengine@lfdr.de>; Thu, 15 Oct 2020 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgJOHbx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 03:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgJOHbx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 03:31:53 -0400
Received: from localhost.localdomain (unknown [122.171.209.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2FC22243;
        Thu, 15 Oct 2020 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602747112;
        bh=AKkD2BXKK07zrp+cxaAHKqs3bNw+VIOYZiGxRH5uZa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T10YH1wRp4YoUn8uwvBI9QStgWeHBQGfM6UOrhwU77v8fcg6yXHlvUx2Zw+posdGG
         klKm0wP/6jR2Eq0AB5CtOagxSON0heRjJpH4lWA2K8xeZKGVSsfwsucx+N6cFq+eUG
         Th4a9KUw3NHGnqRgJaaDHIViWiiPEdWC9vvc8v+M=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/4] dmaengine: move enums in interface to use peripheral term
Date:   Thu, 15 Oct 2020 13:01:29 +0530
Message-Id: <20201015073132.3571684-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015073132.3571684-1-vkoul@kernel.org>
References: <20201015073132.3571684-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dmaengine history has a non inclusive terminology of dmaengine slave, I
feel it is time to replace that. Start with moving enums in dmaengine
interface with replacement of slave to peripheral which is an
appropriate term for dmaengine peripheral devices

Since the change of name can break users, the new names have been added
with old enums kept as macro define for new names. Once the users have
been migrated, these macros will be dropped.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dmaengine.h | 44 ++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index dd357a747780..f7f420876d21 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -59,7 +59,7 @@ enum dma_transaction_type {
 	DMA_INTERRUPT,
 	DMA_PRIVATE,
 	DMA_ASYNC_TX,
-	DMA_SLAVE,
+	DMA_PERIPHERAL,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
 	DMA_COMPLETION_NO_ORDER,
@@ -69,12 +69,14 @@ enum dma_transaction_type {
 	DMA_TX_TYPE_END,
 };
 
+#define DMA_SLAVE DMA_PERIPHERAL
+
 /**
  * enum dma_transfer_direction - dma transfer mode and direction indicator
  * @DMA_MEM_TO_MEM: Async/Memcpy mode
- * @DMA_MEM_TO_DEV: Slave mode & From Memory to Device
- * @DMA_DEV_TO_MEM: Slave mode & From Device to Memory
- * @DMA_DEV_TO_DEV: Slave mode & From Device to Device
+ * @DMA_MEM_TO_DEV: Peripheral mode & From Memory to Device
+ * @DMA_DEV_TO_MEM: Peripheral mode & From Device to Memory
+ * @DMA_DEV_TO_DEV: Peripheral mode & From Device to Device
  */
 enum dma_transfer_direction {
 	DMA_MEM_TO_MEM,
@@ -364,22 +366,34 @@ struct dma_chan_dev {
 	int dev_id;
 };
 
+#define	DMA_SLAVE_BUSWIDTH_UNDEFINED	DMA_PERIPHERAL_BUSWIDTH_UNDEFINED
+#define	DMA_SLAVE_BUSWIDTH_1_BYTE	DMA_PERIPHERAL_BUSWIDTH_1_BYTE
+#define	DMA_SLAVE_BUSWIDTH_2_BYTES	DMA_PERIPHERAL_BUSWIDTH_2_BYTES
+#define	DMA_SLAVE_BUSWIDTH_3_BYTES	DMA_PERIPHERAL_BUSWIDTH_3_BYTES
+#define	DMA_SLAVE_BUSWIDTH_4_BYTES	DMA_PERIPHERAL_BUSWIDTH_4_BYTES
+#define	DMA_SLAVE_BUSWIDTH_8_BYTES	DMA_PERIPHERAL_BUSWIDTH_8_BYTES
+#define	DMA_SLAVE_BUSWIDTH_16_BYTES	DMA_PERIPHERAL_BUSWIDTH_16_BYTES
+#define	DMA_SLAVE_BUSWIDTH_32_BYTES	DMA_PERIPHERAL_BUSWIDTH_32_BYTES
+#define	DMA_SLAVE_BUSWIDTH_64_BYTES	DMA_PERIPHERAL_BUSWIDTH_64_BYTES
+
 /**
- * enum dma_slave_buswidth - defines bus width of the DMA slave
+ * enum dma_peripheral_buswidth - defines bus width of the DMA peripheral
  * device, source or target buses
  */
-enum dma_slave_buswidth {
-	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
-	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
-	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
-	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
-	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
-	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
-	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
-	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
-	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
+enum dma_peripheral_buswidth {
+	DMA_PERIPHERAL_BUSWIDTH_UNDEFINED = 0,
+	DMA_PERIPHERAL_BUSWIDTH_1_BYTE = 1,
+	DMA_PERIPHERAL_BUSWIDTH_2_BYTES = 2,
+	DMA_PERIPHERAL_BUSWIDTH_3_BYTES = 3,
+	DMA_PERIPHERAL_BUSWIDTH_4_BYTES = 4,
+	DMA_PERIPHERAL_BUSWIDTH_8_BYTES = 8,
+	DMA_PERIPHERAL_BUSWIDTH_16_BYTES = 16,
+	DMA_PERIPHERAL_BUSWIDTH_32_BYTES = 32,
+	DMA_PERIPHERAL_BUSWIDTH_64_BYTES = 64,
 };
 
+#define dma_slave_buswidth dma_peripheral_buswidth
+
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
-- 
2.26.2

