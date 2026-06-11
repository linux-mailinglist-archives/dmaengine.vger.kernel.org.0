Return-Path: <dmaengine+bounces-11436-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8AD6K5NIKmrzlgMAu9opvQ
	(envelope-from <dmaengine+bounces-11436-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:33:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E48E066E9D2
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g+XzQ1xH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11436-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11436-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA15320CDE4
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B42347BC1;
	Thu, 11 Jun 2026 05:15:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0F2737FC;
	Thu, 11 Jun 2026 05:15:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154933; cv=none; b=IfJ5kyAF/5fZpvFsJwKjVeK1u0vdVZBzhHanZsFzH4quMZXmqVv2dOH78lrngYg0yte6va+IExoSidZZ5vNNW1QUVMK+1XDioUvyNOwdUA9gr9mOc/59GjNKiZQDoplcg5fWqzub5SadeUit22zCjty5n6Gp4hI3D/ITTW2UGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154933; c=relaxed/simple;
	bh=tTuybEuR6gnoGbu3D4QUyWOeAfzej4NgvzgnoflTldA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejj1VThRtbvw7MOG4Bb9pp0tHrqLKhpXHoaNQHmE7ixEJ0rqmtlxUIS6pJmUiPXi4GxaEJkL8Y+9B+mPtAtlt6QIvyHnhuzksEWm7dJwU1sanojKyr/ywB89EoTs713gWmoDsmWzGVd9wSClI0AAZ2nNTlcGCjXW5KXCqOtulBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+XzQ1xH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B401F00893;
	Thu, 11 Jun 2026 05:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781154930;
	bh=2sdwdrP69ZuOt1NoQqeSBnhxpHmS6DIjb1ObDLwBhxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+XzQ1xHxDrFQZeJ6D1wDKuSaun0O7AmbIHp4+1UDU9kvdRz+sRrRmbDqqiasuf9l
	 J9rMYkjiC7qTJkzjrKNeWlbTFxcqzpii1/wHq3VZA18ZiU8a7mrUPCZ7Ya2BiauIFj
	 0ZKJLRQ6A3uzgr0iE/AedMebTeitovLX11SEuzQ/Eaeo7C8+RxXnsrlkULpEQ7m9yJ
	 s8e2lS3d105EBtCuGGB0kffc793bdX+spRRa3IAJOo4BukfgOttbJfSzToraaGCbkU
	 YyHNtpFzFVNw/gQvTy1iPqofLbukNuMmjtWafLUTaBIyIWwbyApcsyXe8/ohsxaeCw
	 BFgVVX974LQ6g==
Date: Thu, 11 Jun 2026 10:45:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: Re: dmaengine: k3dma: KASAN null-ptr-deref in k3_dma_int_handler()
 on early IRQ
Message-ID: <aipEbnW219G7U0eo@vaman>
References: <20260610104713.591381-1-jjy600901@snu.ac.kr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610104713.591381-1-jjy600901@snu.ac.kr>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jjy600901@snu.ac.kr,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11436-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,snu.ac.kr,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vaman:mid,snu.ac.kr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E48E066E9D2

On 10-06-26, 19:47, Jaeyoung Chung wrote:
> Hi,
> 
> k3_dma_probe() in drivers/dma/k3dma.c registers the interrupt handler
> with devm_request_irq() before it initializes d->phy. If an interrupt
> arrives before d->phy is initialized, k3_dma_int_handler() dereferences
> a NULL d->phy, causing a kernel panic.
> 
> The probe path, in k3_dma_probe():
> 
>     d = devm_kzalloc(&op->dev, sizeof(*d), GFP_KERNEL); /* d->phy == NULL */
>     ...
>     ret = devm_request_irq(&op->dev, irq,
>                            k3_dma_int_handler, 0, DRIVER_NAME, d); /* register handler */
>     ...
>     d->phy = devm_kcalloc(&op->dev,
>                           d->dma_channels, sizeof(struct k3_dma_phy), GFP_KERNEL); /* initialize d->phy */
> 
> The interrupt handler, k3_dma_int_handler(), dereferences d->phy without
> check:
> 
>     p = &d->phy[i];
>     c = p->vchan;   /* NULL pointer dereference */
> 
> If the device raises an interrupt before d->phy is initialized, the
> handler dereferences the NULL d->phy, triggering a KASAN
> null-ptr-deref.
> 
> Suggested fix: move the d->phy = devm_kcalloc() assignment above
> devm_request_irq(), so the d->phy array is valid before the
> handler can run.

Please send a patch

> 
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
> 
> Thanks,
> Jaeyoung Chung

-- 
~Vinod

