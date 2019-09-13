Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F758B18CE
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2019 09:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfIMHVZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Sep 2019 03:21:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33026 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfIMHVY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Sep 2019 03:21:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8D7LH6j100344;
        Fri, 13 Sep 2019 02:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568359277;
        bh=TOZHru5X6XUj2LkcqOkTZ5p+L4Yvc+YK8qK6LR9EH8E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WlAANlAssqmJq+X0jSFKJFP1HVVLg3UmmSdMlXFBf4J8BxYgwUvop/RO1xUkKkTpb
         3pOVHr+pLVQPhrlMZR0fThuYrKy/2Docj/t/mbd3v8CFl8ka1zX4Wl1r0j04oevPaB
         iIxIJnh1eOox+YCYaNG2dh5bJ3KDUpPD+p3RlMFM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8D7LHVu057714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Sep 2019 02:21:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 13
 Sep 2019 02:21:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 13 Sep 2019 02:21:15 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8D7LEHN013986;
        Fri, 13 Sep 2019 02:21:14 -0500
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
 <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
 <20190908121058.GL2672@vkoul-mobl>
 <a452cd06-79ca-424d-b259-c8d60fc59772@ti.com>
 <20190912170312.GD4392@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1992ccdd-78b3-f248-3d4d-76b5e6d4cb37@ti.com>
Date:   Fri, 13 Sep 2019 10:21:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912170312.GD4392@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/09/2019 20.03, Vinod Koul wrote:
> On 09-09-19, 09:30, Peter Ujfalusi wrote:
> 
>>>> or domain-dma-controller?
>>>
>>> I feel dma-domain-controller sounds fine as we are defining domains for
>>> dmaengine. Another thought which comes here is that why not extend this to
>>> slave as well and define dma-domain-controller for them as use that for
>>> filtering, that is what we really need along with slave id in case a
>>> specific channel is to be used by a peripheral
>>>
>>> Thoughts..?
>>
>> I have thought about this, we should be able to drop the phandle to the
>> dma controller from the slave binding just fine.
>>
>> However we have the dma routers for the slave channels and there is no
>> clear way to handle them.
>> They are not needed for non slave channels as there is no trigger to
>> route. In DRA7 for example we have an event router for EDMA and another
>> one for sDMA. If a slave device is to be serviced by EDMA, the EDMA
>> event router needs to be specified, for sDMA clients should use the sDMA
>> event router.
> 
> So you have dma, xbar and client? And you need to use a specfic xbar,
> did i get that right?

At the end yes.
EDMA have dedicated crossbar
sDMA have dedicated crossbar

Slave devices must use the crossbar to request channel from the DMA
controllers. Non slave request are directed to the controllers directly
(no DT binding).

At minimum we would need a new property for DMA routers.
dma-domain-router perhaps which is pointing to the xbar.

A slave channel request would first look for dma-domain-router, if it is
there, the request goes via that.
If not then look for dma-domain-controller and use it for the request.
The DMA binding can drop the phandle to the xbar/dma.

Request for not slave channel would only look for dma-domain-controller.

But...

- If we have one dedicated memcpy DMA and one for slave usage.
In top we declare dma-domain-controller = <&m2m_dma>;

Then you have  a slave client somewhere
client1: peripheral@42 {
	dma-domain-controller = <&slave_dma>;
	dmas = <6>, <7>;
	dma-names = "tx", "rx";
};

This is fine I guess. But what would we do if the driver for client1
needs additional memcpy channel? By the definition of the binding the
non slave channel should be taken from the closest dma-domain-controller
which is not what we want. We want the channel from m2m_dma.

And no, we can not start looking for the dma-domain-controller starting
from the root as in most cases the dma-domain-controller closer to the
client is what we really want and not the globally best controller.

- How to handle the transition?
If neither dma-domain-controller/router is found, assume that the first
argument in the binding is a phandle to the dma/router?
We need to carry the support for what we have today for a long time. The
kernel must boot with old DT blob.

- Will it make things cleaner? Atm it is pretty easy to see which
controller/router is used for which device.

- Also to note that the EDMA and sDMA bindings are different, so we can
not just swap dma-domain-controller/router underneath, we also need to
modify the client's dmas line as well.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
