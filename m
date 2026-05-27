Return-Path: <dmaengine+bounces-10979-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM31E9j3FmrUywcAu9opvQ
	(envelope-from <dmaengine+bounces-10979-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:55:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF45E5655
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6B3300D339
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2432FA1B;
	Wed, 27 May 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq9/ca4o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CE313552;
	Wed, 27 May 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889762; cv=none; b=Vf4zDyjunm4rh3VMOKwfJ5euGnK/w7nvTLcpatmKxxFmFFwj1iuej6mX25Jz5LU3H/q3s2Ggmn4J/GXQZ8RfUt4i7RRAjhDuZoAOpt4VGugRpu09vwac+2/mLvCR0CiGS9SDP+q4jZ7zDgHV+ubnXpymkQN1NyVfE1jg/5JM1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889762; c=relaxed/simple;
	bh=lX0gIDpKlEWVT6/C6ELLOIkJuKFIEGMczqkurCCyPdE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GDp6G//S4L5WvSomvLURpM8pBaheN82RWmNsYNbubW81wyFlOHxwgITSLXAMfjVJLBkUaB2FVGpx1xQMdJRYZ9qmCEe25D3aEcX8XiYl59xmESArmud8Zq/PudIacecxX97SaNRxc6bDNCU35IxMUd1LAKRo7m+W2OgLGaP7sK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq9/ca4o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9421F00A3D;
	Wed, 27 May 2026 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889760;
	bh=BkdLYt3sAnWD24cO/3pRvQ5cZ8QR8okqOahDfBCwT7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cq9/ca4oKiOVLdcwGldGv1FoCVeADjDkvdyn1VplLgsUBaoYeNDuJKTCf3jsTkhkn
	 HoDuUzStlEIxuUvFhG36J/Tm/RM4TzYRRW/TvjCDtxMwfXJP/5pmsl9HTf3JVuLOMD
	 MSF8g2VzXhlA1YWuK0+gN9WbibSIQKY/3JVbDa3AyHwcpXUVjfcktTkjiOMMLIr6ld
	 V4q6MzFO2cGtdYYoGWyX7BRe3Nx7Jb5ot6i6yG9rIeiPshoc/1yVL/WHvnLL60CwoJ
	 b+yHawnzoGxdZ6zmZ/Cl1RArsAdqYl9j8S9DrNPMX97NhtPxbRToyLylS5Qk5E1aaf
	 qDITPeJP3KUzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "CL Wang" <cl634@andestech.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, robh@kernel.org, vkoul@kernel.org
In-Reply-To: <20260527132815.1211195-2-cl634@andestech.com>
References: <20260527132815.1211195-2-cl634@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 13:49:20 +0000
Message-Id: <20260527134920.8E9421F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10979-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,andestech.com:email]
X-Rspamd-Queue-Id: A4FF45E5655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect use of 'additionalProperties: false' when referencing a c=
ommon schema.
--

commit f1fe6e40b9cc08af2c1dbda4fec526d830ad7eb3
Author: CL Wang <cl634@andestech.com>

dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine

This commit documents the devicetree bindings for the Andes ATCDMAC300 DMA
engine, which is embedded in platforms like AE350 and Qilai.

> diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.ya=
ml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> new file mode 100644
> index 0000000000000..0f5ffdf1d1609
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml

[ ... ]

> +allOf:
> +  - $ref: dma-controller.yaml#
> +

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +
> +additionalProperties: false

[Severity: Low]
Should this be unevaluatedProperties: false instead?

Since this binding references the common dma-controller.yaml schema via an
allOf block, using additionalProperties: false will cause dt_binding_check
to reject standard DMA properties (like dma-channels or dma-requests)
because they aren't explicitly defined in this file.=20

Using unevaluatedProperties: false allows properties defined in referenced
schemas to be properly evaluated and permitted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527132815.1211=
195-1-cl634@andestech.com?part=3D1

