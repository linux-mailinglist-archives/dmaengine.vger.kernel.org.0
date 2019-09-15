Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B925B2F11
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfIOHc1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:32:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42822 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOHc1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:32:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so237998pff.9;
        Sun, 15 Sep 2019 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPul5JuzdKo1YLlmlMUVEvVy40XkhDScmOvvCl/5Aqg=;
        b=BbWt2DLYK8AUxUs1ijP7jhTEmZRsuZlkVv0L7MhtdmA1ZVzYE6UYsyHSSUcsgrIBds
         pKQYa5d7HfA9clUZO9ZeUWzO4yc5xNnRd0Q0mIa+0miB4vSiw0UvhlcBM/idtYg6FszN
         UTv8U/1c1w+mD4qHiLLtv0+oI9WDvcyKPYwAlXPQPcefq9QHdY+zeiz8k3f+xjAaa0nZ
         xsNFZeYz3lqK9erPsssS8WMur4pGSMjbmPhzTedNaorSgfTQNxM0Y33O1UYora3+bYzU
         w4iHoRYMJw2D3/N+iwYzZsGDodt1pn0aPsX0H+FoFnidJs3zFZ7mBTll0auGC/AxKvq4
         OJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPul5JuzdKo1YLlmlMUVEvVy40XkhDScmOvvCl/5Aqg=;
        b=UC7txxlDgYwKRHzRmcBVbtu0Oi2xApQJilH7qdFDnq141PhnRY25TTtGFKak183lqB
         dgmHHaBSEMfjyddlulUQKUHmeJf+OSy3pRnyKaEI8tPcMW/V4Niy1PmgPFWRuVmnzprk
         8uLZKBbO15FTqenthYPgP7RXh4tU9Aei3BYDHOJT0xJnUwGwb0mHu4YEnuk6LOYs+qw8
         OM+RADmS4SpHQVEHOlH/bEPXEmCOMU3MWS5AjERcm0tn9bpe5dmscRjuRFZ7Ap4TnmaU
         AJPc3KNjeUaXS+sI19WeLQl+3b8QSAQ8Vs3LQ8PPl88vymhxb8B1/5hk94/Sj5gPSy7O
         XNmw==
X-Gm-Message-State: APjAAAXnA1BqjlcpHvuP1X4yoIPJ6JmkbQSLaHa5Dom5zy8B0Mh76xA0
        iGMnliWLs8IaApHViwh5OBA=
X-Google-Smtp-Source: APXvYqyXkwyCNKWe1ap8gdlQNYMaQ+xsRWuU3kxTWHyT3AZqbIjkAfdHvFTLTpgvyNIggQxhv3eSSA==
X-Received: by 2002:aa7:9486:: with SMTP id z6mr64991286pfk.118.1568532746548;
        Sun, 15 Sep 2019 00:32:26 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id f14sm44920340pfq.187.2019.09.15.00.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:32:25 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] probe/dma/axi: removed redundant code from axi dma controller's probe function
Date:   Sun, 15 Sep 2019 13:02:17 +0530
Message-Id: <20190915073217.24101-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190915072644.23329-1-sst2005@gmail.com>
References: <20190915072644.23329-1-sst2005@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1. In order to remove duplicate code, following functions:
platform_get_resource
devm_kzalloc
devm_ioremap_resource
devm_clk_get
platform_get_irq
clk_prepare_enable
are replaced with a macro devm_platform_probe_helper.

2. This patch depends on the file include/linux/probe-helper.h
which is pushed in previous patch [01/09].

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/dma-axi-dmac.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a0ee404b736e..ac8a2355b299 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/fpga/adi-axi-common.h>
+#include <linux/probe-helper.h>
 
 #include <dt-bindings/dma/axi-dmac.h>
 
@@ -829,28 +830,19 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	struct device_node *of_channels, *of_chan;
 	struct dma_device *dma_dev;
 	struct axi_dmac *dmac;
-	struct resource *res;
 	int ret;
 
-	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
-	if (!dmac)
-		return -ENOMEM;
-
-	dmac->irq = platform_get_irq(pdev, 0);
-	if (dmac->irq < 0)
-		return dmac->irq;
-	if (dmac->irq == 0)
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq
+	 */
+	ret = devm_platform_probe_helper(pdev, dmac, NULL);
+	if (ret < 0)
+		return ret;
+	else if (!dmac->irq)
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmac->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dmac->base))
-		return PTR_ERR(dmac->base);
-
-	dmac->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dmac->clk))
-		return PTR_ERR(dmac->clk);
-
 	INIT_LIST_HEAD(&dmac->chan.active_descs);
 
 	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
-- 
2.17.1

