Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E58442011
	for <lists+dmaengine@lfdr.de>; Mon,  1 Nov 2021 19:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhKASeO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Nov 2021 14:34:14 -0400
Received: from neon-v2.ccupm.upm.es ([138.100.198.70]:46231 "EHLO
        neon-v2.ccupm.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhKASeL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Nov 2021 14:34:11 -0400
Received: from localhost.localdomain (62-3-70-206.dsl.in-addr.zen.co.uk [62.3.70.206] (may be forged))
        (user=adrianml@alumnos.upm.es mech=LOGIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 1A1I8fSP016585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 1 Nov 2021 18:08:54 GMT
From:   Adrian Larumbe <adrianml@alumnos.upm.es>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Adrian Larumbe <adrianml@alumnos.upm.es>
Subject: [PATCH 2/3] dmaengine: Add core function and capability check for DMA_MEMCPY_SG
Date:   Mon,  1 Nov 2021 18:08:24 +0000
Message-Id: <20211101180825.241048-3-adrianml@alumnos.upm.es>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101180825.241048-1-adrianml@alumnos.upm.es>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20211101180825.241048-1-adrianml@alumnos.upm.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is the old DMA_SG interface that was removed in commit
c678fa66341c ("dmaengine: remove DMA_SG as it is dead code in kernel"). It
has been renamed to DMA_MEMCPY_SG to better match the MEMSET and MEMSET_SG
naming convention.

It should only be used for mem2mem copies, either main system memory or
CPU-addressable device memory (like video memory on a PCI graphics card).

Bringing back this interface was prompted by the need to use the Xilinx
CDMA device for mem2mem SG transfers.

Signed-off-by: Adrian Larumbe <adrianml@alumnos.upm.es>
---
 drivers/dma/dmaengine.c   |  7 +++++++
 include/linux/dmaengine.h | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index d9f7c097cfd6..2cfa8458b51b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1159,6 +1159,13 @@ int dma_async_device_register(struct dma_device *device)
 		return -EIO;
 	}
 
+	if (dma_has_cap(DMA_MEMCPY_SG, device->cap_mask) && !device->device_prep_dma_memcpy_sg) {
+		dev_err(device->dev,
+			"Device claims capability %s, but op is not defined\n",
+			"DMA_MEMCPY_SG");
+		return -EIO;
+	}
+
 	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dma_xor) {
 		dev_err(device->dev,
 			"Device claims capability %s, but op is not defined\n",
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9000f3ffce8b..554a86665de9 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -50,6 +50,7 @@ enum dma_status {
  */
 enum dma_transaction_type {
 	DMA_MEMCPY,
+	DMA_MEMCPY_SG,
 	DMA_XOR,
 	DMA_PQ,
 	DMA_XOR_VAL,
@@ -891,6 +892,11 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
 		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 		size_t len, unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy_sg)(
+		struct dma_chan *chan,
+		struct scatterlist *dst_sg, unsigned int dst_nents,
+		struct scatterlist *src_sg, unsigned int src_nents,
+		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
 		struct dma_chan *chan, dma_addr_t dst, dma_addr_t *src,
 		unsigned int src_cnt, size_t len, unsigned long flags);
@@ -1051,6 +1057,20 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(
+		struct dma_chan *chan,
+		struct scatterlist *dst_sg, unsigned int dst_nents,
+		struct scatterlist *src_sg, unsigned int src_nents,
+		unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_dma_memcpy_sg)
+		return NULL;
+
+	return chan->device->device_prep_dma_memcpy_sg(chan, dst_sg, dst_nents,
+						       src_sg, src_nents,
+						       flags);
+}
+
 static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
 		enum dma_desc_metadata_mode mode)
 {
-- 
2.33.1

