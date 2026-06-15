Return-Path: <dmaengine+bounces-11516-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RW2DLp7GL2oHGQUAu9opvQ
	(envelope-from <dmaengine+bounces-11516-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 11:32:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBB68513A
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 11:32:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JJM+k9bd;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11516-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11516-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C593017BD9
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B47211A14;
	Mon, 15 Jun 2026 09:32:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962533C194
	for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 09:32:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515930; cv=none; b=EjZh67lXOrCkJTpfm6iTqRKJZ+jHVpxkE5HO7fGAf8s0vYYzrkxH1Wjtd484mU7RHKuuwvurlt/wKjdz8Dv0ooAbHz0VJrEGwTLfXA4HnTQVRIaISqRE51d+G8lYA9V8U0OTVQ7Hn5FoW7Txuc7TW7qdbLpBNHUVVepZDjU24Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515930; c=relaxed/simple;
	bh=3KVAPw0s3OzcXn6m81O6julVuvl652ZtLHGwjq1EMA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhtCUY8qRjX3qyf6vktQnItV4hPcslXs6ARZcJGeHbouR/KmPQ65wSChkaWggsVVSX+VkjvlSWSItniZLfjbHjPCz6DXkpW/0ZcyZNeFE8uggjj5GQ6nOLtZYh0ddOf5xiVCulptGzNntqzPjA6MgBe1yh3IVFbOawZip2CXUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJM+k9bd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE98B1F00A3A;
	Mon, 15 Jun 2026 09:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781515929;
	bh=w2l5k2hhc9+RCmNBJaxINScrN9UnBKpSIzqMkZaXiM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJM+k9bd7D1LbJ6ZBSNWYV5qENT6Pgix58eX1IoaJZaRW3IjEA/nbeWC0E0qf+VI5
	 DO+mBgySddi+Azvj/piau3KDOcosWJYALwn4D+/MuDb570rJAFdrIRK1H+LkUxsSGj
	 QIzbwzvAfiR3WKO+oh7kfY1I2Kwlnll6xydkZ8EnbmOcIGlywe4Jh2CwgoQk5Y9Lnx
	 +ej9pkRQ5fWPliVJG+4Zs+Qav0oiDJBnwofvEoNINU64ZokKAiRBHqXpEPS8SavbZz
	 hkze0BvhGZEULFBiI60s0Yp5Wq3nWM7aAi3pIie2CIGQJeXpuNOnHcCVXirpQrsw5W
	 IaQOkFkdJWMFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: pl330: remove debugfs file on teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260615091645.28878-1-pengpeng@iscas.ac.cn>
References: <20260615091645.28878-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 09:32:08 +0000
Message-Id: <20260615093208.EE98B1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11516-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,iscas.ac.cn:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09BBB68513A

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent modification of the shared `desc_pool` list without=
 acquiring `pool_lock` causes list corruption.
- [High] The IRQ handler is registered before the driver state is fully ini=
tialized, allowing the interrupt handler to run and access uninitialized da=
ta structures if an interrupt fires early.
- [High] Inconsistent lock acquisition order between the per-channel `pch->=
lock` and the device-wide `pl330->lock` creates an AB-BA deadlock.
- [High] Potential NULL pointer dereference in `pl330_debugfs_show()` due t=
o an unprotected TOCTOU data race on `pch->thread`.
--

commit e5237f92634c12f29e973c872d0bf6600d10e173
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

dmaengine: pl330: remove debugfs file on teardown

init_pl330_debugfs() creates a debugfs file with struct pl330_dmac as
private data. pl330_remove() then unregisters the DMA device and frees
the PL330 channel/thread state without removing that file. This commit
adds the cleanup of the debugfs dentry during teardown to prevent a
use-after-free.

> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 25ba84b187041..6214d9000db8e 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c

[ ... ]

> @@ -2952,14 +2953,24 @@ DEFINE_SHOW_ATTRIBUTE(pl330_debugfs);

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
debugfs lifecycle, is there a potential NULL pointer dereference in
pl330_debugfs_show() due to a data race on pch->thread?

In pl330_debugfs_show(), the code checks:

    if (!pch->thread || thrd->id !=3D pch->thread->id)

This happens without holding pl330->lock or using READ_ONCE(). A concurrent
call to pl330_free_chan_resources() could set pch->thread =3D NULL between =
the
two evaluations. If the second load fetches NULL, evaluating pch->thread->id
would dereference a NULL pointer.

>  static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
>  {
> -	debugfs_create_file(dev_name(pl330->ddma.dev),
> -			    S_IFREG | 0444, NULL, pl330,
> -			    &pl330_debugfs_fops);
> +	pl330->dbgfs =3D debugfs_create_file(dev_name(pl330->ddma.dev),
> +					   S_IFREG | 0444, NULL, pl330,
> +					   &pl330_debugfs_fops);
>  }

[ ... ]

> @@ -3204,6 +3215,8 @@ static void pl330_remove(struct amba_device *adev)
>  	struct dma_pl330_chan *pch, *_p;
>  	int i, irq;
> =20
> +	deinit_pl330_debugfs(pl330);
> +
>  	pm_runtime_get_noresume(pl330->ddma.dev);
> =20
>  	if (adev->dev.of_node)
>  		of_dma_controller_free(adev->dev.of_node);
> =20
>  	for (i =3D 0; i < AMBA_NR_IRQS; i++) {
>  		irq =3D adev->irq[i];
>  		if (irq)
>  			devm_free_irq(&adev->dev, irq, pl330);
>  	}

[Severity: High]
This is a pre-existing issue, but looking at the IRQ handling, is there an
initialization race in pl330_probe()?

In pl330_probe(), devm_request_irq() is called before pl330_add():

drivers/dma/pl330.c:pl330_probe() {
    ...
    ret =3D devm_request_irq(&adev->dev, irq, pl330_irq_handler, 0,
                           dev_name(&adev->dev), pl330);
    ...
    ret =3D pl330_add(pl330);
}

However, pl330_add() is where critical state used by the interrupt handler
is initialized, such as the pl330->lock spinlock and pl330->tasks tasklet.
If an interrupt fires between the IRQ request and pl330_add(), wouldn't
pl330_irq_handler() attempt to lock an uninitialized spinlock?

>  	dma_async_device_unregister(&pl330->ddma);
> =20
>  	/* Idle the DMAC */
>  	list_for_each_entry_safe(pch, _p, &pl330->ddma.channels,
>  			chan.device_node) {
> =20
>  		/* Remove the channel */
>  		list_del(&pch->chan.device_node);
> =20
>  		/* Flush the channel */
>  		if (pch->thread) {
>  			pl330_terminate_all(&pch->chan);
>  			pl330_free_chan_resources(&pch->chan);

[Severity: Critical]
This isn't a bug introduced by this patch, but does calling
pl330_terminate_all() and pl330_free_chan_resources() here cause concurrent
modification of the shared desc_pool?

When descriptors are returned to the pool, the driver modifies the shared
desc_pool while only holding the per-channel pch->lock or the DMAC
pl330->lock, rather than the required pool_lock:

drivers/dma/pl330.c:pl330_free_chan_resources() {
    ...
    list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
    ...
}

Could this lead to list corruption if multiple channels perform unlocked
modifications concurrently?

[Severity: High]
This is also a pre-existing issue, but does this cleanup path introduce an
AB-BA deadlock?

In normal operating paths like pl330_tx_status(), the locks are acquired in
this order:

    spin_lock_irqsave(&pch->lock, flags);
    spin_lock(&pch->thread->dmac->lock);

However, pl330_free_chan_resources() acquires pl330->lock first, and then
calls pl330_release_channel(), which subsequently calls dma_pl330_rqcb()
where it acquires pch->lock:

drivers/dma/pl330.c:pl330_free_chan_resources() {
    spin_lock_irqsave(&pl330->lock, flags);
    ...
    pl330_release_channel(pch->thread);
        -> dma_pl330_rqcb()
            -> spin_lock_irqsave(&pch->lock, flags);

Could this reversed locking order deadlock if another CPU runs a state check
concurrently?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615091645.2887=
8-1-pengpeng@iscas.ac.cn?part=3D1

