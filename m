Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E12F9F7E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jan 2021 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390859AbhARMZq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jan 2021 07:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391257AbhARMSt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Jan 2021 07:18:49 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA24DC061573
        for <dmaengine@vger.kernel.org>; Mon, 18 Jan 2021 04:18:08 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 143so18354424qke.10
        for <dmaengine@vger.kernel.org>; Mon, 18 Jan 2021 04:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67NIDC3WNBkuxGIoq25j/EtjuvLxjb7elhuP9OoWXxc=;
        b=h90cYGuASoeFj3dW56liUnWvtO1akzZMpjFNsIgl2Flen/vG78Kf/AYQ3+40eMBK+R
         E7BZmTHg/w6LpHKWdyKTbM3ecXe7+jYiVL4AzbhECF9ivAbsG+GHhDsOTyMI/jlmL+GK
         k3P+KVXy32w2e2dLHLTxRl0nWLHh63cQXanguUr6PhH1y4wKiQRVTmJJGhX/z3gIYk9v
         oauvrJEAItodBrIz+09Jze89PHc8tVXXFz8uU0FrPRmgPOHOqMIJnkNZGqX/OgV7FZdr
         aRMpC8vlN3zWPUsOdjOVzi1agvbhoV7N6+oMsOV9INkL5f+kW0dnWacDTw4AAzhh03TH
         UWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67NIDC3WNBkuxGIoq25j/EtjuvLxjb7elhuP9OoWXxc=;
        b=l6072eWssmnqkkeRJSDNhZgkJL2Mk+OEIQiC5X++Zh4VlBrdO9vGDxgHElTWAJc/oa
         2DR56+VSaRsnLJh7qy89YZJFRkcIuX8pSAdIkWhJTMZp/IK5ANob3Kv9PMn7d8McMrih
         mB9YsRrWg4M/b4u5LGPWpcsAmDDHS+jYeypKfuQc6TdkG+3REjI1qKyyZoRbdH/ayVxg
         LQFZWhWEU8fcfH28BH6NRjzZc5v3WEDIEEufbnip+cpBr30EvebIrpn+S/82jDYpqW/J
         qah7zv9bwB04VMI0fcdc0CupVHo2yE88aa3FD+wtIh3W9Nyluq+c/c5Bni9k8wsHc/1M
         uRhg==
X-Gm-Message-State: AOAM532/Zuag0P3gpoIImN5d860ghVhpsrQCYdoWe0JLpF+DBMsZhHRJ
        kB8TVafOsjIY0q6ZSNzXjQgwLBZQrTs=
X-Google-Smtp-Source: ABdhPJxxj5AjydSRbrzKv2+tUY5fsPLxhIx5iL5BhmEbhHsi/mIMR40acpbEC/HSk2SiD+vZzhuoGw==
X-Received: by 2002:a37:a8c4:: with SMTP id r187mr23493137qke.481.1610972288211;
        Mon, 18 Jan 2021 04:18:08 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
        by smtp.gmail.com with ESMTPSA id 74sm10259565qko.59.2021.01.18.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 04:18:07 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     shawnguo@kernel.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] dmaengine: imx-sdma: Remove platform data support
Date:   Mon, 18 Jan 2021 09:15:48 -0300
Message-Id: <20210118121549.1625217-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since 5.10-rc1, i.MX has been converted to a devicetree-only platform.

The platform data support in this driver was only used for non-DT
platforms.

Remove the platform data support as it has no more users.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/dma/imx-sdma.c                     | 35 +++++++---------------
 include/linux/platform_data/dma-imx-sdma.h | 11 -------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 41ba21eea7c8..a68950f80635 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1961,7 +1961,6 @@ static int sdma_probe(struct platform_device *pdev)
 	int irq;
 	struct resource *iores;
 	struct resource spba_res;
-	struct sdma_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int i;
 	struct sdma_engine *sdma;
 	s32 *saddr_arr;
@@ -2063,8 +2062,6 @@ static int sdma_probe(struct platform_device *pdev)
 
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
-	if (pdata && pdata->script_addrs)
-		sdma_add_scripts(sdma, pdata->script_addrs);
 
 	sdma->dma_device.dev = &pdev->dev;
 
@@ -2110,30 +2107,18 @@ static int sdma_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Kick off firmware loading as the very last step:
-	 * attempt to load firmware only if we're not on the error path, because
-	 * the firmware callback requires a fully functional and allocated sdma
-	 * instance.
+	 * Because that device tree does not encode ROM script address,
+	 * the RAM script in firmware is mandatory for device tree
+	 * probe, otherwise it fails.
 	 */
-	if (pdata) {
-		ret = sdma_get_firmware(sdma, pdata->fw_name);
-		if (ret)
-			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
+	ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
+				      &fw_name);
+	if (ret) {
+		dev_warn(&pdev->dev, "failed to get firmware name\n");
 	} else {
-		/*
-		 * Because that device tree does not encode ROM script address,
-		 * the RAM script in firmware is mandatory for device tree
-		 * probe, otherwise it fails.
-		 */
-		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
-					      &fw_name);
-		if (ret) {
-			dev_warn(&pdev->dev, "failed to get firmware name\n");
-		} else {
-			ret = sdma_get_firmware(sdma, fw_name);
-			if (ret)
-				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
-		}
+		ret = sdma_get_firmware(sdma, fw_name);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
 	}
 
 	return 0;
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 30e676b36b24..725602d9df91 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -57,15 +57,4 @@ struct sdma_script_start_addrs {
 	/* End of v4 array */
 };
 
-/**
- * struct sdma_platform_data - platform specific data for SDMA engine
- *
- * @fw_name		The firmware name
- * @script_addrs	SDMA scripts addresses in SDMA ROM
- */
-struct sdma_platform_data {
-	char *fw_name;
-	struct sdma_script_start_addrs *script_addrs;
-};
-
 #endif /* __MACH_MXC_SDMA_H__ */
-- 
2.17.1

