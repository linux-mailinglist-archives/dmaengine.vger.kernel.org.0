Return-Path: <dmaengine+bounces-12267-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OS01Og+KUGoF1AIAu9opvQ
	(envelope-from <dmaengine+bounces-12267-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 07:58:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEC2737777
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 07:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oE7YptjO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12267-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12267-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132693028002
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B97395ACE;
	Fri, 10 Jul 2026 05:56:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CAF395AC2;
	Fri, 10 Jul 2026 05:56:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662975; cv=none; b=FEg2X6F5S+GIZqTdnLVFt8dQ4bs6Ir7w530V1Rcq2+/DtevMSAAc1PkCmI+T2k5qVHip46Z8v+zAP6AnVUONeMEOB6yPt0Qfyek+aB+MdVcCeYsi8wSr1oSIGpZtluHOjy4JAusbIjTGsyJg165Ag8kPOkQOvdGfFZOpglNziXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662975; c=relaxed/simple;
	bh=Qyv6Yj1QttUfP8f7oYi0sBZLJRbeQRF2JE+oNTc8/ZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a/vYwGVoeiZPDwcO/NMN2TBKZxyA7aaXyUj7u9zAmjAgxtaZNNsuyf3NaqGcmK18R0bRAuIVce3fpkCB+St26mz3F4srPw5pLuN9+H3FEP+yg3fjzU63/l66p4j/hgBepxLVn+F5m6ND5C5TND34eugUfCuJaqUsmodBw4Z4+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE7YptjO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD8F1F000E9;
	Fri, 10 Jul 2026 05:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662974;
	bh=ahuNRr/Mh7BaiOwHTLAC3cW7JJUenNp+2t36g1wXGF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oE7YptjOOC/1yaFN8r4XhAFWfYjqelHqsrLlWHcZRhwX4prtunIOkDGAAYOmssbbU
	 fNSXxgMHHiPXborNWP7wUOc65aPRDUHUx6b3UGeC6v6DLKv1uQuF7PbbAooxMaIA3i
	 fn/trfMO2MyBfi5ErXJ8RLwTgnMHh8qF5jVPfAveZPLr+SOnDwWMUIzv7n4s+T8Xdb
	 wwTuXTqzWdkYE1NXa608/XS1koo29n00Bf7KMiGrb745IntoVTz/Mq9bKnnxdDlS1Y
	 5nwgOVFiykjKi+1yGEFfPd5RMwg2hl9WsBVqDUpUflEFQJNGJTejgvbFUT0PGdbPXL
	 Fm5aMa5fBJYSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao" <xianwei.zhao@amlogic.com>
Cc: robh@kernel.org, linux-amlogic@lists.infradead.org, vkoul@kernel.org, devicetree@vger.kernel.org, neil.armstrong@linaro.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260710-amlogic-dma-v10-1-ff4deae837e7@amlogic.com>
References: <20260710-amlogic-dma-v10-0-ff4deae837e7@amlogic.com>
 <20260710-amlogic-dma-v10-1-ff4deae837e7@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:56:13 +0000
Message-Id: <20260710055614.0CD8F1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12267-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xianwei.zhao@amlogic.com,m:robh@kernel.org,m:linux-amlogic@lists.infradead.org,m:vkoul@kernel.org,m:devicetree@vger.kernel.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BEC2737777

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The macros DMA_TX and DMA_RX in the global devicetree bindings head=
er lack an SoC or vendor prefix, causing namespace pollution.
--

--- Patch [1]: [PATCH v10 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA ---
commit dd68c09cf89a4142756eff7b44b06fb8f8ed1b20
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>

dt-bindings: dma: Add Amlogic A9 SoC DMA

This commit adds documentation describing the Amlogic A9 SoC DMA controller.
It also introduces a new include file containing specific property values
for DMA channels.

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
Do these macro names need a vendor or SoC prefix like AMLOGIC_A9_DMA_TX?

Since they are in a global devicetree bindings header, using generic names
like DMA_TX and DMA_RX could pollute the global macro namespace. Are these
likely to collide with existing definitions in other driver headers and
cause macro redefinition build errors?

> +#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-amlogic-dm=
a-v10-0-ff4deae837e7@amlogic.com?part=3D1

