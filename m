Return-Path: <dmaengine+bounces-11506-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AepAIQBlL2q7/gQAu9opvQ
	(envelope-from <dmaengine+bounces-11506-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 04:35:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED1682E44
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 04:35:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q7VCK1wm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11506-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11506-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE5B300578B
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 02:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EDA2459C5;
	Mon, 15 Jun 2026 02:35:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC62472B6;
	Mon, 15 Jun 2026 02:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490941; cv=none; b=CPYavwmZGFfoldo94gxR/vR64t+3CDaBYoaUJhrP3xCgoByTGHiKrrSAHGLjjIFQTKyUQ+8aRqX4PX9WriO1CLJYDElnmAJl8Y9G8/bUodwzi+ddrfZpWug/3nU4Gdf2fQtFQNadj9/5n2Nt3y7P5eGqlGTTsS0PL8l+LdlAA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490941; c=relaxed/simple;
	bh=V/g+P/fTydolpiKmdLIUeI/weZhzltUn+ycsw1YHt6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EkHpC+H89hfzmKAGWJCgHAzEudQSbcXBBrNo0UyBV9WJrzWNmm132OFrn0UeEU9S3ly8w1p5KgtVcLbHvsYkLZx3PhxABXrC0lELtQFHRd28eQkCEXO+3Tpbw5l78gkpx+7KRuN32ZcLlPz+aui5T7IC/4I6HfxSeIFe21/rKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7VCK1wm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB211F000E9;
	Mon, 15 Jun 2026 02:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781490939;
	bh=jk3EYKdsJqglnPEO4r0CaWOPlZC2zPDGQfGdzMvJc9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q7VCK1wmyEtV2HWQdnKMsk7c89tjPE7koPApbBTmX1xAcAPkrlW0BEq1vNuImZ4g1
	 VPModRwDDC630M7RWQRP9+yN4dZpisfaCFEj7FFyyvE6uJ3OHDgpS2u2QPZeke2gd7
	 Hmi+Oee1vTt4lt1u/riorWt4XPytvKNetZQXVmoncEJN8N4kO+MPdtuFGzCI07epel
	 dKSY0Hmw21iFhNX6v9DA6Dc4cBrOL3trXfFchx/5KE6cAjlyZ+hTA0hs7AlI7r/CEO
	 aVOafzc+D3DsEbeDypihBNCWs1CxEx+vnY7M3HQlR6L94sM5GjbWxWN+inuvVT+35Z
	 jHzjWDwUiu0Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: sun6i-dma: Fix use-after-free in error
 handling paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: linux-sunxi@lists.linux.dev, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260615022400.13454-1-zenghongling@kylinos.cn>
References: <20260615022400.13454-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 02:35:38 +0000
Message-Id: <20260615023539.4FB211F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11506-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:linux-sunxi@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6ED1682E44

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation for `sg_len =3D=3D 0` in `sun6i_dma_prep_slave_=
sg()` allows the creation of an empty descriptor, leading to a NULL pointer=
 dereference or wild DMA execution.
- [High] Missing parameter validation in `sun6i_dma_prep_dma_cyclic()` allo=
ws division-by-zero exceptions and NULL pointer dereferences.
- [High] Unprotected access to `pchan->desc` in the interrupt handler can r=
ace with `sun6i_dma_terminate_all()`, causing a NULL pointer dereference.
- [High] Process-context use of plain `spin_lock()` on a lock shared with a=
 tasklet causes softirq preemption deadlocks.
- [Medium] Hardware race in `sun6i_get_chan_size()` inflates residue report=
s due to unverified sequential register reads.
--

commit d4e1b819645de3459092e86e1c23dd821c23cfce
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix use-after-free in error handling paths

This commit addresses a use-after-free bug in the error handling paths of
sun6i_dma_prep_slave_sg() and sun6i_dma_prep_dma_cyclic(). The variables
v_lli and p_lli were accessed in the loop increment expression after the
loop body freed them. A new helper function, sun6i_dma_free_lli_list(), is
introduced to safely traverse and free the list.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..02dd07001d5a9 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c

[ ... ]

> @@ -788,9 +794,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_slave_sg(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> +	sun6i_dma_free_lli_list(sdev, txd);

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem earlier
in sun6i_dma_prep_slave_sg(). If the function is called with sg_len
equal to 0, the for_each_sg() loop is bypassed entirely:

	for_each_sg(sgl, sg, sg_len, i) {

This allows the creation of an empty descriptor where txd->v_lli is NULL
and txd->p_lli is 0. Does this lead to a NULL pointer dereference or wild
DMA execution when the DMA engine starts the transaction via
sun6i_dma_start_desc()?

drivers/dma/sun6i-dma.c:sun6i_dma_start_desc() {
	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
	writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);
}

Additionally, if dynamic debug is enabled, would sun6i_dma_dump_lli()
unconditionally dereference the NULL v_lli pointer before the function
returns?

>  	kfree(txd);
>  	return NULL;
>  }
> @@ -869,9 +873,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_dma_cyclic(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> +	sun6i_dma_free_lli_list(sdev, txd);

[Severity: High]
This is a pre-existing issue, but I spotted a potential problem earlier in
sun6i_dma_prep_dma_cyclic() where we calculate periods:

	unsigned int i, periods =3D buf_len / period_len;

Is validation missing for period_len here, potentially causing a
division-by-zero exception if it is 0?

Additionally, if buf_len < period_len, the calculated periods is 0,
which bypasses the allocation loop. This leaves the prev pointer
initialized as NULL, which then causes a NULL pointer dereference
here:

	prev->p_lli_next =3D txd->p_lli;		/* cyclic list */

>  	kfree(txd);
>  	return NULL;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed unprotected access to
pchan->desc in the interrupt handler which might race with
sun6i_dma_terminate_all():

drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
			pchan =3D sdev->pchans + j;
			vchan =3D pchan->vchan;
			if (vchan && (status & vchan->irq_type)) {
				if (vchan->cyclic) {
					vchan_cyclic_callback(&pchan->desc->vd);
				} else {
					spin_lock(&vchan->vc.lock);
					vchan_cookie_complete(&pchan->desc->vd);
}

Could the lockless read of vchan followed by dereferencing pchan->desc
allow a NULL pointer dereference if sun6i_dma_terminate_all()
concurrently runs on another CPU?

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
		vchan->phy =3D NULL;
		pchan->vchan =3D NULL;
		pchan->desc =3D NULL;
}

[Severity: High]
This is a pre-existing issue, but process-context use of plain spin_lock()
on a lock shared with a tasklet seems to cause softirq preemption deadlocks.

drivers/dma/sun6i-dma.c:sun6i_dma_pause() {
		spin_lock(&sdev->lock);
		list_del_init(&vchan->node);
		spin_unlock(&sdev->lock);
}

Since sun6i_dma_tasklet() runs in softirq context and acquires sdev->lock
using spin_lock_irq():

drivers/dma/sun6i-dma.c:sun6i_dma_tasklet() {
	spin_lock_irq(&sdev->lock);
}

If a hardware interrupt fires while the lock is held in process context,
would the interrupt exit path execute pending softirqs on the same CPU,
causing the tasklet to attempt to acquire sdev->lock and spin indefinitely?

[Severity: Medium]
This is a pre-existing issue, but unverified sequential register reads
in sun6i_get_chan_size() might create a race condition.

drivers/dma/sun6i-dma.c:sun6i_get_chan_size() {
	pos =3D readl(pchan->base + DMA_CHAN_LLI_ADDR);
	bytes =3D readl(pchan->base + DMA_CHAN_CUR_CNT);
}

If the DMA hardware advances to the next Linked List Item (LLI) exactly
between these reads, can pos hold the old LLI address but bytes hold the
new LLI's remaining byte count? This might double-count the new LLI's bytes
when iterating through the software list, reporting an artificially inflated
residue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615022400.1345=
4-1-zenghongling@kylinos.cn?part=3D1

