Return-Path: <dmaengine+bounces-12471-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ouv0A8LyVWq+wgAAu9opvQ
	(envelope-from <dmaengine+bounces-12471-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:26:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6437525F6
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:26:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ia9rbKyC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12471-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12471-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69480305B7F4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178413FAE19;
	Tue, 14 Jul 2026 08:19:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202183EDE5F;
	Tue, 14 Jul 2026 08:19:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017191; cv=none; b=WB5JNp2n2vvazayiCS24ZVOwlNhoH8qsZsCkfcS7uNyAkcdvthtaf5i/7DM7oTQfx93RFP6EMEu7GTpKoW++dfOJgD9ogb1lmnYnvXm8C/CY6k2rkHxN92k8bkjXc88ezaS6e5J+ZYqEiMk9BzE5v/gmfxN13twDc5pP7mqsmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017191; c=relaxed/simple;
	bh=qkTR8NHXRTG8OQSVTgabcuVukF2UeoJkaUSbVQoGMMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ae9U9To26s2AhL8gRZ5LAweUmtLrdl2m0LT4X16b6H84ZHafwuqN6mR2L9wypwFstgnlU7LGMv6iQG/IoxQIrrt9shn3q2yAcB1lR1VNpNNHGWciztK9HGAP2qgom1fTgbLOWDiRIrvwBqdm+NR3KZFB5sUv0hwK5GDd/Va2sKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia9rbKyC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0B91F000E9;
	Tue, 14 Jul 2026 08:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784017182;
	bh=CCPHq1HHM2IxWF7xzjbQGlm+A8GOHNH5HyfKyBhULhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ia9rbKyC4kUKevmkwKQT+0tqRgIv8nc61JorVx/5cQLw5UdS51IrjGVgVJCEcdN71
	 Bwgwqho+h+UrO3tIunUXrJw+AETR1HeEHIIsu8ozW9PCS98jobGD/DZ/b/PC70UAD9
	 raD+xcKc6PKzWruMr+KzTQlapQF7xLHNXQo8TOeC5kCmqJ6HzJk3Opzh5dMjlHBl1w
	 OVFI6TdKh0aQi1ZQNpwpxPCLKlF4uupXeaKfBu+3Wd7iBOvgdi/Zjv9RQAtY1gv0wP
	 ns0+s53hIZ6h/5SRaA9Ty70Hv3V2k1BCx6bsQ8kGgPRQeRXkWam+9klH/cy6zVVbPa
	 jf9LrQShNxYeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao" <xianwei.zhao@amlogic.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260714-amlogic-dma-v11-1-de79c2394282@amlogic.com>
References: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
 <20260714-amlogic-dma-v11-1-de79c2394282@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 08:19:41 +0000
Message-Id: <20260714081942.2E0B91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12471-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xianwei.zhao@amlogic.com,m:neil.armstrong@linaro.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:linux-amlogic@lists.infradead.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A6437525F6

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The macros DMA_TX and DMA_RX in the global DT binding header lack a=
n Amlogic/SoC specific prefix, leading to namespace pollution and potential=
 build conflicts.
--

--- Patch [1]: [PATCH v11 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA ---
commit 093f368eaa67418008421d43d724ce2e98651039
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
dt-bindings: dma: Add Amlogic A9 SoC DMA

This commit adds device tree binding documentation for the Amlogic A9 SoC
general-purpose DMA controller. It introduces the YAML schema and a header
file defining the channel type macros.

> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/=
Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
[ ... ]
> +  '#dma-cells':
> +    const: 2
> +    description:
> +      The first cell is the DMA channel type(DMA_TX or DMA_RX).
> +      The second cell is the DMA channel index.
[ ... ]
> diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindin=
gs/dma/amlogic,a9-dma.h
> new file mode 100644
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
Are these macro names too generic for a global dt-bindings header?

Since headers in include/dt-bindings/ are globally visible and frequently
included by C drivers, unprefixed names like DMA_TX and DMA_RX could lead
to namespace pollution and macro redefinition build failures if a driver
includes this alongside other headers that use the same common names.

Would it be safer to add a vendor or SoC prefix, such as AMLOGIC_A9_DMA_TX?

> +#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-amlogic-dm=
a-v11-0-de79c2394282@amlogic.com?part=3D1

