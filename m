Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA9A2F04
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2019 07:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfH3Fh0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Aug 2019 01:37:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59252 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfH3FhZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Aug 2019 01:37:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7U5bBq0007730;
        Fri, 30 Aug 2019 00:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567143431;
        bh=wENEtc1oSdE7sKdHvE/SrtRNZIVELKHhkqPIGCtqfZM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fP+UQ47ODQpVpnHMSgU5hH2Tw8D2QjpX/uQ0nWELDQ8CIOgTzh81lJSfMvU/RNJi7
         rRVBF5K0YELHhOo+cMFUNJpqQA9yYjdnmOTHXBS2+1IQJtiS87lUuTqR+R+cxGmEUm
         g20o9y/eXQs6LQQ4vwrizejntWF+Ue1biLPyEqow=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7U5bB59040438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Aug 2019 00:37:11 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 30
 Aug 2019 00:37:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 30 Aug 2019 00:37:11 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7U5b9RZ082071;
        Fri, 30 Aug 2019 00:37:09 -0500
Subject: Re: [PATCH 4/5] dt-bindings: dma: ti-edma: Add option for reserved
 channel ranges
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
 <20190823125618.8133-5-peter.ujfalusi@ti.com> <20190829224728.GA1198@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a4c5688b-cbeb-5059-5351-11d9ae1b25d5@ti.com>
Date:   Fri, 30 Aug 2019 08:37:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829224728.GA1198@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rob,

On 30/08/2019 1.47, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 03:56:17PM +0300, Peter Ujfalusi wrote:
>> Similarly to paRAM slots, channels can be used by other cores.
>>
>> Add optional property to configure the reserved channel ranges.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  Documentation/devicetree/bindings/dma/ti-edma.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> index 4bbc94d829c8..1198682ada99 100644
>> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> @@ -42,6 +42,9 @@ Optional properties:
>>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>>  		the driver, they are allocated to be used by for example the
>>  		DSP. See example.
>> +- ti,edma-reserved-chan-ranges: channel ranges which should not be used by
>> +		the driver, they are allocated to be used by for example the
>> +		DSP. See example.
> 
> Based on the other thread, I think extending dma-channel-mask to a 
> uint32-array makes sense here.

Yes, that is the reason I have asked on that and I'm in progress of
converting the edma driver to use the dma-channel-mask.
Just need to do some shuffling in the driver to get the mask in a form
usable by the driver.

I'll send an updated series early next week.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
