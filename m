Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E95B7559
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfISIm1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 04:42:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45948 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfISIm1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Sep 2019 04:42:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8J8gOfh101089;
        Thu, 19 Sep 2019 03:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568882544;
        bh=9XCz0KQ8VIy2bXU54yGvLcGfJbHxfuMAFwL9AuUQbJk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xrjPviqfg+AoBvCYwkGfIVJzvNHcMKKfdZPgYiXzNRUqew/vzw98kzX3G0wpL/T6z
         XFVwNs4LQo5vigsv+vDuJg00o5S0Vfw3j8IKm1PQNSeWBkNfYMULvbzUWAGKd7x12U
         WCbjFjHEdy3HffU6n9+7kKVvWbpNA+dn/3T6VxbA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8J8gOpr020085
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Sep 2019 03:42:24 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 19
 Sep 2019 03:42:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 19 Sep 2019 03:42:24 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8J8gMRU029946;
        Thu, 19 Sep 2019 03:42:22 -0500
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: dma-common: Change
 dma-channel-mask to uint32-array
To:     Rob Herring <robh@kernel.org>
CC:     Vinod <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190910114559.22810-1-peter.ujfalusi@ti.com>
 <20190910114559.22810-2-peter.ujfalusi@ti.com> <20190918132835.GA4527@bogus>
 <d76ffc38-8e68-656a-325b-37de9b01e015@ti.com>
 <CAL_JsqLJn4dmnjU=7kVgiosAU=o+fSJNH6578D92fGbdOR8Zfw@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a1e4bf6a-ad7d-aa72-82c0-5cbb5af5bd0d@ti.com>
Date:   Thu, 19 Sep 2019 11:42:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLJn4dmnjU=7kVgiosAU=o+fSJNH6578D92fGbdOR8Zfw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/09/2019 17.21, Rob Herring wrote:
>>>> +          - description: Mask of chnanels X-(X+31)
>>>
>>> Obviously, this was not validated with 'make dt_binding_check'.
>> make dt_bindings_check
>> make: *** No rule to make target 'dt_bindings_check'.  Stop.
> 
> Read Documentation/devicetree/writing-schema.md (or .rst in next).
> 
> Either your config doesn't have DTC enabled or you don't have
> dt-schema installed.

I have reinstalled dt-schema and added $HOME/.local/bin to PATH and now
'make dt_binding_check' is working and passing for dma-common.yaml.

For some reason it did not validate the new dma-domain.yaml from another
series, I guess it need to be added to some list?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
