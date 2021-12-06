Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78A846A369
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 18:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbhLFRrT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 12:47:19 -0500
Received: from aposti.net ([89.234.176.197]:59744 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245477AbhLFRrS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Dec 2021 12:47:18 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/6] dmaengine: jz4780: Replace uint32_t with u32
Date:   Mon,  6 Dec 2021 17:42:58 +0000
Message-Id: <20211206174259.68133-6-paul@crapouillou.net>
In-Reply-To: <20211206174259.68133-1-paul@crapouillou.net>
References: <20211206174259.68133-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace the uint32_t type used all over dma-jz4780.c with the equivalent
Linux type: u32.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index bcd21d7a559d..c8c4bbd57d14 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -104,10 +104,10 @@
  * descriptor base address in the upper 8 bits.
  */
 struct jz4780_dma_hwdesc {
-	uint32_t dcm;
-	uint32_t dsa;
-	uint32_t dta;
-	uint32_t dtc;
+	u32 dcm;
+	u32 dsa;
+	u32 dta;
+	u32 dtc;
 };
 
 /* Size of allocations for hardware descriptor blocks. */
@@ -122,7 +122,7 @@ struct jz4780_dma_desc {
 	dma_addr_t desc_phys;
 	unsigned int count;
 	enum dma_transaction_type type;
-	uint32_t status;
+	u32 status;
 };
 
 struct jz4780_dma_chan {
@@ -130,8 +130,8 @@ struct jz4780_dma_chan {
 	unsigned int id;
 	struct dma_pool *desc_pool;
 
-	uint32_t transfer_type;
-	uint32_t transfer_shift;
+	u32 transfer_type;
+	u32 transfer_shift;
 	struct dma_slave_config	config;
 
 	struct jz4780_dma_desc *desc;
@@ -152,12 +152,12 @@ struct jz4780_dma_dev {
 	unsigned int irq;
 	const struct jz4780_dma_soc_data *soc_data;
 
-	uint32_t chan_reserved;
+	u32 chan_reserved;
 	struct jz4780_dma_chan chan[];
 };
 
 struct jz4780_dma_filter_data {
-	uint32_t transfer_type;
+	u32 transfer_type;
 	int channel;
 };
 
@@ -179,26 +179,26 @@ static inline struct jz4780_dma_dev *jz4780_dma_chan_parent(
 			    dma_device);
 }
 
-static inline uint32_t jz4780_dma_chn_readl(struct jz4780_dma_dev *jzdma,
+static inline u32 jz4780_dma_chn_readl(struct jz4780_dma_dev *jzdma,
 	unsigned int chn, unsigned int reg)
 {
 	return readl(jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
 }
 
 static inline void jz4780_dma_chn_writel(struct jz4780_dma_dev *jzdma,
-	unsigned int chn, unsigned int reg, uint32_t val)
+	unsigned int chn, unsigned int reg, u32 val)
 {
 	writel(val, jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
 }
 
-static inline uint32_t jz4780_dma_ctrl_readl(struct jz4780_dma_dev *jzdma,
+static inline u32 jz4780_dma_ctrl_readl(struct jz4780_dma_dev *jzdma,
 	unsigned int reg)
 {
 	return readl(jzdma->ctrl_base + reg);
 }
 
 static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
-	unsigned int reg, uint32_t val)
+	unsigned int reg, u32 val)
 {
 	writel(val, jzdma->ctrl_base + reg);
 }
@@ -260,8 +260,8 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
 	kfree(desc);
 }
 
-static uint32_t jz4780_dma_transfer_size(struct jz4780_dma_chan *jzchan,
-	unsigned long val, uint32_t *shift)
+static u32 jz4780_dma_transfer_size(struct jz4780_dma_chan *jzchan,
+	unsigned long val, u32 *shift)
 {
 	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	int ord = ffs(val) - 1;
@@ -303,7 +303,7 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 	enum dma_transfer_direction direction)
 {
 	struct dma_slave_config *config = &jzchan->config;
-	uint32_t width, maxburst, tsz;
+	u32 width, maxburst, tsz;
 
 	if (direction == DMA_MEM_TO_DEV) {
 		desc->dcm = JZ_DMA_DCM_SAI;
@@ -453,7 +453,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
 {
 	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
 	struct jz4780_dma_desc *desc;
-	uint32_t tsz;
+	u32 tsz;
 
 	desc = jz4780_dma_desc_alloc(jzchan, 1, DMA_MEMCPY);
 	if (!desc)
@@ -670,7 +670,7 @@ static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 {
 	const unsigned int soc_flags = jzdma->soc_data->flags;
 	struct jz4780_dma_desc *desc = jzchan->desc;
-	uint32_t dcs;
+	u32 dcs;
 	bool ack = true;
 
 	spin_lock(&jzchan->vchan.lock);
@@ -727,7 +727,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 	struct jz4780_dma_dev *jzdma = data;
 	unsigned int nb_channels = jzdma->soc_data->nb_channels;
 	unsigned long pending;
-	uint32_t dmac;
+	u32 dmac;
 	int i;
 
 	pending = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DIRQP);
-- 
2.33.0

