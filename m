Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148BCB393F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfIPLV0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 07:21:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35964 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfIPLV0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Sep 2019 07:21:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8GBLHpq018299;
        Mon, 16 Sep 2019 06:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568632877;
        bh=wfTbaAsMEgx246hNYVYOakABrMwbY3BN/kjsiLz4lDU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YwKaQWKIwG6iHYhAUHn/s9YWwC3FEqt3x7BZZ2615UlRMglUhdtmYSnBW9rx9Nv9a
         hqWt0g1hd2QlBYPKVEOYWCXYtjp/WUMgnMUTkd+7PO6jAv6HfyHdWcAQqWSWTAZDOQ
         IdhtICJA+187SlQA3Bdt58PPtIPJyA5txDRxUstI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8GBLHkk031925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Sep 2019 06:21:17 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 16
 Sep 2019 06:21:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 16 Sep 2019 06:21:15 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8GBLFCr054256;
        Mon, 16 Sep 2019 06:21:16 -0500
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add documentation for DMA domains
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190910115037.23539-1-peter.ujfalusi@ti.com>
 <20190910115037.23539-2-peter.ujfalusi@ti.com>
 <5d7ba96c.1c69fb81.ee467.32b9@mx.google.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <82254a3e-12fe-14d8-d49a-6627dd1d3559@ti.com>
Date:   Mon, 16 Sep 2019 14:21:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d7ba96c.1c69fb81.ee467.32b9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 13/09/2019 17.36, Rob Herring wrote:
> On Tue, Sep 10, 2019 at 02:50:35PM +0300, Peter Ujfalusi wrote:
>> On systems where multiple DMA controllers available, non Slave (for example
>> memcpy operation) users can not be described in DT as there is no device
>> involved from the DMA controller's point of view, DMA binding is not usable.
>> However in these systems still a peripheral might need to be serviced by or
>> it is better to serviced by specific DMA controller.
>> When a memcpy is used to/from a memory mapped region for example a DMA in the
>> same domain can perform better.
>> For generic software modules doing mem 2 mem operations it also matter that
>> they will get a channel from a controller which is faster in DDR to DDR mode
>> rather then from the first controller happen to be loaded.
>>
>> This property is inherited, so it may be specified in a device node or in any
>> of its parent nodes.
> 
> If a device needs mem2mem dma, I think we should just use the existing 
> dma binding. The provider will need a way to define cell values which 
> mean mem2mem.

But isn't it going to be an abuse of the binding? Each DMA controller
would hack this in different ways, probably using out of range DMA
request/trigger number or if they have direction in the binding or some
other parameter would be set to something invalid...

> For generic s/w, it should be able to query the dma speed or get a 
> preferred one IMO. It's not a DT problem.
> 
> We measure memcpy speeds at boot time to select the fastest 
> implementation for a chip, why not do that for mem2mem DMA?

It would make an impact on boot time since the tests would need to be
done with a large enough copy to be able to see clearly which one is faster.

Also we should be able to handle different probing orders:
client1 should have mem2mem channel from dma2.

- dma1 probes
- client1 probes and asks for a mem2mem channel
- dma2 probes

Here client1 should deffer until dma2 is probed.

Probably the property should be dma-mem2mem-domain to be more precise on
it's purpose and avoid confusion?

> 
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../devicetree/bindings/dma/dma-domain.yaml   | 88 +++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml
> 
> Note that you have several errors in your schema. Run 'make dt_bindings_check'.

That does not do anything on my system, but git dt-doc-validate running
via https://github.com/robherring/yaml-bindings.git.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
