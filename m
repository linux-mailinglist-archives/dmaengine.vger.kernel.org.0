Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D84FB30F
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 06:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiDKEtA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 00:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbiDKEs4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 00:48:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485F35ABE;
        Sun, 10 Apr 2022 21:46:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B8F403200993;
        Mon, 11 Apr 2022 00:46:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Apr 2022 00:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649652401; x=1649738801; bh=mB
        +nLCZ+L9sywRzCC2aZPrLE0+qzIdPX9BHY90NKeFs=; b=X0n6WLnlSy1Fsem0KT
        Ftu/US7pYvSd7gNGQ3OYU46BQqY/JrdWULtCwwGvPu5OfIPw19PX83MFEWUfSdQ/
        rEquZShmvuEYuNeJiuzWgha2LXajZ4voBWARWF0/F9nNcXd31OTqtnogaW0HKdgU
        dNM4OAzOi5fA/wcuqOPFQ3qd9kUQhm+ILC5CaSwF0j7S6TXEUtaLZNtZMQiGYzEF
        MGxrynkRz9Tfydccj79FQZNj/MLXjfSJVyu8AbHW8iWAfOMoFTlVh1PZNmCJITSp
        BZqm9UBvDE1cM36gqszIB9RCvd4INhBXws8PorS9NOv9C3+L6kbpIdHDlAnXOI7h
        eq7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649652401; x=1649738801; bh=mB+nLCZ+L9sywRzCC2aZPrLE0+qzIdPX9BH
        Y90NKeFs=; b=mH2xC6SDexAJ+IYea8WxPjkDleOF9cZbDGw2wAbzxf1BTZxwb2o
        zh2Vyh+ZplTG1e123ptFuxzUNxAPsPsSsTqZGu+pbiaezeLr2rJyb1EGsZhO/kcg
        9KwaPAF8b3etiXQua3gfClCZvXXl+02P1R1dnvk5n7ALwmLTPotLw4xchaQ0fbrR
        oTX/Xt7ARgvbh5S5fwtu9prliXPxaMIaSz/YkEy4bDrbQXGQDGIEUlx9xPKXvD2D
        BWAQpL7Gw/Ao6WXjW0D/YNwLB/t45NZZbaSj5hbhyhMRRZ6NjkTcws+CdZ+Jidls
        WOhaqnJ//F//pytWOrmeb8Elt1Mv/oiTggA==
X-ME-Sender: <xms:sbJTYh5egS0sdY_f4hSLrbJLPxKsxlcek7-0yCiQlix8nKtddR3LPw>
    <xme:sbJTYu4iQqoxPliY6qDQxaWPd0niuoyEqM0hzYUc_dQYg9yhSPmZ-Jd-0AfLVMWSo
    Fc2fdvq39EUw2e6jg>
X-ME-Received: <xmr:sbJTYocLU3jXP_Vwh7Nioo4Cq2P7TqO0qIwp77gOm0tBX0V-wWVmDG7LQioSPwcUnlRLxMueWJWI1EhD2uOAO0hkU_TC_vb2QNVUJZVi8A7WQRdgIZ6JqMvhRvWOKrVSNkvoTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:sbJTYqKeDs-EAZ6sv6pqWxkW7--KknW6vDLx1MAbSRJvHK3x69bdfg>
    <xmx:sbJTYlLbWkF-GtHm3v2S5uuVN_5gn0JsHBR2Xjsz9iLxhf_PhPkBRA>
    <xmx:sbJTYjyqOUErxJoH-vgJQzKFHG4RgDRT_P77SjPeZbuuKyiQaI8S3w>
    <xmx:sbJTYvzDvuTF7yh1bsUBvOsUJDZkLgQ88J7jp15iQOjqsbLhP7uK5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:46:40 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 2/4] dmaengine: sun6i: Do not use virt_to_phys
Date:   Sun, 10 Apr 2022 23:46:30 -0500
Message-Id: <20220411044633.39014-3-samuel@sholland.org>
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

This breaks on RISC-V, because dma_pool_alloc returns addresses which
are not in the linear map. Instead, plumb through the physical address
which is already known anyway.

Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/dma/sun6i-dma.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5cadd4d2b824..a9334f969b28 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -241,9 +241,7 @@ static inline void sun6i_dma_dump_com_regs(struct sun6i_dma_dev *sdev)
 static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
 					    struct sun6i_pchan *pchan)
 {
-	phys_addr_t reg = virt_to_phys(pchan->base);
-
-	dev_dbg(sdev->slave.dev, "Chan %d reg: %pa\n"
+	dev_dbg(sdev->slave.dev, "Chan %d reg: 0x%lx\n"
 		"\t___en(%04x): \t0x%08x\n"
 		"\tpause(%04x): \t0x%08x\n"
 		"\tstart(%04x): \t0x%08x\n"
@@ -252,7 +250,7 @@ static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
 		"\t__dst(%04x): \t0x%08x\n"
 		"\tcount(%04x): \t0x%08x\n"
 		"\t_para(%04x): \t0x%08x\n\n",
-		pchan->idx, &reg,
+		pchan->idx, pchan->base - sdev->base,
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

