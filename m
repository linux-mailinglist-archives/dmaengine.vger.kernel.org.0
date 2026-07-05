Return-Path: <dmaengine+bounces-12034-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OGOrMMEWSmrb+AAAu9opvQ
	(envelope-from <dmaengine+bounces-12034-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 05 Jul 2026 10:33:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC7709766
	for <lists+dmaengine@lfdr.de>; Sun, 05 Jul 2026 10:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FiRFEXJ/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12034-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12034-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54559303308C
	for <lists+dmaengine@lfdr.de>; Sun,  5 Jul 2026 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3FB19ADA4;
	Sun,  5 Jul 2026 08:31:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF0433E7A;
	Sun,  5 Jul 2026 08:31:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240295; cv=none; b=dTHsIjE+QrfvSIVR8JZ/5z5eUsgX6CAnysxNfjBrOl60lnKD9ozLkFzGy+2KREU7aulPtA/KlmecFHMj7PB1ctIAScflDTTi4tJC1BclUI7Hzy6pxd57XirJPFY4ZugC9XWuDHCFquXn6+zd0Y4HEZ3K9sZ/psQ0+ig32vjPcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240295; c=relaxed/simple;
	bh=lIA4QZYnQ68ULiDlyLCFzLyE2tT8sDKPGurvLAoJbNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqZnqgpAWkfYVq4lbQWoOhy3X28oYo3vUaN6nkccBKHbMywbe5Zu376XNsB7LJnZEksg/ulTVtYuT7IeLMvVDrbDbwhY3ubG3l+q1bp9YpPjXtFzS8cNaP+SfjUCRpvLvR9pyr3qnkZkYNYPa4iDWyN+Ikyl4XeR0EsVynIQJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiRFEXJ/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001491F000E9;
	Sun,  5 Jul 2026 08:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783240294;
	bh=Agbfe0njKoz4QT5VuapeBuCYZVeZrF83Ow6drs7eIm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FiRFEXJ/onWiuGPsq/9PAIsQAmUl5EqVQ/q4KRzJjQBOz5XzOty8H2OkotyNBgEIY
	 tnL06GHlRA201UuMvxl3hlK3VyS9qPZGyIFtIMAOo5wAV0CSXkW5tcQzXt9L2WHQsk
	 gZJNnV58HRIAx9B9m0DmU7Gf+QQyqYoetUXNDNCrpG9KqDEyBSJuM6wxxTCneNJsnc
	 ZtG11dEZoJhMfj+GDLzHkTOd8wK4FYzf7A/Z98f0mFBxhqjE5El5xk6Dy1hG+SFEKJ
	 UcxGNxkawshFN1tzbaSQhIZmwlSkwMoFIrdOyZaJI76FkWn4/DKDpfqkn2t3wpskR0
	 c1FLWFQa+skXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: sun6i: Fix potential deadlock in
 dma_terminate_all and pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260705082105.13325-1-zenghongling@kylinos.cn>
References: <20260705082105.13325-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 08:31:33 +0000
Message-Id: <20260705083134.001491F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12034-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,kylinos.cn:email,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:linux-sunxi@lists.linux.dev,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16BC7709766

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use of spin_lock_irq()/spin_unlock_irq() unconditionally re-enable=
s hardware interrupts, breaking caller atomic contexts.

Pre-existing issues:
- [High] Lockless reads of vchan->phy introduce Time-of-Check to Time-of-Us=
e (TOCTOU) races causing cross-channel interference.
- [High] Active, non-cyclic DMA descriptors are leaked upon channel termina=
tion.
--

commit 5ad36fe6cb5ac09d034a98b6efc7e6a3152d1705
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i: Fix potential deadlock in dma_terminate_all and pause

This patch addresses a deadlock between process context and the DMA tasklet
in softirq context. It replaces plain spin_lock() and spin_unlock() with
their irq variants for sdev->lock in sun6i_dma_pause() and
sun6i_dma_terminate_all().

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..37b143a8f75e2 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -898,9 +898,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
>  		writel(DMA_CHAN_PAUSE_PAUSE,
>  		       pchan->base + DMA_CHAN_PAUSE);
>  	} else {
> -		spin_lock(&sdev->lock);
> +		spin_lock_irq(&sdev->lock);
>  		list_del_init(&vchan->node);
> -		spin_unlock(&sdev->lock);
> +		spin_unlock_irq(&sdev->lock);

[Severity: High]
Does spin_unlock_irq() unintentionally enable hardware interrupts for calle=
rs
that enter this function with interrupts disabled?

DMA engine API functions like dmaengine_pause() are frequently called by
client drivers from atomic contexts where interrupts are already disabled (=
for
example, while holding a lock via spin_lock_irqsave()). Since
spin_unlock_irq() unconditionally re-enables hardware interrupts, could this
destroy the caller's atomicity and lead to scheduling while atomic panics or
deadlocks?

Would it be safer to use spin_lock_irqsave() and spin_unlock_irqrestore()
here instead?

[ ... ]

> @@ -939,9 +939,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *c=
han)
>  	unsigned long flags;
>  	LIST_HEAD(head);

[Severity: High]
This is a pre-existing issue, but does fetching the physical channel pointer
locklessly at the start of this function introduce a race condition?

At the top of sun6i_dma_terminate_all(), we have:

    struct sun6i_pchan *pchan =3D vchan->phy;

If a DMA transfer completes concurrently on another CPU, the tasklet might
clear vchan->phy and reassign the same pchan to a different virtual channel.
When sun6i_dma_terminate_all() later acquires the lock and calls writel() to
stop the channel, could it mistakenly stop an unrelated transfer that was j=
ust
started on that physical channel?

[Severity: High]
This is a pre-existing issue, but does sun6i_dma_terminate_all() leak active
non-cyclic descriptors?

When terminating, the function has logic to rescue cyclic descriptors and m=
ove
them to the completed list:

    if (vchan->cyclic) {
        vchan->cyclic =3D false;
        if (pchan && pchan->desc) {
            ...
            list_add_tail(&vd->node, &vc->desc_completed);
        }
    }

However, for non-cyclic transfers, it ignores the active descriptor entirely
and sets pchan->desc =3D NULL. Because vchan_get_all_descriptors() only gra=
bs
descriptors from the tracking lists, the active non-cyclic descriptor is
bypassed and lost. Could this lead to a permanent memory leak of sun6i_desc
structures and their associated hardware pools when non-cyclic transfers are
aborted?

> -	spin_lock(&sdev->lock);
> +	spin_lock_irq(&sdev->lock);
>  	list_del_init(&vchan->node);
> -	spin_unlock(&sdev->lock);
> +	spin_unlock_irq(&sdev->lock);

[Severity: High]
Similar to sun6i_dma_pause(), will this spin_unlock_irq() unconditionally
enable hardware interrupts and break the caller's atomic context?

Also, because it re-enables interrupts before the immediately following
spin_lock_irqsave(&vchan->vc.lock, flags) call, could it corrupt the IRQ
state saved in flags?

> =20
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705082105.1332=
5-1-zenghongling@kylinos.cn?part=3D1

