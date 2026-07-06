Return-Path: <dmaengine+bounces-12039-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OTsJA9MgS2qsMAEAu9opvQ
	(envelope-from <dmaengine+bounces-12039-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 05:28:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109270C512
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 05:28:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="cY3rZJ/5";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12039-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12039-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84863011845
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76D73AD520;
	Mon,  6 Jul 2026 03:27:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE53A9002;
	Mon,  6 Jul 2026 03:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783308466; cv=none; b=PO4a3GXWqOiD8XPWHOYzuQ2XgaHj+9Gq3xMOThyZaaFcqxvSg+anuoXZQE/eU0LcTX6UFeixSNIvhR5/jyx96dt1IUnnG0fZYiTiDnPT26ezVaTY7KD36NJBT6gF81QKZ3xb/8kBgmTg2Dq9GKEk3gPTlDBb947JQHKF93XY9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783308466; c=relaxed/simple;
	bh=7NS4NaGBKdPgNPL+Y/dEjH+hsgsM1QQ6anhA6onxOWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVLzHwGw+LIEatrcuSe8UoRI7dY7AJi+Rzq+MDNkETXjNoFnZ5XD8GYoey3LHDFYuwNvcBZngNvxiZTgVKGvxuc6o2kfIgIEXGZE2ohGZGQM8VDM3ucNcO+6hd+TVyKsqOimioAMKBan7/LSKovDdWVgUKYPUrJMfkizauH2kzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY3rZJ/5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251AB1F000E9;
	Mon,  6 Jul 2026 03:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783308465;
	bh=JnlSTJPDUIN6XFkMdhMfIw/K81qVvOHjxzP4Vl4zZqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cY3rZJ/5RnmcNAans6SJ4uCIyfFdthCF+L+DX524etab6SpofAeE5c/SOf4tfvtkO
	 a+HnFA8D0he12+mWy1JbbRsO1qJD0+3fk2f+oFTQmVYmwmNDxSvqDh/SEF+Aouu0KN
	 XkXEcOgtcUuLm+Eb1l6H2bOsfW+nzsVg5KCeHI120dGy2kKAg2R6OYtDTr3s2er7yU
	 9VpYr1EJRJNwkZkm7YE5LK7gFceJvx8U5TUoN6V0FsBMmzB5Is3rICsJEaY1JxUXa7
	 cqj4UJ1kyiOcZp5bnh+uV0XnUjsuc1k8tIlBjonzDBRIJsamZ0hSV5oec/s8mIxxQc
	 ll/qxpaYK83kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: sun6i: Fix potential deadlock on
 sdev->lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260706031721.24415-1-zenghongling@kylinos.cn>
References: <20260706031721.24415-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:27:43 +0000
Message-Id: <20260706032744.251AB1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12039-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,kylinos.cn:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5109270C512

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The DMA interrupt handler erroneously uses the relative inner =
loop index `j` to resolve physical channels, causing false transfer complet=
ions and silent memory corruption for channels >=3D 8.
- [High] Unprotected read of `vchan->phy` before acquiring locks creates se=
vere TOCTOU races, risking memory corruption and crashes.
- [High] Concurrent execution of `sun6i_dma_interrupt` and `sun6i_dma_termi=
nate_all` causes a NULL pointer dereference on `pchan->desc`.
- [High] Calling `sun6i_dma_resume` on an already pending channel corrupts =
the `sdev->pending` list.
- [High] `sun6i_dma_terminate_all()` permanently leaks the active descripto=
r and its DMA pool entries for non-cyclic transfers.
- [High] Use-after-free when traversing the LLI linked list in the error ha=
ndling paths of `sun6i_dma_prep_slave_sg()` and `sun6i_dma_prep_dma_cyclic(=
)`.
--

commit b092144f027cb09b10f743f59c347030a2c17b8c
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i: Fix potential deadlock on sdev->lock

sun6i_dma_terminate_all() and sun6i_dma_pause() acquire sdev->lock
with plain spin_lock() from process context. If a DMA interrupt fires
on the same CPU while the lock is held, the interrupt handler schedules
sun6i_dma_tasklet(), which runs in softirq context and attempts to
acquire the same lock with spin_lock_irq(), causing a deadlock.

Cc: stable@vger.kernel.org

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..a6487971ad09e 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -891,6 +891,7 @@ static int sun6i_dma_pause(struct dma_chan *chan)
>  	struct sun6i_dma_dev *sdev =3D to_sun6i_dma_dev(chan->device);
>  	struct sun6i_vchan *vchan =3D to_sun6i_vchan(chan);
>  	struct sun6i_pchan *pchan =3D vchan->phy;

[Severity: High]
This isn't a bug introduced by this patch, but vchan->phy is read without
holding vchan->vc.lock. Can this allow pchan to become stale if the
tasklet completes the transfer and reassigns the physical channel to a
different virtual channel before the locks are acquired?

> +	unsigned long flags;
> =20
>  	dev_dbg(chan2dev(chan), "vchan %p: pause\n", &vchan->vc);
> =20
> @@ -898,9 +899,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
>  		writel(DMA_CHAN_PAUSE_PAUSE,
>  		       pchan->base + DMA_CHAN_PAUSE);
>  	} else {
> -		spin_lock(&sdev->lock);
> +		spin_lock_irqsave(&sdev->lock, flags);
>  		list_del_init(&vchan->node);
> -		spin_unlock(&sdev->lock);
> +		spin_unlock_irqrestore(&sdev->lock, flags);
>  	}
> =20
>  	return 0;

[ ... ]

> @@ -939,9 +940,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *c=
han)

[Severity: High]
This is a pre-existing issue, but vchan->phy is read unlocked in this
function as well. Could the stale pchan be used to modify hardware registers
and descriptor lists for the wrong transfer inside the lock?

>  	unsigned long flags;
>  	LIST_HEAD(head);
> =20
> -	spin_lock(&sdev->lock);
> +	spin_lock_irqsave(&sdev->lock, flags);
>  	list_del_init(&vchan->node);
> -	spin_unlock(&sdev->lock);
> +	spin_unlock_irqrestore(&sdev->lock, flags);
> =20
>  	spin_lock_irqsave(&vchan->vc.lock, flags);


[Severity: High]
This isn't a bug introduced by this patch, but does sun6i_dma_terminate_all=
()
permanently leak the active descriptor and its DMA pool entries for non-cyc=
lic
transfers?

When a transfer is aborted, the code clears pchan->desc:

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
	...
	if (vchan->cyclic) {
		vchan->cyclic =3D false;
		if (pchan && pchan->desc) {
			...
			list_add_tail(&vd->node, &vc->desc_completed);
		}
	}

	vchan_get_all_descriptors(&vchan->vc, &head);

	if (pchan) {
		...
		pchan->desc =3D NULL;
	}
	...
}

It doesn't append the active descriptor to any cleanup list for non-cyclic
transfers before clearing it, which means vchan_get_all_descriptors() fails
to capture it.


[Severity: Critical]
This is a pre-existing issue, but does the DMA interrupt handler erroneously
use the relative inner loop index 'j' to resolve physical channels?

drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
	...
	for (i =3D 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
		...
		for (j =3D 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
			pchan =3D sdev->pchans + j;
	...
}

On SoCs with more than 8 channels, shouldn't this use the absolute index
(i * DMA_IRQ_CHAN_NR + j)? Using 'j' always resolves to channels 0-7, which
could falsely complete unrelated channels and cause silent memory corruption
for channels >=3D 8.


[Severity: High]
This isn't a bug introduced by this patch, but can concurrent execution of
sun6i_dma_interrupt() and sun6i_dma_terminate_all() cause a NULL pointer
dereference?

In the hard IRQ handler, sun6i_dma_interrupt() acquires the lock and
unconditionally dereferences pchan->desc:

drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
	...
	if (vchan && (status & vchan->irq_type)) {
		if (vchan->cyclic) {
			vchan_cyclic_callback(&pchan->desc->vd);
		} else {
			spin_lock(&vchan->vc.lock);
			vchan_cookie_complete(&pchan->desc->vd);
			pchan->done =3D pchan->desc;
			spin_unlock(&vchan->vc.lock);
		}
	}
	...
}

If sun6i_dma_terminate_all() runs concurrently, it acquires vchan->vc.lock,
forcefully stops the channel, and sets pchan->desc =3D NULL. When the inter=
rupt
handler subsequently acquires the lock, wouldn't it dereference the NULL
pchan->desc?


[Severity: High]
This is a pre-existing issue, but does calling sun6i_dma_resume() on an
already pending channel corrupt the sdev->pending list?

drivers/dma/sun6i-dma.c:sun6i_dma_resume() {
	...
	} else if (!list_empty(&vchan->vc.desc_issued)) {
		spin_lock(&sdev->lock);
		list_add_tail(&vchan->node, &sdev->pending);
		spin_unlock(&sdev->lock);
	}
	...
}

Unlike sun6i_dma_issue_pending(), this fails to check
!list_empty(&vchan->node) before adding the node. If a channel is already
waiting in the sdev->pending list, couldn't this re-addition corrupt the
list pointers?


[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
when traversing the LLI linked list in the error handling paths?

drivers/dma/sun6i-dma.c:sun6i_dma_prep_slave_sg() {
	...
err_lli_free:
	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
		dma_pool_free(sdev->pool, v_lli, p_lli);
	...
}

The loop body frees v_lli immediately, but the loop's update expression
then reads v_lli->p_lli_next and v_lli->v_lli_next from the just-freed
memory. This same pattern also appears in sun6i_dma_prep_dma_cyclic().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706031721.2441=
5-1-zenghongling@kylinos.cn?part=3D1

