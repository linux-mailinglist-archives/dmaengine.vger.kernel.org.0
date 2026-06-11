Return-Path: <dmaengine+bounces-11450-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0u+pAYxaKmrWnwMAu9opvQ
	(envelope-from <dmaengine+bounces-11450-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:49:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290766F263
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:49:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="UyWPDIB/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11450-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11450-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2C8B3008D62
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E498379C29;
	Thu, 11 Jun 2026 06:49:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9E379C4F;
	Thu, 11 Jun 2026 06:49:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160583; cv=none; b=p0nPVA4EzjY0fxfJTcuE7JLMzfelwFXOZT2qt5+5+UL8Oj0By8qoWuRV8V6EpSXgOGXIifIGH3r8is1v+8r6lyNosyVVj/xH79OYXgDQzHeAVRcciwDW9kP60EW3ipkW0mnPH3/FyBkkzJF4BrUGAW3INVzFSNd6MDJ4HtxyjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160583; c=relaxed/simple;
	bh=cbTUbyOt2VY5HOf8pBk8+L3dfHLV4thvg1YIQgPPW7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHrIneJp8mCPXjGAUQ8sbs1guZb+Qt7ow5hK9PA0E6lvhLyRKWFmGD+Qj/WnQvfqpYbYnWZZg6i8ugQDlFCmKwEjO8v+OHBjRNlsucS9P8Succ6DqhuVI3pPjMYHMasbUoKG78MZG+V+e60AxA9JWKItZ4OGB1ddrNmVfQIfuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyWPDIB/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F2E1F00898;
	Thu, 11 Jun 2026 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781160573;
	bh=AK9hhcpPRx5nQQdM9IV3eqa75eWCLBUWxbBXyQEFRZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyWPDIB/mHFQTZWmZ4v+zln4w7Xt+EAu7VoNPMRMj3lZ4+XFrxPvrHL6DSNQc+hof
	 XyjIN6zwz2XF5IaWtrgP0VAnaewbNjjTW7HqotVwmI3FwxOy05KN5BXqxhrC1J/253
	 SUj5PuTPSaUzfD9keudN8tqIkl4cjnmwn0sWXlMsoGHEiRDT6v3Jx9Z/GWbtYCwqTH
	 Q6iEkLIvmpaB1EnpqboHB9LPAO410u6TpA1N4SON941cyAPycu/yJvfJ1Ll9aY+7Ya
	 BP48ZuhqtG05XCKyrnY3t8XrVWs3Zat6NdJSWiB1UNtzNTDHhh9DwD5AGsbftprG58
	 YrEeH8FKtLABw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: sun6i-dma: Fix use-after-free in error
 handling paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260611063631.96566-1-zenghongling@kylinos.cn>
References: <20260611063631.96566-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:49:32 +0000
Message-Id: <20260611064933.67F2E1F00898@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11450-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:linux-sunxi@lists.linux.dev,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9290766F263

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `sg_len` validation in `sun6i_dma_prep_slave_sg` leads to =
NULL pointer dereference and hardware memory corruption.
- [High] Missing bounds validation in `sun6i_dma_prep_dma_cyclic` causes a =
kernel panic via division by zero or NULL pointer dereference.
- [High] Deadlock risk due to incompatible lock contexts for `sdev->lock`.
- [High] TOCTOU race condition in `sun6i_dma_interrupt` leads to NULL point=
er dereference if raced against `sun6i_dma_terminate_all`.
--

commit ca6b94283f2abd1205fd392ecfced542cac0978a
Author: Hongling Zeng <zenghongling@kylinos.cn>

    dmaengine: sun6i-dma: Fix use-after-free in error handling paths

This commit fixes a use-after-free issue in the error handling paths of the
DMA preparation functions. It saves the next physical and virtual pointers
before freeing the current linked list node.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..eb9c4ae87ac8e 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -788,9 +788,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_slave_sg(

[Severity: High]
This isn't a bug introduced by this patch, but missing sg_len validation in
sun6i_dma_prep_slave_sg() can lead to a NULL pointer dereference and
hardware memory corruption.

If a 0-length scatterlist is provided, the loop is completely bypassed:

	for_each_sg(sgl, sg, sg_len, i) {
		v_lli =3D dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);

This leaves txd->v_lli as NULL and txd->p_lli as 0. When this descriptor is
later submitted in sun6i_dma_start_desc():

	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
	writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);

The uninitialized physical address 0 is fed directly to the DMA hardware
registers. Does this code need an explicit sg_len > 0 check to prevent
invalid memory accesses?

>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> +	p_lli =3D txd->p_lli;
> +	v_lli =3D txd->v_lli;
> +	while (v_lli) {
> +		struct sun6i_dma_lli *next_v_lli =3D v_lli->v_lli_next;
> +		dma_addr_t next_p_lli =3D v_lli->p_lli_next;
>  		dma_pool_free(sdev->pool, v_lli, p_lli);
> +		v_lli =3D next_v_lli;
> +		p_lli =3D next_p_lli;
> +	}
>  	kfree(txd);
>  	return NULL;
>  }

[ ... ]

> @@ -869,9 +875,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_dma_cyclic(

[Severity: High]
This is a pre-existing issue, but missing bounds validation in
sun6i_dma_prep_dma_cyclic() can cause a kernel panic via division by zero or
a NULL pointer dereference.

The function computes the number of periods without checking if period_len
is zero:

	unsigned int i, periods =3D buf_len / period_len;

If buf_len is less than period_len, periods evaluates to 0, which skips the
allocation loop and leaves prev as NULL, resulting in an immediate NULL
pointer dereference here:

	prev->p_lli_next =3D txd->p_lli;		/* cyclic list */

Could this be triggered by a caller passing invalid lengths, and should we
return an error early if period_len is zero or greater than buf_len?

>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> +	p_lli =3D txd->p_lli;
> +	v_lli =3D txd->v_lli;
> +	while (v_lli) {
> +		struct sun6i_dma_lli *next_v_lli =3D v_lli->v_lli_next;
> +		dma_addr_t next_p_lli =3D v_lli->p_lli_next;
>  		dma_pool_free(sdev->pool, v_lli, p_lli);
> +		v_lli =3D next_v_lli;
> +		p_lli =3D next_p_lli;
> +	}
>  	kfree(txd);
>  	return NULL;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is there a deadlock risk due
to incompatible lock contexts for sdev->lock?

The spinlock sdev->lock is taken by sun6i_dma_tasklet() in softirq context:

	spin_lock_irq(&sdev->lock);

However, sun6i_dma_pause() and sun6i_dma_terminate_all() acquire the lock
without disabling softirqs:

	spin_lock(&sdev->lock);
	list_del_init(&vchan->node);
	spin_unlock(&sdev->lock);

If a process thread holds the lock and a hardware interrupt schedules the
tasklet, could the tasklet execute on the same CPU, attempt to acquire
sdev->lock with spin_lock_irq(), and spin forever because the preempted
process still holds it?

[Severity: High]
This is a pre-existing issue, but does a TOCTOU race condition exist
between sun6i_dma_interrupt() and sun6i_dma_terminate_all()?

In sun6i_dma_terminate_all(), the channel is stopped and pchan->desc is set
to NULL concurrently under vchan->vc.lock:

		vchan->phy =3D NULL;
		pchan->vchan =3D NULL;
		pchan->desc =3D NULL;
		pchan->done =3D NULL;

Meanwhile, the interrupt handler sun6i_dma_interrupt() processes the
completion:

				if (vchan->cyclic) {
					vchan_cyclic_callback(&pchan->desc->vd);
				} else {
					spin_lock(&vchan->vc.lock);
					vchan_cookie_complete(&pchan->desc->vd);

In the cyclic case, the handler dereferences pchan->desc->vd locklessly. In
the non-cyclic case, it waits on vchan->vc.lock but doesn't re-validate
pchan->desc after acquiring the lock. Could this lead to a NULL pointer
dereference if the descriptor is cleared by sun6i_dma_terminate_all() on
another CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611063631.9656=
6-1-zenghongling@kylinos.cn?part=3D1

