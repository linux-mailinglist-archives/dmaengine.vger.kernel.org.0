Return-Path: <dmaengine+bounces-11778-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2YR/JA/zPGp0uwgAu9opvQ
	(envelope-from <dmaengine+bounces-11778-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:21:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C46C429A
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:21:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fXiwuOXJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11778-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11778-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B826F3006152
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3E368968;
	Thu, 25 Jun 2026 09:17:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA832FD665;
	Thu, 25 Jun 2026 09:17:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379064; cv=none; b=fA9nTlCdkBRDomI5sOe1BEGYrsecCgDaURCStTWpaavdf4oaXOeNK11hXfXO/RkwIpxJKPh3EKQ9t+5Ad/QVV/2pgkG/rwwNhrX8KmSR3p77wOzuMCnyW+QDrUbv2IM8iKq/mz4A/ZVIHot4B54tgxnWMnVoZEiIYThYY/v/RjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379064; c=relaxed/simple;
	bh=OTOeFN1k71hQqnK2LjHRaxjSYRg8iEq8+cny2EwuB6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TZyWBcslWpSBlkDSS30Du/KxEq2L0Lwl8bKmvE7aSHJ+L70ot8PVcppc7w7mcbMQ1gxc6wDeH8o2EXLoCe25dy1hOo5wk4k0r868GTmt3OfLoBZqTCtlQ0T4XsBKbs+iivWfuNcMYD99v94qyoU5CMHAaq2vVsPQulisuFsLXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXiwuOXJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AD41F000E9;
	Thu, 25 Jun 2026 09:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782379063;
	bh=sE2N47SbZTjGEDsB8E7tyBjhfI9h2PB7skGRSyJI7Zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fXiwuOXJ6pS3h4NiSBbOklSfu4+rzPi8J6QOkD8Bf+DmVlEi0HFLCDEQcdta3p5o2
	 Zs1BD3fIkBRYalWQXFV5CUZXQoHpnAIGcB+YJiWXNsnTzTwvpKFagIgYeWp33HYbxs
	 QNznKBI5r7WVu5aDVk8vEc1ErJJFObj4OGJB7ERGtncsDhSsreOmxmh2t9IAdVRgWs
	 ELxeJ4aX9WtLiW/c47zERH7rX58xHKEhVrj17xQeaF92yP/qIyW3pYRmjVSeRmp0go
	 ULplidVPEYPr7hW8aMnBkAsFXZdHGCKDPsYxJQAE50T2k2e4K/zki5aH6ipeppeTdP
	 C21zyw+l6bUuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] dmaengine: mcf-edma: Fix error handler for all
 64 DMA channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jean-Michel Hautbois" <jeanmichel.hautbois@yoseli.org>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260625-b4-edma-dmaengine-v3-4-44be00ace37d@yoseli.org>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-4-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:17:42 +0000
Message-Id: <20260625091743.34AD41F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11778-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,yoseli.org:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: CF6C46C429A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Hardware State Corruption: fsl_edma_disable_reque=
st() truncates channel IDs >=3D 32 when disabling error interrupts.
--

commit 95f12f5cb94b6214f42fed40a0a6ec8cb8002d51
Author: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

dmaengine: mcf-edma: Fix error handler for all 64 DMA channels

This commit updates the DMA error interrupt handler to properly process err=
ors
on all 64 channels by iterating over a 64-bit mask with for_each_set_bit().=
 It
also ensures both low and high channel groups consistently use
fsl_edma_err_chan_handler() for error status reporting.

> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 953b20f99f251..3dab5d475d1b4 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
[ ... ]
> @@ -42,30 +42,22 @@ static irqreturn_t mcf_edma_err_handler(int irq, void=
 *dev_id)
[ ... ]
> -	for (ch =3D (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
> -		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
> -			fsl_edma_disable_request(&mcf_edma->chans[ch]);
> -			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
> -			mcf_edma->chans[ch].status =3D DMA_ERROR;
> -		}
> +	for_each_set_bit(ch, err_mask, mcf_edma->n_chans) {
> +		fsl_edma_disable_request(&mcf_edma->chans[ch]);

[Severity: High]
This is a pre-existing issue, but does fsl_edma_disable_request() properly
handle channel IDs >=3D 32?

Looking at fsl_edma_disable_request() in drivers/dma/fsl-edma-common.c, it
uses the EDMA_CEEI_CEEI() macro to write to the ceei register:

    iowrite8(ch, regs->cerq);
    iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);

However, EDMA_CEEI_CEEI(x) masks the channel ID to 5 bits using GENMASK(4, =
0).

When fsl_edma_disable_request() is called for high channels (32-63), the
channel ID will be truncated. For instance, channel 33 would be truncated t=
o 1.

Could this truncation fail to disable the error interrupt for the intended
high channel, leading to a continuous interrupt loop, while erroneously
disabling the interrupt for an unrelated active low channel?

> +		iowrite8(EDMA_MASK_CH(ch), regs->cerr);
> +		fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
>  	}
> =20
>  	return IRQ_HANDLED;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-b4-edma-dm=
aengine-v3-0-44be00ace37d@yoseli.org?part=3D4

