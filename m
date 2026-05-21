Return-Path: <dmaengine+bounces-10624-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOTROhm0DmosBQYAu9opvQ
	(envelope-from <dmaengine+bounces-10624-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:28:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0AB5A0197
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C1003054515
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36059396D09;
	Thu, 21 May 2026 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx57IHv2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55A3815DD
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348298; cv=none; b=pdMjZXZlKdIRzEc+DJ+og28bTrTwPZLIElrg7/WOTikBkrn2GKK/6D0j3aEEHXo3eJgu0pr3uwVJ9n7pZnNupEqky7FWeCScT6QaZ7Et3vbFqj08W94aycCVuv9jiRc1csGoFDEksLf90RK545dlFvlebBr/UdvbF8RWMOf9usk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348298; c=relaxed/simple;
	bh=m5IDhNeRwMH8PP0OpflBBRv0Fn+xa1/ETaIzCWCGTPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rKNkgfC6WCZA3eqfr+3h17t/UgUVBOAR43Bq7sDZHjAYsdN9brQZZ9ti1hoVkoIUALmGvY0/XlIVxkPSTQki/jdMnA/L0hSI47/zzJy/oBWW1KkEUpKDQwGq4QSMLjXlxjPOaSk5Wu2i6l6hhSIKL81SBkupfeJg/bh/wfFe18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx57IHv2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AD21F00A3C;
	Thu, 21 May 2026 07:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779348294;
	bh=eZl/3GLROF5YGEmvAGhh4uYtr2y+7OA2muo7bv/g20Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xx57IHv2Kiv7tyrpPmPFSU4TK2rTMHiYw1P+6OcQ9AAWPgZB8k4r4OahDh3jBtkc+
	 XU4U/eCmYBn2dpIyKfeCObqEG24fMfvUlKr3C+Vj8/qbn1DgyT9nwootxjyw/o7nc3
	 1CMCVDKqIqZB99Mt9cvu7gxw4iXPKdeoNGoR5VaJSXwXHpXh853QNjww0JuiRtYkG4
	 L6+kNRkB+5FNS4h1DsmRvXJPNyG/QFnEdlQFFYLrAveGXHolt1s71p6v+FOwozKpYC
	 a7oUBdyZ1kFy7ru8hXLlNwwDsOEEX9HuzFVq7Sw+JtIEsy0TxiczlLlfP5qg9kO5qi
	 fMR1uiwxNCZ7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] dmaengine: dw-edma: Add partial channel ownership
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260521063115.2842238-5-den@valinux.co.jp>
References: <20260521063115.2842238-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 07:24:53 +0000
Message-Id: <20260521072453.E5AD21F00A3C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10624-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 5A0AB5A0197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The partial ownership check compares requested channels against a =
software-capped limit instead of the true hardware channel count.
- [High] Bypassing the global controller reset in partial mode leaves claim=
ed hardware channels uninitialized, risking runaway DMA and memory corrupti=
on.

Pre-existing issues:
- [High] Requesting IRQs before channel setup completes exposes a NULL poin=
ter dereference.
- [High] Freeing IRQs before unregistering the DMA device leaves the hardwa=
re active without an interrupt handler, leading to interrupt storms.
- [High] Concurrent channel starts in the same direction race on read-modif=
y-write of shared direction-wide registers, leading to lost interrupt unmas=
ks.
--

commit f43f6aa75a3f74ae4984f3bcd2491f36243b0786
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add partial channel ownership mode

Some endpoint DMA frontends expose only a subset of a controller that is
also initialized by the endpoint-side OS. Add a partial ownership flag
so dw-edma does not reset controller-wide state in probe() or remove().

> Keep the mode conservative. Do not enable interrupt-emulation doorbells,
> and reject eDMA legacy mode because it uses a shared viewport selector.
> For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, require ownership of
> all channels in each exposed direction. The driver updates registers
> shared by all channels in a direction, such as interrupt masks and
> linked-list error enables, so two independent OS instances cannot safely
> split one direction without a shared locking protocol, which is
> unrealistic.

[Severity: High]
This isn't a bug introduced by this patch, but does this actually guarantee
safety?

Looking at dw_edma_v0_core_start(), the driver updates direction-wide
registers like int_mask and linked_list_err_en using a read-modify-write
sequence. This code executes with only the per-channel virt-dma spinlock
(chan->vc.lock) held.

If two channels in the same direction are started concurrently on different
CPUs, won't they race on the read-modify-write, causing one channel's
interrupt unmask to be silently overwritten and lost?

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -1152,13 +1161,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> =20
>  	raw_spin_lock_init(&dw->lock);
> =20
> -	dw->wr_ch_cnt =3D min_t(u16, chip->ll_wr_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt =3D min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	hw_wr_ch_cnt =3D min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
> +			     EDMA_MAX_WR_CH);
> +	hw_rd_ch_cnt =3D min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
> +			     EDMA_MAX_RD_CH);
> =20
> -	dw->rd_ch_cnt =3D min_t(u16, chip->ll_rd_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt =3D min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> +		/*
> +		 * Direction-wide registers are shared by all channels in that
> +		 * direction, so a direction must have a single owner.
> +		 */
> +		if ((chip->mf =3D=3D EDMA_MF_EDMA_UNROLL ||
> +		     chip->mf =3D=3D EDMA_MF_HDMA_COMPAT) &&
> +		    ((chip->ll_wr_cnt && chip->ll_wr_cnt !=3D hw_wr_ch_cnt) ||
> +		     (chip->ll_rd_cnt && chip->ll_rd_cnt !=3D hw_rd_ch_cnt)))
> +			return -EOPNOTSUPP;

[Severity: High]
Does this validation reliably ensure a single OS instance owns an entire
direction?

Because hw_wr_ch_cnt is capped by EDMA_MAX_WR_CH (8) during its calculation,
if the hardware supports more channels (e.g., 10), dw_edma_core_ch_count()
will return 10, but hw_wr_ch_cnt is truncated to 8.

A frontend requesting 8 channels will then falsely pass the check, leaving
the remaining hardware channels unowned and available to another OS instanc=
e.
Could this allow multiple instances to share and corrupt direction-wide
registers?

> +	}
> +
> +	dw->wr_ch_cnt =3D min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
> +	dw->rd_ch_cnt =3D min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);

[ ... ]

> @@ -1175,8 +1196,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
>  		 dev_name(chip->dev));
> =20
> -	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
> +		/* Disable eDMA only when this instance owns the controller. */
> +		dw_edma_core_off(dw);
> +	}

[Severity: High]
If the global controller reset is bypassed in partial mode, could this leave
the claimed hardware channels uninitialized?

If the bootloader or a prior kernel left these exclusively owned channels
active, won't they continue running and risk memory corruption when the
new kernel reallocates descriptor rings? Does the driver need to perform a
targeted reset for the specific channels it owns during probe?

> =20
>  	/* Request IRQs */
>  	err =3D dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);

[Severity: High]
This isn't a bug introduced by this patch, but does requesting IRQs here
expose a NULL pointer dereference?

dw_edma_irq_request() is called before dw_edma_channel_setup(). The IRQ
handlers like dw_edma_interrupt_write_inner() dereference dw_irq->dw, which
is only initialized later inside dw_edma_channel_setup().

Since the IRQ is requested with IRQF_SHARED, couldn't another device sharing
the IRQ line trigger the handler prematurely? This patch seems to make it
more likely for partial instances since dw_edma_core_off() is skipped,
allowing the device to immediately assert an unmasked interrupt.

[ ... ]

> @@ -1220,8 +1243,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return -ENODEV;
> =20
> -	/* Disable eDMA */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
> +		dw_edma_core_off(dw);
> =20
>  	/* Free irqs */
>  	for (i =3D (dw->nr_irqs - 1); i >=3D 0; i--)

[Severity: High]
This isn't a bug introduced by this patch, but doesn't freeing IRQs before
unregistering the DMA device leave the hardware active without a handler?

If active DMA transfers are running during dw_edma_remove(), the hardware
will continue asserting the interrupt. Since the handler is removed and
the IRQ is IRQF_SHARED, won't the kernel's spurious interrupt detector
permanently disable the shared IRQ line?

This was previously masked because the unconditional dw_edma_core_off()
safely disabled the hardware. With DW_EDMA_CHIP_PARTIAL, the hardware is
left running, which directly exposes this ordering bug.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D4

