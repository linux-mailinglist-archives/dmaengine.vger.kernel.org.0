Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D8D6E41B2
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDQH4B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDQHz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 03:55:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9830C6
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec817735a7so1206529e87.3
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718155; x=1684310155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDtAHFkACNF4Fh0e1ECtMlpIQkwRfUIlYaCT74L7zJo=;
        b=q7WCF1N+CRQkoWPOWi5hetk0qFQtsHK02pWAAiDM91JT2mUoRVoQFvTq0XtekzYjfP
         aDNyKKUAvU7Zt6SdaYhc00poFYogGvx8fXCB0ZL0R2C+F3RjJbm9lvaJH889C1T9Pwkw
         62Q0IQsR7pLMyPOgnyyh/OFIFQLd3HYmxAsAWzUiacTN149pJ8Toi5J7kLBdQ2gD+Hbh
         5wxuzji9RIXzVnnHv6TxTd3nZWqc7Gl7eXzfBGHbIHLmY7SpYBoGkzrp7V1Dv7MprKOU
         AH/ITkbWNpr+A86d56rEn7+lMiMOrtUujLH+uEBAPreyfdRSEh6XeGHc9xfWB7x3OKej
         bJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718155; x=1684310155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDtAHFkACNF4Fh0e1ECtMlpIQkwRfUIlYaCT74L7zJo=;
        b=LUXjkVYblPICM2/33AsylgrHKvvFG2sBSABSw6FQUI+eB0XvivvUfn7ygIqBMC0tDJ
         wtbs1HCv5jArY/rpBc+0lDIOWrw5PiVfuwsCK/xXSxqI6gmjFBp76JaFovVl8ByN5x1H
         a60PCWBTo8jzpDjIB7l3UOCdS0WjqseU0HDVhtgXsMWZUlCUWz2MY2ojQrXtnlU0yd7k
         JWONdqycZ0YRRvHxj7ksK7s3luxL4VfRhCE7WgnOZWpWcPeg36rlpa6aEzI4G59ata4w
         8ZRWO9kRm3z4RJ1S+JY0L+abdM43qvcJGMWPkWotSvxNLhuVtjlABaA7WEjo0DPfuF/X
         /Pkw==
X-Gm-Message-State: AAQBX9epde67u9RQlLVpqyThcF/9tpJdQOu0BQKaUnmd40fQ0eDVEiSH
        tcNPDuP3Rx+IDOvdeRgX681V9g==
X-Google-Smtp-Source: AKy350ZboDm+4NK7B9xoD63pnZSAk88IDjHPqcL+OvTd7BTSkWUG9K2d8Mr8xj9P21rFBQtOk3YUqA==
X-Received: by 2002:ac2:51b8:0:b0:4ed:bfbf:4486 with SMTP id f24-20020ac251b8000000b004edbfbf4486mr1417102lfk.4.1681718155000;
        Mon, 17 Apr 2023 00:55:55 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004eb274b3a43sm1952547lfc.134.2023.04.17.00.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:55:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:55:47 +0200
Subject: [PATCH 2/7] dmaengine: ste_dma40: Get LCPA SRAM from SRAM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v1-2-b26324956e47@linaro.org>
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
2.39.2

