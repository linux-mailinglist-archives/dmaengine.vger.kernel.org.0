Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CCE1D6448
	for <lists+dmaengine@lfdr.de>; Sat, 16 May 2020 23:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgEPVmM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 16 May 2020 17:42:12 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:31070 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726592AbgEPVmL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 16 May 2020 17:42:11 -0400
Received: from localhost.localdomain ([93.23.13.5])
        by mwinf5d73 with ME
        id fZi72200106YL0V03Zi71p; Sat, 16 May 2020 23:42:09 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 May 2020 23:42:09 +0200
X-ME-IP: 93.23.13.5
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        dan.j.williams@intel.com, vkoul@kernel.org,
        thierry.reding@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: tegra210-adma: Fix an error handling path in 'tegra_adma_probe()'
Date:   Sat, 16 May 2020 23:42:05 +0200
Message-Id: <20200516214205.276266-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
has moved some code in the probe function and reordered the error handling
path accordingly.
However, a goto has been missed.

Fix it and goto the right label if 'dma_async_device_register()' fails, so
that all resources are released.

Fixes: b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/tegra210-adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index c4ce5dfb149b..db58d7e4f9fe 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -900,7 +900,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
-		goto irq_dispose;
+		goto rpm_put;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
-- 
2.25.1

