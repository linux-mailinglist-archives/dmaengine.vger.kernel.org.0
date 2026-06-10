Return-Path: <dmaengine+bounces-11401-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V95NEZM5KWqESgMAu9opvQ
	(envelope-from <dmaengine+bounces-11401-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:16:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91B6682D1
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:16:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mThRrkQu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11401-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11401-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 213E8308111A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B693E9C0E;
	Wed, 10 Jun 2026 10:11:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642713E834B;
	Wed, 10 Jun 2026 10:11:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086313; cv=none; b=Y9NufuykGK3CynW+yC8S3Pg6iSSklqCbx8RnK4gAhvG14z7nbblcP+l4BhtHIH52e0Jrr++WVx0JMpD4+wbk65ox9Ki3I8QpEcexRIbUa+9vojDlH3BQdL+cYzf7khINKRZ6rDQsj7ZEvWzbfaMiyiRJvaLFCFsN0kQo/P2Ibi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086313; c=relaxed/simple;
	bh=TGppL9hDgW5mi5BZI2txZVKn4B8Bduk6VVtIfcRfxcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WsPG+8R9kLW05mK98qCdZ9VfO1T5r5chJyHocPW7I08G0QJcqpVwmIktFGdvurissZPveO+2eGKm9WNzs+4xjPJ3QUCizzmhDUK6Pf2iUKGMg9tFRhRZWhV1mb4SCRDoYT9AA238mMyMjIYBwhQXYqTPPDgn1ja8OAKMmMb0nhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mThRrkQu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1611F00893;
	Wed, 10 Jun 2026 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781086312;
	bh=w2L/TnCaqDd4KnTRIQ+TaHnC3QgS/VxXV74wjJWXoG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mThRrkQusiGr8imwkIt5HOS7tZlAK8UwMj6FPIg9iAPFP3GvN1zrRtUbLN/07uPKo
	 KFScJG5xbtLlguGnyc7HGTvMXwNRu54MlEe8cCOVkV6BeaOP+Hu49Dhlku0k1hbE/t
	 X8IxNyArUuf6I8IE8OmVUlI3pYh142nnxX7dfSCBFGxSaeclD7bwt3M2ZSLjSJK2yf
	 wE/noCbSn109cGucbeMzbCuWObtn2bjiHHWfWqo3O6HDhCx/jAwBsLqnQhya5m1Oeh
	 m6kUSl6w1JsIAVMH56Rva12S08hcJwd2e3omZrFSKxyThxaLU0+7MJRJVlF6sn9mgO
	 XcLE+IHndrALg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "CL Wang" <cl634@andestech.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, robh@kernel.org, vkoul@kernel.org
In-Reply-To: <20260610095724.1980622-2-cl634@andestech.com>
References: <20260610095724.1980622-2-cl634@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 10:11:50 +0000
Message-Id: <20260610101151.AA1611F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11401-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cl634@andestech.com,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,andestech.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E91B6682D1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The schema uses `additionalProperties: false` instead of `unevaluat=
edProperties: false` while referencing a common subsystem schema.
--

commit 0c4fc28dab967baedae4dfdcb32dfa0eb77d45a5
Author: CL Wang <cl634@andestech.com>

dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine

This commit documents devicetree bindings for the Andes ATCDMAC300 DMA
engine, which is embedded in AndesCore-based platforms such as AE350 and
Qilai.

> diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.ya=
ml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> new file mode 100644
> index 0000000000000..f040a2bf7d4b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml

[ ... ]

> +allOf:
> +  - $ref: dma-controller.yaml#

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +
> +additionalProperties: false

[Severity: Low]
Does using additionalProperties: false here prevent the use of common DMA
properties defined in dma-controller.yaml (like dma-channels or
dma-requests)?=20

Since this binding includes another schema under allOf, should it use
unevaluatedProperties: false instead, so that dt-validate correctly
evaluates and permits those inherited properties?

> +
> +examples:
> +  - |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610095724.1980=
622-1-cl634@andestech.com?part=3D1

