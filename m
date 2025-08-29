Return-Path: <dmaengine+bounces-6285-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8DB3B4C7
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 09:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E1DA0029B
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C0285412;
	Fri, 29 Aug 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRld4nrX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662628507E;
	Fri, 29 Aug 2025 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454027; cv=none; b=l0m7/bvBrIOBk+0hn5DRXCEbRaTukXSeYkT6KkMTYSBrUijqRx3fKapIjOhUs4rUfS9ydSv2HRLrPv7t5N32DRJexQVJj2zr+bfxtIbnlAeyw0pnaNchV/up6+X6fhwCTQvV+gS3Sw/1xdVbUB6p7wBzzOpSTcLVo3JXvrDU3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454027; c=relaxed/simple;
	bh=T08v851Q2crHdE5uCS95kO54ArUzsuo7GpEza0t3CRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi8zS+h8OBIBw6vBdEZCG5FzYgbBX2UEMVMtnOBjbeYb5d2gSnvKmcxjmvnfwUSt91ZAb5zalqeW531bGHpMIp7HQ8/ZPnGoZ8CrmH6nesojlGKEeUmr+iipRQQhGik/Cc1ESzXEKSx92huwUfO90EAlkf8y2PIgCyPDSPswgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRld4nrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE117C4CEF0;
	Fri, 29 Aug 2025 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756454026;
	bh=T08v851Q2crHdE5uCS95kO54ArUzsuo7GpEza0t3CRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRld4nrX3VpK7Gv76nwsR16PaFiM0vmCCIUU1zJ1XeVJPa9EpH4YyrHKWvbLp6Rtj
	 eWwpj9xjmEqG8CyUtY2tcHvqrdS4phxUBh/w0h3Ik8+s0X8/3uFWN4zd14LS/N9sLe
	 kVoaGj4dp3Z14YR6CLFo7cma8GSI34LpZibVDOoOsO3v0INm69ZYtCPUW7FuP5jOv6
	 YkNJD8uNn6QvLYLqo3DsYbeXCYyDjH8gEdnBD4lJvLHm+t1DcsTPqmZONwGFZKHs7c
	 KOtEpfF+m5zUHeJXN37IKu8iOQ+pff0JdE5OyoZo5r1QTED/qwEALO2VGQtz82UxRl
	 qQuZUrSr2k+hA==
Date: Fri, 29 Aug 2025 09:53:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nino Zhang <ninozhang001@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, vkoul@kernel.org, rahulbedarkar89@gmail.com, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: dma: img-mdc-dma: convert to DT schema
Message-ID: <20250829-peculiar-pug-of-argument-1bfec0@kuoka>
References: <20250825074141.560141-1-ninozhang001@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825074141.560141-1-ninozhang001@gmail.com>

On Mon, Aug 25, 2025 at 03:41:41PM +0800, Nino Zhang wrote:
> Convert the img-mdc-dma binding from txt to YAML schema.
> No functional changes except dropping the consumer node
> (spi@18100f00) from the example, which belongs to the
> consumer binding instead.
> 
> Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
> ---
> v2 -> v3:
> - Fix remaining issues based on Rob's and Krzysztof's comments.

That's vague. What exactly did you change?

Especially that this is not true. You never responded to comments, never
implemented them.

> - Link to v2: https://lore.kernel.org/all/20250824034509.445743-1-ninozhang001@gmail.com/
> 
> v1 -> v2:
> - Addressed review comments from Rob.
> - Link to v1: https://lore.kernel.org/all/20250821150255.236884-1-ninozhang001@gmail.com/
> 
>  .../bindings/dma/img,pistachio-mdc-dma.yaml   | 89 +++++++++++++++++++
>  .../devicetree/bindings/dma/img-mdc-dma.txt   | 57 ------------
>  2 files changed, 89 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
> new file mode 100644
> index 000000000000..198e80b528c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/img,pistachio-mdc-dma.yaml
> @@ -0,0 +1,89 @@
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

Nothing improved, so with vague commit msg it means you just ignored my
comment.

Best regards,
Krzysztof


