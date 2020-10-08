Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9E3286ECA
	for <lists+dmaengine@lfdr.de>; Thu,  8 Oct 2020 08:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgJHGlT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Oct 2020 02:41:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33184 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGlT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 8 Oct 2020 02:41:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0986fB3A036284;
        Thu, 8 Oct 2020 01:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602139271;
        bh=gsL6qGyv3yy3qt79DsqdekTiwlE1pswLY4v54xlQGaU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=n3Fj0lfsWQDrsoyvfP9Uv/V5oXyfBDyrfdLVs8xCLZorZaqQYZg0e0xtiOdpx8KSL
         VyiIwYQcMqczKR+E71EkBKW3PC0rac75y/SFbeNVOkI5aRzTwRtmguGlJMhGdCYM5I
         6twh2j47g2LWOIKeGCmPfVy3xiLojGG+0TVlJpqQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0986fBxX019430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 01:41:11 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 01:41:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 01:41:11 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0986f8SO048206;
        Thu, 8 Oct 2020 01:41:09 -0500
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
To:     Vinod Koul <vkoul@kernel.org>
CC:     <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>, <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
 <20201007054404.GR2968@vkoul-mobl>
 <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
 <20201007155533.GZ2968@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <45adb88b-1ef8-1fbf-08c1-9afc6ea4c6f0@ti.com>
Date:   Thu, 8 Oct 2020 09:41:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201007155533.GZ2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/10/2020 18.55, Vinod Koul wrote:
> On 07-10-20, 11:08, Peter Ujfalusi wrote:
> 
>> Not really. In DT an event triggered channel can be requested via router
>> (when this is used) for example:
>>
>> dmas = <&inta_l2g a b c>;
>> a - the input number of the DMA request in l2g
>> b - edge or level trigger to be selected
>> c - ASEL number for the channel for coherency
>>
>> The l2g router driver then translate this to:
>> <&main_bcdma 1 0 c>
>> 1 - Global trigger 0 is used by the DMA
>> 0 - ignored
>> c - ASEL number.
>>
>> The router needs to send an event which is going to be received by the
>> channel we have picked up, this event number can only be known when we
>> do have the channel.
>>
>> So the flow in this case:
>> router converts the dma_spec for the DMA, but it does not yet know what
>> is the event number it has to use.
>> The BCDMA driver will pick an available bchan and notes that the
>> transfers will be triggered by global event 0.
>> When we have the channel, the core saves the router information and
>> calls the device_router_config of BCDMA.
>> In there we call back to the router and give the event number it has to
>> use to send the trigger for the channel.
> 
> Ah that is intresting, so you would call router driver foo_set_event()
> and would send the event number

Yes, that's correct.

> why not call that API from alloc
> channel or even xlate?

at alloc / xlate time the DMA driver does not have information about
router. The alloc/xlate will result the channel, but in my case it will
result a broken setup as the router does not know which event to send.

> Why do you need new callback?

When I added the DMA event router support, it was designed in a way that
the DMA driver itself must not know anything about the router, it has to
be transparent. One can just add a router on front of any DMA and
everything will work.
This is the right thing to do, and it works for existing setups.

> Or did i miss something..

The BCDMA triggered channel setup is a chicken-egg setup.
For this case the channel can be triggered by a global event. A channel
can receive two global event, but this is not a concern atm.
The event number depends on the channel we use, for simplicity let's
say: bchan_id + trigger_offset = bchan_trigger_evt.

of_dma_router_xlate does this:

1. calls the dma router's of_dma_route_allocate callback to allocate a
route and craft a dma_spec for the DMA to configure a channel.

2. using this crafted dma_spec we request a channel via of_dma_xlate
callback

3. if we got the channel, we save the router information, so it can be
deallocated when the channel is disabled.

I need a fourth step to do a final configuration since only at this time
(after it has been allocated) the channel has information about possible
router.

In the new optional callback the DMA driver can figure out the event
number which must be used by the router to send the event to the desired
global event target of the channel.

Other DMAs might need something different, but imho if there is going to
be a need for such post alloc router config, then it is most likely will
come from the need to feed back some sort of channel information to the
router. Or take parameter from the router itself for the channel.

To summarize:
In of_dma_route_allocate() the router does not yet know the channel we
are going to get.
In of_dma_xlate() the DMA driver does not yet know if the channel will
use router or not.
I need to tell the router the event number it has to send, which is
based on the channel number I got.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
