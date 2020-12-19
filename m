Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF12DEFDB
	for <lists+dmaengine@lfdr.de>; Sat, 19 Dec 2020 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgLSN3o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Dec 2020 08:29:44 -0500
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:31829 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726483AbgLSN3o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 19 Dec 2020 08:29:44 -0500
Received: from localhost.localdomain ([93.23.13.5])
        by mwinf5d70 with ME
        id 6DTz2400706YL0V03DTzF8; Sat, 19 Dec 2020 14:28:00 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Dec 2020 14:28:00 +0100
X-ME-IP: 93.23.13.5
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        jaswinder.singh@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: milbeaut-xdmac: Fix a resource leak in the error handling path of the probe function
Date:   Sat, 19 Dec 2020 14:28:00 +0100
Message-Id: <20201219132800.183254-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'disable_xdmac()' should be called in the error handling path of the
probe function to undo a previous 'enable_xdmac()' call, as already
done in the remove function.

Fixes: a6e9be055d47 ("dmaengine: milbeaut-xdmac: Add XDMAC driver for Milbeaut platforms")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Purely speculative
---
 drivers/dma/milbeaut-xdmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/milbeaut-xdmac.c b/drivers/dma/milbeaut-xdmac.c
index 584c931e807a..d29d01e730aa 100644
--- a/drivers/dma/milbeaut-xdmac.c
+++ b/drivers/dma/milbeaut-xdmac.c
@@ -350,7 +350,7 @@ static int milbeaut_xdmac_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(ddev);
 	if (ret)
-		return ret;
+		goto disable_xdmac;
 
 	ret = of_dma_controller_register(dev->of_node,
 					 of_dma_simple_xlate, mdev);
@@ -363,6 +363,8 @@ static int milbeaut_xdmac_probe(struct platform_device *pdev)
 
 unregister_dmac:
 	dma_async_device_unregister(ddev);
+disable_xdmac:
+	disable_xdmac(mdev);
 	return ret;
 }
 
-- 
2.27.0

