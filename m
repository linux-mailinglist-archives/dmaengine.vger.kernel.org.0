Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3A1737EC
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2020 14:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgB1NID (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Feb 2020 08:08:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38580 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgB1NIC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Feb 2020 08:08:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01SD7s3g011555;
        Fri, 28 Feb 2020 07:07:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582895274;
        bh=5vN+4gaPAOiKilti2WhXQezE/nW02Nkfaza04gj1gYA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SYsSfLOnslcRgb8DgHYVjLfMzyDZL3zc6HWI6YownDvyX+PLPwl1rA+r4m2cUQQIi
         Ci8ckbmcLhDjG4viDN4Zvf9q1M8SO+TM185pNzd2tFpMqjyR1EbRSZQulT9qngmYEK
         A8YDyG8AcdDgbwTzGI0BJGWk+CZeBxCmc2ypnh2I=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01SD7smR022371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 07:07:54 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 07:07:53 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 07:07:53 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01SD7lcu037330;
        Fri, 28 Feb 2020 07:07:51 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v4 2/2] dmaengine: ti: k3-udma: Implement custom dbg_summary_show for debugfs
Date:   Fri, 28 Feb 2020 15:07:47 +0200
Message-ID: <20200228130747.22905-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228130747.22905-1-peter.ujfalusi@ti.com>
References: <20200228130747.22905-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the custom dbg_summary_show the driver can show useful information
about the used channels.

dma0 (285c0000.dma-controller): number of channels: 24

dma1 (31150000.dma-controller): number of channels: 84
 dma1chan0    | 2b00000.mcasp:tx (MEM_TO_DEV, tchan16 [0x1010 -> 0xc400], PDMA[ ACC32 BURST ], TR mode)
 dma1chan1    | 2b00000.mcasp:rx (DEV_TO_MEM, rchan16 [0x4400 -> 0x9010], PDMA[ ACC32 BURST ], TR mode)
 dma1chan2    | 2ba0000.mcasp:tx (MEM_TO_DEV, tchan17 [0x1011 -> 0xc507], PDMA[ ACC32 BURST ], TR mode)
 dma1chan3    | 2ba0000.mcasp:rx (DEV_TO_MEM, rchan17 [0x4507 -> 0x9011], PDMA[ ACC32 BURST ], TR mode)
 dma1chan4    | in-use (MEM_TO_MEM, chan0 pair [0x1000 -> 0x9000], PSI-L Native, TR mode)
 dma1chan5    | in-use (MEM_TO_MEM, chan1 pair [0x1001 -> 0x9001], PSI-L Native, TR mode)
 dma1chan6    | in-use (MEM_TO_MEM, chan4 pair [0x1004 -> 0x9004], PSI-L Native, TR mode)
 dma1chan7    | in-use (MEM_TO_MEM, chan5 pair [0x1005 -> 0x9005], PSI-L Native, TR mode)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0536866a58ce..80a05ee5e8e4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3473,6 +3473,66 @@ static int udma_setup_rx_flush(struct udma_dev *ud)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static void udma_dbg_summary_show_chan(struct seq_file *s,
+				       struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_chan_config *ucc = &uc->config;
+
+	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
+		   chan->dbg_client_name ?: "in-use");
+	seq_printf(s, " (%s, ", dmaengine_get_direction_text(uc->config.dir));
+
+	switch (uc->config.dir) {
+	case DMA_MEM_TO_MEM:
+		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		break;
+	case DMA_DEV_TO_MEM:
+		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		break;
+	case DMA_MEM_TO_DEV:
+		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		break;
+	default:
+		seq_printf(s, ")\n");
+		return;
+	}
+
+	if (ucc->ep_type == PSIL_EP_NATIVE) {
+		seq_printf(s, "PSI-L Native");
+		if (ucc->metadata_size) {
+			seq_printf(s, "[%s", ucc->needs_epib ? " EPIB" : "");
+			if (ucc->psd_size)
+				seq_printf(s, " PSDsize:%u", ucc->psd_size);
+			seq_printf(s, " ]");
+		}
+	} else {
+		seq_printf(s, "PDMA");
+		if (ucc->enable_acc32 || ucc->enable_burst)
+			seq_printf(s, "[%s%s ]",
+				   ucc->enable_acc32 ? " ACC32" : "",
+				   ucc->enable_burst ? " BURST" : "");
+	}
+
+	seq_printf(s, ", %s)\n", ucc->pkt_mode ? "Packet mode" : "TR mode");
+}
+
+static void udma_dbg_summary_show(struct seq_file *s,
+				  struct dma_device *dma_dev)
+{
+	struct dma_chan *chan;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count)
+			udma_dbg_summary_show_chan(s, chan);
+	}
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
@@ -3553,6 +3613,9 @@ static int udma_probe(struct platform_device *pdev)
 	ud->ddev.device_resume = udma_resume;
 	ud->ddev.device_terminate_all = udma_terminate_all;
 	ud->ddev.device_synchronize = udma_synchronize;
+#ifdef CONFIG_DEBUG_FS
+	ud->ddev.dbg_summary_show = udma_dbg_summary_show;
+#endif
 
 	ud->ddev.device_free_chan_resources = udma_free_chan_resources;
 	ud->ddev.src_addr_widths = TI_UDMAC_BUSWIDTHS;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

