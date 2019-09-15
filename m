Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604F5B2F0D
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfIOHbz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:31:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40510 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOHby (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:31:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so20535251pfb.7;
        Sun, 15 Sep 2019 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0DZe/s2/vHEDWjkZMS1zmvi4NsZEIq/1qP/znK935TQ=;
        b=ZfZ5uJOkXcijb1z+GqXDBCpSk0K10rTW5epVfdMwpJ0sQtC4xP+TyVfe2nF8YAgxsU
         qJS0C73jzw7UM6QUQ579KcOuDXGKpkGfzPV/tp7gb+7ecsj4JJQ6plI3JtPmtvr9Fmax
         uFXQsiFTe5us54At0SivWKJ1tTzeZeqL2DVs/rvaXaQm23avCPCG97VL5oxD/KAgMfyg
         zVa/RFNlCn3kwXddw87Gfa818o6mmG1BpAmEHykzM5kESMLk+OW1ijdy5ZBCoDkU0dYc
         71wMeNwdotk6vTtXfJryYveNv4V+sV9qW972v8PlpEATz8RYb/rKb7NevuQGFwflVz8f
         R9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0DZe/s2/vHEDWjkZMS1zmvi4NsZEIq/1qP/znK935TQ=;
        b=I8jibTD1bluqZlWxIAYNhD8xezdnU28zXpoAFp4Pw20aLp8/CMnVia0nyggMbEXfS4
         COEzJYjkAcH/GmMa37SD8/s6aaAVJIXqqxJsc4c8Cx+eLOc2pD9bERbThQU1NoTkRTmi
         uIGjQUyKyQ/35WLps8hNLRS/hFcdshdQjxFiOc5I0fgb6sfz2Mrt2tnuKVk9qfIX9YgS
         DqTl5XTVKjCNOGOvynkNKRWxiyry3d3NuN8qOwZSomRNWfKNYbDTJGdBvzjSpqwJWZ98
         siNEohzloCbWm/bvEtKKdNC1eqmAKWYY/F+FZ3HURVZcTkwtQ9uXzje9/BCefA5YY8Lh
         K3NA==
X-Gm-Message-State: APjAAAXR/uPFhQWvBBqUkJHXgBwC6/MSiVra7e4DzyWtpqigS2p9xq9a
        vDrT1RAAptHgmbpIQyyvadaum5P8c0y+ow==
X-Google-Smtp-Source: APXvYqycv60YtanN5Vu0TRpL2U5mtB8FDs+f7JRrqV4nnVE9qEcmwM7IZJEy/v83woF+LAH77BTX/Q==
X-Received: by 2002:a62:cf82:: with SMTP id b124mr64368927pfg.159.1568532714069;
        Sun, 15 Sep 2019 00:31:54 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id e192sm45142269pfh.83.2019.09.15.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:31:53 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] probe/dma/sun6i: removed redundant code from sun6i dma controller's probe function
Date:   Sun, 15 Sep 2019 13:01:44 +0530
Message-Id: <20190915073144.23965-1-sst2005@gmail.com>
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
are replaced with a macro devm_platform_probe_helper.

2. This patch depends on the file include/linux/probe-helper.h
which is pushed in previous patch [01/09].

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/sun6i-dma.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ed5b68dcfe50..41ee054bbeeb 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -19,6 +19,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/probe-helper.h>
 
 #include "virt-dma.h"
 
@@ -1234,34 +1235,21 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sun6i_dma_dev *sdc;
-	struct resource *res;
 	int ret, i;
 
-	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
-	if (!sdc)
-		return -ENOMEM;
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq
+	 */
+	ret = devm_platform_probe_helper(pdev, sdc, NULL);
+	if (ret < 0)
+		return ret;
 
 	sdc->cfg = of_device_get_match_data(&pdev->dev);
 	if (!sdc->cfg)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sdc->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(sdc->base))
-		return PTR_ERR(sdc->base);
-
-	sdc->irq = platform_get_irq(pdev, 0);
-	if (sdc->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		return sdc->irq;
-	}
-
-	sdc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sdc->clk)) {
-		dev_err(&pdev->dev, "No clock specified\n");
-		return PTR_ERR(sdc->clk);
-	}
-
 	if (sdc->cfg->has_mbus_clk) {
 		sdc->clk_mbus = devm_clk_get(&pdev->dev, "mbus");
 		if (IS_ERR(sdc->clk_mbus)) {
-- 
2.17.1

