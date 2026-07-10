Return-Path: <dmaengine+bounces-12313-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zrJsJ5/NUGoZ5QIAu9opvQ
	(envelope-from <dmaengine+bounces-12313-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 12:46:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45421739D31
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 12:46:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RffkoNhX;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12313-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12313-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F27300F52E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54B40BCB3;
	Fri, 10 Jul 2026 10:43:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E53E3D90;
	Fri, 10 Jul 2026 10:43:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680234; cv=none; b=RO0XEZ2rcLdC8NSC2/4O11cMNl/fPyl+4VHcX5gxEzQdvnNOwrwhZv2g4b2+I3XXVEGYaaid/3CDLGE98tnzpBA9wvbo0DPytfvy6op0VXpmeIyOTfzuji8wwPGcHc/CnBzed0XHur400KBycPn20iQ1s3wX13ngoMVDyoFTXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680234; c=relaxed/simple;
	bh=/OkMsSt2pEZeE3L97MlLY3KCCaaTYO+eAl6y3/W7H/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GqHdq+zzUGIZ0vmYgHx7n13yzQNlxn01Ul/6SaPye3/sRmCDAIJgvY4J4zR+FMj5QKyCBg0jDvfMGGtjGDDvdTKFwXpEyprBzaTuVtCV8yBupdYdjXcgjf/sTPHT8Lnt0ujamOb3Au6gFmqDqywpllGUbyfWJv0KyntEpjwMosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RffkoNhX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D671F00A3A;
	Fri, 10 Jul 2026 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680233;
	bh=C/lSeXagT+mgcjUZOLp/BIsZTNEz+dIkjPEvhvMwzaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RffkoNhXMGWbrcYteWv1afwKNGsrf6IfRxJGUxd7xpUP+G7fOiLy2qoDL/Cov+8NK
	 hZPY6Koxshgv4auYznOPxBUXv84jvd3AS7AcHe9jdUrrYncE6gM30ob/y1m09FXW9/
	 K+M5obFmGP3uKsoIbN0UxkQovRP43Ukq0TFCSc6cSls04Y+ULJIaiNuS76YADNv1mj
	 aL5EvcX9N5maa/YVLseJ/PyKhF7wp49Ebi8/0TDYq9TxRn57Eq19eoiFnCZhysgObb
	 SqUEuTBD0kfck/HTdjpFaUk3KVehuH9CFePQGhOojeoD9ir47SL5w9B38NVnFxR7d7
	 SY1nrzlUPaklw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] dmaengine: dw-edma: Add delegated channel
 request helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260710082156.2395844-6-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:43:52 +0000
Message-Id: <20260710104352.C9D671F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12313-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45421739D31

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The patch references nonexistent constants, functions, and str=
uct fields, which will cause an immediate compilation failure.
- [Medium] The `irq_mode` field is modified without holding `chan->vc.lock`=
 during channel release, violating the locking discipline established durin=
g delegation.
--

--- Patch [5]: [PATCH v4 5/6] dmaengine: dw-edma: Add delegated channel req=
uest helpers ---
commit 15a8e802b8e938899858a00862b359f85ce5f547
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add delegated channel request helpers

This commit adds DW eDMA-specific helpers that request a write/read
hardware channel through DMAengine. It switches the selected endpoint-local
channel to remote interrupt routing after reservation, and restores default
routing upon release.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 89a4c498a17b8..cbf6f539d4369 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -1178,6 +1178,92 @@ int dw_edma_remove(struct dw_edma_chip *chip)
[ ... ]
> +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	if (chan->configured || chan->status !=3D EDMA_ST_IDLE ||
> +	    chan->request !=3D EDMA_REQ_NONE)
> +		ret =3D -EBUSY;
> +	else
> +		chan->irq_mode =3D DW_EDMA_CH_IRQ_REMOTE;

[Severity: Critical]
Are we missing a prerequisite patch in this series? The field irq_mode does
not seem to exist in struct dw_edma_chan, and the DW_EDMA_CH_IRQ_REMOTE
macro appears to be undefined, which will cause a build regression here.

> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	return ret;
> +}
[ ... ]
> +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan)
> +		return;
> +
> +	chan =3D dchan2dw_edma_chan(dchan);
> +	if (quiesce)
> +		dw_edma_core_ch_quiesce(chan);
> +	chan->irq_mode =3D dw_edma_get_default_irq_mode(chan);

[Severity: Critical]
Are there missing prerequisites for this code as well?=20
dw_edma_core_ch_quiesce() and dw_edma_get_default_irq_mode() appear to be
undeclared functions in this tree.

[Severity: Medium]
Does chan->irq_mode need to be protected by chan->vc.lock here?

In dw_edma_delegate_chan() above, chan->irq_mode is modified while holding
the chan->vc.lock. Here, it is modified locklessly.=20

If quiesce is false, could an ongoing interrupt handler concurrently read
irq_mode while it is being restored?

> +	dma_release_channel(dchan);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D5

