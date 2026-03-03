Return-Path: <dmaengine+bounces-9208-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA+PB9GjpmkbSQAAu9opvQ
	(envelope-from <dmaengine+bounces-9208-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 10:03:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75D01EB970
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 10:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBDC931176CD
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517C389DE6;
	Tue,  3 Mar 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU+Ih78T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6C38552F;
	Tue,  3 Mar 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528254; cv=none; b=CVbCJ03iSCQkCs9SovR1B9TQkPX4cX4gVHx3cVHxrCLfA58xcCdwgPsyGix5pT/SMaShzXjI6+XwqcXWZwI+C4MNOVgktdGlLmo3/T2I6qAzOu3D7KbiWDOgL7XPnSV/t/JycGNrL9UBGJpKIyVnuD0X/Ms11k8UFgpC//ZvGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528254; c=relaxed/simple;
	bh=KulhFkadCwBsmVUEcbSD4peLvLMdzJNrHT+Iiz3ob9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPHk+qAarjzxTZ4wBDLfXKl2J4C22RXxwAkxu9hWglC+CJcvCQyJrbPfKRDKAK0NCeww9/MAaf0/9M/NJooR+R5z3klqW8zDfO8kWREaI4NyBsU0ySXc1j8q4xM2yO97cYT0Kqk1GiJvA3+tkRJkSOWamiwD6qOlfNJXF/WJ4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rU+Ih78T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E76C19425;
	Tue,  3 Mar 2026 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772528254;
	bh=KulhFkadCwBsmVUEcbSD4peLvLMdzJNrHT+Iiz3ob9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rU+Ih78T7EOoLYCGqRgx6jNA22Fi92dBiAxVgB/yNJ4xXHGjsjGynQjkVicwZzaA1
	 I5r3k1XYoyN/7PAbzYMvwkMsCj9oSBsRV7sOlPn0oTmXWQ2m9MYMxIkmgmKIAoCeBt
	 9QJZ3Iqrw+KwEvPFJhUBA/nMIUtAr8sgzulSkpyD21c/sH8q2Diw7UxS4R3sKxnHC5
	 8xWdcpBp6wKnOowaDNUHj/OjSaVa+ih/lsH7L9uwrY5E46odlltoIlUuCqKbZCN1wp
	 UtF+aBQaL+412kW7FfFS7xEWvwizsPQ/kc8QugLRPZgY0iAlGF0YMyFp3KXb4/gtsc
	 VFoFf1TxZjOwg==
Message-ID: <a8f807dd-156e-45bd-8280-38e73dd99b04@kernel.org>
Date: Tue, 3 Mar 2026 09:57:29 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, jonathanh@nvidia.com, krzk+dt@kernel.org,
 ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
 thierry.reding@kernel.org, vkoul@kernel.org
References: <20260303-famous-fearless-asp-1240cb@quoll>
 <20260303084005.57114-1-akhilrajeev@nvidia.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260303084005.57114-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B75D01EB970
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9208-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 03/03/2026 09:40, Akhil R wrote:
> On Tue, 3 Mar 2026 07:39:58 +0100 Krzysztof Kozlowski wrote:
>> On Mon, Mar 02, 2026 at 06:02:31PM +0530, Akhil R wrote:
>>> Add iommu-map property to specify separate stream IDs for each DMA
>>> channel. This enables each channel to be in its own IOMMU domain,
>>> keeping memory isolated from other devices sharing the same DMA
>>> controller.
>>>
>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>> ---
>>>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml     | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>> index 0dabe9bbb219..1e7b5ddd4658 100644
>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>> @@ -14,6 +14,7 @@ description: |
>>>  maintainers:
>>>    - Jon Hunter <jonathanh@nvidia.com>
>>>    - Rajesh Gumasta <rgumasta@nvidia.com>
>>> +  - Akhil R <akhilrajeev@nvidia.com>
>>>  
>>>  allOf:
>>>    - $ref: dma-controller.yaml#
>>> @@ -51,6 +52,10 @@ properties:
>>>    iommus:
>>>      maxItems: 1
>>>  
>>> +  iommu-map:
>>> +    minItems: 1
>>> +    maxItems: 32
>>
>> Why is this flexible? If it is, means usually items are distinctive, so
>> I would expect defining/listing them. If they are not distinctive,
>> commit msg is incorrect. If the list is as simple as 1-to-1 channel
>> mapping, just add it in the description how they are ordered.
> 
> Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
> it flexible is to allow non-consecutive IOMMU ID assignments as well.

You cannot skip items if these have such meaning of mapping per channel.
The list order is the ABI - index of the list is the channel here.

> This is particularly needed in virtualised environments where the
> hypervisor may reserve certain stream IDs, and the guest VM can map only
> the permitted ones. Shall I add a description here mentioning this
> use-case?

You can also look at recent works for iris video codec from Qualcomm
solving something similar.


Best regards,
Krzysztof

