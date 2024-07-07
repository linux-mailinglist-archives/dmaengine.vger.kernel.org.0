Return-Path: <dmaengine+bounces-2647-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A29297D5
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jul 2024 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A985B1C209E3
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jul 2024 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1981CD32;
	Sun,  7 Jul 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTLBD2KL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A41CD00;
	Sun,  7 Jul 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720356185; cv=none; b=GQfDMTOAz4MISpD7SX2NFTXW4HEoL8Mzee7p/gwmL2FqfA/sBFA353KbntncO7+d4wcaf26zh1UkYbTBy/YN9hHoc5cmvaJdBaN1AX5yi1a2Bk4cxXTIhc0SRN/fk+30DFDJkGrLqXIVMVf68cqy/y45Mp+iblxUJNXt+HnkS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720356185; c=relaxed/simple;
	bh=dlU6ZwxMDTR7FRLnhiLzmeaWHsDmk2u8PeU97jG5du8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsemwTHodFXR5MTNUssYihUd6/TSjm/rlS+4070Kqr+CSJY54sFY37LDFaaZrTSsdufe4pAfPwARDgb/0ZGGd0U6MgKawDkt8pnBagfhoPhC6Vs3Oqdz5+GNemWc2YtjTup3vq42vzl/Inq0JirdHMces6Ei/6RSkxCcAKHW6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTLBD2KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04444C4AF07;
	Sun,  7 Jul 2024 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720356184;
	bh=dlU6ZwxMDTR7FRLnhiLzmeaWHsDmk2u8PeU97jG5du8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GTLBD2KLl4YeuoLBpH6OnjEKYMlTptTEkoLcw7/141+T17ltNhsYeiGaFJzuIlDN2
	 vSZrAa13c7V/acq1JSyZ6SoQ5Lmh7bUAlFWV5LyLDB5LkRnvqdH+rhqsFkIeFq+Zvo
	 +fQQ+hDeun2oDbfZBheOZTur0Lm+nyvh0BYjL/smWJDqUYEDS2sc13ifJv6Pd19uHa
	 LhAg4YrD6VV3TkNopGNymXHm2vpFxf+3LG6z/b/QapYOba3hL8G8d590HrxnhLkVGz
	 SYPadMPiDr5p/pqjB0HeWqjwSQX39iGmIYuihLJchbZ0jvjjPaORoA/JMPqRAk36/y
	 okvLQxj/DjfGQ==
Message-ID: <f452408f-2ec3-4893-b287-157579d5e48a@kernel.org>
Date: Sun, 7 Jul 2024 14:42:58 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: dma: mv-xor-v2: Convert to dtschema
To: Shresth Prasad <shresthprasad7@gmail.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, hdegoede@redhat.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240707091331.127520-3-shresthprasad7@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240707091331.127520-3-shresthprasad7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2024 11:13, Shresth Prasad wrote:
> Convert txt bindings of Marvell XOR v2 engines to dtschema to allow
> for validation.
> 
> Also add missing property `dma-coherent` as `drivers/dma/mv_xor_v2.c`
> calls various dma-coherent memory functions.
> 
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Changes in v2:
>     - Update commit message to indicate addition of `dma-coherent`
>     - Change maintainer
>     - Change compatible section
>     - Add `minItems` to `clock-names`
>     - Remove "location and length" from reg description
>     - List out `clock-names` items in `if:`
>     - Create two variants of `if:`
> 
> Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mochabin.dtb`
> and `marvell/armada-8080-db.dtb`
> 
>  .../bindings/dma/marvell,xor-v2.yaml          | 86 +++++++++++++++++++
>  .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 ------
>  2 files changed, 86 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
> new file mode 100644
> index 000000000000..da58f6e0feab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/marvell,xor-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell XOR v2 engines
> +
> +maintainers:
> +  - Hans de Goede <hdegoede@redhat.com>

I don't think Hans maintains this platform - Marvell SoCs. Didn't we
talk already what is "platform"?


> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: marvell,xor-v2
> +      - items:
> +          - enum:
> +              - marvell,armada-7k-xor
> +          - const: marvell,xor-v2
> +

> +
> +allOf:
> +  - if:
> +      properties:
> +        clocks:
> +          maxItems: 1

Still not much improved. There are plenty of examples how this is done,
so please do not invent one, entirely new style. Think for a sec, why
doing things differently? Why this code is the first example of such syntax?

I asked to limit it pear each variant.

https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132



> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +  - if:
> +      properties:
> +        clocks:
> +          minItems: 2
> +      required:
> +        - clocks
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: reg
> +      required:
> +        - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xor0@6a0000 {

xor@6a0000

Best regards,
Krzysztof


