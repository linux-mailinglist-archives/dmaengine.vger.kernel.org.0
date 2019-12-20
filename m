Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408991278F8
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 11:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLTKNW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 05:13:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33478 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfLTKNV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 05:13:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKADDQe056920;
        Fri, 20 Dec 2019 04:13:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576836793;
        bh=9DmEO+OYxJgAdf+riV2ejuQ1fMZXsgBMxnnPcmuwnhE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=whFIJrJD4FprTZAOiJ8wEeSEisPM8Fr46QZ4DUg2HBS0RzHmsZClqBvWZG7dtqXXX
         jBMa+TkyD+euyhiIO3PtCHaVpBXU2f2wIAOuIYSQHgMCRnWeO20FdKHDL2SMCMSLz4
         WAcpB+HHQOqrcVsItNufA43SY3GMKqEpJPdlA8mk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBKADCSi014986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 04:13:12 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 04:13:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 04:13:05 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKAD1TA072417;
        Fri, 20 Dec 2019 04:13:02 -0600
Subject: Re: [PATCH v7 05/12] dmaengine: Add support for reporting DMA cached
 data amount
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-6-peter.ujfalusi@ti.com>
 <20191220083713.GL2536@vkoul-mobl>
 <f28301f7-4624-b4f8-d781-7ebfa4ae7856@ti.com>
 <20191220095755.GN2536@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ea912bfb-a315-a230-85e9-9c9110b3f0d7@ti.com>
Date:   Fri, 20 Dec 2019 12:13:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220095755.GN2536@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 20/12/2019 11.57, Vinod Koul wrote:
> On 20-12-19, 10:49, Peter Ujfalusi wrote:
> 
>>>> +static inline void dma_set_in_flight_bytes(struct dma_tx_state *state,
>>>> +					   u32 in_flight_bytes)
>>>> +{
>>>> +	if (state)
>>>> +		state->in_flight_bytes = in_flight_bytes;
>>>> +}
>>>
>>> This would be used by dmaengine drivers right, so lets move it to drivers/dma/dmaengine.h
>>>
>>> lets not expose this to users :)
>>
>> I have put it where the dma_set_residue() was.
>> I can add a patch first to move dma_set_residue() then add
> 
> not sure I follow, but dma_set_residue() in already in drivers/dma/dmaengine.h

and this patch adds the dma_set_in_flight_bytes() to
drivers/dma/dmaengine.h

in include/linux/dmaengine.h the dma_tx_state struct is updated only.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
