Return-Path: <dmaengine+bounces-11084-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFdSCIPcHGoDTgkAu9opvQ
	(envelope-from <dmaengine+bounces-11084-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 03:12:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDAF618974
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 03:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9003012E90
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 01:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D791A683C;
	Mon,  1 Jun 2026 01:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InBAa25c"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60341C6A
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780276352; cv=none; b=iPToawIv01Kf4axLM636vq7fmidAsE/zJXeigUcOiwGsuE0k8mnqaqE3bCA+ZrbfBT0aV/H6XfN2NbU7aMlR4n3RHE/9u3tBNt2oKETQXcPdueGeaLldJwpUKlPDfHzRzMCWC4GVKbFsqOEpafaIpsLRwblWLZiX5Udl5Z3ffMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780276352; c=relaxed/simple;
	bh=hafgj+k2Hy16VOKvUQrIAvifI9fopnG1wm5es18AK/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XqC7ySRxko1DW96Sxb87/w269wwMWqEPl4USxwn9BqQt/XV47Qv/KLaAqmhGG0TtV0QfJo8oginMA+/ydpEYgCKyYx6qhpSOLxcl882lFdZoJp7Xby7Iapcn80Oxt9BojblRXllJ+ZrcQHGEA/d/K22hnEd8abHqGV7B5y/TDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InBAa25c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BDB1F00893;
	Mon,  1 Jun 2026 01:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780276351;
	bh=7womZqJ4Rgn9Aonal76+E4uizkNXmRgn1f6IUjQ+Rxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=InBAa25ciGR3H9UIWjE2OW++fZLgmk674lIzHLnTWOam4TnBNl8QD1MeI+QIff5dF
	 uKgceqtteV64DawrTGBQqrpP3zFftP/lvu9wje7SPKYHXCxoBqcSc3HDsxDrWEXGsi
	 ULgoPLe6vkwgV/0DGYQOBhB0fCGkZYfNkrp3VNHac4CwajBl+R++1De0L006i/f8iI
	 xidD86fkKNsDCd6bMUTAa3Vrxmy4yhPk6MSCtl+t/PQYukXzQSjrFLWlt0q/bf6Iub
	 ruvt5t97pnt0AMxQVgiK3UG0hHjY00r/XfhVmChAMWwih6lH+jtfKb2EIUVH+JGyQD
	 lApCr7fD0gP5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] dmaengine: ti: omap-dma: fix dma_pool_destroy
 before omap_dma_free in error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260601003553.72573-4-rosenp@gmail.com>
References: <20260601003553.72573-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 01:12:30 +0000
Message-Id: <20260601011230.C6BDB1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11084-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 6DDAF618974
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional write to `IRQENABLE_L1` in `omap_dma_probe` error =
paths triggers WARN_ON splats on OMAP1 legacy platforms.

Pre-existing issues:
- [Critical] The driver teardown paths free channel structures and destroy =
the DMA pool without explicitly stopping actively running hardware DMA chan=
nels.
- [High] The patch attempts to fix a memory leak of channel descriptors, bu=
t misses the actively executing descriptor `c->desc`.
--

commit 5698cd1c75a26052d705aeceb286850e8b0239ca
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: fix dma_pool_destroy before omap_dma_free in error=
 paths

The probe error paths and remove path called omap_dma_free() after
dma_pool_destroy(), leaving the desc_pool dangling. This patch reorders
the teardown sequence, disables hardware interrupts in probe error
paths, and drains virt-dma descriptor lists in omap_dma_free().

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 839e04f53fc2d..dde270646bb94 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1522,6 +1522,7 @@ static void omap_dma_free(struct omap_dmadev *od)
> =20
>  		list_del(&c->vc.chan.device_node);
>  		tasklet_kill(&c->vc.task);
> +		vchan_free_chan_resources(&c->vc);

[Severity: High]
This is a pre-existing issue, but does this leak the actively executing
descriptor?

When a descriptor is issued to the hardware, omap_dma_start_desc() removes
it from the virt-dma lists and assigns it to c->desc. Since
vchan_free_chan_resources() only drains the virt-dma lists and does not
inspect c->desc, could the active descriptor and its associated hardware
pool allocations be permanently leaked before the channel is freed?

> +		kfree(c);

[Severity: Critical]
This isn't a bug introduced by this patch, but are the channels freed here
without stopping the underlying hardware DMA engine?

If omap_dma_stop() or omap_dma_terminate_all() is never called to halt the
hardware channel, the DMA hardware might continue executing transfers
asynchronously. Could this cause the hardware to scribble over memory when
fetching descriptors, especially since the DMA pool is destroyed shortly
after in omap_dma_remove() and the probe error paths?

>  	}
>  }

[ ... ]

> @@ -1808,9 +1809,14 @@ static int omap_dma_probe(struct platform_device *=
pdev)
>  	if (rc) {
>  		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
>  			rc);
> +		spin_lock_irq(&od->irq_lock);
> +		od->irq_enable_mask =3D 0;
> +		omap_dma_glbl_write(od, IRQENABLE_L1, 0);

[Severity: Medium]
Does this unconditional write to IRQENABLE_L1 trigger a WARN_ON splat on
OMAP1 legacy platforms?

On OMAP1 legacy platforms where omap_dma_legacy(od) is true, IRQENABLE_L1
is not mapped in reg_map and evaluates to a zero-initialized register with
type OMAP_DMA_REG_NONE (0). Attempting to read or write OMAP_DMA_REG_NONE
unconditionally triggers a WARN_ON(1) inside omap_dma_write() and
omap_dma_read().

Should this interrupt disable logic be guarded by a check for
!omap_dma_legacy(od) as done in omap_dma_remove()?

> +		spin_unlock_irq(&od->irq_lock);
> +		omap_dma_glbl_read(od, IRQENABLE_L1);
> +		omap_dma_free(od);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601003553.7257=
3-1-rosenp@gmail.com?part=3D3

