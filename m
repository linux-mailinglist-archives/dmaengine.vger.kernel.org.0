Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5221FF0CD
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgFRLjZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Jun 2020 07:39:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36234 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFRLjT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Jun 2020 07:39:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05IBdGDo070503;
        Thu, 18 Jun 2020 06:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592480356;
        bh=uGS0X3TlLZzxFj9lgxwFOCPF1ve9HNvFVRdtwO0XHFo=;
        h=From:To:CC:Subject:Date;
        b=wB5EtpSsPevDGz/JPOcuhWKb/4w9WcbOePbop8xD6wgtXlIBqbJhthN3fSzVjRbaG
         29l2l4X/LICCRqDf9UJraxHCvCI2OUVmok+3/u/QtHcK72dfxayoRPqD3HYUkfJLqR
         8fmVgIP5fhEy6kq6+PD9SGQQQye8CklEB33XnTGE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05IBdGVh092225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 06:39:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 18
 Jun 2020 06:39:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 18 Jun 2020 06:39:16 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05IBdEXX006331;
        Thu, 18 Jun 2020 06:39:15 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <tomi.valkeinen@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma: Fix delayed_work usage for tx drain workaround
Date:   Thu, 18 Jun 2020 14:40:04 +0300
Message-ID: <20200618114004.6268-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
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
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Change since v1:
- Added my sob

Regards,
Peter

 drivers/dma/ti/k3-udma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0d5fb154b8e2..6c879a734360 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1907,8 +1907,6 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	udma_reset_rings(uc);
 
-	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
-				  udma_check_tx_completion);
 	return 0;
 
 err_irq_free:
@@ -3020,7 +3018,6 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 	}
 
 	cancel_delayed_work_sync(&uc->tx_drain.work);
-	destroy_delayed_work_on_stack(&uc->tx_drain.work);
 
 	if (uc->irq_num_ring > 0) {
 		free_irq(uc->irq_num_ring, uc);
@@ -3712,6 +3709,7 @@ static int udma_probe(struct platform_device *pdev)
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

