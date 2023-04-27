Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AEB6F0557
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbjD0MKH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 08:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbjD0MKE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 08:10:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959324698
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso9329278e87.0
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682597401; x=1685189401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWTuvneH8OCx2P81Wc3vASVRb7SduL7aaPSfgRD/SAs=;
        b=om4ZJrubqvm9fw2ZalUk1RT0azz39OuLOId41AYD0LfTb5dlZ9LX3jCwDrBZKOO++e
         uA1mRFlnjWE2DTzo+ZEKqXtcuZhYON83NYKG5peLU1pizGZ1Gwa7SJipGmrVJEUf4upi
         yp9LH5iTxIqy8l15MjffFKXm4jfGcp+XPj97cRTp1hrQUnEb4HAFaYn+P1uhVDxlxWo/
         WD1ZR1HVW5/REtdxhNkQnjbS02c9El/JOTgMDHdVZpQ+wH3rYf50S403y6n1slz289eO
         mNT+SaaGh+DDOzJ0okF99kSR/kGGc5YehVHI8N8wPHUz6/1ivOHPM+jRdU4uS+zRsBOq
         AvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597401; x=1685189401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWTuvneH8OCx2P81Wc3vASVRb7SduL7aaPSfgRD/SAs=;
        b=IH4G+yB1sDwKJzAT66WFbbdG3HVALaaqZuGA8KUlPC4KE0N1ZDYACNT6Rssxjcjb1Z
         +FpyOFehM4jtnJT3iiK5s68E+rN8wJArGTFbaujg/HEg3bI29rygfiaEAeHIEkt704iW
         RWZ9ZXJ4JFNpla0Iv0ia3Thwhw1/cPE12WII5R7bu49JJz/eX1mL6M19Rv+R+15o615q
         nSWfw+3AMxouu28kMwwp/sYuSAcVEYFu/3a6f4iAPSdqdCffs88V4+heX6Sj6HgfvtPg
         /m+JSWJ/+h7NlEiQxc3mvh3KhVpwQ4X8aShBzZwIsITIffLY/H/QwSyQjf2JYEuh8eUd
         9xsw==
X-Gm-Message-State: AC+VfDzaIcai/XUENtSKMTDxsEIqMxRzdBDxfPYj1Xceh8E0De7gGetq
        vujSeCL/QVkBp422+ybzCx84Rg==
X-Google-Smtp-Source: ACHHUZ43cX0+V8tD1PWXB6ZPABwRslcXJOEw7f4/EvLJ4ocyNR1FMVgddher638aNSpzw269uNIK2A==
X-Received: by 2002:a05:6512:3cc:b0:4ed:cc6d:1da1 with SMTP id w12-20020a05651203cc00b004edcc6d1da1mr433433lfp.36.1682597400855;
        Thu, 27 Apr 2023 05:10:00 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004d4d7fb0e07sm2892044lfn.216.2023.04.27.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:10:00 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Apr 2023 14:09:57 +0200
Subject: [PATCH v2 2/8] dmaengine: ste_dma40: Get LCPA SRAM from SRAM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v2-2-cdaa68a4b863@linaro.org>
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

Instead of passing the reserved SRAM as a "reg" field
look for a phandle to the LCPA SRAM memory so we can
use the proper SRAM device tree bindings for the SRAM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/Kconfig     |  1 +
 drivers/dma/ste_dma40.c | 47 ++++++++++++++++++++++++-----------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fb7073fc034f..37db3dc9a92a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -553,6 +553,7 @@ config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
 	depends on ARCH_U8500
 	select DMA_ENGINE
+	select SRAM
 	help
 	  Support for ST-Ericsson DMA40 controller
 
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f093e08c23b1..236269d35a53 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -19,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_dma.h>
 #include <linux/amba/bus.h>
 #include <linux/regulator/consumer.h>
@@ -3506,9 +3507,11 @@ static int __init d40_probe(struct platform_device *pdev)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np_lcpa;
 	int ret = -ENOENT;
 	struct d40_base *base;
 	struct resource *res;
+	struct resource res_lcpa;
 	int num_reserved_chans;
 	u32 val;
 
@@ -3535,37 +3538,37 @@ static int __init d40_probe(struct platform_device *pdev)
 	spin_lock_init(&base->interrupt_lock);
 	spin_lock_init(&base->execmd_lock);
 
-	/* Get IO for logical channel parameter address */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lcpa");
-	if (!res) {
-		ret = -ENOENT;
-		d40_err(&pdev->dev, "No \"lcpa\" memory resource\n");
-		goto destroy_cache;
+	/* Get IO for logical channel parameter address (LCPA) */
+	np_lcpa = of_parse_phandle(np, "sram", 0);
+	if (!np_lcpa) {
+		dev_err(&pdev->dev, "no LCPA SRAM node\n");
+		goto report_failure;
 	}
-	base->lcpa_size = resource_size(res);
-	base->phy_lcpa = res->start;
-
-	if (request_mem_region(res->start, resource_size(res),
-			       D40_NAME " I/O lcpa") == NULL) {
-		ret = -EBUSY;
-		d40_err(&pdev->dev, "Failed to request LCPA region %pR\n", res);
-		goto destroy_cache;
+	/* This is no device so read the address directly from the node */
+	ret = of_address_to_resource(np_lcpa, 0, &res_lcpa);
+	if (ret) {
+		dev_err(&pdev->dev, "no LCPA SRAM resource\n");
+		goto report_failure;
 	}
+	base->lcpa_size = resource_size(&res_lcpa);
+	base->phy_lcpa = res_lcpa.start;
+	dev_info(&pdev->dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
+		 base->phy_lcpa, base->lcpa_size);
 
 	/* We make use of ESRAM memory for this. */
 	val = readl(base->virtbase + D40_DREG_LCPA);
-	if (res->start != val && val != 0) {
+	if (base->phy_lcpa != val && val != 0) {
 		dev_warn(&pdev->dev,
-			 "[%s] Mismatch LCPA dma 0x%x, def %pa\n",
-			 __func__, val, &res->start);
+			 "[%s] Mismatch LCPA dma 0x%x, def %08x\n",
+			 __func__, val, base->phy_lcpa);
 	} else
-		writel(res->start, base->virtbase + D40_DREG_LCPA);
+		writel(base->phy_lcpa, base->virtbase + D40_DREG_LCPA);
 
-	base->lcpa_base = ioremap(res->start, resource_size(res));
+	base->lcpa_base = ioremap(base->phy_lcpa, base->lcpa_size);
 	if (!base->lcpa_base) {
 		ret = -ENOMEM;
 		d40_err(&pdev->dev, "Failed to ioremap LCPA region\n");
-		goto destroy_cache;
+		goto release_base;
 	}
 	/* If lcla has to be located in ESRAM we don't need to allocate */
 	if (base->plat_data->use_esram_lcla) {
@@ -3678,9 +3681,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	if (base->lcpa_base)
 		iounmap(base->lcpa_base);
 
-	if (base->phy_lcpa)
-		release_mem_region(base->phy_lcpa,
-				   base->lcpa_size);
+release_base:
 	if (base->phy_start)
 		release_mem_region(base->phy_start,
 				   base->phy_size);

-- 
2.40.0

