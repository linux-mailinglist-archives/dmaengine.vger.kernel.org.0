Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B052C1489
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgKWTeZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Nov 2020 14:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgKWTeY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Nov 2020 14:34:24 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA63C0613CF
        for <dmaengine@vger.kernel.org>; Mon, 23 Nov 2020 11:34:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so18106733qke.8
        for <dmaengine@vger.kernel.org>; Mon, 23 Nov 2020 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AgZGngUJDkNRnTli8CidwshmemdgXT6Z4pk7Hskn7F8=;
        b=Twzf5xcqtymlE7yyPfiFdUVOIa67hASs5geAHz53iMTfkUcxzmpusIpJJhAR9qHUTb
         7paroxGtVaDJXOrUxyc0RHehYEGTsdfU9dVGOPafwm6snmj1Pa1Da3Aiv4Wzee5usURS
         HFZHB/XWPa9AwsNVXRvWFIDk65SfeUefvmENLkJtJmGLtLGR0uuTY/9EsfDMeyWD/c8J
         0UtGrjGERAHcgq4wfM1EWQrTjdOj6HZYs/LG/0ZlqmIwCdJgRcqZlayX6cj3N9WGWFge
         3CL/YdbF81v+Aas6C+ICYxHqkK78D9E9IJDZOOyDiU0tFwPK6TrVapT0SSV3Qrnq5rQq
         Meiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AgZGngUJDkNRnTli8CidwshmemdgXT6Z4pk7Hskn7F8=;
        b=ZtMxxZ5drp9ot6ih3Z6Jd1q4AqHWDALZkjDjSAePHzI21ae+ASsTjuyyH3vPnc6FFD
         YM7It8mRtyx4zGBWvblOYOhgAVfi4lJAk1Gqd+gd3TqpjEG6WPiwBk+W3XLrVwOq6rfZ
         yJyXK2b9yVZF3R+SRal3khtJz2NuPZTtfxRLu0lSk+FI+s499sHRZHU9khaMm/+rb88B
         RJilunrx3M+K9bicLTHGkbRt+rUJl8c69DwGrDhG1lDrEgDf5IymLWl8tn0I1hQL9Q88
         3FHSka9g07dIYNuMdUj1Yk+CsCzZhgAR4WNLntbeyqnC4W9g3PcldmS5LaTJnwhy5Dar
         swsg==
X-Gm-Message-State: AOAM533MJEiCvuybm3MA7GDRe/rWBUGO4JwxNm5NRogEJJPj8A9B3Wmf
        MrLw8Dmg214fttyKvPqdMA8=
X-Google-Smtp-Source: ABdhPJwlnapN9NbJHbsg9JYEiuWAIumvFd2rLClAPkSpazQqmSPYc8JSiH6nAwTc/V/2lvLDkrVkCg==
X-Received: by 2002:a37:9481:: with SMTP id w123mr1054126qkd.3.1606160063164;
        Mon, 23 Nov 2020 11:34:23 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id l62sm10616548qkf.121.2020.11.23.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 11:34:22 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     kernel@pengutronix.de, dmaengine@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dmaengine: mxs-dma: Remove the unused .id_table
Date:   Mon, 23 Nov 2020 16:30:51 -0300
Message-Id: <20201123193051.17285-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The mxs-dma driver is only used by DT platforms and the .id_table
is unused.

Get rid of it to simplify the code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/dma/mxs-dma.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 65f816b40c32..994fc4d2aca4 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -167,29 +167,11 @@ static struct mxs_dma_type mxs_dma_types[] = {
 	}
 };
 
-static const struct platform_device_id mxs_dma_ids[] = {
-	{
-		.name = "imx23-dma-apbh",
-		.driver_data = (kernel_ulong_t) &mxs_dma_types[0],
-	}, {
-		.name = "imx23-dma-apbx",
-		.driver_data = (kernel_ulong_t) &mxs_dma_types[1],
-	}, {
-		.name = "imx28-dma-apbh",
-		.driver_data = (kernel_ulong_t) &mxs_dma_types[2],
-	}, {
-		.name = "imx28-dma-apbx",
-		.driver_data = (kernel_ulong_t) &mxs_dma_types[3],
-	}, {
-		/* end of list */
-	}
-};
-
 static const struct of_device_id mxs_dma_dt_ids[] = {
-	{ .compatible = "fsl,imx23-dma-apbh", .data = &mxs_dma_ids[0], },
-	{ .compatible = "fsl,imx23-dma-apbx", .data = &mxs_dma_ids[1], },
-	{ .compatible = "fsl,imx28-dma-apbh", .data = &mxs_dma_ids[2], },
-	{ .compatible = "fsl,imx28-dma-apbx", .data = &mxs_dma_ids[3], },
+	{ .compatible = "fsl,imx23-dma-apbh", .data = &mxs_dma_types[0], },
+	{ .compatible = "fsl,imx23-dma-apbx", .data = &mxs_dma_types[1], },
+	{ .compatible = "fsl,imx28-dma-apbh", .data = &mxs_dma_types[2], },
+	{ .compatible = "fsl,imx28-dma-apbx", .data = &mxs_dma_types[3], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_dma_dt_ids);
@@ -762,8 +744,6 @@ static struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
 static int __init mxs_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct platform_device_id *id_entry;
-	const struct of_device_id *of_id;
 	const struct mxs_dma_type *dma_type;
 	struct mxs_dma_engine *mxs_dma;
 	struct resource *iores;
@@ -779,13 +759,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	of_id = of_match_device(mxs_dma_dt_ids, &pdev->dev);
-	if (of_id)
-		id_entry = of_id->data;
-	else
-		id_entry = platform_get_device_id(pdev);
-
-	dma_type = (struct mxs_dma_type *)id_entry->driver_data;
+	dma_type = (struct mxs_dma_type *)of_device_get_match_data(&pdev->dev);
 	mxs_dma->type = dma_type->type;
 	mxs_dma->dev_id = dma_type->id;
 
@@ -865,7 +839,6 @@ static struct platform_driver mxs_dma_driver = {
 		.name	= "mxs-dma",
 		.of_match_table = mxs_dma_dt_ids,
 	},
-	.id_table	= mxs_dma_ids,
 };
 
 static int __init mxs_dma_module_init(void)
-- 
2.17.1

