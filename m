Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00834704E4F
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjEPM4Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjEPM4R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 08:56:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21811FD2
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso147184071fa.1
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241743; x=1686833743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXjTKNG/4Q9BqbjF143T/9kpVtT1Frl+2u0I19+j0Tw=;
        b=AD2VueX4Pbraf05ngrY77FYs6FcnQJMuaaRGp77fLkEDQ/aAmrkVFByrKRdfb/26S1
         hZRlle0gdGPMXMWaNB/zQ+C+ei2kQI7M6qie0+xcWuLmoR7297GFaS1ivnC9HZIvbvcb
         rOu/eV7XMd896JpEAiL4uM6qBx7MjEWGlxWnUX+oJzDrH7aUypHS+jcyqhdWqBCOa+Ob
         AWbWvc835cbYuOMit40ehoaXejghkRWqfhEYTuEspVpRBhUSPZUfxw+LfPBJ62TMLb/N
         DojPnTARUN5CJ0bOEqKttY/0h8Z1NXRIBzHU6miu1Qf6YqXG17NWDmwooDva+9cUHmzz
         Qcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241743; x=1686833743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXjTKNG/4Q9BqbjF143T/9kpVtT1Frl+2u0I19+j0Tw=;
        b=fk+/kWu77aQLZiieBhbPEicNGJGzQraxL23ro5/rYRq3wmeNUPlRDihmQC3v4aA8C9
         nlkSBxliazdfblBq13WWE0aBsZEPJpbgsGngacXDDurlbng7Q6Lsm93ODErClzTeYp++
         oh37Ut391JJsJHWwRgZ87YTik91icRG1zD/leE/nr67B5sqJG3yBY0bPdHyrRZRNGwew
         ITZPPlaqHBED02hpJRKS0AMtK5Z8klJTwiP3uoqiO7lJLp+3Mk+WuAKq7ulKXDlVehOe
         hTt4GpLCXAjob6Z+3Fli+Jdm4uO37xa1v8cCooN2ekyywrFX5gQSJlk/KT82MJpCm7aX
         SUJg==
X-Gm-Message-State: AC+VfDxLZi5GgMdRXvewxzZ6dniXLn85A2seC/qcJqyHnr3DJtPCxdXL
        bw9oBY2eYiBaQY6j7BIhKzTrtCcJmAYvjUF3v6c=
X-Google-Smtp-Source: ACHHUZ7AEmd/oegRDvhdW4xIZMmvxg+7pwTYg1MWoJiZQyGlAgiMbV6SawrsmnSGyuGxT5tXX4y/4A==
X-Received: by 2002:a2e:9697:0:b0:2a8:aec9:b0ba with SMTP id q23-20020a2e9697000000b002a8aec9b0bamr8495250lji.11.1684241742778;
        Tue, 16 May 2023 05:55:42 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e7317000000b002add1f4a92asm1647789ljc.113.2023.05.16.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:55:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 14:55:33 +0200
Subject: [PATCH v3 3/7] dmaengine: ste_dma40: Add dev helper variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v3-3-60bfa6785968@linaro.org>
References: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 7890ccae61f9..813de4efced5 100644
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
 		 (u32)base->phy_lcpa, base->lcpa_size);
 
 	/* We make use of ESRAM memory for this. */
 	val = readl(base->virtbase + D40_DREG_LCPA);
 	if (base->phy_lcpa != val && val != 0) {
-		dev_warn(&pdev->dev,
+		dev_warn(dev,
 			 "[%s] Mismatch LCPA dma 0x%x, def %08x\n",
 			 __func__, val, (u32)base->phy_lcpa);
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
2.40.1

