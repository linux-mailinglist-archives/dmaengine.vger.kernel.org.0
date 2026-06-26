Return-Path: <dmaengine+bounces-11802-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ejisGa0yPmphBQkAu9opvQ
	(envelope-from <dmaengine+bounces-11802-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:05:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B1F6CB345
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:05:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F++xT6rk;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11802-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11802-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 636BD3051780
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED033E3D93;
	Fri, 26 Jun 2026 08:04:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE23DB330;
	Fri, 26 Jun 2026 08:04:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461094; cv=none; b=Qy4y6xI/P5oPmODn1XZt3gOjQ5XgaeRYTG4RC9gOVdGONW783AD2lidjk2KVaRMYIdpVg+g/qui7vJ1GhgWMOEzRWpDVv6UHYqqre1Qs7TKiYACg8uM2On7WF3j5t+PfZGB7Ia8suJxc6cCUEDSVJ3OmxYoIKRaK/s5SrDnhINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461094; c=relaxed/simple;
	bh=Bw/RJ2z9s3NYhnGepxI3RDI98k0HoIx/UjlAtf/9xc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sueI5z3tlxJ5VnaCoHvdTJl5JCCYWqR6ybGgwrW8QvL77Z+g5YGR3034wGiSpW2/i/r4urOoKczU8CWdgI8PQuhHKoTdn353MD68/mJSJOMe894JdlWUs6JIrMBjF9E5jjN5Hbg3SYScEMjCu+xaU8HlpTibeQ4h+hP5IGhj274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F++xT6rk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0981F00A3E;
	Fri, 26 Jun 2026 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782461092;
	bh=Sk7CWkvXC8D8N45tPv22wE83pLMkYTSkRNxQDotlMwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F++xT6rksaeS/VJab8BjQNNa+HvQhPy0lTov3XUjYULif5N1yPYr15U7B6cLCpdsD
	 ierIUq8UTvtc4a0wRvvLvXe1rPQA+JI/Ar3wVFonkMVtpkulGl01ZL5ZK39CkrHUNy
	 Ql9WdlNlVDTY93SW5noabNueoydtNsSZ7W6X0mxCFBQx9D98a/ePWIBu5hXIMklJeJ
	 Ei7iFV8gon9ttpyuOy67z62io19x5vzPFRKH6f4C+N6QVf5lbk7armchxO0mqN5Rt6
	 cjluFHuvW1mqQMqiY+bjl4H42jJKZyNz2r5xNXvHlvuSYmmjXFrRszFfOtuniV8TJW
	 3Qgr6aVCnHkMw==
Date: Fri, 26 Jun 2026 10:04:49 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: altera-msgdma: replace maintainer
Message-ID: <aj4yodoqp-ZWQVEs@vaman>
References: <065e447dc41ea149c900338e64f047575ca6c348.1782279704.git.adrian.ho.yin.ng@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065e447dc41ea149c900338e64f047575ca6c348.1782279704.git.adrian.ho.yin.ng@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:adrian.ho.yin.ng@altera.com,m:olivierdautricourt@gmail.com,m:sr@denx.de,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11802-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:email,vaman:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0B1F6CB345

On 24-06-26, 13:49, Adrian Ng Ho Yin wrote:
> Olivier Dautricourt has stepped down as maintainer of the Altera
> msgDMA driver as he no longer has access to the hardware. Add
> Adrian Ng Ho Yin as the new maintainer and update the status to
> Maintained.

Olivier okay with this?

> 
> Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b787bc2855f..1f515256412b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -952,10 +952,10 @@ S:	Maintained
>  F:	drivers/mailbox/mailbox-altera.c
>  
>  ALTERA MSGDMA IP CORE DRIVER
> -M:	Olivier Dautricourt <olivierdautricourt@gmail.com>
> +M:	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
>  R:	Stefan Roese <sr@denx.de>
>  L:	dmaengine@vger.kernel.org
> -S:	Odd Fixes
> +S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
>  F:	drivers/dma/altera-msgdma.c
>  
> -- 
> 2.49.GIT

-- 
~Vinod

