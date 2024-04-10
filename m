Return-Path: <dmaengine+bounces-1804-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0EE89EB40
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 08:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D802832FB
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9D57307;
	Wed, 10 Apr 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPOLsZnD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4E5732E;
	Wed, 10 Apr 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731628; cv=none; b=ad/8Fj/DG1D56QUosFCKGLYHi7tok87p333/oSU58QiSyIn79YmeicC/ewNLdqfSiIGC5cBcF5ttgK86a9tMUee+A3tNBweqJ/bM/IkLSrERiqwboVNssYGB0T+YlntV47y3zDkhBbp/je8egXHZgZLa0b+lA63ZWgbXiNTib5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731628; c=relaxed/simple;
	bh=umvn7dJr5Ogb5vNynCKdiGQkU5N7ianpIhZBLnGPWR0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uNCIyVX6M65ZKV/uVmoWCbJRsoVFNJ6PyjJ1I9qKjM2T4hOTM0yju2/QRP2OuIZb2zD0JdVtvuVv6mtMQzlxK892LHRSFKjrr6N09RBxIdl7dtR6+pU9FOJ0arDdvw1GsNmyAHhiabBmJpgFYMHwXlClO398d/MA0YDuIsgTfGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPOLsZnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4C9C433C7;
	Wed, 10 Apr 2024 06:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712731627;
	bh=umvn7dJr5Ogb5vNynCKdiGQkU5N7ianpIhZBLnGPWR0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MPOLsZnDqxbgiWwAdUU/cEs9w8vMF42KAb0npYDH90s7xApDFzOCCZmSE0He8XiBD
	 1llDVak1UYOOQ/JNv6DbQDz7bFPNtf6NuVaAIcHAYbzmJqgA+XhMOfphWKusFN/LsI
	 OmsaR23FO5c+htlo3RpOPX1+K13bvGPG1IBSffNKhP9D71Wd7C7hcyilH8hnOWuAm4
	 GEKx3a9kU8Ju1qyF21XiDWnv+AlBEFxaoYP8Fzl4Aqo20hLx6Wbg2vCgEwLzQUvgFe
	 1+L70NvvExFj9+ho58uhgc2AyOyOg9AooimAiFFYA5FhRBbsBkK+eeB3FwarbkTBee
	 hraFBPX44ealA==
Message-ID: <6db0c7fc-a94f-4f02-840a-1d64d6e2daa0@kernel.org>
Date: Wed, 10 Apr 2024 08:47:00 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from
 required
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, imx@lists.linux.dev,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org,
 20240409185416.2224609-1-Frank.Li@nxp.com, Xu Yang <xu.yang_2@nxp.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>
References: <20240409185416.2224609-1-Frank.Li@nxp.com>
 <b15ad271-037e-4ee3-ad88-e8068d31c8c8@linaro.org>
 <ZhWuetC8bRvDyxgX@lizhi-Precision-Tower-5810>
 <680f8830-6cd8-433b-85b7-439070bc528f@linaro.org>
 <383141cd-7f6f-4ed0-945b-7761833ecc35@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <383141cd-7f6f-4ed0-945b-7761833ecc35@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 08:32, Krzysztof Kozlowski wrote:
> On 10/04/2024 08:30, Krzysztof Kozlowski wrote:
>> On 09/04/2024 23:09, Frank Li wrote:
>>> On Tue, Apr 09, 2024 at 10:02:32PM +0200, Krzysztof Kozlowski wrote:
>>>> On 09/04/2024 20:54, Frank Li wrote:
>>>>> fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
>>>>> required and add 'if' block for other compatible string to keep the same
>>>>> restrictions.
>>>>>
>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>     Change from v2 to v3
>>>>>       - rebase to dmaengine/next
>>>>
>>>> This fails...
>>>
>>> What's wrong? 
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
>>>
>>>>
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>> index 825f4715499e5..657a7d3ebf857 100644
>>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>> @@ -82,7 +82,6 @@ required:
>>>>>    - compatible
>>>>>    - reg
>>>>>    - interrupts
>>>>> -  - clocks
>>>>>    - dma-channels
>>>>>  
>>>>>  allOf:
>>>>> @@ -187,6 +186,22 @@ allOf:
>>>>>          "#dma-cells":
>>>>>            const: 3
>>>>>  
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +	  contains:
>>>>
>>>> It does not look like you tested the bindings, at least after quick
>>>> look. Please run `make dt_binding_check` (see
>>>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>>> Maybe you need to update your dtschema and yamllint.
>>>
>>> Strange, Test passed
>>>
>>> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,edma.yaml
>>>   LINT    Documentation/devicetree/bindings
>>>   DTEX    Documentation/devicetree/bindings/dma/fsl,edma.example.dts
>>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>>   DTC_CHK Documentation/devicetree/bindings/dma/fsl,edma.example.dtb
>>
>> Nope, you tested other patch. Just look at your second patch for this.
>> When reviewer points to errors to your code, please investigate?
>>
>> NAK, fix your patches.
> 
> And to prove it, so you will stop wasting my time:
> ../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: found
> character that cannot start any token
> 
> ../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: [error]
> syntax error: found character '\t' that cannot start any token (syntax)
> 
> ../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: found
> character that cannot start any token
> 
> Documentation/devicetree/bindings/dma/fsl,edma.yaml: ignoring, error
> parsing file

Dear NXP,

Quality of patches from NXP is terrible. Several of them are poorly
coded, not following coding style, their submission is not following the
process and requires a lot of effort from reviewers. I was already
complaining about this on mailing lists months ago.

Things did not improve much.

However another trouble is the quality of responses during review. In
many patchsets your responses to reviewers comments were half-baked, not
on actual topic or just with minimal effort to close the topic from your
side. That's not how it works.

If you receive comment, you must investigate. Don't respond immediately
"no, I don't see error" or "but I want something else", but be sure that
you fixed the problem.

Such responses of minimal effort or pushing your own patch is
significant effort on reviewers side. I was complaining about this as
well. This patch here, which does not even build/test yet you claim in
response that you test, is perfect example of it. You got comment from
reviewer and instead really investigating this, you respond that
everything is good on your side. Typical response with minimal effort on
your side, but pushing it to the community.

That's it, that's too much.

NXP, your contributions are poor quality and put too much effort on
community.

Please improve your process, e.g. by training people interacting with
community and using extensive internal review. You can also reach to
experienced community members for help in training and explaining
upstream work, like Denx, Pengutronix, Bootlin, Linaro, Baylibre,
Collabora and others.

Till the situation improves, I will be ignoring all patches from @nxp.com.

Best regards,
Krzysztof


