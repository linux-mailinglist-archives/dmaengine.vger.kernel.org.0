Return-Path: <dmaengine+bounces-11799-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 51eiGHgTPmpK/ggAu9opvQ
	(envelope-from <dmaengine+bounces-11799-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:51:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC36CA806
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:51:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lfjnuEid;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11799-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11799-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6A43055D70
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A559D3CD8C5;
	Fri, 26 Jun 2026 05:50:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069653CAE7F;
	Fri, 26 Jun 2026 05:50:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453045; cv=none; b=HfJFJAyPREd4/5tRBcA2S9ns8/Qxm21qPjdbaHLlIbgzGwB44nztY3kkohAZ9T5bzzAhKrjEzsHSQ9KllVBltciRFu8jaTfOB5y+AhXswvN6IMs9rPW0m0CyFSm4yNylPLmEEqewMZReUVCx5GZoustfqqCk24W//bCK/2vJU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453045; c=relaxed/simple;
	bh=BP6o0ae/B0exO8m91oeCU4rd8de0HLBfgYtGzgId+1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fjldxw96JLVabNGEVqa3JkPNRRBl7MXP5PqvI001NDLjn9W8JTOU1WDGOK+5vpxULb77XYEmKxtMSYHYYuYabBPE2d5h4dAR5b+qZG8tiB8YmhjD04NqjJIFrn0PEdUCk1tad5jeRtws9OIRpyBI8XBLR8DnQh2piHrF8Z618tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfjnuEid; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061BD1F000E9;
	Fri, 26 Jun 2026 05:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782453033;
	bh=fpqguDEqtAYjCGwIjtf7qbbFYvPiXQsaNg2WmGUEkWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lfjnuEidXn2ukIdD7bnTLw2mDS+HxiUP5ADnYTRfDFK1ENv7TV+pRu7A6aYO7bAng
	 elT3Sh1yQxIXWNj5mXbJUm0MDdc2txsoVfJ9+0D1pZ4JKFMBUH+EdTGyWC6Zy53PJJ
	 ioAJBBDnyDC2PvjeeLt3HLPlRQwDATv2xY4mq4k9Z85Dfb7e9d85/OwsGfIoQ05VR8
	 O7IJkuiJYcuE+ZkerdGuly7FNJuowMeR8q7yTTgWdG+R3Q43H+z4IMCg34RGviEYw9
	 DRKED1/T6Pzlh3KXMw9hYLz7a5mn3FP3dVAvCnzedsQYtVj0B0zZsypVLGDrc7gzm5
	 3g2d/ywstPjOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao via B4 Relay" <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Frank.Li@kernel.org, robh@kernel.org, neil.armstrong@linaro.org, conor+dt@kernel.org, vkoul@kernel.org, linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260626-amlogic-dma-v9-1-558d672c4a95@amlogic.com>
References: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
 <20260626-amlogic-dma-v9-1-558d672c4a95@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:50:32 +0000
Message-Id: <20260626055033.061BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11799-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+xianwei.zhao.amlogic.com@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:neil.armstrong@linaro.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:devnull@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,amlogic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEBC36CA806

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Global dt-binding header defines generic 'DMA_TX' and 'DMA_RX' macr=
os, risking namespace collisions.
- [Low] The `#dma-cells` property lacks a description explaining the layout=
 and purpose of its 2 cells.
- [Low] Missing space before the opening brace in the device tree example n=
ode.
--

commit a7b4f5e4e6207e7134f0b399abc853db92908381
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>

dt-bindings: dma: Add Amlogic A9 SoC DMA

This commit adds device tree binding documentation for the Amlogic A9 SoC
general-purpose DMA controller. It also introduces a new header file contai=
ning
specific property values for this controller.

> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/=
Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> new file mode 100644
> index 0000000000000..efd7b2602c336
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml

[ ... ]

> @@ -0,0 +1,65 @@
> +properties:
> +  compatible:
> +    const: amlogic,a9-dma

[ ... ]

> +  clock-names:
> +    const: sys
> +
> +  '#dma-cells':
> +    const: 2

[Severity: Low]
Is a description needed for this `#dma-cells` property to explain the layout
and purpose of its 2 cells? Without it, device tree writers won't have
documentation clarifying which cell represents the channel ID and which
represents the direction.

> +
> +  dma-channels:
> +    maximum: 64

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    dma-controller@fe400000{

[Severity: Low]
This isn't a bug, but should there be a space before the opening brace here?
Normally it is formatted as `dma-controller@fe400000 {`.

> +        compatible =3D "amlogic,a9-dma";
> +        reg =3D <0xfe400000 0x4000>;
> +        interrupts =3D <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +        clocks =3D <&clkc 45>;
> +        #dma-cells =3D <2>;
> +        dma-channels =3D <28>;
> +    };
> diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindin=
gs/dma/amlogic,a9-dma.h
> new file mode 100644
> index 0000000000000..c59c2fd4b9561
> --- /dev/null
> +++ b/include/dt-bindings/dma/amlogic,a9-dma.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> +
> +#define DMA_TX			0
> +#define DMA_RX			1

[Severity: Low]
Could these macro names lead to namespace collisions since they lack a vend=
or
or SoC prefix? These names are already widely used across the kernel, and
defining them generically in a global dt-bindings header might cause
preprocessor collisions and build failures for any driver or DTS file that
includes this header.

> +#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-amlogic-dm=
a-v9-0-558d672c4a95@amlogic.com?part=3D1

