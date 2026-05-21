Return-Path: <dmaengine+bounces-10592-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGV5GH1iDmpG+QUAu9opvQ
	(envelope-from <dmaengine+bounces-10592-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 03:40:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B569259DBAD
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 03:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29BB30432CE
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B230BB80;
	Thu, 21 May 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCsPv/HP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE02BDC29;
	Thu, 21 May 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327608; cv=none; b=f13zEX11PMkfPpUudivKi+bq63yUuCgFq1c5HgfXghJP7KYjaeOHsRfprX6AsUkSa4ottCBxBSc5roH+ABE72/vm4YdQrOAMrSGxgYl3Ga/2Bz6H7dowm9wHbVeruWg32daS6OXffbxSKTzCz4a9wRPHelEM21+NBUDAYei7RKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327608; c=relaxed/simple;
	bh=+//FBnorJ2lhtFSrcA4G20BqwByEiOtZZBPWqG/sY+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAR2SGg9G824m9x0vX8ht0DNny/QUrDx7Vs2EpiU9oPdKywCNjitVSMSmV91O26l/9fDinYb2jwVy4N+nhuZVkQ+LwL0jjb90ezd6imlPgdVOz9FQBGWx10fLrgNWqt6Xk2yM8/ULYTLTh8bjZr571fC+wxqKq6KqIrTKt7FkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCsPv/HP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816211F000E9;
	Thu, 21 May 2026 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779327597;
	bh=z56IcxevCxCLK3e81tgp51x640ys7gQ19xc/k91g0OU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JCsPv/HPTy1AVyxseB25PSFBkaUkBZyFpRJzFG6tjdciJaGrwUPW6Fs2eP68/8QEq
	 gwJVRJdZZyC0TgDlz04nmj4z7YbcTHZJC7pcRJ8H++cSn4vxmZeWhJR903SG18tztX
	 sRWgWgaofrF8fGYa1ar99pFViWLGU2WUjCddCJvvcTNnvGuYpE3rDCFN9VIuAtXW4n
	 XxzQxHBIXew3r9sKFQMVtFDVdUfmkSEIA3swpP6NfGB1u1+ulHwKW8bYNr8UhpTPYq
	 R5lgZc41zf8mikIhHTrx7hpQjGHsIvFUciVsjMeL9KOu0zjy0Hh7m1Ya9CNYKQppzu
	 B5M+LG0W8XYkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260520-dma_prep_config-v6-7-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-7-06e49b7acb38@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 01:39:56 +0000
Message-Id: <20260521013956.816211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10592-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: B569259DBAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Removing the mutex introduces a cascading teardown failure and use=
-after-free where a single DMA timeout forcefully terminates all concurrent=
 transfers on the shared channel.
- [High] Massive CPU wastage and starvation due to un-serialized concurrent=
 busy-waiting on the DMA channel.
- [Low] Unused mutex fields and their initialization/teardown code were lef=
t behind in the structure and lifecycle functions.
--

commit 9bda24c8bcaef3ff0459f6035b72408052dec87b
Author: Frank Li <Frank.Li@nxp.com>

nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

This commit replaces dmaengine_slave_config() and dmaengine_prep_slave_sing=
le()
with dmaengine_prep_config_single_safe(), combining the configuration and
preparation into a single call. It also removes the mutex locks under the
assumption that atomic configuration makes them unnecessary.

> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2afe8f4d0e461..f917d6ec278b7 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -368,18 +368,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_=
pci_epf *nvme_epf,
>  	struct dma_chan *chan;
>  	dma_cookie_t cookie;
>  	dma_addr_t dma_addr;
> -	struct mutex *lock;
>  	int ret;
> =20
>  	switch (dir) {
>  	case DMA_FROM_DEVICE:
> -		lock =3D &nvme_epf->dma_rx_lock;
>  		chan =3D nvme_epf->dma_rx_chan;
>  		sconf.direction =3D DMA_DEV_TO_MEM;
>  		sconf.src_addr =3D seg->pci_addr;
>  		break;
>  	case DMA_TO_DEVICE:
> -		lock =3D &nvme_epf->dma_tx_lock;

[Severity: Low]
Are the dma_tx_lock and dma_rx_lock fields still needed in struct nvmet_pci=
_epf?

Since the locks are no longer used here, it seems the field declarations
and their initialization/teardown code might have been left behind.

>  		chan =3D nvme_epf->dma_tx_chan;
>  		sconf.direction =3D DMA_MEM_TO_DEV;
>  		sconf.dst_addr =3D seg->pci_addr;

[ ... ]

> @@ -388,22 +385,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_=
pci_epf *nvme_epf,
>  		return -EINVAL;
>  	}
> =20
> -	mutex_lock(lock);
> -

[Severity: High]
Does removing the mutex introduce concurrent busy-waiting on the shared DMA
channel?

dma_sync_wait() internally uses a cpu_relax() loop to busy-wait for hardware
completion. Before this patch, the mutex ensured only one thread actively
polled the hardware at a time, while other concurrent workers slept efficie=
ntly
on mutex_lock().

By removing the mutex, it appears multiple worker threads could concurrently
enter dma_sync_wait() on the same channel, unnecessarily consuming 100% of
multiple CPU cores and potentially causing CPU exhaustion.

[Severity: High]
Can removing the mutex also lead to a cascading teardown failure and
use-after-free?

Because the mutex was removed, multiple worker threads can concurrently sub=
mit
and wait on the shared dma_tx_chan or dma_rx_chan. If one transfer times out
in dma_sync_wait(), the error path calls dmaengine_terminate_sync(chan).

It looks like this would forcefully abort the shared channel, destroying all
other active and pending descriptors belonging to concurrent NVMe commands.

Also, if Thread A calls dmaengine_terminate_sync(chan) while Thread B is
between dmaengine_prep_config_single_safe() and dmaengine_submit():

Thread B:
	desc =3D dmaengine_prep_config_single_safe(...)
	// Thread A calls dmaengine_terminate_sync() here
	cookie =3D dmaengine_submit(desc);

Could Thread B's descriptor be freed by the termination, resulting in a
use-after-free when Thread B attempts to submit it?

>  	dma_dev =3D dmaengine_get_dma_device(chan);
>  	dma_addr =3D dma_map_single(dma_dev, seg->buf, seg->length, dir);
>  	ret =3D dma_mapping_error(dma_dev, dma_addr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-dma_prep_c=
onfig-v6-0-06e49b7acb38@nxp.com?part=3D7

