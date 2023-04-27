Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301046F0567
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 14:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbjD0MKM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 08:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbjD0MKI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 08:10:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041D4C2C
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4efe8991bafso6888428e87.0
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682597406; x=1685189406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iexne6KWiUZLuVlw3N1v+wyJfKESkTIo0maZTpTI9HE=;
        b=XaqgjtwdVcU9AORsU7T2pzMxrCU/fNdtM41WtrStcjjTPpM0aNsN6ppeQoIqFt+2Gw
         2SK67wMAlpVUnZsUXL1dtd1AhBD8LRxoxNEO57x0yU3n2VIZJ1A+IP6kfuSNGYPQ1LJO
         U3WbHmJpomEX22tZDK4qNz6IGNU3FfHUaL0Br8mMPNYBkrUVZHt+08Qfb3eoAfGi9urB
         0SI5cVXbSpulLmYfpXyQO3+X0pcwg9gtHtWZkuekXYSh91Kuzfgh2Hf8QKKPdMdRovwc
         5cxXb+x76KIFoL80aiLc6wETFBSX7+zsH5GWUfa9WJ2CIaRMCfDlCQgOI05CnAFqsg5q
         p3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597406; x=1685189406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iexne6KWiUZLuVlw3N1v+wyJfKESkTIo0maZTpTI9HE=;
        b=JyQ3pb7lAgPjKjfZm9TxAuwWzwo+f8R9q7yLASB0Fya/ym+g6690dHhMX2rpNRWT7M
         XH1koW6b3KvoKooIT0/bjomUHzInsR43MtaMX5JCAVhxDQfqDBv6u53WVhcldSW7V4ZH
         BJILZppJQjeKxySmGDLkYKXv1bXP4E/AkXNYGFeepcwklCnVOvHOTwvPGg5FBKvRKLcn
         pY2IIAc574bg0MYaNngqT+K2a4GeoS7SiuN/ByPMXBxG7c3MOUdJERph8v1eRHW9cxlh
         KzbH3JR3TOpI6JnLhLlEi7hldny/lHKKWXtSFjc1YU6yX1DkqooWO700wxx7CHdercwi
         /2Ew==
X-Gm-Message-State: AC+VfDzfdpI1rGzT2YtIDCI4Ibc0IJ6wyySveLVbfaeHZ5ZN8I+mIP2A
        QIlUwBnNvu6YHfIqsbN+rydHhQ==
X-Google-Smtp-Source: ACHHUZ64h1cMUCvx0c2PIRR6kjDHa7YGe8eE5JsKstwj1P8W2/L/14jUmmPABSGuKATY1fxz9CJ/hA==
X-Received: by 2002:a19:f70c:0:b0:4ef:e7cb:b0ef with SMTP id z12-20020a19f70c000000b004efe7cbb0efmr541074lfe.31.1682597406393;
        Thu, 27 Apr 2023 05:10:06 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004d4d7fb0e07sm2892044lfn.216.2023.04.27.05.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:10:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Apr 2023 14:10:02 +0200
Subject: [PATCH v2 7/8] dmaengine: ste_dma40: Return error codes properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v2-7-cdaa68a4b863@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This makes the probe() and its subfunction d40_hw_detect_init()
return proper error codes.

One effect of this is that deferred probe, e.g from the clock,
will start to work, would it happen. Also it is better design.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c5991009d3e4..2911017265cf 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3132,7 +3132,8 @@ static void d40_drop_kmem_cache_action(void *d)
 	kmem_cache_destroy(desc_slab);
 }
 
-static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
+static int __init d40_hw_detect_init(struct platform_device *pdev,
+				     struct d40_base **retbase)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
@@ -3150,14 +3151,12 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
-		return NULL;
+		return PTR_ERR(clk);
 
 	/* Get IO for DMAC base address */
 	virtbase = devm_platform_ioremap_resource_byname(pdev, "base");
-	if (IS_ERR(virtbase)) {
-		dev_err(dev, "No IO base defined\n");
-		return NULL;
-	}
+	if (IS_ERR(virtbase))
+		return PTR_ERR(virtbase);
 
 	/* This is just a regular AMBA PrimeCell ID actually */
 	for (pid = 0, i = 0; i < 4; i++)
@@ -3169,13 +3168,13 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 
 	if (cid != AMBA_CID) {
 		d40_err(dev, "Unknown hardware! No PrimeCell ID\n");
-		return NULL;
+		return -EINVAL;
 	}
 	if (AMBA_MANF_BITS(pid) != AMBA_VENDOR_ST) {
 		d40_err(dev, "Unknown designer! Got %x wanted %x\n",
 			AMBA_MANF_BITS(pid),
 			AMBA_VENDOR_ST);
-		return NULL;
+		return -EINVAL;
 	}
 	/*
 	 * HW revision:
@@ -3189,7 +3188,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	rev = AMBA_REV_BITS(pid);
 	if (rev < 2) {
 		d40_err(dev, "hardware revision: %d is not supported", rev);
-		return NULL;
+		return -EINVAL;
 	}
 
 	/* The number of physical channels on this HW */
@@ -3216,7 +3215,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		sizeof(struct d40_chan), GFP_KERNEL);
 
 	if (!base)
-		return NULL;
+		return -ENOMEM;
 
 	base->rev = rev;
 	base->clk = clk;
@@ -3263,51 +3262,53 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 				     sizeof(*base->phy_res),
 				     GFP_KERNEL);
 	if (!base->phy_res)
-		return NULL;
+		return -ENOMEM;
 
 	base->lookup_phy_chans = devm_kcalloc(dev, num_phy_chans,
 					      sizeof(*base->lookup_phy_chans),
 					      GFP_KERNEL);
 	if (!base->lookup_phy_chans)
-		return NULL;
+		return -ENOMEM;
 
 	base->lookup_log_chans = devm_kcalloc(dev, num_log_chans,
 					      sizeof(*base->lookup_log_chans),
 					      GFP_KERNEL);
 	if (!base->lookup_log_chans)
-		return NULL;
+		return -ENOMEM;
 
 	base->reg_val_backup_chan = devm_kmalloc_array(dev, base->num_phy_chans,
 						  sizeof(d40_backup_regs_chan),
 						  GFP_KERNEL);
 	if (!base->reg_val_backup_chan)
-		return NULL;
+		return -ENOMEM;
 
 	base->lcla_pool.alloc_map = devm_kcalloc(dev, num_phy_chans
 					    * D40_LCLA_LINK_PER_EVENT_GRP,
 					    sizeof(*base->lcla_pool.alloc_map),
 					    GFP_KERNEL);
 	if (!base->lcla_pool.alloc_map)
-		return NULL;
+		return -ENOMEM;
 
 	base->regs_interrupt = devm_kmalloc_array(dev, base->gen_dmac.il_size,
 					     sizeof(*base->regs_interrupt),
 					     GFP_KERNEL);
 	if (!base->regs_interrupt)
-		return NULL;
+		return -ENOMEM;
 
 	base->desc_slab = kmem_cache_create(D40_NAME, sizeof(struct d40_desc),
 					    0, SLAB_HWCACHE_ALIGN,
 					    NULL);
 	if (!base->desc_slab)
-		return NULL;
+		return -ENOMEM;
 
 	ret = devm_add_action_or_reset(dev, d40_drop_kmem_cache_action,
 				       base->desc_slab);
 	if (ret)
-		return NULL;
+		return ret;
+
+	*retbase = base;
 
-	return base;
+	return 0;
 }
 
 static void __init d40_hw_init(struct d40_base *base)
@@ -3503,20 +3504,20 @@ static int __init d40_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
-	int ret = -ENOENT;
 	struct d40_base *base;
 	struct resource *res;
 	struct resource res_lcpa;
 	int num_reserved_chans;
 	u32 val;
+	int ret;
 
 	if (d40_of_probe(dev, np)) {
 		ret = -ENOMEM;
 		goto report_failure;
 	}
 
-	base = d40_hw_detect_init(pdev);
-	if (!base)
+	ret = d40_hw_detect_init(pdev, &base);
+	if (ret)
 		goto report_failure;
 
 	num_reserved_chans = d40_phy_res_init(base);
@@ -3530,6 +3531,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	np_lcpa = of_parse_phandle(np, "sram", 0);
 	if (!np_lcpa) {
 		dev_err(dev, "no LCPA SRAM node\n");
+		ret = -EINVAL;
 		goto report_failure;
 	}
 	/* This is no device so read the address directly from the node */

-- 
2.40.0

