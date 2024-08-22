Return-Path: <dmaengine+bounces-2933-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F05395AD6E
	for <lists+dmaengine@lfdr.de>; Thu, 22 Aug 2024 08:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BC0281B88
	for <lists+dmaengine@lfdr.de>; Thu, 22 Aug 2024 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D02139CF6;
	Thu, 22 Aug 2024 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od+2+EEe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38A137C2A;
	Thu, 22 Aug 2024 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308075; cv=none; b=nkh2hqimWo/GynS8LHsLzjOISTZp2MJlxS1WvSfmkXRH0nhwdMkIcnJyBFgdONTSRvRUgc7Ey1fYMGzn+I1hIh0s3xvNc0bT2KGy4+PAwH3tOKvSVw6xWe6HkxCd+Qer5w2phNNy7ZdLcRlArsuyB2PIBAooUE28kFw6FmYp1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308075; c=relaxed/simple;
	bh=Uj8lzzLoP45JzCD1zqt3qSj6l3BlWmsYEzoccHcMGQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6QAKGWvG4/7snZXC7l8hjOfMZ+qCfjU+0x4S30aRMQggdLUShXG+hukPTc76qc24ygGrxNzjIH/qRCW9JLl5CwhgJJXtqxHl7Guo6XbcyXj+pUYhODlV6gX+FkbSlIYyY5+4KBIlo5CT41G2rooOPCKubIUncBk9OWOl0wDbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od+2+EEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98779C4AF0B;
	Thu, 22 Aug 2024 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724308075;
	bh=Uj8lzzLoP45JzCD1zqt3qSj6l3BlWmsYEzoccHcMGQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Od+2+EEeUbpxYry9/eiIWxc0ef7yY3IGKtR1ni/yReYhO75eVN6oBW4E8vu1tRVVi
	 HNc0f84X9y0Zqzm/+n8Vay5y+47jqgIZLH4PC9Ue4yLFjnYeCA+qB7nf9wHXacehL+
	 8Dnktag0KbkCgfXYNNK0AKZ1tV339AphYmbpZQn5rIjdkl0noH++dkX2iLUxKjCOhz
	 syPHquTZ6pnR1/G1viHy9QOYlytE0r3sKDRFmdjILMD00tBP4s4l7XLBGo5dvLl8Qn
	 fUAQhlycGNR7l5T54Bt3PsM68nAuIov5PNS03GBB+yIxPyfhrf6YCnadTOr9eQ+NAR
	 lkYdd9Tu27EkQ==
Message-ID: <c2292ef2-e93e-4ca3-bcd3-542bd27526ad@kernel.org>
Date: Thu, 22 Aug 2024 08:27:44 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] dt-bindings: dma: qcom,bam: Add bam pipe lock
To: Md Sadre Alam <quic_mdalam@quicinc.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, gustavoars@kernel.org,
 u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
 quic_utiwari@quicinc.com
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-2-quic_mdalam@quicinc.com>
 <0a2b884b-bd28-428e-be12-8fef4fdfd278@kernel.org>
 <c8b7c2f0-9de1-1787-2f1b-2aa0102f347c@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c8b7c2f0-9de1-1787-2f1b-2aa0102f347c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 18:34, Md Sadre Alam wrote:
> 
> 
> On 8/17/2024 2:38 PM, Krzysztof Kozlowski wrote:
>> On 15/08/2024 10:57, Md Sadre Alam wrote:
>>> BAM having pipe locking mechanism. The Lock and Un-Lock bit
>>> should be set on CMD descriptor only. Upon encountering a
>>> descriptor with Lock bit set, the BAM will lock all other
>>> pipes not related to the current pipe group, and keep
>>> handling the current pipe only until it sees the Un-Lock
>>> set.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>    Ok , will update in next patch.
>>
>>>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---
>>>
>>> Change in [v2]
>>>
>>> * Added initial support for dt-binding
>>>
>>> Change in [v1]
>>>
>>> * This patch was not included in [v1]
>>>
>>>   Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>> index 3ad0d9b1fbc5..91cc2942aa62 100644
>>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>> @@ -77,6 +77,12 @@ properties:
>>>         Indicates that the bam is powered up by a remote processor but must be
>>>         initialized by the local processor.
>>>   
>>> +  qcom,bam_pipe_lock:
>>
>> Please follow DTS coding style.
>    Ok
>>
>>> +    type: boolean
>>> +    description:
>>> +      Indicates that the bam pipe needs locking or not based on client driver
>>> +      sending the LOCK or UNLOK bit set on command descriptor.
>>
>> You described the desired Linux feature or behavior, not the actual
>> hardware. The bindings are about the latter, so instead you need to
>> rephrase the property and its description to match actual hardware
>> capabilities/features/configuration etc.
>    Ok, will update in next patch.
>>
>>> +
>>>     reg:
>>>       maxItems: 1
>>>   
>>> @@ -92,6 +98,8 @@ anyOf:
>>>         - qcom,powered-remotely
>>>     - required:
>>>         - qcom,controlled-remotely
>>> +  - required:
>>> +      - qcom,bam_pipe_lock
>>
>> Why is it here? What do you want to achieve?
>    This property added to achieve locking/unlocking
>    of BAM pipe groups for mutual exclusion of resources
>    that can be used across multiple EE's

This explains me nothing. I am questioning the anyOf block. Why this is
the fourth method of controlling BAM? Anyway, if it is, then explain
this in commit msg.

Best regards,
Krzysztof


