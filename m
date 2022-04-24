Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBF050D3F5
	for <lists+dmaengine@lfdr.de>; Sun, 24 Apr 2022 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiDXRbI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Apr 2022 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiDXRbG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Apr 2022 13:31:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65E114AADC;
        Sun, 24 Apr 2022 10:28:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 463995C00FF;
        Sun, 24 Apr 2022 13:28:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 24 Apr 2022 13:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650821285; x=1650907685; bh=pI
        0+xczgj9HddQyvNbQNgf/Wfc3FJNTjyj7iSZol1+M=; b=llu6M6Fn/i/c82i7lR
        Qa7p1yspcKaLcuDmMDHAuNG0uUZGTgzHA6NuvOODCqtFbIpLLOubmwnqC/YEe/RW
        j8MdG3R/G4OGCajnmCaO9vJZnUcW0103PAWXHNVKfzSD09tIa/q1vsr2wat8qsSM
        S++f9d2bq/dI7NzQemlHn1oQj/jNbflVr6S+7+961Z9za1KT2+2jVuUdPt/Sf41h
        9OIxlESn6T7Rg88Tt2UtYUwJMXb0/GgByjnrY+W/cw1rlI82m384s76nKzIwIUqA
        yR/jbvqa+M6yxiszs+MZEhAr3bS42AZl8muVmiDfP8Pkrpev6toMAc0qURzfQSO3
        /Eig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650821285; x=1650907685; bh=pI0+xczgj9HddQyvNbQNgf/Wfc3FJNTjyj7
        iSZol1+M=; b=j+0Qg41KoUB3K9eML1A26l6UXCykrN2VzUJZEJVoU01V3jGvDva
        Tfr5c3qebt+ygWliuKJf+ReCwuaR+5XMlqnqOEXYdxvB0ox5QMIww51X0i+BZPvd
        opESplhvlUL9Ms/gCNcTINtslwwzK7yEL96NauiQn94W5EHetaaK4/ASRBhgpMLn
        TV1ykqkP1gJpMUUcpbpAz66vx1mmuQRvtO88/YZD8TM18KKgRpYrC2ZamivYHnyR
        vcSxY/o6tNbf7c2PKz8s/jXIOEGUnlCog2QtJ9BUAEj3EIhfiBpU2dMUeMm21SlM
        lwutUWFeGjPJtEGRODDHGyWvBlEOGHmBk1w==
X-ME-Sender: <xms:pYhlYuA8g_l4DHfYMw9qulzLE78R12dHvW7AmoQaFPKgKt-oHx_oKQ>
    <xme:pYhlYohHCMyZctUFR-MVLqquSMJxfLzc5JlVrjSKbjHrDXAmmppNDvESZm6P7UjBw
    TxQw6qaqj-UdyjKPw>
X-ME-Received: <xmr:pYhlYhn9iijFj62H1lcRQoR-6Bmtjqgrq-qe543TEKZeLIdedOOLF1DyF9NIOHyNQ5XPtP68BvKS0wF6C5RM2w0WstcuIpSpvaE_2xFT2XYXbujl0LyeJTjfAmkUkA5eK7b5EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:pYhlYsylgWg-VoCZ2H0YUo45HIvaGaKIl49voCbc-MJVtO3fb1-HkQ>
    <xmx:pYhlYjSkfPZIvKX0dYZIH-eI7wBU1xv8uFfNR6IUky8ZrLvUqBKvaw>
    <xmx:pYhlYnY-b-dvZmc3eVwbq255GA3KjgO4K-0qnJNE6zor_lrzpPCrNw>
    <xmx:pYhlYrbayW1SxJxlACvqfPhKqeLYXAgvNchqRakR0czi_cMytfM4TQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 13:28:04 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 2/4] dmaengine: sun6i: Do not use virt_to_phys
Date:   Sun, 24 Apr 2022 12:27:56 -0500
Message-Id: <20220424172759.33383-3-samuel@sholland.org>
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

This breaks on RISC-V, because dma_pool_alloc returns addresses which
are not in the linear map. Instead, plumb through the physical address
which is already known anyway.

Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Fix format warnings

 drivers/dma/sun6i-dma.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5cadd4d2b824..4436fbd70445 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -241,9 +241,7 @@ static inline void sun6i_dma_dump_com_regs(struct sun6i_dma_dev *sdev)
 static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
 					    struct sun6i_pchan *pchan)
 {
-	phys_addr_t reg = virt_to_phys(pchan->base);
-
-	dev_dbg(sdev->slave.dev, "Chan %d reg: %pa\n"
+	dev_dbg(sdev->slave.dev, "Chan %d reg:\n"
 		"\t___en(%04x): \t0x%08x\n"
 		"\tpause(%04x): \t0x%08x\n"
 		"\tstart(%04x): \t0x%08x\n"
@@ -252,7 +250,7 @@ static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
 		"\t__dst(%04x): \t0x%08x\n"
 		"\tcount(%04x): \t0x%08x\n"
 		"\t_para(%04x): \t0x%08x\n\n",
-		pchan->idx, &reg,
+		pchan->idx,
 		DMA_CHAN_ENABLE,
 		readl(pchan->base + DMA_CHAN_ENABLE),
 		DMA_CHAN_PAUSE,
@@ -385,17 +383,16 @@ static void *sun6i_dma_lli_add(struct sun6i_dma_lli *prev,
 }
 
 static inline void sun6i_dma_dump_lli(struct sun6i_vchan *vchan,
-				      struct sun6i_dma_lli *lli)
+				      struct sun6i_dma_lli *v_lli,
+				      dma_addr_t p_lli)
 {
-	phys_addr_t p_lli = virt_to_phys(lli);
-
 	dev_dbg(chan2dev(&vchan->vc.chan),
-		"\n\tdesc:   p - %pa v - 0x%p\n"
+		"\n\tdesc:\tp - %pad v - 0x%p\n"
 		"\t\tc - 0x%08x s - 0x%08x d - 0x%08x\n"
 		"\t\tl - 0x%08x p - 0x%08x n - 0x%08x\n",
-		&p_lli, lli,
-		lli->cfg, lli->src, lli->dst,
-		lli->len, lli->para, lli->p_lli_next);
+		&p_lli, v_lli,
+		v_lli->cfg, v_lli->src, v_lli->dst,
+		v_lli->len, v_lli->para, v_lli->p_lli_next);
 }
 
 static void sun6i_dma_free_desc(struct virt_dma_desc *vd)
@@ -445,7 +442,7 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 	pchan->desc = to_sun6i_desc(&desc->tx);
 	pchan->done = NULL;
 
-	sun6i_dma_dump_lli(vchan, pchan->desc->v_lli);
+	sun6i_dma_dump_lli(vchan, pchan->desc->v_lli, pchan->desc->p_lli);
 
 	irq_reg = pchan->idx / DMA_IRQ_CHAN_NR;
 	irq_offset = pchan->idx % DMA_IRQ_CHAN_NR;
@@ -670,7 +667,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 
 	sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
 
-	sun6i_dma_dump_lli(vchan, v_lli);
+	sun6i_dma_dump_lli(vchan, v_lli, p_lli);
 
 	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
 
@@ -746,14 +743,16 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 	}
 
 	dev_dbg(chan2dev(chan), "First: %pad\n", &txd->p_lli);
-	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
-		sun6i_dma_dump_lli(vchan, prev);
+	for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
+	     p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
+		sun6i_dma_dump_lli(vchan, v_lli, p_lli);
 
 	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
 
 err_lli_free:
-	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
-		dma_pool_free(sdev->pool, prev, virt_to_phys(prev));
+	for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
+	     p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
+		dma_pool_free(sdev->pool, v_lli, p_lli);
 	kfree(txd);
 	return NULL;
 }
@@ -820,8 +819,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
 
 err_lli_free:
-	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
-		dma_pool_free(sdev->pool, prev, virt_to_phys(prev));
+	for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
+	     p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
+		dma_pool_free(sdev->pool, v_lli, p_lli);
 	kfree(txd);
 	return NULL;
 }
-- 
2.35.1

