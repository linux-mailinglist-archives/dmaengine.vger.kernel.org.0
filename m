Return-Path: <dmaengine+bounces-11249-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id akhSMHxnI2rHswEAu9opvQ
	(envelope-from <dmaengine+bounces-11249-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:19:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193B164BFCF
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:19:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QAtSUB3Z;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11249-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11249-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B757F300FC72
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE74071D7;
	Sat,  6 Jun 2026 00:16:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BB3EA66;
	Sat,  6 Jun 2026 00:16:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704961; cv=none; b=kWlOevruiTjTx4ft8oNyom3St8cbrhdsHP/myuxLhm3XLL3ZOdmMIHJFg+QspqfR1uq/uVYeDpNXWz2hTsk2jqd50dpe/lQ/L7mYK1hpjQX6szqyPwLc1SOBkx4H/DqYku4n/w27DMvdkoMJp9A/heZTiDTcPisZ5GT5ASR4XQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704961; c=relaxed/simple;
	bh=IumoLe8ixmgYoieknV576Kgvfo8WQgWd3UYpxDagQHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2J4OAb6YlWOmGO57EqrKIyO1Kdh26ozz2NQWmRYLnB4hjrTodkJly+2VF0OIluiLtGN1/yR0D0qsxb0g9Ne5whCzHeQMx3vGV/y5mQ4xIBhwBNQ6tWH/5Kcr6BzWUBNFNcpGbz3T0IbKnlV6sjjIy/cNqBpd7sav+lu1Fhdemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAtSUB3Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E121F00893;
	Sat,  6 Jun 2026 00:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704960;
	bh=i7CFeAY+CBmuWITV4NYCclA8wKNsEzo1NLtTZnwCuZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAtSUB3ZNPsCUesZxxkS1bxPZ2M87+o14KiGFFGlzB7LsCOE9Nj3/mqsT+nUzCRnp
	 3z4uENwesS1lLHOiHt8DV3c7zAfI5UeSeg/eXvP9wGcJa1zpkW2auXALq7IGKqAIvd
	 3+xUcuJKj6X0l0jSrl3QEGfaxorKQ3GwpbzNHhYA00sNavvbHDk1qOWXuN8MHk1hJ1
	 by8ZehEQW1KJwoF3Yz5R/GcmU//t2WPwt+ut6jIauVpPQeaLVe2WJLxigltOSah1Lc
	 82n2nK+Gv871wS4Y4C8KTrBpu5I+Yyi5Y9PhB1emHCai5Zavf1sDwz34HAv+eMnDbc
	 G/pSzFtQfT14Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/23] dmaengine: sdxi: Allocate DMA pools
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-6-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-6-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:15:59 +0000
Message-Id: <20260606001600.49E121F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,amd.com:email,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-11249-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 193B164BFCF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The DMA pool for Context Control (CXT_CTL) blocks is hardcoded t=
o a 64-byte alignment, causing cacheline false sharing on architectures wit=
h larger cache lines.

Pre-existing issues:
- [High] The driver programs hardware registers with physical memory addres=
ses but lacks a hardware quiesce/cleanup path on probe failure, leading to =
a structural DMA Use-After-Free (UAF).
--

commit 9cf4c3500101cb5a3bcbf3a8b8a42a1772787cc2
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Allocate DMA pools

This commit introduces C structures for context control, context status,
and completion status blocks. It creates DMA pools for each during SDXI
function initialization to ensure proper alignment and avoid cacheline
sharing.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
[ ... ]
> @@ -218,6 +221,43 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	return 0;
>  }
> =20
> +static int sdxi_device_init(struct sdxi_dev *sdxi)
> +{
[ ... ]
> +	size =3D sizeof(struct sdxi_cxt_sts);
> +	align =3D max(size, SMP_CACHE_BYTES);
> +	sdxi->cxt_sts_pool =3D dmam_pool_create("CXT_STS", dev, size, align, 0);
> +	if (!sdxi->cxt_sts_pool)
> +		return -ENOMEM;
> +
> +	size =3D align =3D sizeof(struct sdxi_cxt_ctl);
> +	sdxi->cxt_ctl_pool =3D dmam_pool_create("CXT_CTL", dev, size, align, 0);

[Severity: Medium]
Does this fixed alignment introduce false sharing on architectures with
larger cache lines?

The commit message states the goal is to avoid cacheline sharing for
frequently-updated objects, but setting alignment strictly to the struct
size (64 bytes) means the allocator could pack two CXT_CTL objects into
a single 128-byte cache line on platforms where SMP_CACHE_BYTES > 64.

Should this use max(size, SMP_CACHE_BYTES) similar to how the other
pools in this function are aligned?

> +	if (!sdxi->cxt_ctl_pool)
> +		return -ENOMEM;
[ ... ]
> +	err =3D sdxi_fn_activate(sdxi);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>  {
>  	struct sdxi_dev *sdxi;
> @@ -235,7 +275,7 @@ int sdxi_register(struct device *dev, const struct sd=
xi_bus_ops *ops)
>  	if (err)
>  		return err;
> =20
> -	return sdxi_fn_activate(sdxi);
> +	return sdxi_device_init(sdxi);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the probe sequence
leave the hardware active if an error occurs here?

Looking at sdxi_fn_activate(), it programs hardware registers with the
physical addresses of devres-managed memory:

sdxi_fn_activate() {
    ...
    cxt_l2 =3D FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K=
));
    sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
    ...
}

If a subsequent step fails (like sdxi_dev_start timing out), the function
returns an error and sdxi_device_init() propagates it back up to
sdxi_register().

Because devres actions execute in reverse order, the dmam_alloc_coherent
memory is freed before the PCI bus master bit is cleared. Can the active
device perform a DMA into freed memory during this window?

Additionally, if the driver is re-probed, pci_set_master() is called
before sdxi_fn_activate() can stop the device, which might cause the
hardware to immediately resume DMA to the old freed addresses.

Is there a need for a cleanup path on failure that explicitly stops the
device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D6

