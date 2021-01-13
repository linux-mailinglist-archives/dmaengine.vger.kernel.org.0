Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE02F4A97
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbhAMLsK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 06:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbhAMLr6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jan 2021 06:47:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B76C06179F;
        Wed, 13 Jan 2021 03:47:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u25so2331583lfc.2;
        Wed, 13 Jan 2021 03:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErApFw9/tg5Njrn59qXljPaRIT8dXV27C9p2SiWgiqU=;
        b=RX/JopX0eUOAvBJmau80+yqqEXtIaSWYd7H4NEklO0QomKj4qKCj0uwh3YFP+GERqS
         NbixHXMGCubO+mtl+ZS68n8gSlOX6hp/KfkNVT01YGAneglSvnss/ZHFBROHErfmh6aZ
         PaU+OFS8wnRj/pa/RlWfwRl0dC6xsZt1Eq3NnWR/CZe/ge+kDUJ7W5xqoeqyU5yLSY93
         hdmtgWJlX5aEN/qCRxzqU96iovCCVAnCxJTkZ1jA8IuKchdDqPK3TUYsflCNRPBJnEkD
         PTXC4tU8QhGVAeufd/MRqXlZvJVBrphSLQUa25cU0/hAlu2hj2+vf8r6dkNs6nYxFtJK
         9qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErApFw9/tg5Njrn59qXljPaRIT8dXV27C9p2SiWgiqU=;
        b=oUkzpjp4uwfRwHDdD0Kn5sZ/BGSb44L0CZf8Ak2R5yHZ1ITGg3BAgW3GyRC0Tq2YHa
         ewSjEhehR7vIiFFD8rrX7SxblktnlYAqL1yfbub7v2hMZr5uu7IUD6y1U4RPGkbqRMcZ
         lhxiECVh/YkMLF/xqV6odb5ShJmde9Ys3GvU56Gh7SLOOjPg9ZWoubaeXiHk+ob/Iga7
         qtO9Qe/Gn2TJQ0mkYYVZyNymD6BLjbtIeiiz4r48UAbTcYHdKu3oUXzVVBC0HIiOTUzB
         BUgOsZRqzNmqBivXlRPmW789pAXXd7rR8K+7w4UihNFFQ5uVp94AaIsyveYdx69S0D7l
         sY9w==
X-Gm-Message-State: AOAM532qAPgmT7Mnktc6n88o8QU32+A3TOUblIYjHupSyPesTAkt2951
        i2bOPvEFf6qCo3n1DcJkw2I=
X-Google-Smtp-Source: ABdhPJwyeaeoI9l+d29o3sxk/+955RdAOCSrAneoBLA+cCybKH3+t/VEZU/5JPpNTQR3C1YVnlXFow==
X-Received: by 2002:a19:5f13:: with SMTP id t19mr706272lfb.79.1610538436819;
        Wed, 13 Jan 2021 03:47:16 -0800 (PST)
Received: from localhost.localdomain (91-157-87-152.elisa-laajakaista.fi. [91.157.87.152])
        by smtp.gmail.com with ESMTPSA id f19sm186489lfc.71.2021.01.13.03.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:47:16 -0800 (PST)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
Subject: [PATCH v2 2/3] dmaengine: ti: k3-udma: Add support for burst_size configuration for mem2mem
Date:   Wed, 13 Jan 2021 13:49:22 +0200
Message-Id: <20210113114923.9231-3-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
References: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

The UDMA and BCDMA can provide higher throughput if the burst_size of the
channel is changed from it's default (which is 64 bytes) for Ultra-high
and high capacity channels.

This performance benefit is even more visible when the buffers are aligned
with the burst_size configuration.

The am654 does not have a way to change the burst size, but it is using
64 bytes burst, so increasing the copy_align from 8 bytes to 64 (and
clients taking that into account) can increase the throughput as well.

Numbers gathered on j721e:
echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
echo 2000 > /sys/module/dmatest/parameters/timeout
echo 50 > /sys/module/dmatest/parameters/iterations
echo 1 > /sys/module/dmatest/parameters/max_channels

Prior this patch:       ~1.3 GB/s
After this patch:       ~1.8 GB/s
 with 1 byte alignment: ~1.7 GB/s

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/dma/ti/k3-udma.c | 116 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 298460438bb4..1030c2ff487a 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -121,6 +121,11 @@ struct udma_oes_offsets {
 #define UDMA_FLAG_PDMA_ACC32		BIT(0)
 #define UDMA_FLAG_PDMA_BURST		BIT(1)
 #define UDMA_FLAG_TDTYPE		BIT(2)
+#define UDMA_FLAG_BURST_SIZE		BIT(3)
+#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
+					 UDMA_FLAG_PDMA_BURST | \
+					 UDMA_FLAG_TDTYPE | \
+					 UDMA_FLAG_BURST_SIZE)
 
 struct udma_match_data {
 	enum k3_dma_type type;
@@ -128,6 +133,7 @@ struct udma_match_data {
 	bool enable_memcpy_support;
 	u32 flags;
 	u32 statictr_z_mask;
+	u8 burst_size[3];
 };
 
 struct udma_soc_data {
@@ -436,6 +442,18 @@ static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
 	}
 }
 
+static u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
+{
+	int i;
+
+	for (i = 0; i < tpl_map->levels; i++) {
+		if (chan_id >= tpl_map->start_idx[i])
+			return i;
+	}
+
+	return 0;
+}
+
 static void udma_reset_uchan(struct udma_chan *uc)
 {
 	memset(&uc->config, 0, sizeof(uc->config));
@@ -1811,13 +1829,21 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct udma_tchan *tchan = uc->tchan;
 	struct udma_rchan *rchan = uc->rchan;
+	u8 burst_size = 0;
 	int ret = 0;
+	u8 tpl;
 
 	/* Non synchronized - mem to mem type of transfer */
 	int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
 	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
 
+	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
+		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, tchan->id);
+
+		burst_size = ud->match_data->burst_size[tpl];
+	}
+
 	req_tx.valid_params = TISCI_UDMA_TCHAN_VALID_PARAMS;
 	req_tx.nav_id = tisci_rm->tisci_dev_id;
 	req_tx.index = tchan->id;
@@ -1825,6 +1851,10 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	req_tx.tx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
 	req_tx.txcq_qnum = tc_ring;
 	req_tx.tx_atype = ud->atype;
+	if (burst_size) {
+		req_tx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_BURST_SIZE_VALID;
+		req_tx.tx_burst_size = burst_size;
+	}
 
 	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
 	if (ret) {
@@ -1839,6 +1869,10 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	req_rx.rxcq_qnum = tc_ring;
 	req_rx.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
 	req_rx.rx_atype = ud->atype;
+	if (burst_size) {
+		req_rx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_BURST_SIZE_VALID;
+		req_rx.rx_burst_size = burst_size;
+	}
 
 	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
 	if (ret)
@@ -1854,12 +1888,24 @@ static int bcdma_tisci_m2m_channel_config(struct udma_chan *uc)
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
 	struct udma_bchan *bchan = uc->bchan;
+	u8 burst_size = 0;
 	int ret = 0;
+	u8 tpl;
+
+	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
+		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, bchan->id);
+
+		burst_size = ud->match_data->burst_size[tpl];
+	}
 
 	req_tx.valid_params = TISCI_BCDMA_BCHAN_VALID_PARAMS;
 	req_tx.nav_id = tisci_rm->tisci_dev_id;
 	req_tx.extended_ch_type = TI_SCI_RM_BCDMA_EXTENDED_CH_TYPE_BCHAN;
 	req_tx.index = bchan->id;
+	if (burst_size) {
+		req_tx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_BURST_SIZE_VALID;
+		req_tx.tx_burst_size = burst_size;
+	}
 
 	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
 	if (ret)
@@ -4167,6 +4213,11 @@ static struct udma_match_data am654_main_data = {
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
 	.statictr_z_mask = GENMASK(11, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* H Channels */
+		0, /* No UH Channels */
+	},
 };
 
 static struct udma_match_data am654_mcu_data = {
@@ -4174,38 +4225,63 @@ static struct udma_match_data am654_mcu_data = {
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false,
 	.statictr_z_mask = GENMASK(11, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* H Channels */
+		0, /* No UH Channels */
+	},
 };
 
 static struct udma_match_data j721e_main_data = {
 	.type = DMA_TYPE_UDMA,
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
+	.flags = UDMA_FLAGS_J7_CLASS,
 	.statictr_z_mask = GENMASK(23, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES, /* H Channels */
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES, /* UH Channels */
+	},
 };
 
 static struct udma_match_data j721e_mcu_data = {
 	.type = DMA_TYPE_UDMA,
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false, /* MEM_TO_MEM is slow via MCU UDMA */
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
+	.flags = UDMA_FLAGS_J7_CLASS,
 	.statictr_z_mask = GENMASK(23, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES, /* H Channels */
+		0, /* No UH Channels */
+	},
 };
 
 static struct udma_match_data am64_bcdma_data = {
 	.type = DMA_TYPE_BCDMA,
 	.psil_base = 0x2000, /* for tchan and rchan, not applicable to bchan */
 	.enable_memcpy_support = true, /* Supported via bchan */
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
+	.flags = UDMA_FLAGS_J7_CLASS,
 	.statictr_z_mask = GENMASK(23, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		0, /* No H Channels */
+		0, /* No UH Channels */
+	},
 };
 
 static struct udma_match_data am64_pktdma_data = {
 	.type = DMA_TYPE_PKTDMA,
 	.psil_base = 0x1000,
 	.enable_memcpy_support = false, /* PKTDMA does not support MEM_TO_MEM */
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
+	.flags = UDMA_FLAGS_J7_CLASS,
 	.statictr_z_mask = GENMASK(23, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		0, /* No H Channels */
+		0, /* No UH Channels */
+	},
 };
 
 static const struct of_device_id udma_of_match[] = {
@@ -5045,6 +5121,34 @@ static void udma_dbg_summary_show(struct seq_file *s,
 }
 #endif /* CONFIG_DEBUG_FS */
 
+static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
+{
+	const struct udma_match_data *match_data = ud->match_data;
+	u8 tpl;
+
+	if (!match_data->enable_memcpy_support)
+		return DMAENGINE_ALIGN_8_BYTES;
+
+	/* Get the highest TPL level the device supports for memcpy */
+	if (ud->bchan_cnt)
+		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
+	else if (ud->tchan_cnt)
+		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
+	else
+		return DMAENGINE_ALIGN_8_BYTES;
+
+	switch (match_data->burst_size[tpl]) {
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
+		return DMAENGINE_ALIGN_256_BYTES;
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
+		return DMAENGINE_ALIGN_128_BYTES;
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
+	fallthrough;
+	default:
+		return DMAENGINE_ALIGN_64_BYTES;
+	}
+}
+
 #define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
@@ -5201,7 +5305,6 @@ static int udma_probe(struct platform_device *pdev)
 	ud->ddev.dst_addr_widths = TI_UDMAC_BUSWIDTHS;
 	ud->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	ud->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
-	ud->ddev.copy_align = DMAENGINE_ALIGN_8_BYTES;
 	ud->ddev.desc_metadata_modes = DESC_METADATA_CLIENT |
 				       DESC_METADATA_ENGINE;
 	if (ud->match_data->enable_memcpy_support &&
@@ -5283,6 +5386,9 @@ static int udma_probe(struct platform_device *pdev)
 		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
 	}
 
+	/* Configure the copy_align to the maximum burst size the device supports */
+	ud->ddev.copy_align = udma_get_copy_align(ud);
+
 	ret = dma_async_device_register(&ud->ddev);
 	if (ret) {
 		dev_err(dev, "failed to register slave DMA engine: %d\n", ret);
-- 
2.30.0

