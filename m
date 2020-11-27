Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E392C6069
	for <lists+dmaengine@lfdr.de>; Fri, 27 Nov 2020 08:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404994AbgK0HRs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Nov 2020 02:17:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51846 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404938AbgK0HRr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Nov 2020 02:17:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AR7HcdA128347;
        Fri, 27 Nov 2020 01:17:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606461458;
        bh=QCEaSAPyq4gNobl1XoJ4kq3NkpE9v4LSEb38RtVgIik=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Dg4TgYQ+CSyn6JRe2Sgbfq2RwZYMSVbOPhB5py1tiotoGlbYMx0lz6doOhyrUPMbD
         ZYp0pzEl9xq5NP8rRRRCoe/S33/xAcyZkOlylYa+7XAJvPDgbyScv6KT6YiVIngvW4
         FieivqcUXtz6pI9L5xns/kTKkXQPpyLoxDA5NKDY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AR7Hc1S105208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 01:17:38 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 27
 Nov 2020 01:17:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 27 Nov 2020 01:17:38 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AR7HZt6015823;
        Fri, 27 Nov 2020 01:17:35 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <vigneshr@ti.com>, <grygorii.strashko@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: Add new class for glue channels
Date:   Fri, 27 Nov 2020 09:18:31 +0200
Message-ID: <20201127071831.29986-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117105656.5236-20-peter.ujfalusi@ti.com>
References: <20201117105656.5236-20-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dev_release must be provided for a device and in case of the udma glue
layer it is in essence an empty function as the struct containing the
registered device is devm managed.

Reported-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

now that we actually have the silicon and the glue layer got into use it was
descovered that we need to have a class with dev_release function for the
devices we create for the physical channels used by the glue layer.

Vinod: I would prefer to send v3 and squash this patch down to the parent.

Regards,
Peter

 drivers/dma/ti/k3-udma-glue.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 2d0b26a7bf78..790027a99c4c 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -85,6 +85,16 @@ struct k3_udma_glue_rx_channel {
 	u32 flows_ready;
 };
 
+static void chan_dev_release(struct device *dev)
+{
+	/* The struct containing the device is devm managed */
+}
+
+static struct class k3_udma_glue_devclass = {
+	.name		= "k3_udma_glue_chan",
+	.dev_release	= chan_dev_release,
+};
+
 #define K3_UDMAX_TDOWN_TIMEOUT_US 1000
 
 static int of_k3_udma_glue_parse(struct device_node *udmax_np,
@@ -286,6 +296,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	}
 	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
 
+	tx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
 	tx_chn->common.chan_dev.parent = xudma_get_device(tx_chn->common.udmax);
 	dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
 		     tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
@@ -903,6 +914,7 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 	}
 	rx_chn->udma_rchan_id = xudma_rchan_get_id(rx_chn->udma_rchanx);
 
+	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
 	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
 	dev_set_name(&rx_chn->common.chan_dev, "rchan%d-0x%04x",
 		     rx_chn->udma_rchan_id, rx_chn->common.src_thread);
@@ -1033,6 +1045,7 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 		goto err;
 	}
 
+	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
 	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
 	dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x",
 		     rx_chn->common.src_thread);
@@ -1419,3 +1432,9 @@ void k3_udma_glue_rx_cppi5_to_dma_addr(struct k3_udma_glue_rx_channel *rx_chn,
 	*addr &= (u64)GENMASK(K3_ADDRESS_ASEL_SHIFT - 1, 0);
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_rx_cppi5_to_dma_addr);
+
+static int __init k3_udma_glue_class_init(void)
+{
+	return class_register(&k3_udma_glue_devclass);
+}
+arch_initcall(k3_udma_glue_class_init);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

