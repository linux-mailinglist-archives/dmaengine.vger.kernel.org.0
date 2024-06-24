Return-Path: <dmaengine+bounces-2528-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953B914817
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 13:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04441B242C5
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7397137773;
	Mon, 24 Jun 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IszAkwdQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8523136663;
	Mon, 24 Jun 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227330; cv=none; b=St4W05IfLmV4gitYVz7V+5fQrxhGmYH5FR0+MlkvW5T9AXfcj13rfgvW768UIEuS0MhllMAjZvxy5biXtQq0pu/oGv+ug0sGPPwwlMNLBSj7iERtga+XZ2udAP4RG/GzbekZHAQglqybZs4ZIy7gicW1W6u51/+tRG1ODVV9sRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227330; c=relaxed/simple;
	bh=mV4YjmH7D2/JZFK+5HhHPapGgeMTzfYtMa0o2NSuqYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVNOJjl2E8sPhiOe01fQYLqfMbLTphA0gY0t1a48R4UISScV5/qYSrKoxf9+DaYOO6h38ZUIltche+V9KvRGbAme5/dL00hhlID0l/gbHQ0D4e+Nu5EbVaUM6BtB6g/uMzAW67AO3Dx5TluoXJCUkp7nM5nDhwwazI8gYV2dzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IszAkwdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFFCC32786;
	Mon, 24 Jun 2024 11:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719227330;
	bh=mV4YjmH7D2/JZFK+5HhHPapGgeMTzfYtMa0o2NSuqYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IszAkwdQ9jiaPKhyDw2sY4+HZyHzqaGDkWi0SoiCrH23vmZZwMkJfkPvLFtZpQ2uV
	 IEBWNJ0jqU/NBUuUYNr+1o5Kvz4TG8mH5sDg8cYdOpWHhLQuO+cqR4XgTHhDqy9uyF
	 Dkwvo97ZbneULZIVftfyo97fd6ulWBBVOhFIICoz408Omi33azrkKCUjDTNkvgz08+
	 JqZxHHGKviyzxh1V89NpXQRA3UwoS9JQAbH+iEh6IlV/Yk45lEK74w1BrT7sS8bHxi
	 jekUTzZrzP2rYMbCy0xEg11nNCwKlTm+vtNTOrKRathVMu+zFguFMivMbt/qFn/GVN
	 FC6yLz1uXHdCA==
Message-ID: <93a7e063-02bb-4052-a3ed-a543a038c3ba@kernel.org>
Date: Mon, 24 Jun 2024 13:08:43 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: mv-xor-v2: Convert to dtschema
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240623124507.27297-2-shresthprasad7@gmail.com>
 <62c05c34-0b69-4091-8c3a-d0b8befa9150@kernel.org>
 <CAE8VWiLXS1gsxjk7aK335QtZJk7Se+k5VsFzmUpQHfaVJnKa7g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAE8VWiLXS1gsxjk7aK335QtZJk7Se+k5VsFzmUpQHfaVJnKa7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/06/2024 12:14, Shresth Prasad wrote:
> On Mon, Jun 24, 2024 at 10:47 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 23/06/2024 14:45, Shresth Prasad wrote:
>>> Convert txt bindings of Marvell XOR v2 engines to dtschema to allow
>>> for validation.
>>>
>>> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
>>> ---
>>> Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mochabin.dtb`
>>> and `marvell/armada-8080-db.dtb`
>>>
>>>  .../bindings/dma/marvell,xor-v2.yaml          | 69 +++++++++++++++++++
>>>  .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 --------
>>>  2 files changed, 69 insertions(+), 28 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
>>> new file mode 100644
>>> index 000000000000..3d7481c1917e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
>>> @@ -0,0 +1,69 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/dma/marvell,xor-v2.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Marvell XOR v2 engines
>>> +
>>> +maintainers:
>>> +  - Vinod Koul <vkoul@kernel.org>
>>
>> Should be rather platform maintainer.
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    contains:
>>
>> This cannot be unspecific. Drop contains.
>>
>>> +      enum:
>>> +        - marvell,armada-7k-xor
>>> +        - marvell,xor-v2
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: DMA registers location and length
>>> +      - description: global registers location and length
>>
>> Drop "location and length", redundant.
>>
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: core
>>> +      - const: reg
>>
>> This does not match number of items in clocks:
> 
> I'm not sure what you mean, the original txt stated that `clock-names`
> is only required if there are two `clocks`.

Exactly. It said "required", not "disallowed for 1 clock case". You
basically made it impossible to use for one case, so standard reply:
these should be always in sync.

> 
>>
>>> +
>>> +  msi-parent:
>>> +    description:
>>> +      Phandle to the MSI-capable interrupt controller used for
>>> +      interrupts.
>>> +    maxItems: 1
>>> +
>>> +  dma-coherent: true
>>
>> This was not present in the binding and commit msg did not explain why
>> this is needed. Are devices really DMA coherent?
> 
> Sorry about that, I added this because all the nodes I looked at
> contained `dma-coherent`.
> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - msi-parent
>>> +  - dma-coherent
>>> +
>>> +if:
>>
>> Put it under allOf: in this place.
>>
>>> +  required:
>>> +    - clocks
>>
>> This does not work and does not make much sense. Probably you want to
>> list the items per variant?
>>
>>
>>> +  properties:
>>> +    clocks:
>>> +      minItems: 2
>>> +      maxItems: 2
>>
>> Instead list and describe the items.
>>
> 
> I did it this way to allow for `clock-names` to only be required if there
> are two `clocks` present. Is there another way I should be doing this?

Why number of clocks would mean you need clock-names? Why does it
matter? If the driver is taking second clock by name, it does not mean
second clock name can be anything for other cases.


Best regards,
Krzysztof


