Return-Path: <dmaengine+bounces-11742-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R7sdErFIOmoz5QcAu9opvQ
	(envelope-from <dmaengine+bounces-11742-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 10:49:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F30E6B5641
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 10:49:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jYxRw6uw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11742-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11742-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76C73020026
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511B3C37BD;
	Tue, 23 Jun 2026 08:47:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7B349B02;
	Tue, 23 Jun 2026 08:47:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204423; cv=none; b=Lq1McOKkHHanREsvNjRGOyUHhjl1fH5UdqRWZAEKJyrL6FtiGc9Khyv/nfkASmqW5q/G1scVsun3XT/8//Wvc9d1oXEPPtUxAe2yY6cg5dTCJFyri15zDw5uVoOJYJ6P/sBzb/NV/yGiWfjk/17r9Jt46/l88ENH7agZXxBNUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204423; c=relaxed/simple;
	bh=6vO769Z2othjMjBeAgBThXE93heAzAxGdoljJfl0WYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ2VM6xSxEDKWKSUYOglTttN4JAkFLhoB7DJFgSGVJHfLbz/qkGo+C5G9KfDush4LrEfn9rXoA5o3/42nQfsaNFKvjC+o2zb00X8RYqXcVTCDAmyRf9AkBmBUirYmAjVoVJ98AYNvDm2dsMi3Hpqt3ZOvvdEDFldB2pwF4Q7sdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYxRw6uw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0538E1F000E9;
	Tue, 23 Jun 2026 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204421;
	bh=WIwTC0VHw0jMFTXrlPYu0EBk9AhpcmV7JfkqaZxHCBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYxRw6uwNPYdz2dtcmIZFKkjSmnce0AkzA2cipbsc8XfB7+QQrrLm9S3oXC3rR2He
	 4+JUClOGBhD684EXgDlTruzwYKbBNBwS0fr2on/Ik4F5iHhGidQ/a6jLHJ1Ik2UclH
	 5O5c1XcsbmFL9/1NEmzqwfVClgVUnUUHHUvM/Y26f74bZYVDdNoSLWzODeIqcVchHV
	 rcVqwq/zWumw/mNQ+m3R1QQ9k+1Em/hi/DsP8BLjFIqwXq2evXe+5/FVqUhcSFaw2e
	 KdxXZzxudLMBrS1boAHEUv8hs0863UZrsaDIgBNeNw+kMFuLkM6nYyBe/dOBVAX9+y
	 H3zgr4szmz/0g==
Date: Tue, 23 Jun 2026 10:46:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: Add the actual power domains on U8500
Message-ID: <20260623-just-grinning-peccary-d661ca@quoll>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-2-eb5e50b1a588@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-2-eb5e50b1a588@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lee@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11742-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quoll:mid,vger.kernel.org:from_smtp,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F30E6B5641

On Thu, Jun 18, 2026 at 07:00:48AM +0200, Linus Walleij wrote:
> This file has been left in an unfinished state just defining
> the root power domain for the U8500 SoC. Fix it up by adding
> the actual existing power domains in this SoC.
> 
> The PRCMU code and old regulator driver is mentioning some
> *_RET domains, this means "retention" and is a state in the
> domain and not a domain of its own.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

From/SoB mismatch.

> ---
>  include/dt-bindings/arm/ux500_pm_domains.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
> index 9bd764f0c9e6..1c168e59ac90 100644
> --- a/include/dt-bindings/arm/ux500_pm_domains.h
> +++ b/include/dt-bindings/arm/ux500_pm_domains.h
> @@ -8,8 +8,23 @@
>  #define _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
>  
>  #define DOMAIN_VAPE		0
> +#define DOMAIN_VARM		1
> +#define DOMAIN_VMODEM		2
> +#define DOMAIN_VPLL		3
> +#define DOMAIN_VSMPS1		4
> +#define DOMAIN_VSMPS2		5
> +#define DOMAIN_VSMPS3		6
> +#define DOMAIN_VRF1		7
> +#define DOMAIN_SVA_MMDSP	8
> +#define DOMAIN_SVA_PIPE		9
> +#define DOMAIN_SIA_MMDSP	10
> +#define DOMAIN_SIA_PIPE		11
> +#define DOMAIN_SGA		12
> +#define DOMAIN_B2R2_MCDE	13
> +#define DOMAIN_ESRAM_12		14
> +#define DOMAIN_ESRAM_34		15
>  
>  /* Number of PM domains. */
> -#define NR_DOMAINS		(DOMAIN_VAPE + 1)
> +#define NR_DOMAINS		(DOMAIN_ESRAM_34 + 1)

In a separate commit, instead you need to drop NR_DOMAINS and move them
to driver. If this changes, then it is not ABI. We did similarly for
many clock bindings/drivers.

Best regards,
Krzysztof


