Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F480F758D
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 14:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfKKNxS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 08:53:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56722 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfKKNxR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 08:53:17 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xABDr6be090695;
        Mon, 11 Nov 2019 07:53:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573480386;
        bh=ohRHfztl/6cwF/ARblvPlIwfCKujALnmx6Fu/d0o7cU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JaU2tcB3WN+oVX9nAefMGll10oCv8xzvrHGI6fxhCXyoYinufZUOkG++nUWIPhzqJ
         X70LtqTIAZ2Zo8A6JFFeuPA2ThL2s2LFqd4HUXcvz8mWVjcAwORj2Zb6oY9yVOoKDA
         OtDTg2rhc3KjPHmp+JE2QVF+DlRjtZ5O+1PRBbrA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xABDr633046552;
        Mon, 11 Nov 2019 07:53:06 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 07:52:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 07:52:49 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xABDqE90097668;
        Mon, 11 Nov 2019 07:53:03 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v5 13/15] dmaengine: ti: New driver for K3 UDMA - split#5: dma_device callbacks 2
Date:   Mon, 11 Nov 2019 15:53:28 +0200
Message-ID: <20191111135330.8235-14-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111135330.8235-1-peter.ujfalusi@ti.com>
References: <20191111135330.8235-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Split patch for review containing:
device_prep_slave_sg and device_prep_dma_cyclic implementation supporting
packet and TR channels.

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
 drivers/dma/ti/k3-udma.c | 702 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 702 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 4b113c4eb3d9..8cffc41b9d38 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1790,6 +1790,708 @@ static int udma_slave_config(struct dma_chan *chan,
 	return 0;
 }
 
+static struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
+					    size_t tr_size, int tr_count,
+					    enum dma_transfer_direction dir)
+{
+	struct udma_hwdesc *hwdesc;
+	struct cppi5_desc_hdr_t *tr_desc;
+	struct udma_desc *d;
+	u32 reload_count = 0;
+	u32 ring_id;
+
+	switch (tr_size) {
+	case 16:
+	case 32:
+	case 64:
+	case 128:
+		break;
+	default:
+		dev_err(uc->ud->dev, "Unsupported TR size of %zu\n", tr_size);
+		return NULL;
+	}
+
+	/* We have only one descriptor containing multiple TRs */
+	d = kzalloc(sizeof(*d) + sizeof(d->hwdesc[0]), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	d->sglen = tr_count;
+
+	d->hwdesc_count = 1;
+	hwdesc = &d->hwdesc[0];
+
+	/* Allocate memory for DMA ring descriptor */
+	if (uc->use_dma_pool) {
+		hwdesc->cppi5_desc_size = uc->hdesc_size;
+		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
+						GFP_ATOMIC,
+						&hwdesc->cppi5_desc_paddr);
+	} else {
+		hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size,
+								 tr_count);
+		hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
+						uc->ud->desc_align);
+		hwdesc->cppi5_desc_vaddr = dma_alloc_coherent(uc->ud->dev,
+						hwdesc->cppi5_desc_size,
+						&hwdesc->cppi5_desc_paddr,
+						GFP_ATOMIC);
+	}
+
+	if (!hwdesc->cppi5_desc_vaddr) {
+		kfree(d);
+		return NULL;
+	}
+
+	/* Start of the TR req records */
+	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
+	/* Start address of the TR response array */
+	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size * tr_count;
+
+	tr_desc = hwdesc->cppi5_desc_vaddr;
+
+	if (uc->cyclic)
+		reload_count = CPPI5_INFO0_TRDESC_RLDCNT_INFINITE;
+
+	if (dir == DMA_DEV_TO_MEM)
+		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
+	else
+		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
+
+	cppi5_trdesc_init(tr_desc, tr_count, tr_size, 0, reload_count);
+	cppi5_desc_set_pktids(tr_desc, uc->id, 0x3fff);
+	cppi5_desc_set_retpolicy(tr_desc, 0, ring_id);
+
+	return d;
+}
+
+static struct udma_desc *
+udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
+		      unsigned int sglen, enum dma_transfer_direction dir,
+		      unsigned long tx_flags, void *context)
+{
+	enum dma_slave_buswidth dev_width;
+	struct scatterlist *sgent;
+	struct udma_desc *d;
+	size_t tr_size;
+	struct cppi5_tr_type1_t *tr_req = NULL;
+	unsigned int i;
+	u32 burst;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_width = uc->cfg.src_addr_width;
+		burst = uc->cfg.src_maxburst;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_width = uc->cfg.dst_addr_width;
+		burst = uc->cfg.dst_maxburst;
+	} else {
+		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
+		return NULL;
+	}
+
+	if (!burst)
+		burst = 1;
+
+	/* Now allocate and setup the descriptor. */
+	tr_size = sizeof(struct cppi5_tr_type1_t);
+	d = udma_alloc_tr_desc(uc, tr_size, sglen, dir);
+	if (!d)
+		return NULL;
+
+	d->sglen = sglen;
+
+	tr_req = (struct cppi5_tr_type1_t *)d->hwdesc[0].tr_req_base;
+	for_each_sg(sgl, sgent, sglen, i) {
+		d->residue += sg_dma_len(sgent);
+
+		cppi5_tr_init(&tr_req[i].flags, CPPI5_TR_TYPE1, false, false,
+			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+		cppi5_tr_csf_set(&tr_req[i].flags, CPPI5_TR_CSF_SUPR_EVT);
+
+		tr_req[i].addr = sg_dma_address(sgent);
+		tr_req[i].icnt0 = burst * dev_width;
+		tr_req[i].dim1 = burst * dev_width;
+		tr_req[i].icnt1 = sg_dma_len(sgent) / tr_req[i].icnt0;
+	}
+
+	cppi5_tr_csf_set(&tr_req[i - 1].flags, CPPI5_TR_CSF_EOP);
+
+	return d;
+}
+
+static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
+				   enum dma_slave_buswidth dev_width,
+				   u16 elcnt)
+{
+	if (uc->ep_type != PSIL_EP_PDMA_XY)
+		return 0;
+
+	/* Bus width translates to the element size (ES) */
+	switch (dev_width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		d->static_tr.elsize = 0;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		d->static_tr.elsize = 1;
+		break;
+	case DMA_SLAVE_BUSWIDTH_3_BYTES:
+		d->static_tr.elsize = 2;
+		break;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		d->static_tr.elsize = 3;
+		break;
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		d->static_tr.elsize = 4;
+		break;
+	default: /* not reached */
+		return -EINVAL;
+	}
+
+	d->static_tr.elcnt = elcnt;
+
+	/*
+	 * PDMA must to close the packet when the channel is in packet mode.
+	 * For TR mode when the channel is not cyclic we also need PDMA to close
+	 * the packet otherwise the transfer will stall because PDMA holds on
+	 * the data it has received from the peripheral.
+	 */
+	if (uc->pkt_mode || !uc->cyclic) {
+		unsigned int div = dev_width * elcnt;
+
+		if (uc->cyclic)
+			d->static_tr.bstcnt = d->residue / d->sglen / div;
+		else
+			d->static_tr.bstcnt = d->residue / div;
+
+		if (uc->dir == DMA_DEV_TO_MEM &&
+		    d->static_tr.bstcnt > uc->ud->match_data->statictr_z_mask)
+			return -EINVAL;
+	} else {
+		d->static_tr.bstcnt = 0;
+	}
+
+	return 0;
+}
+
+static struct udma_desc *
+udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
+		       unsigned int sglen, enum dma_transfer_direction dir,
+		       unsigned long tx_flags, void *context)
+{
+	struct scatterlist *sgent;
+	struct cppi5_host_desc_t *h_desc = NULL;
+	struct udma_desc *d;
+	u32 ring_id;
+	unsigned int i;
+
+	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	d->sglen = sglen;
+	d->hwdesc_count = sglen;
+
+	if (dir == DMA_DEV_TO_MEM)
+		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
+	else
+		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
+
+	for_each_sg(sgl, sgent, sglen, i) {
+		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
+		dma_addr_t sg_addr = sg_dma_address(sgent);
+		struct cppi5_host_desc_t *desc;
+		size_t sg_len = sg_dma_len(sgent);
+
+		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
+						GFP_ATOMIC,
+						&hwdesc->cppi5_desc_paddr);
+		if (!hwdesc->cppi5_desc_vaddr) {
+			dev_err(uc->ud->dev,
+				"descriptor%d allocation failed\n", i);
+
+			udma_free_hwdesc(uc, d);
+			kfree(d);
+			return NULL;
+		}
+
+		d->residue += sg_len;
+		hwdesc->cppi5_desc_size = uc->hdesc_size;
+		desc = hwdesc->cppi5_desc_vaddr;
+
+		if (i == 0) {
+			cppi5_hdesc_init(desc, 0, 0);
+			/* Flow and Packed ID */
+			cppi5_desc_set_pktids(&desc->hdr, uc->id, 0x3fff);
+			cppi5_desc_set_retpolicy(&desc->hdr, 0, ring_id);
+		} else {
+			cppi5_hdesc_reset_hbdesc(desc);
+			cppi5_desc_set_retpolicy(&desc->hdr, 0, 0xffff);
+		}
+
+		/* attach the sg buffer to the descriptor */
+		cppi5_hdesc_attach_buf(desc, sg_addr, sg_len, sg_addr, sg_len);
+
+		/* Attach link as host buffer descriptor */
+		if (h_desc)
+			cppi5_hdesc_link_hbdesc(h_desc,
+						hwdesc->cppi5_desc_paddr);
+
+		if (dir == DMA_MEM_TO_DEV)
+			h_desc = desc;
+	}
+
+	if (d->residue >= SZ_4M) {
+		dev_err(uc->ud->dev,
+			"%s: Transfer size %u is over the supported 4M range\n",
+			__func__, d->residue);
+		udma_free_hwdesc(uc, d);
+		kfree(d);
+		return NULL;
+	}
+
+	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
+	cppi5_hdesc_set_pktlen(h_desc, d->residue);
+
+	return d;
+}
+
+static int udma_attach_metadata(struct dma_async_tx_descriptor *desc,
+				void *data, size_t len)
+{
+	struct udma_desc *d = to_udma_desc(desc);
+	struct udma_chan *uc = to_udma_chan(desc->chan);
+	struct cppi5_host_desc_t *h_desc;
+	u32 psd_size = len;
+	u32 flags = 0;
+
+	if (!uc->pkt_mode || !uc->metadata_size)
+		return -ENOTSUPP;
+
+	if (!data || len > uc->metadata_size)
+		return -EINVAL;
+
+	if (uc->needs_epib && len < CPPI5_INFO0_HDESC_EPIB_SIZE)
+		return -EINVAL;
+
+	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
+	if (d->dir == DMA_MEM_TO_DEV)
+		memcpy(h_desc->epib, data, len);
+
+	if (uc->needs_epib)
+		psd_size -= CPPI5_INFO0_HDESC_EPIB_SIZE;
+
+	d->metadata = data;
+	d->metadata_size = len;
+	if (uc->needs_epib)
+		flags |= CPPI5_INFO0_HDESC_EPIB_PRESENT;
+
+	cppi5_hdesc_update_flags(h_desc, flags);
+	cppi5_hdesc_update_psdata_size(h_desc, psd_size);
+
+	return 0;
+}
+
+static void *udma_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
+				   size_t *payload_len, size_t *max_len)
+{
+	struct udma_desc *d = to_udma_desc(desc);
+	struct udma_chan *uc = to_udma_chan(desc->chan);
+	struct cppi5_host_desc_t *h_desc;
+
+	if (!uc->pkt_mode || !uc->metadata_size)
+		return ERR_PTR(-ENOTSUPP);
+
+	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
+
+	*max_len = uc->metadata_size;
+
+	*payload_len = cppi5_hdesc_epib_present(&h_desc->hdr) ?
+		       CPPI5_INFO0_HDESC_EPIB_SIZE : 0;
+	*payload_len += cppi5_hdesc_get_psdata_size(h_desc);
+
+	return h_desc->epib;
+}
+
+static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
+				 size_t payload_len)
+{
+	struct udma_desc *d = to_udma_desc(desc);
+	struct udma_chan *uc = to_udma_chan(desc->chan);
+	struct cppi5_host_desc_t *h_desc;
+	u32 psd_size = payload_len;
+	u32 flags = 0;
+
+	if (!uc->pkt_mode || !uc->metadata_size)
+		return -ENOTSUPP;
+
+	if (payload_len > uc->metadata_size)
+		return -EINVAL;
+
+	if (uc->needs_epib && payload_len < CPPI5_INFO0_HDESC_EPIB_SIZE)
+		return -EINVAL;
+
+	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
+
+	if (uc->needs_epib) {
+		psd_size -= CPPI5_INFO0_HDESC_EPIB_SIZE;
+		flags |= CPPI5_INFO0_HDESC_EPIB_PRESENT;
+	}
+
+	cppi5_hdesc_update_flags(h_desc, flags);
+	cppi5_hdesc_update_psdata_size(h_desc, psd_size);
+
+	return 0;
+}
+
+static struct dma_descriptor_metadata_ops metadata_ops = {
+	.attach = udma_attach_metadata,
+	.get_ptr = udma_get_metadata_ptr,
+	.set_len = udma_set_metadata_len,
+};
+
+static struct dma_async_tx_descriptor *
+udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		   unsigned int sglen, enum dma_transfer_direction dir,
+		   unsigned long tx_flags, void *context)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	enum dma_slave_buswidth dev_width;
+	struct udma_desc *d;
+	u32 burst;
+
+	if (dir != uc->dir) {
+		dev_err(chan->device->dev,
+			"%s: chan%d is for %s, not supporting %s\n",
+			__func__, uc->id, udma_get_dir_text(uc->dir),
+			udma_get_dir_text(dir));
+		return NULL;
+	}
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_width = uc->cfg.src_addr_width;
+		burst = uc->cfg.src_maxburst;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_width = uc->cfg.dst_addr_width;
+		burst = uc->cfg.dst_maxburst;
+	} else {
+		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
+		return NULL;
+	}
+
+	if (!burst)
+		burst = 1;
+
+	if (uc->pkt_mode)
+		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
+					   context);
+	else
+		d = udma_prep_slave_sg_tr(uc, sgl, sglen, dir, tx_flags,
+					  context);
+
+	if (!d)
+		return NULL;
+
+	d->dir = dir;
+	d->desc_idx = 0;
+	d->tr_idx = 0;
+
+	/* static TR for remote PDMA */
+	if (udma_configure_statictr(uc, d, dev_width, burst)) {
+		dev_err(uc->ud->dev,
+			"%s: StaticTR Z is limted to maximum 4095 (%u)\n",
+			__func__, d->static_tr.bstcnt);
+
+		udma_free_hwdesc(uc, d);
+		kfree(d);
+		return NULL;
+	}
+
+	if (uc->metadata_size)
+		d->vd.tx.metadata_ops = &metadata_ops;
+
+	return vchan_tx_prep(&uc->vc, &d->vd, tx_flags);
+}
+
+static struct udma_desc *
+udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
+			size_t buf_len, size_t period_len,
+			enum dma_transfer_direction dir, unsigned long flags)
+{
+	enum dma_slave_buswidth dev_width;
+	struct udma_desc *d;
+	size_t tr_size;
+	struct cppi5_tr_type1_t *tr_req;
+	unsigned int i;
+	unsigned int periods = buf_len / period_len;
+	u32 burst;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_width = uc->cfg.src_addr_width;
+		burst = uc->cfg.src_maxburst;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_width = uc->cfg.dst_addr_width;
+		burst = uc->cfg.dst_maxburst;
+	} else {
+		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
+		return NULL;
+	}
+
+	if (!burst)
+		burst = 1;
+
+	/* Now allocate and setup the descriptor. */
+	tr_size = sizeof(struct cppi5_tr_type1_t);
+	d = udma_alloc_tr_desc(uc, tr_size, periods, dir);
+	if (!d)
+		return NULL;
+
+	tr_req = (struct cppi5_tr_type1_t *)d->hwdesc[0].tr_req_base;
+	for (i = 0; i < periods; i++) {
+		cppi5_tr_init(&tr_req[i].flags, CPPI5_TR_TYPE1, false, false,
+			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+
+		tr_req[i].addr = buf_addr + period_len * i;
+		tr_req[i].icnt0 = dev_width;
+		tr_req[i].icnt1 = period_len / dev_width;
+		tr_req[i].dim1 = dev_width;
+
+		if (!(flags & DMA_PREP_INTERRUPT))
+			cppi5_tr_csf_set(&tr_req[i].flags,
+					 CPPI5_TR_CSF_SUPR_EVT);
+	}
+
+	return d;
+}
+
+static struct udma_desc *
+udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
+			 size_t buf_len, size_t period_len,
+			 enum dma_transfer_direction dir, unsigned long flags)
+{
+	struct udma_desc *d;
+	u32 ring_id;
+	int i;
+	int periods = buf_len / period_len;
+
+	if (periods > (K3_UDMA_DEFAULT_RING_SIZE - 1))
+		return NULL;
+
+	if (period_len > 0x3FFFFF)
+		return NULL;
+
+	d = kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	d->hwdesc_count = periods;
+
+	/* TODO: re-check this... */
+	if (dir == DMA_DEV_TO_MEM)
+		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
+	else
+		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
+
+	for (i = 0; i < periods; i++) {
+		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
+		dma_addr_t period_addr = buf_addr + (period_len * i);
+		struct cppi5_host_desc_t *h_desc;
+
+		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
+						GFP_ATOMIC,
+						&hwdesc->cppi5_desc_paddr);
+		if (!hwdesc->cppi5_desc_vaddr) {
+			dev_err(uc->ud->dev,
+				"descriptor%d allocation failed\n", i);
+
+			udma_free_hwdesc(uc, d);
+			kfree(d);
+			return NULL;
+		}
+
+		hwdesc->cppi5_desc_size = uc->hdesc_size;
+		h_desc = hwdesc->cppi5_desc_vaddr;
+
+		cppi5_hdesc_init(h_desc, 0, 0);
+		cppi5_hdesc_set_pktlen(h_desc, period_len);
+
+		/* Flow and Packed ID */
+		cppi5_desc_set_pktids(&h_desc->hdr, uc->id, 0x3fff);
+		cppi5_desc_set_retpolicy(&h_desc->hdr, 0, ring_id);
+
+		/* attach each period to a new descriptor */
+		cppi5_hdesc_attach_buf(h_desc,
+				       period_addr, period_len,
+				       period_addr, period_len);
+	}
+
+	return d;
+}
+
+static struct dma_async_tx_descriptor *
+udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+		     size_t period_len, enum dma_transfer_direction dir,
+		     unsigned long flags)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	enum dma_slave_buswidth dev_width;
+	struct udma_desc *d;
+	u32 burst;
+
+	if (dir != uc->dir) {
+		dev_err(chan->device->dev,
+			"%s: chan%d is for %s, not supporting %s\n",
+			__func__, uc->id, udma_get_dir_text(uc->dir),
+			udma_get_dir_text(dir));
+		return NULL;
+	}
+
+	uc->cyclic = true;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_width = uc->cfg.src_addr_width;
+		burst = uc->cfg.src_maxburst;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_width = uc->cfg.dst_addr_width;
+		burst = uc->cfg.dst_maxburst;
+	} else {
+		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
+		return NULL;
+	}
+
+	if (!burst)
+		burst = 1;
+
+	if (uc->pkt_mode)
+		d = udma_prep_dma_cyclic_pkt(uc, buf_addr, buf_len, period_len,
+					     dir, flags);
+	else
+		d = udma_prep_dma_cyclic_tr(uc, buf_addr, buf_len, period_len,
+					    dir, flags);
+
+	if (!d)
+		return NULL;
+
+	d->sglen = buf_len / period_len;
+
+	d->dir = dir;
+	d->residue = buf_len;
+
+	/* static TR for remote PDMA */
+	if (udma_configure_statictr(uc, d, dev_width, burst)) {
+		dev_err(uc->ud->dev,
+			"%s: StaticTR Z is limted to maximum 4095 (%u)\n",
+			__func__, d->static_tr.bstcnt);
+
+		udma_free_hwdesc(uc, d);
+		kfree(d);
+		return NULL;
+	}
+
+	if (uc->metadata_size)
+		d->vd.tx.metadata_ops = &metadata_ops;
+
+	return vchan_tx_prep(&uc->vc, &d->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *
+udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+		     size_t len, unsigned long tx_flags)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_desc *d;
+	struct cppi5_tr_type15_t *tr_req;
+	int num_tr;
+	size_t tr_size = sizeof(struct cppi5_tr_type15_t);
+	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
+
+	if (uc->dir != DMA_MEM_TO_MEM) {
+		dev_err(chan->device->dev,
+			"%s: chan%d is for %s, not supporting %s\n",
+			__func__, uc->id, udma_get_dir_text(uc->dir),
+			udma_get_dir_text(DMA_MEM_TO_MEM));
+		return NULL;
+	}
+
+	if (len < SZ_64K) {
+		num_tr = 1;
+		tr0_cnt0 = len;
+		tr0_cnt1 = 1;
+	} else {
+		unsigned long align_to = __ffs(src | dest);
+
+		if (align_to > 3)
+			align_to = 3;
+		/*
+		 * Keep simple: tr0: SZ_64K-alignment blocks,
+		 *		tr1: the remaining
+		 */
+		num_tr = 2;
+		tr0_cnt0 = (SZ_64K - BIT(align_to));
+		if (len / tr0_cnt0 >= SZ_64K) {
+			dev_err(uc->ud->dev, "size %zu is not supported\n",
+				len);
+			return NULL;
+		}
+
+		tr0_cnt1 = len / tr0_cnt0;
+		tr1_cnt0 = len % tr0_cnt0;
+	}
+
+	d = udma_alloc_tr_desc(uc, tr_size, num_tr, DMA_MEM_TO_MEM);
+	if (!d)
+		return NULL;
+
+	d->dir = DMA_MEM_TO_MEM;
+	d->desc_idx = 0;
+	d->tr_idx = 0;
+	d->residue = len;
+
+	tr_req = (struct cppi5_tr_type15_t *)d->hwdesc[0].tr_req_base;
+
+	cppi5_tr_init(&tr_req[0].flags, CPPI5_TR_TYPE15, false, true,
+		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+	cppi5_tr_csf_set(&tr_req[0].flags, CPPI5_TR_CSF_SUPR_EVT);
+
+	tr_req[0].addr = src;
+	tr_req[0].icnt0 = tr0_cnt0;
+	tr_req[0].icnt1 = tr0_cnt1;
+	tr_req[0].icnt2 = 1;
+	tr_req[0].icnt3 = 1;
+	tr_req[0].dim1 = tr0_cnt0;
+
+	tr_req[0].daddr = dest;
+	tr_req[0].dicnt0 = tr0_cnt0;
+	tr_req[0].dicnt1 = tr0_cnt1;
+	tr_req[0].dicnt2 = 1;
+	tr_req[0].dicnt3 = 1;
+	tr_req[0].ddim1 = tr0_cnt0;
+
+	if (num_tr == 2) {
+		cppi5_tr_init(&tr_req[1].flags, CPPI5_TR_TYPE15, false, true,
+			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+		cppi5_tr_csf_set(&tr_req[1].flags, CPPI5_TR_CSF_SUPR_EVT);
+
+		tr_req[1].addr = src + tr0_cnt1 * tr0_cnt0;
+		tr_req[1].icnt0 = tr1_cnt0;
+		tr_req[1].icnt1 = 1;
+		tr_req[1].icnt2 = 1;
+		tr_req[1].icnt3 = 1;
+
+		tr_req[1].daddr = dest + tr0_cnt1 * tr0_cnt0;
+		tr_req[1].dicnt0 = tr1_cnt0;
+		tr_req[1].dicnt1 = 1;
+		tr_req[1].dicnt2 = 1;
+		tr_req[1].dicnt3 = 1;
+	}
+
+	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags, CPPI5_TR_CSF_EOP);
+
+	if (uc->metadata_size)
+		d->vd.tx.metadata_ops = &metadata_ops;
+
+	return vchan_tx_prep(&uc->vc, &d->vd, tx_flags);
+}
+
 static void udma_issue_pending(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

