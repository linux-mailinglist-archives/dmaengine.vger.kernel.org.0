Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEBCA990E
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfIEDzQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 23:55:16 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:41154 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIEDzP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Sep 2019 23:55:15 -0400
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2019 23:55:14 EDT
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-06.nifty.com with ESMTP id x853g6jX011050
        for <dmaengine@vger.kernel.org>; Thu, 5 Sep 2019 12:42:06 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x853fY68003716;
        Thu, 5 Sep 2019 12:41:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x853fY68003716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567654895;
        bh=R46SqTBG0wiskAaYxuXipqRLOslxanzHTdul3DZROHA=;
        h=From:To:Cc:Subject:Date:From;
        b=gv5Y3PoZTVKNnNJlAVgNZCYAMA72KKtMMFDvlAhmFn2EpRR2yChDvt3wababkCszC
         HHY21EZLMBcHIcaahCgEr4j7ZAyYb3wxK2UmxQdOAd7arl/8TcNvAxPYuRfHaNq4PY
         dUNc1yK1b7AGXq3L1LUq2yzWwiQ2zYn2seXtQWtKJsJAOF0ZmLaGfi6JQMNH3ZME0X
         fZqvqKfLsR58uvg84zWeCYhhRDilgEERcDRB41+8yzsfLQy6kZNlmoUQUJxIv1of9d
         X9LEnsW5HeBrk7ClwAMnKWyna+X8DDcrzqE+M+9E3cm8uhLqs4BnBYQGyuL2VsBS7V
         p64SIMHKVZyKQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: uniphier-mdmac: use devm_platform_ioremap_resource()
Date:   Thu,  5 Sep 2019 12:41:33 +0900
Message-Id: <20190905034133.29514-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace the chain of platform_get_resource() and devm_ioremap_resource()
with devm_platform_ioremap_resource().

This allows to remove the local variable for (struct resource *), and
have one function call less.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/dma/uniphier-mdmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index ec65a7430dc4..e42f2312b7a1 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -385,7 +385,6 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct uniphier_mdmac_device *mdev;
 	struct dma_device *ddev;
-	struct resource *res;
 	int nr_chans, ret, i;
 
 	nr_chans = platform_irq_count(pdev);
@@ -401,8 +400,7 @@ static int uniphier_mdmac_probe(struct platform_device *pdev)
 	if (!mdev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdev->reg_base = devm_ioremap_resource(dev, res);
+	mdev->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdev->reg_base))
 		return PTR_ERR(mdev->reg_base);
 
-- 
2.17.1

