Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A632A0F7F
	for <lists+dmaengine@lfdr.de>; Fri, 30 Oct 2020 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgJ3Ua7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Oct 2020 16:30:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37082 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgJ3U34 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Oct 2020 16:29:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09UKTsfV114723;
        Fri, 30 Oct 2020 15:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604089794;
        bh=7Pwwzv+TgrvuvT6kJgOXLEc8CmUuI0cBSgM+8QQq3HI=;
        h=From:To:CC:Subject:Date;
        b=UWlXAxon24E5LGRtEcbHB5EXnZoPvwuUWhz/SHoAP/ifFb72eCrlSMXJQ/tv0/ehk
         er9fakX/O1VTDuzOFIepjoUhJHap2IR5Z43/dVlzrjj3k8PhfC8l3itDjnjPJuHXIn
         Iwe2A3GIYzOwrYTuYjiSh7f9njOHyo8C0hDwgWEo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09UKTsTZ083104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 15:29:54 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 30
 Oct 2020 15:29:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 30 Oct 2020 15:29:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09UKTrUp068321;
        Fri, 30 Oct 2020 15:29:53 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: move psi-l pairing in channel en/dis functions
Date:   Fri, 30 Oct 2020 22:30:00 +0200
Message-ID: <20201030203000.4281-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The NAVSS UDMA will stuck if target IP module is disabled by PM while PSI-L
threads are paired UDMA<->IP and no further transfers is possible. This
could be the case for IPs J721E Main CPSW (cpsw9g).

Hence, to avoid such situation do PSI-L threads pairing only when UDMA
channel is going to be enabled as at this time DMA consumer module expected
to be active already.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c | 64 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index a367584f0d7b..dfb65e382ab9 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -303,19 +303,6 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 		goto err;
 	}
 
-	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
-				    tx_chn->common.src_thread,
-				    tx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(dev, "PSI-L request err %d\n", ret);
-		goto err;
-	}
-
-	tx_chn->psil_paired = true;
-
-	/* reset TX RT registers */
-	k3_udma_glue_disable_tx_chn(tx_chn);
-
 	k3_udma_glue_dump_tx_chn(tx_chn);
 
 	return tx_chn;
@@ -378,6 +365,18 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn);
 
 int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
+	int ret;
+
+	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
+				    tx_chn->common.src_thread,
+				    tx_chn->common.dst_thread);
+	if (ret) {
+		dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
+		return ret;
+	}
+
+	tx_chn->psil_paired = true;
+
 	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
 			    UDMA_PEER_RT_EN_ENABLE);
 
@@ -398,6 +397,13 @@ void k3_udma_glue_disable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 	xudma_tchanrt_write(tx_chn->udma_tchanx,
 			    UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn dis2");
+
+	if (tx_chn->psil_paired) {
+		xudma_navss_psil_unpair(tx_chn->common.udmax,
+					tx_chn->common.src_thread,
+					tx_chn->common.dst_thread);
+		tx_chn->psil_paired = false;
+	}
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_disable_tx_chn);
 
@@ -815,19 +821,6 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 			goto err;
 	}
 
-	ret = xudma_navss_psil_pair(rx_chn->common.udmax,
-				    rx_chn->common.src_thread,
-				    rx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(dev, "PSI-L request err %d\n", ret);
-		goto err;
-	}
-
-	rx_chn->psil_paired = true;
-
-	/* reset RX RT registers */
-	k3_udma_glue_disable_rx_chn(rx_chn);
-
 	k3_udma_glue_dump_rx_chn(rx_chn);
 
 	return rx_chn;
@@ -1052,12 +1045,24 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_rx_flow_disable);
 
 int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 {
+	int ret;
+
 	if (rx_chn->remote)
 		return -EINVAL;
 
 	if (rx_chn->flows_ready < rx_chn->flow_num)
 		return -EINVAL;
 
+	ret = xudma_navss_psil_pair(rx_chn->common.udmax,
+				    rx_chn->common.src_thread,
+				    rx_chn->common.dst_thread);
+	if (ret) {
+		dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
+		return ret;
+	}
+
+	rx_chn->psil_paired = true;
+
 	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
 			    UDMA_CHAN_RT_CTL_EN);
 
@@ -1078,6 +1083,13 @@ void k3_udma_glue_disable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG, 0);
 
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt dis2");
+
+	if (rx_chn->psil_paired) {
+		xudma_navss_psil_unpair(rx_chn->common.udmax,
+					rx_chn->common.src_thread,
+					rx_chn->common.dst_thread);
+		rx_chn->psil_paired = false;
+	}
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_disable_rx_chn);
 
-- 
2.17.1

