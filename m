Return-Path: <dmaengine+bounces-11091-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EY5FOddHWojZwkAu9opvQ
	(envelope-from <dmaengine+bounces-11091-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 12:24:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A232661D4A3
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49B7331E0800
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586C3AC0EB;
	Mon,  1 Jun 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChVJcYWl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0593ACA7C;
	Mon,  1 Jun 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307936; cv=none; b=JgANFZAiQFsYbGNIUDFgyIzYu4Xv/rzBt8yy8kSFBAesJYK0cpbdua4sokou5EolmOzF32NCdPMr/aXJvzZdYeszDeaGVF019CDxOhcZbGk98Kd28fmSqiTfn3TAedeD0OBpnghW/ZgPrlR9jOZvENefko+Wt86vHmHXKNhyk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307936; c=relaxed/simple;
	bh=bEazeAebAUV6jPXRuP9/77Msccaaz2doB/rXC+HZu+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jud8qF3Y3wxnArxTdT51987TwbpFQztwPSadCh7OhjaHOZ+oDw62mB9U5YMLHR8C242X+z1lwImi7bfmorYTU22VluLUnZf50R/iuS/N2SPRaIjBDBcWUBPRjKG84b2XhFoIHHSIeqKCxWXOGJdT+fFfaktSTc5dgLVHOhyMSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChVJcYWl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2431F00893;
	Mon,  1 Jun 2026 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780307926;
	bh=LePCTfN56H/WPSoRi3CkNytKD/M2TpSTQ0+ItJTWOX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChVJcYWl60GzBSMLP5RdrsNdGGnq8bd4wKkvO+5gJMV+q7q7W0MsezyDtyJo12gbI
	 jy3rdo18UaCGBLaKWJ7B9cBUF4jw2JXVQEI1bGObD+wXejXS3459pW2lsymxhB4QUB
	 4HUrRKniQC4Aa+B1IMkD8BcvS7NQpDVQmhCt1lRSuvsOXHzv0tnI8FzVuu84HGfEC4
	 ochNygN5AS5xwRmLK6GHY/Z1pgjD1nE8gSujmXH5ZNpaScy4BQCuVbBfdmliyPUDkt
	 DXz1MEOjvPKauLqEA8wXj3evnC6Be+Adcc5DEZ4e2Ev2mEf8XUIeSz+kh8MURe7d2P
	 WcivAssE29r2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "CL Wang" <cl634@andestech.com>
Cc: vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260601094846.1097678-2-cl634@andestech.com>
References: <20260601094846.1097678-2-cl634@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:58:45 +0000
Message-Id: <20260601095846.3B2431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11091-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[andestech.com:email,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A232661D4A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The Device Tree schema uses `additionalProperties: false` alongside=
 an `allOf: [ { $ref: dma-controller.yaml# } ]` inclusion, which violates D=
T schema guidelines and prevents the use of standard generic DMA properties.
--

commit 65ee89a1dfc4e52aa6a4083163369bef3de2c374
Author: CL Wang <cl634@andestech.com>

dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine

This commit documents the devicetree bindings for the Andes ATCDMAC300
DMA engine. The IP is embedded in AndesCore-based platforms or SoCs
such as AE350 and Qilai.

> diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.ya=
ml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
[ ... ]
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +
> +additionalProperties: false

[Severity: Low]
Does this cause a regression during schema validation when standard DMA
properties are used?

Since this binding references dma-controller.yaml# via an allOf block, using
additionalProperties: false will reject generic properties like dma-channels
or dma-requests if they are present in the device tree node.=20

Should this be unevaluatedProperties: false instead to properly allow the
inherited properties?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601094846.1097=
678-1-cl634@andestech.com?part=3D1

