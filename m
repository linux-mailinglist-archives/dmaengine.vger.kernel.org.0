Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB312921D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 08:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfLWHLS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 02:11:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40650 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLWHLR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 02:11:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBN7B4Cf088308;
        Mon, 23 Dec 2019 01:11:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577085064;
        bh=02Y5bx6iWO9Ds4+8bjzc1aI2WrawgyCHLyU/VpC8TA4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=lftrXC8/DpJwn4Aso0DNv9JYSikjp4xa+4lEDZ8K4mMS3sGTr4XSiQvYnp4pLYSuH
         emlLOLHPhfy9CXMN3gbQHLrlYWlz0dKcfUx2YOIpr0ipSzjmm7F6/lJoztW2mLuZba
         7J0/QvgAdr1EpLS7GrofRWhCtadHOEZFbvjK/uV8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBN7B4JB086044
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 01:11:04 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 01:11:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 01:11:02 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBN7AxHw061310;
        Mon, 23 Dec 2019 01:10:59 -0600
Subject: Re: [PATCH v7 06/12] dmaengine: ti: Add cppi5 header for K3
 NAVSS/UDMA
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-7-peter.ujfalusi@ti.com>
 <20191220095455.GM2536@vkoul-mobl>
 <d5bd6bcf-9c1e-8633-fdc4-ee787100b44c@ti.com>
Message-ID: <dc251d90-2e1f-ae3e-2a29-4191e8eefb7a@ti.com>
Date:   Mon, 23 Dec 2019 09:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d5bd6bcf-9c1e-8633-fdc4-ee787100b44c@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 20/12/2019 12.42, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 20/12/2019 11.54, Vinod Koul wrote:
>> On 09-12-19, 11:43, Peter Ujfalusi wrote:
>>
>>> +#define CPPI5_INFO2_DESC_RETPUSHPOLICY		BIT(16)
>>> +#define CPPI5_INFO2_DESC_RETP_MASK		GENMASK(18, 16)
>>> +
>>> +#define CPPI5_INFO2_DESC_RETQ_SHIFT		(0)
>>> +#define CPPI5_INFO2_DESC_RETQ_MASK		GENMASK(15, 0)
>>> +
>>> +#define CPPI5_INFO3_DESC_SRCTAG_SHIFT		(16U)
>>> +#define CPPI5_INFO3_DESC_SRCTAG_MASK		GENMASK(31, 16)
>>> +#define CPPI5_INFO3_DESC_DSTTAG_SHIFT		(0)
>>> +#define CPPI5_INFO3_DESC_DSTTAG_MASK		GENMASK(15, 0)
>>> +
>>> +#define CPPI5_BUFINFO1_HDESC_DATA_LEN_SHIFT	(0)
>>> +#define CPPI5_BUFINFO1_HDESC_DATA_LEN_MASK	GENMASK(27, 0)
>>> +
>>> +#define CPPI5_OBUFINFO0_HDESC_BUF_LEN_SHIFT	(0)
>>> +#define CPPI5_OBUFINFO0_HDESC_BUF_LEN_MASK	GENMASK(27, 0)
>>
>> I think you can remove the SHIFT defines and use ffs() to get the bit
>> position for shift
> 
> Right. I'll convert to use ffs()

I rather keep the defines.
While ffs() is simple, it is going to have effect in speeds gigabit or
beyond.

>>> +static inline u32 cppi5_hdesc_calc_size(bool epib, u32 psdata_size,
>>> +					u32 sw_data_size)
>>> +{
>>> +	u32 desc_size;
>>> +
>>> +	if (psdata_size > CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE)
>>> +		return 0;
>>> +
>>> +	desc_size = sizeof(struct cppi5_host_desc_t) + psdata_size +
>>> +		    sw_data_size;
>>
>> I think there was an API for this kind of mem allocation of struct and
>> buffer attached...
> 
> The returned size is not only used when allocating memory or setting up
> the dma_pool, but for UDMAP's fetch size parameter.
> 
>>> +static inline void cppi5_hdesc_reset_hbdesc(struct cppi5_host_desc_t *desc)
>>> +{
>>> +	desc->hdr = (struct cppi5_desc_hdr_t) { 0 };
>>> +	desc->next_desc = 0;
>>
>> would this not be superfluous? Or if you want a memset call?
> 
> The intention is to reset the header and the next descriptor link but
> leave the backing buffer information intact. This allows the reuse of a
> descriptor+buffer and we only need to set the header bits + next
> descriptor pointer if any.
> 
>>> +static inline u32 *cppi5_hdesc_get_psdata32(struct cppi5_host_desc_t *desc)
>>> +{
>>> +	return (u32 *)cppi5_hdesc_get_psdata(desc);
>>
>> you dont need casts away from void *
> 
> Hrm, or just remove this, clients can use the cppi5_hdesc_get_psdata()
> directly.
> 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
