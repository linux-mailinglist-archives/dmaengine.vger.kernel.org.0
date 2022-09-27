Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C25ED0BA
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 01:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiI0XIM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 19:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiI0XIL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 19:08:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F06C10C7AA
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:08:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b23so10964528pfp.9
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3D+ViyFwrXZ0nshMyB6HV1II5SU4JDOahb0+F+RI0tE=;
        b=b5fb58H+z3ZJAsyvwzFqDmxJqpA96BLlhQe6uVl+mwqulv0KClo2l8aIq0msqF3k/M
         2CenHdRU5BEBXXdo153aGnR7tEQaj/gBb75QvRC/gzwYD3FlPVixLJiavAGRQDMY5TQV
         ZFcbN7igcwVkc7HLFnGedISchZiux20mJO+2YVFAHHkbJmGNnt99pEKP/Kk7+0PvdO19
         bklUCkZc/C5T4c4/qnLb4AmM77ybfRH+xX+XiQL/M0bsWms3WJJO2WI64D7qGYF/pBol
         nuoMcUjm8altWuSoJWS3ZA0a1s6pH7CjnC+PdyknZAKcdLFX9XBmjEGmLnYujZzjdGdV
         jDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3D+ViyFwrXZ0nshMyB6HV1II5SU4JDOahb0+F+RI0tE=;
        b=XGze3vU0NpfI3j2LUyGaS2Fm3yJrkBrytG5eKq67uuWTv3X6ZAAXSs5JLy5YwNDpPE
         NCgXrOgrgggT6tGNRf8MPjrtjjwvwZ3KlCikoQbPYb3Ae/9LD7/0Gj57iNGfdMNa07v6
         1Q5oaWXyjtPHexREajDT6KT03Q082zYWCPPhsbMc1d9Iiu6XvkoYskrTWJntGCElpDxs
         MrD+UVJ5blsm/VRk3MJqD4xjHWQ0z1MoZNLPpmHxzOIWTJLJN7MAcWolY0tb3ZhgBZcl
         9HdSapsrSuFLz5iOBpMzjAaWI4TSWmDzBNbjGGCPk5vPMb1dM9BoQgUimFcJFIYOil5M
         QPpw==
X-Gm-Message-State: ACrzQf39yDxHunDAyDDz7bU6owkgrkDd3URrvqvdPkPQ5o9wCa+466cG
        16Pc9HPpylAVFoQVgKqTOxIvoQ==
X-Google-Smtp-Source: AMsMyM525NWDdFeelA0uGSrAFLlw61Kz5Ki/PBk5/uD0cQTBGE80JfTpmVu5HT7tyhpjGHg3rpd5LA==
X-Received: by 2002:a63:dd01:0:b0:439:34d8:82d5 with SMTP id t1-20020a63dd01000000b0043934d882d5mr26244218pgg.530.1664320089622;
        Tue, 27 Sep 2022 16:08:09 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b0053ebe7ffddcsm2338488pfq.116.2022.09.27.16.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:08:08 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH v2 2/3] dma/ti: convert k3-udma to module
Date:   Tue, 27 Sep 2022 16:08:03 -0700
Message-Id: <20220927230804.4085579-3-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220927230804.4085579-1-khilman@baylibre.com>
References: <20220927230804.4085579-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently k3-udma driver is built as separate platform drivers with a
shared probe and identical code path, just differnet platform data.

To enable to build as module, convert the separate platform driver
into a single module_platform_driver with the data selection done via
compatible string and of_match.  The separate of_match tables are also
combined into a single table to avoid the multiple calls to
of_match_node()

Since all modern TI platforms using this are DT enabled, the removal
of separate platform_drivers shoul should nave no functional change.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>                                                                                                                            
---
 drivers/dma/ti/Kconfig        |  4 ++--
 drivers/dma/ti/k3-udma-glue.c |  5 ++++-
 drivers/dma/ti/k3-udma.c      | 40 +++++------------------------------
 3 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index 79618fac119a..f196be3b222f 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -35,7 +35,7 @@ config DMA_OMAP
 	  DMA engine is found on OMAP and DRA7xx parts.
 
 config TI_K3_UDMA
-	bool "Texas Instruments UDMA support"
+	tristate "Texas Instruments UDMA support"
 	depends on ARCH_K3
 	depends on TI_SCI_PROTOCOL
 	depends on TI_SCI_INTA_IRQCHIP
@@ -48,7 +48,7 @@ config TI_K3_UDMA
 	  DMA engine is used in AM65x and j721e.
 
 config TI_K3_UDMA_GLUE_LAYER
-	bool "Texas Instruments UDMA Glue layer for non DMAengine users"
+	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
 	depends on ARCH_K3
 	depends on TI_K3_UDMA
 	help
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 4fdd9f06b723..c29de4695ae7 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/module.h>
 #include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -1433,4 +1434,6 @@ static int __init k3_udma_glue_class_init(void)
 {
 	return class_register(&k3_udma_glue_devclass);
 }
-arch_initcall(k3_udma_glue_class_init);
+
+module_init(k3_udma_glue_class_init);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 2f0d2c68c93c..7239ff31c8c5 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -4318,18 +4319,10 @@ static const struct of_device_id udma_of_match[] = {
 		.compatible = "ti,j721e-navss-mcu-udmap",
 		.data = &j721e_mcu_data,
 	},
-	{ /* Sentinel */ },
-};
-
-static const struct of_device_id bcdma_of_match[] = {
 	{
 		.compatible = "ti,am64-dmss-bcdma",
 		.data = &am64_bcdma_data,
 	},
-	{ /* Sentinel */ },
-};
-
-static const struct of_device_id pktdma_of_match[] = {
 	{
 		.compatible = "ti,am64-dmss-pktdma",
 		.data = &am64_pktdma_data,
@@ -5254,14 +5247,9 @@ static int udma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	match = of_match_node(udma_of_match, dev->of_node);
-	if (!match)
-		match = of_match_node(bcdma_of_match, dev->of_node);
 	if (!match) {
-		match = of_match_node(pktdma_of_match, dev->of_node);
-		if (!match) {
-			dev_err(dev, "No compatible match found\n");
-			return -ENODEV;
-		}
+		dev_err(dev, "No compatible match found\n");
+		return -ENODEV;
 	}
 	ud->match_data = match->data;
 
@@ -5494,27 +5482,9 @@ static struct platform_driver udma_driver = {
 	},
 	.probe		= udma_probe,
 };
-builtin_platform_driver(udma_driver);
 
-static struct platform_driver bcdma_driver = {
-	.driver = {
-		.name	= "ti-bcdma",
-		.of_match_table = bcdma_of_match,
-		.suppress_bind_attrs = true,
-	},
-	.probe		= udma_probe,
-};
-builtin_platform_driver(bcdma_driver);
-
-static struct platform_driver pktdma_driver = {
-	.driver = {
-		.name	= "ti-pktdma",
-		.of_match_table = pktdma_of_match,
-		.suppress_bind_attrs = true,
-	},
-	.probe		= udma_probe,
-};
-builtin_platform_driver(pktdma_driver);
+module_platform_driver(udma_driver);
+MODULE_LICENSE("GPL v2");
 
 /* Private interfaces to UDMA */
 #include "k3-udma-private.c"
-- 
2.34.0

