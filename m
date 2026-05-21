Return-Path: <dmaengine+bounces-10705-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jv1JH87D2qZIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10705-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:06:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 354AC5A9DA7
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFFDE300337D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73553385D75;
	Thu, 21 May 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXjOtQrp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07B385D82
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382612; cv=none; b=CNrzp9UnSUVlMT1jvIGDGkD2C8zc4SwSm8I1yTrBMkflm6glxxWus+B8qxaROTQ4Kj1wcjDELGd5UYANHjQp0lkXi73jEnsVZKboITZ/e2+i+aUbMTFIBm+OLlrUYsl40jmoS1+jR2gJ0ub0HgejJ6jMUSlIPop3nF41Pajc3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382612; c=relaxed/simple;
	bh=Sd7Tm8rne9pkUNE3u2qem3fwF6/RjummTHb/jpaBvZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ekpsn32wLxcOWr0k/s87CItqGa+maq00XaQ+fMwnSIUPmHaSzT7rbt1rrQ74OVg/3lDf3Px+IkibnwrcaTzlWCvJnsL6Fqbs9BNjhwj4vW3r0M7707/q58MnAZ3ITwxm49e+L72npidqAH621TgGaOuZYxs3168CwYHdJbFk614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXjOtQrp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534061F00A3B;
	Thu, 21 May 2026 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779382610;
	bh=nJj1H11Tt7S3rVId/M7qASEWqeE4i8dkoeDYPLxT7N4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXjOtQrpCUbwNfPOBws3QZU2Kpo1hQLObOuHFk3r7JQ40Qv6UhNVUTAqOvRYOhx1s
	 MB2YJCyUmOFHCxpifN+jRhztnFL4yUY6CMjgJ0M8/hxZzgyFUk6Vx5Bz4HU3eprTzk
	 HSUr4becd+ht3eMeaKOcOaQUUotAigDUuyk97ARn2NFxG9dV8wZ62G7flHeYEvECHJ
	 EsUHVzswkI1ONNToBc4Woynqb4c26v4vE7Aoaf6QGvGXndhqx+HRz+1McxQnpITbON
	 HTLNeXkVYGakbgR0Rn+L88a+ry1LhiGhuqUe2miMBPUn6i6q+J7L5/kG4i6qYGI7LK
	 xziMbbPLtH4iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260521142153.2957432-5-den@valinux.co.jp>
References: <20260521142153.2957432-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 16:56:49 +0000
Message-Id: <20260521165650.534061F00A3B@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10705-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,nxp.com:email,lists.linux.dev:replyto,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 354AC5A9DA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The teardown sequence in `dw_edma_remove` incorrectly powers off t=
he hardware and frees interrupts before unregistering the DMA device, expos=
ing a race window.
--

commit 3dac310797da8c464a27d4656c26826f3d2a7401
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK

This commit adds a spinlock to dw_edma_v0_core_start() to serialize access
to the shared DONE_INT_MASK and ABORT_INT_MASK registers. This prevents
race conditions from concurrent updates across multiple channels.

Link: https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@=
nxp.com/

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 69e8279adec81..cfdd6463252e6 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
[ ... ]
> @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chun=
k *chunk, bool first)
>  			}
>  		}
>  		/* Interrupt unmask - done, abort */
> +		raw_spin_lock_irqsave(&dw->lock, flags);
> +

[Severity: High]
This is a pre-existing issue, but I noticed a potential race window related=
 to
how dw_edma_remove() interacts with this code.

In dw_edma_remove(), the driver teardown sequence calls dw_edma_core_off() =
to
disable the engine and mask interrupts, then frees the IRQs, and only
subsequently calls dma_async_device_unregister().

Since the DMA device remains registered in the dmaengine framework during t=
his
window, can concurrent DMA clients still issue new transfers?

If a client calls dmaengine_submit() and dma_async_issue_pending(), the
execution traces down to dw_edma_v0_core_start().

Could this write to the engine_en register and unmask interrupts here,
unexpectedly re-enabling the hardware? Since the IRQs have already been fre=
ed,
would this result in the transfer completion never being signaled, leading =
to
a hung task?

Should the teardown sequence call dma_async_device_unregister() first to
safely quiesce the subsystem and prevent new requests before stopping the
hardware and freeing IRQs?

>  		tmp =3D GET_RW_32(dw, chan->dir, int_mask);
>  		tmp &=3D ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
>  		tmp &=3D ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chun=
k *chunk, bool first)
>  		tmp =3D GET_RW_32(dw, chan->dir, linked_list_err_en);
>  		tmp |=3D FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
>  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> +
> +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142153.2957=
432-1-den@valinux.co.jp?part=3D4

