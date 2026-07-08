Return-Path: <dmaengine+bounces-12143-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id urONHeqbTmpiQgIAu9opvQ
	(envelope-from <dmaengine+bounces-12143-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:50:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A91729B69
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QAgr4F80;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12143-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12143-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC85304E57F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973833C1084;
	Wed,  8 Jul 2026 18:49:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842C3BB106;
	Wed,  8 Jul 2026 18:49:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536574; cv=none; b=hDum6pQU4XgGdCglYynpmKoBDqK1y76aODZwbwqIEdhE/2dDh19JLnzqb3CqQXWIsC7JCEDBBr0yS+fI12dKih67VmMamnNog2b5rPnO0yv3VAzhmUr/Ho6iJpJJKLoHkUjdoiVwB8RrYyqc3a/kKPfnWElNuj1OUwRorZavRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536574; c=relaxed/simple;
	bh=gCCm6B7WFMkh6TI6vx5C47OeQLzMw8zPtV66poT5UCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hHTgx1YFinw7ieKlKOLu99D6TU0E841msAxG0Dj/1mfA82XLmYwGiC8k/2HnNIiFjyNe2D+Ts3cb59DskYbEbUKvUvTkbeGttSDqgHOxv1cPQDczkGS/ngrJ/RW1szJQflDa1RntF0T11hgCyZLPNf4yp8bSPzmIcj6avwtgXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAgr4F80; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F181F000E9;
	Wed,  8 Jul 2026 18:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536573;
	bh=XlF/wNqXviapsnIgyXbUGPyvZgCbKHbqzDLFxhmcJkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAgr4F80zR71fuYTDrMJpT/SKIgFw++0RV/h/hOINiGP09d5myH57doLIvfVSe74P
	 NFnLgLjBmtKb1LiBJaMlngvfx1X0cpBNRwVuVfmdwXwWyf5upVG6hxAg0lv+oRMEUC
	 wiUam5VUBrU3KBPYVaVBEzMeIDxfZdP9caDc4ACOsGxuczm+RSi5cDklaSCfyvi4eA
	 N2cPsucuLVJYDTE/prevEtFligQIrbfz2CuOK0CeLivQRRbrJwv2gXbNvs9IpsK7Gq
	 jP4cfNDGuEY4DICopf/0MFE6zfHeBG4gs5ZkquPz1D/K6OSb80oQHfivk+2ddKAIhU
	 NpgmCESA1SwBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] dmaengine: dw-edma: Add xfer_sz field to
 struct dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260708-edma_ll-v4-2-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-2-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:49:32 +0000
Message-Id: <20260708184932.A4F181F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12143-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17A91729B69

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing locking in `dw_edma_device_resume` leads to list corruptio=
n and UAF when racing with other dmaengine callbacks or interrupts.
- [High] `dw_edma_device_terminate_all` and `dw_edma_free_chan_resources` f=
ail to reap and free pending descriptors, leading to memory leaks.
--

--- Patch [2]: [PATCH v4 02/10] dmaengine: dw-edma: Add xfer_sz field to st=
ruct dw_edma_chunk ---
commit c69420a16cf9075d2716bbeed5e9f214096073f7
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk

This commit adds a new xfer_sz field to struct dw_edma_chunk to explicitly
indicate the total transfer size of a chunk. This replaces the reuse of
ll_region.sz, which represents the memory size of the EDMA link list.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 1fec1b52e3d47..53469c8c8b82e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan=
 *chan)
>  		return 0;
> =20
>  	dw_edma_core_start(dw, child, !desc->xfer_sz);
> -	desc->xfer_sz +=3D child->ll_region.sz;
> +	desc->xfer_sz +=3D child->xfer_sz;
>  	dw_edma_free_burst(child);
>  	list_del(&child->list);
>  	kfree(child);

[Severity: High]
This is a pre-existing issue, but could this sequence lead to a double-free
when racing with interrupts?

Looking at dw_edma_device_resume(), it calls dw_edma_start_transfer() witho=
ut
holding the chan->vc.lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
    } else {
        chan->status =3D EDMA_ST_BUSY;
        dw_edma_start_transfer(chan);
    }
    ...
}

If dw_edma_core_start() kicks the hardware and finishes immediately, an
interrupt could fire. The interrupt handler dw_edma_done_interrupt()
would take the lock and also call dw_edma_start_transfer(), potentially
freeing the exact same child entry concurrently.

While reviewing the broader code in this file, I also noticed another
potential leak in the channel termination code:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
    ...
	} else if (chan->request > EDMA_REQ_PAUSE) {
		err =3D -EPERM;
	} else {
		chan->request =3D EDMA_REQ_STOP;
	}

	return err;
}

[Severity: High]
This is a pre-existing issue, but do dw_edma_device_terminate_all() and
dw_edma_free_chan_resources() leak pending virt-dma descriptors?

dw_edma_device_terminate_all() only sets internal state flags but never
flushes the vc.desc_issued or vc.desc_submitted queues.

Additionally, dw_edma_free_chan_resources() waits for termination:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_free_chan_resources() {
    ...
	while (time_before(jiffies, timeout)) {
		ret =3D dw_edma_device_terminate_all(dchan);
		if (!ret)
			break;
    ...
}

However, it doesn't appear to call vchan_free_chan_resources() to free the
allocated virt-dma descriptors. Can this lead to memory leaks or the
execution of stale transfers if the channel is reused?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D2

