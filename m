Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC60C2F4565
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 08:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAMHjF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 02:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbhAMHjD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jan 2021 02:39:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0CC061575;
        Tue, 12 Jan 2021 23:38:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a12so1330477lfl.6;
        Tue, 12 Jan 2021 23:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M2N/Z0+D0Z/nN3iaZwlEky/BcBwBwPLBvbnhdo2uPxs=;
        b=LFRWJCuELJUrDZnPH0lwnNC3gUN9x35pulfcEGroRiLH/jZ39p89IR5pFVCx67/Rwh
         7M2NUaoUWA7g9N4WR7/hyPcItKUDTGtiWNswNZulZBPRJzgxlW7rqjd9BNYLU3Cf81v7
         xhYx33M/9JTPFxhpzOvdWdKVi7jbu927Ub4OJGliE6wclihuWdcP7BYqIvBNxlwXNspX
         kyCDyYxxd/68fev7lC4lyFIHrwywYSo+JkXJOgBa6Bf2AMZhE8p8rRH3hlwcPXO4h9Wo
         xlhXDXAFcAbN4PdoyKKHiNisSSbx05wY9JXp+eiyPu9fG72CML0WoCP9KGyndSyutaDf
         Iymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M2N/Z0+D0Z/nN3iaZwlEky/BcBwBwPLBvbnhdo2uPxs=;
        b=EQ1g5/3Hm23pcjnw45/By4SAGdDYIOsmFxNu1TJ8E30uzM8sRUlqcpjcELEQGfpIU8
         Kj1XqHsUdOKz4S7jMZGhN+/YDVIiHKConUnpvZzxgE35nlmSbvKZEGFKgtUPgTKDflqZ
         R9S6cuLFZ4ruS25pJHvo/kliOI7Bu7sO+OjS51qNczxFwHVWVdwhLsfSl2rTfoPuuFuE
         2iKTRdAh9aJ1pZ0c4gqTin1LR1zTj47IgttlijlLK+jrJsEy+n9Jth3VpvP6HlB+MJZf
         iPWrR5CvVUfQ+Zo+At5KWkOh9hhuAZaA3gGM2Deak/A+cC8r3mYlXORRBFGHnBEbSRPG
         HNRA==
X-Gm-Message-State: AOAM53393q1e0rDEDFvbsjJo+WfycNMJsb9nQFyn6u8zI7AkMRwmCaOd
        TvDeEYtOHdbfXqG7ZijHVbc=
X-Google-Smtp-Source: ABdhPJyEMAYxO2vaMwJ2n1KJOg0uNQa5PlXQklk6QWpMeKFhrJSfgXA8tiLM5L47c5G1S+dG1s/rQQ==
X-Received: by 2002:a05:6512:21d:: with SMTP id a29mr314970lfo.444.1610523501274;
        Tue, 12 Jan 2021 23:38:21 -0800 (PST)
Received: from [10.0.0.113] (91-157-87-152.elisa-laajakaista.fi. [91.157.87.152])
        by smtp.gmail.com with ESMTPSA id c10sm95106lji.103.2021.01.12.23.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 23:38:20 -0800 (PST)
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
References: <20201214081310.10746-1-peter.ujfalusi@ti.com>
 <20201214081310.10746-3-peter.ujfalusi@ti.com>
 <20210112101637.GJ2771@vkoul-mobl>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: ti: k3-udma: Add support for burst_size
 configuration for mem2mem
Message-ID: <76cabf10-7747-73ee-1c42-8d5a7eb85b6c@gmail.com>
Date:   Wed, 13 Jan 2021 09:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112101637.GJ2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 1/12/21 12:16 PM, Vinod Koul wrote:
> On 14-12-20, 10:13, Peter Ujfalusi wrote:
>> The UDMA and BCDMA can provide higher throughput if the burst_size of the
>> channel is changed from it's default (which is 64 bytes) for Ultra-high
>> and high capacity channels.
>>
>> This performance benefit is even more visible when the buffers are aligned
>> with the burst_size configuration.
>>
>> The am654 does not have a way to change the burst size, but it is using
>> 64 bytes burst, so increasing the copy_align from 8 bytes to 64 (and
>> clients taking that into account) can increase the throughput as well.
>>
>> Numbers gathered on j721e:
>> echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
>> echo 2000 > /sys/module/dmatest/parameters/timeout
>> echo 50 > /sys/module/dmatest/parameters/iterations
>> echo 1 > /sys/module/dmatest/parameters/max_channels
>>
>> Prior this patch:       ~1.3 GB/s
>> After this patch:       ~1.8 GB/s
>>  with 1 byte alignment: ~1.7 GB/s
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 115 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 110 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 87157cbae1b8..54e4ccb1b37e 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -121,6 +121,11 @@ struct udma_oes_offsets {
>>  #define UDMA_FLAG_PDMA_ACC32		BIT(0)
>>  #define UDMA_FLAG_PDMA_BURST		BIT(1)
>>  #define UDMA_FLAG_TDTYPE		BIT(2)
>> +#define UDMA_FLAG_BURST_SIZE		BIT(3)
>> +#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
>> +					 UDMA_FLAG_PDMA_BURST | \
>> +					 UDMA_FLAG_TDTYPE | \
>> +					 UDMA_FLAG_BURST_SIZE)
>>  
>>  struct udma_match_data {
>>  	enum k3_dma_type type;
>> @@ -128,6 +133,7 @@ struct udma_match_data {
>>  	bool enable_memcpy_support;
>>  	u32 flags;
>>  	u32 statictr_z_mask;
>> +	u8 burst_size[3];
>>  };
>>  
>>  struct udma_soc_data {
>> @@ -436,6 +442,18 @@ static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
>>  	}
>>  }
>>  
>> +static u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < tpl_map->levels; i++) {
>> +		if (chan_id >= tpl_map->start_idx[i])
>> +			return i;
>> +	}
> 
> Braces seem not required

True, they are not strictly needed but I prefer to have them when I have
any condition in the loop.

>> +
>> +	return 0;
>> +}
>> +
>>  static void udma_reset_uchan(struct udma_chan *uc)
>>  {
>>  	memset(&uc->config, 0, sizeof(uc->config));
>> @@ -1811,6 +1829,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
>>  	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
>>  	struct udma_tchan *tchan = uc->tchan;
>>  	struct udma_rchan *rchan = uc->rchan;
>> +	u8 burst_size = 0;
>>  	int ret = 0;
>>  
>>  	/* Non synchronized - mem to mem type of transfer */
>> @@ -1818,6 +1837,12 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
>>  	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
>>  	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
>>  
>> +	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
>> +		u8 tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, tchan->id);
> 
> Can we define variable at function start please

The 'tpl' is only used within this if branch, it looks a bit cleaner
imho, but if you insist, I can move the definition.

...

>> +static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
>> +{
>> +	const struct udma_match_data *match_data = ud->match_data;
>> +	u8 tpl;
>> +
>> +	if (!match_data->enable_memcpy_support)
>> +		return DMAENGINE_ALIGN_8_BYTES;
>> +
>> +	/* Get the highest TPL level the device supports for memcpy */
>> +	if (ud->bchan_cnt) {
>> +		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
>> +	} else if (ud->tchan_cnt) {
>> +		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
>> +	} else {
>> +		return DMAENGINE_ALIGN_8_BYTES;
>> +	}
> 
> Braces seem not required

Very true.

> 
>> +
>> +	switch (match_data->burst_size[tpl]) {
>> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
>> +			return DMAENGINE_ALIGN_256_BYTES;
>> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
>> +			return DMAENGINE_ALIGN_128_BYTES;
>> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
>> +		fallthrough;
>> +		default:
>> +			return DMAENGINE_ALIGN_64_BYTES;
> 
> ah, we are supposed to have case at same indent as switch, pls run
> checkpatch to have these flagged off

Yes, they should be.

The other me did a sloppy job for sure, this should have been screaming
even without checkpatch...
This has been done in a rush during the last days to close on the
backlog item which got the most votes.

-- 
Péter
