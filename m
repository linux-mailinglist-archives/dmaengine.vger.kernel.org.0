Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5B6F056A
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbjD0MKJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbjD0MKF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 08:10:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148A469E
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4efe8991bafso6888345e87.0
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682597402; x=1685189402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dzjqDUqhlpwIVqCpt+cUtHh+EAeuNijiG89uyJMVyE=;
        b=GE0B2hlfsZ7HsdMx37vjGXXwJpLwp2GmtgxQ5XGC/Yt42Zf7fMYnoGrpZjrQ816WGx
         uS2GsUFIQ7JfTyPqqtUtIJsbwf+Zpnv6h6T/mrldPoS8Bs3eqXhNqPAl9rUpw5vaW7Uh
         ac7e7w3is/Hs3OpG+qgCF6njW2jqWCXVIoYFQKZj1hihJn6pajlGktWxvh0XmFZg0HYI
         B6SdtgNUysjD007W03YANvqTvbis+Vu0HZuVFhJ78TEmfJwB7IDByYpeqNhHUi96UgFe
         PygZqGV+cX15zJ4CPc7dcibKAxZBEbQlxYg8elm4f4rHq96LU1DaEYLhTC45Ra64yGFq
         SY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597402; x=1685189402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dzjqDUqhlpwIVqCpt+cUtHh+EAeuNijiG89uyJMVyE=;
        b=YYO9TyrajggOyihyJaN3jzSPycyT3/0IsWbfX+/IfOYvK2BhzRm9N+1DuJeCahfnEY
         y8MvXrkGNm/WWGSU3lQNwk5Eo2/4NcFvKN+n5oGhPzdeYFDIxUQ9zRxEsgwgSeKaPccI
         9K/h7O0wmJU8liFO4X+9uIVCXL6fvUgqpJqLL6pOEJQcJCoEHfE7HTJj6PHfYveQI7CQ
         Aaj78lwdb7t7M64k7XswyigCMwSGSdwpEAsnqtyV5XOSTX1YZYwf3QYLMwrblZxnARtv
         10UIxnGhQgua4g2wNwCIjd1haRcqknVrbC3cHotQpDYl5A+0lJ8258lo3QeFL8K9qjDa
         uZSw==
X-Gm-Message-State: AC+VfDzobBvcwynpNLVn6RARGMy4kHuNQ3c206e28Qy/e0M3Ctc950xW
        fj+gcdGm9WMf0u6PnMbfu5r0+Q==
X-Google-Smtp-Source: ACHHUZ7tTRg6JjrQn0fN0wMHNQEUZxZc+8nVJItV2YPemA+2Nsy91sZM02NQMcgDGGIBwHzi+eaRLQ==
X-Received: by 2002:ac2:5616:0:b0:4ee:d8f3:1398 with SMTP id v22-20020ac25616000000b004eed8f31398mr465560lfd.68.1682597401956;
        Thu, 27 Apr 2023 05:10:01 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004d4d7fb0e07sm2892044lfn.216.2023.04.27.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:10:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Apr 2023 14:09:58 +0200
Subject: [PATCH v2 3/8] dmaengine: ste_dma40: Add dev helper variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v2-3-cdaa68a4b863@linaro.org>
References: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
2.40.0

