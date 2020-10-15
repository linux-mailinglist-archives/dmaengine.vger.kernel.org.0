Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4944528EDC1
	for <lists+dmaengine@lfdr.de>; Thu, 15 Oct 2020 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgJOHb5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 03:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgJOHb4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 03:31:56 -0400
Received: from localhost.localdomain (unknown [122.171.209.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049E62224A;
        Thu, 15 Oct 2020 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602747116;
        bh=q6y96Az+Nz8rnTWUROCL2UApIOd860PHpToD4g5tVY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycAx+MeCxuU8C84Mwkn5TTuOB/HO18n93rde5KlresiwZz0fH+SSM9p3cBSUPfoir
         3NbU6FEDjvU9v/W2jxfvGDnrbx4COGFJ6hFzsL6KzA1gHRP/ecn7j8BxWhrok9RcTU
         irjpvkb2LttSNsqG/GVxjpA03ui2sS2yPk1F8m3w=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/4] dmaengine: move APIs in interface to use peripheral term
Date:   Thu, 15 Oct 2020 13:01:31 +0530
Message-Id: <20201015073132.3571684-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015073132.3571684-1-vkoul@kernel.org>
References: <20201015073132.3571684-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dmaengine history has a non inclusive terminology of dmaengine slave, I
feel it is time to replace that.

This moves APIs in dmaengine interface with replacement of slave
to peripheral which is an appropriate term for dmaengine peripheral
devices

Since the change of name can break users, the new names have been added
with old APIs kept as macro define for new names. Once the users have
been migrated, these macros will be dropped.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dmaengine.h | 46 +++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 04b993a5373c..d8dce3cdfdd4 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -923,6 +923,10 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
 		struct dma_chan *chan, unsigned long flags);
 
+	struct dma_async_tx_descriptor *(*device_prep_peripheral_sg)(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context);
 	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -959,8 +963,8 @@ struct dma_device {
 #endif
 };
 
-static inline int dmaengine_slave_config(struct dma_chan *chan,
-					  struct dma_slave_config *config)
+static inline int dmaengine_peripheral_config(struct dma_chan *chan,
+					  struct dma_peripheral_config *config)
 {
 	if (chan->device->device_config)
 		return chan->device->device_config(chan, config);
@@ -968,12 +972,16 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 	return -ENOSYS;
 }
 
-static inline bool is_slave_direction(enum dma_transfer_direction direction)
+#define dmaengine_slave_config dmaengine_peripheral_config
+
+static inline bool is_peripheral_direction(enum dma_transfer_direction direction)
 {
 	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
+#define is_slave_direction is_peripheral_direction
+
+static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_single(
 	struct dma_chan *chan, dma_addr_t buf, size_t len,
 	enum dma_transfer_direction dir, unsigned long flags)
 {
@@ -989,7 +997,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
 						  dir, flags, NULL);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
+#define dmaengine_prep_slave_single dmaengine_prep_peripheral_single
+
+static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_sg(
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
 	enum dma_transfer_direction dir, unsigned long flags)
 {
@@ -1000,6 +1010,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
 						  dir, flags, NULL);
 }
 
+#define dmaengine_prep_slave_sg dmaengine_prep_peripheral_sg
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
@@ -1498,7 +1510,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
 
 void dma_release_channel(struct dma_chan *chan);
-int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
+int dma_get_peripheral_caps(struct dma_chan *chan, struct dma_peripheral_caps *caps);
 #else
 static inline struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)
 {
@@ -1535,19 +1547,21 @@ static inline struct dma_chan *dma_request_chan_by_mask(
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
-static inline int dma_get_slave_caps(struct dma_chan *chan,
-				     struct dma_slave_caps *caps)
+static inline int dma_get_peripheral_caps(struct dma_chan *chan,
+				     struct dma_peripheral_caps *caps)
 {
 	return -ENXIO;
 }
 #endif
 
+#define dma_get_slave_caps dma_get_peripheral_caps
+
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
 {
-	struct dma_slave_caps caps;
+	struct dma_peripheral_caps caps;
 	int ret;
 
-	ret = dma_get_slave_caps(tx->chan, &caps);
+	ret = dma_get_peripheral_caps(tx->chan, &caps);
 	if (ret)
 		return ret;
 
@@ -1592,17 +1606,19 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 
 /* Deprecated, please use dma_request_chan() directly */
 static inline struct dma_chan * __deprecated
-dma_request_slave_channel(struct device *dev, const char *name)
+dma_request_peripheral_channel(struct device *dev, const char *name)
 {
 	struct dma_chan *ch = dma_request_chan(dev, name);
 
 	return IS_ERR(ch) ? NULL : ch;
 }
 
+#define dma_request_slave_channel dma_request_peripheral_channel
+
 static inline struct dma_chan
-*dma_request_slave_channel_compat(const dma_cap_mask_t mask,
-				  dma_filter_fn fn, void *fn_param,
-				  struct device *dev, const char *name)
+*dma_request_peripheral_channel_compat(const dma_cap_mask_t mask,
+				       dma_filter_fn fn, void *fn_param,
+				       struct device *dev, const char *name)
 {
 	struct dma_chan *chan;
 
@@ -1616,6 +1632,8 @@ static inline struct dma_chan
 	return __dma_request_channel(&mask, fn, fn_param, NULL);
 }
 
+#define dma_request_slave_channel_compat dma_request_peripheral_channel_compat
+
 static inline char *
 dmaengine_get_direction_text(enum dma_transfer_direction dir)
 {
-- 
2.26.2

