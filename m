Return-Path: <dmaengine+bounces-5020-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EAA9AC44
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 13:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C2D9A0D90
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6722CBE9;
	Thu, 24 Apr 2025 11:38:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E364223DF9;
	Thu, 24 Apr 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494713; cv=none; b=nW6w6mbeiHVrWFuu2Z2XWgoq7757q687g5LZff1xLuiuM5aGAFkEIDwz6eDdOvSvd4GFfiRLzc/AFqoRWvFWEmzMklr2DB9/5EIYg33xOyz3zwMvlfYDiKrfHd5BeNLk94ulD0ZGnGPOczLxrcSpdODjVuGu1yOOTBsaN/prjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494713; c=relaxed/simple;
	bh=YnVdP5JrfoFnV+HtyKFHOIak+9oIvNBw6PGZQxnXm3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiUmbCM7giZeC0C2MXN2E9Ws1HNu2IpdUogQSlCgLKxWV7QSagR5/0QEDJAbB93cw7mR6qz0vpbT4sA22AxuaweSmZsz6lsKjyhepoYxj+skZ6stmirosX0gH1nrb/+XbZhxxjzuAR181Ies2BvFx7BDPZoDOmkjfkWSgiZQfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCED11063;
	Thu, 24 Apr 2025 04:38:25 -0700 (PDT)
Received: from [10.57.73.163] (unknown [10.57.73.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00F4C3F59E;
	Thu, 24 Apr 2025 04:38:29 -0700 (PDT)
Message-ID: <7f4207ff-42ec-46ee-beb6-cb27835f955d@arm.com>
Date: Thu, 24 Apr 2025 12:38:28 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
 <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com>
 <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
 <aAjTg8dgvxqLQOwQ@vaman>
 <CAMuHMdXQKG0qptWMi169MVBL1S3hPo1TsaOSxWspoHAwRd+fug@mail.gmail.com>
 <aAjaPV/2DSyPAGRB@vaman> <b7557def-d0a1-4035-9586-a2651e28ab24@arm.com>
 <CAMuHMdWoxPc71YYrEMdPwdq-HOhmP2jNiwo1+-8o6_v4YJ0NHQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAMuHMdWoxPc71YYrEMdPwdq-HOhmP2jNiwo1+-8o6_v4YJ0NHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-23 3:34 pm, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Wed, 23 Apr 2025 at 15:29, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2025-04-23 1:17 pm, Vinod Koul wrote:
>>> On 23-04-25, 14:13, Geert Uytterhoeven wrote:
>>>> On Wed, 23 Apr 2025 at 13:48, Vinod Koul <vkoul@kernel.org> wrote:
>>>>> On 23-04-25, 13:11, Geert Uytterhoeven wrote:
>>>>>> On Wed, 23 Apr 2025 at 12:59, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>>>> On 2025-04-22 7:11 pm, Geert Uytterhoeven wrote:
>>>>>>>> The Arm DMA-350 controller is only present on Arm-based SoCs.
>>>>>>>
>>>>>>> Do you know that for sure? I certainly don't. This is a licensable,
>>>>>>> self-contained DMA controller IP with no relationship whatsoever to any
>>>>>>> particular CPU ISA - our other system IP products have turned up in the
>>>>>>> wild paired with non-Arm CPUs, so I don't see any reason that DMA-350
>>>>>>> wouldn't either.
>>>>>>
>>>>>> The dependency can always be relaxed later, when the need arises.
>>>>>> Note that currently there are no users at all...
>>
>> Huh? There is now an upstream DT binding, and DTs using that binding
>> most certainly already exist - not least the one I have, but I'm not the
>> only one. We don't have a requirement that bindings must have
>> upstream-supported consumers.
> 
> Dependencies in Kconfig are not related to DT bindings, they only
> control what can be built?

I was questioning how you have decided that there are "no users at all", 
and how you know "the need" hasn't already arisen...

>>>>> True, but do we have any warnings generated as a result, if there are no
>>>>> dependency should we still limit a driver to an arch?
>>>>
>>>> I am not aware of any warnings (I built it on MIPS yesterday ;-).
>>>> It is just one more question that pops up during "make oldconfig",
>>>> and Linus may notice and complain, too...
>>
>> Well, yeah? It's a new driver for some (relatively) new hardware; every
>> release always adds loads of new drivers for things I don't personally
>> care about, so I press "n" a lot when updating my config, just like I
>> imagine most other people do, Linus included.
> 
> Please read [1] and ask yourself if Linux wants to see a question
> about Arm DMA-350 when configuring a kernel for his AMD Threadripper
> workstation...

...because the whole point here is that it's *not* "completely 
nonsensical". I am well aware of Linus' view and I share it myself. This 
is not a driver for some deeply platform-vendor-specific firmware 
function. PCIe FPGA prototyping cards are a thing, so yes, just like 
with XILINX_DMA, anyone with one of those and access to the IP could 
absolutely synthesise and drive a functional DMA-350 in their x86 PC 
today if they wish.

Conversely, Linus doesn't have a DMA-350 in his Ampere box or his Mac 
either, so in that context it's still just as meaningless to prompt him 
for his ARM64 builds. And I doubt he has all of the dozens of new IIO 
sensors, USB HIDs, etc. which pop up every release either. I'm not sure 
what point you're trying to make there.

People are building hardware now, which by the time it comes out might 
be able to run a standard distro kernel and use this driver, if said 
distro has already built and shipped the module. Why is that such an 
unacceptably terrible thing?

>>> True, give there are no users, lets pick this and drop if we get a non
>>> arm user
>>
>> Well by that logic surely it should just depend on COMPILE_TEST, because
>> there are no ARM or ARM64 "users" either?
> 
> If you want to push it that far, fine for me ;-)
> 
>> FWIW the not-quite-upstream platform I developed on (a custom build of
>> fvp-base-revc with a DMA-350 component added) did happen to be ARM64, as
>> are some other Arm-internal designs and one available SoC that I do know
>> of containing DMA-350; I am not aware of any Linux-capable 32-bit
>> platforms to justify an ARM dependency, so I'd consider that just as
>> arbitrarily pulled out of thin air.
> 
> OK, then the ARM dependency can be dropped for now.
> I had done a quick Google search to find SoCs that contain a DMA-350
> instance, and had only found a Cortex-M0-based SoC, so I assumed it
> would be used on ARM, too.
> 
>> But then to pick another example at random, XILINX_DMA equally has no
>> "users", so please make that depend on something arbitrary as well for
>> consistency; it's only fair.
> 
> Sure, there are lots of Kconfig symbols that could benefit from
> additional dependencies. Unfortunately my time is limited, so usually
> I create and send patches for new Kconfig symbols only....

Dare I suggest your time could be less limited if you avoided spending 
it on nonsensical and unnecessary gatekeeping? ;)

Yes, config options with a clear dependency on a particular platform 
should clearly be restricted to configs which include support for that 
platform. Config options which do not have any such dependency are just 
that - *options*, for the distro/end user to decide whether they might 
be (or become) relevant within the scope and lifetime of the kernel 
being built.

Thanks,
Robin.

