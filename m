Return-Path: <dmaengine+bounces-11069-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kxkoNzebG2pWEgkAu9opvQ
	(envelope-from <dmaengine+bounces-11069-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:21:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E66143AC
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A110E3004D19
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E411A5BAE;
	Sun, 31 May 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8Xt8UTM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BEA194A6C
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780194096; cv=none; b=fQjh1c/IkMDJgbS5onui5etiRxsk2e9LBjagscsfstGNYY/D1ioJtWf4EQI9vCbM5hHHa5TQ8ESDErTW7bONOShJeBSpm0O4ttwaltohJglNKCjOm4ecUbU9u37u8gTo6I97UpTOwudb37NeScw1RrZ1bkEY/QZc+SPqEP6q40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780194096; c=relaxed/simple;
	bh=iTfA5bxADvrDo+jbG9cF5TOGO4AqPKGrZuZaAq/23tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HtSR6qfSEBP+vaqN1g1PJI+vEou7G69gTPADanbVsfZqav1Uba5iCgECagSAmkuQd6BWe6emvb481wmChDRJn0UYmSjZyfCXTzY8e7KhuJJIDrhuWIoW2AduUZ3bXYlp3/WUTS9yK7tpBnFdib4zaCS9rLo3s96zgEy3AFIcY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8Xt8UTM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B4F1F00893;
	Sun, 31 May 2026 02:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780194095;
	bh=xoqBdyV1q3yyHvXaLGRox9VMhksHteso3ufis4v5kPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8Xt8UTMqW3kTuQuiGBrnygvtxB5cz+ZLD9BnhSZzy4sXRfV4P8DnyqDlIeoLmzPW
	 8PpEeJIFtXrqhrrhgNoR2dMxi1on8NDm3kmnXRsbiJm551nUJzY2QXP9CxztHJizG8
	 jbY93F+3JXReYJeSzxTU5QNk7owC8tNhciShK5HCkvHUu0ackhXIrpWsLg7q4rZgF2
	 vasJcdo/6knCaLXaTHbDagJ0wWxZEfyXvHIjlk9RI3hXrGmIKpxYvcKNg5XtmHMgKF
	 G2z3mhbcjf4O1yx41Fs3KYXchQ+jtZxMQuZrU14LgflfN79yPxN9Cm7RbqKKwiy5i0
	 esyb2Q7AYSLVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3] dmaengine: ste_dma40: turn d40_base phy_chans into a
 flexible array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260531020843.594892-1-rosenp@gmail.com>
References: <20260531020843.594892-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 02:21:34 +0000
Message-Id: <20260531022134.E2B4F1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11069-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: CE0E66143AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and write on `dma40_memcpy_channels` due to inc=
orrect array size and clamping limit.
--

commit f80ed233c1567c0d1ee4933ba428492ac35dc443
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array

Convert the separately-offset phy_chans pointer to a C99 flexible array
member at the end of struct d40_base, and switch the allocation to
struct_size().

> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 9b803c0aec254..0d9ffa3e26639 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c

[ ... ]

> @@ -3185,22 +3186,24 @@ static int __init d40_hw_detect_init(struct platf=
orm_device *pdev,
>  	else
>  		num_phy_chans =3D 4 * (readl(virtbase + D40_DREG_ICFG) & 0x7) + 4;
> =20
> +	num_phy_chans =3D min(num_phy_chans, STEDMA40_MAX_PHYS);
> +
>  	/* The number of channels used for memcpy */
>  	if (plat_data->num_of_memcpy_chans)
>  		num_memcpy_chans =3D plat_data->num_of_memcpy_chans;
>  	else
>  		num_memcpy_chans =3D ARRAY_SIZE(dma40_memcpy_channels);
> =20
> +	num_memcpy_chans =3D min(num_memcpy_chans, D40_MEMCPY_MAX_CHANS);

[Severity: High]
This isn't a bug introduced by this patch, but does this clamping limit all=
ow
out-of-bounds accesses on the dma40_memcpy_channels array?

The dma40_memcpy_channels array has exactly 6 elements, but
D40_MEMCPY_MAX_CHANS is 8.

When d40_of_probe() is called, it permits num_memcpy up to 8 and writes
them into the array:

drivers/dma/ste_dma40.c:d40_of_probe() {
    ...
    of_property_read_u32_array(np, "memcpy-channels",
                               dma40_memcpy_channels,
                               num_memcpy);
    ...
}

Can this cause an out-of-bounds write corrupting adjacent memory?

Additionally, because num_memcpy_chans is clamped to 8 here in
d40_hw_detect_init(), it allows up to 8 memcpy channels to be registered.

When clients allocate these channels, d40_config_memcpy() indexes the array:

drivers/dma/ste_dma40.c:d40_config_memcpy() {
    ...
    d40c->dma_cfg.dev_type =3D dma40_memcpy_channels[d40c->chan.chan_id];
    ...
}

If chan_id is 6 or 7, won't this result in an out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531020843.5948=
92-1-rosenp@gmail.com?part=3D1

