Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6B149D4
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfEFMgL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 08:36:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33868 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfEFMgK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 08:36:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x46CZTLE110983;
        Mon, 6 May 2019 07:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557146129;
        bh=LQGk6bzP2U3fyMzIxnX21CxpUwANj3mNi/depjbzqBQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nc2zNEw+6wQY/M30HLsN/85LHnjPA72j98uLeCZ2oaot1ZBRlJOBPi2zHfXK0fOjg
         2AJ7BajZzhhetXHMQHoMbcb4o4NJ2Vu/6lfXSbVW32qe/vaLS3KUXUSUj/i9Ng3Lps
         T1xaZex+utj1+zUjSKoIIztpXckLnqdXqOtgs82U=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x46CZTQY024363
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 May 2019 07:35:29 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 6 May
 2019 07:35:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 6 May 2019 07:35:28 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x46CYpUH110286;
        Mon, 6 May 2019 07:35:25 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
Subject: [PATCH 11/16] dmaengine: ti: New driver for K3 UDMA - split#2: probe/remove, xlate and filter_fn
Date:   Mon, 6 May 2019 15:34:51 +0300
Message-ID: <20190506123456.6777-12-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506123456.6777-1-peter.ujfalusi@ti.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Split patch for review containing: module probe/remove functions, of_xlate
and filter_fn for slave channel requests.

DMA driver for
Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)

The UDMA-P is intended to perform similar (but significantly upgraded) functions
as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
supports the transmission and reception of various packet types. The UDMA-P is
architected to facilitate the segmentation and reassembly of SoC DMA data
structure compliant packets to/from smaller data blocks that are natively
compatible with the specific requirements of each connected peripheral. Multiple
Tx and Rx channels are provided within the DMA which allow multiple segmentation
or reassembly operations to be ongoing. The DMA controller maintains state
information for each of the channels which allows packet segmentation and
reassembly operations to be time division multiplexed between channels in order
to share the underlying DMA hardware. An external DMA scheduler is used to
control the ordering and rate at which this multiplexing occurs for Transmit
operations. The ordering and rate of Receive operations is indirectly controlled
by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.

The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
channels. Channels in the UDMA-P can be configured to be either Packet-Based or
Third-Party channels on a channel by channel basis.

The initial driver supports:
- MEM_TO_MEM (TR mode)
- DEV_TO_MEM (Packet / TR mode)
- MEM_TO_DEV (Packet / TR mode)
- Cyclic (Packet / TR mode)
- Metadata for descriptors

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 495 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 495 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 81bc52f59044..b9db73fee1b7 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1006,3 +1006,498 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+
+static struct platform_driver udma_driver;
+
+static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	u32 *args;
+	struct udma_chan *uc;
+	struct udma_dev *ud;
+	struct device_node *chconf_node, *slave_node;
+	char prop[50];
+	u32 val;
+
+	if (chan->device->dev->driver != &udma_driver.driver)
+		return false;
+
+	uc = to_udma_chan(chan);
+	ud = uc->ud;
+	args = param;
+
+	if (args[2] == UDMA_DIR_TX) {
+		uc->dir = DMA_MEM_TO_DEV;
+	} else if (args[2] == UDMA_DIR_RX) {
+		uc->dir = DMA_DEV_TO_MEM;
+	} else {
+		dev_err(ud->dev, "Invalid direction (%u)\n", args[2]);
+		return false;
+	}
+
+	slave_node = of_find_node_by_phandle(args[0]);
+	if (!slave_node) {
+		dev_err(ud->dev, "Slave node is missing\n");
+		return false;
+	}
+
+	snprintf(prop, sizeof(prop), "ti,psil-config%u", args[1]);
+	chconf_node = of_find_node_by_name(slave_node, prop);
+	if (!chconf_node) {
+		dev_err(ud->dev, "Channel configuration node is missing\n");
+		of_node_put(slave_node);
+		return false;
+	}
+
+	if (!of_property_read_u32(chconf_node, "linux,udma-mode", &val)) {
+		if (val == UDMA_PKT_MODE)
+			uc->pkt_mode = true;
+	}
+
+	if (!of_property_read_u32(chconf_node, "statictr-type", &val))
+		uc->static_tr_type = val;
+
+	if (!of_property_read_u32(chconf_node, "ti,channel-tpl", &val))
+		uc->channel_tpl = val;
+
+	uc->needs_epib = of_property_read_bool(chconf_node, "ti,needs-epib");
+	if (!of_property_read_u32(chconf_node, "ti,psd-size", &val))
+		uc->psd_size = val;
+	uc->metadata_size = (uc->needs_epib ? CPPI5_INFO0_HDESC_EPIB_SIZE : 0) +
+			    uc->psd_size;
+
+	if (uc->pkt_mode)
+		uc->hdesc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
+				 uc->metadata_size, ud->desc_align);
+
+	of_node_put(chconf_node);
+
+	if (of_property_read_u32(slave_node, "ti,psil-base", &val)) {
+		dev_err(ud->dev, "ti,psil-base is missing\n");
+		of_node_put(slave_node);
+		return false;
+	}
+
+	uc->remote_thread_id = val + args[1];
+
+	of_node_put(slave_node);
+
+	dev_dbg(ud->dev, "chan%d: Remote thread: 0x%04x (%s)\n", uc->id,
+		uc->remote_thread_id, udma_get_dir_text(uc->dir));
+
+	return true;
+}
+
+static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
+				      struct of_dma *ofdma)
+{
+	struct udma_dev *ud = ofdma->of_dma_data;
+	struct dma_chan *chan;
+
+	if (dma_spec->args_count != 3)
+		return NULL;
+
+	chan = dmadev_get_slave_channel(&ud->ddev, udma_dma_filter_fn,
+					&dma_spec->args[0]);
+	if (!chan) {
+		dev_err(ud->dev, "get channel fail in %s.\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return chan;
+}
+
+static struct udma_match_data am654_main_data = {
+	.enable_memcpy_support = true,
+	.tpl_levels = 2,
+	.level_start_idx = {
+		[0] = 8, /* Normal channels */
+		[1] = 0, /* High Throughput channels */
+	},
+};
+
+static struct udma_match_data am654_mcu_data = {
+	.enable_memcpy_support = false, /* MEM_TO_MEM is slow via MCU UDMA */
+	.tpl_levels = 2,
+	.level_start_idx = {
+		[0] = 2, /* Normal channels */
+		[1] = 0, /* High Throughput channels */
+	},
+};
+
+static const struct of_device_id udma_of_match[] = {
+	{
+		.compatible = "ti,am654-navss-main-udmap",
+		.data = &am654_main_data,
+	},
+	{
+		.compatible = "ti,am654-navss-mcu-udmap",
+		.data = &am654_mcu_data,
+	},
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, udma_of_match);
+
+static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
+{
+	struct resource *res;
+	int i;
+
+	for (i = 0; i < MMR_LAST; i++) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   mmr_names[i]);
+		ud->mmrs[i] = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(ud->mmrs[i]))
+			return PTR_ERR(ud->mmrs[i]);
+	}
+
+	return 0;
+}
+
+static int udma_setup_resources(struct udma_dev *ud)
+{
+	struct device *dev = ud->dev;
+	int ch_count, ret, i, j;
+	u32 cap2, cap3;
+	struct ti_sci_resource_desc *rm_desc;
+	struct ti_sci_resource *rm_res, irq_res;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	static const char * const range_names[] = { "ti,sci-rm-range-tchan",
+						    "ti,sci-rm-range-rchan",
+						    "ti,sci-rm-range-rflow" };
+
+	cap2 = udma_read(ud->mmrs[MMR_GCFG], 0x28);
+	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
+
+	ud->rflow_cnt = cap3 & 0x3fff;
+	ud->tchan_cnt = cap2 & 0x1ff;
+	ud->echan_cnt = (cap2 >> 9) & 0x1ff;
+	ud->rchan_cnt = (cap2 >> 18) & 0x1ff;
+	ch_count  = ud->tchan_cnt + ud->rchan_cnt;
+
+	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
+				  GFP_KERNEL);
+	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
+				  GFP_KERNEL);
+	ud->rflow_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rflow_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rflow_map_reserved = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
+					      sizeof(unsigned long),
+					      GFP_KERNEL);
+	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
+				  GFP_KERNEL);
+
+	if (!ud->tchan_map || !ud->rchan_map || !ud->rflow_map ||
+	    !ud->rflow_map_reserved || !ud->tchans || !ud->rchans ||
+	    !ud->rflows)
+		return -ENOMEM;
+
+	/*
+	 * RX flows with the same Ids as RX channels are reserved to be used
+	 * as default flows if remote HW can't generate flow_ids. Those
+	 * RX flows can be requested only explicitly by id.
+	 */
+	bitmap_set(ud->rflow_map_reserved, 0, ud->rchan_cnt);
+
+	/* Get resource ranges from tisci */
+	for (i = 0; i < RM_RANGE_LAST; i++)
+		tisci_rm->rm_ranges[i] =
+			devm_ti_sci_get_of_resource(tisci_rm->tisci, dev,
+						    tisci_rm->tisci_dev_id,
+						    (char *)range_names[i]);
+
+	/* tchan ranges */
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
+	if (IS_ERR(rm_res)) {
+		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
+	} else {
+		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
+		for (i = 0; i < rm_res->sets; i++) {
+			rm_desc = &rm_res->desc[i];
+			bitmap_clear(ud->tchan_map, rm_desc->start,
+				     rm_desc->num);
+		}
+	}
+	irq_res.sets = rm_res->sets;
+
+	/* rchan and matching default flow ranges */
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
+	if (IS_ERR(rm_res)) {
+		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
+		bitmap_zero(ud->rflow_map, ud->rchan_cnt);
+	} else {
+		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
+		bitmap_fill(ud->rflow_map, ud->rchan_cnt);
+		for (i = 0; i < rm_res->sets; i++) {
+			rm_desc = &rm_res->desc[i];
+			bitmap_clear(ud->rchan_map, rm_desc->start,
+				     rm_desc->num);
+			bitmap_clear(ud->rflow_map, rm_desc->start,
+				     rm_desc->num);
+		}
+	}
+
+	irq_res.sets += rm_res->sets;
+	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
+	for (i = 0; i < rm_res->sets; i++) {
+		irq_res.desc[i].start = rm_res->desc[i].start;
+		irq_res.desc[i].num = rm_res->desc[i].num;
+	}
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
+	for (j = 0; j < rm_res->sets; j++, i++) {
+		irq_res.desc[i].start = rm_res->desc[j].start + 0x2000;
+		irq_res.desc[i].num = rm_res->desc[j].num;
+	}
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
+	kfree(irq_res.desc);
+	if (ret) {
+		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
+		return ret;
+	}
+
+	/* GP rflow ranges */
+	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
+	if (IS_ERR(rm_res)) {
+		bitmap_clear(ud->rflow_map, ud->rchan_cnt,
+			     ud->rflow_cnt - ud->rchan_cnt);
+	} else {
+		bitmap_set(ud->rflow_map, ud->rchan_cnt,
+			   ud->rflow_cnt - ud->rchan_cnt);
+		for (i = 0; i < rm_res->sets; i++) {
+			rm_desc = &rm_res->desc[i];
+			bitmap_clear(ud->rflow_map, rm_desc->start,
+				     rm_desc->num);
+		}
+	}
+
+	ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
+	ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
+	if (!ch_count)
+		return -ENODEV;
+
+	ud->channels = devm_kcalloc(dev, ch_count, sizeof(*ud->channels),
+				    GFP_KERNEL);
+	if (!ud->channels)
+		return -ENOMEM;
+
+	dev_info(dev,
+		 "Channels: %d (tchan: %u, echan: %u, rchan: %u, rflow: %u)\n",
+		 ch_count, ud->tchan_cnt, ud->echan_cnt, ud->rchan_cnt,
+		 ud->rflow_cnt);
+
+	return ch_count;
+}
+
+#define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
+
+static int udma_probe(struct platform_device *pdev)
+{
+	struct device_node *navss_node = pdev->dev.parent->of_node;
+	struct device *dev = &pdev->dev;
+	struct udma_dev *ud;
+	const struct of_device_id *match;
+	int i, ret;
+	int ch_count;
+
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (ret)
+		dev_err(dev, "failed to set dma mask stuff\n");
+
+	ud = devm_kzalloc(dev, sizeof(*ud), GFP_KERNEL);
+	if (!ud)
+		return -ENOMEM;
+
+	ret = udma_get_mmrs(pdev, ud);
+	if (ret)
+		return ret;
+
+	ud->tisci_rm.tisci = ti_sci_get_by_phandle(dev->of_node, "ti,sci");
+	if (IS_ERR(ud->tisci_rm.tisci))
+		return PTR_ERR(ud->tisci_rm.tisci);
+
+	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id",
+				   &ud->tisci_rm.tisci_dev_id);
+	if (ret) {
+		dev_err(dev, "ti,sci-dev-id read failure %d\n", ret);
+		return ret;
+	}
+	pdev->id = ud->tisci_rm.tisci_dev_id;
+
+	ret = of_property_read_u32(navss_node, "ti,sci-dev-id",
+				   &ud->tisci_rm.tisci_navss_dev_id);
+	if (ret) {
+		dev_err(dev, "NAVSS ti,sci-dev-id read failure %d\n", ret);
+		return ret;
+	}
+
+	ud->tisci_rm.tisci_udmap_ops = &ud->tisci_rm.tisci->ops.rm_udmap_ops;
+	ud->tisci_rm.tisci_psil_ops = &ud->tisci_rm.tisci->ops.rm_psil_ops;
+
+	ud->ringacc = of_k3_ringacc_get_by_phandle(dev->of_node, "ti,ringacc");
+	if (IS_ERR(ud->ringacc))
+		return PTR_ERR(ud->ringacc);
+
+	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
+					    DOMAIN_BUS_TI_SCI_INTA_MSI);
+	if (!dev->msi_domain) {
+		dev_err(dev, "Failed to get MSI domain\n");
+		return -EPROBE_DEFER;
+	}
+
+	match = of_match_node(udma_of_match, dev->of_node);
+	if (!match) {
+		dev_err(dev, "No compatible match found\n");
+		return -ENODEV;
+	}
+	ud->match_data = match->data;
+
+	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
+	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
+
+	ud->ddev.device_alloc_chan_resources = udma_alloc_chan_resources;
+	ud->ddev.device_config = udma_slave_config;
+	ud->ddev.device_prep_slave_sg = udma_prep_slave_sg;
+	ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
+	ud->ddev.device_issue_pending = udma_issue_pending;
+	ud->ddev.device_tx_status = udma_tx_status;
+	ud->ddev.device_pause = udma_pause;
+	ud->ddev.device_resume = udma_resume;
+	ud->ddev.device_terminate_all = udma_terminate_all;
+	ud->ddev.device_synchronize = udma_synchronize;
+
+	ud->ddev.device_free_chan_resources = udma_free_chan_resources;
+	ud->ddev.src_addr_widths = TI_UDMAC_BUSWIDTHS;
+	ud->ddev.dst_addr_widths = TI_UDMAC_BUSWIDTHS;
+	ud->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	ud->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	ud->ddev.copy_align = DMAENGINE_ALIGN_8_BYTES;
+	ud->ddev.desc_metadata_modes = DESC_METADATA_CLIENT |
+				       DESC_METADATA_ENGINE;
+	if (ud->match_data->enable_memcpy_support) {
+		dma_cap_set(DMA_MEMCPY, ud->ddev.cap_mask);
+		ud->ddev.device_prep_dma_memcpy = udma_prep_dma_memcpy;
+		ud->ddev.directions |= BIT(DMA_MEM_TO_MEM);
+	}
+
+	ud->ddev.dev = dev;
+	ud->dev = dev;
+
+	INIT_LIST_HEAD(&ud->ddev.channels);
+	INIT_LIST_HEAD(&ud->desc_to_purge);
+
+	ret = of_property_read_u32(dev->of_node, "ti,psil-base",
+				   &ud->psil_base);
+	if (ret) {
+		dev_info(dev, "Missing ti,psil-base property, using %d.\n",
+			 ret);
+		return ret;
+	}
+
+	ch_count = udma_setup_resources(ud);
+	if (ch_count <= 0)
+		return ch_count;
+
+	spin_lock_init(&ud->lock);
+	INIT_WORK(&ud->purge_work, udma_purge_desc_work);
+
+	ud->desc_align = 64;
+	if (ud->desc_align < dma_get_cache_alignment())
+		ud->desc_align = dma_get_cache_alignment();
+
+	for (i = 0; i < ud->tchan_cnt; i++) {
+		struct udma_tchan *tchan = &ud->tchans[i];
+
+		tchan->id = i;
+		tchan->reg_rt = ud->mmrs[MMR_TCHANRT] + i * 0x1000;
+	}
+
+	for (i = 0; i < ud->rchan_cnt; i++) {
+		struct udma_rchan *rchan = &ud->rchans[i];
+
+		rchan->id = i;
+		rchan->reg_rt = ud->mmrs[MMR_RCHANRT] + i * 0x1000;
+	}
+
+	for (i = 0; i < ud->rflow_cnt; i++) {
+		struct udma_rflow *rflow = &ud->rflows[i];
+
+		rflow->id = i;
+	}
+
+	for (i = 0; i < ch_count; i++) {
+		struct udma_chan *uc = &ud->channels[i];
+
+		uc->ud = ud;
+		uc->vc.desc_free = udma_desc_free;
+		uc->id = i;
+		uc->remote_thread_id = -1;
+		uc->tchan = NULL;
+		uc->rchan = NULL;
+		uc->dir = DMA_MEM_TO_MEM;
+		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
+					  dev_name(dev), i);
+
+		vchan_init(&uc->vc, &ud->ddev);
+		/* Use custom vchan completion handling */
+		tasklet_init(&uc->vc.task, udma_vchan_complete,
+			     (unsigned long)&uc->vc);
+		init_completion(&uc->teardown_completed);
+	}
+
+	ret = dma_async_device_register(&ud->ddev);
+	if (ret) {
+		dev_err(dev, "failed to register slave DMA engine: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, ud);
+
+	ret = of_dma_controller_register(dev->of_node, udma_of_xlate, ud);
+	if (ret) {
+		dev_err(dev, "failed to register of_dma controller\n");
+		dma_async_device_unregister(&ud->ddev);
+	}
+
+	return ret;
+}
+
+static int udma_remove(struct platform_device *pdev)
+{
+	struct udma_dev *ud = platform_get_drvdata(pdev);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&ud->ddev);
+
+	/* Make sure that we did proper cleanup */
+	cancel_work_sync(&ud->purge_work);
+	udma_purge_desc_work(&ud->purge_work);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver udma_driver = {
+	.driver = {
+		.name	= "ti-udma",
+		.of_match_table = udma_of_match,
+	},
+	.probe		= udma_probe,
+	.remove		= udma_remove,
+};
+
+module_platform_driver(udma_driver);
+
+MODULE_ALIAS("platform:ti-udma");
+MODULE_DESCRIPTION("TI K3 DMA driver for CPPI 5.0 compliant devices");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

