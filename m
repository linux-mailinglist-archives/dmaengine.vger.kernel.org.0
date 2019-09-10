Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F5AE43F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfIJHHP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 03:07:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39466 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfIJHHP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 03:07:15 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8A773kY063473;
        Tue, 10 Sep 2019 02:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568099223;
        bh=qhrJHNazfc5CMwtBCfE9AmHbBpmQjdMCtB10M++D6ZI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aV5MsxeyOwzwuZre588rIVKEGGzYc0ka2baZHICXVKLIOPQ85G4qlEBnlMU9/6aq/
         QWLgTsFdP5pvBhU4DDK+fl1lFQb/bNpW77FzDyhCS66xccgugv/apXAeh1XkKaeRA6
         5L+806zvG7l2Kb7IKCSvyZDZbZTvjv6TKV9eZRD4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8A7735E059383
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Sep 2019 02:07:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 02:07:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 02:07:03 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8A76xLj100346;
        Tue, 10 Sep 2019 02:07:00 -0500
Subject: Re: [PATCH v2 06/14] dmaengine: ti: Add cppi5 header for UDMA
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-7-peter.ujfalusi@ti.com>
 <20190908142528.GP2672@vkoul-mobl>
 <8699f999-7834-a083-2c7b-3ea909b1e011@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <8486fbb1-9d2c-9230-6205-85d58b93697c@ti.com>
Date:   Tue, 10 Sep 2019 10:06:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8699f999-7834-a083-2c7b-3ea909b1e011@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 09/09/2019 13:59, Peter Ujfalusi wrote:
> 
> 
> On 08/09/2019 17.25, Vinod Koul wrote:
>> On 30-07-19, 12:34, Peter Ujfalusi wrote:
>>
>>> +/**
>>> + * Descriptor header, present in all types of descriptors
>>> + */
>>> +struct cppi5_desc_hdr_t {
>>> +	u32 pkt_info0;	/* Packet info word 0 (n/a in Buffer desc) */
>>> +	u32 pkt_info1;	/* Packet info word 1 (n/a in Buffer desc) */
>>> +	u32 pkt_info2;	/* Packet info word 2 Buffer reclamation info */
>>> +	u32 src_dst_tag; /* Packet info word 3 (n/a in Buffer desc) */
>>
>> Can we move these comments to kernel-doc style please
> 
> Sure, I'll move all struct and enums.
> 
>>> +/**
>>> + * cppi5_desc_get_type - get descriptor type
>>> + * @desc_hdr: packet descriptor/TR header
>>> + *
>>> + * Returns descriptor type:
>>> + * CPPI5_INFO0_DESC_TYPE_VAL_HOST
>>> + * CPPI5_INFO0_DESC_TYPE_VAL_MONO
>>> + * CPPI5_INFO0_DESC_TYPE_VAL_TR
>>> + */
>>> +static inline u32 cppi5_desc_get_type(struct cppi5_desc_hdr_t *desc_hdr)
>>> +{
>>> +	WARN_ON(!desc_hdr);
>>
>> why WARN_ON and not return error!
> 
> these helpers were intended to be as simple as possible.
> I can go through with all of the WARN_ONs and replace them with if()
> pr_warn() and either just return or return with 0.
> 
> Would that be acceptable?
> 

This should never happens in working system unless there is buggy code.
I think It can be just removed

-- 
Best regards,
grygorii
