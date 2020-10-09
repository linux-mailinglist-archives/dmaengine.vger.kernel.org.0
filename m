Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C4288729
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 12:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgJIKpj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 06:45:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59706 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbgJIKpi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Oct 2020 06:45:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099AjZ05091973;
        Fri, 9 Oct 2020 05:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602240335;
        bh=hWdCeby0CJnBJr4PdNH/5tXM2WBfbU9pcWgtDZlYtRU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w1+KtB2wnABezR2N1ZNWZVN1ObIyw6HLz7NlkdaHhXednmphOvB+aLOF125WuSDI3
         V1rHH277ls1G9w0uDTpjaJozPQ4gftNmLzNkj3Cb0ttqmOasSS6KP4Z5E4APka2/J7
         LdryiySp0KQzL5FidVI6eaInzRrqHpplHaW4PrtA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099AjZn1015543
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 05:45:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 05:45:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 05:45:35 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099AjX3G103239;
        Fri, 9 Oct 2020 05:45:33 -0500
Subject: Re: [PATCH v4 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-3-vkoul@kernel.org>
 <e2c0323b-4f41-1926-5930-c63624fe1dd1@ti.com>
 <20201009103019.GD2968@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a44af464-7d13-1254-54dd-f7783ccfaa0f@ti.com>
Date:   Fri, 9 Oct 2020 13:45:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009103019.GD2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 09/10/2020 13.30, Vinod Koul wrote:
> Hi Peter,
> 
> On 09-10-20, 12:04, Peter Ujfalusi wrote:
>> On 08/10/2020 15.31, Vinod Koul wrote:
>>> Some complex dmaengine controllers have capability to program the
>>> peripheral device, so pass on the peripheral configuration as part of
>>> dma_slave_config
>>>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>> ---
>>>  include/linux/dmaengine.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>> index 6fbd5c99e30c..a15dc2960f6d 100644
>>> --- a/include/linux/dmaengine.h
>>> +++ b/include/linux/dmaengine.h
>>> @@ -418,6 +418,9 @@ enum dma_slave_buswidth {
>>>   * @slave_id: Slave requester id. Only valid for slave channels. The dma
>>>   * slave peripheral will have unique id as dma requester which need to be
>>>   * pass as slave config.
>>> + * @peripheral_config: peripheral configuration for programming peripheral
>>> + * for dmaengine transfer
>>> + * @peripheral_size: peripheral configuration buffer size
>>>   *
>>>   * This struct is passed in as configuration data to a DMA engine
>>>   * in order to set up a certain channel for DMA transport at runtime.
>>> @@ -443,6 +446,8 @@ struct dma_slave_config {
>>>  	u32 dst_port_window_size;
>>>  	bool device_fc;
>>>  	unsigned int slave_id;
>>> +	void *peripheral_config;
>>> +	size_t peripheral_size;
>>
>> Do you foresee a need of src/dst pair of these?
>> If we do DEV_TO_DEV with different type of peripherals it is going to
>> cause issues.
> 
> Not really as the channel already has direction and this is per channel.

Yes, in case of DEV_TO_MEM or MEM_TO_DEV.

> If for any any reason subsequent txn is for different direction, I would
> expect that parameters are set again before prep_ calls

But in DEV_TO_DEV?
If we have two peripherals, both needs config:
p1_config and p2_config

What and how would one use the single peripheral_config?

If only one of them needs config, then sure, the driver can pin-point
which one the single config might apply to.

Or you chain the same type of peripheral and you would need different
config for tx and rx?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
