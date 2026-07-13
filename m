Return-Path: <dmaengine+bounces-12362-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vw03Of5+VGqemgMAu9opvQ
	(envelope-from <dmaengine+bounces-12362-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 08:00:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0374766E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 08:00:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CUDI35Y6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12362-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12362-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C492D30038DF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 05:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E335F5F7;
	Mon, 13 Jul 2026 05:59:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CB2750FB;
	Mon, 13 Jul 2026 05:59:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922391; cv=none; b=qzxUdXJUceu2vdeiNjmw/RPjSmHbTfRW0brqD8UryuH5uD0k9rONcqkF/OwrJYFRu/OCeRMZ9JswtbNiqDc1t2PfuhTE4H0JVwNOxBXQeyb3whfhuobtXCVEI2JsnUpyrqaK0q9KjTkrB7VLz2Dzs0qzRS1RsfFfXCB15HfvaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922391; c=relaxed/simple;
	bh=mR6qG39tEdoqjonfEn7s1b84oKR6QX1VtjciU/OAoeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzh5JSPjzS5sBM1DObiLQGg9E/PFSIs9lvnDfA/nSYhmyYOe1TbonZlKSmDcpyUxh0qdwtXbmoWa+bNSQlLKPimT8PvYk0XqWUgLZbGLLR9sksjavYoXmuCYkkVT8aVJD90k12BSb/4k2ZtDveKvQoogenwWQbXkd5SG4GkRdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUDI35Y6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8C61F00A3A;
	Mon, 13 Jul 2026 05:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783922389;
	bh=ODG82ruy28s+gGhD9LHAupuPADqRrO7ASGl7zXU51V0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CUDI35Y6oG+VMQREk6ymLT0G11kLEzOqBkk593KdFXq8qV8IIuDJdIbceMZz6cVX8
	 DXhNc7zPn/mS+U7vcHnKfBffvxegpYeE7K62ZOR6kpfSYUbLLZADHVEsURwhTerYa4
	 peOT0togycLnGk3BPwsbL8EiUR7YxecNYNGQXRPWRMxb1EvvtQxnULPRPc/zVHco/i
	 OITDdz6r60gUsjfE5ogpglajJ3hXJm7Cl+BrySB7+qVxlizlOrqJ4D9F/37aok1o5B
	 B0fwaSK6WCx2yS3ayOh1IDGv7i8K2DnnFaVelO1vLpEnJBM7A/Qhm/WwLvlqAM0Hgs
	 CTdo0+1CmWoHw==
Message-ID: <7444091d-c4bf-40d9-a163-806a64565ce9@kernel.org>
Date: Mon, 13 Jul 2026 07:59:42 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: dma: ti,dma-crossbar: Convert to DT
 schema
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
 simona.toaca@nxp.com
References: <20260708-ti-dma-crossbar-v2-1-2ac0d6efde36@gmail.com>
 <20260712-dainty-condor-of-luxury-bacfa4@quoll>
 <CAOWyW_79oQB0L=3MtCnRuLst3=5ATJj=wpSS_550skTswUE2LQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAOWyW_79oQB0L=3MtCnRuLst3=5ATJj=wpSS_550skTswUE2LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:j.bhargav.u@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vigneshr@ti.com,m:peter.ujfalusi@gmail.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:goledhruva@gmail.com,m:m-chawdhry@ti.com,m:daniel.baluta@gmail.com,m:simona.toaca@nxp.com,m:jbhargavu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:peterujfalusi@gmail.com,m:danielbaluta@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12362-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,gmail.com,vger.kernel.org,nxp.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FD0374766E

On 12/07/2026 18:28, Bhargav Joshi wrote:
> Hi,
> 
> On Sun, Jul 12, 2026 at 6:22 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Wed, Jul 08, 2026 at 10:02:18PM +0530, Bhargav Joshi wrote:
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,dra7-dma-crossbar
>>> +      - ti,am335x-edma-crossbar
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#dma-cells":
>>> +    minimum: 1
>>> +    maximum: 3
>>
>> That's rather:
>>   enum: [1, 3]
>>
>> right?
> value 2 is required by DRA7 enhanced DMA crossbar (edma_xbar), and it is
> used in dra7-l4.dtsi so i think we can keep it unless you specifically
> prefer enum: [1, 2, 3]

I missed that edma device. It is fine.

> 
>>
>>> +
>>> +  dma-requests:
>>> +    minimum: 1
>>> +    maximum: 256
>>> +
>>> +  dma-masters:
>>> +    maxItems: 1
>>> +
>>> +  ti,dma-safe-map:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Safe routing value for unused request lines
>>> +
>>> +  ti,reserved-dma-request-ranges:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +    description:
>>> +      DMA request ranges which should not be used when mapping xbar input to
>>> +      DMA request, they are either allocated to be used by for example the DSP
>>> +      or they are used as memcpy channels in eDMA.
>>> +    items:
>>> +      items:
>>> +        - description: starting DMA request line number
>>> +        - description: number of consecutive lines to reserve
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - "#dma-cells"
>>> +  - dma-requests
>>> +  - dma-masters
>>> +
>>> +allOf:
>>> +  - $ref: dma-router.yaml#
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: ti,am335x-edma-crossbar
>>> +    then:
>>> +      properties:
>>> +        "#dma-cells":
>>> +          const: 3
>>
>> else:
>>   properties:
>>     dma-cels:
>>       const: 1
> Yes but this should be rather,
> else:
>   properties:
>     '#dma-cells':
>         enum: [1, 2]
> as dra7 doesn't use value 3 but uses 1 and 2, I will add it in next version


Yes


Best regards,
Krzysztof

