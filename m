Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89F2B526E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Nov 2020 21:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgKPUYU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 15:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPUYU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Nov 2020 15:24:20 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFDEC0613CF
        for <dmaengine@vger.kernel.org>; Mon, 16 Nov 2020 12:24:20 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id n132so18245186qke.1
        for <dmaengine@vger.kernel.org>; Mon, 16 Nov 2020 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sRZpZUiKCU9uE0UhGLJs8lTYZ4xq6vHNph9Jdhyl8bo=;
        b=nkT2vN7t95GlRjqVtYkP0JDAXYtzxX8mlIKRuxog+qnCz3rs/93wQx2wN2Sh1zbuUy
         6YApCUvnMwAt++mBLq0n8uxX9WpSP6S4DthjD0idGNw0mkbRrWgQlGo1aAJKWJC38vpR
         szAIDE70B/nV7kvSHDlDHIt7gq0hzVNR+E4ijEJKl/ks2zFGVex+84njiAUSYtdiFxqh
         RyZL0X1wOanEX516KLtRMTdTFPUlOmVDgXLkgRrp/tHVKJNN0bW6qYmkpjtKGAnmYxo5
         Scexd4jYvhjLIvREwQRiO2YEnDSyBHCD9YFZNqbIr9vjxrXsGiBMt7HaOh12cQnVYv59
         Q/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sRZpZUiKCU9uE0UhGLJs8lTYZ4xq6vHNph9Jdhyl8bo=;
        b=FVwPkOp/jdF0QeaFJo/TtZTpPjkUh7n0l69NXHMKH3D4HEJV5MsTyNOXPz9b1uCL3W
         WrugLNTj/dV4QKXBp6dRJ5gwvSBko++YWOgdA/WhaM7u9u45wyI4sOD9ovX7lvS7j14P
         Sf5aIP3QKT2HCcvY/v18Xm1MrY+J/c12s73RSRGW98LAKTjz+boeiTgfmvB+28GlFuSp
         SDq2nbOCj/FffAM1B4gSr6dL2enzMm+LlxK19LCXrN04X09kz5pvjw88lYC+u+sB/kxS
         HQNsonDkyv2nGjDQrL6QUt9c5rSB3xo0kErp0FD1hGzQ1ShV+HX6xL4Vxrl1Xpz7HbYN
         4SsA==
X-Gm-Message-State: AOAM530IwO03bG1NAPXOx7dCOhsgv1ks38zpaBWItBq9hjpzbBE3hndj
        CkM5ApyjqgMOBzH3wpARn/Y=
X-Google-Smtp-Source: ABdhPJwt63b48ChOVJPodcbruGgcGvu0ugd3WCraLO8noSQgbO6K0saiv0/W2/Vdu3ftGEFhzh0Kew==
X-Received: by 2002:a37:f503:: with SMTP id l3mr14872292qkk.160.1605558259245;
        Mon, 16 Nov 2020 12:24:19 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:997:213a:a240:fc07:36c8])
        by smtp.gmail.com with ESMTPSA id d12sm12394503qtp.77.2020.11.16.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:24:18 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     shawnguo@kernel.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dmaengine: imx-sdma: Remove unused .id_table support
Date:   Mon, 16 Nov 2020 17:24:03 -0300
Message-Id: <20201116202403.29749-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
.id_table support in this driver was only useful for old non-devicetree
platforms.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/dma/imx-sdma.c | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 16b908c77db3..41ba21eea7c8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -566,37 +566,6 @@ static struct sdma_driver_data sdma_imx8mq = {
 	.check_ratio = 1,
 };
 
-static const struct platform_device_id sdma_devtypes[] = {
-	{
-		.name = "imx25-sdma",
-		.driver_data = (unsigned long)&sdma_imx25,
-	}, {
-		.name = "imx31-sdma",
-		.driver_data = (unsigned long)&sdma_imx31,
-	}, {
-		.name = "imx35-sdma",
-		.driver_data = (unsigned long)&sdma_imx35,
-	}, {
-		.name = "imx51-sdma",
-		.driver_data = (unsigned long)&sdma_imx51,
-	}, {
-		.name = "imx53-sdma",
-		.driver_data = (unsigned long)&sdma_imx53,
-	}, {
-		.name = "imx6q-sdma",
-		.driver_data = (unsigned long)&sdma_imx6q,
-	}, {
-		.name = "imx7d-sdma",
-		.driver_data = (unsigned long)&sdma_imx7d,
-	}, {
-		.name = "imx8mq-sdma",
-		.driver_data = (unsigned long)&sdma_imx8mq,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, sdma_devtypes);
-
 static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-sdma", .data = &sdma_imx6q, },
 	{ .compatible = "fsl,imx53-sdma", .data = &sdma_imx53, },
@@ -1998,11 +1967,7 @@ static int sdma_probe(struct platform_device *pdev)
 	s32 *saddr_arr;
 	const struct sdma_driver_data *drvdata = NULL;
 
-	if (of_id)
-		drvdata = of_id->data;
-	else if (pdev->id_entry)
-		drvdata = (void *)pdev->id_entry->driver_data;
-
+	drvdata = of_id->data;
 	if (!drvdata) {
 		dev_err(&pdev->dev, "unable to find driver data\n");
 		return -EINVAL;
@@ -2211,7 +2176,6 @@ static struct platform_driver sdma_driver = {
 		.name	= "imx-sdma",
 		.of_match_table = sdma_dt_ids,
 	},
-	.id_table	= sdma_devtypes,
 	.remove		= sdma_remove,
 	.probe		= sdma_probe,
 };
-- 
2.17.1

