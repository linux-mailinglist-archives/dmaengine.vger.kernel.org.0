Return-Path: <dmaengine+bounces-11909-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pg0iCF6hRGq/yAoAu9opvQ
	(envelope-from <dmaengine+bounces-11909-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 07:10:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 122336E9C96
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 07:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EsG4HZMW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11909-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11909-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C652300C39E
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 05:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1535D363082;
	Wed,  1 Jul 2026 05:10:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA819D07E;
	Wed,  1 Jul 2026 05:10:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882647; cv=none; b=naCVBn+dp5E3wRTc5AyOehXaHWRp+9QUgBjkMdTvuIZX7ikBeNNT6WuFFkC8AXPFySHJ/GRV0pksyO7QN5GP6497PkFdODW7n5QqVUiFrEVi5l3rZnDd+YXwXlPaDssoZc2J/Em90dQVxuRX8MplWNxWn1mi+2o9vdnLud+KAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882647; c=relaxed/simple;
	bh=fmVcC1KSc5v3+423moyB5Rrb1i5/arRehkvnhLwdVBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CIDO4yahTF4SEZRiDitHaSHfNrN/e0kTH39ZwmLxBTAM+QLpDaFj8AHKpEvOIbcPUa+UWDmMsPlVrXeEa/SEbDfvjq98UleyJLmNNyGBXOJAzvol0a4HR6o4kbxItBi9Rk0Lg7dSI2JNb7+aDgA9aVbhqhY1cCwKwuq5SP2ADto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsG4HZMW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC4D1F000E9;
	Wed,  1 Jul 2026 05:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782882645;
	bh=5n3CCM2CuKZtgiHOu6GkBm9+I5RN7Var9z0aMoAmeXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsG4HZMWx/o/hBY7tNBVDXuS/uv8m69aPqNsddnu5lmTUpuAUjB3ashmqq3Mm5NsQ
	 Cv75AQRVl0aA2oybI00XfH/UEAWSxpez3h7fcuY/Flc8b83zPV35InV6+W9UMGy0dy
	 wb5ObggUiqxWSjb4IiR5FL29oprmCKj5t5PBnVde+aMCgQPbLtTIXh1JluTqKTjRDL
	 dBgRI5iPpRCeOegRqRl2LrQ8mInF4h5Rj+aed2PlbTjm4eUTVUsir531KNHECJGCD9
	 hQSFC1frlRoXzfbH/7cPPIobb3VeBjMskD7NvEVwl2gydJso1dWbOI/vdc25rU7zj+
	 3zHw2DNjns3HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] dmaengine: sun6i-dma: Fix reclaim descriptors while
 terminating DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260701045733.33654-1-zenghongling@kylinos.cn>
References: <20260701045733.33654-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:10:44 +0000
Message-Id: <20260701051045.3BC4D1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11909-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 122336E9C96

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected out-of-lock read of `vchan->phy` leads to a severe TOC=
TOU race causing list corruption and wrong channel teardown.
- [High] TOCTOU race in hardware interrupt handler leads to a fatal NULL po=
inter dereference when terminating DMA.
- [High] Missing IRQ masking when acquiring `sdev->lock` in process context=
 causes a deadlock with the softirq tasklet.
- [High] Incorrect array indexing in `sun6i_dma_interrupt` incorrectly rout=
es upper hardware channels to lower channel states.
--

commit 494d0d1002ddd0015efbf5a3a6ef1f6894fb2914
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix reclaim descriptors while terminating DMA

This commit updates sun6i_dma_terminate_all() to use vchan_terminate_vdesc(=
)=20
so that both cyclic and non-cyclic descriptors are properly reclaimed. It=20
also adds a check to prevent double-adding completed descriptors to the lis=
t.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..f47a326dd7ffa 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -945,16 +945,13 @@ static int sun6i_dma_terminate_all(struct dma_chan =
*chan)
> =20

[Severity: High]
This is a pre-existing issue, but just above this hunk, the function acquir=
es
sdev->lock using a plain spin_lock():

sun6i_dma_terminate_all() {
        ...
        spin_lock(&sdev->lock);
        list_del_init(&vchan->node);
        spin_unlock(&sdev->lock);

Could this plain spin_lock cause a deadlock?

Since this is called from process context, hardware interrupts remain
enabled. If a DMA interrupt fires on this CPU while the lock is held,
the softirq can execute sun6i_dma_tasklet() which attempts to acquire
the same lock with spin_lock_irq():

sun6i_dma_tasklet() {
        spin_lock_irq(&sdev->lock);
}

Could this cause the tasklet to spin forever waiting for the interrupted
process to release it? The same pattern appears in sun6i_dma_pause().

>  	spin_lock_irqsave(&vchan->vc.lock, flags);
> =20
> -	if (vchan->cyclic) {
> -		vchan->cyclic =3D false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd =3D &pchan->desc->vd;
> -			struct virt_dma_chan *vc =3D &vchan->vc;
> +	if (pchan && pchan->desc && pchan->desc !=3D pchan->done) {
> +		struct virt_dma_desc *vd =3D &pchan->desc->vd;
> =20
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +		vchan_terminate_vdesc(vd);

[Severity: High]
This is a pre-existing issue, but is it safe to trust the pchan pointer
here?

The pchan pointer is read locklessly at the start of the function
(struct sun6i_pchan *pchan =3D vchan->phy;). If a tasklet runs concurrently
before the locks are acquired, couldn't it complete the current descriptor,
free this physical channel, and reallocate it to a different virtual
channel?

If that happens, this code would evaluate the stale pointer inside the
critical section and mistakenly call vchan_terminate_vdesc() on another
channel's descriptors.

>  	}
> =20
> +	vchan->cyclic =3D false;
>  	vchan_get_all_descriptors(&vchan->vc, &head);
> =20
>  	if (pchan) {

[Severity: High]
This is a pre-existing issue, but inside this if block, the descriptor
pointer is cleared:

sun6i_dma_terminate_all() {
        ...
        if (pchan) {
                ...
                pchan->desc =3D NULL;
        }
}

Could clearing the descriptor pointer here race with the interrupt handler?

If another CPU is actively processing a hardware interrupt when this channel
is terminated:

CPU1: sun6i_dma_interrupt() validates vchan locklessly
CPU2: sun6i_dma_terminate_all() sets pchan->desc =3D NULL;
CPU1: sun6i_dma_interrupt() calls vchan_cyclic_callback(&pchan->desc->vd);

Would this lead to a NULL pointer dereference when evaluating the
descriptor on CPU1?


While reviewing the driver, I noticed another pre-existing issue in
sun6i_dma_interrupt():

drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
        ...
        for (i =3D 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
                ...
                for (j =3D 0; j < DMA_IRQ_CHAN_NR; j++) {
                        ...
                        pchan =3D sdev->pchans + j;

[Severity: High]
This is a pre-existing issue, but does this inner loop incorrectly route
upper-bank interrupts to the lower physical channels?

For SoCs with more than 8 DMA channels, the outer loop checks register
banks (i =3D 0, 1). However, the physical channel lookup uses
sdev->pchans + j instead of including the offset for the current bank
(sdev->pchans + i * DMA_IRQ_CHAN_NR + j).

Could an interrupt from physical channel 8 or above incorrectly process
the virtual channel attached to physical channel 0, potentially causing
descriptors to complete for the wrong channel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701045733.3365=
4-1-zenghongling@kylinos.cn?part=3D1

