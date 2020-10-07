Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C428285E75
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 13:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgJGLto (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 07:49:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59728 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgJGLto (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Oct 2020 07:49:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 097Bnfhu050847;
        Wed, 7 Oct 2020 06:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602071381;
        bh=W4xGhDWT1+ePzUUUuvec26NlPIyDjKM2QF/s3h1SvZw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MKVT8Hiq1s9mtqtgyOKK3dXtvvCq1DMKYxqiJSeF4z6zxZHyP3+RoM1HJxl86Gk9w
         cDGGmyhQ0u3Pu320zffqPALoN/ZBLcYS3Vj9cu3DVJ/VCvkPvku+s9WHQzu32mpw+y
         MNFJw+HOxpHQKLhW//LOHbnByKQpdPFozCE8Uu/A=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 097BnfbN128101
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 06:49:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 06:49:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 06:49:41 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 097BnOgQ102958;
        Wed, 7 Oct 2020 06:49:25 -0500
Subject: Re: [PATCH v3 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200923063410.3431917-1-vkoul@kernel.org>
 <20200923063410.3431917-3-vkoul@kernel.org>
 <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
 <20201001112307.GX2968@vkoul-mobl>
 <f063ae03-41da-480a-19ba-d061e140e4d2@ti.com>
 <20201007112807.GW2968@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <5784e3cb-8d22-58f1-5211-a450b60949a9@ti.com>
Date:   Wed, 7 Oct 2020 14:49:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007112807.GW2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 07/10/2020 14.28, Vinod Koul wrote:
> Hi Peter,
> 
> On 02-10-20, 11:48, Peter Ujfalusi wrote:
> 
>> It depends which is best for the use case.
>> I see the metadata useful when you need to send different
>> metadata/configuration with each transfer.
>> It can be also useful when you need it seldom, but for your use case and
>> setup the dma_slave_config extended with
>>
>> enum dmaengine_peripheral peripheral_type;
>> void *peripheral_config;
>>
>> would be a bit more explicit.
>>
>> I would then deal with the peripheral config in this way:
>> when the DMA driver's device_config is called, I would take the
>> parameters and set a flag that the config needs to be processed as it
>> has changed.
>> In the next prep_slave_sg() then I would prepare the TREs with the
>> config and clear the flag that the next transfer does not need the
>> configuration anymore.
>>
>> In this way each dmaengine_slave_config() will trigger at the next
>> prep_slave_sg time configuration update for the peripheral to be
>> included in the TREs.
>> The set_config would be internal to the DMA driver, clients just need to
>> update the configuration when they need to and everything is taken care of.
> 
> Ok I am going to drop the dmaengine_peripheral and make
> peripheral_config as as you proposed.
> 
> So will add following to dma_slave_config:
>         void *peripheral_config;
> 
> Driver can define the config they would like and use.
> 
> We can eventually look at common implementations and try to unify once
> we have more users

Sound good to me!

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
