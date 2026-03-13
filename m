Return-Path: <dmaengine+bounces-9427-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JMtAKGYtGnOqwAAu9opvQ
	(envelope-from <dmaengine+bounces-9427-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 00:07:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBE28A978
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 00:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C709F30C1C14
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ECF3D0905;
	Fri, 13 Mar 2026 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMyHZpMS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312426A08A;
	Fri, 13 Mar 2026 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443229; cv=none; b=uK9QCY1ZYd5gYJ2hOgBRaFLBBBpeqy8moPHK72ZLCxcCgdebzrq8tRkFbIP+X3Y0cpSpxMHvlkaaPsyA/mAjo9pOJlq7ALqY5COQ+s9r49RtLzhA6hsw9DHyAyUNWcuxP4NsgreqB5EqCxRFns7OBux6zX2QSk7T0PD0qKh8/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443229; c=relaxed/simple;
	bh=5n7K/5zkep3KhbLF3QY/BkJ3CUHzeTh942RzL9LF9eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJlXrWLg6EK+n7NXdqCGleUZnvj+3Zq0J13UhYYlMpsdXMUofgpBfMpoMx16WdiZE3WQPBZTnPbbYhiyNe8yHSJ0FAkPQXJDno2oE40y9cDziARurSo5apo4+QMOac2tQ6ibrK8zWnAndffvOf1mT4g/65HguRrLdYMTc6Pq57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMyHZpMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409E6C19421;
	Fri, 13 Mar 2026 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773443228;
	bh=5n7K/5zkep3KhbLF3QY/BkJ3CUHzeTh942RzL9LF9eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMyHZpMSObB4Q1f7iWBtcBmCDGW3VoSwUsb7tgXyWR+qgySRYTCxULOcglQrSmaMi
	 4gk6db2L5IaLm1Igf3hBjuMrayfBvhQgVeHSWWVdhR69CuDV097fMiETLbXpRRGNMg
	 A3eU/We8eRH2LnSh3j5qtKDBgaSn12GydjVK9v/e7GviGApn2z9Td6ux3kMH9X9lMZ
	 YC6Gci8Ohlk/kImlm8LonpEPVM/Eo2ncpYbsJTEV801SWWo2ez0akv3F/38YVyaiTe
	 TJl9yp5cYocm2ASkkXGZF+ouaAg2ezzpuQzqCtBSvIW/J7rjvJEH/dkBSz8k/G0OFN
	 QP89Rbko0ZnGQ==
Date: Fri, 13 Mar 2026 18:07:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Add conditional schema for
 RZ/G3L
Message-ID: <177344322564.3613129.9716836875975202281.robh@kernel.org>
References: <20260306145819.897047-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306145819.897047-1-biju.das.jz@bp.renesas.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[renesas.com:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-9427-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,bp.renesas.com,glider.be,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EEBE28A978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 06 Mar 2026 14:58:17 +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The RZ/G3L DMA controller is compatible with RZ/G2L, sharing the same
> IP. However, the conditional schema logic that enforces RZ/G2L-specific
> binding constraints was not extended to cover the RZ/G3L compatible
> string, leaving its bindings without proper validation.
> 
> Add the RZ/G3L compatible string to the existing RZ/G2L conditional
> schema so that the same property constraints are applied to both SoCs.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


