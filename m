Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498035529A3
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 05:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbiFUDN7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343662AbiFUDN6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 23:13:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE54120A4;
        Mon, 20 Jun 2022 20:13:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 964C13200645;
        Mon, 20 Jun 2022 23:13:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 20 Jun 2022 23:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655781233; x=1655867633; bh=JIQVua/KN0tcwAdf3iHUyfV4R
        R4Q0CrA2bv56SJC9R8=; b=B9PRh5Rd8oa01y2eEFjqHFLOJpm0h6pNVrDISZLfN
        u4q4T5eMwkFl9Fmxh1Slx53T+fqgEA7aXEmbnlvsWkq6bJZ8xkpRTNvhPsdEO+Ef
        D5ugfb6HLepwJBiaxWdcC51HplPrmwZlJrDWVW+au9jVutw9/EUrvp+mXP9jtiyu
        JZHDSteD9UxuThTDqX7cAyM0C8CzP7UMRk0SQfv19bg4g9wysm2rVgUU3IUjvVdM
        6KrqwwAmwnrsHV81onzVz1eHZoqGAoPOJe6kBvFcXRV2RBB8Pc8Z9LQt97Bls1oH
        v93Dy+jwZ3b8oO2DDDffYLlr+XhORmwkh7DpxZX3IH2cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655781233; x=1655867633; bh=JIQVua/KN0tcwAdf3iHUyfV4RR4Q0CrA2bv
        56SJC9R8=; b=d/1pFOzkbXgDSKc4QUKgR1VKKr/JOtCqdC2W3A/f/x/XG8GYqca
        C0bnkyqBVnRwsK6GO1hOya50WMYhe3sWQDtVA2zyPAWomtgPITXJfnRFDiB/wVp+
        MO1HqHF4xEECW6gc5a5eNFZGN8GrKBHbWhTAYBr8ZHUe/w7PS8mokLYwWZYEHt8A
        ihWiPCvb0UP16cFcqLWDDqTG+VV4192eSE2SAkHRXXLsRxyrA3ZtTouf/JbavgEN
        07FBphtM8wWS/ntSQ8n21Eko/KHxgTdrK3uFWsd8+yIQb42TFpE8tLsZvIbRTCPM
        LpHADavYrj77n90DtzN/f41qnRFnuHWTRRQ==
X-ME-Sender: <xms:cDexYmtpYzGwWMcldm3imIgDH4Y5UjePUlBB1aIz-bWiHjyiuC5rjA>
    <xme:cDexYrcgpJgQGTtvPML0q-MbgmH98ch2Qi0Fzaz3he1N35Xhc32HMenC--4-s0rAs
    0QEZWqz6SXYWN2uOQ>
X-ME-Received: <xmr:cDexYhywWkUVEqD1Zc1gTHtxnp1CDXZbtoimh8rkSGB4iy_8JXQF2KX0kCiokPBidnRpgVOq3oclzZK309ZQF78VSvaE9rW1mdkwAKMMhWoA8WA7ZmEosOyS5O2r8xbSTH3EGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:cDexYhOQiehcAPyETfjU7K7iiCf27dSuD-wEFrtVvkPnzcsLQ3XgoA>
    <xmx:cDexYm8uyyFpqjq4SQxClVqT-9-prc4vt5_4z1ckSF8RlpnYorpCsA>
    <xmx:cDexYpUbdYAswhbeKT0tLb92_e52ds4GKFuXwjtCv7Qyp8hyOXIzsQ>
    <xmx:cTexYrNGQ28OJHiL8kYhWYZ5oCdkCr0W7fjPLw2ykmq0GBbIy9OUFA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:13:51 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] dmaengine: sun4i: Set the maximum segment size
Date:   Mon, 20 Jun 2022 22:13:50 -0500
Message-Id: <20220621031350.36187-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The sun4i DMA engine supports transfer sizes up to 128k for normal DMA
and 16M for dedicated DMA, as documented in the A10 and A20 manuals.

Since this is larger than the default segment size limit (64k), exposing
the real limit reduces the number of transfers needed for a transaction.
However, because the device can only report one segment size limit, we
have to expose the smaller limit from normal DMA.

One complication is that the driver combines pairs of periodic transfers
to reduce programming overhead. This only works when the period size is
at most half of the maximum transfer size. With the default 64k segment
size limit, this was always the case, but for normal DMA it is no longer
guaranteed. Skip the optimization if the period is too long; even
without it, the overhead is less than before.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
I don't have any A10 or A20 boards I can test this on.

 drivers/dma/sun4i-dma.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 93f1645ae928..f291b1b4db32 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -7,6 +7,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/interrupt.h>
@@ -122,6 +123,15 @@
 	 SUN4I_DDMA_PARA_DST_WAIT_CYCLES(2) |				\
 	 SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(2))
 
+/*
+ * Normal DMA supports individual transfers (segments) up to 128k.
+ * Dedicated DMA supports transfers up to 16M. We can only report
+ * one size limit, so we have to use the smaller value.
+ */
+#define SUN4I_NDMA_MAX_SEG_SIZE		SZ_128K
+#define SUN4I_DDMA_MAX_SEG_SIZE		SZ_16M
+#define SUN4I_DMA_MAX_SEG_SIZE		SUN4I_NDMA_MAX_SEG_SIZE
+
 struct sun4i_dma_pchan {
 	/* Register base of channel */
 	void __iomem			*base;
@@ -155,7 +165,8 @@ struct sun4i_dma_contract {
 	struct virt_dma_desc		vd;
 	struct list_head		demands;
 	struct list_head		completed_demands;
-	int				is_cyclic;
+	bool				is_cyclic : 1;
+	bool				use_half_int : 1;
 };
 
 struct sun4i_dma_dev {
@@ -372,7 +383,7 @@ static int __execute_vchan_pending(struct sun4i_dma_dev *priv,
 	if (promise) {
 		vchan->contract = contract;
 		vchan->pchan = pchan;
-		set_pchan_interrupt(priv, pchan, contract->is_cyclic, 1);
+		set_pchan_interrupt(priv, pchan, contract->use_half_int, 1);
 		configure_pchan(pchan, promise);
 	}
 
@@ -735,12 +746,21 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 	 *
 	 * Which requires half the engine programming for the same
 	 * functionality.
+	 *
+	 * This only works if two periods fit in a single promise. That will
+	 * always be the case for dedicated DMA, where the hardware has a much
+	 * larger maximum transfer size than advertised to clients.
 	 */
-	nr_periods = DIV_ROUND_UP(len / period_len, 2);
+	if (vchan->is_dedicated || period_len <= SUN4I_NDMA_MAX_SEG_SIZE / 2) {
+		period_len *= 2;
+		contract->use_half_int = 1;
+	}
+
+	nr_periods = DIV_ROUND_UP(len, period_len);
 	for (i = 0; i < nr_periods; i++) {
 		/* Calculate the offset in the buffer and the length needed */
-		offset = i * period_len * 2;
-		plength = min((len - offset), (period_len * 2));
+		offset = i * period_len;
+		plength = min((len - offset), period_len);
 		if (dir == DMA_MEM_TO_DEV)
 			src = buf + offset;
 		else
@@ -1149,6 +1169,8 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	spin_lock_init(&priv->lock);
 
+	dma_set_max_seg_size(&pdev->dev, SUN4I_DMA_MAX_SEG_SIZE);
+
 	dma_cap_zero(priv->slave.cap_mask);
 	dma_cap_set(DMA_PRIVATE, priv->slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, priv->slave.cap_mask);
-- 
2.35.1

