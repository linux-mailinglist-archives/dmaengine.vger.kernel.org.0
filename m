Return-Path: <dmaengine+bounces-12081-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OCH2MCAwTWpIwQEAu9opvQ
	(envelope-from <dmaengine+bounces-12081-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:58:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BA71E0BB
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NhuKJ16t;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12081-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12081-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF5FC3010669
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D253EB10D;
	Tue,  7 Jul 2026 16:58:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB322A1D4
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:58:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443486; cv=none; b=Vw569OpgZ++YWeSHNHZkI/TUAHjuRJhr9Iphr6w1xIr65DdZ2kT+HczdhFWhsSxqmPEjmxA19X3r5P2JEdPHSEK0tvmW0nFDKX6UXwafcgIIGYvcZmGWjP/qpncrgndbCdOoEpFoUHXRTf1+IZhjxZHHywbgUca90/Z5vbaDEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443486; c=relaxed/simple;
	bh=ZtvpHitOMCmfboutdp0oNp9U5lgKVnBlUOrlO3qxUy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BkB4lJ84UEVS7nAY3Cq1HDGERp9NKN0yPmiSxrzS190WOT7a0++UKsdPaKlpUE9iM9dJX6eQWyxJORqugyi4eBa7ZoKjnWLkxu1sUPA2b0Ha6FeUnfgJnshb3dIYG9BzoHcS+n3e7t0/y6A5zZDEnEPrUWm3+agRintfDmMY0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhuKJ16t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A241F000E9;
	Tue,  7 Jul 2026 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783443485;
	bh=tZ6qLEr3U59FWZbyr0YVV3M2PWAjxuh9IXSObBEZULg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NhuKJ16tqsEh6dt8BOWxGl4vh5Y2QIBeGMd1yGXz0NpARXLkcY43Q4K/qxPG6ZgNf
	 xql0xmMSw063/yyi+ECFkrBwnvrMq2c4jaUo7JXhdb1qz3e+jqVycDBvcfCIeYp9Vw
	 nIEpiZKKsbNYuDPWFP02HM0rPUV/5gubt+YYwX0GD8sBKabnllqksVAYjW7NAEgi2l
	 EGcc04tAafnXoxbjiyxBSvrMD0dTYkil9SYSPVkh+wD40IVVQLL3GB3g+/KeJsjfye
	 kGr015XyFj4TXqLCDh0h0ypCDkWPJ1R9kyxvWIfTzqK+xJtNSDX1MMow5Z6qJBsQr9
	 2zugPKfuqs6lA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] dmaengine: switchtec-dma: Add pmon sysfs
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260707162045.23910-5-logang@deltatee.com>
References: <20260707162045.23910-1-logang@deltatee.com>
 <20260707162045.23910-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:58:04 +0000
Message-Id: <20260707165804.C1A241F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12081-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 578BA71E0BB

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `.release` callback in `switchtec_ktype` causes Use-After-=
Free of channel memory when sysfs files are held open during device removal.
- [Low] The `latency_selector_show` function violates sysfs rules by using =
`strcat()` to build a multi-line menu instead of using `sysfs_emit()`.
--

--- Patch [4]: [PATCH v1 4/5] dmaengine: switchtec-dma: Add pmon sysfs attr=
ibutes ---
commit 9353b00f22d3df92fe9cfb71beccb84977c35e68
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: Add pmon sysfs attributes

Switchtec hardware exposes some performance monitor registers which
can be used to monitor various statistics of the hardware. Expose
these as a sysfs interface under the switchtec group in a pmon
sub-group.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 4841134bd7b83..2ac43eb58995a 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -1156,8 +1163,200 @@ static struct attribute_group switchtec_config_gr=
oup =3D {
>  	.attrs =3D switchtec_config_attrs,
>  };
> =20
> +#define pmon_show(chan, page, field, reader) ({				     \
> +	struct switchtec_dma_chan *__swdma_chan =3D			     \
> +		container_of((chan), struct switchtec_dma_chan, dma_chan);   \

[ ... ]

> +static ssize_t latency_selector_show(struct dma_chan *chan, char *page)
> +{
> +	struct switchtec_dma_chan *swdma_chan =3D
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_fw_regs __iomem *chan_fw =3D swdma_chan->mmio_chan_fw;
> +	u32 lat =3D 0;
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	lat =3D readl(&chan_fw->perf_latency_selector);
> +	rcu_read_unlock();
> +
> +	strcat(page, "To select a latency type, write the type number (1 ~ 5) t=
o latency_selector\n\n");
> +
> +	strcat(page, "Latency Types:\n");
> +	strcat(page, "(1) SE Fetch latency");

[Severity: Low]
Should this code use sysfs_emit() instead of strcat() to construct the menu=
 on
the raw page buffer? Sysfs documentation requires using sysfs_emit() and
generally expects a single value per file rather than a multi-line string.

> +	if (lat & SWITCHTEC_LAT_SE_FETCH)
> +		strcat(page, " (*)\n");
> +	else
> +		strcat(page, "\n");

[ ... ]

>  static const struct attribute_group *switchtec_groups[] =3D {
>  	&switchtec_config_group,
> +	&switchtec_pmon_group,
>  	NULL,
>  };

[Severity: High]
Does the driver's kobj_type (switchtec_ktype) lack a .release callback?

If a userspace process holds a channel's sysfs file open, keeping the
embedded kobject refcount elevated, and the device is unregistered,
switchtec_dma_release() unconditionally frees the channel memory.

When the file is closed later and the refcount drops to zero, the kernel
would access the already-freed kobject to invoke the missing release
function, leading to a Use-After-Free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707162045.2391=
0-1-logang@deltatee.com?part=3D4

