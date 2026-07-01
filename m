Return-Path: <dmaengine+bounces-11913-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GSxlNELPRGrx1AoAu9opvQ
	(envelope-from <dmaengine+bounces-11913-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 10:26:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8916EB145
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 10:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cbsb1CfV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11913-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11913-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0FDD309843E
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C93C0601;
	Wed,  1 Jul 2026 08:21:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20FEED8;
	Wed,  1 Jul 2026 08:21:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894086; cv=none; b=E86uYPmM3Sl1Kx1nlU+HoFjD05qmGYuSJcDtnWyyMQ8yNY61F3F0bbTNEKvkdskSmSpwlcL2CWVYBqnILXr6UD5VTbO/Up1MV9s3JG85zKGxPEjH+iurMRLwIgcL2pSg1hoJpJPwuc973ikYL3q7mMUDdHcXh+qCNCuu3WH4WBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894086; c=relaxed/simple;
	bh=PvEw0UPdQ1EZMAoKMP89AcPz55a0OOLxucM/cI6aQWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQff/JAbzkaw5hmcQsTLRefON1UK/KsqU+8Gdpu76AGVx1TUUyyl5UNH77mCTQTv+D5iGk5kS9SdgL8iOzOwVkf6PAak5j9iaqgVcqiTmbh+/C5hGgJtDDa4/OU7UOcILscR12CG/3aacMkbhTr2EWbPxSkxq2luY2oz75Oy3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbsb1CfV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECAE1F000E9;
	Wed,  1 Jul 2026 08:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782894085;
	bh=p8+LoiQEPl9c/fRVf/vVLivgXz49UlU+h7hWhLWqyfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cbsb1CfV6e/Gz95XkBHU7qsjLx/n6zXPzemsNmsYUuFKmvyYysrgSGE16JU/ZQLDO
	 +dLik8cHwVS9GSh3mewqqob02yC/WigChupzQGwuuoOhzQn5PGUHkr+zUF7gRoecsQ
	 1i1KVrl+AjwLr9901xoAZ4upIWamfzix7nFQgKDbKRWslw8Bnk3pZTkKP1m+o/LNat
	 Ad1OlqHjFFz65XT73VoNHOB4CZUdO72x0YKLqydHgPg839EcBdT9Fpd4m9OY/cpITl
	 O1p+SjUzOsKOKjaZomd7gEFqN++yMAPtnxdo+Hr8gG+ysKz6aom5pRamEmNGUcH9zm
	 apCy+CeVNSyYg==
Date: Wed, 1 Jul 2026 13:51:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: altr,msgdma: update maintainer
Message-ID: <akTOAdKsFt0jxAnh@vaman>
References: <20260701023455.36330-1-adrian.ho.yin.ng@altera.com>
 <20260701-tactful-viridian-horse-3fa1f5@quoll>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-tactful-viridian-horse-3fa1f5@quoll>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11913-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:adrian.ho.yin.ng@altera.com,m:olivierdautricourt@gmail.com,m:sr@denx.de,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[altera.com,gmail.com,denx.de,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,vaman:mid,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A8916EB145

On 01-07-26, 09:36, Krzysztof Kozlowski wrote:
> On Wed, Jul 01, 2026 at 10:34:55AM +0800, Adrian Ng Ho Yin wrote:
> > Olivier Dautricourt has stepped down as maintainer of the Altera
> > msgDMA driver as he no longer has access to the hardware. Replace him
> > with Adrian Ng Ho Yin as the new maintainer.
> > 
> > Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
> > ---
> >  Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> And maintainers file? Don't send such commits separately.

That was sent separately
065e447dc41ea149c900338e64f047575ca6c348.1782279704.git.adrian.ho.yin.ng@altera.com

But yes subject could be better for both. Myabe replace Oliver as altera
maintainer.

Would be good to post both together as update

> 
> Also, subject is too generic - "update maintainer" can be any update...
> 
> Best regards,
> Krzysztof

-- 
~Vinod

