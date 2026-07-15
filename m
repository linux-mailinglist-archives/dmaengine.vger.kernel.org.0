Return-Path: <dmaengine+bounces-12532-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wpriGy3OVmqRBQEAu9opvQ
	(envelope-from <dmaengine+bounces-12532-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 02:02:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D09ED7598C6
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 02:02:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Wb499/S1";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12532-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12532-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27ADC3028E86
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 00:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAA45039;
	Wed, 15 Jul 2026 00:02:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9C42BC47
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 00:02:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073764; cv=none; b=BEa9HdSK+LhnnevOcUWQ4Bd8B2ob9GeIMK/zs2DoPCcIbMd7DOpCiibbCELxSqbn1V0l/MWJxB3PILn8JqQZ8omSIPycLkfJemMnbID6clLWmLGBH+ldUCDcglp9ivnSr5S4Q1sus+g43KTp+m5uKrnW0MFaUMzg9/a6DgZ2pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073764; c=relaxed/simple;
	bh=3zS0whs2AgKFWBYqusvjPgLaOESQJTZSbxgV/zauoWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mM7lRcMG9E1BrIMEukP9kdT0FclurgoZjmsmXjy4tirS8uc+oXqkb/ahYFtoIofxUdnWGV72H2RVDL7pf6D4PjCTWjVZ3JKBh2MNKB8OE8dj4Hbd3StiHNUmExJJZm79JZ+kdWiUvItGMxmW3I8HPvdbwonFj9N+qKxkPWKSt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb499/S1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3AC1F000E9;
	Wed, 15 Jul 2026 00:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784073763;
	bh=8DhD/t4FKzNPUEo95TbklvRvnhaoudWqGlIyYqx2df0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wb499/S1N7DXghlgmSkzHm+VHnoD+QzJHzTNGpPtWlUI46IRlFgwJuQrnf3aRfmqa
	 19Ex65GjNS4XVjHtsj8qS7SGS+5wuUrf99CBad60f7cIynl+JBhB+UwDKrlE+q9lxp
	 UbzAvuZl8lbklkJWjvCqaiGnN1ygQllumdEyhV+Jxz4Rvy0aHGwkM29qWPT+QaxCrf
	 PClMOv6trXb3fUaX0UFsUn4VncbbVgvREj3eygXyoqw2MvSvF95txWy/Dr7oSn9RHv
	 X5jvR3Ly40yXXWi/U47aPborJKlskxHUa09PgV+nwx4sbjnwza6NXrk3abOZwC2yZx
	 1l/usa1OL7V9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: txx9dmac: use
 devm_platform_ioremap_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260714234742.908956-1-rosenp@gmail.com>
References: <20260714234742.908956-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 00:02:42 +0000
Message-Id: <20260715000243.1E3AC1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12532-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D09ED7598C6

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in `txx9dmac_chan_probe` fails to kill `dc->tasklet=
` and leaves a dangling pointer in `dc->ddev->chan`, leading to Use-After-F=
ree.
- [High] Missing `dma_mapping_error()` check after mapping memory with `dma=
_map_single()` in `txx9dmac_desc_alloc`.
--

--- Patch [1]: [PATCH] dmaengine: txx9dmac: use devm_platform_ioremap_resou=
rce() ---
commit bc23f2a8099e4ec156f46c83d8a2cae426f12327
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: txx9dmac: use devm_platform_ioremap_resource()

Replace the open-coded platform_get_resource() plus devm_request_mem_region=
()
and devm_ioremap() sequence with a single devm_platform_ioremap_resource()
call. This folds the resource lookup, region reservation and mapping into
one step and returns an ERR_PTR on failure. This is behaviorally equivalent
as the driver already reserved the region.

> diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
> index 05622b68a9363..6595a54a4b97f 100644
> --- a/drivers/dma/txx9dmac.c
> +++ b/drivers/dma/txx9dmac.c
> @@ -1167,26 +1167,20 @@ static void txx9dmac_chan_remove(struct platform_=
device *pdev)
>  static int __init txx9dmac_probe(struct platform_device *pdev)
>  {
>  	struct txx9dmac_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
> -	struct resource *io;
>  	struct txx9dmac_dev *ddev;
> +	void __iomem *regs;
>  	u32 mcr;
>  	int err;
> =20
> -	io =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!io)
> -		return -EINVAL;
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> =20
>  	ddev =3D devm_kzalloc(&pdev->dev, sizeof(*ddev), GFP_KERNEL);
>  	if (!ddev)
>  		return -ENOMEM;
> =20
> -	if (!devm_request_mem_region(&pdev->dev, io->start, resource_size(io),
> -				     dev_name(&pdev->dev)))
> -		return -EBUSY;
> -
> -	ddev->regs =3D devm_ioremap(&pdev->dev, io->start, resource_size(io));
> -	if (!ddev->regs)
> -		return -ENOMEM;
> +	ddev->regs =3D regs;
>  	ddev->have_64bit_regs =3D pdata->have_64bit_regs;
>  	if (__is_dmac64(ddev))
>  		ddev->descsize =3D sizeof(struct txx9dmac_hwdesc);

While reviewing this file, I noticed a couple of pre-existing issues.

drivers/dma/txx9dmac.c:txx9dmac_chan_probe() {
    ...
	dc->ddev->chan[ch] =3D dc;
	dc->chan.device =3D &dc->dma;
	list_add_tail(&dc->chan.device_node, &dc->chan.device->channels);
	dma_cookie_init(&dc->chan);
    ...
	err =3D dma_async_device_register(&dc->dma);
	if (err)
		return err;
    ...
}

[Severity: High]
This is a pre-existing issue, but does this error path lead to a
Use-After-Free?

If dma_async_device_register() fails, the function returns without performi=
ng
cleanup. It leaves a dangling pointer in dc->ddev->chan[ch] and fails to ca=
ll
tasklet_kill(&dc->tasklet), unlike the cleanup in txx9dmac_chan_remove().

Because the devres framework will free the dc structure, a previously sched=
uled
tasklet or an interrupt handler referencing ddev->chan[0] could dereference=
 the
freed dc structure.


drivers/dma/txx9dmac.c:txx9dmac_desc_alloc() {
    ...
	desc->txd.phys =3D dma_map_single(chan2parent(&dc->chan), &desc->hwdesc,
					ddev->descsize, DMA_TO_DEVICE);
	return desc;
}

[Severity: High]
This is a pre-existing issue, but does this code need to check for DMA mapp=
ing
errors?

The physical address returned by dma_map_single() is assigned and returned
without being validated with dma_mapping_error().

If the mapping fails, it returns a bad DMA address, and the hardware will
subsequently attempt to access this invalid address during descriptor fetch=
ing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714234742.9089=
56-1-rosenp@gmail.com?part=3D1

