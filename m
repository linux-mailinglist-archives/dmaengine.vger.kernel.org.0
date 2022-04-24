Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE650D401
	for <lists+dmaengine@lfdr.de>; Sun, 24 Apr 2022 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiDXRbK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Apr 2022 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiDXRbI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Apr 2022 13:31:08 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34F214AAED;
        Sun, 24 Apr 2022 10:28:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FC6A5C00FD;
        Sun, 24 Apr 2022 13:28:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 24 Apr 2022 13:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650821287; x=1650907687; bh=KX
        ud8aNEo3GPSzdUwZ+M0Sz/KQJhb4LbGLSizThDo/8=; b=pMMge4SiMS/fgZXb8g
        pjZlAR1AFQU94Pqaz0bHGqr9f+waSEyzAP9huQ8sd0eoakRqOGrLdObZy4ZyQQei
        GfJJscBSrlmDcBsPyXR7eI4kOikUWB65r5pI4Aay1vXv8W79xIAKxd5IkvWV9tzN
        hRGGn9XbqCxLGApwArJmmK/+zy/pteEzJVVmxU0DJpG+u6hO/BQ30SaTssL7e4IB
        eRvlcaijaFiqLNBXIS+oOALY5rFmyH+IvQikXOGrRAGJYOnfIP01BwnqrT4oaOT8
        xFa8LRJ6B2QTlGrfk5idW87efy0miyJ+8DSTA6lrtHe++gxDkP8EJYYCD+AIh+4z
        EZDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650821287; x=1650907687; bh=KXud8aNEo3GPSzdUwZ+M0Sz/KQJhb4LbGLS
        izThDo/8=; b=xr1I/ToiYHYh4WrTNdeYIyMwC3vFcnLESDuGMfZVorAkLPrsZbS
        hhIjRJ5AA/gJAxEDVzzFHijIDTaZeVFTRf41rCWfy9nZqhgw+hUjrLEFpbDugvVU
        W4R8zhx4N5g84Hj81MyT+U6USd3yMlJldKtSufVfjEQkfGXymXNCKYUh1DDXg13y
        DJ7N5OksTEPGHGb1bWhYbPQ7iN74l6V4JDZjXidO0/9Kvq7x3/TzSZBiMTs2ICHH
        CrkzFOzQZMfSDk0RuZPdv7jT+Wgr+HvanpW2hweyoJjlsILybEv8tiOxz2QhuIDF
        dH0Iw8SfKXgek8rpBPqm/sYPvHOyp9bHTcA==
X-ME-Sender: <xms:p4hlYsTKmodRBE6-D53357Nj9QMiHwIbX3D5jozj-W1WXYnpO-MMpg>
    <xme:p4hlYpyJuvtBfDgY2EGh38LohwngasqdVXh2jL_IsTpp-rde4BQT1SmbrKaKmCm5x
    xmSho5pklubPZy3Qw>
X-ME-Received: <xmr:p4hlYp0XP-EH6OQ9NlLAhtpA_hteOUdqucTaR_iCRNTFnrB0e97V49OPHJbHzsOPJNseM9KTAc1OI26h2F1865iTZga0tdwbCYB5yzu6Qy6uaV2cVMFEUPcNx299YF13DIFdgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:p4hlYgCIs8aB5xle3Q5z729R4I72aAq9VSEkvo9gTFgTNSWcTR-eFg>
    <xmx:p4hlYlis5IIK3Flv_h6ak8ncrX5XezvOPsHOD--XbUN3DR4olguRmw>
    <xmx:p4hlYsoNO-D3gyfXCg-IrTQOXjjEkmdcOML-YRxq55osJuCoy-nJ_g>
    <xmx:p4hlYqYEr63VDEOXacgvOgudlFcUHJliSEBT4fjTbMc2GIrwizznjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 13:28:06 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 3/4] dmaengine: sun6i: Add support for 34-bit physical addresses
Date:   Sun, 24 Apr 2022 12:27:57 -0500
Message-Id: <20220424172759.33383-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424172759.33383-1-samuel@sholland.org>
References: <20220424172759.33383-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Fix shift warnings for 32-bit dma_addr_t and 32-bit phys_addr_t
 - Make explicit that v_lli->src/dst only hold the low 32 bits

Changes in v2:
 - Fix `checkpatch.pl --strict` style issues (missing spaces)

 drivers/dma/sun6i-dma.c | 53 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 4436fbd70445..1eb3bafa7324 100644
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
+#define SRC_HIGH_ADDR(x)		(((x) & 0x3U) << 16)
+#define DST_HIGH_ADDR(x)		(((x) & 0x3U) << 18)
 
 /*
  * Various hardware related defines
@@ -132,6 +140,7 @@ struct sun6i_dma_config {
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
+	bool has_high_addr;
 	bool has_mbus_clk;
 };
 
@@ -623,6 +632,18 @@ static int set_config(struct sun6i_dma_dev *sdev,
 	return 0;
 }
 
+static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
+				      struct sun6i_dma_lli *v_lli,
+				      dma_addr_t src, dma_addr_t dst)
+{
+	v_lli->src = lower_32_bits(src);
+	v_lli->dst = lower_32_bits(dst);
+
+	if (sdev->cfg->has_high_addr)
+		v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
+			       DST_HIGH_ADDR(upper_32_bits(dst));
+}
+
 static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		size_t len, unsigned long flags)
@@ -645,16 +666,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 	if (!txd)
 		return NULL;
 
-	v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
+	v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);
 	if (!v_lli) {
 		dev_err(sdev->slave.dev, "Failed to alloc lli memory\n");
 		goto err_txd_free;
 	}
 
-	v_lli->src = src;
-	v_lli->dst = dest;
 	v_lli->len = len;
 	v_lli->para = NORMAL_WAIT;
+	sun6i_dma_set_addr(sdev, v_lli, src, dest);
 
 	burst = convert_burst(8);
 	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
@@ -705,7 +725,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		return NULL;
 
 	for_each_sg(sgl, sg, sg_len, i) {
-		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
+		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);
 		if (!v_lli)
 			goto err_lli_free;
 
@@ -713,8 +733,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		v_lli->para = NORMAL_WAIT;
 
 		if (dir == DMA_MEM_TO_DEV) {
-			v_lli->src = sg_dma_address(sg);
-			v_lli->dst = sconfig->dst_addr;
+			sun6i_dma_set_addr(sdev, v_lli,
+					   sg_dma_address(sg),
+					   sconfig->dst_addr);
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
@@ -726,8 +747,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 				sg_dma_len(sg), flags);
 
 		} else {
-			v_lli->src = sconfig->src_addr;
-			v_lli->dst = sg_dma_address(sg);
+			sun6i_dma_set_addr(sdev, v_lli,
+					   sconfig->src_addr,
+					   sg_dma_address(sg));
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
@@ -786,7 +808,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 		return NULL;
 
 	for (i = 0; i < periods; i++) {
-		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
+		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);
 		if (!v_lli) {
 			dev_err(sdev->slave.dev, "Failed to alloc lli memory\n");
 			goto err_lli_free;
@@ -796,14 +818,16 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 		v_lli->para = NORMAL_WAIT;
 
 		if (dir == DMA_MEM_TO_DEV) {
-			v_lli->src = buf_addr + period_len * i;
-			v_lli->dst = sconfig->dst_addr;
+			sun6i_dma_set_addr(sdev, v_lli,
+					   buf_addr + period_len * i,
+					   sconfig->dst_addr);
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
 		} else {
-			v_lli->src = sconfig->src_addr;
-			v_lli->dst = buf_addr + period_len * i;
+			sun6i_dma_set_addr(sdev, v_lli,
+					   sconfig->src_addr,
+					   buf_addr + period_len * i);
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
@@ -1174,8 +1198,6 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 };
 
 /*
- * TODO: Add support for more than 4g physical addressing.
- *
  * The A100 binding uses the number of dma channels from the
  * device tree node.
  */
@@ -1194,6 +1216,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.has_high_addr = true,
 	.has_mbus_clk = true,
 };
 
-- 
2.35.1

