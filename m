Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7163109A26
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2019 09:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKZI3i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Nov 2019 03:29:38 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55100 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfKZI3i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Nov 2019 03:29:38 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQ8TIGd113992;
        Tue, 26 Nov 2019 02:29:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574756958;
        bh=sOlBif7gK5pnyCr+lDdyRLduRMavJKYGdPrcVdrE3vk=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=D8uPLtYb5/IfCiXlyv90/OI9+s3XAyzzegnbexNxyBmMAlhDsyMh32hGIKoAflM3P
         OYs0ZDbdS0Yrxvcvm8v2hWOsK8Kh9wV3g4wyAHG6M0B8AqVszRrkgWG0kvn+JOomMz
         7eA37MHwzghpLHmPgFCVCY1D3Ckmpb0WRtkKJEvw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAQ8TInK027696
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 02:29:18 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 02:29:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 02:29:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQ8TDfx099514;
        Tue, 26 Nov 2019 02:29:14 -0600
Subject: Re: [PATCH v4 08/15] dt-bindings: dma: ti: Add document for K3 UDMA
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vinod <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-9-peter.ujfalusi@ti.com> <20191105021900.GA17829@bogus>
 <fc1ea525-54f1-ff1a-7e1c-61b54f5be862@ti.com>
 <CAL_JsqJbV7Zd40admW-x2SSveMqMkG0tM6RFTwjCJyYxX4Cxtw@mail.gmail.com>
 <b4705f2e-b2fb-f00f-7d4d-bd440fe89135@ti.com>
Message-ID: <f2f4a4f5-335d-9a20-b410-91a7619fb84d@ti.com>
Date:   Tue, 26 Nov 2019 10:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b4705f2e-b2fb-f00f-7d4d-bd440fe89135@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rob,

On 15/11/2019 11.45, Peter Ujfalusi wrote:
> Rob,
> 
> On 14/11/2019 19.53, Rob Herring wrote:
>> On Tue, Nov 5, 2019 at 4:07 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>>
>>>
>>>
>>> On 05/11/2019 4.19, Rob Herring wrote:
>>>> On Fri, Nov 01, 2019 at 10:41:28AM +0200, Peter Ujfalusi wrote:
>>>>> New binding document for
>>>>> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
>>>>>
>>>>> UDMA-P is introduced as part of the K3 architecture and can be found in
>>>>> AM654 and j721e.
>>>>>
>>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>>> ---
>>>>> Rob,
>>>>>
>>>>> can you give me some hint on how to fix these two warnings from dt_binding_check:
>>>>>
>>>>>   DTC     Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
>>>>> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dts:23.13-72: Warning (ranges_format): /example-0/interconnect@30800000:ranges: "ranges" property has invalid length (24 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 2)
>>>>>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
>>>>
>>>> The default #address-cells is 1 for examples. So you need to
>>>> either override it or change ranges parent address size.
>>>
>>> wrapping the cbass_main_navss inside:
>>> cbass_main {
>>>     #address-cells = <2>;
>>>     #size-cells = <2>;
>>>     ...
>>> };
>>>
>>> fixes it.
>>>
>>>>>
>>>>> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml: interconnect@30800000: $nodename:0: 'interconnect@30800000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>>>>
>>>> Use 'bus' for the node name of 'simple-bus'.
>>>
>>> I took the navss node from the upstream dts (I'm going to fix it there
>>> as well).
>>> It has simple-bus for the navss, which is not quite right as NAVSS is
>>> not a bus, but a big subsystem with multiple components (UDMAP, ringacc,
>>> INTA, INTR, timers, etc).
>>>
>>> What about to change the binding doc to simple-mfd like this
>>
>> That's really for things not memory-mapped (I'm sure you can probably
>> find an example to contradict me), so better to keep simple-bus if all
>> the child nodes have addresses.
> 
> According to Documentation/devicetree/bindings/mfd/mfd.txt:
> - A range of memory registers containing "miscellaneous system
>   registers" also known as a system controller "syscon" or any other
>   memory range containing a mix of unrelated hardware devices.
> 
> NAVSS (NAVigator SubSystem) falls in the later case, it contains
> unrelated blocks, like the UDMAP, ringacc, mailboxes, spinlocks,
> interrupt aggregator, interrupt router, etc.
> 
> - compatible : "simple-mfd" - this signifies that the operating system
>   should consider all subnodes of the MFD device as separate devices
>   akin to how "simple-bus" indicates when to see subnodes as children
>   for a simple memory-mapped bus.
> 
> This is a bit confusing, but NAVSS is not really a bus, everything in it
> can be accessed by the CPU via memory mapped registers (some sub devices
> does not have registers defined, they are controlled via system firmware).
> 
>> Do you need the node name to be 'navss' for some reason? If so, then
>> better have a compatible string in there to identify it. If not, just
>> use 'bus' and be done with it.
> 
> We don't need unique compatible for the NAVSS itself as there is not
> much we can configure on the top level, it is 'just' a big subsystem
> with all sorts of things.
> 
> I like to keep the 'navss' as node name as it gives human understandable
> representation of it in /sys for example, easier to see the topology.
> 
> I just feel that the 'bus' does not really apply to what NAVSS is.
> Probably my view of simple-bus is not correct.

Can you advice on how to proceed? I would like to send v6 so Vinod can
pick it for next after 5.5-rc1 is tagged.
This is the only thing which I need to close on to be able to do that.

> 
>>> cbass_main_navss: navss@30800000 {
>>>     compatible = "simple-mfd";
>>>     #address-cells = <2>;
>>>     #size-cells = <2>;
>>>     ...
>>> };
>>>
>>> and fix up the DT when I got to the point when I can send the patches to
>>> enable DMA for am654 and j721e?
>>
>> There's no requirement yet for DTS files to not have warnings.
> 
> Sure, but it does not hurt if they are clean ;)
> 
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - const: ti,am654-navss-main-udmap
>>>>> +      - const: ti,am654-navss-mcu-udmap
>>>>> +      - const: ti,j721e-navss-main-udmap
>>>>> +      - const: ti,j721e-navss-mcu-udmap
>>>>
>>>> enum works better than oneOf+const. Better error messages.
>>>
>>> Like this:
>>>   compatible:
>>>     oneOf:
>>>       - description: for AM654
>>>         items:
>>>           - enum:
>>>               - ti,am654-navss-main-udmap
>>>               - ti,am654-navss-mcu-udmap
>>>
>>>       - description: for J721E
>>>         items:
>>>           - enum:
>>>               - ti,j721e-navss-main-udmap
>>>               - ti,j721e-navss-mcu-udmap
>>
>> If the 'description' was useful, but it's not. Just:
>>
>> compatible:
>>   enum:
>>     - ti,am654-navss-main-udmap
>>     - ti,am654-navss-mcu-udmap
>>     - ti,j721e-navss-main-udmap
>>     - ti,j721e-navss-mcu-udmap
> 
> OK, can I keep your Reviewed-by you have given to v5 if I do this change
> for v6?
> 
>>
>>
>> Rob
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
