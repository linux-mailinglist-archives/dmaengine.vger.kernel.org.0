Return-Path: <dmaengine+bounces-5726-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF5AF6368
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 22:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E357548749E
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E02D63E2;
	Wed,  2 Jul 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPRpVWdn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B35225A47;
	Wed,  2 Jul 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488687; cv=none; b=NFVX2mMPz7HrSJmB0abMG5fbE+7FTLPDeLJVjugSxSYFWSV1ZbeK9cm2EumyeB3xMMdkoHiQDvdrCUkXnW654to19WCX20PjyCLSlLdtLej2lCyEeGodipq39gUZS5ZQdXPBFQ3hIq0rwjwitGUI3ovLbmm3NY1k++1va+yz1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488687; c=relaxed/simple;
	bh=dDCS6QVJ7nXRWlnC2SiSC9vvqcF5+4EB5/e+hxz2kYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI8685KqAWZu7vct0Pzs+IgSVyJfyFeMVkaebg3XJ4xmXdAy0XFriTHzWimyf2ATLcfYaJr785djJ4bJFMOYYFaWKjGXgUq2xyYjig6hgzD4mHtXJnGR6O7Zka8OaG4hcBXzObJSAeQcrAvW3sg5MKZ+Nu3p1fNKHN9uTTrstmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPRpVWdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF21EC4CEE7;
	Wed,  2 Jul 2025 20:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751488687;
	bh=dDCS6QVJ7nXRWlnC2SiSC9vvqcF5+4EB5/e+hxz2kYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vPRpVWdnh+OJAAA7arYY7PnTcK2jpNELhtnvDh4laCUI4hYVphhNSPs460L2IVWTr
	 1jpr5XgjEgv88LJM91FV1cNYfzB7YLuH9t4SdJC4DNuy9RqwgcjL+99vF3iuJ1SctZ
	 ARHOTjY1hY8ZUrKMa/jH/4mi5bmpe0EB6KOC/Y7QKXXjfTaQTMI7TcjZlR4uOWwzpO
	 npAM2tFfXbRoGuWi1e2mt8hxCh3uiDlhHKU8fHBgR5DetbenJmcGQl54fPFsVTQ3Oh
	 ieCiVM47209l1++MMj/p6W+sbLAwaZixwCFKlfFnwbk9kM15X/w6gTj592919C4Z9u
	 PBAsrRUs6476w==
Message-ID: <43f19fbc-838b-431e-9d02-ecacf5f43731@kernel.org>
Date: Wed, 2 Jul 2025 22:38:00 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: dma: marvell,mmp-dma: Add SpacemiT K1
 PDMA support
To: Guodong Xu <guodong@riscstar.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
References: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
 <20250701-working_dma_0701_v2-v2-1-ab6ee9171d26@riscstar.com>
 <de965773-bab1-4c50-b111-19896465e53e@kernel.org>
 <CAH1PCMbKGeXL9Te6M28ZdX8VBvaToKcK7f+JmN6JsCfttG_Mtg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAH1PCMbKGeXL9Te6M28ZdX8VBvaToKcK7f+JmN6JsCfttG_Mtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/07/2025 11:52, Guodong Xu wrote:
> Hi, Krzysztof
> 
> On Tue, Jul 1, 2025 at 3:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 01/07/2025 07:36, Guodong Xu wrote:
>>> Add "spacemit,k1-pdma" compatible string to support SpacemiT K1 PDMA
>>> controller. This variant requires:
>>
>> Why is this marvell? This should be explained here, it's really unexpected.
>>
> 
> SpacemiT K1 SoC uses the same DMA controller as Marvell MMP. They share most
> of the registers (and address offsets) and only enhanced in addressing space
> capability (from 32bit to 64bit).

I hope you got the last comment...

> 
> Also, spacemit,k1-pdma and marvell,pdma-1.0 use the same driver (mmp_pdma.c),
> that's the reason why I chose keeping them in the same binding file.

That's moderate reason. I explained here further - don't grow old
bindings with completely new devices, because you keep growing old,
poorer patterns. You have a new device, you can make it right.


...

>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: spacemit,k1-pdma
>>> +    then:
>>> +      required:
>>> +        - clocks
>>> +        - resets
>>> +    else:
>>> +      properties:
>>> +        clocks: false
>>> +        resets: false
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - marvell,pdma-1.0
>>> +              - spacemit,k1-pdma
>>> +    then:
>>> +      properties:
>>> +        '#dma-cells':
>>> +          const: 2
>>> +          description:
>>> +            The first cell contains the DMA request number for the peripheral
>>> +            device. The second cell is currently unused but must be present for
>>> +            backward compatibility.
>>> +    else:
>>> +      properties:
>>> +        '#dma-cells':
>>> +          const: 1
>>> +          description:
>>> +            The cell contains the DMA request number for the peripheral device.
>>
>>
>> It's getting complicated. I suggest to make your own schema. Then you
>> would also switch to preferred 'sram' property instead of that legacy
>> 'asram'.
>>
>> Really, ancient schemas should not be grown for new, completely
> 
> The reason that they share the same device driver may not be strong enough
> compared to what you said here.

If DMA maintainer(s) reject complexity in driver, then it is fine. But
till that happens, you should rather come with a clean new binding and
don't grow legacy.


Best regards,
Krzysztof

