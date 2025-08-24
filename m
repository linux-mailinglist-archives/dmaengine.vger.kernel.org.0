Return-Path: <dmaengine+bounces-6187-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C61B32F5C
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 13:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896D11B62D99
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD802D59E3;
	Sun, 24 Aug 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbFQk76l"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238629D0E;
	Sun, 24 Aug 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034648; cv=none; b=BL4MwpMjSmOGL5PQX8pi1Luh1smCvv/XXCpnFaW4yvW4L/vTYqg7nOmHqQlz69ccCy2oFwBKVAirLwxNqHOD8/HEmr0ocZRvXJJ5WVwM/Ck6HvGeIB5TFUcXVu9ltBIOz5ZvQwhAG5Y+kzn8sDfcl2oKH3mVRscTQ5psSkMNsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034648; c=relaxed/simple;
	bh=t9BcqUjMupBLwjDS1XcQiUoTtCSx25XWIEN3xv6mkfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/LTLG/Arypxzb4O8QqYk60+uvLXoezA8WNmKT2b3aJognt8q3o2xIWFMsGMzS0vzzdgmd6jGRSOAITqquIXoxTzuI65XdJOi5frBtwpuPAve6YicCF5gX7gsZYFouiZmdxLqgsSgqnpp8uXB92qtAZXLJp4LGrbz6agskQyPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbFQk76l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4464C4CEED;
	Sun, 24 Aug 2025 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756034647;
	bh=t9BcqUjMupBLwjDS1XcQiUoTtCSx25XWIEN3xv6mkfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kbFQk76lP7NWpdFedpxd+xoNZ45UtQKHEC/Ka3QcPK/ySM+zo7/FqRscmPc5hmCRj
	 ZZCUizyvYeUpZUS0LioRhIWM5K/7w1dacMegUZI6W0UvEdLN39m5SheeeTPzDWxq/D
	 wp+U73Q+ffHP4PATNBp5D25yODM+shxs8kbnhxfF3Zr0W9OuBQvzTh9pXvxlx21d+n
	 9CxmNqNLu41FwPYruFrYZW0bCU9b9+sjsnaH6uoxUeYzcYFzHWsHrPKiQ4rRou1Ykp
	 GgMwLdhgQ46BxMRKwSWtYKCJHHszTQwQNoH2L5jOcn7SiyEhaKW/o8EsW+2Ea6K/K5
	 Ct+w+QwRNHO4w==
Message-ID: <b748f86f-68ee-47fd-8394-f6352f99f3f0@kernel.org>
Date: Sun, 24 Aug 2025 13:24:02 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: dma: img-mdc-dma: convert to DT schema
To: Nino Zhang <ninozhang001@gmail.com>, devicetree@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, rahulbedarkar89@gmail.com, linux-mips@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821150255.236884-1-ninozhang001@gmail.com>
 <20250824034509.445743-1-ninozhang001@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250824034509.445743-1-ninozhang001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/08/2025 05:45, Nino Zhang wrote:
> Convert the img-mdc-dma binding from txt to YAML schema.
> No functional changes except dropping the consumer node
> (spi@18100f00) from the example, which belongs to the
> consumer binding instead.
> 
> Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
> ---
> Changes since v1:
> - All review comments addressed.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> 
> Open:
> - Maintainers: set to Rahul Bedarkar + linux-mips per MAINTAINERS entry
>   for Pistachio/CI40 device tree. This seems the closest match to the
>   hardware. Happy to adjust if platform maintainers suggest otherwise.
> - img,max-burst-multiplier: defined as uint32. A minimum of 1 is used to
>   exclude the invalid case of 0, but the actual supported range has not
>   been confirmed in available documentation. Example uses 16. A maximum
>   will be added once confirmed by platform maintainers or hardware docs.
> 
>  .../bindings/dma/img,pistachio-mdc-dma.yaml   | 90 +++++++++++++++++++
>  .../devicetree/bindings/dma/img-mdc-dma.txt   | 57 ------------
>  2 files changed, 90 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
> new file mode 100644
> index 000000000000..4dde54a17f52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/img,pistachio-mdc-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IMG Multi-threaded DMA Controller (MDC)
> +
> +maintainers:
> +  - Rahul Bedarkar <rahulbedarkar89@gmail.com>
> +  - linux-mips@vger.kernel.org
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: img,pistachio-mdc-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 32

Why is this flexible?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: sys
> +
> +  img,cr-periph:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >

Drop >

You already got exactly the same comment.


> +      Phandle to peripheral control syscon node with DMA request to channel
> +      mapping registers.
> +
> +  img,max-burst-multiplier:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1

Does not feel like enough of constraints.

> +    description: >
> +      Maximum supported burst size multiplier. The maximum burst size is this
> +      value multiplied by the hardware-reported bus width.
> +
> +  "#dma-cells":
> +    const: 3
> +    description: |
> +      DMA specifier cells:
> +        1: peripheral's DMA request line
> +        2: channel bitmap: bit N set indicates channel N is usable
> +        3: thread ID to be used by the channel
> +
> +  dma-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32

More ignored comments.

Please go back to previous posting and respond to each comment. Then
implement each one or keep discussing.

Best regards,
Krzysztof

