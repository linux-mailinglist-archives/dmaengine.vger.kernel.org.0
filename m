Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C005EAF9A
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIZSWf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIZSWS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:22:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF86F25F
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f23so6988889plr.6
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sOua1pY21Fv96aW7PrqBiYaJcs7gq7YxISSZUAc8EdI=;
        b=kjmkfPAt0Ldb3kCH6Yy627NqbCxAlubd0uia6q14J2OjHUm+b5V/OKWYaeR40shCYw
         bBdnojc5UaDQ0/H7vxZwcXUNrbQTF973LhAUDwAoD7hboV1z5FtvlWNqO9xU4VbVW4Jz
         soyMTVCUrcQhmcb2iKs7B/Ebg+Lfa/8kZgzazWk6Gz54hKdnguR7TWrJumBSjO2fFDSq
         gb75osepy7K4kuQwOcBFaryGpVGCbU2abfq0ztoN2zh129iidfp/nQpP3781Ovy0/hNs
         CY4Jk8RYRUPBfQrqOGGxBJZ8nkQj4qDuJYVQwcI2d0jVcED/q2dP2XSR5wkaDBcDPx25
         DhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sOua1pY21Fv96aW7PrqBiYaJcs7gq7YxISSZUAc8EdI=;
        b=PFOD4dSETbx9OQfli63+/X1slDiLSc/H8SyS6klbawMAE1U8bMXtjD/DgldQ8qnsCt
         szeQubYS/nR04f3P79R6KkCXuB3k/fw1afSLESMbHY2xANBULoEasjPNcxH7KpLGr32u
         nhRgefwseyR9ebQvg8jgpCIvJyeH3AGvVn1RmaYVQUoGSZQ0vYBTdS3Htn8+07pwnGnd
         gKFMssr+2g7aej7pCX8QfbYit9FCChzfLXoIIWbLItxY51RClnx8sBp+Cy8ZADBgrKIE
         W2RxO0LJcH0UA0XT9MLl57HLfggPeDP+JkFYNJp+/x5h9fitNbsjLTb2pHTl/Z5+Gyqv
         u8oQ==
X-Gm-Message-State: ACrzQf2E6gcN0zt2ieGMblvV1bMWsx/kYvoAbAfYCRx6z5Mg/cD1hn9l
        Q5aQfe3edIOahLLh113DeCnXVO1ZWhJWk7JGJGk=
X-Google-Smtp-Source: AMsMyM64SABO96G27AS3aWnCUnQpn/3RgqTRcJiZhmQYLLesTVTJaim/CtVlQE3CoaXbAN8KoEgu5A==
X-Received: by 2002:a17:902:e5c3:b0:176:d1b9:ee33 with SMTP id u3-20020a170902e5c300b00176d1b9ee33mr23499484plf.122.1664216334097;
        Mon, 26 Sep 2022 11:18:54 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id y129-20020a62ce87000000b005480167b921sm13039838pfg.172.2022.09.26.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:18:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH 2/3] dma/ti: convert k3-udma to module
Date:   Mon, 26 Sep 2022 11:18:47 -0700
Message-Id: <20220926181848.2917639-3-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220926181848.2917639-1-khilman@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
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

