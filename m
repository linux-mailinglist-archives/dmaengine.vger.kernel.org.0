Return-Path: <dmaengine+bounces-2112-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B678CA9E7
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BF5B2140A
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4053E3D;
	Tue, 21 May 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeAtIO/I"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2D54777;
	Tue, 21 May 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280015; cv=none; b=SWmJn9d1LxL+P1IJ5xz6WwYXaHCxfGhtlWxKzyE+X+4qdtdsTeMkNR/9E72Ye9Mz5RTRLHhjhorKw2lVPyIWdPYAevkw9r6Fq/IwuRjWOn1yCZ9iBQxpgcM4i9c3O/U8wibbWreHQoXAL5K1XWG5e3MjBgG9AVM9Z3hu1z1ey80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280015; c=relaxed/simple;
	bh=tv6yy5kHc6AAE39BqUVHJ2LFtdoFuzOvYG6HtKaB4Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yh0j8Tkg2EKoTXI7+AMw2vQ1QY6A12ffUeWF+4SVsMiHjXNjHmeFug1p1BGr5VwlBQuMm0u35EV1QNG4Fa07pWkT00PtagX/CY1Mp/vUujrngEUmHyEO3qDwnaIfXbZl3UfPH+jh2OV5jxvos4N8hgA0XVM4o5z7iZCOvV9u23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeAtIO/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B9CC2BD11;
	Tue, 21 May 2024 08:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716280014;
	bh=tv6yy5kHc6AAE39BqUVHJ2LFtdoFuzOvYG6HtKaB4Pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DeAtIO/IMKUgSJl2VhFPZMh2EPp+bLNHxDBVjluZ+tQeUif3WB/9HJvhdNwNKKnPk
	 K3Nb17yJHuMjwnV6MRjnKCOxTLlW4Z01tbjHf8v6/f+ZH6XtQhNAy79rL+YbRDnh+4
	 MC4ZYfWDuEq8SSlgJudgRA/ZzFDWYEridFAPzhuulzP35UEwi75Ahx0v27RKFoP1/q
	 iiDUQ40YzFR9JXX584cyYVpyRfc1622rzORW+FaFFFrV49x0jh6j5e/h8is80uL777
	 qQMaaEOjOyveietda0tsTrA+UHZvDtsGCRePJUngawYvLhs3UCjJ3t/STdZb64Fxvk
	 Rx5NQmww9FVgw==
Message-ID: <8a0e5863-27f7-47e4-9325-a686d5adffec@kernel.org>
Date: Tue, 21 May 2024 10:26:48 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: fsl-qdma: Convert to yaml format
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240520203907.749347-1-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240520203907.749347-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2024 22:39, Frank Li wrote:
> Convert binding doc from txt to yaml.
> 
> Re-order interrupt-names to align example.


> +properties:
> +  compatible:
> +    enum:
> +      - fsl,ls1021a-qdma
> +      - fsl,ls1028a-qdma
> +      - fsl,ls1043a-qdma
> +      - fsl,ls1046a-qdma
> +
> +  reg:
> +    items:
> +      - description: Controller regs
> +      - description: Status regs
> +      - description: Block regs
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 5
> +
> +  interrupt-names:
> +    minItems: 2
> +    items:
> +      - const: qdma-error
> +      - const: qdma-queue0
> +      - const: qdma-queue1
> +      - const: qdma-queue2
> +      - const: qdma-queue3
> +
> +  dma-channels:
> +    minItems: 1
> +    maxItems: 64

That's not a list. Did you just copy buggy fsl-edma?

> +
> +  fsl,dma-queues:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Should contain number of queues supported.

Constraints?

> +
> +  block-number:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: the virtual block number
> +
> +  block-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: the offset of different virtual block
> +
> +  status-sizes:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: status queue size of per virtual block
> +
> +  queue-sizes:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      command queue size of per virtual block, the size number
> +      based on queues
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present registers and hardware scatter/gather descriptors
> +      of the qDMA are implemented in big endian mode, otherwise in little
> +      mode.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - fsl,dma-queues
> +  - block-number
> +  - block-offset
> +  - status-sizes
> +  - queue-sizes
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: dma-controller.yaml#

This goes above unevaluatedProperties.

Please constrain interrupts per variant.


Best regards,
Krzysztof


