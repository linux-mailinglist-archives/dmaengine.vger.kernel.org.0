Return-Path: <dmaengine+bounces-11283-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xkRnJoRTJmqQUwIAu9opvQ
	(envelope-from <dmaengine+bounces-11283-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:30:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D70652D24
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:30:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="mxcOn/it";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11283-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11283-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D086730015A4
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 05:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE1279DB1;
	Mon,  8 Jun 2026 05:30:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E0234994
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 05:30:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896637; cv=none; b=Nln3v1dMUITeJL+E4axdczYfQNr1O9hGsUE3Pm+koneptDUYeUWyMa+4RfHetw6RY3Moo0hLBY4E1NcOvKvVLzt50tcxNttxjcX4D3LTI3TTPXiRnYEW2aAtjyEFdONhXwwGBUnvcgs2rw8uoFMEdlDJ8kWOB3p4C9aS3LBiRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896637; c=relaxed/simple;
	bh=O9qXJaCqIZG+BG++lVUxOkGEoqEp4r/gOM0sSDq0iPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6Q4Fey/j2gkYAn1Zbla3PqIsqM+ve+f4spDBL/gyaU3ix/xJ6b4nUu4FcaNpUuuYmI+jt8gfbbum94Lp5VX0uQvv7c6m1km1+mZiCxiYH/FVjrSy4jcQ8xwiXOAeLycKqetqNS464NWBQkDvUHeN3szn3+zhID+ITi8zBHpGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxcOn/it; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDF51F00893;
	Mon,  8 Jun 2026 05:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780896636;
	bh=1zX0lIDY9SuTC74MAZJEWYJDf8HxamUtclOk2y8Ryno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxcOn/itOx2bgbwo8490Nw6IqVMwruZGAm19svHvDr74xvvUuMUvZHammYHpJWGO+
	 RR/wQ9tH+4xVCK6W26bhvloTVi2l2kWoyf9cq6FxSdsP7rN8bzjS+4BMouBBxI+5Rb
	 Djp5T6u3Fcl1vqm/pTQec5CS5SIAMkpis55fTHtR6/j2I7fNoueFYy4BHxehMwZInk
	 +WS/qI2bCrHbY17Fc4fvh5oEKJJ8hUD1QSwQETsxaPL/vTjMmmDvlJUoLpWqZ5dSGf
	 vZkz40COQ5E9gZbIGMb1u+MuUH1LIF5Gpfa9DF+1A2p/i61YnERlygm3DTijpRnXrS
	 Sj+rI0Phj4WHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] dmaengine: st_fdma: simplify allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260608051829.7390-1-rosenp@gmail.com>
References: <20260608051829.7390-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 05:30:35 +0000
Message-Id: <20260608053036.2EDF51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11283-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93D70652D24

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ handler iterates over the interrupt status register withou=
t verifying bounds against `nr_channels`, allowing hardware to trigger out-=
of-bounds memory accesses.
- [High] The driver requests the IRQ before initializing the virtual DMA ch=
annels, leading to a potential crash due to uninitialized spinlock access i=
f a pending interrupt fires immediately.
- [High] The `st_fdma_remove()` function fails to kill the `vchan` tasklets=
, leading to a potential use-after-free when the `fdev` structure is freed =
by devres.
- [High] Squashing the negative error code from `platform_get_irq()` to `-E=
INVAL` breaks deferred probing.
- [High] On the probe error path, `st_fdma_free()` removes channels from th=
e `dma_device.channels` list before the devres unwinder calls `dma_async_de=
vice_unregister()`, leaking sysfs devices and percpu memory.
--

commit ce37cbca5ef5b425ece0170e4264843d1f67946c
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: st_fdma: simplify allocation

Use a flexible array member to combine kzalloc and kcalloc to a single
allocation. Add __counted_by for extra runtime analysis. Assign counting
variable after allocation before any array accesses.

> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> index d9547017f3bd6..3ec0d6731b8dc 100644
> --- a/drivers/dma/st_fdma.c
> +++ b/drivers/dma/st_fdma.c
[ ... ]
> @@ -742,27 +732,26 @@ static int st_fdma_probe(struct platform_device *pd=
ev)
>  	struct st_fdma_dev *fdev;
>  	struct device_node *np =3D pdev->dev.of_node;
>  	const struct st_fdma_driverdata *drvdata;
> +	u32 nr_channels;
>  	int ret, i;
> =20
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
> +
>  	platform_set_drvdata(pdev, fdev);
> =20
>  	fdev->irq =3D platform_get_irq(pdev, 0);

[Severity: High]
This isn't a bug introduced by this patch, but squashing the negative error
code from platform_get_irq() to -EINVAL breaks deferred probing.

platform_get_irq() can return -EPROBE_DEFER if the interrupt controller is
not yet ready. By overwriting the error code, the driver prevents the
subsystem from retrying the probe later:

	fdev->irq =3D platform_get_irq(pdev, 0);
	if (fdev->irq < 0)
		return -EINVAL;

Does this code leave the device non-functional on systems dependent on
specific probe ordering?

[Severity: High]
This is a pre-existing issue, but does the driver request the IRQ before
initializing the virtual DMA channels?

In st_fdma_probe(), devm_request_irq() is called before the loop that
invokes vchan_init():

	ret =3D devm_request_irq(&pdev->dev, fdev->irq, st_fdma_irq_handler, 0,
			       dev_name(&pdev->dev), fdev);
	...
	for (i =3D 0; i < fdev->nr_channels; i++) {
		...
		vchan_init(&fchan->vchan, &fdev->dma_device);
	}

If an interrupt is already pending from a previous system state, could
st_fdma_irq_handler() run immediately and attempt to acquire
fchan->vchan.lock before vchan_init() has initialized it, leading to an
uninitialized spinlock access?

[Severity: High]
This isn't a bug introduced by this patch, but does the IRQ handler iterate
over the interrupt status register without verifying bounds against
nr_channels?

drivers/dma/st_fdma.c:st_fdma_irq_handler() {
	...
	for (; int_sta !=3D 0 ; int_sta >>=3D 2, fchan++) {
	...

If the hardware sets interrupt status bits for channels equal to or greater
than the configured nr_channels, could this increment the fchan pointer
past the end of the fdev->chans flexible array and cause out-of-bounds
memory accesses?

[Severity: High]
This is a pre-existing issue, but does st_fdma_remove() fail to explicitly
kill the vchan tasklets?

drivers/dma/st_fdma.c:st_fdma_remove() {
	struct st_fdma_dev *fdev =3D platform_get_drvdata(pdev);

	devm_free_irq(&pdev->dev, fdev->irq, fdev);
	...

The device removal callback does not call tasklet_kill() for the channels.
When st_fdma_remove() returns, devres automatically frees the fdev
structure. If a tasklet was scheduled right before the IRQ was freed and
runs after the struct is freed, could it access the vchan struct embedded
in fdev and cause a use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but does st_fdma_free() remove
channels from the dma_device.channels list before the devres unwinder calls
dma_async_device_unregister()?

During the probe error path, st_fdma_free() is called manually:

	err_rproc:
		st_fdma_free(fdev);

This function executes list_del(&fchan->vchan.chan.device_node), removing
channels from the device list:

drivers/dma/st_fdma.c:st_fdma_free() {
	...
		list_del(&fchan->vchan.chan.device_node);
	...

When the devres unwinder subsequently calls dma_async_device_unregister(),
does it iterate over an empty list and skip the channel unregistration,
leaking the allocated percpu memory and sysfs nodes?

> diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
> index f1e746f7bc7dc..27ded555879fb 100644
> --- a/drivers/dma/st_fdma.h
> +++ b/drivers/dma/st_fdma.h
[ ... ]
> @@ -136,13 +136,13 @@ struct st_fdma_dev {
> =20
>  	int irq;
> =20
> -	struct st_fdma_chan *chans;
> -
>  	spinlock_t dreq_lock;
>  	unsigned long dreq_mask;
> =20
>  	u32 nr_channels;
>  	char fw_name[FW_NAME_SIZE];
> +
> +	struct st_fdma_chan chans[] __counted_by(nr_channels);
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608051829.7390=
-1-rosenp@gmail.com?part=3D1

