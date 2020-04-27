Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84D31BA200
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgD0LKx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 07:10:53 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:40083 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0LKw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Apr 2020 07:10:52 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d13 with ME
        id XnAl2200P0F2omL03nAman; Mon, 27 Apr 2020 13:10:51 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 27 Apr 2020 13:10:51 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     okaya@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        vkoul@kernel.org, dan.j.williams@intel.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: qcom_hidma: Simplify error handling path in hidma_probe
Date:   Mon, 27 Apr 2020 13:10:43 +0200
Message-Id: <20200427111043.70218-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to call 'hidma_debug_uninit()' in the error handling
path. 'hidma_debug_init()' has not been called yet.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/qcom/hidma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 411f91fde734..87490e125bc3 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -897,7 +897,6 @@ static int hidma_probe(struct platform_device *pdev)
 	if (msi)
 		hidma_free_msis(dmadev);
 
-	hidma_debug_uninit(dmadev);
 	hidma_ll_uninit(dmadev->lldev);
 dmafree:
 	if (dmadev)
-- 
2.25.1

