Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE062B5D95
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgKQK4b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:56:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgKQK43 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:56:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAuM4c117205;
        Tue, 17 Nov 2020 04:56:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610582;
        bh=clrhNW0HKvD5h4sMDEuhMbOQDZdCfb7rL0FInuqE+2c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KBNUOnx8v9DK79Kzxm70fQyEuREgoG/nHBulAthwoBGfNYnIpf67R1RhD0p/GSpwC
         GrQzSYp623Zl9nVBLLlLA22ic9v3NqbfYs3TmUoaRgQnde1a44HVXRi8MKlxduZJVQ
         y35YLiOZoKH9iG35Wtl0wBCtLzH4uBus7xKuPu58=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAuMSg010012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:56:22 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:56:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:56:21 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6to087311;
        Tue, 17 Nov 2020 04:56:19 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 04/19] dmaengine: ti: k3-udma-glue: Add function to get device pointer for DMA API
Date:   Tue, 17 Nov 2020 12:56:41 +0200
Message-ID: <20201117105656.5236-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117105656.5236-1-peter.ujfalusi@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Glue layer users should use the device of the DMA for DMA mapping and
allocations as it is the DMA which accesses to descriptors and buffers,
not the clients

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 14 ++++++++++++++
 drivers/dma/ti/k3-udma-private.c |  6 ++++++
 drivers/dma/ti/k3-udma.h         |  1 +
 include/linux/dma/k3-udma-glue.h |  4 ++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index dfb65e382ab9..29d1524d1916 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -493,6 +493,13 @@ int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
 
+struct device *
+	k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn)
+{
+	return xudma_get_device(tx_chn->common.udmax);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_dma_device);
+
 static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 {
 	const struct udma_tisci_rm *tisci_rm = rx_chn->common.tisci_rm;
@@ -1201,3 +1208,10 @@ int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 	return flow->virq;
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_irq);
+
+struct device *
+	k3_udma_glue_rx_get_dma_device(struct k3_udma_glue_rx_channel *rx_chn)
+{
+	return xudma_get_device(rx_chn->common.udmax);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_dma_device);
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 8563a392f30b..c9fb1d832581 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -50,6 +50,12 @@ struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property)
 }
 EXPORT_SYMBOL(of_xudma_dev_get);
 
+struct device *xudma_get_device(struct udma_dev *ud)
+{
+	return ud->dev;
+}
+EXPORT_SYMBOL(xudma_get_device);
+
 u32 xudma_dev_get_psil_base(struct udma_dev *ud)
 {
 	return ud->psil_base;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 09c4529e013d..d1cace0cb43b 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -112,6 +112,7 @@ int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 			    u32 dst_thread);
 
 struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property);
+struct device *xudma_get_device(struct udma_dev *ud);
 void xudma_dev_put(struct udma_dev *ud);
 u32 xudma_dev_get_psil_base(struct udma_dev *ud);
 struct udma_tisci_rm *xudma_dev_get_tisci_rm(struct udma_dev *ud);
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index 5eb34ad973a7..d7c12f31377c 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -41,6 +41,8 @@ void k3_udma_glue_reset_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 u32 k3_udma_glue_tx_get_hdesc_size(struct k3_udma_glue_tx_channel *tx_chn);
 u32 k3_udma_glue_tx_get_txcq_id(struct k3_udma_glue_tx_channel *tx_chn);
 int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn);
+struct device *
+	k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn);
 
 enum {
 	K3_UDMA_GLUE_SRC_TAG_LO_KEEP = 0,
@@ -130,5 +132,7 @@ int k3_udma_glue_rx_flow_enable(struct k3_udma_glue_rx_channel *rx_chn,
 				u32 flow_idx);
 int k3_udma_glue_rx_flow_disable(struct k3_udma_glue_rx_channel *rx_chn,
 				 u32 flow_idx);
+struct device *
+	k3_udma_glue_rx_get_dma_device(struct k3_udma_glue_rx_channel *rx_chn);
 
 #endif /* K3_UDMA_GLUE_H_ */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

