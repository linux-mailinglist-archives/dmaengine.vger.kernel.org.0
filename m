Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EDD2D882B
	for <lists+dmaengine@lfdr.de>; Sat, 12 Dec 2020 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407609AbgLLQ1d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Dec 2020 11:27:33 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:17641 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407605AbgLLQ1Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 12 Dec 2020 11:27:24 -0500
Received: from localhost.localdomain ([93.22.36.60])
        by mwinf5d29 with ME
        id 3URb240041HrHD103URbFF; Sat, 12 Dec 2020 17:25:40 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Dec 2020 17:25:40 +0100
X-ME-IP: 93.22.36.60
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: owl-dma: Fix a resource leak in the remove function
Date:   Sat, 12 Dec 2020 17:25:35 +0100
Message-Id: <20201212162535.95727-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A 'dma_pool_destroy()' call is missing in the remove function.
Add it.

This call is already made in the error handling path of the probe function.

Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/owl-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 9fede32641e9..04202d75f4ee 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1245,6 +1245,7 @@ static int owl_dma_remove(struct platform_device *pdev)
 	owl_dma_free(od);
 
 	clk_disable_unprepare(od->clk);
+	dma_pool_destroy(od->lli_pool);
 
 	return 0;
 }
-- 
2.27.0

