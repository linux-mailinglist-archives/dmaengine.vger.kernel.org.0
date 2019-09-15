Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E3B2F05
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfIOHaj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:30:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42870 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOHaj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:30:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so4078941pls.9;
        Sun, 15 Sep 2019 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dMeTUZXRAUHh0+qJ13H8cie73F/u28qD7x83pAfJ/9Q=;
        b=p23CT3gRcvap2xtcYSdgl1DJX7+YD+Tc3MWZ5tZ69jtgHNh3opMLs4hhDeohqTQ8lT
         LMQWcvKLaNOVZY0kZU+RQIPGRJF/ifS1NIFJ7PUaLTmUPVERkqIzX2T9yOQ9Is65TwT7
         Ccz+mvMBo/km8JEOnM++YPtHzltCjorO3l3tk+0BU2QL+rRuWkn9v8/ZRjdIRF1tGcx4
         OONKF9e06k8/KBjzjmaX2Oh2EJsAjAHr5zOK3PfHQfWYpnUeaZ4jOf3Kk7V/EPAmf/Dl
         +T3xioo6um5zvmTbImxMYoMC8gPzEAAQlehSsKGfacysFWpV6c1nyKEeyB5Gy4GMBLp8
         TIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dMeTUZXRAUHh0+qJ13H8cie73F/u28qD7x83pAfJ/9Q=;
        b=sgyXfJKoWBcHi48RcRJgENPGiUtbbZETy4mXcRKTugiMwQ/41i90+HatghwVmeeeKr
         ehFXxgfk8py1Pvhc/SKMC+463Pv3JPe6hspexNticB0OTj9hPSuvpcwU+hFwQpkzUqcY
         IUvqsBEoAFRmtnHdZBWfMO1vv6rPxg+OV6IbrtczFx/02UfZZWgjvLTff8fG5F1Vwfry
         QVYp1JHdCzgS2r094DUAzBOQcvTjmiftfge5ibs8qbjyLU1ZqfDNpmbksOcXNNhoErry
         8YiSQ6Vf1xW4HH0kdmbTQ1WxPABKAs9ZzGNFksr6T45mhYce36/tb8n/d14RBeF5DTsE
         W2Xw==
X-Gm-Message-State: APjAAAUwh/NG5+MA7n9uWjPoqHgNdNSk9rRRFE2L5oWI01cvGEj3g9Ab
        f25+1EyZ1YxshQVI0J7QxBo=
X-Google-Smtp-Source: APXvYqzdSFdn/APC8Kl3rfSziRAIhmZhHdVJdjZRPZa5vfYcn6CxiIhCmbCNhMIdxW/OH/TLwQlvrg==
X-Received: by 2002:a17:902:9681:: with SMTP id n1mr5657126plp.89.1568532638710;
        Sun, 15 Sep 2019 00:30:38 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id y12sm195702pfe.165.2019.09.15.00.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:30:38 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] probe/dma/qcom-bam: removed redundant code from qcom bam dma controller's probe function
Date:   Sun, 15 Sep 2019 13:00:20 +0530
Message-Id: <20190915073021.23738-1-sst2005@gmail.com>
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
are replaced with a macro devm_platform_probe_helper_clk.

2. Renamed variables regs and bamclk so that helper macro can
be applied.

3. This patch depends on the file include/linux/probe-helper.h
which is pushed in previous patch [01/09].

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 71 ++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 8e90a405939d..06c136ca8e40 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -41,6 +41,7 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/pm_runtime.h>
+#include <linux/probe-helper.h>
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"
@@ -378,7 +379,7 @@ static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
 }
 
 struct bam_device {
-	void __iomem *regs;
+	void __iomem *base;
 	struct device *dev;
 	struct dma_device common;
 	struct device_dma_parameters dma_parms;
@@ -392,7 +393,7 @@ struct bam_device {
 
 	const struct reg_offset_data *layout;
 
-	struct clk *bamclk;
+	struct clk *clk;
 	int irq;
 
 	/* dma start transaction tasklet */
@@ -410,7 +411,7 @@ static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
 {
 	const struct reg_offset_data r = bdev->layout[reg];
 
-	return bdev->regs + r.base_offset +
+	return bdev->base + r.base_offset +
 		r.pipe_mult * pipe +
 		r.evnt_mult * pipe +
 		r.ee_mult * bdev->ee;
@@ -1209,41 +1210,41 @@ static int bam_dma_probe(struct platform_device *pdev)
 {
 	struct bam_device *bdev;
 	const struct of_device_id *match;
-	struct resource *iores;
 	int ret, i;
-
-	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
-	if (!bdev)
-		return -ENOMEM;
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq, clk_prepare_enable
+	 */
+	ret = devm_platform_probe_helper_clk(pdev, bdev, "bam_clk");
+	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
+						"qcom,controlled-remotely");
+	if (ret < 0) {
+		if (IS_ERR(bdev->clk)) {
+			if (!bdev->controlled_remotely)
+				return ret;
+			bdev->clk = NULL;
+		} else
+			return ret;
+	}
 
 	bdev->dev = &pdev->dev;
 
 	match = of_match_node(bam_of_match, pdev->dev.of_node);
 	if (!match) {
 		dev_err(&pdev->dev, "Unsupported BAM module\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_disable_clk;
 	}
 
 	bdev->layout = match->data;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bdev->regs = devm_ioremap_resource(&pdev->dev, iores);
-	if (IS_ERR(bdev->regs))
-		return PTR_ERR(bdev->regs);
-
-	bdev->irq = platform_get_irq(pdev, 0);
-	if (bdev->irq < 0)
-		return bdev->irq;
-
 	ret = of_property_read_u32(pdev->dev.of_node, "qcom,ee", &bdev->ee);
 	if (ret) {
 		dev_err(bdev->dev, "Execution environment unspecified\n");
-		return ret;
+		goto err_disable_clk;
 	}
 
-	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
-						"qcom,controlled-remotely");
-
 	if (bdev->controlled_remotely) {
 		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
 					   &bdev->num_channels);
@@ -1256,20 +1257,6 @@ static int bam_dma_probe(struct platform_device *pdev)
 			dev_err(bdev->dev, "num-ees unspecified in dt\n");
 	}
 
-	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
-	if (IS_ERR(bdev->bamclk)) {
-		if (!bdev->controlled_remotely)
-			return PTR_ERR(bdev->bamclk);
-
-		bdev->bamclk = NULL;
-	}
-
-	ret = clk_prepare_enable(bdev->bamclk);
-	if (ret) {
-		dev_err(bdev->dev, "failed to prepare/enable clock\n");
-		return ret;
-	}
-
 	ret = bam_init(bdev);
 	if (ret)
 		goto err_disable_clk;
@@ -1359,7 +1346,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 err_tasklet_kill:
 	tasklet_kill(&bdev->task);
 err_disable_clk:
-	clk_disable_unprepare(bdev->bamclk);
+	clk_disable_unprepare(bdev->clk);
 
 	return ret;
 }
@@ -1393,7 +1380,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 
 	tasklet_kill(&bdev->task);
 
-	clk_disable_unprepare(bdev->bamclk);
+	clk_disable_unprepare(bdev->clk);
 
 	return 0;
 }
@@ -1402,7 +1389,7 @@ static int __maybe_unused bam_dma_runtime_suspend(struct device *dev)
 {
 	struct bam_device *bdev = dev_get_drvdata(dev);
 
-	clk_disable(bdev->bamclk);
+	clk_disable(bdev->clk);
 
 	return 0;
 }
@@ -1412,7 +1399,7 @@ static int __maybe_unused bam_dma_runtime_resume(struct device *dev)
 	struct bam_device *bdev = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_enable(bdev->bamclk);
+	ret = clk_enable(bdev->clk);
 	if (ret < 0) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
 		return ret;
@@ -1428,7 +1415,7 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
 	if (!bdev->controlled_remotely)
 		pm_runtime_force_suspend(dev);
 
-	clk_unprepare(bdev->bamclk);
+	clk_unprepare(bdev->clk);
 
 	return 0;
 }
@@ -1438,7 +1425,7 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
 	struct bam_device *bdev = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare(bdev->bamclk);
+	ret = clk_prepare(bdev->clk);
 	if (ret)
 		return ret;
 
-- 
2.17.1

