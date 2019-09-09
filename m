Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28639AD341
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 08:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfIIGwW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 02:52:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35744 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfIIGwW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 02:52:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x896qB1N051914;
        Mon, 9 Sep 2019 01:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568011931;
        bh=zG7j/FKdnKJGi5S4/+DCXgAmeaLRvacq3SV1zBDjDK8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WKgZcs86xvkImDeZTlWxI+8ij8tctOXjcls20eW2N/bICrWbMQ8eXxRNUA6WGaDpd
         UzRXpMUYomZH4/+IIuvhgioZDGynFptCHw5uKdFxLnliospaaChQs+WX8DzUHc2q5S
         5StTng57b+ELtdUOKiZ9lnxXUmb9eldTeMb3K9Ww=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x896qARe005981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Sep 2019 01:52:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 9 Sep
 2019 01:52:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 9 Sep 2019 01:52:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x896q69W031378;
        Mon, 9 Sep 2019 01:52:07 -0500
Subject: Re: [PATCH v2 04/14] dmaengine: Add metadata_ops for
 dma_async_tx_descriptor
To:     Vinod Koul <vkoul@kernel.org>,
        Radhey Shyam Pandey <radheys@xilinx.com>
CC:     <robh+dt@kernel.org>, "Menon, Nishanth" <nm@ti.com>,
        <ssantosh@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-5-peter.ujfalusi@ti.com>
 <20190908141207.GO2672@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0ccf3880-935f-be54-0f62-e57762141af1@ti.com>
Date:   Mon, 9 Sep 2019 09:52:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908141207.GO2672@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/09/2019 17.12, Vinod Koul wrote:
> On 30-07-19, 12:34, Peter Ujfalusi wrote:
>> The metadata is best described as side band data or parameters traveling
>> alongside the data DMAd by the DMA engine. It is data
>> which is understood by the peripheral and the peripheral driver only, the
>> DMA engine see it only as data block and it is not interpreting it in any
>> way.
>>
>> The metadata can be different per descriptor as it is a parameter for the
>> data being transferred.
>>
>> If the DMA supports per descriptor metadata it can implement the attach,
>> get_ptr/set_len callbacks.
>>
>> Client drivers must only use either attach or get_ptr/set_len to avoid
>> misconfiguration.
>>
>> Client driver can check if a given metadata mode is supported by the
>> channel during probe time with
>> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_CLIENT);
>> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_ENGINE);
>>
>> and based on this information can use either mode.
>>
>> Wrappers are also added for the metadata_ops.
>>
>> To be used in DESC_METADATA_CLIENT mode:
>> dmaengine_desc_attach_metadata()
>>
>> To be used in DESC_METADATA_ENGINE mode:
>> dmaengine_desc_get_metadata_ptr()
>> dmaengine_desc_set_metadata_len()
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/dmaengine.c   |  73 ++++++++++++++++++++++++++
>>  include/linux/dmaengine.h | 108 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 181 insertions(+)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index 03ac4b96117c..6baddf7dcbfd 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -1302,6 +1302,79 @@ void dma_async_tx_descriptor_init(struct dma_async_tx_descriptor *tx,
>>  }
>>  EXPORT_SYMBOL(dma_async_tx_descriptor_init);
>>  
>> +static inline int desc_check_and_set_metadata_mode(
>> +	struct dma_async_tx_descriptor *desc, enum dma_desc_metadata_mode mode)
>> +{
>> +	/* Make sure that the metadata mode is not mixed */
>> +	if (!desc->desc_metadata_mode) {
>> +		if (dmaengine_is_metadata_mode_supported(desc->chan, mode))
>> +			desc->desc_metadata_mode = mode;
> 
> So do we have different descriptors supporting different modes or is it
> controlled based? For latter we can do this check at controller
> registration!

It is actually on channel basis (in UDMAP):
TR channel does not support metadata at all.
Packet Mode channel have support for metadata, but it might not be
available for certain remote peripherals. PDMAs for example does not use
metadata.
Any channel can be configured as TR or Packet Mode, any channel can
service a peripheral which needs or does not need metadata.

The reason we ended up per descriptor callbacks with Radhey (added to
CC) is that all functions operate on the descriptor and it was natural
to have them attached to the descriptor rather than add channel based
callbacks which must also take the descriptor pointer in addition. The
descriptor have pointer to the channel it is issued on.

I only know if metadata is going to be supported when the channel is
requested, based on the psil-config of the remote thread.

Clients still can check and plan ahead on how to use the metadata.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
