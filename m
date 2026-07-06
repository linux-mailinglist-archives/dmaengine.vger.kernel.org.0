Return-Path: <dmaengine+bounces-12037-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PD3WEPUcS2o2MAEAu9opvQ
	(envelope-from <dmaengine+bounces-12037-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 05:11:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1370C46E
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 05:11:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LJwKPEm9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12037-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12037-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F313006B1F
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 03:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942737DAA8;
	Mon,  6 Jul 2026 03:11:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427136165E;
	Mon,  6 Jul 2026 03:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307504; cv=none; b=EmkoTrFiqap1CAsONYE6uPOf1xM6DwiYf2H5dAqc8VD1fDBioUw4LWXloj7bcGOLu+cWrmaiQfVYFUUocWG2xxCvmvP26n4Skom+GVD4/BbFANdRtB4lhpsHdWcCM6oLonFwd7KSw5guzIDBUkZMNuE7/DYx9PmHwMs2xPNtq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307504; c=relaxed/simple;
	bh=g7gS5TF9DMMHRnjlCG6XSkZiCQT6IjfG6vdakSAHh84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tyb5dIn11r7st6JV9yimvF8sW6FIF/rO5oIGVa4p21SUwVd4KvedLQCLEtgruMb64u089Qd1T8k7gRE/vTuWQRnQv8702QvU/mwx0JL1Ms0knBYEVjFwkVD5G8F6njNpsJi7orqYuxff+ghelEiAL+tbwBwPSUrfocVgtVvf5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJwKPEm9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6E61F000E9;
	Mon,  6 Jul 2026 03:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783307503;
	bh=8+WGjis1U/3lL7c/6bqTT3VyJe6DM8Qstr/HaKKLJmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJwKPEm9xSb3sgTb1gSNO75TbDNKf1Q8DxkVQwJbHxq7eZCMf/HepxrGb7Glfb8t/
	 9PPwV7YdQCfo2r270A8M+Re+0dUf9869+bdVM4lJOdqBnjkanKdjyWncY/Tm0irYPB
	 5tgrIdzCIrSnl6pMVAiiXHUM4A7g1c0XF0/yWf+MHWgpqUdhOiS5MYiSn1QEiXzVEX
	 pEpJKZqfkdLc0I2lcUssXMy1NnMqRUYke5eV61PY4dzPUUjOMP0/LJrVFg61N+yuFd
	 moZEbXnr2Dpf00rWeloqVq9hU1OjguUERCrcmy7NvVTrQGPQNrjhYZr8fMdLNIgWx9
	 49Sxgk5QdKz6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: sun6i: Fix potential deadlock on
 sdev->lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260706030347.22730-1-zenghongling@kylinos.cn>
References: <20260706030347.22730-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:11:42 +0000
Message-Id: <20260706031142.AF6E61F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12037-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,kylinos.cn:email,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DF1370C46E

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch incorrectly uses spin_lock_irq() and spin_unlock_irq() i=
nside an existing spin_lock_irqsave() critical section, prematurely enablin=
g local interrupts and risking a recursive spinlock deadlock.

Pre-existing issues:
- [High] Lockless reading of vchan->phy (pchan) leads to a time-of-check to=
 time-of-use (TOCTOU) race condition with concurrent channel reallocation.
--

commit 540abaecd705cc77dff5d58414b0bd84a163d5b5
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i: Fix potential deadlock on sdev->lock

This patch replaces plain spin_lock() with spin_lock_irq() and=20
spin_lock_irqsave() around sdev->lock acquisitions in process context. This=
=20
aims to prevent a deadlock where the lock is held by a process and a DMA=20
interrupt schedules a softirq tasklet that attempts to acquire the same loc=
k.

Cc: stable@vger.kernel.org

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..742a0822a8da7 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -891,6 +891,7 @@ static int sun6i_dma_pause(struct dma_chan *chan)
>  	struct sun6i_dma_dev *sdev =3D to_sun6i_dma_dev(chan->device);
>  	struct sun6i_vchan *vchan =3D to_sun6i_vchan(chan);
>  	struct sun6i_pchan *pchan =3D vchan->phy;

[Severity: High]
This is a pre-existing issue, but does reading vchan->phy locklessly lead t=
o a
time-of-check to time-of-use (TOCTOU) race condition?

If sun6i_dma_tasklet() runs concurrently in softirq context, it could compl=
ete
the current transfer, clear vchan->phy, and reassign the physical channel t=
o a
different virtual channel.

The original thread would then continue using the stale pchan pointer, appl=
ying
commands like PAUSE_PAUSE to a physical channel now actively processing a
different client's transfer.

[ ... ]

> @@ -921,9 +922,9 @@ static int sun6i_dma_resume(struct dma_chan *chan)
>  		writel(DMA_CHAN_PAUSE_RESUME,
>  		       pchan->base + DMA_CHAN_PAUSE);
>  	} else if (!list_empty(&vchan->vc.desc_issued)) {
> -		spin_lock(&sdev->lock);
> +		spin_lock_irq(&sdev->lock);
>  		list_add_tail(&vchan->node, &sdev->pending);
> -		spin_unlock(&sdev->lock);
> +		spin_unlock_irq(&sdev->lock);

[Severity: High]
Does this spin_unlock_irq() prematurely enable local interrupts inside the
spin_lock_irqsave(&vchan->vc.lock, flags) critical section?

Since spin_unlock_irq() unconditionally enables local interrupts, it breaks=
 the
protection established by the outer irqsave lock.

If a DMA hardware interrupt for the same virtual channel fires immediately =
after
this unlock, the interrupt handler will attempt to acquire vchan->vc.lock. =
Since
the interrupted thread already holds that lock, would this result in a recu=
rsive
spinlock deadlock?

>  	}
> =20
>  	spin_unlock_irqrestore(&vchan->vc.lock, flags);

[ ... ]

> @@ -1021,7 +1022,7 @@ static void sun6i_dma_issue_pending(struct dma_chan=
 *chan)
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
> =20
>  	if (vchan_issue_pending(&vchan->vc)) {
> -		spin_lock(&sdev->lock);
> +		spin_lock_irq(&sdev->lock);
> =20
>  		if (!vchan->phy && list_empty(&vchan->node)) {
>  			list_add_tail(&vchan->node, &sdev->pending);
> @@ -1030,7 +1031,7 @@ static void sun6i_dma_issue_pending(struct dma_chan=
 *chan)
>  				&vchan->vc);
>  		}
> =20
> -		spin_unlock(&sdev->lock);
> +		spin_unlock_irq(&sdev->lock);

[Severity: High]
Similarly here, does this unconditionally enable interrupts while the outer
vchan->vc.lock is still held?

Could this also expose the CPU to a recursive spinlock deadlock if an inter=
rupt
arrives before the outer spin_unlock_irqrestore() is called?

>  	} else {
>  		dev_dbg(chan2dev(chan), "vchan %p: nothing to issue\n",
>  			&vchan->vc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706030347.2273=
0-1-zenghongling@kylinos.cn?part=3D1

