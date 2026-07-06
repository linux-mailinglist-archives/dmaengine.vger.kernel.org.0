Return-Path: <dmaengine+bounces-12043-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0/CUBOpYS2o0PwEAu9opvQ
	(envelope-from <dmaengine+bounces-12043-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 09:27:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDABA70D865
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 09:27:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eOzkWoUu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12043-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12043-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41E6E301CF7D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E034D2EEE;
	Mon,  6 Jul 2026 06:56:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0F3EDE6E;
	Mon,  6 Jul 2026 06:56:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321017; cv=none; b=nW2jA5NUuDcOO8FlDxJc5+WBBhfno76xR1QLpsQcM15lmOkJzC6h5TQqNgl4LREHsZ6//zeIWD+oMVuLYOrKy0SyMpcCDbpW5iwQncLTDj8dAw64+2yTdXGqSX3XzYsYLjOLu1oiT9b1PYMotIlpa3hMVL7DFEW4psqBdnfFuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321017; c=relaxed/simple;
	bh=CgfMcY8N8XcITP9lpcIUdjAIWdtmnwPr1UFiHe6glOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K+Bi6EacsMzqS8hBExt+68AjGqQOZwrWf+26rxGeM3zyflKcDRiFrwvLprkfrfGf1tGpl2FrE5h9K8N5lOz2wBTMvL6Zac54sOSkLn/U8AOZVS6dODxnDDKLL9xPdN9udc3vrh/btp43JliWUJPaNnn5thKVhBKR/srTw0dzdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOzkWoUu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B131F00A3A;
	Mon,  6 Jul 2026 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783321010;
	bh=WusjoFTD8dNRYcHTwu4R/vsKTVbNud5Rc92n8HdhQ3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOzkWoUu3GuelVNCPe0OtZ6awhEMPbosWMBu52tsaZuVXUt6suHVUlFHCanq4Am91
	 QsWhZRJuajy/2rb66p97ow65FhWKc7Kx1Xevb8lT2K2EPfTWWsr1T37gp7ZWS/oJQF
	 VolmIwdPb26fE20FJkbq1WokcV3nQ+UFSTBSZ0eZmtFHu6d7gwgJE+hrYXOjveRtYo
	 bbrg32cMSI7vbru7JnKpKSi7Av1r+8uRG/yAfI4KkRhhAu+zAEqOaDzaej+PJICFUv
	 nSfVHXJ7q3Teey7FmkKyy7GWXge6psyiwq/kDpiK+sgghdnIPniVUuRo/IzbBLVV+j
	 XxMrAzcVvdvNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: sun6i: Fix physical channel index in
 interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260706064123.66035-1-zenghongling@kylinos.cn>
References: <20260706064123.66035-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 06:56:49 +0000
Message-Id: <20260706065650.34B131F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12043-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:linux-sunxi@lists.linux.dev,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDABA70D865

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing interrupt handling for higher DMA channels due to truncati=
ng integer division.
- [High] TOCTOU race condition in `sun6i_dma_interrupt` leads to NULL point=
er dereference.
- [High] Softirq deadlock in `sun6i_dma_pause` and `sun6i_dma_terminate_all=
` due to unprotected `sdev->lock` acquisition.
- [High] TOCTOU race reading `vchan->phy` locklessly causing DMA memory cor=
ruption (use-after-free on target buffers).
--

commit b276e8e28f169d8ad907c8404d5562072f082f83
Author: Hongling Zeng <zenghongling@kylinos.cn>
dmaengine: sun6i: Fix physical channel index in interrupt handler

This commit fixes a bug where SoCs with more than 8 DMA channels incorrectly
routed interrupts from higher physical channels to physical channels 0-7. It
updates the physical channel lookup to use the absolute channel index inste=
ad
of just the inner loop index.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..3e03d39e25aa6 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -543,21 +543,21 @@ static irqreturn_t sun6i_dma_interrupt(int irq, voi=
d *dev_id)
>  	struct sun6i_vchan *vchan;
>  	struct sun6i_pchan *pchan;
>  	int i, j, ret =3D IRQ_NONE;
>  	u32 status;
> =20
>  	for (i =3D 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {

[Severity: High]
This is a pre-existing issue, but does this loop condition skip higher
channels on some SoCs?

Since DMA_IRQ_CHAN_NR is 8, if sdev->num_pchans is not a multiple of 8 (for
example 12 on Allwinner H3), the truncating division (12 / 8 =3D 1) causes =
the
loop to only check i =3D 0 (channels 0-7). The interrupts for channels 8-11
would remain unacknowledged, which might lead to an interrupt storm.

Could this be fixed by using DIV_ROUND_UP(sdev->num_pchans, DMA_IRQ_CHAN_NR=
)?

>  		status =3D readl(sdev->base + DMA_IRQ_STAT(i));
>  		if (!status)
>  			continue;
> =20
>  		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
>  			str_high_low(i), status);
> =20
>  		writel(status, sdev->base + DMA_IRQ_STAT(i));
> =20
>  		for (j =3D 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
> -			pchan =3D sdev->pchans + j;
> +			pchan =3D sdev->pchans + i * DMA_IRQ_CHAN_NR + j;
>  			vchan =3D pchan->vchan;
>  			if (vchan && (status & vchan->irq_type)) {
>  				if (vchan->cyclic) {
>  					vchan_cyclic_callback(&pchan->desc->vd);
>  				} else {
>  					spin_lock(&vchan->vc.lock);
>  					vchan_cookie_complete(&pchan->desc->vd);
>  					pchan->done =3D pchan->desc;
>  					spin_unlock(&vchan->vc.lock);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to locklessly cac=
he
pchan->vchan and then dereference pchan->desc inside the lock?

If sun6i_dma_terminate_all() is called concurrently on another CPU:

CPU1 (terminate_all):
    spin_lock(&vchan->vc.lock);
    vchan->phy =3D NULL;
    pchan->vchan =3D NULL;
    pchan->desc =3D NULL;
    spin_unlock(&vchan->vc.lock);

CPU2 (sun6i_dma_interrupt):
    vchan =3D pchan->vchan; // Read locklessly before CPU1 sets it to NULL
    ...
    spin_lock(&vchan->vc.lock); // Waits for CPU1
    vchan_cookie_complete(&pchan->desc->vd); // pchan->desc is now NULL

Could this lead to a NULL pointer dereference in vchan_cookie_complete()?

>  				}
>  			}
> =20
>  			status =3D status >> DMA_IRQ_CHAN_WIDTH;
>  		}

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the lock acquisition in
sun6i_dma_pause() and sun6i_dma_terminate_all() risk a softirq deadlock?

In sun6i_dma_pause():

drivers/dma/sun6i-dma.c:sun6i_dma_pause() {
    spin_lock(&sdev->lock);
    list_del_init(&vchan->node);
    spin_unlock(&sdev->lock);
}

And similarly in sun6i_dma_terminate_all(). Since these functions acquire
sdev->lock without disabling softirqs, could they deadlock if preempted by
sun6i_dma_tasklet() running in softirq context on the same CPU, which calls
spin_lock_irq(&sdev->lock)?

[Severity: High]
This isn't a bug introduced by this patch, but does sun6i_dma_terminate_all=
()
have a race condition when reading vchan->phy locklessly?

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
    struct sun6i_pchan *pchan =3D vchan->phy;
    ...
    spin_lock_irqsave(&vchan->vc.lock, flags);
    ...
    if (pchan) {
        writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);
    ...
}

If sun6i_dma_tasklet() concurrently allocates a physical channel and updates
vchan->phy right after this lockless read, pchan will remain NULL locally.
The hardware stop command would be skipped, allowing the DMA hardware to
continue running while the caller assumes it has been stopped. Can this lead
to memory corruption if the caller frees or reuses the target buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706064123.6603=
5-1-zenghongling@kylinos.cn?part=3D1

