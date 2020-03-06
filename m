Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B944017C035
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCFO2u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 09:28:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36246 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFO2t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Mar 2020 09:28:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 026EShJU098556;
        Fri, 6 Mar 2020 08:28:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583504923;
        bh=epEgo9Mc3Y0W/pqupclf1kOKI/maS/SomefQSM1pvp4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HUZrmMC/ykbvlpsZpSF6OEmjocZ5k5gGJCeAVXGBfEODGwsJmwtsSYshD16THmK3M
         Bd3OBjKx2SjtwQ0Pkz542b8p+ktdo91XvCULJfPkCR175GbUxwgOfnoeN714Flo1Qb
         L8xYEF5HgFeyia+qGd+wGJdzrRJnwotneq39r1O8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 026EShpg101651
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Mar 2020 08:28:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Mar
 2020 08:28:43 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Mar 2020 08:28:43 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 026ESbUa115246;
        Fri, 6 Mar 2020 08:28:41 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v5 2/3] dmaengine: ti: k3-udma: Implement custom dbg_summary_show for debugfs
Date:   Fri, 6 Mar 2020 16:28:38 +0200
Message-ID: <20200306142839.17910-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306142839.17910-1-peter.ujfalusi@ti.com>
References: <20200306142839.17910-1-peter.ujfalusi@ti.com>
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
index 5e076e5680f4..a9c0251adf1a 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3501,6 +3501,66 @@ static int udma_setup_rx_flush(struct udma_dev *ud)
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
@@ -3587,6 +3647,9 @@ static int udma_probe(struct platform_device *pdev)
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

