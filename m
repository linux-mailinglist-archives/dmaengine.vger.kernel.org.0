Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32C650D40
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfFXOHh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 10:07:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41677 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXOHh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 10:07:37 -0400
Received: by mail-io1-f67.google.com with SMTP id w25so1782245ioc.8;
        Mon, 24 Jun 2019 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=03apFXZ4DhKsed7tdajOvwJKFsSf8Y4I5P3qFLjRkKo=;
        b=I2Fo6XRAMMVOjvK9E4plBFmE6GbrgJNAzyqNah9iq40Vff1Sw1lpbcprdLQnGMx0eX
         xlzZChXLaTQXOyI22/oiBXxsGauWHWJoqH9029TFw6qyRQcnIRC/gDVZYqeTZVO/9/ny
         x/vHEcTt1jha1w58oRB6H9f2iJX0p/tSvZo5TIOk5x4NFIjQAn+nA1vNlrqf1DP3asNE
         lAnhxpsOMxb1xsuRRPUjobmfukOlvQ1DETmQUIXj8Sq8l4vGUCHzAtmp75+gaGegyo1X
         84V+T86qp0e3GuFTf6Z+v8yV8zgTzDwqZoLeNq0BOmMlLyJjTw/MySnlGVfPhXpYa1qj
         YLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=03apFXZ4DhKsed7tdajOvwJKFsSf8Y4I5P3qFLjRkKo=;
        b=KQeZB8J3ZZZcd5DjoJ+rByBfgZLJVlVVIpzPl5JP1/vbkTYPOwYH4dAJnkJXEYy+Ne
         I7Y5LgzmFXYu+HuIJ0yq6UY/eNWQLCm9ur3b31hyx49dlyZykp6YMCf6AEUh/SFkms75
         29p4uHf4xknaYRtnYZSo7o+7qny/Vu3EMaC60mFCFvgzCSE0jy4rW4Dgk6fk1ZJhKyTs
         gOIJISSQCSbsCwP3//wuEtE/0nruX0vJ2k37w89+55PVhQQN/92YZttejohSO+cY8nuO
         EiJuNXzsRvri6G9V5EIj3eOKmq2TZUdh88fBI8qryu/328GB8k1k277MeGNXzxH2G5kp
         UwUg==
X-Gm-Message-State: APjAAAVY09PJkSwMbJdJFoWoR+9rGZ4cubPwBFQFB6VVZuwbrz1AHWCC
        mTQzqA87lB9AMeLHupYfEuS+Q3i3
X-Google-Smtp-Source: APXvYqyyScY1CjudlFtny0U4SJFuFhECkaYbbnN7rZimu7Yub+mmjUoXj+OQyw0DAdw//wlggWdGLA==
X-Received: by 2002:a5d:9703:: with SMTP id h3mr21151624iol.152.1561385256497;
        Mon, 24 Jun 2019 07:07:36 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id d17sm13210813iom.28.2019.06.24.07.07.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 07:07:35 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error path
Date:   Mon, 24 Jun 2019 10:07:31 -0400
Message-Id: <20190624140731.24080-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If probe() fails anywhere beyond the point where
sdma_get_firmware() is called, then a kernel oops may occur.

Problematic sequence of events:
1. probe() calls sdma_get_firmware(), which schedules the
   firmware callback to run when firmware becomes available,
   using the sdma instance structure as the context
2. probe() encounters an error, which deallocates the
   sdma instance structure
3. firmware becomes available, firmware callback is
   called with deallocated sdma instance structure
4. use after free - kernel oops !

Solution: only attempt to load firmware when we're certain
that probe() will succeed. This guarantees that the firmware
callback's context will remain valid.

Note that the remove() path is unaffected by this issue: the
firmware loader will increment the driver module's use count,
ensuring that the module cannot be unloaded while the
firmware callback is pending or running.

To: Robin Gong <yibin.gong@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/dma/imx-sdma.c | 48 ++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 99d9f431ae2c..3f0f41d16e1c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2096,27 +2096,6 @@ static int sdma_probe(struct platform_device *pdev)
 	if (pdata && pdata->script_addrs)
 		sdma_add_scripts(sdma, pdata->script_addrs);
 
-	if (pdata) {
-		ret = sdma_get_firmware(sdma, pdata->fw_name);
-		if (ret)
-			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
-	} else {
-		/*
-		 * Because that device tree does not encode ROM script address,
-		 * the RAM script in firmware is mandatory for device tree
-		 * probe, otherwise it fails.
-		 */
-		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
-					      &fw_name);
-		if (ret)
-			dev_warn(&pdev->dev, "failed to get firmware name\n");
-		else {
-			ret = sdma_get_firmware(sdma, fw_name);
-			if (ret)
-				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
-		}
-	}
-
 	sdma->dma_device.dev = &pdev->dev;
 
 	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
@@ -2161,6 +2140,33 @@ static int sdma_probe(struct platform_device *pdev)
 		of_node_put(spba_bus);
 	}
 
+	/*
+	 * Kick off firmware loading as the very last step:
+	 * attempt to load firmware only if we're not on the error path, because
+	 * the firmware callback requires a fully functional and allocated sdma
+	 * instance.
+	 */
+	if (pdata) {
+		ret = sdma_get_firmware(sdma, pdata->fw_name);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
+	} else {
+		/*
+		 * Because that device tree does not encode ROM script address,
+		 * the RAM script in firmware is mandatory for device tree
+		 * probe, otherwise it fails.
+		 */
+		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
+					      &fw_name);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to get firmware name\n");
+		else {
+			ret = sdma_get_firmware(sdma, fw_name);
+			if (ret)
+				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
+		}
+	}
+
 	return 0;
 
 err_register:
-- 
2.17.1

