Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8A6E41B4
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjDQH4E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 03:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDQH4A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 03:56:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE053359C
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ec9c7c6986so1185540e87.0
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718156; x=1684310156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raEcrPxjmvIorgt3QUQP2yO/QZWKTGTiFhKTb/g/MHU=;
        b=WQvI0XMCf+Pgy2E7m3MhIJQC3jvWr5xauHbQzB7292ATdg6cXkXtPuAFS+s4Ie7sjB
         EPwa/d0xxX5BgRc8FK3EpWbpN2SZf5NBBYNAnRytTPzvh/a2xYPTrhBb1SKKlCBKM0HC
         gvbmkLTRu5WHLhhyYkcZgSrF0cPGVPOvorlaggHNa1ZXWnclyTX5Eg56lIvqNXLXYRZ0
         pvLz6uaC/yBl0v2aO0tDdqOtIAUNnwutdBGHOwoGLFuUJnFRNKS/V5i6rE+amerWeF7J
         ZZLGqijPVgcohhB6n80w2flAO5FBGblPDocxELnNvq+JrCHG/Sji/7PKFKbsew6oBTiP
         Forw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718156; x=1684310156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raEcrPxjmvIorgt3QUQP2yO/QZWKTGTiFhKTb/g/MHU=;
        b=l5DrYerSEfBnam5bA4A01E46mllCYW2YH7voNCtW1m2pIMBhMLumYvSRrEi4fPpUcR
         m3gci/BavZdtoms2gd2lt4FMyPMQcAFtv4hC02PKUDz59z0bhmdpCYUSUTVwHs7KqyLi
         gLVYlUQguYzc1BDhUH0rxccMWkuwa9hcBTZfW4lcQgo/Nyp8ylMn2oAJtrBpom30UEcS
         pcXcvMMNVy/V/AOSQLVqnddeaKLTuCQ0E4f3WIV8/CEiyG8nKdiQt3rY8txfo8rDALtm
         Fi7b8MRVsyDVSJ6R0S+8Qpj2X/pO9aZB+QAH562D22DcMchs1nnMTvwWFSpe1oqRrfVY
         0fzw==
X-Gm-Message-State: AAQBX9cqu4poYRqaaWoOnoCcY1UlL3H0RJWZHI6bx6KDquHQQafe0dNF
        2qnnVdIwRnko/VHXwdBra5JjjA==
X-Google-Smtp-Source: AKy350ZgjIY+yG5oaRxLHW5UscfH/erx5atBNJjyB9TLrOROFCjGCcMQOl4hQqB6ikN/bo8DRLpXHg==
X-Received: by 2002:ac2:5dc7:0:b0:4ec:9c2e:7edb with SMTP id x7-20020ac25dc7000000b004ec9c2e7edbmr1554419lfq.42.1681718155874;
        Mon, 17 Apr 2023 00:55:55 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004eb274b3a43sm1952547lfc.134.2023.04.17.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:55:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:55:48 +0200
Subject: [PATCH 3/7] dmaengine: ste_dma40: Add dev helper variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v1-3-b26324956e47@linaro.org>
References: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The &pdev->dev device pointer is used so many times in the
probe() and d40_hw_detect_init() functions that a local *dev
variable makes the code way easier to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c | 50 +++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 236269d35a53..ef2a2fdaa82e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3104,6 +3104,7 @@ static int __init d40_phy_res_init(struct d40_base *base)
 static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	void __iomem *virtbase;
 	struct resource *res;
@@ -3117,15 +3118,15 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	u32 cid;
 	u8 rev;
 
-	clk = clk_get(&pdev->dev, NULL);
+	clk = clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
-		d40_err(&pdev->dev, "No matching clock found\n");
+		d40_err(dev, "No matching clock found\n");
 		goto check_prepare_enabled;
 	}
 
 	clk_ret = clk_prepare_enable(clk);
 	if (clk_ret) {
-		d40_err(&pdev->dev, "Failed to prepare/enable clock\n");
+		d40_err(dev, "Failed to prepare/enable clock\n");
 		goto disable_unprepare;
 	}
 
@@ -3151,11 +3152,11 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 			& 255) << (i * 8);
 
 	if (cid != AMBA_CID) {
-		d40_err(&pdev->dev, "Unknown hardware! No PrimeCell ID\n");
+		d40_err(dev, "Unknown hardware! No PrimeCell ID\n");
 		goto unmap_io;
 	}
 	if (AMBA_MANF_BITS(pid) != AMBA_VENDOR_ST) {
-		d40_err(&pdev->dev, "Unknown designer! Got %x wanted %x\n",
+		d40_err(dev, "Unknown designer! Got %x wanted %x\n",
 			AMBA_MANF_BITS(pid),
 			AMBA_VENDOR_ST);
 		goto unmap_io;
@@ -3171,7 +3172,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	 */
 	rev = AMBA_REV_BITS(pid);
 	if (rev < 2) {
-		d40_err(&pdev->dev, "hardware revision: %d is not supported", rev);
+		d40_err(dev, "hardware revision: %d is not supported", rev);
 		goto unmap_io;
 	}
 
@@ -3189,7 +3190,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 
 	num_log_chans = num_phy_chans * D40_MAX_LOG_CHAN_PER_PHY;
 
-	dev_info(&pdev->dev,
+	dev_info(dev,
 		 "hardware rev: %d @ %pa with %d physical and %d logical channels\n",
 		 rev, &res->start, num_phy_chans, num_log_chans);
 
@@ -3209,7 +3210,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	base->phy_size = resource_size(res);
 	base->virtbase = virtbase;
 	base->plat_data = plat_data;
-	base->dev = &pdev->dev;
+	base->dev = dev;
 	base->phy_chans = ((void *)base) + ALIGN(sizeof(struct d40_base), 4);
 	base->log_chans = &base->phy_chans[num_phy_chans];
 
@@ -3505,7 +3506,8 @@ static int __init d40_of_probe(struct platform_device *pdev,
 
 static int __init d40_probe(struct platform_device *pdev)
 {
-	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct stedma40_platform_data *plat_data = dev_get_platdata(dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
 	int ret = -ENOENT;
@@ -3522,7 +3524,7 @@ static int __init d40_probe(struct platform_device *pdev)
 				goto report_failure;
 			}
 		} else {
-			d40_err(&pdev->dev, "No pdata or Device Tree provided\n");
+			d40_err(dev, "No pdata or Device Tree provided\n");
 			goto report_failure;
 		}
 	}
@@ -3541,24 +3543,24 @@ static int __init d40_probe(struct platform_device *pdev)
 	/* Get IO for logical channel parameter address (LCPA) */
 	np_lcpa = of_parse_phandle(np, "sram", 0);
 	if (!np_lcpa) {
-		dev_err(&pdev->dev, "no LCPA SRAM node\n");
+		dev_err(dev, "no LCPA SRAM node\n");
 		goto report_failure;
 	}
 	/* This is no device so read the address directly from the node */
 	ret = of_address_to_resource(np_lcpa, 0, &res_lcpa);
 	if (ret) {
-		dev_err(&pdev->dev, "no LCPA SRAM resource\n");
+		dev_err(dev, "no LCPA SRAM resource\n");
 		goto report_failure;
 	}
 	base->lcpa_size = resource_size(&res_lcpa);
 	base->phy_lcpa = res_lcpa.start;
-	dev_info(&pdev->dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
+	dev_info(dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
 		 base->phy_lcpa, base->lcpa_size);
 
 	/* We make use of ESRAM memory for this. */
 	val = readl(base->virtbase + D40_DREG_LCPA);
 	if (base->phy_lcpa != val && val != 0) {
-		dev_warn(&pdev->dev,
+		dev_warn(dev,
 			 "[%s] Mismatch LCPA dma 0x%x, def %08x\n",
 			 __func__, val, base->phy_lcpa);
 	} else
@@ -3567,7 +3569,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	base->lcpa_base = ioremap(base->phy_lcpa, base->lcpa_size);
 	if (!base->lcpa_base) {
 		ret = -ENOMEM;
-		d40_err(&pdev->dev, "Failed to ioremap LCPA region\n");
+		d40_err(dev, "Failed to ioremap LCPA region\n");
 		goto release_base;
 	}
 	/* If lcla has to be located in ESRAM we don't need to allocate */
@@ -3576,7 +3578,7 @@ static int __init d40_probe(struct platform_device *pdev)
 							"lcla_esram");
 		if (!res) {
 			ret = -ENOENT;
-			d40_err(&pdev->dev,
+			d40_err(dev,
 				"No \"lcla_esram\" memory resource\n");
 			goto destroy_cache;
 		}
@@ -3584,7 +3586,7 @@ static int __init d40_probe(struct platform_device *pdev)
 						resource_size(res));
 		if (!base->lcla_pool.base) {
 			ret = -ENOMEM;
-			d40_err(&pdev->dev, "Failed to ioremap LCLA region\n");
+			d40_err(dev, "Failed to ioremap LCLA region\n");
 			goto destroy_cache;
 		}
 		writel(res->start, base->virtbase + D40_DREG_LCLA);
@@ -3592,7 +3594,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	} else {
 		ret = d40_lcla_allocate(base);
 		if (ret) {
-			d40_err(&pdev->dev, "Failed to allocate LCLA area\n");
+			d40_err(dev, "Failed to allocate LCLA area\n");
 			goto destroy_cache;
 		}
 	}
@@ -3603,7 +3605,7 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
 	if (ret) {
-		d40_err(&pdev->dev, "No IRQ defined\n");
+		d40_err(dev, "No IRQ defined\n");
 		goto destroy_cache;
 	}
 
@@ -3611,7 +3613,7 @@ static int __init d40_probe(struct platform_device *pdev)
 
 		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
 		if (IS_ERR(base->lcpa_regulator)) {
-			d40_err(&pdev->dev, "Failed to get lcpa_regulator\n");
+			d40_err(dev, "Failed to get lcpa_regulator\n");
 			ret = PTR_ERR(base->lcpa_regulator);
 			base->lcpa_regulator = NULL;
 			goto destroy_cache;
@@ -3619,7 +3621,7 @@ static int __init d40_probe(struct platform_device *pdev)
 
 		ret = regulator_enable(base->lcpa_regulator);
 		if (ret) {
-			d40_err(&pdev->dev,
+			d40_err(dev,
 				"Failed to enable lcpa_regulator\n");
 			regulator_put(base->lcpa_regulator);
 			base->lcpa_regulator = NULL;
@@ -3642,7 +3644,7 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
 	if (ret) {
-		d40_err(&pdev->dev, "Failed to set dma max seg size\n");
+		d40_err(dev, "Failed to set dma max seg size\n");
 		goto destroy_cache;
 	}
 
@@ -3651,7 +3653,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	if (np) {
 		ret = of_dma_controller_register(np, d40_xlate, NULL);
 		if (ret)
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"could not register of_dma_controller\n");
 	}
 
@@ -3701,7 +3703,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	kfree(base->phy_res);
 	kfree(base);
  report_failure:
-	d40_err(&pdev->dev, "probe failed\n");
+	d40_err(dev, "probe failed\n");
 	return ret;
 }
 

-- 
2.39.2

