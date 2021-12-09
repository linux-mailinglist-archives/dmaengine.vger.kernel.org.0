Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8E46F2CF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Dec 2021 19:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbhLISNy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Dec 2021 13:13:54 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55562 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhLISNx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Dec 2021 13:13:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B9IA6cU112667;
        Thu, 9 Dec 2021 12:10:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639073406;
        bh=Fi97amapW5yKm92q0RXAU/GkZ4Oj9cIza/ahxsQE+m4=;
        h=From:To:CC:Subject:Date;
        b=gotks5rJCum381F7pxtRs5Fth9BODzcg64Dsds2DpOXFSJmmJuCYPDbcKIyon7AkW
         Hc5jpDMSg71ldoo9MQ5zuyMsTd57E6TdFoLrVncVEd24TiyNR/ZEyN2kdNLQlIcVyo
         j1zuQGKhhuawl/lThTzRuIAjRDLl4bRL/BW93fDk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B9IA6cd042661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Dec 2021 12:10:06 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 9
 Dec 2021 12:10:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 9 Dec 2021 12:10:06 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B9IA30d124714;
        Thu, 9 Dec 2021 12:10:04 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] dma: ti: k3-udma: Fix smatch warnings
Date:   Thu, 9 Dec 2021 23:39:56 +0530
Message-ID: <20211209180957.29036-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Smatch reports below warnings [1] wrt dereferencing rm_res when it can
potentially be ERR_PTR(). This is possible when entire range is
allocated to Linux
Fix this case by making sure, there is no deference of rm_res when its
ERR_PTR().

[1]:
 drivers/dma/ti/k3-udma.c:4524 udma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
 drivers/dma/ti/k3-udma.c:4537 udma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
 drivers/dma/ti/k3-udma.c:4681 bcdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
 drivers/dma/ti/k3-udma.c:4696 bcdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
 drivers/dma/ti/k3-udma.c:4711 bcdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
 drivers/dma/ti/k3-udma.c:4848 pktdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
 drivers/dma/ti/k3-udma.c:4861 pktdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 157 ++++++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 50 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 041d8e32d630..6e56d1cef5ee 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4534,45 +4534,60 @@ static int udma_setup_resources(struct udma_dev *ud)
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 	if (IS_ERR(rm_res)) {
 		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
+		irq_res.sets = 1;
 	} else {
 		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->tchan_map,
 						  &rm_res->desc[i], "tchan");
+		irq_res.sets = rm_res->sets;
 	}
-	irq_res.sets = rm_res->sets;
 
 	/* rchan and matching default flow ranges */
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 	if (IS_ERR(rm_res)) {
 		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
+		irq_res.sets++;
 	} else {
 		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->rchan_map,
 						  &rm_res->desc[i], "rchan");
+		irq_res.sets += rm_res->sets;
 	}
 
-	irq_res.sets += rm_res->sets;
 	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
+	if (!irq_res.desc)
+		return -ENOMEM;
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
-	for (i = 0; i < rm_res->sets; i++) {
-		irq_res.desc[i].start = rm_res->desc[i].start;
-		irq_res.desc[i].num = rm_res->desc[i].num;
-		irq_res.desc[i].start_sec = rm_res->desc[i].start_sec;
-		irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+	if (IS_ERR(rm_res)) {
+		irq_res.desc[0].start = 0;
+		irq_res.desc[0].num = ud->tchan_cnt;
+		i = 1;
+	} else {
+		for (i = 0; i < rm_res->sets; i++) {
+			irq_res.desc[i].start = rm_res->desc[i].start;
+			irq_res.desc[i].num = rm_res->desc[i].num;
+			irq_res.desc[i].start_sec = rm_res->desc[i].start_sec;
+			irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
-	for (j = 0; j < rm_res->sets; j++, i++) {
-		if (rm_res->desc[j].num) {
-			irq_res.desc[i].start = rm_res->desc[j].start +
-					ud->soc_data->oes.udma_rchan;
-			irq_res.desc[i].num = rm_res->desc[j].num;
-		}
-		if (rm_res->desc[j].num_sec) {
-			irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
-					ud->soc_data->oes.udma_rchan;
-			irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+	if (IS_ERR(rm_res)) {
+		irq_res.desc[i].start = 0;
+		irq_res.desc[i].num = ud->rchan_cnt;
+	} else {
+		for (j = 0; j < rm_res->sets; j++, i++) {
+			if (rm_res->desc[j].num) {
+				irq_res.desc[i].start = rm_res->desc[j].start +
+						ud->soc_data->oes.udma_rchan;
+				irq_res.desc[i].num = rm_res->desc[j].num;
+			}
+			if (rm_res->desc[j].num_sec) {
+				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+						ud->soc_data->oes.udma_rchan;
+				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+			}
 		}
 	}
 	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
@@ -4690,14 +4705,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->bchan_map, ud->bchan_cnt);
+			irq_res.sets++;
 		} else {
 			bitmap_fill(ud->bchan_map, ud->bchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->bchan_map,
 							  &rm_res->desc[i],
 							  "bchan");
+			irq_res.sets += rm_res->sets;
 		}
-		irq_res.sets += rm_res->sets;
 	}
 
 	/* tchan ranges */
@@ -4705,14 +4721,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->tchan_map, ud->tchan_cnt);
+			irq_res.sets += 2;
 		} else {
 			bitmap_fill(ud->tchan_map, ud->tchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->tchan_map,
 							  &rm_res->desc[i],
 							  "tchan");
+			irq_res.sets += rm_res->sets * 2;
 		}
-		irq_res.sets += rm_res->sets * 2;
 	}
 
 	/* rchan ranges */
@@ -4720,47 +4737,72 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->rchan_map, ud->rchan_cnt);
+			irq_res.sets += 2;
 		} else {
 			bitmap_fill(ud->rchan_map, ud->rchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->rchan_map,
 							  &rm_res->desc[i],
 							  "rchan");
+			irq_res.sets += rm_res->sets * 2;
 		}
-		irq_res.sets += rm_res->sets * 2;
 	}
 
 	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
+	if (!irq_res.desc)
+		return -ENOMEM;
 	if (ud->bchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
-		for (i = 0; i < rm_res->sets; i++) {
-			irq_res.desc[i].start = rm_res->desc[i].start +
-						oes->bcdma_bchan_ring;
-			irq_res.desc[i].num = rm_res->desc[i].num;
+		if (IS_ERR(rm_res)) {
+			irq_res.desc[0].start = oes->bcdma_bchan_ring;
+			irq_res.desc[0].num = ud->bchan_cnt;
+			i = 1;
+		} else {
+			for (i = 0; i < rm_res->sets; i++) {
+				irq_res.desc[i].start = rm_res->desc[i].start +
+							oes->bcdma_bchan_ring;
+				irq_res.desc[i].num = rm_res->desc[i].num;
+			}
 		}
 	}
 	if (ud->tchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
-		for (j = 0; j < rm_res->sets; j++, i += 2) {
-			irq_res.desc[i].start = rm_res->desc[j].start +
-						oes->bcdma_tchan_data;
-			irq_res.desc[i].num = rm_res->desc[j].num;
-
-			irq_res.desc[i + 1].start = rm_res->desc[j].start +
-						oes->bcdma_tchan_ring;
-			irq_res.desc[i + 1].num = rm_res->desc[j].num;
+		if (IS_ERR(rm_res)) {
+			irq_res.desc[i].start = oes->bcdma_tchan_data;
+			irq_res.desc[i].num = ud->tchan_cnt;
+			irq_res.desc[i + 1].start = oes->bcdma_tchan_ring;
+			irq_res.desc[i + 1].num = ud->tchan_cnt;
+			i += 2;
+		} else {
+			for (j = 0; j < rm_res->sets; j++, i += 2) {
+				irq_res.desc[i].start = rm_res->desc[j].start +
+							oes->bcdma_tchan_data;
+				irq_res.desc[i].num = rm_res->desc[j].num;
+
+				irq_res.desc[i + 1].start = rm_res->desc[j].start +
+							oes->bcdma_tchan_ring;
+				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+			}
 		}
 	}
 	if (ud->rchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
-		for (j = 0; j < rm_res->sets; j++, i += 2) {
-			irq_res.desc[i].start = rm_res->desc[j].start +
-						oes->bcdma_rchan_data;
-			irq_res.desc[i].num = rm_res->desc[j].num;
-
-			irq_res.desc[i + 1].start = rm_res->desc[j].start +
-						oes->bcdma_rchan_ring;
-			irq_res.desc[i + 1].num = rm_res->desc[j].num;
+		if (IS_ERR(rm_res)) {
+			irq_res.desc[i].start = oes->bcdma_rchan_data;
+			irq_res.desc[i].num = ud->rchan_cnt;
+			irq_res.desc[i + 1].start = oes->bcdma_rchan_ring;
+			irq_res.desc[i + 1].num = ud->rchan_cnt;
+			i += 2;
+		} else {
+			for (j = 0; j < rm_res->sets; j++, i += 2) {
+				irq_res.desc[i].start = rm_res->desc[j].start +
+							oes->bcdma_rchan_data;
+				irq_res.desc[i].num = rm_res->desc[j].num;
+
+				irq_res.desc[i + 1].start = rm_res->desc[j].start +
+							oes->bcdma_rchan_ring;
+				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+			}
 		}
 	}
 
@@ -4858,39 +4900,54 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 	if (IS_ERR(rm_res)) {
 		/* all rflows are assigned exclusively to Linux */
 		bitmap_zero(ud->rflow_in_use, ud->rflow_cnt);
+		irq_res.sets = 1;
 	} else {
 		bitmap_fill(ud->rflow_in_use, ud->rflow_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->rflow_in_use,
 						  &rm_res->desc[i], "rflow");
+		irq_res.sets = rm_res->sets;
 	}
-	irq_res.sets = rm_res->sets;
 
 	/* tflow ranges */
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
 	if (IS_ERR(rm_res)) {
 		/* all tflows are assigned exclusively to Linux */
 		bitmap_zero(ud->tflow_map, ud->tflow_cnt);
+		irq_res.sets++;
 	} else {
 		bitmap_fill(ud->tflow_map, ud->tflow_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->tflow_map,
 						  &rm_res->desc[i], "tflow");
+		irq_res.sets += rm_res->sets;
 	}
-	irq_res.sets += rm_res->sets;
 
 	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
+	if (!irq_res.desc)
+		return -ENOMEM;
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
-	for (i = 0; i < rm_res->sets; i++) {
-		irq_res.desc[i].start = rm_res->desc[i].start +
-					oes->pktdma_tchan_flow;
-		irq_res.desc[i].num = rm_res->desc[i].num;
+	if (IS_ERR(rm_res)) {
+		irq_res.desc[0].start = oes->pktdma_tchan_flow;
+		irq_res.desc[0].num = ud->tflow_cnt;
+		i = 1;
+	} else {
+		for (i = 0; i < rm_res->sets; i++) {
+			irq_res.desc[i].start = rm_res->desc[i].start +
+						oes->pktdma_tchan_flow;
+			irq_res.desc[i].num = rm_res->desc[i].num;
+		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
-	for (j = 0; j < rm_res->sets; j++, i++) {
-		irq_res.desc[i].start = rm_res->desc[j].start +
-					oes->pktdma_rchan_flow;
-		irq_res.desc[i].num = rm_res->desc[j].num;
+	if (IS_ERR(rm_res)) {
+		irq_res.desc[i].start = oes->pktdma_rchan_flow;
+		irq_res.desc[i].num = ud->rflow_cnt;
+	} else {
+		for (j = 0; j < rm_res->sets; j++, i++) {
+			irq_res.desc[i].start = rm_res->desc[j].start +
+						oes->pktdma_rchan_flow;
+			irq_res.desc[i].num = rm_res->desc[j].num;
+		}
 	}
 	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
 	kfree(irq_res.desc);
-- 
2.34.1

