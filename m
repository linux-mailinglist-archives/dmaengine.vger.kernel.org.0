Return-Path: <dmaengine+bounces-9148-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB3VAXpioWnIsQQAu9opvQ
	(envelope-from <dmaengine+bounces-9148-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 10:23:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1171B53C1
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 10:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286DD3079B8C
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC40364930;
	Fri, 27 Feb 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N00Hr+qT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296122D4B40;
	Fri, 27 Feb 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183922; cv=none; b=OGklkzkTTYOSGvBQfk7HW3iKl9NLgsZaRyObKxGlIbRxwrqmXsA1f3IxZQj43qIGapyLW9NjeVyagj4pOUZ0Q74nyxDUhS79D19vwGMRBk3rX9u98bRcyeqFAfNjcGOdI/r0BbevY/aSgNQV7yYRltFKnDtpeAzJ8GpI9N1lWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183922; c=relaxed/simple;
	bh=tiOquXN+Z2n7DVUsWeoujnFyOYIp0Oz9W9Dq52IUj30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGzFovWCNEnWaVapbYBorT73EWsX4yFUlM8vRY3K0moED6NHaghgf5781M+yeHMrW1qpUO5UT5hok2JtKSgiU0lPES8hS/wyEF/mz7OCLUE/MYYwivG5zGgqO/qotiU6oRYuScAXifsOYWxhCCEdSJavSKbaKr9WJX9Vo2IiRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N00Hr+qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A56C116C6;
	Fri, 27 Feb 2026 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772183921;
	bh=tiOquXN+Z2n7DVUsWeoujnFyOYIp0Oz9W9Dq52IUj30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N00Hr+qT1p3/4l0FSOCPGBOhwYAqyLTzuSj7hvaFsKLwgUgPf8H2LkdERoSCvNWqU
	 lGau7hW3v+4PA9jTmb8/sdnLNc7aOa/OPeBiSWvq6UswBw1yh0o0rR6j45FRaX4hrW
	 6I439fWLHyHHfbYRdZ0yvjdW7K6vyk2rS0DLKMYr2AXxq63IgCL4BEbNti4SsrjCjB
	 mA4E02f8KpVD1j6bUVOqRRrKra5C04f/WDf3CUDb4dNgIO8TSKztmxDGaHeAvAlCrP
	 8O5wUUVWIzHpVgZOEKzqCAw7oMP2h/plwjypo35eiIlhIu3CO+aiFE1l3C5/v7GDf2
	 1Mg6RMWr77HWQ==
Date: Fri, 27 Feb 2026 10:18:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Message-ID: <20260227-crafty-just-cheetah-7ef8a2@quoll>
References: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
 <20260227-amlogic-dma-v4-1-f25e4614e9b7@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260227-amlogic-dma-v4-1-f25e4614e9b7@amlogic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9148-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amlogic.com:email,fe400000:email]
X-Rspamd-Queue-Id: 9A1171B53C1
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:20:53AM +0000, Xianwei Zhao wrote:
> Add documentation describing the Amlogic A9 SoC DMA. And add
> the properties specific values defines into a new include file.
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 65 ++++++++++++++++=
++++++
>  include/dt-bindings/dma/amlogic-dma.h              |  8 +++
>  2 files changed, 73 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/=
Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> new file mode 100644
> index 000000000000..efd7b2602c33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic general DMA controller
> +
> +description:
> +  This is a general-purpose peripheral DMA controller. It currently supp=
orts
> +  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and r=
eceive
> +  for the same peripheral use two separate channels, controlled by diffe=
rent
> +  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
> +  CAN-BUS transfer data in 4-byte units. From the controller=E2=80=99s p=
erspective,
> +  there is no significant difference.
> +
> +maintainers:
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a9-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: sys
> +
> +  '#dma-cells':
> +    const: 2
> +
> +  dma-channels:
> +    maximum: 64
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    dma-controller@fe400000{
> +        compatible =3D "amlogic,a9-dma";
> +        reg =3D <0xfe400000 0x4000>;
> +        interrupts =3D <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +        clocks =3D <&clkc 45>;
> +        #dma-cells =3D <2>;
> +        dma-channels =3D <28>;
> +    };
> diff --git a/include/dt-bindings/dma/amlogic-dma.h b/include/dt-bindings/=
dma/amlogic-dma.h

Filename must be the same as binding file.

> new file mode 100644
> index 000000000000..025ecc42e395
> --- /dev/null
> +++ b/include/dt-bindings/dma/amlogic-dma.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> +
> +#define AML_DMA_TYPE_TX		0
> +#define AML_DMA_TYPE_RX		1

You sure you need AML prefix? Your clock constants do not have AML
prefixes. What other constants do you expect here?

Best regards,
Krzysztof


