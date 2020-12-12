Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8763C2D8798
	for <lists+dmaengine@lfdr.de>; Sat, 12 Dec 2020 17:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439307AbgLLQHH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Dec 2020 11:07:07 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:33513 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439305AbgLLQHG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 12 Dec 2020 11:07:06 -0500
Received: from localhost.localdomain ([93.22.36.60])
        by mwinf5d29 with ME
        id 3U5G2400D1HrHD103U5HaS; Sat, 12 Dec 2020 17:05:22 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Dec 2020 17:05:22 +0100
X-ME-IP: 93.22.36.60
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     leoyang.li@nxp.com, zw@zh-kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, timur@freescale.com
Cc:     linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] dmaengine: fsldma: Fix a resource leak in the remove function
Date:   Sat, 12 Dec 2020 17:05:16 +0100
Message-Id: <20201212160516.92515-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A 'irq_dispose_mapping()' call is missing in the remove function.
Add it.

This is needed to undo the 'irq_of_parse_and_map() call from the probe
function and already part of the error handling path of the probe function.

It was added in the probe function only in commit d3f620b2c4fe ("fsldma:
simplify IRQ probing and handling")

Fixes: 77cd62e8082b ("fsldma: allow Freescale Elo DMA driver to be compiled as a module")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Patch provided as-is.
I don't have the configuration to compile test this patch
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0feb323bae1e..554f70a0c18c 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1314,6 +1314,7 @@ static int fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
+	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.27.0

