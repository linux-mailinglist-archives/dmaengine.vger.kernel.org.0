Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08FFD9A0
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2019 10:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfKOJoV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Nov 2019 04:44:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50428 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfKOJoV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Nov 2019 04:44:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAF9i9cM070472;
        Fri, 15 Nov 2019 03:44:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573811049;
        bh=E0WzhltMB1uCqHukFqL7nvpsZ7Dg3L6LXU0D/M/afHk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nGQ4lsiTTMA/u3mYvQBGiCimGGu+zhohaFc7OZ7bIu+CWjxxF1eWkRUBFtOuyYeCa
         OKc7HWEV9E2Vb0B10pGrfZ2BFSL/Q+m77cERWOeDxYFdTbhQd2autXTZqwz9BxfO+g
         lJ4q4DWNpBtxmyRXdYJSyxkH7gWGik8yTMi/ByJI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAF9i9JV054404;
        Fri, 15 Nov 2019 03:44:09 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 15
 Nov 2019 03:44:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 15 Nov 2019 03:44:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAF9i55L081214;
        Fri, 15 Nov 2019 03:44:05 -0600
Subject: Re: [PATCH v4 08/15] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Rob Herring <robh@kernel.org>
CC:     Vinod <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-9-peter.ujfalusi@ti.com> <20191105021900.GA17829@bogus>
 <fc1ea525-54f1-ff1a-7e1c-61b54f5be862@ti.com>
 <CAL_JsqJbV7Zd40admW-x2SSveMqMkG0tM6RFTwjCJyYxX4Cxtw@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b4705f2e-b2fb-f00f-7d4d-bd440fe89135@ti.com>
Date:   Fri, 15 Nov 2019 11:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJbV7Zd40admW-x2SSveMqMkG0tM6RFTwjCJyYxX4Cxtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rob,

On 14/11/2019 19.53, Rob Herring wrote:
> On Tue, Nov 5, 2019 at 4:07 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>
>>
>>
>> On 05/11/2019 4.19, Rob Herring wrote:
>>> On Fri, Nov 01, 2019 at 10:41:28AM +0200, Peter Ujfalusi wrote:
>>>> New binding document for
>>>> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
>>>>
>>>> UDMA-P is introduced as part of the K3 architecture and can be found in
>>>> AM654 and j721e.
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> ---
>>>> Rob,
>>>>
>>>> can you give me some hint on how to fix these two warnings from dt_binding_check:
>>>>
>>>>   DTC     Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
>>>> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dts:23.13-72: Warning (ranges_format): /example-0/interconnect@30800000:ranges: "ranges" property has invalid length (24 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 2)
>>>>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
>>>
>>> The default #address-cells is 1 for examples. So you need to
>>> either override it or change ranges parent address size.
>>
>> wrapping the cbass_main_navss inside:
>> cbass_main {
>>     #address-cells = <2>;
>>     #size-cells = <2>;
>>     ...
>> };
>>
>> fixes it.
>>
>>>>
>>>> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml: interconnect@30800000: $nodename:0: 'interconnect@30800000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>>>
>>> Use 'bus' for the node name of 'simple-bus'.
>>
>> I took the navss node from the upstream dts (I'm going to fix it there
>> as well).
>> It has simple-bus for the navss, which is not quite right as NAVSS is
>> not a bus, but a big subsystem with multiple components (UDMAP, ringacc,
>> INTA, INTR, timers, etc).
>>
>> What about to change the binding doc to simple-mfd like this
> 
> That's really for things not memory-mapped (I'm sure you can probably
> find an example to contradict me), so better to keep simple-bus if all
> the child nodes have addresses.

According to Documentation/devicetree/bindings/mfd/mfd.txt:
- A range of memory registers containing "miscellaneous system
  registers" also known as a system controller "syscon" or any other
  memory range containing a mix of unrelated hardware devices.

NAVSS (NAVigator SubSystem) falls in the later case, it contains
unrelated blocks, like the UDMAP, ringacc, mailboxes, spinlocks,
interrupt aggregator, interrupt router, etc.

- compatible : "simple-mfd" - this signifies that the operating system
  should consider all subnodes of the MFD device as separate devices
  akin to how "simple-bus" indicates when to see subnodes as children
  for a simple memory-mapped bus.

This is a bit confusing, but NAVSS is not really a bus, everything in it
can be accessed by the CPU via memory mapped registers (some sub devices
does not have registers defined, they are controlled via system firmware).

> Do you need the node name to be 'navss' for some reason? If so, then
> better have a compatible string in there to identify it. If not, just
> use 'bus' and be done with it.

We don't need unique compatible for the NAVSS itself as there is not
much we can configure on the top level, it is 'just' a big subsystem
with all sorts of things.

I like to keep the 'navss' as node name as it gives human understandable
representation of it in /sys for example, easier to see the topology.

I just feel that the 'bus' does not really apply to what NAVSS is.
Probably my view of simple-bus is not correct.

>> cbass_main_navss: navss@30800000 {
>>     compatible = "simple-mfd";
>>     #address-cells = <2>;
>>     #size-cells = <2>;
>>     ...
>> };
>>
>> and fix up the DT when I got to the point when I can send the patches to
>> enable DMA for am654 and j721e?
> 
> There's no requirement yet for DTS files to not have warnings.

Sure, but it does not hurt if they are clean ;)

>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - const: ti,am654-navss-main-udmap
>>>> +      - const: ti,am654-navss-mcu-udmap
>>>> +      - const: ti,j721e-navss-main-udmap
>>>> +      - const: ti,j721e-navss-mcu-udmap
>>>
>>> enum works better than oneOf+const. Better error messages.
>>
>> Like this:
>>   compatible:
>>     oneOf:
>>       - description: for AM654
>>         items:
>>           - enum:
>>               - ti,am654-navss-main-udmap
>>               - ti,am654-navss-mcu-udmap
>>
>>       - description: for J721E
>>         items:
>>           - enum:
>>               - ti,j721e-navss-main-udmap
>>               - ti,j721e-navss-mcu-udmap
> 
> If the 'description' was useful, but it's not. Just:
> 
> compatible:
>   enum:
>     - ti,am654-navss-main-udmap
>     - ti,am654-navss-mcu-udmap
>     - ti,j721e-navss-main-udmap
>     - ti,j721e-navss-mcu-udmap

OK, can I keep your Reviewed-by you have given to v5 if I do this change
for v6?

> 
> 
> Rob
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
