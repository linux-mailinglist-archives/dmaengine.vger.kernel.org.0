Return-Path: <dmaengine+bounces-3657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7359B7AA6
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 13:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25BB1C2211F
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A019CC1F;
	Thu, 31 Oct 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="NjxvLIEG"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8B19C567;
	Thu, 31 Oct 2024 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378163; cv=none; b=r4kltV/XW2fA4bKPS8ig4tzWDh3TvYFfVKuWi6nAyj5wqz/QG7cWyqw+MLy8Pol22wfzw0Aihm+DbSzbd7JzHHw0akCKTPFOPKJIK9r6UeT3SWnhbhbj2SOf5pMhbYUi2WqeCfgpvMFhkb+QdQ8ohAJy3D5pVrxpjpTl0JcRQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378163; c=relaxed/simple;
	bh=rlT2DPWfdxZcYFjIBa/WQeWWhpaYtrcCeHY85Lo4sTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EvGvVIluZs3gwX9EwsmaEA9Dih/xchiJ6cPYdcBfAWkQVgetPQSdK6gsiO54PDwMgH7PjLRwdgzzRBkv1mDCzrvKJIrod3mITHIq8kEXrQmJZnryweIBXpvnD0MFf38puFIYua032IfwbJfwxIGtTWCZL2lw+QC+lWKq8HxFrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=NjxvLIEG; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 11C92A0E19;
	Thu, 31 Oct 2024 13:35:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=v2RgTF8D7wajG55pSlawfkLKs/fqiaH4u0qyD0R2ays=; b=
	NjxvLIEGLyqRtnwLLN0JyocFrQJUakJHFioBpC8qMH+dGs92oKqGAKxaLhVqffFa
	S30YD8cIGlZetsm+tF8TSnTaO3ZNyv+yfixeCZQSy3VXV0ghPCatrme8MM+/UVQl
	v6cAXY0wx5BErwEcQvGAfbshwfiBYENGRfJrS/EGEympnU+BvMqDNsx2a0lKtMeZ
	xDsXiH3UlEqqr9F03M61TnTeGxYj5yNNQGJtwRy/9lVU5DCnquYSToRAf6FMcL7f
	4cERi0CKfh/06zV5MCmWaUbtxXXMKqnlMDzWuVm0dJASyEJRSm+Ookx79N5W2GnF
	kr3HkwyudZ0GY4F6zJpYUJNhqGShZ/PL8r8UGVrnJfO78Bqitz/BqG/FeBa0B/UN
	zntG+6Sfd8ZSIDbrf4/M2WgJmgILTGTpY0w7FG4eHQYIImRxmh7WUMQxoFmRshM4
	MvXQ2KEdyMRNViU79bl/sDFQC5+PIb/BOPTOzaiNjs6zkG+sS9CScdU/jznuRlOc
	wD3ATOB57Kfe5wT6aLj9xxfWk4aDsreXMwfqXty6MpMkRYu61fsaFgizC4Ju/hEB
	8eEQUzPLmLIDnQuUp/K8WuIBXMV7Fwdo8UiUybDS5OS3evlSTY3KQVT8lk65e6Qg
	iuxJXHDCeKiYbhigwqGMDLQmekLAAtxO0JcjJnfNOJo=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 01/10] dma-engine: sun4i: Add a quirk to support different chips
Date: Thu, 31 Oct 2024 13:35:27 +0100
Message-ID: <20241031123538.2582675-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730378154;VERSION=7979;MC=832915346;ID=207181;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667667

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s has similar DMA engine to sun4i. Several
registers has different addresses. Total dma channels, endpoint counts
and max burst counts are also different.

In order to support F1C100s add a quirk structure to hold IC specific
data.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Resolve conflict in `sun4i_dma_prep_dma_cyclic()`, fix whitespace ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * Whitespace

 drivers/dma/sun4i-dma.c | 138 ++++++++++++++++++++++++++++++----------
 1 file changed, 106 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 2e7f9b07fdd2..d472f57a39ea 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -31,6 +32,8 @@
 #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
 #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
 
+#define SUN4I_MAX_BURST	8
+
 /** Normal DMA register values **/
 
 /* Normal DMA source/destination data request type values */
@@ -132,6 +135,32 @@
 #define SUN4I_DDMA_MAX_SEG_SIZE		SZ_16M
 #define SUN4I_DMA_MAX_SEG_SIZE		SUN4I_NDMA_MAX_SEG_SIZE
 
+/*
+ * Hardware channels / ports representation
+ *
+ * The hardware is used in several SoCs, with differing numbers
+ * of channels and endpoints. This structure ties those numbers
+ * to a certain compatible string.
+ */
+struct sun4i_dma_config {
+	u32 ndma_nr_max_channels;
+	u32 ndma_nr_max_vchans;
+
+	u32 ddma_nr_max_channels;
+	u32 ddma_nr_max_vchans;
+
+	u32 dma_nr_max_channels;
+
+	void (*set_dst_data_width)(u32 *p_cfg, s8 data_width);
+	void (*set_src_data_width)(u32 *p_cfg, s8 data_width);
+	int (*convert_burst)(u32 maxburst);
+
+	u8 ndma_drq_sdram;
+	u8 ddma_drq_sdram;
+
+	u8 max_burst;
+};
+
 struct sun4i_dma_pchan {
 	/* Register base of channel */
 	void __iomem			*base;
@@ -170,7 +199,7 @@ struct sun4i_dma_contract {
 };
 
 struct sun4i_dma_dev {
-	DECLARE_BITMAP(pchans_used, SUN4I_DMA_NR_MAX_CHANNELS);
+	unsigned long *pchans_used;
 	struct dma_device		slave;
 	struct sun4i_dma_pchan		*pchans;
 	struct sun4i_dma_vchan		*vchans;
@@ -178,6 +207,7 @@ struct sun4i_dma_dev {
 	struct clk			*clk;
 	int				irq;
 	spinlock_t			lock;
+	const struct sun4i_dma_config *cfg;
 };
 
 static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
@@ -200,7 +230,17 @@ static struct device *chan2dev(struct dma_chan *chan)
 	return &chan->dev->device;
 }
 
-static int convert_burst(u32 maxburst)
+static void set_dst_data_width_a10(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(data_width);
+}
+
+static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
+}
+
+static int convert_burst_a10(u32 maxburst)
 {
 	if (maxburst > 8)
 		return -EINVAL;
@@ -233,15 +273,15 @@ static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *priv,
 	int i, max;
 
 	/*
-	 * pchans 0-SUN4I_NDMA_NR_MAX_CHANNELS are normal, and
-	 * SUN4I_NDMA_NR_MAX_CHANNELS+ are dedicated ones
+	 * pchans 0-priv->cfg->ndma_nr_max_channels are normal, and
+	 * priv->cfg->ndma_nr_max_channels+ are dedicated ones
 	 */
 	if (vchan->is_dedicated) {
-		i = SUN4I_NDMA_NR_MAX_CHANNELS;
-		max = SUN4I_DMA_NR_MAX_CHANNELS;
+		i = priv->cfg->ndma_nr_max_channels;
+		max = priv->cfg->dma_nr_max_channels;
 	} else {
 		i = 0;
-		max = SUN4I_NDMA_NR_MAX_CHANNELS;
+		max = priv->cfg->ndma_nr_max_channels;
 	}
 
 	spin_lock_irqsave(&priv->lock, flags);
@@ -444,6 +484,7 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		      size_t len, struct dma_slave_config *sconfig,
 		      enum dma_transfer_direction direction)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_promise *promise;
 	int ret;
 
@@ -467,13 +508,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		sconfig->src_addr_width, sconfig->dst_addr_width);
 
 	/* Source burst */
-	ret = convert_burst(sconfig->src_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->src_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
 
 	/* Destination burst */
-	ret = convert_burst(sconfig->dst_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->dst_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
@@ -482,13 +523,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 	ret = convert_buswidth(sconfig->src_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
+	priv->cfg->set_src_data_width(&promise->cfg, ret);
 
 	/* Destination bus width */
 	ret = convert_buswidth(sconfig->dst_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
+	priv->cfg->set_dst_data_width(&promise->cfg, ret);
 
 	return promise;
 
@@ -510,6 +551,7 @@ static struct sun4i_dma_promise *
 generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		      size_t len, struct dma_slave_config *sconfig)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_promise *promise;
 	int ret;
 
@@ -524,13 +566,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		SUN4I_DDMA_CFG_BYTE_COUNT_MODE_REMAIN;
 
 	/* Source burst */
-	ret = convert_burst(sconfig->src_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->src_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
 
 	/* Destination burst */
-	ret = convert_burst(sconfig->dst_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->dst_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
@@ -539,13 +581,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 	ret = convert_buswidth(sconfig->src_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
+	priv->cfg->set_src_data_width(&promise->cfg, ret);
 
 	/* Destination bus width */
 	ret = convert_buswidth(sconfig->dst_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
+	priv->cfg->set_dst_data_width(&promise->cfg, ret);
 
 	return promise;
 
@@ -622,6 +664,7 @@ static struct dma_async_tx_descriptor *
 sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 			  dma_addr_t src, size_t len, unsigned long flags)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
 	struct sun4i_dma_promise *promise;
@@ -638,8 +681,8 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 	 */
 	sconfig->src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	sconfig->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	sconfig->src_maxburst = 8;
-	sconfig->dst_maxburst = 8;
+	sconfig->src_maxburst = priv->cfg->max_burst;
+	sconfig->dst_maxburst = priv->cfg->max_burst;
 
 	if (vchan->is_dedicated)
 		promise = generate_ddma_promise(chan, src, dest, len, sconfig);
@@ -654,11 +697,13 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 
 	/* Configure memcpy mode */
 	if (vchan->is_dedicated) {
-		promise->cfg |= SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM) |
-				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM);
+		promise->cfg |=
+			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ddma_drq_sdram) |
+			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ddma_drq_sdram);
 	} else {
-		promise->cfg |= SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM) |
-				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
+		promise->cfg |=
+			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ndma_drq_sdram) |
+			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ndma_drq_sdram);
 	}
 
 	/* Fill the contract with our only promise */
@@ -673,6 +718,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 			  size_t period_len, enum dma_transfer_direction dir,
 			  unsigned long flags)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
 	struct sun4i_dma_promise *promise;
@@ -696,11 +742,11 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 	if (vchan->is_dedicated) {
 		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
 		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
-		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
+		ram_type = priv->cfg->ddma_drq_sdram;
 	} else {
 		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
 		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
-		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
+		ram_type = priv->cfg->ndma_drq_sdram;
 	}
 
 	if (dir == DMA_MEM_TO_DEV) {
@@ -793,6 +839,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			unsigned int sg_len, enum dma_transfer_direction dir,
 			unsigned long flags, void *context)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
 	struct sun4i_dma_promise *promise;
@@ -818,11 +865,11 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (vchan->is_dedicated) {
 		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
 		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
-		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
+		ram_type = priv->cfg->ddma_drq_sdram;
 	} else {
 		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
 		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
-		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
+		ram_type = priv->cfg->ndma_drq_sdram;
 	}
 
 	if (dir == DMA_MEM_TO_DEV)
@@ -1150,6 +1197,10 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->cfg = of_device_get_match_data(&pdev->dev);
+	if (!priv->cfg)
+		return -ENODEV;
+
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -1197,23 +1248,26 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 
 	priv->slave.dev = &pdev->dev;
 
-	priv->pchans = devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_CHANNELS,
+	priv->pchans = devm_kcalloc(&pdev->dev, priv->cfg->dma_nr_max_channels,
 				    sizeof(struct sun4i_dma_pchan), GFP_KERNEL);
 	priv->vchans = devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_VCHANS,
 				    sizeof(struct sun4i_dma_vchan), GFP_KERNEL);
-	if (!priv->vchans || !priv->pchans)
+	priv->pchans_used = devm_kcalloc(&pdev->dev,
+					 BITS_TO_LONGS(priv->cfg->dma_nr_max_channels),
+					 sizeof(unsigned long), GFP_KERNEL);
+	if (!priv->vchans || !priv->pchans || !priv->pchans_used)
 		return -ENOMEM;
 
 	/*
-	 * [0..SUN4I_NDMA_NR_MAX_CHANNELS) are normal pchans, and
-	 * [SUN4I_NDMA_NR_MAX_CHANNELS..SUN4I_DMA_NR_MAX_CHANNELS) are
+	 * [0..priv->cfg->ndma_nr_max_channels) are normal pchans, and
+	 * [priv->cfg->ndma_nr_max_channels..priv->cfg->dma_nr_max_channels) are
 	 * dedicated ones
 	 */
-	for (i = 0; i < SUN4I_NDMA_NR_MAX_CHANNELS; i++)
+	for (i = 0; i < priv->cfg->ndma_nr_max_channels; i++)
 		priv->pchans[i].base = priv->base +
 			SUN4I_NDMA_CHANNEL_REG_BASE(i);
 
-	for (j = 0; i < SUN4I_DMA_NR_MAX_CHANNELS; i++, j++) {
+	for (j = 0; i < priv->cfg->dma_nr_max_channels; i++, j++) {
 		priv->pchans[i].base = priv->base +
 			SUN4I_DDMA_CHANNEL_REG_BASE(j);
 		priv->pchans[i].is_dedicated = 1;
@@ -1284,8 +1338,28 @@ static void sun4i_dma_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk);
 }
 
+static struct sun4i_dma_config sun4i_a10_dma_cfg = {
+	.ndma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS,
+	.ndma_nr_max_vchans	= SUN4I_NDMA_NR_MAX_VCHANS,
+
+	.ddma_nr_max_channels	= SUN4I_DDMA_NR_MAX_CHANNELS,
+	.ddma_nr_max_vchans	= SUN4I_DDMA_NR_MAX_VCHANS,
+
+	.dma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS +
+		SUN4I_DDMA_NR_MAX_CHANNELS,
+
+	.set_dst_data_width	= set_dst_data_width_a10,
+	.set_src_data_width	= set_src_data_width_a10,
+	.convert_burst		= convert_burst_a10,
+
+	.ndma_drq_sdram		= SUN4I_NDMA_DRQ_TYPE_SDRAM,
+	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
+
+	.max_burst		= SUN4I_MAX_BURST,
+};
+
 static const struct of_device_id sun4i_dma_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-dma" },
+	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_dma_match);
-- 
2.34.1



