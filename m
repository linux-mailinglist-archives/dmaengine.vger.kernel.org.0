Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC962A6670
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2019 12:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfICKT2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Sep 2019 06:19:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42974 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICKT2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Sep 2019 06:19:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x83AJJrI043302;
        Tue, 3 Sep 2019 05:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567505959;
        bh=nRTqcKo/WxW5TqzAmvGzBhBJLV092AmqWAXRSgLL4HQ=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=MAVqHP5rCVzAK7qY2G2VaRwl+Eht1wf++tyKAUBDMpBXY1dqWnkSOasWdWuL3UJH0
         U1dTBLkeDz1xPdv8fjND7octTCvsoznIQlEEKIsiKu28tOdcGOTTPx52xwX7H2+Mlc
         7C8KTXqRqmsSup83zDK3uH75JreICd8llooyx7us=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x83AJJXP081861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Sep 2019 05:19:19 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 3 Sep
 2019 05:19:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 3 Sep 2019 05:19:19 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x83AJHVI102032;
        Tue, 3 Sep 2019 05:19:17 -0500
Subject: Re: [PATCH 4/5] dt-bindings: dma: ti-edma: Add option for reserved
 channel ranges
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
 <20190823125618.8133-5-peter.ujfalusi@ti.com> <20190829224728.GA1198@bogus>
 <a4c5688b-cbeb-5059-5351-11d9ae1b25d5@ti.com>
Message-ID: <15d5dc03-d6ca-f438-f37a-e71298abda95@ti.com>
Date:   Tue, 3 Sep 2019 13:19:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a4c5688b-cbeb-5059-5351-11d9ae1b25d5@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On 30/08/2019 8.37, Peter Ujfalusi wrote:
> Rob,
> 
> On 30/08/2019 1.47, Rob Herring wrote:
>> On Fri, Aug 23, 2019 at 03:56:17PM +0300, Peter Ujfalusi wrote:
>>> Similarly to paRAM slots, channels can be used by other cores.
>>>
>>> Add optional property to configure the reserved channel ranges.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/dma/ti-edma.txt | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> index 4bbc94d829c8..1198682ada99 100644
>>> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> @@ -42,6 +42,9 @@ Optional properties:
>>>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>>>  		the driver, they are allocated to be used by for example the
>>>  		DSP. See example.
>>> +- ti,edma-reserved-chan-ranges: channel ranges which should not be used by
>>> +		the driver, they are allocated to be used by for example the
>>> +		DSP. See example.
>>
>> Based on the other thread, I think extending dma-channel-mask to a 
>> uint32-array makes sense here.
> 
> Yes, that is the reason I have asked on that and I'm in progress of
> converting the edma driver to use the dma-channel-mask.
> Just need to do some shuffling in the driver to get the mask in a form
> usable by the driver.
> 
> I'll send an updated series early next week.

How should the dma-channel-mask uint31-array should be documented and used?

Basically some EDMA have 32, some 64 channels. This is fine.
Let's say I want to mask out channel 0-4 and 24-27

This would look like in case of EDMA with 32 channels:
&edma {
	/* channel 0-4 and 24-27 is not to be used */
	dma-channel-mask = <0xf0fffff0>;
};

How this should look like in case when I have 64 channels?
&edma {
	/* channel 0-4 and 24-27 is not to be used */
	dma-channel-mask = <0xf0fffff0>, <0xffffffff>;
};

When I read the u32s then
chan_mask[0] is for channel 0-31 (LSB is channel 0)
chan_maks[1] is for channel 32-63 (LSB is channel 32)

Or:
&edma {
	/* channel 0-4 and 24-27 is not to be used */
	dma-channel-mask = <0xffffffff>, <0xf0fffff0>;
};

chan_maks[0] is for channel 32-63 (LSB is channel 32)
chan_mask[1] is for channel 0-31 (LSB is channel 0)

Do you have pointer on already established notion on how to document and
handle this?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
