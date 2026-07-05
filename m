Return-Path: <dmaengine+bounces-12032-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XkkFFeIQSmoS+AAAu9opvQ
	(envelope-from <dmaengine+bounces-12032-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 05 Jul 2026 10:08:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0717095B4
	for <lists+dmaengine@lfdr.de>; Sun, 05 Jul 2026 10:08:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aqUQP7XC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12032-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12032-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDB5E3006955
	for <lists+dmaengine@lfdr.de>; Sun,  5 Jul 2026 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965FF36AB61;
	Sun,  5 Jul 2026 08:07:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4636165E;
	Sun,  5 Jul 2026 08:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238850; cv=none; b=H17C8itfWpQdMiqjiV6HKo8msuEj4S8JuJs7B7XtJ/Aqo9weuceXle18rGoeezyve15OBciyf2DzjjSpzgmYfiD00Tqpn0Yk9GlFfxuzEafLPueAVNb8aUQ+H25qKPRy6yTs1zWX8g5Q1CE/nkImw9BydQu9Ai1Wpu1SjwRISXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238850; c=relaxed/simple;
	bh=Pnzax5eEFCaPFr2wYTe4MqmyxnjDD0Ekr/JmWAkBjlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C3eUldpKkxSEE9w8h0mkNhnDJVOwCg7k9FmhPuRAc1tgYO8vW6radaUd1LENujHja5ToveCMgsv7xl+nvTAQR1yh8xuJqXWvTgdpHCvB0AWCeZr+cWOBsEx8FcPcyDeN2jHC4ORB5mqeRXBQ+DJlhM6L9zoMLwsM51iTVWNwdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqUQP7XC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585E31F000E9;
	Sun,  5 Jul 2026 08:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783238846;
	bh=aPiUbRb9F335UAOqVtkPG5bKHJ0vAZx3MOjcrOEptlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aqUQP7XCcAE0IvnjBRxifDqJAVrFAKOc4S8IPPaidTpE0cu9A5GBQ1ZArypvYhXHv
	 4t58zcvuHqTHlSFD/A1Zyv+od5HBaQ2czyHibNq0Ki9Plsk4kRzoT9F5nxzG30Z4Wn
	 8Qw9YzdrWtudCIRoO+fMYvZakbzTq/rnvCfalsnIPa/UBU937et5zzCOBFdLDFL5gN
	 kYgVQELWyU3wYqZt7JTcd847C7paa/qL8RteufO3ET1DTFdBEldpMytT4ej24S5dmz
	 toZvG13WfZ7Jk46K8uDVXqlf+4U0nITQXXnwY3LwSbh7WTTEUOPImMeU+DwnALQMDN
	 2V+MGwelgIxWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: sun6i: Fix potential deadlock in
 sun6i_dma_terminate_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260705075738.10639-1-zenghongling@kylinos.cn>
References: <20260705075738.10639-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 08:07:25 +0000
Message-Id: <20260705080726.585E31F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12032-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,kylinos.cn:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:linux-sunxi@lists.linux.dev,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: AA0717095B4

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditional hardware interrupt re-enablement violates caller loc=
k state.

Pre-existing issues:
- [High] Incomplete deadlock fix: sun6i_dma_pause() contains the exact same=
 deadlock vulnerability.
- [High] Lockless read of vchan->phy causes Time-Of-Check to Time-Of-Use (T=
OCTOU) race condition and hardware corruption.
--

commit 1435f9b5204cbc43aa5b41f133e1e3e88387cce1
Author: Hongling Zeng <zenghongling@kylinos.cn>
dmaengine: sun6i: Fix potential deadlock in sun6i_dma_terminate_all()

This commit modifies sun6i_dma_terminate_all() to use spin_lock_irq()
instead of plain spin_lock() when acquiring sdev->lock. The change aims
to prevent a deadlock caused when a DMA interrupt fires while the lock
is held.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..840f7276ad5d5 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -939,9 +939,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *c=
han)
>  	unsigned long flags;
>  	LIST_HEAD(head);
> =20

[Severity: High]
This is a pre-existing issue, but does reading vchan->phy locklessly at
the start of this function create a race condition?

In sun6i_dma_terminate_all():

static int sun6i_dma_terminate_all(struct dma_chan *chan)
{
        ...
        struct sun6i_pchan *pchan =3D vchan->phy;
        ...
        spin_lock_irqsave(&vchan->vc.lock, flags);
        ...
        if (pchan) {
                writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);

If sun6i_dma_tasklet() completes a transfer, clears vchan->phy, and
reassigns the physical channel to a different virtual channel before the
lock is acquired here, would this operate on a stale pchan and stop
an unrelated transfer?

Similar lockless reads of vchan->phy exist in sun6i_dma_pause(),
sun6i_dma_resume(), and sun6i_dma_tx_status().

> -	spin_lock(&sdev->lock);
> +	spin_lock_irq(&sdev->lock);
>  	list_del_init(&vchan->node);
> -	spin_unlock(&sdev->lock);

[Severity: High]
Does this unconditional spin_unlock_irq() risk breaking callers that
invoke dmaengine_terminate_all() with interrupts already disabled?

Since spin_unlock_irq() forces hardware interrupts back on, it could
destroy the caller's interrupt-disabled state and lead to unexpected
nested interrupts. Is it safer to use spin_lock_irqsave() and
spin_unlock_irqrestore() here?

[Severity: High]
This is a pre-existing issue, but does sun6i_dma_pause() have the exact
same deadlock vulnerability being fixed here?

sun6i_dma_pause() acquires the same lock without disabling interrupts:

static int sun6i_dma_pause(struct dma_chan *chan)
{
        ...
        } else {
                spin_lock(&sdev->lock);
                list_del_init(&vchan->node);
                spin_unlock(&sdev->lock);
        }

Could a DMA interrupt fire while this lock is held in process context
and cause the same tasklet deadlock?

> =20
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705075738.1063=
9-1-zenghongling@kylinos.cn?part=3D1

