Return-Path: <dmaengine+bounces-11349-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ll31KIptKGo9EQMAu9opvQ
	(envelope-from <dmaengine+bounces-11349-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:46:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA7663DDF
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:46:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aRQhYOnW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11349-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11349-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06D2D301C6EF
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FED40D58C;
	Tue,  9 Jun 2026 19:42:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328C3749E3
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 19:42:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034138; cv=none; b=SNAFAO/VtlBEXwVXEreB90FXjszlPBqWe3r7BnvNjd1p+jy5HhEzDs4zndy9ZhMG+dvuylCQZljf2rdt0V+Kl3FsCWoeMyDJ+iU8sMK/Lu2U11dDEDwcdciYzkIwBPZz1n/xgp4TnZ3u4gexfCYqVTcx42e0TN89cHGl7pDwbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034138; c=relaxed/simple;
	bh=M/OA1NmjgFVn4AEERCCYDQ87FoKYcCzJTWzFqzV3I8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBbF5zlXP7aNYJh7EnAGtqKgFeOR9Hylu8bDV6imaIHkQAetyRav1NyoO2Kv8jeqOkbw3aa5G7ONv2Z4h4mPkY6W205sl+4/lvkR+p++VogomtWGMBJ0iv6zASq17ZuVZLdDyvXLQ8FFO1DK9wTnmpC4H3xf0LQLLz6VteZD47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRQhYOnW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E8B1F00893;
	Tue,  9 Jun 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781034137;
	bh=YkYx2WppenpXWINjb3GYK5JlFX4ScapHykaQBxySvkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aRQhYOnWrrvyOhdeMAMmHFCA6KYhW7uNi+LVT+8w80wtDZ6TZV9ccxpa4RvzcgN3v
	 dEd5xPKw77VmktytdI6O3JT67axY96aR4mq072nL0BQcATbq9Ot2GuTTuVQn+UX/aY
	 C+OgtGagzwDv7d/tAWrQ7Vp/SSqxj2oXILf18O2224+Enud6x4uTqKtYEGmft+o7h9
	 RXii/Db4oavLvCiLU2VsBjbFfxrlcaWqUTs6K2DfIqwXfGdQeJKs8yIvC6VAiCpNwL
	 SrX4VOEQn/paDr+4dv5RYUTPs4oCFt2Z3H+PsIYQUgavIQt2ykd57xlntsg/MxbiNy
	 UO7KGlanbYiGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] dmaengine: st_fdma: simplify allocation by using
 flexible array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260609193040.4504-1-rosenp@gmail.com>
References: <20260609193040.4504-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 19:42:16 +0000
Message-Id: <20260609194217.76E8B1F00893@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11349-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17AA7663DDF

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The interrupt handler processes hardware interrupts without bounds=
 checking, potentially causing an out-of-bounds access on the flexible arra=
y.
- [High] Missing teardown of virtual DMA channels and tasklets in the drive=
r remove path.
- [High] The probe function dereferences `drvdata` without ensuring it is n=
on-NULL.
- [High] The device interrupt is requested prematurely before the internal =
structures used by the handler are fully initialized.
--

commit 6e6039b90268df76eca011a93a38a5c5fa030d9b
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: st_fdma: simplify allocation by using flexible array

This patch simplifies the allocation of st_fdma_dev and its channels
by using a flexible array member. It combines kzalloc and kcalloc into
a single devm_kzalloc using struct_size. It also adds the __counted_by
attribute for runtime analysis.

> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> index d9547017f3bd6..3ec0d6731b8dc 100644
> --- a/drivers/dma/st_fdma.c
> +++ b/drivers/dma/st_fdma.c
[ ... ]
> @@ -742,27 +732,26 @@ static int st_fdma_probe(struct platform_device *pd=
ev)
[ ... ]
>  	drvdata =3D device_get_match_data(&pdev->dev);
> =20
> -	fdev =3D devm_kzalloc(&pdev->dev, sizeof(*fdev), GFP_KERNEL);
> -	if (!fdev)
> -		return -ENOMEM;
> -
> -	ret =3D st_fdma_parse_dt(pdev, drvdata, fdev);
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "dma-channels", &nr_cha=
nnels);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to find platform data\n");
> -		goto err;
> +		return ret;
>  	}
> =20
> -	fdev->chans =3D devm_kcalloc(&pdev->dev, fdev->nr_channels,
> -				   sizeof(struct st_fdma_chan), GFP_KERNEL);
> -	if (!fdev->chans)
> +	fdev =3D devm_kzalloc(&pdev->dev, struct_size(fdev, chans, nr_channels)=
, GFP_KERNEL);
> +	if (!fdev)
>  		return -ENOMEM;
> =20
> +	fdev->nr_channels =3D nr_channels;
>  	fdev->dev =3D &pdev->dev;
>  	fdev->drvdata =3D drvdata;
> +	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf", drvdata->name, =
drvdata->id);

[Severity: High]
This is a pre-existing issue, but could this cause a NULL pointer dereferen=
ce
in st_fdma_probe()?

If the device is bound manually by driver name via sysfs to an unrelated
device that happens to have a "dma-channels" property but lacks a matching
compatible string, device_get_match_data() will return NULL.

The code then unconditionally dereferences drvdata->name and drvdata->id
in this snprintf() call.

> +
>  	platform_set_drvdata(pdev, fdev);
> =20
>  	fdev->irq =3D platform_get_irq(pdev, 0);

[Severity: High]
This is a pre-existing issue, but is the device interrupt requested prematu=
rely
before the internal structures used by the handler are fully initialized?

In drivers/dma/st_fdma.c:st_fdma_probe(), devm_request_irq() is called shor=
tly
after this point, before fdev->slim_rproc is allocated via
st_slim_rproc_alloc(), and before the virtual DMA channels are initialized =
via
vchan_init().

If an interrupt fires immediately, st_fdma_irq_handler() runs and calls:

    int_sta =3D fdma_read(fdev, FDMA_INT_STA_OFST);

This macro expands to readl(), which dereferences fdev->slim_rproc.

Because fdev->slim_rproc is still NULL at this point, could this cause an
immediate NULL pointer dereference?

[Severity: High]
This isn't a bug introduced by this patch, but does the interrupt handler
process hardware interrupts without bounds checking?

In drivers/dma/st_fdma.c:st_fdma_irq_handler(), the loop iterates over the
hardware register:

    for (; int_sta !=3D 0 ; int_sta >>=3D 2, fchan++) {
        ...
    }

If the hardware generates an interrupt status with bits set for channels
greater than or equal to the configured fdev->nr_channels, the fchan++ poin=
ter
arithmetic will advance past the flexible array bounds.

Since the driver seems to trust the hardware implicitly, could this lead to=
 an
out-of-bounds memory corruption when writing to fchan->status?

[Severity: High]
This is a pre-existing issue, but is there a missing teardown of virtual DMA
channels and tasklets in the driver remove path?

During probe in drivers/dma/st_fdma.c:st_fdma_probe(), vchan_init()
initializes a tasklet for each channel. These structures are embedded in
fchan->vchan and allocated as part of fdev via devm_kzalloc().

However, drivers/dma/st_fdma.c:st_fdma_remove() doesn't appear to call
st_fdma_free() or tasklet_kill(). When st_fdma_remove() returns, devres
automatically frees the fdev structure.

If a tasklet was scheduled and runs asynchronously after this point, will it
execute a use-after-free on the released memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609193040.4504=
-1-rosenp@gmail.com?part=3D1

