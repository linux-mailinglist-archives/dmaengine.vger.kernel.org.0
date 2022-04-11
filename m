Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077954FB30E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 06:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbiDKEtC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 00:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbiDKEs7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 00:48:59 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FBA35DCD;
        Sun, 10 Apr 2022 21:46:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C6D373200EAD;
        Mon, 11 Apr 2022 00:46:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Apr 2022 00:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649652404; x=1649738804; bh=tb
        GECmg7cmOgqhCSnDxa9d6F+HbU8moeuBjWkZd3Kmg=; b=iop0ys6C6nJF7C0ejv
        BSFwlXoOUJ9Y06N+yKU9DovoBVQnNFtaE5GU39QdrKXhdWwt0fmmC/O3DmuWhk7j
        Oywk+weDsSbzRkUmJ8aEuzDCzBs156hc4rly6nTyepUQkwdWTyAOgCcHWtN0TMbn
        wtYXEpUvW70mAPojp33isDuRsvkgzz6+3gK8Voc8RNyC3y4pP+8wAdLovWMlkfuQ
        RVA347KNBhJ8KjOfwJZ26gKS2qFMdDge2uyBtq1PWn76nT+KZtTMNw5eMdSCqeB8
        RqsW7uGt3HQRDcFaZXb3eMS929Nz3MXbexINfh2AWMWyNhABDs4SlgFmanlzOpeo
        t54Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649652404; x=1649738804; bh=tbGECmg7cmOgqhCSnDxa9d6F+HbU8moeuBj
        WkZd3Kmg=; b=mqr8jdxhpiIuVMsx/SVjURO7cqIgxr7PQpAEpFGEr384izCzXHQ
        scFDng6X+YnwhXO1azYMb/zeqU7YY3rO0XSornlvHZKiwLHIu9uIO7/lHHZJfzyX
        RXLy+oDEex3fnCQ3B81N5ggpp8S4aY+CfJgF5xgUXeBJlqwiuS6unmSQHVPDzUps
        z6/9U6upCtWXTVza/fWfZOw0GR+mPclC4f2F9JUzC8W4+kuCCbd4pDCepn4kmrIU
        KThmqSV0aysTla82vbW3UCGTjft1NWOe4EAaN0gywc0gavx+KW7vYWvt6cZmZTbL
        XwnUVCy+pqGWfUSHDDPkEVF3VJZ2iZ76B4w==
X-ME-Sender: <xms:tLJTYpduxsqy7oCqdlLTDVS2XLqX16TV4XnGaGTyMak3JKg4FOczwQ>
    <xme:tLJTYnPcAsv8U0bK7fTYKZgl0Eh44IM8bna7kfgljH88z806WTjnsAqw297nF8Maj
    abDU4IhZVhyEqhmHg>
X-ME-Received: <xmr:tLJTYiiHq-3MtQDX1k5Kuqn7AwZ_uGKDbDLd36LgmkE3vy4juInYN4DL0lF0dMGGfb-9NvwVst4QynZZ5y7k4AWU4SUORTZZXzHIYX-8y0zAQb5Py3D-0VertTZLm38Fx1Cg_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:tLJTYi_oOdupA9TGMp3njRMe0rQ_bIfyKaURrNsMTHfVb5iZYMicew>
    <xmx:tLJTYlva2WcGp8nMrd9JDGqlxNLrIyoKcREcKwYJYsNpj72PAkStzA>
    <xmx:tLJTYhFXuqi1O2IzkFYyzsDeNxex6VNggesXgjiMVffYIIaWm_k3Lg>
    <xmx:tLJTYhFQSF7oqF5k2-X8SMYYBiRc-G8HZQxBcLUtMJuYggC8lYciOA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:46:43 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 3/4] dmaengine: sun6i: Add support for 34-bit physical addresses
Date:   Sun, 10 Apr 2022 23:46:31 -0500
Message-Id: <20220411044633.39014-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411044633.39014-1-samuel@sholland.org>
References: <20220411044633.39014-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Fix `checkpatch.pl --strict` style issues (missing spaces)

 drivers/dma/sun6i-dma.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a9334f969b28..bd5958185ed1 100644
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
+	v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);
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
+		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);
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
+		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);
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
2.35.1

