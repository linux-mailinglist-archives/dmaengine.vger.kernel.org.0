Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADBBF70F0
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKJjy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 04:39:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJjy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 04:39:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB9deam107948;
        Mon, 11 Nov 2019 03:39:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573465180;
        bh=BEXZAIpRzxqNeefh/J9C5EiDlt0B/TXLhAEH6e8HpHk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TfHXEZamg58rdWlK5BysZV02AQQQj4UU7QrHapkWnMxQ72oxEdzvHcEsimBil1wd6
         lIv6CticHJZrV5CnF2Wvc1LS51J6EAP0NNB2ojI1Ni1R8wx7dk5/zdc+zQD6o+kLjX
         Xs7IUjaUFXCKeqpsS6D3oBG9JK6xefyD/07vDVUc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAB9ddRZ118324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 03:39:40 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 03:39:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 03:39:21 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB9dZnY090658;
        Mon, 11 Nov 2019 03:39:36 -0600
Subject: Re: [PATCH v4 11/15] dmaengine: ti: New driver for K3 UDMA - split#3:
 alloc/free chan_resources
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-12-peter.ujfalusi@ti.com>
 <20191111060625.GP952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <33c88201-3311-0438-ead5-63ea14a0b153@ti.com>
Date:   Mon, 11 Nov 2019 11:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111060625.GP952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 8.06, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
>> Split patch for review containing: channel rsource allocation and free
> 
> s/rsource/resource

I'll try to remember to fix up this temporally commit message, at the
end these split patches are going to be squashed into one commit when
things are ready to be applied.

>> +static int udma_tisci_tx_channel_config(struct udma_chan *uc)
>> +{
>> +	struct udma_dev *ud = uc->ud;
>> +	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
>> +	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
>> +	struct udma_tchan *tchan = uc->tchan;
>> +	int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
>> +	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
>> +	u32 mode, fetch_size;
>> +	int ret = 0;
>> +
>> +	if (uc->pkt_mode) {
>> +		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
>> +		fetch_size = cppi5_hdesc_calc_size(uc->needs_epib, uc->psd_size,
>> +						   0);
>> +	} else {
>> +		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_PBRR;
>> +		fetch_size = sizeof(struct cppi5_desc_hdr_t);
>> +	}
>> +
>> +	req_tx.valid_params =
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID;
> 
> bunch of these are repeat, you can define a COMMON_VALID_PARAMS and use
> that + specific ones..

OK, I'll try to sanitize these a bit.

>> +
>> +	req_tx.nav_id = tisci_rm->tisci_dev_id;
>> +	req_tx.index = tchan->id;
>> +	req_tx.tx_pause_on_err = 0;
>> +	req_tx.tx_filt_einfo = 0;
>> +	req_tx.tx_filt_pswords = 0;
> 
> i think initialization to 0 is superfluous

Indeed, I'll remove these.

>> +	req_tx.tx_chan_type = mode;
>> +	req_tx.tx_supr_tdpkt = uc->notdpkt;
>> +	req_tx.tx_fetch_size = fetch_size >> 2;
>> +	req_tx.txcq_qnum = tc_ring;
>> +	if (uc->ep_type == PSIL_EP_PDMA_XY) {
>> +		/* wait for peer to complete the teardown for PDMAs */
>> +		req_tx.valid_params |=
>> +				TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID;
>> +		req_tx.tx_tdtype = 1;
>> +	}
>> +
>> +	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
>> +	if (ret)
>> +		dev_err(ud->dev, "tchan%d cfg failed %d\n", tchan->id, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int udma_tisci_rx_channel_config(struct udma_chan *uc)
>> +{
>> +	struct udma_dev *ud = uc->ud;
>> +	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
>> +	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
>> +	struct udma_rchan *rchan = uc->rchan;
>> +	int fd_ring = k3_ringacc_get_ring_id(rchan->fd_ring);
>> +	int rx_ring = k3_ringacc_get_ring_id(rchan->r_ring);
>> +	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
>> +	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
>> +	u32 mode, fetch_size;
>> +	int ret = 0;
>> +
>> +	if (uc->pkt_mode) {
>> +		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
>> +		fetch_size = cppi5_hdesc_calc_size(uc->needs_epib,
>> +							uc->psd_size, 0);
>> +	} else {
>> +		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_PBRR;
>> +		fetch_size = sizeof(struct cppi5_desc_hdr_t);
>> +	}
>> +
>> +	req_rx.valid_params =
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID;
>> +
>> +	req_rx.nav_id = tisci_rm->tisci_dev_id;
>> +	req_rx.index = rchan->id;
>> +	req_rx.rx_fetch_size =  fetch_size >> 2;
>> +	req_rx.rxcq_qnum = rx_ring;
>> +	req_rx.rx_pause_on_err = 0;
>> +	req_rx.rx_chan_type = mode;
>> +	req_rx.rx_ignore_short = 0;
>> +	req_rx.rx_ignore_long = 0;
>> +	req_rx.flowid_start = 0;
>> +	req_rx.flowid_cnt = 0;
>> +
>> +	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
>> +	if (ret) {
>> +		dev_err(ud->dev, "rchan%d cfg failed %d\n", rchan->id, ret);
>> +		return ret;
>> +	}
>> +
>> +	flow_req.valid_params =
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_EINFO_PRESENT_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_PSINFO_PRESENT_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_ERROR_HANDLING_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DESC_TYPE_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_QNUM_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_HI_SEL_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_LO_SEL_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_HI_SEL_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_LO_SEL_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ0_SZ0_QNUM_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ1_QNUM_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ2_QNUM_VALID |
>> +		TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ3_QNUM_VALID;
>> +
>> +	flow_req.nav_id = tisci_rm->tisci_dev_id;
>> +	flow_req.flow_index = rchan->id;
>> +
>> +	if (uc->needs_epib)
>> +		flow_req.rx_einfo_present = 1;
>> +	else
>> +		flow_req.rx_einfo_present = 0;
>> +	if (uc->psd_size)
>> +		flow_req.rx_psinfo_present = 1;
>> +	else
>> +		flow_req.rx_psinfo_present = 0;
>> +	flow_req.rx_error_handling = 1;
>> +	flow_req.rx_desc_type = 0;
>> +	flow_req.rx_dest_qnum = rx_ring;
>> +	flow_req.rx_src_tag_hi_sel = 2;
>> +	flow_req.rx_src_tag_lo_sel = 4;
>> +	flow_req.rx_dest_tag_hi_sel = 5;
>> +	flow_req.rx_dest_tag_lo_sel = 4;
> 
> can we get rid of magic numbers here and elsewhere, or at least comment
> on what these mean..

True, I'll clean it up.

>> +static int udma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct udma_chan *uc = to_udma_chan(chan);
>> +	struct udma_dev *ud = to_udma_dev(chan->device);
>> +	const struct udma_match_data *match_data = ud->match_data;
>> +	struct k3_ring *irq_ring;
>> +	u32 irq_udma_idx;
>> +	int ret;
>> +
>> +	if (uc->pkt_mode || uc->dir == DMA_MEM_TO_MEM) {
>> +		uc->use_dma_pool = true;
>> +		/* in case of MEM_TO_MEM we have maximum of two TRs */
>> +		if (uc->dir == DMA_MEM_TO_MEM) {
>> +			uc->hdesc_size = cppi5_trdesc_calc_size(
>> +					sizeof(struct cppi5_tr_type15_t), 2);
>> +			uc->pkt_mode = false;
>> +		}
>> +	}
>> +
>> +	if (uc->use_dma_pool) {
>> +		uc->hdesc_pool = dma_pool_create(uc->name, ud->ddev.dev,
>> +						 uc->hdesc_size, ud->desc_align,
>> +						 0);
>> +		if (!uc->hdesc_pool) {
>> +			dev_err(ud->ddev.dev,
>> +				"Descriptor pool allocation failed\n");
>> +			uc->use_dma_pool = false;
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Make sure that the completion is in a known state:
>> +	 * No teardown, the channel is idle
>> +	 */
>> +	reinit_completion(&uc->teardown_completed);
>> +	complete_all(&uc->teardown_completed);
> 
> should we not complete first and then do reinit to bring a clean state?

The reason why it is like this is that the udma_synchronize() is
checking the completion and if the client requested the channel and
calls terminate_all_sync() without any transfer then no one will mark
the completion completed.

>> +	uc->state = UDMA_CHAN_IS_IDLE;
>> +
>> +	switch (uc->dir) {
>> +	case DMA_MEM_TO_MEM:
> 
> can you explain why a allocation should be channel dependent, shouldn't
> these things be done in prep_ calls?

A channel can not change direction, it is either MEM_TO_DEV, DEV_TO_MEM
or MEM_TO_MEM and it is set when the channel is requested.

> I looked ahead and checked the prep_ calls and we can use any direction
> so this somehow doesn't make sense!

I'm checking in the prep callbacks if the requested direction is
matching with the channel direction.

I just can not change the channel direction runtime.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
