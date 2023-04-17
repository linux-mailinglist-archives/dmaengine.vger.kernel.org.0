Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47D6E41BC
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjDQH4Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjDQH4C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 03:56:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896663A80
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so11863531fa.0
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718157; x=1684310157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPWdg7F3IMdhanRJoUEbtquK6iHGHFOstWq/7/QawoU=;
        b=LT8FWIuV4QuV5Jxu51E5t0hEDBquZRsX+AYIVo/gFq4FALa3HcErJACinixYKJz0aQ
         sC3skK7dDYJ9W1DLB/6/wXusRHxiQVe04LDmblPt+9UVD2iKjSHbk0jcctJKr3frLWZp
         7KfmyGbcQOCH1ydaWCYEmJRq2+yLTkOXgrNlTZCFV52CAXVxz5CyPaWeM0rSSHFxCm/0
         FAziJi89Blw/zsQOn4YbXCX/uBHKyH6Sjq7UA0P89SHJ0MBPZfn+YKVWGiaWbynmsMdp
         sHCuXJkfwn/pRN4XA2ypjnnw56gQlGYo64HNdTSQuMLgtZDrKLCK/lAddEjjAJQLTOLE
         ojDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718157; x=1684310157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPWdg7F3IMdhanRJoUEbtquK6iHGHFOstWq/7/QawoU=;
        b=hrU+RtaDWob7sG/eIOkzAhRgSZT3tGiCc6W//LubCNC+CG+9eawki7v6P2TXg/uv5w
         6uaCEynNGZsL6l58Lxkwon0FNa/5V1Ck0EVNrorHUMMhsYJDi2vsHZVh+kF41lLGyPfi
         fCp8dcZccYXYxwPu8VsY6aRcpuq+83dRwJlgSGAmZoGen+BXadj+blHewlpeIatTb6BH
         zdfFuvbF4Y+wk0RVODnucHk4jD4JVMM2vfX4ZW8cRnFDAM1iCg6A5414edJsaYcmIQMT
         V7LhF9xLufspK25chDZ4gbZPRBb7/XjHuhafhWJUDXi1b+jk0BwdTLWDBlNUj3PRd4Q/
         JCfQ==
X-Gm-Message-State: AAQBX9fH5PQEFIvfgTcjXVQdUQhBiAJefyg4OFQgiEO1wIPA3TshsJlY
        UWxUeanJtdN/0ZBBQ2h70rLJfw==
X-Google-Smtp-Source: AKy350bML7c6LpQMxs0/0b67cTJuBJMGkcPz3uAfd3K+50MDS6j/zGVs+A6rTABTQsiXl7b75Ymbjg==
X-Received: by 2002:a05:6512:3882:b0:4eb:2b32:feab with SMTP id n2-20020a056512388200b004eb2b32feabmr1673201lft.50.1681718156788;
        Mon, 17 Apr 2023 00:55:56 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004eb274b3a43sm1952547lfc.134.2023.04.17.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:55:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:55:49 +0200
Subject: [PATCH 4/7] dmaengine: ste_dma40: Remove platform data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v1-4-b26324956e47@linaro.org>
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

The Ux500 is device tree-only since ages. Delete the
platform data header and push it into or next to the driver
instead.

Drop the non-DT probe path since this will not happen.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c                            |  56 ++++++++----
 .../dma-ste-dma40.h => drivers/dma/ste_dma40.h     | 101 +--------------------
 drivers/dma/ste_dma40_ll.c                         |   3 +-
 3 files changed, 41 insertions(+), 119 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index ef2a2fdaa82e..e5df28cdc4c8 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -23,11 +23,39 @@
 #include <linux/of_dma.h>
 #include <linux/amba/bus.h>
 #include <linux/regulator/consumer.h>
-#include <linux/platform_data/dma-ste-dma40.h>
 
 #include "dmaengine.h"
+#include "ste_dma40.h"
 #include "ste_dma40_ll.h"
 
+/**
+ * struct stedma40_platform_data - Configuration struct for the dma device.
+ *
+ * @dev_tx: mapping between destination event line and io address
+ * @dev_rx: mapping between source event line and io address
+ * @disabled_channels: A vector, ending with -1, that marks physical channels
+ * that are for different reasons not available for the driver.
+ * @soft_lli_chans: A vector, that marks physical channels will use LLI by SW
+ * which avoids HW bug that exists in some versions of the controller.
+ * SoftLLI introduces relink overhead that could impact performace for
+ * certain use cases.
+ * @num_of_soft_lli_chans: The number of channels that needs to be configured
+ * to use SoftLLI.
+ * @use_esram_lcla: flag for mapping the lcla into esram region
+ * @num_of_memcpy_chans: The number of channels reserved for memcpy.
+ * @num_of_phy_chans: The number of physical channels implemented in HW.
+ * 0 means reading the number of channels from DMA HW but this is only valid
+ * for 'multiple of 4' channels, like 8.
+ */
+struct stedma40_platform_data {
+	int				 disabled_channels[STEDMA40_MAX_PHYS];
+	int				*soft_lli_chans;
+	int				 num_of_soft_lli_chans;
+	bool				 use_esram_lcla;
+	int				 num_of_memcpy_chans;
+	int				 num_of_phy_chans;
+};
+
 #define D40_NAME "dma40"
 
 #define D40_PHY_CHAN -1
@@ -2269,7 +2297,7 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	return NULL;
 }
 
-bool stedma40_filter(struct dma_chan *chan, void *data)
+static bool stedma40_filter(struct dma_chan *chan, void *data)
 {
 	struct stedma40_chan_cfg *info = data;
 	struct d40_chan *d40c =
@@ -2288,7 +2316,6 @@ bool stedma40_filter(struct dma_chan *chan, void *data)
 
 	return err == 0;
 }
-EXPORT_SYMBOL(stedma40_filter);
 
 static void __d40_set_prio_rt(struct d40_chan *d40c, int dev_type, bool src)
 {
@@ -3517,16 +3544,9 @@ static int __init d40_probe(struct platform_device *pdev)
 	int num_reserved_chans;
 	u32 val;
 
-	if (!plat_data) {
-		if (np) {
-			if (d40_of_probe(pdev, np)) {
-				ret = -ENOMEM;
-				goto report_failure;
-			}
-		} else {
-			d40_err(dev, "No pdata or Device Tree provided\n");
-			goto report_failure;
-		}
+	if (d40_of_probe(pdev, np)) {
+		ret = -ENOMEM;
+		goto report_failure;
 	}
 
 	base = d40_hw_detect_init(pdev);
@@ -3650,11 +3670,11 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	d40_hw_init(base);
 
-	if (np) {
-		ret = of_dma_controller_register(np, d40_xlate, NULL);
-		if (ret)
-			dev_err(dev,
-				"could not register of_dma_controller\n");
+	ret = of_dma_controller_register(np, d40_xlate, NULL);
+	if (ret) {
+		dev_err(dev,
+			"could not register of_dma_controller\n");
+		goto destroy_cache;
 	}
 
 	dev_info(base->dev, "initialized\n");
diff --git a/include/linux/platform_data/dma-ste-dma40.h b/drivers/dma/ste_dma40.h
similarity index 51%
rename from include/linux/platform_data/dma-ste-dma40.h
rename to drivers/dma/ste_dma40.h
index 10641633facc..c697bfe16a01 100644
--- a/include/linux/platform_data/dma-ste-dma40.h
+++ b/drivers/dma/ste_dma40.h
@@ -1,19 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) ST-Ericsson SA 2007-2010
- * Author: Per Forlin <per.forlin@stericsson.com> for ST-Ericsson
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com> for ST-Ericsson
- */
-
 
 #ifndef STE_DMA40_H
 #define STE_DMA40_H
 
-#include <linux/dmaengine.h>
-#include <linux/scatterlist.h>
-#include <linux/workqueue.h>
-#include <linux/interrupt.h>
-
 /*
  * Maxium size for a single dma descriptor
  * Size is limited to 16 bits.
@@ -118,92 +107,4 @@ struct stedma40_chan_cfg {
 	int					 phy_channel;
 };
 
-/**
- * struct stedma40_platform_data - Configuration struct for the dma device.
- *
- * @dev_tx: mapping between destination event line and io address
- * @dev_rx: mapping between source event line and io address
- * @disabled_channels: A vector, ending with -1, that marks physical channels
- * that are for different reasons not available for the driver.
- * @soft_lli_chans: A vector, that marks physical channels will use LLI by SW
- * which avoids HW bug that exists in some versions of the controller.
- * SoftLLI introduces relink overhead that could impact performace for
- * certain use cases.
- * @num_of_soft_lli_chans: The number of channels that needs to be configured
- * to use SoftLLI.
- * @use_esram_lcla: flag for mapping the lcla into esram region
- * @num_of_memcpy_chans: The number of channels reserved for memcpy.
- * @num_of_phy_chans: The number of physical channels implemented in HW.
- * 0 means reading the number of channels from DMA HW but this is only valid
- * for 'multiple of 4' channels, like 8.
- */
-struct stedma40_platform_data {
-	int				 disabled_channels[STEDMA40_MAX_PHYS];
-	int				*soft_lli_chans;
-	int				 num_of_soft_lli_chans;
-	bool				 use_esram_lcla;
-	int				 num_of_memcpy_chans;
-	int				 num_of_phy_chans;
-};
-
-#ifdef CONFIG_STE_DMA40
-
-/**
- * stedma40_filter() - Provides stedma40_chan_cfg to the
- * ste_dma40 dma driver via the dmaengine framework.
- * does some checking of what's provided.
- *
- * Never directly called by client. It used by dmaengine.
- * @chan: dmaengine handle.
- * @data: Must be of type: struct stedma40_chan_cfg and is
- * the configuration of the framework.
- *
- *
- */
-
-bool stedma40_filter(struct dma_chan *chan, void *data);
-
-/**
- * stedma40_slave_mem() - Transfers a raw data buffer to or from a slave
- * (=device)
- *
- * @chan: dmaengine handle
- * @addr: source or destination physicall address.
- * @size: bytes to transfer
- * @direction: direction of transfer
- * @flags: is actually enum dma_ctrl_flags. See dmaengine.h
- */
-
-static inline struct
-dma_async_tx_descriptor *stedma40_slave_mem(struct dma_chan *chan,
-					    dma_addr_t addr,
-					    unsigned int size,
-					    enum dma_transfer_direction direction,
-					    unsigned long flags)
-{
-	struct scatterlist sg;
-	sg_init_table(&sg, 1);
-	sg.dma_address = addr;
-	sg.length = size;
-
-	return dmaengine_prep_slave_sg(chan, &sg, 1, direction, flags);
-}
-
-#else
-static inline bool stedma40_filter(struct dma_chan *chan, void *data)
-{
-	return false;
-}
-
-static inline struct
-dma_async_tx_descriptor *stedma40_slave_mem(struct dma_chan *chan,
-					    dma_addr_t addr,
-					    unsigned int size,
-					    enum dma_transfer_direction direction,
-					    unsigned long flags)
-{
-	return NULL;
-}
-#endif
-
-#endif
+#endif /* STE_DMA40_H */
diff --git a/drivers/dma/ste_dma40_ll.c b/drivers/dma/ste_dma40_ll.c
index b5287c661eb7..4c489b126cb2 100644
--- a/drivers/dma/ste_dma40_ll.c
+++ b/drivers/dma/ste_dma40_ll.c
@@ -6,8 +6,9 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/platform_data/dma-ste-dma40.h>
+#include <linux/dmaengine.h>
 
+#include "ste_dma40.h"
 #include "ste_dma40_ll.h"
 
 static u8 d40_width_to_bits(enum dma_slave_buswidth width)

-- 
2.39.2

