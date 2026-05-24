Return-Path: <dmaengine+bounces-10781-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ0YO21uEmo7zQYAu9opvQ
	(envelope-from <dmaengine+bounces-10781-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 05:20:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 547FC5C13AE
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 05:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B6E3011584
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E202857EE;
	Sun, 24 May 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8PRy+Yj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF622257825
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779592803; cv=none; b=dghza7TpMi7yBslrd8/6fRA22IVSrjp8SSwnDrZHhH3AxJU5tvmNTcaex5FGoyq96MzctQ8dLn1DOWTKDBuVD17b+B26zfc6L1d2WTv/30qghsgd8UdljhZheQUnywnvGZ7SHRlxN4g9WZiunM4Mp0oxwg2r06iwUpoQ5zWWoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779592803; c=relaxed/simple;
	bh=ybrPvEBTsWXL7aRETvPDnz3ockMXDU8+2PE42VaOsdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKw3hXwZD5x9uT4X/oCX+9j0W+F32pt6sLjjMf8VF7Qg1i6VHZd0KcBjhJEqKLyN0wKjy24Zx5FvScDUCMnRV65Az+qxZlTfzq0WcsLV/eD2p9ykyNP1aEeGDAh1kTLtYGKC993IrX8q5HAsj7Otd/3NgAHeu+gfbS8d1q2qe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8PRy+Yj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530F91F000E9;
	Sun, 24 May 2026 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779592801;
	bh=VuYDFvrObzVZ59CxkTbsloizcyTddFjsj9D+vlCeduc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8PRy+YjQgQ6WefbZLNF1s5fAaGMR7cyoR0uBc95Z+tuURB0YDppp1kNSgHnU+P0i
	 kjQaUbsqFWeG1blFo+SdKolwdRpqgFYzw8HbUAe41ILLXAhkj5LFQBsWfwb0D0DtBc
	 RYIcNVuMNMpPYtiEF4RDmAef+tj9FjdTnadroK5OAmIlYCLJsHRl3La/l2UZPy2cme
	 B2HqEGR0OKwUvbQwV7DmSVfqnqZ0ngaEbwlr3V6qfaWiH36Oetg+5Aie6wnzTowkz+
	 H/4de8/kt5pLQd64ZGItaCQHyhFeH7B8o07eQZRNwBaZGrXpGWoy3b953dA9crHIVN
	 /wVEVtA20sywA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: turn lch_map into a flexible
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260524024614.182126-1-rosenp@gmail.com>
References: <20260524024614.182126-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 03:20:00 +0000
Message-Id: <20260524032001.530F91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10781-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 547FC5C13AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded `dma-channels` device tree property causes out-of-bounds=
 stack read and heap buffer overflow.
- [High] Missing return on error path and improper unregistration leaves a =
dangling CPU PM notifier, leading to Use-After-Free.
--

commit 91ef33462c6154050830fe926f0bdab84e94c15b
Author: Rosen Penev <rosenp@gmail.com>
Subject: dmaengine: ti: omap-dma: turn lch_map into a flexible array

Convert the separately-allocated lch_map pointer array to a C99 flexible ar=
ray
member at the end of struct omap_dmadev and annotate it with
__counted_by(lch_count). The probe is reordered so platform_data lookup and
the lch_count determination happen before the parent allocation. This lets
struct_size() size the FAM, collapsing two allocations into one.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99a..901e38b089624 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c

[ ... ]

> @@ -1656,36 +1656,53 @@ static int omap_dma_probe(struct platform_device =
*pdev)
>  	const struct omap_dma_config *conf;
> +	struct omap_system_dma_plat_info *plat;
>  	struct omap_dmadev *od;
> +	int lch_count;
>  	int rc, i, irq;
>  	u32 val;
> =20
> -	od =3D devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
> -	if (!od)
> -		return -ENOMEM;
> -
> -	od->base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(od->base))
> -		return PTR_ERR(od->base);
> -
>  	conf =3D of_device_get_match_data(&pdev->dev);
>  	if (conf) {
> -		od->cfg =3D conf;
> -		od->plat =3D dev_get_platdata(&pdev->dev);
> -		if (!od->plat) {
> +		plat =3D dev_get_platdata(&pdev->dev);
> +		if (!plat) {
>  			dev_err(&pdev->dev, "omap_system_dma_plat_info is missing");
>  			return -ENODEV;
>  		}
>  	} else if (IS_ENABLED(CONFIG_ARCH_OMAP1)) {
> -		od->cfg =3D &default_cfg;
> -
> -		od->plat =3D omap_get_plat_info();
> -		if (!od->plat)
> +		plat =3D omap_get_plat_info();
> +		if (!plat)
>  			return -EPROBE_DEFER;
>  	} else {
>  		return -ENODEV;
>  	}
> =20
> +	/* Number of available logical channels */
> +	if (!pdev->dev.of_node) {
> +		lch_count =3D plat->dma_attr->lch_count;
> +		if (unlikely(!lch_count))
> +			lch_count =3D OMAP_SDMA_CHANNELS;
> +	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels",
> +					&lch_count)) {

[Severity: High]
This is a pre-existing issue, but does this code properly bound the value
read from the dma-channels device tree property?

If a malformed device tree provides a value greater than OMAP_SDMA_CHANNELS
(which is 32), the subsequent call to bitmap_from_arr32(od->lch_bitmap,
&val, od->lch_count) will attempt to read more than 32 bits from the single
32-bit stack variable 'val'.

Since od->lch_bitmap is strictly sized to 32 bits via:
    DECLARE_BITMAP(lch_bitmap, OMAP_SDMA_CHANNELS);

Could this out-of-bounds stack read silently corrupt subsequent members of
the omap_dmadev structure on the heap (such as the lch_lock mutex)?

> +		dev_info(&pdev->dev,
> +			 "Missing dma-channels property, using %u.\n",
> +			 OMAP_SDMA_CHANNELS);
> +		lch_count =3D OMAP_SDMA_CHANNELS;
> +	}

[ ... ]

>  	if (pdev->dev.of_node) {
>  		omap_dma_info.dma_cap =3D od->ddev.cap_mask;
> =20
>  		/* Device-tree DMA controller registration */
>  		rc =3D of_dma_controller_register(pdev->dev.of_node,
>  				of_dma_simple_xlate, &omap_dma_info);
>  		if (rc) {
>  			pr_warn("OMAP-DMA: failed to register DMA controller\n");
>  			dma_async_device_unregister(&od->ddev);
>  			if (od->ll123_supported)
>  				dma_pool_destroy(od->desc_pool);
>  			omap_dma_free(od);
>  		}

[Severity: High]
This is a pre-existing issue, but is there a missing return statement in
the of_dma_controller_register() error path above?

If of_dma_controller_register() fails, the code handles the error by logging
a warning and calling omap_dma_free(od) but fails to immediately return 'rc=
'.

Execution falls through, eventually calling cpu_pm_register_notifier(&od->n=
b)
and then returning the error code 'rc'.

Because the probe function returns an error, the driver core will free 'od'
via devres. However, the CPU PM notifier remains globally registered. When a
CPU PM event occurs, could the kernel invoke the notifier callback with the
freed 'od' pointer, resulting in a use-after-free?

Additionally, does the unregistration logic in omap_dma_remove() properly
clean this up? It appears to only unregister if 'may_lose_context' is true,
but probe registers it if 'needs_busy_check' is true as well.

>  	}
> =20
>  	omap_dma_init_gcr(od, DMA_DEFAULT_ARB_RATE, DMA_DEFAULT_FIFO_DEPTH, 0);
> =20
>  	if (od->cfg->needs_busy_check) {
>  		od->nb.notifier_call =3D omap_dma_busy_notifier;
>  		cpu_pm_register_notifier(&od->nb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524024614.1821=
26-1-rosenp@gmail.com?part=3D1

