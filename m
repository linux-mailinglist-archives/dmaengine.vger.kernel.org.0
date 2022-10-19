Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802F360482C
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiJSNuw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiJSNt6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 09:49:58 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57EE1D4DC3;
        Wed, 19 Oct 2022 06:34:07 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1666185808; bh=MzctQr9qZv9WWpuIx6Po0Lx1bRPSxyuGpqrsSw2Aa2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T0rg3eYTePFllJTlCl7xRrk8Ov5UVjgswieO3K5pxTrtjLl0bJe0diwD/d3LP3Dhl
         TOfFPysneaHVI61NwKb92OjItsWOJi08NlvZ0bcLDW0vNPDOJj0xqkwVKze6/lqLdZ
         bWi/9bZBa70dbEUpSNvKbByInX0Z5j/l7vo7apwI=
To:     Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: apple-admac: Allocate cache SRAM to channels
Date:   Wed, 19 Oct 2022 15:23:24 +0200
Message-Id: <20221019132324.8585-2-povik+lin@cutebit.org>
In-Reply-To: <20221019132324.8585-1-povik+lin@cutebit.org>
References: <20221019132324.8585-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There's a previously unknown part of the controller interface: We have
to assign SRAM carveouts to channels to store their in-flight samples
in. So, obtain the size of the SRAM from a read-only register and divide
it into 2K blocks for allocation to channels. The FIFO depths we
configure will always fit into 2K.

(This fixes audio artifacts during simultaneous playback/capture on
multiple channels -- which looking back is fully accounted for by having
had the caches in the DMA controller overlap in memory.)

Fixes: b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 drivers/dma/apple-admac.c | 102 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index a2cc520225d3..90f28bda29c8 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -21,6 +21,12 @@
 #define NCHANNELS_MAX	64
 #define IRQ_NOUTPUTS	4
 
+/*
+ * For allocation purposes we split the cache
+ * memory into blocks of fixed size (given in bytes).
+ */
+#define SRAM_BLOCK	2048
+
 #define RING_WRITE_SLOT		GENMASK(1, 0)
 #define RING_READ_SLOT		GENMASK(5, 4)
 #define RING_FULL		BIT(9)
@@ -36,6 +42,9 @@
 #define REG_TX_STOP		0x0004
 #define REG_RX_START		0x0008
 #define REG_RX_STOP		0x000c
+#define REG_IMPRINT		0x0090
+#define REG_TX_SRAM_SIZE	0x0094
+#define REG_RX_SRAM_SIZE	0x0098
 
 #define REG_CHAN_CTL(ch)	(0x8000 + (ch) * 0x200)
 #define REG_CHAN_CTL_RST_RINGS	BIT(0)
@@ -53,7 +62,9 @@
 #define BUS_WIDTH_FRAME_2_WORDS	0x10
 #define BUS_WIDTH_FRAME_4_WORDS	0x20
 
-#define CHAN_BUFSIZE		0x8000
+#define REG_CHAN_SRAM_CARVEOUT(ch)	(0x8050 + (ch) * 0x200)
+#define CHAN_SRAM_CARVEOUT_SIZE		GENMASK(31, 16)
+#define CHAN_SRAM_CARVEOUT_BASE		GENMASK(15, 0)
 
 #define REG_CHAN_FIFOCTL(ch)	(0x8054 + (ch) * 0x200)
 #define CHAN_FIFOCTL_LIMIT	GENMASK(31, 16)
@@ -76,6 +87,8 @@ struct admac_chan {
 	struct dma_chan chan;
 	struct tasklet_struct tasklet;
 
+	u32 carveout;
+
 	spinlock_t lock;
 	struct admac_tx *current_tx;
 	int nperiod_acks;
@@ -92,12 +105,24 @@ struct admac_chan {
 	struct list_head to_free;
 };
 
+struct admac_sram {
+	u32 size;
+	/*
+	 * SRAM_CARVEOUT has 16-bit fields, so the SRAM cannot be larger than
+	 * 64K and a 32-bit bitfield over 2K blocks covers it.
+	 */
+	u32 allocated;
+};
+
 struct admac_data {
 	struct dma_device dma;
 	struct device *dev;
 	__iomem void *base;
 	struct reset_control *rstc;
 
+	struct mutex cache_alloc_lock;
+	struct admac_sram txcache, rxcache;
+
 	int irq;
 	int irq_index;
 	int nchannels;
@@ -118,6 +143,60 @@ struct admac_tx {
 	struct list_head node;
 };
 
+static int admac_alloc_sram_carveout(struct admac_data *ad,
+				     enum dma_transfer_direction dir,
+				     u32 *out)
+{
+	struct admac_sram *sram;
+	int i, ret = 0, nblocks;
+
+	if (dir == DMA_MEM_TO_DEV)
+		sram = &ad->txcache;
+	else
+		sram = &ad->rxcache;
+
+	mutex_lock(&ad->cache_alloc_lock);
+
+	nblocks = sram->size / SRAM_BLOCK;
+	for (i = 0; i < nblocks; i++)
+		if (!(sram->allocated & BIT(i)))
+			break;
+
+	if (i < nblocks) {
+		*out = FIELD_PREP(CHAN_SRAM_CARVEOUT_BASE, i * SRAM_BLOCK) |
+			FIELD_PREP(CHAN_SRAM_CARVEOUT_SIZE, SRAM_BLOCK);
+		sram->allocated |= BIT(i);
+	} else {
+		ret = -EBUSY;
+	}
+
+	mutex_unlock(&ad->cache_alloc_lock);
+
+	return ret;
+}
+
+static void admac_free_sram_carveout(struct admac_data *ad,
+				     enum dma_transfer_direction dir,
+				     u32 carveout)
+{
+	struct admac_sram *sram;
+	u32 base = FIELD_GET(CHAN_SRAM_CARVEOUT_BASE, carveout);
+	int i;
+
+	if (dir == DMA_MEM_TO_DEV)
+		sram = &ad->txcache;
+	else
+		sram = &ad->rxcache;
+
+	if (WARN_ON(base >= sram->size))
+		return;
+
+	mutex_lock(&ad->cache_alloc_lock);
+	i = base / SRAM_BLOCK;
+	sram->allocated &= ~BIT(i);
+	mutex_unlock(&ad->cache_alloc_lock);
+}
+
 static void admac_modify(struct admac_data *ad, int reg, u32 mask, u32 val)
 {
 	void __iomem *addr = ad->base + reg;
@@ -466,15 +545,28 @@ static void admac_synchronize(struct dma_chan *chan)
 static int admac_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct admac_chan *adchan = to_admac_chan(chan);
+	struct admac_data *ad = adchan->host;
+	int ret;
 
 	dma_cookie_init(&adchan->chan);
+	ret = admac_alloc_sram_carveout(ad, admac_chan_direction(adchan->no),
+					&adchan->carveout);
+	if (ret < 0)
+		return ret;
+
+	writel_relaxed(adchan->carveout,
+		       ad->base + REG_CHAN_SRAM_CARVEOUT(adchan->no));
 	return 0;
 }
 
 static void admac_free_chan_resources(struct dma_chan *chan)
 {
+	struct admac_chan *adchan = to_admac_chan(chan);
+
 	admac_terminate_all(chan);
 	admac_synchronize(chan);
+	admac_free_sram_carveout(adchan->host, admac_chan_direction(adchan->no),
+				 adchan->carveout);
 }
 
 static struct dma_chan *admac_dma_of_xlate(struct of_phandle_args *dma_spec,
@@ -712,6 +804,7 @@ static int admac_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ad);
 	ad->dev = &pdev->dev;
 	ad->nchannels = nchannels;
+	mutex_init(&ad->cache_alloc_lock);
 
 	/*
 	 * The controller has 4 IRQ outputs. Try them all until
@@ -801,6 +894,13 @@ static int admac_probe(struct platform_device *pdev)
 		goto free_irq;
 	}
 
+	ad->txcache.size = readl_relaxed(ad->base + REG_TX_SRAM_SIZE);
+	ad->rxcache.size = readl_relaxed(ad->base + REG_RX_SRAM_SIZE);
+
+	dev_info(&pdev->dev, "Audio DMA Controller\n");
+	dev_info(&pdev->dev, "imprint %x TX cache %u RX cache %u\n",
+		 readl_relaxed(ad->base + REG_IMPRINT), ad->txcache.size, ad->rxcache.size);
+
 	return 0;
 
 free_irq:
-- 
2.33.0

