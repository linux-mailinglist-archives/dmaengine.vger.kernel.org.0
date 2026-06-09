Return-Path: <dmaengine+bounces-11379-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5t22BTCXKGpPGgMAu9opvQ
	(envelope-from <dmaengine+bounces-11379-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:44:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F9664A34
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WIcE8JCE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11379-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11379-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F331303282F
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0DF3A6EEB;
	Tue,  9 Jun 2026 22:36:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820939524E
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:36:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044618; cv=none; b=qfv7NWHCAfvBcT4/TzaadRSvv+t2GqqCr6ekNCrDZoWShYLidaJAWndZNqC4pJE6WG6j3I7IYRNDlvLlBec1MCYp0wkgNQ9mfstbv5r5uJBDF6DFkgM3qGQt8ape1P6B1N40JYe5uEQC3uU3sJwbxUifIIx55QHPMarEAh/9bhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044618; c=relaxed/simple;
	bh=zJexg/NBBCOq0fCj+qpiUzOzBmAUD+rWZI9KhNii6YY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fpp9MRZ1NL/4rhvILtBKS8XYmc0RdSvBtvHfAHQ3XNPjrH8CfFwBz//z0rXkwmw1rrdvHVhH+LN8PJrlU47Y1qkmaD6OPBpz+eS6jQkI2aKyTAYHqBIKaWeVxd3Q+PlwfuQj7GNfTdZVBszoReANFebH9fcdNOOHl53qXemwRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIcE8JCE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828291F00893;
	Tue,  9 Jun 2026 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044616;
	bh=A2WN6b6qP+MFejUZ08EyYWe8jKo8wM7vZ2FT8yenL9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WIcE8JCEFoUzVd73T+AlF+Lz+PqDV/iSxAXjp26kfP/4PP9I2Ds36IoTq2mL67ZND
	 T2M9iUc/hAh8g5vkojp8rj2B/uARVgRUONHsJnGLFr6sAq646JMCzb7LHL47mt/vk0
	 T7UvAz0uA4/hSX4dXpOjJkFX63QeecxHyLu8TMIAd/DAwatM+BXHOteBcKE4NMPv/L
	 uK1L1qTB74CCTL2h68oaKb2Uzmuptu/ynR3fOgy4O8yzTliRZKzkCV+SaAbylnmbd2
	 ub/5EdEwZDtBQ88Y4kiv+xXlKKmneeoEtk5l5aAZjpTiWjO5DhjKXL/7vPhyrk1y0w
	 Vug50sskIUNKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 13/15] dmaengine: fsldma: replace irq_of_parse_and_map
 with of_irq_get
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260609221926.35538-14-rosenp@gmail.com>
References: <20260609221926.35538-14-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:36:56 +0000
Message-Id: <20260609223656.828291F00893@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11379-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 667F9664A34

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch adds deferred probe support for per-channel IRQs but neg=
lects the per-controller IRQ.
- [Medium] Negative error codes from `of_irq_get()` are incorrectly logged =
and passed to the IRQ mapping subsystem.

Pre-existing issues:
- [High] Missing `tasklet_kill()` leads to potential use-after-free of the =
channel structure.
--

commit 2b8b79cb3c43b58e4e60c937bb6a8f2ff23ac916
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
   =20
Use of_irq_get() which returns a negative error code on failure
instead of silently returning 0. Split the IRQ validation check
in fsldma_request_irqs to handle three cases.

> The fsldma_free_irqs() function's !chan->irq check is unchanged
> since both 0 and negative values mean no IRQ to free.

[Severity: Medium]
Is this description accurate? In C, negative values like -EPROBE_DEFER
evaluate to true. This means !chan->irq will be false for negative error
codes, skipping the intended check, and potentially passing a negative
value to free_irq() or irq_dispose_mapping() later.

> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..b2259f8f69ab9 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c

[ ... ]

> @@ -1185,7 +1191,7 @@ static int fsl_dma_chan_probe(struct fsldma_device =
*fdev,
>  	dma_cookie_init(&chan->common);
> =20
>  	/* find the IRQ line, if it exists in the device tree */
> -	chan->irq =3D irq_of_parse_and_map(node, 0);
> +	chan->irq =3D of_irq_get(node, 0);

[Severity: High]
Does this change miss updating the per-controller IRQ in fsldma_of_probe()?

If irq_of_parse_and_map() remains in fsldma_of_probe() to set fdev->irq:

    fdev->irq =3D irq_of_parse_and_map(op->dev.of_node, 0);

It will silently return 0 on deferral. The driver then falls back to
checking per-channel IRQs. If they don't exist, probe fails completely
with -EINVAL instead of correctly deferring, preventing deferred probe
from working for the standard per-controller IRQ configuration.

[Severity: Medium]
Will this logging logic incorrectly evaluate negative error codes? In
fsl_dma_chan_probe(), just after this block:

    dev_info(fdev->dev, "#%d (%s), irq %d\n", chan->id, compatible,
             chan->irq ? chan->irq : fdev->irq);

Since chan->irq now stores negative error codes from of_irq_get(), the
ternary operator will evaluate them as true and log the error code
instead of falling back to the controller IRQ.

Additionally, is it safe to unconditionally pass a negative error code to
irq_dispose_mapping() in fsl_dma_chan_remove() if chan->irq failed?

    static void fsl_dma_chan_remove(struct fsldma_chan *chan)
    {
        irq_dispose_mapping(chan->irq);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a
tasklet to trigger a use-after-free here?

During teardown, fsl_dma_chan_remove() does:

    static void fsl_dma_chan_remove(struct fsldma_chan *chan)
    {
        irq_dispose_mapping(chan->irq);
        list_del(&chan->common.device_node);
        iounmap(chan->regs);
        kfree(chan);
    }

It frees the channel memory without first calling
tasklet_kill(&chan->tasklet). If a tasklet was scheduled and remains
pending in the softirq queue, it will execute dma_do_tasklet() after the
chan structure has been freed, dereferencing freed memory.

> =20
>  	/* Add the channel to DMA device channel list */
>  	list_add_tail(&chan->common.device_node, &fdev->common.channels);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609221926.3553=
8-14-rosenp@gmail.com?part=3D1

