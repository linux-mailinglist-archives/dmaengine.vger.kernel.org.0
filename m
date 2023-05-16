Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9F704E5B
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjEPM4t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 08:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjEPM4c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 08:56:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A8173D
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:56:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac8cc8829fso134596661fa.3
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241747; x=1686833747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KThRHpQPHpZPJSTEGZZjIaigcF+AfIhnsyQDOpO+RdU=;
        b=kWj3kn1pOuUsl+DepVm/MZsJBwrfldQssLnsjBuMBKxgDM7AD3zgTCSnIAwFDKsRUK
         5VfSr66foS5xDfMMdHzg4P7k7JfWWCQGTXKdgVJQySW6SIWyYFk5rvu09MuRVkxlhXcs
         Uinu873E7zwk1tFIVR+AdaZrnFUum5I2rr5asv0/KlH5Wv5t02H7W+XUmUvQzwS/jmNs
         OVH1gI5yMtTah1iUfUN7iZIz9Iri9HXhxF0EzF4nEAIZpRIWfL4pYuM3wj5tc7XLYfpz
         YaxYURTOaUJctn4bjey7TeOkNMZcBiYiTqJeqQioFJ53DZMsyuKqb1xo4zZS9E/4cnq0
         +MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241747; x=1686833747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KThRHpQPHpZPJSTEGZZjIaigcF+AfIhnsyQDOpO+RdU=;
        b=KvgZCaLkOgtlSZdprsRCoRd8wA50UJ6a3B6yyzpvl7CnZY2a+73bdr/srQkCUQMI8g
         l20MLA1tLZX1KkQP7fnafqVPXO496TtzUr1m2guSqWkazv7rV/2Yiy4iXkXDCSNa6pFh
         EC0wYIMQ2X2iWTA0aZZUjAR/s4cIGCzbUzbViXqTV/49LQtoJCwXfKcW9tfz/omDoTcU
         Ck650JCgnUPQzhFRUCVWOYgQySolcU9MqSpemeg5bb+RsEMlF5DVcXO1b/subIFfFcuC
         80IqMlecTio40TuPkvZAt8FtQHcjHeJWVePqlaq+6UKGlTfNvJKzPbOtN+fRtkBiPfYR
         vgQA==
X-Gm-Message-State: AC+VfDy705X8Qp9l+zpx196i3bTqT8KvVUVJ4cxPkzi4+6sGd5v4w66+
        H+Er+AdCcPtPw4IyZSNK2Z9NiT4e7FNuwCvhKKI=
X-Google-Smtp-Source: ACHHUZ690LWVzRKPMZYlSQC1TXpjCqNEZDAIs/JcX2XqOWxWgk4gW0PoN33eVAk88x6uQ/6grOwRTg==
X-Received: by 2002:a2e:9f17:0:b0:2a8:bce1:5cac with SMTP id u23-20020a2e9f17000000b002a8bce15cacmr8101788ljk.37.1684241747533;
        Tue, 16 May 2023 05:55:47 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e7317000000b002add1f4a92asm1647789ljc.113.2023.05.16.05.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:55:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 14:55:37 +0200
Subject: [PATCH v3 7/7] dmaengine: ste_dma40: Return error codes properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v3-7-60bfa6785968@linaro.org>
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

This makes the probe() and its subfunction d40_hw_detect_init()
return proper error codes.

One effect of this is that deferred probe, e.g from the clock,
will start to work, would it happen. Also it is better design.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 313baf316f13..c30d00a78eed 100644
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
2.40.1

