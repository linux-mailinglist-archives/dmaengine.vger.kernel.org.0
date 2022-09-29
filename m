Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B25F018B
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 01:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiI2Xs1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 19:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiI2Xs1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 19:48:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E51FBCA2
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so2744684pjr.5
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=47vGPfHQ5SpOiUOWbCFeWpSRlTRaxQq1Ffs8KOXZab8=;
        b=Tcw6vcE1W9xd1zM11+UsgwQbqzbllS19xXqy5HRhsIP51Jw6vFXxPm2Z+L5U+CUy7L
         R4tj5NbrZiKLiycxqvvk04LT1z84WX+JTEc6VfkECGAhrafsz6Fy9ImRsIr5f+wImeMb
         HBnV9ZG1mLZYKGfa7U6RxgqI/yHa7eJrmVRigTc636CE+hmhGMUJHKUzO9E5PjiY403J
         huY5QWheHjV/z0oRVbZFVtqJu+178ql0Atxbj3d2axcd397Fx4mtAqGeDWvHDNh1DQ4+
         tu7oOHzZ69mqHvR17NCPYg5+dQn80HqlH46vC/cgdzQO/izk237bnD4v4l237C1TyWGp
         606w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=47vGPfHQ5SpOiUOWbCFeWpSRlTRaxQq1Ffs8KOXZab8=;
        b=ETeUAS08tx+rKmX0iScuOl3UX4d7vAXS3pJ3nnt3v3xLGVItmAkFNivvYrMlnWeTHB
         CAbhmftNDcN5Y33NJkrfi1HWQWtAb+jS6VI24mXynvipqL8M/52uNZhrBqyxG0ehnX4z
         NEnGz0n4dScnXjx55hfJhUT6X21WjBmUyWaTU8M13hLl7CFl0mkA2SFhoEh43otCaIlp
         2GDWaFLFAa3z192tNCCi3pyGEYLKvILqNw83cVF38gb17TyqubTpQ+uHrP2M3bT2bx+z
         cLwAQQI/P60TZGQ5b4S3yV/vupKmQpGCy3Yi+Mc0JnwcFWCVe+mepuC0IDOcAau++/51
         i46Q==
X-Gm-Message-State: ACrzQf2Tq8r7SS7Q9JAqihUDtl5rsfaBRrMhG34/DEy0e843zYD2SsTx
        FM5MKFaFctBfjYBgIN2MUvRioQ==
X-Google-Smtp-Source: AMsMyM7Ow0uJaIea8+NKspCt4hxki3jkwPJmYa3/6FznNa3iKWL1vFC/8gPgZU2fksAK/oBo4uGg3w==
X-Received: by 2002:a17:903:1c2:b0:178:3c7e:34f5 with SMTP id e2-20020a17090301c200b001783c7e34f5mr6032146plh.105.1664495305487;
        Thu, 29 Sep 2022 16:48:25 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id i3-20020a626d03000000b0052dfe83e19csm275681pfc.16.2022.09.29.16.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:48:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH v3 2/3] dmaengine: ti: convert k3-udma to module
Date:   Thu, 29 Sep 2022 16:48:19 -0700
Message-Id: <20220929234820.940048-3-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220929234820.940048-1-khilman@baylibre.com>
References: <20220929234820.940048-1-khilman@baylibre.com>
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
of separate platform_drivers should have no functional change.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
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

