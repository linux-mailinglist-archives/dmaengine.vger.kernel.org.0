Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965C82C29C1
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 15:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgKXOeW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 09:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbgKXOeV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Nov 2020 09:34:21 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E125C0613D6
        for <dmaengine@vger.kernel.org>; Tue, 24 Nov 2020 06:34:21 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 9so6472663qvk.9
        for <dmaengine@vger.kernel.org>; Tue, 24 Nov 2020 06:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZIBEt3Mnez4TPdCbYzUoCMsJRJEw3pFptBvj4bcjb80=;
        b=qhl4XHDEnRiw7QQKoRt9uwBK5Pp8iWuGuBUtNKZnYgqzbRCgNwNZIsCXgHFu7YNmsa
         vpJqzM4fVajXIr7uv2EvUyTh9hTlAfs3MFNzdL+Xr8uKhyByFBz2Kr9RLC4W8ZdeL3ni
         zbh3KeSobDcqbwQ8TzfsawLyVv0fgI/qxiaDoZH8T5FiP5jqrVXbof41peoAGwKn/dsF
         llbwRnh3I5t+T/euINBy2/okn0TSP5vBvANVWOu20//nMB2ThlEAQY4xojmaSizcCvZR
         DSN19lMmNyU9W69l3nLNigmo1lgabz3Vcwv2ZwZtYkgZVmicM7UOSKF1bLtA35QUfAIg
         RCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZIBEt3Mnez4TPdCbYzUoCMsJRJEw3pFptBvj4bcjb80=;
        b=pBnWPjf1TKgqzEL0ElFb+dSHWjOw3N5ZyZRg3oLfApLU/Bo4ozNRXqOZ/kUC/Ugvow
         yVwCkxb04s8A2t7gAI0HhsgayOLc4I/47mys93rbHAVdHOKYak9h3JQUJU951zD9CBw4
         p2ahKrN7vskL52VUMIfxu1KVoWnsk7n/Y0usKRGxfKfU2xk8ZezMyC1MgF/iiNPVwH5g
         6YaeFciaIRVQpfpcc2F9uWpE7mWJ/QyGgHqjV3Zmo1tAOitZYcpE2TEKLF1qn6Qd8xGb
         A+wsGZCrIT1zqzk0uCde5Q0JXKMAv0eVodRKurBfXkOPICVBXHxaqZUYV8QWp4hYKzO9
         6muw==
X-Gm-Message-State: AOAM533nbXQOBEQ8f+5ab6eCh/1+FA8k/gDotGGwqdhrHv4UfFdvmKIU
        U2jSPo4ZziVqUnF9C/gb3/I=
X-Google-Smtp-Source: ABdhPJzSFjHC+/aaJWClS4hPi+Azsa9LZJi5MgNH67PYY1Ml5lhtht+0Jo9iPj3rg/sVM//IUCAVhQ==
X-Received: by 2002:a0c:fbac:: with SMTP id m12mr4985752qvp.52.1606228460678;
        Tue, 24 Nov 2020 06:34:20 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:c91:9ce8:56e7:5368:ece8])
        by smtp.gmail.com with ESMTPSA id n93sm12922756qtd.7.2020.11.24.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:34:19 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     shawnguo@kernel.org, dmaengine@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] dmaengine: imx-dma: Remove unused .id_table
Date:   Tue, 24 Nov 2020 11:34:05 -0300
Message-Id: <20201124143405.2764-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
by removing the unused non-DT support.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/dma/imx-dma.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 670db04b0757..7f116bbcfad2 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -191,32 +191,13 @@ struct imxdma_filter_data {
 	int			 request;
 };
 
-static const struct platform_device_id imx_dma_devtype[] = {
-	{
-		.name = "imx1-dma",
-		.driver_data = IMX1_DMA,
-	}, {
-		.name = "imx21-dma",
-		.driver_data = IMX21_DMA,
-	}, {
-		.name = "imx27-dma",
-		.driver_data = IMX27_DMA,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, imx_dma_devtype);
-
 static const struct of_device_id imx_dma_of_dev_id[] = {
 	{
-		.compatible = "fsl,imx1-dma",
-		.data = &imx_dma_devtype[IMX1_DMA],
+		.compatible = "fsl,imx1-dma", .data = (const void *)IMX1_DMA,
 	}, {
-		.compatible = "fsl,imx21-dma",
-		.data = &imx_dma_devtype[IMX21_DMA],
+		.compatible = "fsl,imx21-dma", .data = (const void *)IMX21_DMA,
 	}, {
-		.compatible = "fsl,imx27-dma",
-		.data = &imx_dma_devtype[IMX27_DMA],
+		.compatible = "fsl,imx27-dma", .data = (const void *)IMX27_DMA,
 	}, {
 		/* sentinel */
 	}
@@ -1056,20 +1037,15 @@ static int __init imxdma_probe(struct platform_device *pdev)
 {
 	struct imxdma_engine *imxdma;
 	struct resource *res;
-	const struct of_device_id *of_id;
 	int ret, i;
 	int irq, irq_err;
 
-	of_id = of_match_device(imx_dma_of_dev_id, &pdev->dev);
-	if (of_id)
-		pdev->id_entry = of_id->data;
-
 	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
 	if (!imxdma)
 		return -ENOMEM;
 
 	imxdma->dev = &pdev->dev;
-	imxdma->devtype = pdev->id_entry->driver_data;
+	imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imxdma->base = devm_ioremap_resource(&pdev->dev, res);
@@ -1263,7 +1239,6 @@ static struct platform_driver imxdma_driver = {
 		.name	= "imx-dma",
 		.of_match_table = imx_dma_of_dev_id,
 	},
-	.id_table	= imx_dma_devtype,
 	.remove		= imxdma_remove,
 };
 
-- 
2.17.1

