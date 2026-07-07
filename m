Return-Path: <dmaengine+bounces-12082-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gQGZImswTWpXwQEAu9opvQ
	(envelope-from <dmaengine+bounces-12082-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:59:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D871E0DA
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lHe0Htmu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12082-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12082-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D49A300844F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA3436BE8;
	Tue,  7 Jul 2026 16:59:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A8436BF1
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:59:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443547; cv=none; b=f/y8Dn6IiqGRCFOCmoK/hq2CbscewVcefuwVKoiScsEJjeOf6AmFnKDxU06KomAm1pQG1Bvtns+pCI4oShhZBgUW2aVVicFsDk0MO2Tr/MkpYc5qTpvz3TPyYEGR3JHCetYIkvCk9aAmBUyizLVxvmOnyeW3V2Ra/Jox3bhmSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443547; c=relaxed/simple;
	bh=ujXm3ux2+fnHVYwhCALBfHW+7f7Ydfxm9qQZpNFjadg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UeFeQbWwgzHRn14tTFjVRrNDqnptI4hm9uvAUiB6CdpjhDT5A7vscKNNyNsnpvmafByPCWVL0mRndrZFVuLa60DNevl/zj2EUIKbbDAtqDvyY8kM8XPvn3MeXYi6LiGRHEUlpx1uN4pT0zLUBWy0h5lpfSdLx/srjwrrw4/sUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHe0Htmu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249F41F000E9;
	Tue,  7 Jul 2026 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783443546;
	bh=ibMWAEBE5sikHnfXLYDEBawAde/xHeR+Qd2s0WnXlJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lHe0HtmuglzYcFkTYd+hp8bMJk54zeGLLanpT4Diy609Q/OItg/sVKo5MHsFnlH0g
	 wg2MN3AMhw2ufPs++YQfebsUejC2FNaLpCvQiTVMbIm9bv54bpoP8OKt51yYDam68K
	 Vy33/ysliwcaBekkyEF4/bj75nmRyEEw98TLmb0q/XFy4GrVw/WuLlZL7vObI4hEyf
	 z7JY9YWavt+g6k/8n+CL/+H79xBxpe6+U0ZbQ7r+Bm0AW39ocVNOnjLvS7aonpYOFk
	 5fDGP+u+d/RWqdklj0pkFPXQM0BXmFjMwvAykWQJ7h52eA4LzIS++JYqm7JUeJ66Li
	 csRmXioWgKxiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/5] dmaengine: ioatdma: use common channel sysfs
 attribute creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260707162045.23910-3-logang@deltatee.com>
References: <20260707162045.23910-1-logang@deltatee.com>
 <20260707162045.23910-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:59:05 +0000
Message-Id: <20260707165906.249F41F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12082-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:logang@deltatee.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808D871E0DA

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The patch leaves behind an unused `struct kobject kobj` and `IOAT_K=
OBJ_INIT_FAIL` state flag in `struct ioatdma_chan`.
- [Low] Unconditional reference to `dma_chan_sysfs_ops` and `dma_chan_kobje=
ct_add` causes build breakage if `CONFIG_DEBUG_FS` is disabled.

Pre-existing issues:
- [High] Missing `dma_async_device_unregister()` on error paths in `ioat3_d=
ma_probe()` causes Use-After-Free and resource leaks.
- [High] Missing `release` callback in `kobj_type` violates kobject lifetim=
e rules and causes Use-After-Free.
--

--- Patch [2]: [PATCH v1 2/5] dmaengine: ioatdma: use common channel sysfs =
attribute creation ---
commit 88321b4bdaabe072b5dfb4d9c84f04832a5bcc78
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: ioatdma: use common channel sysfs attribute creation

This patch replaces the manual creation of sysfs attributes for each channel
by utilizing the common dma_chan_kobject_add() facility.

> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
[ ... ]
> @@ -393,8 +393,6 @@ void ioat_issue_pending(struct dma_chan *chan);
>  /* IOAT Init functions */
>  bool is_bwd_ioat(struct pci_dev *pdev);
>  struct dca_provider *ioat_dca_init(struct pci_dev *pdev, void __iomem *i=
obase);
> -void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj=
_type *type);
> -void ioat_kobject_del(struct ioatdma_device *ioat_dma);

[Severity: Low]
Is it possible to remove the kobj and IOAT_KOBJ_INIT_FAIL fields from struct
ioatdma_chan as well? Since dma_chan_kobject_add() uses the kobject embedded
in struct dma_chan, these fields appear to be unused now.

> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
[ ... ]
> @@ -1174,7 +1172,7 @@ static int ioat3_dma_probe(struct ioatdma_device *i=
oat_dma, int dca)
>  	if (err)
>  		goto err_disable_interrupts;
> =20
> -	ioat_kobject_add(ioat_dma, &ioat_ktype);
> +	dma_chan_kobject_add(&ioat_dma->dma_dev, &ioat_ktype, "quickdata");

[Severity: Low]
Will this cause a linker error if the kernel is compiled with CONFIG_DEBUG_=
FS
disabled? It looks like dma_chan_kobject_add() might depend on debugfs.

[Severity: High]
This is a pre-existing issue, but does this error path properly clean up
device registration?

If an error occurs during PCI capability configuration later in
ioat3_dma_probe() after dma_async_device_register() succeeds:

    err =3D pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
    if (err) {
        err =3D pcibios_err_to_errno(err);
        goto err_disable_interrupts;
    }

It jumps to err_disable_interrupts and returns an error without calling
dma_async_device_unregister(). Also, with this patch, do the newly added
kobjects need to be cleaned up on this path?

> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
[ ... ]
>  const struct kobj_type ioat_ktype =3D {
> -	.sysfs_ops =3D &ioat_sysfs_ops,
> +	.sysfs_ops =3D &dma_chan_sysfs_ops,

[Severity: Low]
Will referencing dma_chan_sysfs_ops here also cause a build failure when
CONFIG_DEBUG_FS is disabled?

[Severity: High]
This is a pre-existing issue, but does ioat_ktype need a .release callback?

Without it, if sysfs holds a reference to the kobject during driver unload,
could it access freed memory when the kobject core later tries to release i=
t?

>  	.default_groups =3D ioat_groups,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707162045.2391=
0-1-logang@deltatee.com?part=3D2

