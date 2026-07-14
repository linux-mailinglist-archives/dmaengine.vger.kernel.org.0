Return-Path: <dmaengine+bounces-12484-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pLsZBqYoVmpL0QAAu9opvQ
	(envelope-from <dmaengine+bounces-12484-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:16:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 945AC754636
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=otdtft7k;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12484-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12484-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8128030CB5DE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4AB383991;
	Tue, 14 Jul 2026 11:58:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E7381B02;
	Tue, 14 Jul 2026 11:58:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030339; cv=none; b=FiH8grfmEj+lizST815Tog3ORgVUWZ82qi1ToAlSqqOL3aBBFmorJXcDB7JopZhlJMs/eldWZzCtsQt3TDLEmzMagu6luGQRcA34Gysv+Jn+RINUYubeYsOQcka2N5a8Lg/L40kxik5kXHcybKsztB8FLQ5H1fb9/GdlvLCusqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030339; c=relaxed/simple;
	bh=kmdAeC8hOQ6BVZgDdZfmzE1BGMi4JMkVnWEtsYc6Kg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APY6sm8CZNQQFTnRbk9jjwNSlYhDNoun0OYRUNFB0mHC4ACRwK19J9sJhM9kLn8iddBZlDBEQG3dDeT6dOoduh2OU1daeKywZR0es1yRTa7GwAdmGeHvGq9XUurNUGwCO+FC/OIBUt3m7IBYOPLv/nd0R/3ZAmzV3QbZIfXhGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otdtft7k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09801F000E9;
	Tue, 14 Jul 2026 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030337;
	bh=giljRTyf1/GeNOSQzfIPJUop85WcABknb2AO0qQE6u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=otdtft7koRJ9KTpp8Lc1Kbd0yTLVGKldNWh2Pgdgbxv8Vhn1tQWMLDJynabMil1As
	 IrLVwudKY43tMQ9K6lC2xCblgiQpsMzzIu8kyX5MB1Pq4tQwGM2VRaFypD5LmPW27m
	 uOTxcSvsUa0iJZynDx6ZFSBUFGAZQlplKAV+jiOZ+JNcad24LpbxRVDVUSP+N9TyW+
	 d6Tm20PG90euvR1VHnSL3YbTZoIopdrLYRDoKH/5I651gQlF+115Hm3m5qube0LMct
	 VFIQrwY6uFGKPdKbvNaoIwRdEJulEZsufvfX3wsCqFDI45tmf1B7KgR6qRIVC3+aRZ
	 951wTJfKaMlmQ==
Date: Tue, 14 Jul 2026 17:28:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: sashiko-bot@kernel.org
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, neil.armstrong@linaro.org,
	robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v11 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Message-ID: <alYkfmsBU0UqI6Hz@vaman>
References: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
 <20260714-amlogic-dma-v11-1-de79c2394282@amlogic.com>
 <20260714081942.2E0B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714081942.2E0B91F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12484-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-bot@kernel.org,m:xianwei.zhao@amlogic.com,m:neil.armstrong@linaro.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vaman:mid,amlogic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 945AC754636

On 14-07-26, 08:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The macros DMA_TX and DMA_RX in the global DT binding header lack an Amlogic/SoC specific prefix, leading to namespace pollution and potential build conflicts.
> --
> 
> --- Patch [1]: [PATCH v11 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA ---
> commit 093f368eaa67418008421d43d724ce2e98651039
> Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
> dt-bindings: dma: Add Amlogic A9 SoC DMA
> 
> This commit adds device tree binding documentation for the Amlogic A9 SoC
> general-purpose DMA controller. It introduces the YAML schema and a header
> file defining the channel type macros.
> 
> > diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> > new file mode 100644
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> [ ... ]
> > +  '#dma-cells':
> > +    const: 2
> > +    description:
> > +      The first cell is the DMA channel type(DMA_TX or DMA_RX).
> > +      The second cell is the DMA channel index.
> [ ... ]
> > diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindings/dma/amlogic,a9-dma.h
> > new file mode 100644
> > --- /dev/null
> > +++ b/include/dt-bindings/dma/amlogic,a9-dma.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +
> > +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> > +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> > +
> > +#define DMA_TX			0
> > +#define DMA_RX			1
> 
> [Severity: Low]
> Are these macro names too generic for a global dt-bindings header?
> 
> Since headers in include/dt-bindings/ are globally visible and frequently
> included by C drivers, unprefixed names like DMA_TX and DMA_RX could lead
> to namespace pollution and macro redefinition build failures if a driver
> includes this alongside other headers that use the same common names.
> 
> Would it be safer to add a vendor or SoC prefix, such as AMLOGIC_A9_DMA_TX?

I think this makes sense to add here

-- 
~Vinod

