Return-Path: <dmaengine+bounces-8982-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMoxILEZmGki/wIAu9opvQ
	(envelope-from <dmaengine+bounces-8982-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 09:22:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D6F1659BA
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 09:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D322E3019389
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67243358D3;
	Fri, 20 Feb 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k91OqmPK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E03358D8;
	Fri, 20 Feb 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575724; cv=none; b=H5J2fVEZk3PkYZYOGgiHKNsRGfnlXw+FBrr6CeDYdLimEEo9jFf2i87jkS87LtFSj1qvKES9GG2+R9VmTK42s5jyQcUUfEp3iP52mPE2tK/qrGseGucG6MeiEQL+BQ0gkKMwf5kNu0pgQ14O6cJw9CKWdkzwOilXjHsdCgD3uEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575724; c=relaxed/simple;
	bh=/tVxFYUaV9QgUw8KxtW2+QYEPZm7milE80n6LUzxnpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKs0z/VZI+yETOcifb+kHXhLkMWi3B9FPMbGWkd/IDrxJA4BGkopQGu6lMGmTQm50PHImXL0FoeEb0i1KhOaAeQSatk1Aved3PIGirE20WhgQ58FyqZHWcr8Y5SWe0K6qlFOrtSWvBrzbkZnPEVTsI2Jt+O2YaoJ8y2sJIJGrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k91OqmPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F31EC116C6;
	Fri, 20 Feb 2026 08:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771575724;
	bh=/tVxFYUaV9QgUw8KxtW2+QYEPZm7milE80n6LUzxnpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k91OqmPKeLdP1mFUrZtE8eLFbfLbnuRc5M+Hc7irZ9NqjqfTCThcZPISC+d0IORbb
	 23RIk70UDvHcg6q6BvJ+AKqhnXg//IgL+SSCBrFlxTtKV9VLMX7E4UPh9gu25s2J/L
	 6dyiIKy5Sobzz5r8xaqG6N5G/sO/BtSAVJ41sRHm9y51rtzdK0EoZ9gx4VV6d22RSg
	 OyrpMMrhB768mDbTf4QHYuguatt7YrqFPW0UdlTQpD+HGSRn2NV8LA+1QtAdHZkfkh
	 slLC9/UjWF4gZ4+f27dBCPWPA5gpkj+RNCSsBIVno+q7ViTVPTPbV0jB0/AytnFdhm
	 I5pJwEyV6kj4Q==
Message-ID: <74f16cb6-35e9-45ba-a66c-691f3f23f892@kernel.org>
Date: Fri, 20 Feb 2026 09:21:59 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/18] dt-bindings: dma: ti: Add K3 BCDMA V2
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, Frank.li@nxp.com, r-sharma3@ti.com, gehariprasath@ti.com
References: <20260218095243.2832115-1-s-adivi@ti.com>
 <20260218095243.2832115-13-s-adivi@ti.com>
 <20260219-hopeful-intrepid-cuckoo-32967d@quoll>
 <bab85365-063a-4d46-a1bf-48a25228d109@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <bab85365-063a-4d46-a1bf-48a25228d109@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8982-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 09D6F1659BA
X-Rspamd-Action: no action

On 19/02/2026 13:15, Sai Sree Kartheek Adivi wrote:
> 
> On 19/02/26 13:13, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,
> 
> Thanks for the review.
>> On Wed, Feb 18, 2026 at 03:22:37PM +0530, Sai Sree Kartheek Adivi wrote:
>>> New binding document for
>> Fix wrapping - it's wrapped too early.
> Ack. will fix it in v6.
>>
>>> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
>>>
>>> BCDMA V2 is introduced as part of AM62L.
>>>
>>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> ---
>>>   .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 120 ++++++++++++++++++
>>>   1 file changed, 120 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>> new file mode 100644
>>> index 0000000000000..6fa08f22df375
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>> @@ -0,0 +1,120 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2024-25 Texas Instruments Incorporated
>>> +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments K3 DMSS BCDMA V2
>>> +
>>> +maintainers:
>>> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +
>>> +description:
>>> +  The BCDMA V2 is intended to perform similar functions as the TR
>>> +  mode channels of K3 UDMA-P.
>>> +  BCDMA V2 includes block copy channels and Split channels.
>>> +
>>> +  Block copy channels mainly used for memory to memory transfers, but with
>>> +  optional triggers a block copy channel can service peripherals by accessing
>>> +  directly to memory mapped registers or area.
>>> +
>>> +  Split channels can be used to service PSI-L based peripherals.
>>> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
>>> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
>>> +  legacy peripheral.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/dma/dma-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,am62l-dmss-bcdma
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: BCDMA Control & Status Registers region
>>> +      - description: Block Copy Channel Realtime Registers region
>>> +      - description: Channel Realtime Registers region
>>> +      - description: Ring Realtime Registers region
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: gcfg
>>> +      - const: bchanrt
>>> +      - const: chanrt
>>> +      - const: ringrt
>>> +
>>> +  "#address-cells":
>>> +    const: 0
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 1
>> I don't get why this is nexus but not a interrupt-controller.
>>
>> Can you point me to DTS with complete picture using this?
> 
> Please refer 
> https://github.com/sskartheekadivi/linux/commit/4a7078a6892bfbc4c620b9668e3421b4c7405ca4
> 
> for the dt nodes of AM62L BCDMA and PKTDMA.
> 
> Refer to the below tree for full set of driver, dt-binding and dts changes
> 
> https://github.com/sskartheekadivi/linux/commits/dma-upstream-v5/

That's not complete. There are no consumers, so this does not really
answer my problem of lack of controller.

> 
>>
>>> +
>>> +  "#dma-cells":
>>> +    const: 4
>>> +    description: |
>>> +      cell 1: Trigger type for the channel
>>> +        0 - disable / no trigger
>>> +        1 - internal channel event
>>> +        2 - external signal
>>> +        3 - timer manager event
>>> +
>>> +      cell 2: parameter for the trigger:
>>> +        if cell 1 is 0 (disable / no trigger):
>>> +          Unused, ignored
>>> +        if cell 1 is 1 (internal channel event):
>>> +          channel number whose TR event should trigger the current channel.
>>> +        if cell 1 is 2 or 3 (external signal or timer manager event):
>>> +          index of global interfaces that come into the DMA.
>>> +
>>> +          Please refer to the device documentation for global interface indexes.
>>> +
>>> +      cell 3: Channel number for the peripheral
>>> +
>>> +        Please refer to the device documentation for the channel map.
>>> +
>>> +      cell 4: ASEL value for the channel
>>> +
>>> +  interrupt-map-mask:
>>> +    items:
>>> +      - const: 0x7ff
>>> +
>>> +  interrupt-map:
>>> +    description: |
>>> +      Maps internal BCDMA channel IDs to the parent GIC IRQ lines.
>> Isn't this mapping fixed in given device? IOW, not really part of DTS
>> description but deducible from the compatible.
>>
>> You only need to provide interrupts for your device.
> 
> I initially considered handling the mapping in the driver based on the
> 
> compatible string, but discussing the hardware architecture internally,
> 
> that approach becomes highly problematic for this IP block.
> 
> 
> While the mapping is fixed for the AM62L specifically, this same BCDMA V2
> 
> IP block is reused across different K3 SoCs, and the internal
> 
> channel-to-IRQ wiring changes entirely from SoC to SoC. Furthermore, the
> 
> mapping of internal channels to the parent GIC interrupts is discontiguous
> 
> (and the hardware IP itself supports mapping multiple DMA channels to a
> 
> single shared IRQ line, depending on the SoC integration).
> 
> 
> If we rely on the driver to deduce this via the compatible string, we will
> 
> have to maintain large, discontiguous mapping tables inside the driver
> 
> code for every new SoC that integrates this IP.

And why maintaining exactly same mapping in DTS is okay? What's entirely
deducible from the compatible does not belong to the DTS.

> 
> 
> Because the IP is essentially routing its internal channel events to a
> 
> different set of parent IRQs (which varies per SoC integration), using
> 
> interrupt-map allows us to accurately describe the specific SoC's wiring
> 
> purely in the DT. This keeps the driver clean and easily reusable for
> 
> future K3 SoCs without creeping hardware routing tables into the driver
> 
> code.


All of this is difficult to read. Fix your email client please. I just
skimmed through it, not going to force my brain to work with broken
formatting. Make it easy for reviewers to discuss your patches... if
not, then silence and no ack.

Best regards,
Krzysztof

