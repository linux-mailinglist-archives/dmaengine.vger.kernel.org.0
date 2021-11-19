Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E924569B9
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 06:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhKSFaL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 00:30:11 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40239 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhKSFaK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 00:30:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0147A3201C38;
        Fri, 19 Nov 2021 00:27:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 Nov 2021 00:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Hj1SheuYYwR1t
        vA6LCDRVdTH6OCNS3lyYzcUrbKLHUo=; b=Sa4JsDEn7DgPCJLy4fGfKBdK68Ron
        IHJvjMkFnIdj30DBxYl5BIboUXY3zyd/rMRMBkbLa2ERJbrl6MquQ/4+EH22mf9n
        w7InzPrPp5Xlpp1op5EtBf300dtP8kyVT3S+9cVkOIodjMY/+t1DOPa86o8zDp1S
        CHYvm4rHsPlNjraqqUppvdmfXBqxf7/8R4JqQOL98i6BvW6D5PB2WWTnacXkLt+m
        52TCne2b9qEQcID0NXJmeb3NhZ95E2ZlwUXJ8jnkE5cg5qV0DyDCxX8LPG66+uYg
        sp/0m5t7aZV6TG2w4YK+ZHYk4bL2zSHRSGdw1S2UhAedwYL5KoLiuCbQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Hj1SheuYYwR1tvA6LCDRVdTH6OCNS3lyYzcUrbKLHUo=; b=joyRLk7J
        KbCOltc6VUnIi4AxFdDRVF/d7vZbEfAVkCfOhDpZf/A2zOv4wmIshQFXZjO8738y
        dw+dAophoNcutyQPIsCU2EWQDRbl4z1+Ta1/XhNHEFp3Wq7UMhsw0/gKHXV1+Z9u
        rrQy/y5BkT3lvQY3KfFOJUhe4TlTz4sPSKfwnCbD8lot5Q7TWTVse1PEFz2Y7Lou
        YRD/b2zjeZdEUcq3fdfbBS5MZbVrJ66IwCuVeMJKxvtk4YDdGjT7uda6XotiO3iH
        8MXe/OL9QhWCJn/q6U+EzzkriSPyQ2Sa2+mm19bOTR1ofwI2++lWe9yzbBYXYwz4
        Tv+7mDUDMF/g4w==
X-ME-Sender: <xms:rDWXYUpbBk5FapvZkYVPAnjw2RqMdda_ciBSFShMiFvj3H9oQmJSDg>
    <xme:rDWXYap254oJoXteuunE7agF1CU_QEG0mntNYwP8uweh_yBGzB96nwnnS1d14Shin
    l1l3yqnE-dHC2BsYA>
X-ME-Received: <xmr:rDWXYZOaQuEOc6AAA6segdeV5qKUI5K9HHTIO9-oT3ha9lfueHgeoy2dfiyJheY3TzQKUBbZa2TL1sU8ZeWhmwhaqOs7256lmTIXoRF-gvImwOO-XA6PQARzzuGyQuhjQygySA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:rDWXYb5Oo_455RGG7rfydd4vouQFyeQrbfleIyWuanELQFN6cKoSGw>
    <xmx:rDWXYT7_sruTLf-6pvdO6Ki_1ZPJBy_TiO-x8HDsTo_0rHjXMQRLsw>
    <xmx:rDWXYbj9lk4PrVS0IKqG1W8d4M4KYSH0qQkSbzLo8M0n7MSgAAnVhQ>
    <xmx:rDWXYWb_I4uMeZEjrHBSHELQrI79f5PRdXHGArSsxtnJL8wtWLaK0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Nov 2021 00:27:08 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/4] dmaengine: sun6i: Do not use virt_to_phys
Date:   Thu, 18 Nov 2021 23:26:59 -0600
Message-Id: <20211119052702.14392-3-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119052702.14392-1-samuel@sholland.org>
References: <20211119052702.14392-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This breaks on RISC-V, because dma_pool_alloc returns addresses which
are not in the linear map. Instead, plumb through the physical address
which is already known anyway.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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
2.32.0

