Return-Path: <dmaengine+bounces-5468-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768FFAD9B40
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 10:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C651189A1D3
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2953275AF6;
	Sat, 14 Jun 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dram.page header.i=@dram.page header.b="AsAFH9tr"
X-Original-To: dmaengine@vger.kernel.org
Received: from kuriko.dram.page (kuriko.dram.page [65.108.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADC274FE1;
	Sat, 14 Jun 2025 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749889808; cv=none; b=YIAT69RiI5ZjvfNein+kui4SloioJdA/Vyx3sscFKSl+QoXIkcJ2wY98YVSrBB0zpuizz+fz25+hYaCpmzR51v0rD5CPzH+rTD6XzRElvwaCpSzwK2SVyASQz0yh/E3gyEVtFK3hrb650h2W5QoAiBHzmdmgYoIVMAahnqEwl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749889808; c=relaxed/simple;
	bh=8nGDx9EBdJD5Q7S0nu+h3c/M/InGy+ZQ6FInoRIY0JY=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=kvFOAg5VZqztRzPFthFbbpVQ04GR9SiZIjNPRhDEUOMH3wyORtxXu7Dgp/uLUb+T0utwpN5e7BxvNgK4O4mp2QkDFTi8NAnUqenSXoOF25wgVdL35PqAjmwEWosWvebtGuHfp19rRfPFZSj7M54xJSOuRO9c1IRA9znpUd5MNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dram.page; spf=pass smtp.mailfrom=dram.page; dkim=pass (1024-bit key) header.d=dram.page header.i=@dram.page header.b=AsAFH9tr; arc=none smtp.client-ip=65.108.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dram.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dram.page
Message-ID: <e29c10c1-4428-468a-a3c1-eb52a8927eab@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
	t=1749889804; bh=fy3ZmGP0DBFmKLLDiN1icstbFc46RNNPFWa0SQDVLqI=;
	h=Date:From:Subject:References:Reply-To:To:Cc:In-Reply-To;
	b=AsAFH9trt6/fHdQ0BLcRUSBvuwGiWr9qfoEEJL0jlXyoAr9wDQQDCcThRjSVDgj6v
	 eRJwx8MN3++wmsDzjioVhG+BoF/9na4NMQC00kZugHO1Vm49+uJu5KBUCtLjYnoHSV
	 CLXmqu50kKCWJBDbfBFb/5Rdg3av8O/RZYR6viso=
Date: Sat, 14 Jun 2025 16:29:46 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vivian Wang <uwu@dram.page>
Subject: [PATCH 5/8] riscv: dts: spacemit: Add dma bus and PDMA node for K1
 SoC
References: <f65586d7-6b27-409f-b0f1-d0a746d83521@dram.page>
Content-Language: en-US
Reply-To: Vivian Wang <uwu@dram.page>
To: Guodong Xu <guodong@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com,
 emil.renner.berthing@canonical.com, inochiama@gmail.com,
 geert+renesas@glider.be, tglx@linutronix.de, hal.feng@starfivetech.com,
 joel@jms.id.au, duje.mihanovic@skole.hr, Ze Huang <huangze@whut.edu.cn>,
 elder@riscstar.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
In-Reply-To: <f65586d7-6b27-409f-b0f1-d0a746d83521@dram.page>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[resent to get rid of HTML]

On 6/14/25 10:53, Guodong Xu wrote:
> On Fri, Jun 13, 2025 at 11:07 AM Vivian Wang<uwu@dram.page> wrote:
>> Hi Guodong,
>>
>> On 6/11/25 20:57, Guodong Xu wrote:
>>> <snip>
>>>
>>> -                     status = "disabled";
>>> +             dma_bus: bus@4 {
>>> +                     compatible = "simple-bus";
>>> +                     #address-cells = <2>;
>>> +                     #size-cells = <2>;
>>> +                     dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
>>> +                                  <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
>>> +                     ranges;
>>>                };
>> Can the addition of dma_bus and movement of nodes under it be extracted
>> into a separate patch, and ideally, taken up by Yixun Lan without going
>> through dmaengine? Not specifically "dram_range4", but all of these
>> translations affects many devices on the SoC, including ethernet and
> It was not my intention to add all the separate memory mapping buses into
> one patch. I'd prefer to add them when there is at least one user.
> The k1.dtsi at this moment, as I checked, has no real user beside the
> so-called "dram_range4" in downstream vendor kernel (ie. dma_bus in this
> patch). And that is what I did: grouping devices which share the same
> dma address mapping as pdma0 into one single separated bus.
>
> The other buses, even if I add them, would be empty.
>
> What the SpacemiT team agreed upon so far, is the naming of these separated
> buses. I listed them here for future reference purposes.
>
> If needed, I can send that in a RFC patchset, of course; or as a normal
> PATCH, if Yixun is ok with that. However, please note, that would mean more
> merging dependencies: PDMA dts, ethernet dts, usb dts, will have to depend
> on this base 'buses' PATCH.
>
> Again, I prefer we add our own 'bus' when there is a need.
>
> +       soc {
> +               storage_bus: bus@0 {
> +                       /* USB, SDH storage controllers */
> +                       dma-ranges = <0x0 0x00000000 0x0 0x00000000
> 0x0 0x80000000>;
> +               };
> +
> +               multimedia_bus: bus@1 {
> +                       /* VPU, GPU, DPU */
> +                       dma-ranges = <0x0 0x00000000 0x0 0x00000000
> 0x0 0x80000000>,
> +                                    <0x0 0x80000000 0x1 0x00000000
> 0x3 0x80000000>;
> +               };
> +
> +               pcie_bus: bus@2 {
> +                       /* PCIe controllers */
> +                       dma-ranges = <0x0 0x00000000 0x0 0x00000000
> 0x0 0x80000000>,
> +                                    <0x0 0xb8000000 0x1 0x38000000
> 0x3 0x48000000>;
> +               };
> +
> +               camera_bus: bus@3 {
> +                       /* ISP, CSI, imaging devices */
> +                       dma-ranges = <0x0 0x00000000 0x0 0x00000000
> 0x0 0x80000000>,
> +                                    <0x0 0x80000000 0x1 0x00000000
> 0x1 0x80000000>;
> +               };
> +
> +               dma_bus: bus@4 {
> +                       /* DMA controller, and users */
> +                       dma-ranges = <0x0 0x00000000 0x0 0x00000000
> 0x0 0x80000000>,
> +                                    <0x1 0x00000000 0x1 0x80000000
> 0x3 0x00000000>;
> +               };
> +
> +               network_bus: bus@5 {
> +                       /* Ethernet, Crypto, JPU */
> +                       dma-ranges = <0x0 0x00000000 0x0 0x00000000
> 0x0 0x80000000>,
> +                                    <0x0 0x80000000 0x1 0x00000000
> 0x0 0x80000000>;
> +               };
> +
> +       }; /* soc */

Ah, I didn't know the names were already decided.

However, I still think we should at least separate the patch into two in 
the same series, one adding the bus node and handling existing nodes, 
and another adding the new node under it. This way, say someone starts 
working on Crypto, they can simply depends on the first bus patch 
without having to pull in the new node.

I still prefer having a canonical buses patch though.

If we're going to agree here on what the buses should look, I also have 
two nitpicks, just so we get this sorted: Firstly, I think storage_bus 
should be removed. Anything using storage_bus is already handled by 
simply using 32-bit-only DMA, which is the default anyway. @Ze Huang: 
Your USB controller falls under it, what do you think?

Also, as suggested the node names must not have a made up unit address. 
"bus@1" is inappropriate because they have no reg. The simple-bus schema 
allows the node name to have a prefix like "foo-bus" [1] [2], so it 
should be like:

/* DMA controller, and users */
dma_bus: dma-bus {
	compatible = "simple-bus";
	ranges;
	#address-cells = <2>;
	#size-cells = <2>;
	dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
		     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
};

(Pardon the formatting; I don't know if the tabs survived Thunderbird.)

[1]:https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/simple-bus.yaml
[2]:https://github.com/devicetree-org/dt-schema/commit/bab67075926b8bdc4093edbb9888aaa5bd8befd5

Well, that is the reason I wanted the bus things to be its own patch: I 
think the DT maintainers should review these once and for all, not six 
separate times as the drivers come in.

>> USB3. See:
>>
>> https://lore.kernel.org/all/20250526-b4-k1-dwc3-v3-v4-2-63e4e525e5cb@whut.edu.cn/
>> https://lore.kernel.org/all/20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn/
>>
>> (I haven't put eth{0,1} under dma_bus5 because in 6.16-rc1 there is
>> none, but ideally we should fix this.)
> So, as you are submitting the first node(s) under network_bus: bus@5, you
> should have this added into your patchset, instead of sending out with none.
I hope we can agree on what the bus nodes look like before we do that 
separately.
> The same logic goes to USB too, Ze Huang was in the same offline call, and
> I would prefer that we move in a coordinated way.

I hope so as well, but "we" here should include DT maintainers.

Please consider my suggestions.

Vivian "dramforever" Wang

>> DMA address translation does not depend on PDMA. It would be best if we
>> get all the possible dma-ranges buses handled in one place, instead of
>> everyone moving nodes around.
> No, you should do it in your patchset, when you add the eth0 and eth1 nodes,
> they will be the first in, as I said, "network_bus". I don't expect
> any 'moving nodes around'.
>
>> @Ze Huang: This affects your "MBUS" changes as well. Please take a look,
>> thanks.
>>
>>>                gpio: gpio@d4019000 {
>>> @@ -792,3 +693,124 @@ pwm19: pwm@d4022c00 {
>>>                };
>>>        };
>>>   };
>>> +
>>> +&dma_bus {
>>>
>>> <snip>

