Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD34569BB
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 06:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhKSFaN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 00:30:13 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49015 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232114AbhKSFaN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 00:30:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 715963201C38;
        Fri, 19 Nov 2021 00:27:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Nov 2021 00:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=5zCC9a0f67fcj
        SBH1kDT49fesxeTKEkALCUxYdq5wQk=; b=nWpF5teaaYCnxlWSQlM8HLqZZH77Z
        YF7IqvWWlzvX+6TKVXGqBCzbwbIoX45nnLeSC4RL9B4trhbpMgCAc1MLGavwg2px
        PAuisKDiW+40o+SKG1SjBUgWrpHMsfUf8eWfzk4cZ7v4jR7Tm9sSYRUEYv9tZA5C
        SxYV/P3/4Ytbw+Dl+r5+qB9F0qIPIp5JWBSlHZu040LKcAXkzRUygb7kjBJsF79Y
        G/WRn0xbEgOf83nxdwHdxbVgVTC7zdZYplJ6MZP3Oy5EeiaKtSOJ8Hsh+pGha26f
        Cya8d1KkMP8i3HPGDShQ8qHZnqDDUKZmMSLO23cqNO1UB+b+WDRA8kCwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5zCC9a0f67fcjSBH1kDT49fesxeTKEkALCUxYdq5wQk=; b=eoSNQANe
        brYNfiRwB0xuPXaZbhyiQJL7W4cSsjGH0IMbDpehxmel3MaFzc5YAiuBkOOlD1L7
        rMcY0S4b3pQX3kdbulTcu9HxU+5SeW53AK7NMjx105ZeWX6AGuLqUb3ModStM3jt
        oA1peuWwqwZbBjeNEIaxN9UzENXSj5AKUqER7f6vyVHQMSDzQKQ++95hfaMXSDZP
        aDjYKgBemQmiD99UJvgh5wOxzi8Sc/2RW8TOl5UBPylIncHBvN8AEtf5ouKvFPlg
        Rci2WR0x49pJBD4EpJueVxQsZUAyxs7PJ586cZFymw7kRWFvbytTdZ4UoS3OISP+
        0cHJGW8+m1Z0Gg==
X-ME-Sender: <xms:rzWXYSz5UFfJtb5XtFBtPnnMAZFR-gYnxxMvvZpRlW-yABQtBQLvrg>
    <xme:rzWXYeS73RFZK2Un1Z-SAXvswPEJReyriSDhFjC0lKlbBsCFhV6iMYCTJgZz-fQzL
    HNn6ESvHI-cKLVBPg>
X-ME-Received: <xmr:rzWXYUUwyLfDzmz65icPiZd-Ua1a9A8Z7rtZXScF3PjDbiTgXZJJ8mQkdQr8oVPA0qk9Rx6Jk2nMy5SEFZIy2v_FhfKydnYZuzihXJl5jod-nwBGbhgFsVOw9PxilzMPTpHUog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:rzWXYYj3GbYMuOb2aOsTYueoYn_6INb5Jo50juqG_pa6jqAoCalsig>
    <xmx:rzWXYUBZFjtFvwUOwUAF4EKrKl72TUTyZK_RFR3DieTEjrMD47QxHg>
    <xmx:rzWXYZIcmoRyfHUMxoVRLIBc_uRIxCU1ZY7JnWlmvXmucIn7dhPrXA>
    <xmx:rzWXYSAHfto6vy26rUyF9I5ini7lAKxh9OaRZLLnII4_n4a-ABWbbg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Nov 2021 00:27:10 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/4] dmaengine: sun6i: Add support for 34-bit physical addresses
Date:   Thu, 18 Nov 2021 23:27:00 -0600
Message-Id: <20211119052702.14392-4-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119052702.14392-1-samuel@sholland.org>
References: <20211119052702.14392-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Recent Allwinner SoCs support >4 GiB of DRAM, so those variants of the
DMA engine support >32 bit physical addresses. This is accomplished by
placing the high bits in the "para" word in the DMA descriptor.

DMA descriptors themselves can be located at >32 bit addresses by
putting the high bits in the LSBs of the descriptor address register,
taking advantage of the required DMA descriptor alignment. However,
support for this is not really necessary, so we can avoid the
complication by allocating them from the DMA_32 zone.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/dma/sun6i-dma.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a9334f969b28..8c7cce643cdc 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -90,6 +90,14 @@
 
 #define DMA_CHAN_CUR_PARA	0x1c
 
+/*
+ * LLI address mangling
+ *
+ * The LLI link physical address is also mangled, but we avoid dealing
+ * with that by allocating LLIs from the DMA32 zone.
+ */
+#define SET_SRC_HIGH_ADDR(x)		((((x) >> 32) & 0x3U) << 16)
+#define SET_DST_HIGH_ADDR(x)		((((x) >> 32) & 0x3U) << 18)
 
 /*
  * Various hardware related defines
@@ -132,6 +140,7 @@ struct sun6i_dma_config {
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
+	bool has_high_addr;
 	bool has_mbus_clk;
 };
 
@@ -223,6 +232,12 @@ to_sun6i_desc(struct dma_async_tx_descriptor *tx)
 	return container_of(tx, struct sun6i_desc, vd.tx);
 }
 
+static inline bool sun6i_dma_has_high_addr(struct sun6i_dma_dev *sdev)
+{
+	return IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
+		sdev->cfg->has_high_addr;
+}
+
 static inline void sun6i_dma_dump_com_regs(struct sun6i_dma_dev *sdev)
 {
 	dev_dbg(sdev->slave.dev, "Common register:\n"
@@ -645,7 +660,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 	if (!txd)
 		return NULL;
 
-	v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
+	v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32|GFP_NOWAIT, &p_lli);
 	if (!v_lli) {
 		dev_err(sdev->slave.dev, "Failed to alloc lli memory\n");
 		goto err_txd_free;
@@ -655,6 +670,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 	v_lli->dst = dest;
 	v_lli->len = len;
 	v_lli->para = NORMAL_WAIT;
+	if (sun6i_dma_has_high_addr(sdev))
+		v_lli->para |= SET_SRC_HIGH_ADDR(src) |
+			       SET_DST_HIGH_ADDR(dest);
 
 	burst = convert_burst(8);
 	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
@@ -705,7 +723,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		return NULL;
 
 	for_each_sg(sgl, sg, sg_len, i) {
-		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
+		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32|GFP_NOWAIT, &p_lli);
 		if (!v_lli)
 			goto err_lli_free;
 
@@ -715,6 +733,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		if (dir == DMA_MEM_TO_DEV) {
 			v_lli->src = sg_dma_address(sg);
 			v_lli->dst = sconfig->dst_addr;
+			if (sun6i_dma_has_high_addr(sdev))
+				v_lli->para |= SET_SRC_HIGH_ADDR(sg_dma_address(sg)) |
+					       SET_DST_HIGH_ADDR(sconfig->dst_addr);
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
@@ -728,6 +749,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		} else {
 			v_lli->src = sconfig->src_addr;
 			v_lli->dst = sg_dma_address(sg);
+			if (sun6i_dma_has_high_addr(sdev))
+				v_lli->para |= SET_SRC_HIGH_ADDR(sconfig->src_addr) |
+					       SET_DST_HIGH_ADDR(sg_dma_address(sg));
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
@@ -786,7 +810,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 		return NULL;
 
 	for (i = 0; i < periods; i++) {
-		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
+		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32|GFP_NOWAIT, &p_lli);
 		if (!v_lli) {
 			dev_err(sdev->slave.dev, "Failed to alloc lli memory\n");
 			goto err_lli_free;
@@ -798,12 +822,18 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 		if (dir == DMA_MEM_TO_DEV) {
 			v_lli->src = buf_addr + period_len * i;
 			v_lli->dst = sconfig->dst_addr;
+			if (sun6i_dma_has_high_addr(sdev))
+				v_lli->para |= SET_SRC_HIGH_ADDR(buf_addr + period_len * i) |
+					       SET_DST_HIGH_ADDR(sconfig->dst_addr);
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
 		} else {
 			v_lli->src = sconfig->src_addr;
 			v_lli->dst = buf_addr + period_len * i;
+			if (sun6i_dma_has_high_addr(sdev))
+				v_lli->para |= SET_SRC_HIGH_ADDR(sconfig->src_addr) |
+					       SET_DST_HIGH_ADDR(buf_addr + period_len * i);
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
@@ -1174,8 +1204,6 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 };
 
 /*
- * TODO: Add support for more than 4g physical addressing.
- *
  * The A100 binding uses the number of dma channels from the
  * device tree node.
  */
@@ -1194,6 +1222,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.has_high_addr = true,
 	.has_mbus_clk = true,
 };
 
-- 
2.32.0

