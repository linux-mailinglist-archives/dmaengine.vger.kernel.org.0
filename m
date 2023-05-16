Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869B7704E55
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjEPM4r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjEPM4b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 08:56:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A86A55
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so140201181fa.0
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241746; x=1686833746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mc1Rlsn1GEwCmjCKY/d6Szb0PjVBu+i35jp20ojgCNI=;
        b=j6I2tWNgl15gXeyPBsLSo0X9lhmiwiWe8q2E/Fu3HKg2ejVWK747D1Xyn/0ALbPrrE
         VYz8W1Wz3OBCfv4nqhzAeUWAOjUOK3+k92AvV1+9aZ2NAKQTs4LDruUYh811i217Eq5Y
         g9sVSX+Il015BgYmpmpCgvI3wwASJPtchdi4tV2g1NiFKaIDStLe2o6rAMLkDSFEn8O5
         w170P8dofsdpu+8AjEKjYyEyAY7hxl6RUae+855x/XJEaPzlFRwuFYicDFOcMO6RPo8B
         RI0lKIWc9GdbRJ4XH4Rn8hMxwCDjKGxCarTYgwXvxnkO3RbXHhfFmhmOTBLxxKw23qnh
         j7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241746; x=1686833746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc1Rlsn1GEwCmjCKY/d6Szb0PjVBu+i35jp20ojgCNI=;
        b=fdcdHgQBCnH3navK9QUshY4c5O6M1Yv1Q8F4tJte2TtAi5jfw7tpKXbGoenaJyV+FS
         vdtWcX0czLbqf5YqGj7w9+n2v4EBVTJ7AsFdtkbMTQLTjIehTY1uvY7oom/qHaF8nyqi
         sUFxPtco9pkv1alK7IV44jWX4x0LsegxHoQxVEQBDNgs/zOonWH7UT9w6pM722uU4qeZ
         G0LDNmIb72tGS0Vpqzc9HbvuJYH3ugv3velYH9IMIBYB411Z/s5UrW1iBrfamrGjPjJ3
         O9HXAUb0iSD6ygNImdl7mvP0t4LV75LELslbx8xnAwwVet3iK7bQ0PVb0vvACAeupYZB
         G99g==
X-Gm-Message-State: AC+VfDyOiypmolrdxL+8hQlDeTraKdNtLymNAdJ4z+MAs9Pj+sMzYXDw
        iiJ0jWn+YbFx1qq2rWMieD1eOsjhpY1RLrUEVlc=
X-Google-Smtp-Source: ACHHUZ6ub2L/SGShIiT9NO6L6AfVN8lKl9QRosQTVHSnXKJKioQD1jYq8KxEq6CTUsRuaKeIyAzj1A==
X-Received: by 2002:a2e:8058:0:b0:2a8:bd1f:a377 with SMTP id p24-20020a2e8058000000b002a8bd1fa377mr8160817ljg.20.1684241746275;
        Tue, 16 May 2023 05:55:46 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e7317000000b002add1f4a92asm1647789ljc.113.2023.05.16.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:55:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 14:55:36 +0200
Subject: [PATCH v3 6/7] dmaengine: ste_dma40: Use managed resources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v3-6-60bfa6785968@linaro.org>
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

This switches the DMA40 driver to use a bunch of managed
resources and strip down the errorpath.

The result is pretty neat and makes the driver way more
readable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c | 180 ++++++++++++++++--------------------------------
 1 file changed, 61 insertions(+), 119 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 87f57457e4d9..313baf316f13 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -554,8 +554,6 @@ struct d40_gen_dmac {
  * @virtbase: The virtual base address of the DMA's register.
  * @rev: silicon revision detected.
  * @clk: Pointer to the DMA clock structure.
- * @phy_start: Physical memory start of the DMA registers.
- * @phy_size: Size of the DMA register map.
  * @irq: The IRQ number.
  * @num_memcpy_chans: The number of channels used for memcpy (mem-to-mem
  * transfers).
@@ -599,8 +597,6 @@ struct d40_base {
 	void __iomem			 *virtbase;
 	u8				  rev:4;
 	struct clk			 *clk;
-	phys_addr_t			  phy_start;
-	resource_size_t			  phy_size;
 	int				  irq;
 	int				  num_memcpy_chans;
 	int				  num_phy_chans;
@@ -3128,65 +3124,58 @@ static int __init d40_phy_res_init(struct d40_base *base)
 	return num_phy_chans_avail;
 }
 
+/* Called from the registered devm action */
+static void d40_drop_kmem_cache_action(void *d)
+{
+	struct kmem_cache *desc_slab = d;
+
+	kmem_cache_destroy(desc_slab);
+}
+
 static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	void __iomem *virtbase;
-	struct resource *res;
 	struct d40_base *base;
 	int num_log_chans;
 	int num_phy_chans;
 	int num_memcpy_chans;
-	int clk_ret = -EINVAL;
 	int i;
 	u32 pid;
 	u32 cid;
 	u8 rev;
+	int ret;
 
-	clk = clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		d40_err(dev, "No matching clock found\n");
-		goto check_prepare_enabled;
-	}
-
-	clk_ret = clk_prepare_enable(clk);
-	if (clk_ret) {
-		d40_err(dev, "Failed to prepare/enable clock\n");
-		goto disable_unprepare;
-	}
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return NULL;
 
 	/* Get IO for DMAC base address */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "base");
-	if (!res)
-		goto disable_unprepare;
-
-	if (request_mem_region(res->start, resource_size(res),
-			       D40_NAME " I/O base") == NULL)
-		goto release_region;
-
-	virtbase = ioremap(res->start, resource_size(res));
-	if (!virtbase)
-		goto release_region;
+	virtbase = devm_platform_ioremap_resource_byname(pdev, "base");
+	if (IS_ERR(virtbase)) {
+		dev_err(dev, "No IO base defined\n");
+		return NULL;
+	}
 
 	/* This is just a regular AMBA PrimeCell ID actually */
 	for (pid = 0, i = 0; i < 4; i++)
-		pid |= (readl(virtbase + resource_size(res) - 0x20 + 4 * i)
+		pid |= (readl(virtbase + SZ_4K - 0x20 + 4 * i)
 			& 255) << (i * 8);
 	for (cid = 0, i = 0; i < 4; i++)
-		cid |= (readl(virtbase + resource_size(res) - 0x10 + 4 * i)
+		cid |= (readl(virtbase + SZ_4K - 0x10 + 4 * i)
 			& 255) << (i * 8);
 
 	if (cid != AMBA_CID) {
 		d40_err(dev, "Unknown hardware! No PrimeCell ID\n");
-		goto unmap_io;
+		return NULL;
 	}
 	if (AMBA_MANF_BITS(pid) != AMBA_VENDOR_ST) {
 		d40_err(dev, "Unknown designer! Got %x wanted %x\n",
 			AMBA_MANF_BITS(pid),
 			AMBA_VENDOR_ST);
-		goto unmap_io;
+		return NULL;
 	}
 	/*
 	 * HW revision:
@@ -3200,7 +3189,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	rev = AMBA_REV_BITS(pid);
 	if (rev < 2) {
 		d40_err(dev, "hardware revision: %d is not supported", rev);
-		goto unmap_io;
+		return NULL;
 	}
 
 	/* The number of physical channels on this HW */
@@ -3218,23 +3207,22 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	num_log_chans = num_phy_chans * D40_MAX_LOG_CHAN_PER_PHY;
 
 	dev_info(dev,
-		 "hardware rev: %d @ %pa with %d physical and %d logical channels\n",
-		 rev, &res->start, num_phy_chans, num_log_chans);
+		 "hardware rev: %d with %d physical and %d logical channels\n",
+		 rev, num_phy_chans, num_log_chans);
 
-	base = kzalloc(ALIGN(sizeof(struct d40_base), 4) +
-		       (num_phy_chans + num_log_chans + num_memcpy_chans) *
-		       sizeof(struct d40_chan), GFP_KERNEL);
+	base = devm_kzalloc(dev,
+		ALIGN(sizeof(struct d40_base), 4) +
+		(num_phy_chans + num_log_chans + num_memcpy_chans) *
+		sizeof(struct d40_chan), GFP_KERNEL);
 
-	if (base == NULL)
-		goto unmap_io;
+	if (!base)
+		return NULL;
 
 	base->rev = rev;
 	base->clk = clk;
 	base->num_memcpy_chans = num_memcpy_chans;
 	base->num_phy_chans = num_phy_chans;
 	base->num_log_chans = num_log_chans;
-	base->phy_start = res->start;
-	base->phy_size = resource_size(res);
 	base->virtbase = virtbase;
 	base->plat_data = plat_data;
 	base->dev = dev;
@@ -3271,76 +3259,55 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		base->gen_dmac.init_reg_size = ARRAY_SIZE(dma_init_reg_v4a);
 	}
 
-	base->phy_res = kcalloc(num_phy_chans,
-				sizeof(*base->phy_res),
-				GFP_KERNEL);
+	base->phy_res = devm_kcalloc(dev, num_phy_chans,
+				     sizeof(*base->phy_res),
+				     GFP_KERNEL);
 	if (!base->phy_res)
-		goto free_base;
+		return NULL;
 
-	base->lookup_phy_chans = kcalloc(num_phy_chans,
-					 sizeof(*base->lookup_phy_chans),
-					 GFP_KERNEL);
+	base->lookup_phy_chans = devm_kcalloc(dev, num_phy_chans,
+					      sizeof(*base->lookup_phy_chans),
+					      GFP_KERNEL);
 	if (!base->lookup_phy_chans)
-		goto free_phy_res;
+		return NULL;
 
-	base->lookup_log_chans = kcalloc(num_log_chans,
-					 sizeof(*base->lookup_log_chans),
-					 GFP_KERNEL);
+	base->lookup_log_chans = devm_kcalloc(dev, num_log_chans,
+					      sizeof(*base->lookup_log_chans),
+					      GFP_KERNEL);
 	if (!base->lookup_log_chans)
-		goto free_phy_chans;
+		return NULL;
 
-	base->reg_val_backup_chan = kmalloc_array(base->num_phy_chans,
+	base->reg_val_backup_chan = devm_kmalloc_array(dev, base->num_phy_chans,
 						  sizeof(d40_backup_regs_chan),
 						  GFP_KERNEL);
 	if (!base->reg_val_backup_chan)
-		goto free_log_chans;
+		return NULL;
 
-	base->lcla_pool.alloc_map = kcalloc(num_phy_chans
+	base->lcla_pool.alloc_map = devm_kcalloc(dev, num_phy_chans
 					    * D40_LCLA_LINK_PER_EVENT_GRP,
 					    sizeof(*base->lcla_pool.alloc_map),
 					    GFP_KERNEL);
 	if (!base->lcla_pool.alloc_map)
-		goto free_backup_chan;
+		return NULL;
 
-	base->regs_interrupt = kmalloc_array(base->gen_dmac.il_size,
+	base->regs_interrupt = devm_kmalloc_array(dev, base->gen_dmac.il_size,
 					     sizeof(*base->regs_interrupt),
 					     GFP_KERNEL);
 	if (!base->regs_interrupt)
-		goto free_map;
+		return NULL;
 
 	base->desc_slab = kmem_cache_create(D40_NAME, sizeof(struct d40_desc),
 					    0, SLAB_HWCACHE_ALIGN,
 					    NULL);
-	if (base->desc_slab == NULL)
-		goto free_regs;
+	if (!base->desc_slab)
+		return NULL;
 
+	ret = devm_add_action_or_reset(dev, d40_drop_kmem_cache_action,
+				       base->desc_slab);
+	if (ret)
+		return NULL;
 
 	return base;
- free_regs:
-	kfree(base->regs_interrupt);
- free_map:
-	kfree(base->lcla_pool.alloc_map);
- free_backup_chan:
-	kfree(base->reg_val_backup_chan);
- free_log_chans:
-	kfree(base->lookup_log_chans);
- free_phy_chans:
-	kfree(base->lookup_phy_chans);
- free_phy_res:
-	kfree(base->phy_res);
- free_base:
-	kfree(base);
- unmap_io:
-	iounmap(virtbase);
- release_region:
-	release_mem_region(res->start, resource_size(res));
- check_prepare_enabled:
-	if (!clk_ret)
- disable_unprepare:
-		clk_disable_unprepare(clk);
-	if (!IS_ERR(clk))
-		clk_put(clk);
-	return NULL;
 }
 
 static void __init d40_hw_init(struct d40_base *base)
@@ -3585,11 +3552,11 @@ static int __init d40_probe(struct platform_device *pdev)
 	} else
 		writel(base->phy_lcpa, base->virtbase + D40_DREG_LCPA);
 
-	base->lcpa_base = ioremap(base->phy_lcpa, base->lcpa_size);
+	base->lcpa_base = devm_ioremap(dev, base->phy_lcpa, base->lcpa_size);
 	if (!base->lcpa_base) {
 		ret = -ENOMEM;
 		d40_err(dev, "Failed to ioremap LCPA region\n");
-		goto release_base;
+		goto report_failure;
 	}
 	/* If lcla has to be located in ESRAM we don't need to allocate */
 	if (base->plat_data->use_esram_lcla) {
@@ -3599,14 +3566,14 @@ static int __init d40_probe(struct platform_device *pdev)
 			ret = -ENOENT;
 			d40_err(dev,
 				"No \"lcla_esram\" memory resource\n");
-			goto destroy_cache;
+			goto report_failure;
 		}
-		base->lcla_pool.base = ioremap(res->start,
-						resource_size(res));
+		base->lcla_pool.base = devm_ioremap(dev, res->start,
+						    resource_size(res));
 		if (!base->lcla_pool.base) {
 			ret = -ENOMEM;
 			d40_err(dev, "Failed to ioremap LCLA region\n");
-			goto destroy_cache;
+			goto report_failure;
 		}
 		writel(res->start, base->virtbase + D40_DREG_LCLA);
 
@@ -3678,16 +3645,8 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	dev_info(base->dev, "initialized\n");
 	return 0;
- destroy_cache:
-	kmem_cache_destroy(base->desc_slab);
-	if (base->virtbase)
-		iounmap(base->virtbase);
-
-	if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
-		iounmap(base->lcla_pool.base);
-		base->lcla_pool.base = NULL;
-	}
 
+ destroy_cache:
 	if (base->lcla_pool.dma_addr)
 		dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
 				 SZ_1K * base->num_phy_chans,
@@ -3699,28 +3658,11 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	kfree(base->lcla_pool.base_unaligned);
 
-	if (base->lcpa_base)
-		iounmap(base->lcpa_base);
-
-release_base:
-	if (base->phy_start)
-		release_mem_region(base->phy_start,
-				   base->phy_size);
-	if (base->clk) {
-		clk_disable_unprepare(base->clk);
-		clk_put(base->clk);
-	}
-
 	if (base->lcpa_regulator) {
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
 
-	kfree(base->lcla_pool.alloc_map);
-	kfree(base->lookup_log_chans);
-	kfree(base->lookup_phy_chans);
-	kfree(base->phy_res);
-	kfree(base);
  report_failure:
 	d40_err(dev, "probe failed\n");
 	return ret;

-- 
2.40.1

