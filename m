Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCBCAE4EC
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfIJHw4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 03:52:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34800 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfIJHw4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 03:52:56 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8A7qY5a026137;
        Tue, 10 Sep 2019 02:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568101954;
        bh=D/bdqATif9/uNAEy9DaH03ppDcnwrNOsEvgtUatY4Lc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QvuzFMQaYD7v4N+kuMJRtS/OJtbBWTcQJMgXfUUe6VeY4PEOIsNCPumCF59h9nned
         zXk+yyPS4l3ihm0pgs+31Ra5zVzhD8Cgy2m5Soc+Z3f45D0RhjUhRBDyzKvtYywzxJ
         djCN7ad0X1rzOsuZFQYRQjBAeDskwZafhkQSHZrc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8A7qYo5059845;
        Tue, 10 Sep 2019 02:52:34 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 02:52:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 02:52:32 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8A7qT8R036098;
        Tue, 10 Sep 2019 02:52:29 -0500
Subject: Re: [PATCH v2 10/14] dmaengine: ti: New driver for K3 UDMA - split#3:
 alloc/free chan_resources
To:     Grygorii Strashko <grygorii.strashko@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-11-peter.ujfalusi@ti.com>
 <9091414a-6b9f-24c2-1637-2a8c0ac78dee@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2340c8d7-5879-cb1a-d3b0-8936d9d43110@ti.com>
Date:   Tue, 10 Sep 2019 10:53:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9091414a-6b9f-24c2-1637-2a8c0ac78dee@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/09/2019 10.25, Grygorii Strashko wrote:
> 
> 
> On 30/07/2019 12:34, Peter Ujfalusi wrote:
>> Split patch for review containing: channel rsource allocation and free
>> functions.
>>
>> DMA driver for
>> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
>>
>> The UDMA-P is intended to perform similar (but significantly upgraded)
>> functions
>> as the packet-oriented DMA used on previous SoC devices. The UDMA-P
>> module
>> supports the transmission and reception of various packet types. The
>> UDMA-P is
>> architected to facilitate the segmentation and reassembly of SoC DMA data
>> structure compliant packets to/from smaller data blocks that are natively
>> compatible with the specific requirements of each connected
>> peripheral. Multiple
>> Tx and Rx channels are provided within the DMA which allow multiple
>> segmentation
>> or reassembly operations to be ongoing. The DMA controller maintains
>> state
>> information for each of the channels which allows packet segmentation and
>> reassembly operations to be time division multiplexed between channels
>> in order
>> to share the underlying DMA hardware. An external DMA scheduler is
>> used to
>> control the ordering and rate at which this multiplexing occurs for
>> Transmit
>> operations. The ordering and rate of Receive operations is indirectly
>> controlled
>> by the order in which blocks are pushed into the DMA on the Rx PSI-L
>> interface.
>>
>> The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
>> channels. Channels in the UDMA-P can be configured to be either
>> Packet-Based or
>> Third-Party channels on a channel by channel basis.
>>
>> The initial driver supports:
>> - MEM_TO_MEM (TR mode)
>> - DEV_TO_MEM (Packet / TR mode)
>> - MEM_TO_DEV (Packet / TR mode)
>> - Cyclic (Packet / TR mode)
>> - Metadata for descriptors
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma.c | 780 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 780 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 52ccc6d46de9..0de38db03b8d 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -1039,6 +1039,786 @@ static irqreturn_t udma_udma_irq_handler(int
>> irq, void *data)
>>       return IRQ_HANDLED;
>>   }
>>   +static struct udma_rflow *__udma_reserve_rflow(struct udma_dev *ud,
>> +                           enum udma_tp_level tpl, int id)
>> +{
>> +    DECLARE_BITMAP(tmp, K3_UDMA_MAX_RFLOWS);
>> +
>> +    if (id >= 0) {
>> +        if (test_bit(id, ud->rflow_map)) {
>> +            dev_err(ud->dev, "rflow%d is in use\n", id);
>> +            return ERR_PTR(-ENOENT);
>> +        }
>> +    } else {
>> +        bitmap_or(tmp, ud->rflow_map, ud->rflow_map_reserved,
>> +              ud->rflow_cnt);
>> +
>> +        id = find_next_zero_bit(tmp, ud->rflow_cnt, ud->rchan_cnt);
>> +        if (id >= ud->rflow_cnt)
>> +            return ERR_PTR(-ENOENT);
>> +    }
>> +
>> +    set_bit(id, ud->rflow_map);
>> +    return &ud->rflows[id];
>> +}
>> +
>> +#define UDMA_RESERVE_RESOURCE(res)                    \
>> +static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,    \
>> +                           enum udma_tp_level tpl,    \
>> +                           int id)            \
>> +{                                    \
>> +    if (id >= 0) {                            \
>> +        if (test_bit(id, ud->res##_map)) {            \
>> +            dev_err(ud->dev, "res##%d is in use\n", id);    \
>> +            return ERR_PTR(-ENOENT);            \
>> +        }                            \
>> +    } else {                            \
>> +        int start;                        \
>> +                                    \
>> +        if (tpl >= ud->match_data->tpl_levels)            \
>> +            tpl = ud->match_data->tpl_levels - 1;        \
>> +                                    \
>> +        start = ud->match_data->level_start_idx[tpl];        \
>> +                                    \
>> +        id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,    \
>> +                    start);                \
>> +        if (id == ud->res##_cnt) {                \
>> +            return ERR_PTR(-ENOENT);            \
>> +        }                            \
>> +    }                                \
>> +                                    \
>> +    set_bit(id, ud->res##_map);                    \
>> +    return &ud->res##s[id];                        \
>> +}
>> +
>> +UDMA_RESERVE_RESOURCE(tchan);
>> +UDMA_RESERVE_RESOURCE(rchan);
> 
> Personally I'm not a fan of such a big macro, wouldn't be static
> functions better.

The other option is to have two identical function with only difference
is s/tchan/rchan.

> 
>> +
>> +static int udma_get_tchan(struct udma_chan *uc)
>> +{
>> +    struct udma_dev *ud = uc->ud;
>> +
>> +    if (uc->tchan) {
>> +        dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
>> +            uc->id, uc->tchan->id);
>> +        return 0;
>> +    }
>> +
>> +    uc->tchan = __udma_reserve_tchan(ud, uc->channel_tpl, -1);
>> +    if (IS_ERR(uc->tchan))
>> +        return PTR_ERR(uc->tchan);
>> +
>> +    return 0;
>> +}
>> +
> 
> [...]
> 
>> +
>> +static int udma_tisci_channel_config(struct udma_chan *uc)
>> +{
>> +    struct udma_dev *ud = uc->ud;
>> +    struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
>> +    const struct ti_sci_rm_udmap_ops *tisci_ops =
>> tisci_rm->tisci_udmap_ops;
>> +    struct udma_tchan *tchan = uc->tchan;
>> +    struct udma_rchan *rchan = uc->rchan;
>> +    int ret = 0;
>> +
>> +    if (uc->dir == DMA_MEM_TO_MEM) {
>> +        /* Non synchronized - mem to mem type of transfer */
>> +        int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
>> +        struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
>> +        struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
>> +
>> +        req_tx.valid_params =
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID;
>> +
>> +        req_tx.nav_id = tisci_rm->tisci_dev_id;
>> +        req_tx.index = tchan->id;
>> +        req_tx.tx_pause_on_err = 0;
>> +        req_tx.tx_filt_einfo = 0;
>> +        req_tx.tx_filt_pswords = 0;
>> +        req_tx.tx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
>> +        req_tx.tx_supr_tdpkt = 0;
>> +        req_tx.tx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
>> +        req_tx.txcq_qnum = tc_ring;
>> +
>> +        ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
>> +        if (ret) {
>> +            dev_err(ud->dev, "tchan%d cfg failed %d\n",
>> +                tchan->id, ret);
>> +            return ret;
>> +        }
>> +
>> +        req_rx.valid_params =
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID;
>> +
>> +        req_rx.nav_id = tisci_rm->tisci_dev_id;
>> +        req_rx.index = rchan->id;
>> +        req_rx.rx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
>> +        req_rx.rxcq_qnum = tc_ring;
>> +        req_rx.rx_pause_on_err = 0;
>> +        req_rx.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
>> +        req_rx.rx_ignore_short = 0;
>> +        req_rx.rx_ignore_long = 0;
>> +
>> +        ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
>> +        if (ret) {
>> +            dev_err(ud->dev, "rchan%d alloc failed %d\n",
>> +                rchan->id, ret);
>> +            return ret;
>> +        }
>> +    } else {
>> +        /* Slave transfer */
>> +        u32 mode, fetch_size;
>> +
>> +        if (uc->pkt_mode) {
>> +            mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
>> +            fetch_size = cppi5_hdesc_calc_size(uc->needs_epib,
>> +                               uc->psd_size, 0);
>> +        } else {
>> +            mode = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_PBRR;
>> +            fetch_size = sizeof(struct cppi5_desc_hdr_t);
>> +        }
>> +
>> +        if (uc->dir == DMA_MEM_TO_DEV) {
>> +            /* TX */
>> +            int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
>> +            struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
>> +
>> +            req_tx.valid_params =
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID;
>> +
>> +            req_tx.nav_id = tisci_rm->tisci_dev_id;
>> +            req_tx.index = tchan->id;
>> +            req_tx.tx_pause_on_err = 0;
>> +            req_tx.tx_filt_einfo = 0;
>> +            req_tx.tx_filt_pswords = 0;
>> +            req_tx.tx_chan_type = mode;
>> +            req_tx.tx_supr_tdpkt = 0;
>> +            req_tx.tx_fetch_size = fetch_size >> 2;
>> +            req_tx.txcq_qnum = tc_ring;
>> +
>> +            ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
>> +            if (ret) {
>> +                dev_err(ud->dev, "tchan%d cfg failed %d\n",
>> +                    tchan->id, ret);
>> +                return ret;
>> +            }
>> +        } else {
>> +            /* RX */
>> +            int fd_ring = k3_ringacc_get_ring_id(rchan->fd_ring);
>> +            int rx_ring = k3_ringacc_get_ring_id(rchan->r_ring);
>> +            struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
>> +            struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
>> +
>> +            req_rx.valid_params =
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID;
>> +
>> +            req_rx.nav_id = tisci_rm->tisci_dev_id;
>> +            req_rx.index = rchan->id;
>> +            req_rx.rx_fetch_size =  fetch_size >> 2;
>> +            req_rx.rxcq_qnum = rx_ring;
>> +            req_rx.rx_pause_on_err = 0;
>> +            req_rx.rx_chan_type = mode;
>> +            req_rx.rx_ignore_short = 0;
>> +            req_rx.rx_ignore_long = 0;
>> +
>> +            ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
>> +            if (ret) {
>> +                dev_err(ud->dev, "rchan%d cfg failed %d\n",
>> +                    rchan->id, ret);
>> +                return ret;
>> +            }
>> +
>> +            flow_req.valid_params =
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_EINFO_PRESENT_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_PSINFO_PRESENT_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_ERROR_HANDLING_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DESC_TYPE_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_QNUM_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_HI_SEL_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_SRC_TAG_LO_SEL_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_HI_SEL_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_TAG_LO_SEL_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ0_SZ0_QNUM_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ1_QNUM_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ2_QNUM_VALID |
>> +            TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_FDQ3_QNUM_VALID;
>> +
>> +            flow_req.nav_id = tisci_rm->tisci_dev_id;
>> +            flow_req.flow_index = rchan->id;
>> +
>> +            if (uc->needs_epib)
>> +                flow_req.rx_einfo_present = 1;
>> +            else
>> +                flow_req.rx_einfo_present = 0;
>> +            if (uc->psd_size)
>> +                flow_req.rx_psinfo_present = 1;
>> +            else
>> +                flow_req.rx_psinfo_present = 0;
>> +            flow_req.rx_error_handling = 1;
>> +            flow_req.rx_desc_type = 0;
>> +            flow_req.rx_dest_qnum = rx_ring;
>> +            flow_req.rx_src_tag_hi_sel = 2;
>> +            flow_req.rx_src_tag_lo_sel = 4;
>> +            flow_req.rx_dest_tag_hi_sel = 5;
>> +            flow_req.rx_dest_tag_lo_sel = 4;
>> +            flow_req.rx_fdq0_sz0_qnum = fd_ring;
>> +            flow_req.rx_fdq1_qnum = fd_ring;
>> +            flow_req.rx_fdq2_qnum = fd_ring;
>> +            flow_req.rx_fdq3_qnum = fd_ring;
>> +
>> +            ret = tisci_ops->rx_flow_cfg(tisci_rm->tisci,
>> +                             &flow_req);
>> +
>> +            if (ret) {
>> +                dev_err(ud->dev, "flow%d config failed: %d\n",
>> +                    rchan->id, ret);
>> +                return ret;
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
> 
> Could you split above big function pls?

I can slit to:
udma_tisci_m2m_channel_config()
udma_tisci_tx_channel_config()
udma_tisci_rx_channel_config()

and call them from the first switch case in udma_alloc_chan_resources()

> 
>> +
>> +static int udma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +    struct udma_chan *uc = to_udma_chan(chan);
>> +    struct udma_dev *ud = to_udma_dev(chan->device);
>> +    const struct udma_match_data *match_data = ud->match_data;
>> +    struct k3_ring *irq_ring;
>> +    u32 irq_udma_idx;
>> +    int ret;
>> +
>> +    if (uc->pkt_mode || uc->dir == DMA_MEM_TO_MEM) {
>> +        uc->use_dma_pool = true;
>> +        /* in case of MEM_TO_MEM we have maximum of two TRs */
>> +        if (uc->dir == DMA_MEM_TO_MEM) {
>> +            uc->hdesc_size = cppi5_trdesc_calc_size(
>> +                    sizeof(struct cppi5_tr_type15_t), 2);
>> +            uc->pkt_mode = false;
>> +        }
>> +    }
>> +
>> +    if (uc->use_dma_pool) {
>> +        uc->hdesc_pool = dma_pool_create(uc->name, ud->ddev.dev,
>> +                         uc->hdesc_size, ud->desc_align,
>> +                         0);
>> +        if (!uc->hdesc_pool) {
>> +            dev_err(ud->ddev.dev,
>> +                "Descriptor pool allocation failed\n");
>> +            uc->use_dma_pool = false;
>> +            return -ENOMEM;
>> +        }
>> +    }
>> +
>> +    pm_runtime_get_sync(ud->ddev.dev);
>> +
>> +    /*
>> +     * Make sure that the completion is in a known state:
>> +     * No teardown, the channel is idle
>> +     */
>> +    reinit_completion(&uc->teardown_completed);
>> +    complete_all(&uc->teardown_completed);
>> +    uc->state = UDMA_CHAN_IS_IDLE;
>> +
>> +    switch (uc->dir) {
>> +    case DMA_MEM_TO_MEM:
>> +        /* Non synchronized - mem to mem type of transfer */
>> +        dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-MEM\n", __func__,
>> +            uc->id);
>> +
>> +        ret = udma_get_chan_pair(uc);
>> +        if (ret)
>> +            return ret;
>> +
>> +        ret = udma_alloc_tx_resources(uc);
>> +        if (ret)
>> +            return ret;
>> +
>> +        ret = udma_alloc_rx_resources(uc);
>> +        if (ret) {
>> +            udma_free_tx_resources(uc);
>> +            return ret;
>> +        }
>> +
>> +        uc->src_thread = ud->psil_base + uc->tchan->id;
>> +        uc->dst_thread = (ud->psil_base + uc->rchan->id) |
>> +                 UDMA_PSIL_DST_THREAD_ID_OFFSET;
>> +
>> +        irq_ring = uc->tchan->tc_ring;
>> +        irq_udma_idx = uc->tchan->id;
>> +        break;
>> +    case DMA_MEM_TO_DEV:
>> +        /* Slave transfer synchronized - mem to dev (TX) trasnfer */
>> +        dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-DEV\n", __func__,
>> +            uc->id);
>> +
>> +        ret = udma_alloc_tx_resources(uc);
>> +        if (ret) {
>> +            uc->remote_thread_id = -1;
>> +            return ret;
>> +        }
>> +
>> +        uc->src_thread = ud->psil_base + uc->tchan->id;
>> +        uc->dst_thread = uc->remote_thread_id;
>> +        uc->dst_thread |= UDMA_PSIL_DST_THREAD_ID_OFFSET;
>> +
>> +        irq_ring = uc->tchan->tc_ring;
>> +        irq_udma_idx = uc->tchan->id;
>> +        break;
>> +    case DMA_DEV_TO_MEM:
>> +        /* Slave transfer synchronized - dev to mem (RX) trasnfer */
>> +        dev_dbg(uc->ud->dev, "%s: chan%d as DEV-to-MEM\n", __func__,
>> +            uc->id);
>> +
>> +        ret = udma_alloc_rx_resources(uc);
>> +        if (ret) {
>> +            uc->remote_thread_id = -1;
>> +            return ret;
>> +        }
>> +
>> +        uc->src_thread = uc->remote_thread_id;
>> +        uc->dst_thread = (ud->psil_base + uc->rchan->id) |
>> +                 UDMA_PSIL_DST_THREAD_ID_OFFSET;
>> +
>> +        irq_ring = uc->rchan->r_ring;
>> +        irq_udma_idx = match_data->rchan_oes_offset + uc->rchan->id;
>> +        break;
>> +    default:
>> +        /* Can not happen */
>> +        dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
>> +            __func__, uc->id, uc->dir);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Configure channel(s), rflow via tisci */
>> +    ret = udma_tisci_channel_config(uc);
>> +    if (ret)
>> +        goto err_res_free;
>> +
>> +    if (udma_is_chan_running(uc)) {
>> +        dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
>> +        udma_stop(uc);
>> +        if (udma_is_chan_running(uc)) {
>> +            dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
>> +            goto err_res_free;
>> +        }
>> +    }
>> +
>> +    /* PSI-L pairing */
>> +    ret = navss_psil_pair(ud, uc->src_thread, uc->dst_thread);
>> +    if (ret) {
>> +        dev_err(ud->dev, "PSI-L pairing failed: 0x%04x -> 0x%04x\n",
>> +            uc->src_thread, uc->dst_thread);
>> +        goto err_res_free;
>> +    }
>> +
>> +    uc->psil_paired = true;
>> +
>> +    uc->irq_num_ring = k3_ringacc_get_ring_irq_num(irq_ring);
>> +    if (uc->irq_num_ring <= 0) {
>> +        dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
>> +            k3_ringacc_get_ring_id(irq_ring));
>> +        ret = -EINVAL;
>> +        goto err_psi_free;
>> +    }
>> +
>> +    ret = request_irq(uc->irq_num_ring, udma_ring_irq_handler,
>> +              IRQF_TRIGGER_HIGH, uc->name, uc);
>> +    if (ret) {
>> +        dev_err(ud->dev, "chan%d: ring irq request failed\n", uc->id);
>> +        goto err_irq_free;
>> +    }
>> +
>> +    /* Event from UDMA (TR events) only needed for slave TR mode
>> channels */
>> +    if (is_slave_direction(uc->dir) && !uc->pkt_mode) {
>> +        uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
>> +                                irq_udma_idx);
>> +        if (uc->irq_num_udma <= 0) {
>> +            dev_err(ud->dev, "Failed to get udma irq (index: %u)\n",
>> +                irq_udma_idx);
>> +            free_irq(uc->irq_num_ring, uc);
>> +            ret = -EINVAL;
>> +            goto err_irq_free;
>> +        }
>> +
>> +        ret = request_irq(uc->irq_num_udma, udma_udma_irq_handler, 0,
>> +                  uc->name, uc);
>> +        if (ret) {
>> +            dev_err(ud->dev, "chan%d: UDMA irq request failed\n",
>> +                uc->id);
>> +            free_irq(uc->irq_num_ring, uc);
>> +            goto err_irq_free;
>> +        }
>> +    } else {
>> +        uc->irq_num_udma = 0;
>> +    }
>> +
>> +    udma_reset_rings(uc);
>> +
>> +    return 0;
>> +
>> +err_irq_free:
>> +    uc->irq_num_ring = 0;
>> +    uc->irq_num_udma = 0;
>> +err_psi_free:
>> +    navss_psil_unpair(ud, uc->src_thread, uc->dst_thread);
>> +    uc->psil_paired = false;
>> +err_res_free:
>> +    udma_free_tx_resources(uc);
>> +    udma_free_rx_resources(uc);
>> +
>> +    uc->remote_thread_id = -1;
>> +    uc->dir = DMA_MEM_TO_MEM;
>> +    uc->pkt_mode = false;
>> +    uc->static_tr_type = 0;
>> +    uc->enable_acc32 = 0;
>> +    uc->enable_burst = 0;
>> +    uc->channel_tpl = 0;
>> +    uc->psd_size = 0;
>> +    uc->metadata_size = 0;
>> +    uc->hdesc_size = 0;
>> +
>> +    if (uc->use_dma_pool) {
>> +        dma_pool_destroy(uc->hdesc_pool);
>> +        uc->use_dma_pool = false;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
> 
> [...]
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
