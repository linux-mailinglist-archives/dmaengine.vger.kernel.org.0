Return-Path: <dmaengine+bounces-10633-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK0xAvPBDmrXBwYAu9opvQ
	(envelope-from <dmaengine+bounces-10633-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:27:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 560E75A1056
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84979301DAD2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1B34BA5A;
	Thu, 21 May 2026 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA0mc5+S"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591392ED860;
	Thu, 21 May 2026 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351691; cv=none; b=LTrT5aT25KAhF9VeWEPfEa74g9Me30GytHEGaGQqhUKuRuHyw3L+Yg2BxzEQJ0Pueqr07lHaEzC2Q2tnmyLiZYZVuGF5GtcAhFIgT5jOZgnCQjcoa0LH++vRQ84ecCcCCdanNycqDb13xR38IfM3zUZ/3mC6b1MQC6TBENwCwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351691; c=relaxed/simple;
	bh=ZfEvdJmbSLV/BYoSnh/NDHvbvOvarI+N2DALAuf7eIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KiIch+gbqLsrrvz8y5Vg3Dd3Ltn0OPqAdX2q0fHKza56Rsi1zcMj+scJQX26+am0gGl3PnVaOG7L8Zxd0zxcQBqiZi0Z/6nSdLgKzbpLnPlw22XBQ2G3ga4qJSbPyplwGKoP418kJ4d7CF5FmZUqN0bZ+aE4VcHcVq/2fmitA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA0mc5+S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3FE1F00A3B;
	Thu, 21 May 2026 08:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779351690;
	bh=RsTL9FOW4wrOkfMOa0WAFaXlKJyboMFZ1uHWJa5m12c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KA0mc5+SKIb1Tbp6M9FDpKHI7hyt7xhCLJ51gYspXbV2dgYWUnY7zFuEj0MDG0vNW
	 CH88QlX271eCpX065CiHu/mviFcpKwcPysfm5+t9xhq5ZvkB5vea+zBaoIn0JXl30y
	 dmzkHpc+XXJ12aANnYkd3toSE4JJiD2yPDQLJ13JEERs17eS6afzZ+Dm07rUGT4lu8
	 LxiQFcDXj10grrYNXOTtXF3QkVCDwQ4FXFNwrGqiMYv2UPlZbiTwipTFq7gblOuIdR
	 4MR75rc4cpGlFb6J6pyq5ncW2QUnz9g9g+eU2RCKDYry4UKaKxPHxXbkYtsgdbZgaU
	 5OABAdAeb0T5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao via B4 Relay" <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260521-amlogic-dma-v8-1-86cc2ce94142@amlogic.com>
References: <20260521-amlogic-dma-v8-1-86cc2ce94142@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 08:21:29 +0000
Message-Id: <20260521082129.9F3FE1F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10633-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,amlogic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 560E75A1056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The macros DMA_TX and DMA_RX are defined in a global header without=
 any vendor or subsystem prefix.
- [Low] The binding specifies `#dma-cells: const: 2` but fails to document =
the semantics of the two cells.
--

commit 7a02c7e6145050221d77d7a4745ee4d4e651163b
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>

dt-bindings: dma: Add Amlogic A9 SoC DMA

This commit adds device tree binding documentation for the Amlogic A9 SoC
general-purpose DMA controller. It also introduces a new dt-bindings header
file with property values for the DMA transfer directions.

> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/=
Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> new file mode 100644
> index 0000000000000..efd7b2602c336
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
[ ... ]
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
Should this include a description explaining what the two cells represent?

Usually bindings with multiple cells document the semantics of each cell
(e.g., first cell for the request line, second for transfer direction) so
clients know how to construct their dmas specifier.

[ ... ]
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
Would it be safer to add a vendor or device prefix to these macros?

Since this header is globally accessible and can be included in both device
tree sources and driver code, generic names like DMA_TX and DMA_RX might
cause macro redefinition conflicts with other kernel components. Adding a
prefix like AMLOGIC_A9_ would avoid this.

> +#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-amlogic-dm=
a-v8-0-86cc2ce94142@amlogic.com?part=3D1

