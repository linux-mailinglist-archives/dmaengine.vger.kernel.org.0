Return-Path: <dmaengine+bounces-8863-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gETCHhagimniMQAAu9opvQ
	(envelope-from <dmaengine+bounces-8863-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 04:03:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42505116A65
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 04:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7951300D351
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 03:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385882405ED;
	Tue, 10 Feb 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z234Tp5o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151671DFD8B;
	Tue, 10 Feb 2026 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692628; cv=none; b=Kod/HXwW1eiFIBijEEMA4X7qJJPjamBJ5D1kRY5+H1uB27KNzANDpM4rZoK2iqaoh5M+Pclr+XYa5K7nmEmFoWkTNGxM820vsnxxRO99P/lxjzAVnSqKO+ICjkQvCD3aKvVMhVWjdg1cZMizeLNBJU1jrRMJ/cgQO70xM/IGi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692628; c=relaxed/simple;
	bh=Ziwr30Sqv8i8Ofwg51QM0PFJ/lbd/e4xlTc1cL1yNEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGmbEiEcrj9LtifDiMHLl7BX93TJGK29JiNwnOSctiTaDjtYFMZourOpCGw9UojvmeVdE3sBYbg5UNQewzj3WL2BTJMQb0IYkAB76n51ceT2Eld2jhF2N8F5vQvhoocdW18ruQEplRCySd+Aj2u5bL6NjFYS0pzF4+b7J6XlqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z234Tp5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77197C116C6;
	Tue, 10 Feb 2026 03:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770692627;
	bh=Ziwr30Sqv8i8Ofwg51QM0PFJ/lbd/e4xlTc1cL1yNEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z234Tp5odMkrUm1sOJqcAc1XO8dkTdcXD4KlV+tae3EmY02ev+V0fNbB7te4dPloU
	 pAPp5Fs8ziX5CwYZc2WeTvEI5yjdnz4aTIwISf6YEq7kRtx8bO8rQi+AFMHj5nP+DK
	 fb6NzMD5fODAZWlPysjLn4gjbXrAjQGlZtTVJr/b/68cPPlveC9TseC7x3n2wOoLCm
	 0O8mUX7Q1Zt+f4QRiUL4+Mto1mnmDfOdkRkYHhENvXxZDaoA5EDZRuZRTD7ZJT0ruq
	 sJF+p0R4GVx24LdeQqghFw/A5kmdTgZrBiteob1neyQcyhDJsN3LfzPB1uVCxxLyRj
	 DjzQ/f29/nLJQ==
Date: Mon, 9 Feb 2026 21:03:46 -0600
From: Rob Herring <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org, jeffbai@aosc.io
Subject: Re: [PATCH v2 3/4] dt-bindings: dmaengine: Add Loongson
 Multi-Channel DMA controller
Message-ID: <20260210030346.GA2406064-robh@kernel.org>
References: <cover.1770605931.git.zhoubinbin@loongson.cn>
 <36cc977f0746095196354b631f0b158365208a0e.1770605931.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36cc977f0746095196354b631f0b158365208a0e.1770605931.git.zhoubinbin@loongson.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,aosc.io];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8863-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 42505116A65
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:04:20AM +0800, Binbin Zhou wrote:
> The Loongson-2K0300/Loongson-2K3000 have built-in multi-channel DMA
> controllers, which are similar except for some of the register offsets
> and number of channels.
> 
> Obviously, this is quite different from the APB DMA controller used in
> the Loongson-2K0500/Loongson-2K1000, such as the latter being a
> single-channel DMA controller.
> 
> To avoid cluttering a single dt-binding file, add a new yaml file.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/dma/loongson,ls2k0300-dma.yaml   | 78 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> new file mode 100644
> index 000000000000..77e5df47ec01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/loongson,ls2k0300-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Looongson-2 Multi-Channel DMA controller
> +
> +description:
> +  The Loongson-2 Multi-Channel DMA controller is used for transferring data
> +  between system memory and the peripherals on the APB bus.
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k0300-dma
> +      - loongson,ls2k3000-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 4
> +    maxItems: 8

I'm assuming this is 1 interrupt per channel? If so, add a description 
saying that.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 2
> +    description: |
> +      DMA request from clients consists of 2 cells:
> +        1. Channel index
> +        2. Transfer request factor number, If no transfer factor, use 0.
> +           The number is SoC-specific, and this should be specified with
> +           relation to the device to use the DMA controller.
> +
> +  dma-channels:
> +    enum: [4, 8]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +
> +    dma-controller@1612c000 {
> +        compatible = "loongson,ls2k0300-dma";
> +        reg = <0x1612c000 0xff>;
> +        interrupt-parent = <&liointc0>;
> +        interrupts = <23 IRQ_TYPE_LEVEL_HIGH>,
> +                     <24 IRQ_TYPE_LEVEL_HIGH>,
> +                     <25 IRQ_TYPE_LEVEL_HIGH>,
> +                     <26 IRQ_TYPE_LEVEL_HIGH>,
> +                     <27 IRQ_TYPE_LEVEL_HIGH>,
> +                     <28 IRQ_TYPE_LEVEL_HIGH>,
> +                     <29 IRQ_TYPE_LEVEL_HIGH>,
> +                     <30 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk LS2K0300_CLK_APB_GATE>;
> +        #dma-cells = <2>;
> +        dma-channels = <8>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27f77b68d596..d3cb541aee2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14772,10 +14772,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>  F:	drivers/gpio/gpio-loongson-64bit.c
>  
> -LOONGSON-2 APB DMA DRIVER
> +LOONGSON-2 DMA DRIVER
>  M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
>  F:	drivers/dma/loongson/loongson2-apb-dma.c
>  
> -- 
> 2.52.0
> 

