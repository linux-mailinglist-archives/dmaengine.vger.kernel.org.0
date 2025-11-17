Return-Path: <dmaengine+bounces-7207-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED41C6462D
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 14:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E92736674B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC17333759;
	Mon, 17 Nov 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaU2hNHJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E7333736;
	Mon, 17 Nov 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386148; cv=none; b=FacN9ARYZ0Yrv2EW/QksKpmchGdVamMhb41NWGHZBhNOqpCHtFYaJrb7lUrSkRfSZHTts3I+PBXurp7RTC5+FJGSqSRH4oI+6eV1DErxmIiahK6TNFjeAji9De3NBzpk9iqLFaDURmnD02iHVrcifq3uwSU86e3q9eagitChKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386148; c=relaxed/simple;
	bh=gv2gXvqWNBRE2gsB37FQd1r+Dio+HXuMvuIz/e6eQTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwb+HgbUXeXuh46Zzyg0g9NdBYod+hlTo9OzVPAzi9yMLu8aPkiaHd1HRV6OR/0BdhnGyFB6NJ1txfP8s8ashn3b3/CruXmiiQA173ZGjPi9qCw+DIzONbmCEAyXqtuM3HbDGYnmXmuXsAyOifvF12xnQTEftIVkLZCLL25E3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaU2hNHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C9C19422;
	Mon, 17 Nov 2025 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763386147;
	bh=gv2gXvqWNBRE2gsB37FQd1r+Dio+HXuMvuIz/e6eQTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TaU2hNHJ9Fy8Pxh3bAjRoh8C2ikueevsd6YU10cuuKPBe8/lOghS3iSSr5DplFemB
	 HnE3K/z0JOPYlIbrgEc2Vd4Pp7aeXKxZ3qj631pPi7t7Y/tpnbsmgZU+nrwFS4nzL4
	 oclcgalX/F9YT3xnyLt1CQw9H/gBazwwbB5XIHfcPCrbCo2gFvr5z6E83wINEGPhhq
	 wqUv9Bc6nHwLz52w7acPoyXAnKkKafviq2VCY57xyrChvQ/zCIMyGFoY3kMza+r6qa
	 xYDbt2NhVDXl/RjUVolUen/GPH06AG8I0XJQz1VMFPW1L3+jXpE1f3ytaFHtUIi8AD
	 b5glYuECPyugA==
Message-ID: <7df26091-97be-4494-8140-5e2ca54780ea@kernel.org>
Date: Mon, 17 Nov 2025 14:29:02 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dma: arm-dma350: update DT binding docs
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20251117015943.2858-1-jun.guo@cixtech.com>
 <20251117015943.2858-2-jun.guo@cixtech.com>
 <bfe6a067-704b-45c1-919e-6a7dfb08b984@kernel.org>
 <aea1429d-b67e-4c42-ad19-88d04f69467b@cixtech.com>
 <024eb64f-74bd-4170-a6c1-09c4af647926@kernel.org>
 <62b59d52-7107-4426-b922-812d343195db@kernel.org>
 <08142bd3-4a17-4c4f-88ff-fd81e9941a18@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <08142bd3-4a17-4c4f-88ff-fd81e9941a18@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 13:51, Jun Guo wrote:
> 
> On 11/17/2025 3:13 PM, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL
>>
>> On 17/11/2025 08:11, Krzysztof Kozlowski wrote:
>>> On 17/11/2025 08:07, Jun Guo wrote:
>>>>
>>>> On 11/17/2025 2:11 PM, Krzysztof Kozlowski wrote:
>>>>> On 17/11/2025 02:59, Jun Guo wrote:
>>>>>> - Add new compatible strings to the DT binding documents to support
>>>>> This is not a list.
>>>>>
>>>>> Also, subject is completely redundant. Everything is an update. Why are
>>>>> you repeating DT binding docs?
>>>>>
>>>> Thank you. I will incorporate your feedback in the next version.>>   cix
>>>> sky1 SoC.
>>>>>>
>>>>>> Signed-off-by: Jun Guo<jun.guo@cixtech.com>
>>>>>> ---
>>>>> You just broke all existing platforms. Please test your code properly.
>>>> The patch includes proper checks. Since this platform is the first user
>>>
>>> Nah, tests are here incomplete - look at the binding and DTS users...
>>> nothing there, so you cannot test it.
>>>
>>>> of the driver in the current codebase, the change won't affect other
>>>> platforms.
>>>
>>> NAK, and you keep pushing... I just told you it will break everyone,
>>> which is obvious from the diff.
>>
>> But if that was intentional change of ABI, then could be fine, but you
>> must provide in commit msg proper detailed rationale WHY you are
>> changing ABI and WHAT is the ABI impact of that change.
>>
> I'm not entirely sure if I fully grasped your point, but I also 
> identified the potential issue. I've reworked the patch to accommodate 
> both the default DTS case with a single compatible string and the 
> scenario where platform-specific compatible strings need to be added. 
> Could you please review it again and confirm if this aligns with your 
> intent?
> 
> properties:
>    compatible:
>      contains:

Which example uses such syntax?

>        enum:
>          - cix,sky1-dma-350
>          - arm,dma-350

It's completely different than previous, so I don't know what you want
to achieve, but maybe you wanted to explain lack of compatibility in the
commit msg. Anyway, send proper patches with proper justification (and
for above would really need to be proper).

Best regards,
Krzysztof

