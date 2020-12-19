Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF72DEEDD
	for <lists+dmaengine@lfdr.de>; Sat, 19 Dec 2020 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgLSMt0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Dec 2020 07:49:26 -0500
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:20935 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbgLSMtZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 19 Dec 2020 07:49:25 -0500
Received: from localhost.localdomain ([93.23.13.5])
        by mwinf5d70 with ME
        id 6Cna2400106YL0V03Cnau7; Sat, 19 Dec 2020 13:47:41 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Dec 2020 13:47:41 +0100
X-ME-IP: 93.23.13.5
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sean.wang@mediatek.com, vkoul@kernel.org, dan.j.williams@intel.com,
        matthias.bgg@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix a resource leak in the error handling path of the probe function
Date:   Sat, 19 Dec 2020 13:47:18 +0100
Message-Id: <20201219124718.182664-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'mtk_hsdma_hw_deinit()' should be called in the error handling path of the
probe function to undo a previous 'mtk_hsdma_hw_init()' call, as already
done in the remove function.

Fixes: 548c4597e984 ("dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
'mtk_hsdma_hw_init()' can return an error code, it could be good to check
it as well.
---
 drivers/dma/mediatek/mtk-hsdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index f133ae8dece1..6ad8afbb95f2 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -1007,6 +1007,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	return 0;
 
 err_free:
+	mtk_hsdma_hw_deinit(hsdma);
 	of_dma_controller_free(pdev->dev.of_node);
 err_unregister:
 	dma_async_device_unregister(dd);
-- 
2.27.0

