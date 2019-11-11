Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB49F6FBC
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 09:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKKIcM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 03:32:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60434 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKIcM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 03:32:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB8W0vn038121;
        Mon, 11 Nov 2019 02:32:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573461121;
        bh=g5x94847hYbqbl6t0oMnSzfcp96v+AbsaJu0rr/L1DM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ouWb1i1Vkbcel87sd/4VG/dtoaWeTvVpUlhz7pvAjcp5wjMWPKV5hE+idcWjDSOQm
         bwYla2Xiga8gydxWAyB3T4aJh/brdqu1v91zXMY4MtZEZPmQS+n92P646Klikz5jOw
         V8jhnlV5tJstUqjqEj7ikSg15W1RB8p7UiYURNok=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAB8W0Dc076860
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 02:32:00 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 02:31:43 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 02:31:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB8VuS4099304;
        Mon, 11 Nov 2019 02:31:57 -0600
Subject: Re: [PATCH v4 09/15] dmaengine: ti: New driver for K3 UDMA - split#1:
 defines, structs, io func
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-10-peter.ujfalusi@ti.com>
 <20191111052828.GN952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <00777586-a3ac-2404-5226-e8c887936a32@ti.com>
Date:   Mon, 11 Nov 2019 10:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111052828.GN952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 7.28, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
> 
>> +struct udma_chan {
>> +	struct virt_dma_chan vc;
>> +	struct dma_slave_config	cfg;
>> +	struct udma_dev *ud;
>> +	struct udma_desc *desc;
>> +	struct udma_desc *terminated_desc;
> 
> descriptor and not a list?

Yes, not a list. I have only one transfer (if any) submitted to
hardware. This is mostly due to the packet mode RX operation: no
prelinked support in UDMAP so I need to have as many descriptors queued
up as the number of sg elements.

I need to keep the terminated descriptor around to be able to free it up
_after_ UDMAP returned it to avoid it modifying released memory.

>> +	struct udma_static_tr static_tr;
>> +	char *name;
>> +
>> +	struct udma_tchan *tchan;
>> +	struct udma_rchan *rchan;
>> +	struct udma_rflow *rflow;
>> +
>> +	bool psil_paired;
>> +
>> +	int irq_num_ring;
>> +	int irq_num_udma;
>> +
>> +	bool cyclic;
>> +	bool paused;
>> +
>> +	enum udma_chan_state state;
>> +	struct completion teardown_completed;
>> +
>> +	u32 bcnt; /* number of bytes completed since the start of the channel */
>> +	u32 in_ring_cnt; /* number of descriptors in flight */
>> +
>> +	bool pkt_mode; /* TR or packet */
>> +	bool needs_epib; /* EPIB is needed for the communication or not */
>> +	u32 psd_size; /* size of Protocol Specific Data */
>> +	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
>> +	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
>> +	bool notdpkt; /* Suppress sending TDC packet */
>> +	int remote_thread_id;
>> +	u32 src_thread;
>> +	u32 dst_thread;
>> +	enum psil_endpoint_type ep_type;
>> +	bool enable_acc32;
>> +	bool enable_burst;
>> +	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
>> +
>> +	/* dmapool for packet mode descriptors */
>> +	bool use_dma_pool;
>> +	struct dma_pool *hdesc_pool;
>> +
>> +	u32 id;
>> +	enum dma_transfer_direction dir;
> 
> why does channel have this, it already exists in descriptor

The channel can not change role, it is set when it was requested. In the
prep callbacks I do check if the direction matches with the channel's
direction.

>> +static irqreturn_t udma_udma_irq_handler(int irq, void *data)
>> +{
>> +	struct udma_chan *uc = data;
>> +
>> +	udma_tr_event_callback(uc);
> 
> any reason why we want to call a fn and not code here..?

No particular reason, I'll move them.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
