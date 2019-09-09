Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14341AD76B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbfIIK7o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 06:59:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37036 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390539AbfIIK7o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 06:59:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x89AxSho114599;
        Mon, 9 Sep 2019 05:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568026768;
        bh=KVTZeU9q6U/tm8mHmG6WMtzijKTyoPy7zWy+jYJUN0w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z0kR636WsH3wXes0J12PD38D5hFweyoCxpR+fcSAcWqcaqyeR8AjIXhnnBvTZO8J4
         yPyACWq001MyvsAYus3peKtwX6dQLmuEyzcfdcba/FuVxuwdMwElfDMGTVDMEkAvQH
         /nfb7SUhIcjDJf//GEdyLAhd0tGpVvmHLFG6OG1s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x89AxSEJ104990;
        Mon, 9 Sep 2019 05:59:28 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 9 Sep
 2019 05:59:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 9 Sep 2019 05:59:25 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x89AxMHW108974;
        Mon, 9 Sep 2019 05:59:23 -0500
Subject: Re: [PATCH v2 06/14] dmaengine: ti: Add cppi5 header for UDMA
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-7-peter.ujfalusi@ti.com>
 <20190908142528.GP2672@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8699f999-7834-a083-2c7b-3ea909b1e011@ti.com>
Date:   Mon, 9 Sep 2019 13:59:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908142528.GP2672@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/09/2019 17.25, Vinod Koul wrote:
> On 30-07-19, 12:34, Peter Ujfalusi wrote:
> 
>> +/**
>> + * Descriptor header, present in all types of descriptors
>> + */
>> +struct cppi5_desc_hdr_t {
>> +	u32 pkt_info0;	/* Packet info word 0 (n/a in Buffer desc) */
>> +	u32 pkt_info1;	/* Packet info word 1 (n/a in Buffer desc) */
>> +	u32 pkt_info2;	/* Packet info word 2 Buffer reclamation info */
>> +	u32 src_dst_tag; /* Packet info word 3 (n/a in Buffer desc) */
> 
> Can we move these comments to kernel-doc style please

Sure, I'll move all struct and enums.

>> +/**
>> + * cppi5_desc_get_type - get descriptor type
>> + * @desc_hdr: packet descriptor/TR header
>> + *
>> + * Returns descriptor type:
>> + * CPPI5_INFO0_DESC_TYPE_VAL_HOST
>> + * CPPI5_INFO0_DESC_TYPE_VAL_MONO
>> + * CPPI5_INFO0_DESC_TYPE_VAL_TR
>> + */
>> +static inline u32 cppi5_desc_get_type(struct cppi5_desc_hdr_t *desc_hdr)
>> +{
>> +	WARN_ON(!desc_hdr);
> 
> why WARN_ON and not return error!

these helpers were intended to be as simple as possible.
I can go through with all of the WARN_ONs and replace them with if()
pr_warn() and either just return or return with 0.

Would that be acceptable?

>> +/**
>> + * cppi5_hdesc_calc_size - Calculate Host Packet Descriptor size
>> + * @epib: is EPIB present
>> + * @psdata_size: PSDATA size
>> + * @sw_data_size: SWDATA size
>> + *
>> + * Returns required Host Packet Descriptor size
>> + * 0 - if PSDATA > CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE
>> + */
>> +static inline u32 cppi5_hdesc_calc_size(bool epib, u32 psdata_size,
>> +					u32 sw_data_size)
>> +{
>> +	u32 desc_size;
>> +
>> +	if (psdata_size > CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE)
>> +		return 0;
>> +	//TODO_GS: align
> 
> :)

Leftover TODO from Grygorii, the align is already done.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
