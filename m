Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C749C1DB169
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2020 13:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETLWD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 May 2020 07:22:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44506 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETLWD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 May 2020 07:22:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04KBM07t031584;
        Wed, 20 May 2020 06:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589973720;
        bh=qy9P9aMzN0C/xCRLZwZvXukaEjFqWsGHsK3cJOnMCAw=;
        h=From:To:CC:Subject:Date;
        b=whl06eR5NBsABPA6ewy/CfshQIQxI/iX9zixLv2KZnythnC4G9Rtq7EakPU1waajG
         Ouv6Ha5YyO/mfeD2E8u02ycyAdR/YDhrQ2KPQFQJtNt39SNps6mAkcI7c53Mpfxg8e
         BFeu594TUXoVnF2pWTzw4YRKxCd5RmpVu4UjMsas=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04KBM0Qh125359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 06:22:00 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 06:21:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 06:21:59 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04KBLvYc107754;
        Wed, 20 May 2020 06:21:58 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <tomi.valkeinen@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Fix delayed_work usage for tx drain workaround
Date:   Wed, 20 May 2020 14:22:33 +0300
Message-ID: <20200520112233.26807-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

INIT_DELAYED_WORK_ONSTACK() must be used with on-stack delayed work, which
is not the case here.
Use normal delayed_work for the channels instead.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/dma/ti/k3-udma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c91e2dc1bb72..87554e093a3b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1906,8 +1906,6 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	udma_reset_rings(uc);
 
-	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
-				  udma_check_tx_completion);
 	return 0;
 
 err_irq_free:
@@ -3019,7 +3017,6 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 	}
 
 	cancel_delayed_work_sync(&uc->tx_drain.work);
-	destroy_delayed_work_on_stack(&uc->tx_drain.work);
 
 	if (uc->irq_num_ring > 0) {
 		free_irq(uc->irq_num_ring, uc);
@@ -3711,6 +3708,7 @@ static int udma_probe(struct platform_device *pdev)
 		tasklet_init(&uc->vc.task, udma_vchan_complete,
 			     (unsigned long)&uc->vc);
 		init_completion(&uc->teardown_completed);
+		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
 	}
 
 	ret = dma_async_device_register(&ud->ddev);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

