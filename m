Return-Path: <dmaengine+bounces-4998-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB859A98B01
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920673B2584
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E4156C6F;
	Wed, 23 Apr 2025 13:29:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD29460;
	Wed, 23 Apr 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414967; cv=none; b=ZqES12ClFLhIV1QkolGINE+lB4iSVCKh5mFlgmLX+c5vA2lsUWuAANy/5hjKPwRBAU1U0cwtS+yieRavFAZ77wj9XCQ0Scjzv3VYtdg2MeTXpyzYqRrqufp/V594SjIrSb6aPI2eoziAxjKlzSUgKHHMDNMy5mN8ABS+4LUJh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414967; c=relaxed/simple;
	bh=8IiNl2CeWD9T7AVvpJ1UnuYq7ckE9s7BVYvdL8mzHY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncLEb23zsUcQXOkYT5eB2/sRGEs1IXG+HlTzsrB2763jfl7vxCHab+xHIVUmJp1osDGfqIdRO8LkyAeUl/Vy89Tae39q2TVatBpwVoR5ie1fnQb7u98Lm5fUwkVaQYJhZ46QJdcJPrf8Ftq4qDLKBbJLPnlcTkbwinVG1dV7Ybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0761063;
	Wed, 23 Apr 2025 06:29:19 -0700 (PDT)
Received: from [10.57.74.63] (unknown [10.57.74.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D0473F66E;
	Wed, 23 Apr 2025 06:29:23 -0700 (PDT)
Message-ID: <b7557def-d0a1-4035-9586-a2651e28ab24@arm.com>
Date: Wed, 23 Apr 2025 14:29:21 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
To: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
 <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com>
 <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
 <aAjTg8dgvxqLQOwQ@vaman>
 <CAMuHMdXQKG0qptWMi169MVBL1S3hPo1TsaOSxWspoHAwRd+fug@mail.gmail.com>
 <aAjaPV/2DSyPAGRB@vaman>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aAjaPV/2DSyPAGRB@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-23 1:17 pm, Vinod Koul wrote:
> On 23-04-25, 14:13, Geert Uytterhoeven wrote:
>> Hi Vinod,
>>
>> On Wed, 23 Apr 2025 at 13:48, Vinod Koul <vkoul@kernel.org> wrote:
>>> On 23-04-25, 13:11, Geert Uytterhoeven wrote:
>>>> On Wed, 23 Apr 2025 at 12:59, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>> On 2025-04-22 7:11 pm, Geert Uytterhoeven wrote:
>>>>>> The Arm DMA-350 controller is only present on Arm-based SoCs.
>>>>>
>>>>> Do you know that for sure? I certainly don't. This is a licensable,
>>>>> self-contained DMA controller IP with no relationship whatsoever to any
>>>>> particular CPU ISA - our other system IP products have turned up in the
>>>>> wild paired with non-Arm CPUs, so I don't see any reason that DMA-350
>>>>> wouldn't either.
>>>>
>>>> The dependency can always be relaxed later, when the need arises.
>>>> Note that currently there are no users at all...

Huh? There is now an upstream DT binding, and DTs using that binding 
most certainly already exist - not least the one I have, but I'm not the 
only one. We don't have a requirement that bindings must have 
upstream-supported consumers.

>>> True, but do we have any warnings generated as a result, if there are no
>>> dependency should we still limit a driver to an arch?
>>
>> I am not aware of any warnings (I built it on MIPS yesterday ;-).
>> It is just one more question that pops up during "make oldconfig",
>> and Linus may notice and complain, too...

Well, yeah? It's a new driver for some (relatively) new hardware; every 
release always adds loads of new drivers for things I don't personally 
care about, so I press "n" a lot when updating my config, just like I 
imagine most other people do, Linus included.

> True, give there are no users, lets pick this and drop if we get a non
> arm user

Well by that logic surely it should just depend on COMPILE_TEST, because 
there are no ARM or ARM64 "users" either?

FWIW the not-quite-upstream platform I developed on (a custom build of 
fvp-base-revc with a DMA-350 component added) did happen to be ARM64, as 
are some other Arm-internal designs and one available SoC that I do know 
of containing DMA-350; I am not aware of any Linux-capable 32-bit 
platforms to justify an ARM dependency, so I'd consider that just as 
arbitrarily pulled out of thin air.

But then to pick another example at random, XILINX_DMA equally has no 
"users", so please make that depend on something arbitrary as well for 
consistency; it's only fair.

Thanks,
Robin.

