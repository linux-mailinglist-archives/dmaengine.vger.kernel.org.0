Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501D425D82E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Sep 2020 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgIDL6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Sep 2020 07:58:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45764 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDL6a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Sep 2020 07:58:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 084BwPh3025749;
        Fri, 4 Sep 2020 06:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599220705;
        bh=ppWhjyapygAMKEg69y563wG0ylzRbYN3RFv8wAqxcu0=;
        h=From:To:CC:Subject:Date;
        b=OX70LvSDAw7v/X9k+g7QL2YXYFSp5+VyXfYKNS//S4OTFgR+ViP2j+ANtIcDD3Fqw
         vIujmq1rTYfqKZ5EhEjN0GVcKlHz4L7sxN6dcPh3gI+dB60aUdwXu92+8b+G/7R7JR
         K5t2eiAv3fFDC7jPRmK/NJLOFDCNkzB5BDYoRY5E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 084BwPrT064939
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Sep 2020 06:58:25 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Sep
 2020 06:58:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Sep 2020 06:58:25 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 084BwNqI095932;
        Fri, 4 Sep 2020 06:58:23 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>, <nm@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Use soc_device_match() for SoC dependent parameters
Date:   Fri, 4 Sep 2020 15:00:09 +0300
Message-ID: <20200904120009.30941-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use separate data for SoC dependent parameters. These parameters depends
on the DMA integration (either in HW or in SYSFW), the DMA controller
itself remains compatible with either the am654 or j721e variant.

j7200 have the same DMA as j721e with different number of channels, which
can be queried from HW, but SYSFW defines different rchan_oes_offset
number for j7200 (0x80) compared to j721e (0x400).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Vinod,

this patch is going to be needed when the j7200 support is upstream (we already
have the psil map in dmaengine/next for the UDMA).

Since the hardware itself is the same (but different number of channels) I
wanted to avoid a new set of compatible just becase STSFW is not using the same
rchan_oes_offset value for j7200 and j721e.

Vinod: this patch will not apply cleanly on dmaengine/next because it is on top
of dmaengine/next + the dmaengine/fixes. This might cause issues.

"dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3.0" in
fixes changes the rchan_oes_offset for am654 from 0x2000 to 0x200 and this patch
assumes 0x200...

is there anything I can do to make it easier for you?

Regards,
Peter

 drivers/dma/ti/k3-udma.c | 42 +++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 9a7048bcf0f1..ec7c5f320f7f 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sys_soc.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
 #include <linux/of_device.h>
@@ -91,6 +92,9 @@ struct udma_match_data {
 	bool enable_memcpy_support;
 	u32 flags;
 	u32 statictr_z_mask;
+};
+
+struct udma_soc_data {
 	u32 rchan_oes_offset;
 };
 
@@ -117,6 +121,7 @@ struct udma_dev {
 	struct device *dev;
 	void __iomem *mmrs[MMR_LAST];
 	const struct udma_match_data *match_data;
+	const struct udma_soc_data *soc_data;
 
 	u8 tpl_levels;
 	u32 tpl_start_idx[3];
@@ -1679,7 +1684,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
 	struct udma_dev *ud = to_udma_dev(chan->device);
-	const struct udma_match_data *match_data = ud->match_data;
+	const struct udma_soc_data *soc_data = ud->soc_data;
 	struct k3_ring *irq_ring;
 	u32 irq_udma_idx;
 	int ret;
@@ -1779,7 +1784,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 					K3_PSIL_DST_THREAD_ID_OFFSET;
 
 		irq_ring = uc->rflow->r_ring;
-		irq_udma_idx = match_data->rchan_oes_offset + uc->rchan->id;
+		irq_udma_idx = soc_data->rchan_oes_offset + uc->rchan->id;
 
 		ret = udma_tisci_rx_channel_config(uc);
 		break;
@@ -3091,14 +3096,12 @@ static struct udma_match_data am654_main_data = {
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
 	.statictr_z_mask = GENMASK(11, 0),
-	.rchan_oes_offset = 0x200,
 };
 
 static struct udma_match_data am654_mcu_data = {
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false,
 	.statictr_z_mask = GENMASK(11, 0),
-	.rchan_oes_offset = 0x200,
 };
 
 static struct udma_match_data j721e_main_data = {
@@ -3106,7 +3109,6 @@ static struct udma_match_data j721e_main_data = {
 	.enable_memcpy_support = true,
 	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
 	.statictr_z_mask = GENMASK(23, 0),
-	.rchan_oes_offset = 0x400,
 };
 
 static struct udma_match_data j721e_mcu_data = {
@@ -3114,7 +3116,6 @@ static struct udma_match_data j721e_mcu_data = {
 	.enable_memcpy_support = false, /* MEM_TO_MEM is slow via MCU UDMA */
 	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
 	.statictr_z_mask = GENMASK(23, 0),
-	.rchan_oes_offset = 0x400,
 };
 
 static const struct of_device_id udma_of_match[] = {
@@ -3135,6 +3136,25 @@ static const struct of_device_id udma_of_match[] = {
 	{ /* Sentinel */ },
 };
 
+struct udma_soc_data am654_soc_data = {
+	.rchan_oes_offset = 0x200,
+};
+
+struct udma_soc_data j721e_soc_data = {
+	.rchan_oes_offset = 0x400,
+};
+
+struct udma_soc_data j7200_soc_data = {
+	.rchan_oes_offset = 0x80,
+};
+
+static const struct soc_device_attribute k3_soc_devices[] = {
+	{ .family = "AM65X", .data = &am654_soc_data },
+	{ .family = "J721E", .data = &j721e_soc_data },
+	{ .family = "J7200", .data = &j7200_soc_data },
+	{ /* sentinel */ }
+};
+
 static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 {
 	struct resource *res;
@@ -3277,7 +3297,7 @@ static int udma_setup_resources(struct udma_dev *ud)
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 	for (j = 0; j < rm_res->sets; j++, i++) {
 		irq_res.desc[i].start = rm_res->desc[j].start +
-					ud->match_data->rchan_oes_offset;
+					ud->soc_data->rchan_oes_offset;
 		irq_res.desc[i].num = rm_res->desc[j].num;
 	}
 	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
@@ -3487,6 +3507,7 @@ static void udma_dbg_summary_show(struct seq_file *s,
 static int udma_probe(struct platform_device *pdev)
 {
 	struct device_node *navss_node = pdev->dev.parent->of_node;
+	const struct soc_device_attribute *soc;
 	struct device *dev = &pdev->dev;
 	struct udma_dev *ud;
 	const struct of_device_id *match;
@@ -3551,6 +3572,13 @@ static int udma_probe(struct platform_device *pdev)
 	}
 	ud->match_data = match->data;
 
+	soc = soc_device_match(k3_soc_devices);
+	if (!soc) {
+		dev_err(dev, "No compatible SoC found\n");
+		return -ENODEV;
+	}
+	ud->soc_data = soc->data;
+
 	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

