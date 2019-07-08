Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A073B619D0
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2019 06:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfGHEUw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jul 2019 00:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfGHEUw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Jul 2019 00:20:52 -0400
Received: from localhost (unknown [49.207.58.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F84420659;
        Mon,  8 Jul 2019 04:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562559652;
        bh=3wZD58tp9mnWfaLtCngO7bIDdHwZX+UzA+iianPh1Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0hseX16jvVjtegeR6Rdz8wsWyEs7Dza6o9rVzqdlGvZqyeb/rTQiBLIjuHC6iMcK
         X7/Xsg0FIfQgBNV98CuAv/BAmfeSoT+6cs5c1/LL6KS95CXLVnTgqk6vZ4mIcYeN4P
         4EmvoOgBZEiTZSRlVZprQk3LzVDMiLGDLDPSBpHU=
Date:   Mon, 8 Jul 2019 09:47:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dma <dmaengine@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: Re: linux-next: build failure after merge of the slave-dma tree
Message-ID: <20190708041728.GK2911@vkoul-mobl>
References: <20190704173108.0646eef8@canb.auug.org.au>
 <VE1PR04MB6638080C43EC68EFF9F7B38A89F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <58c9b815-9bfc-449c-6017-c6da582dffc5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58c9b815-9bfc-449c-6017-c6da582dffc5@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-19, 11:06, zhangfei wrote:
> Hi, Robin
> 
> On 2019/7/8 上午9:22, Robin Gong wrote:
> > Hi Stephen,
> > 	That's caused by 'of_irq_count' NOT export to global symbol, and I'm curious why it has been
> > here for so long since Zhangfei found it in 2015. https://patchwork.kernel.org/patch/7404681/
> > Hi Rob,
> > 	Is there something I miss so that Zhangfei's patch not accepted finally?
> > 
> > 
> 
> I remembered Rob suggested us not using of_irq_count and use
> platform_get_irq etc.
> https://lkml.org/lkml/2015/11/18/466

The explanation looks sane to me, so it makes sense to revert the commit
for now. Reverted now

-- >8 --

From 5c274ca4cfb22a455e880f61536b1894fa29fd17 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vkoul@kernel.org>
Date: Mon, 8 Jul 2019 09:42:55 +0530
Subject: [PATCH] dmaengine: Revert "dmaengine: fsl-edma: add i.mx7ulp edma2
 version support"

This reverts commit 7144afd025b2 ("dmaengine: fsl-edma: add i.mx7ulp
edma2 version support") as this fails to build with module option due to
usage of of_irq_count() which is not an exported symbol as kernel
drivers are *not* expected to use it (rightly so).

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/fsl-edma-common.c | 18 +---------
 drivers/dma/fsl-edma-common.h |  4 ---
 drivers/dma/fsl-edma.c        | 66 -----------------------------------
 3 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 6d6d8a4e8e38..44d92c34dec3 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -90,19 +90,6 @@ static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 	iowrite8(val8, addr + off);
 }
 
-void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
-		     u32 off, u32 slot, bool enable)
-{
-	u32 val;
-
-	if (enable)
-		val = EDMAMUX_CHCFG_ENBL << 24 | slot;
-	else
-		val = EDMAMUX_CHCFG_DIS;
-
-	iowrite32(val, addr + off * 4);
-}
-
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable)
 {
@@ -116,10 +103,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-	if (fsl_chan->edma->drvdata->version == v3)
-		mux_configure32(fsl_chan, muxaddr, ch_off, slot, enable);
-	else
-		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
+	mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
 }
 EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 5eaa2902ed39..4e175560292c 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -125,7 +125,6 @@ struct fsl_edma_chan {
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
-	char				chan_name[16];
 };
 
 struct fsl_edma_desc {
@@ -140,13 +139,11 @@ struct fsl_edma_desc {
 enum edma_version {
 	v1, /* 32ch, Vybrid, mpc57x, etc */
 	v2, /* 64ch Coldfire */
-	v3, /* 32ch, i.mx7ulp */
 };
 
 struct fsl_edma_drvdata {
 	enum edma_version	version;
 	u32			dmamuxs;
-	bool			has_dmaclk;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
 };
@@ -156,7 +153,6 @@ struct fsl_edma_engine {
 	void __iomem		*membase;
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
-	struct clk		*dmaclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 50fe196b0c73..e616425acd5f 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -166,50 +166,6 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 	return 0;
 }
 
-static int
-fsl_edma2_irq_init(struct platform_device *pdev,
-		   struct fsl_edma_engine *fsl_edma)
-{

-- 
~Vinod
