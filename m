Return-Path: <dmaengine+bounces-12080-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ZbVFqAvTWowwQEAu9opvQ
	(envelope-from <dmaengine+bounces-12080-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:56:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DD71E09B
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:55:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="okEpNAr/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12080-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12080-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F856300B1A4
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242E3EBF36;
	Tue,  7 Jul 2026 16:55:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AD3EB81E
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:55:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443357; cv=none; b=l1AblhCibDMRsxcSZ0WjvZoUgNGLqUE3Y1efy0zc/sLazuz5qPo/d+gBU7EtHKEf584aoWC2MszaXJ/dBEWfkmdr/U1Wouv9ceEfm9ym/7op1HxEOS6/42aN9QcPt7zNpcxk9Oe0QbmrAqJ3rzaiwNLP0E7EuTJatSyBsyKwtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443357; c=relaxed/simple;
	bh=UIhneQoj/JzhcklAKaVgl8GSa7B/Uuy1kPj6OuUhp80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rl5PwCqwhT0pxEcumkCAkR0VbJVvOTIS4PgckgXBCIsOXlHArjUrFDUzw6v8yDJF8Jnz6I6B1KrCYy2Vmmv+I7MndRZTPtTdg1nSsVx2lqek9yScCB/8VeW3tCjDO/LvS+EJ037KARCP4EpRO2FowguvimqDOVBE4w4yXHQHea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okEpNAr/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350951F000E9;
	Tue,  7 Jul 2026 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783443356;
	bh=JJSXNHi0k3LqkDSSpjLvG3fjIZIWnSwtSE89SDFpfjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=okEpNAr/woH/3wK4fsRVeF8sS+uB1TYeh7NLAyZHWJyN7gc8ehN4P5kEv5aUiXx/k
	 PY/bA1If+pOhDKS6WCVsvTf1C5YrIcEre+iSD2Uhr5it8rC0OHKpQAlNRQgcA+OAES
	 CFZoEN37UTCWqdklJb8ySBeem7hsRO/ljnA0Ip0JDpBTfsDBvp4ZbS3xxkaQzEw3ah
	 PLw3hGlGNHvVaMh+vB48zZhko3DJg+KNBI1fYmdG5BZjCqqx9ujthZyOFhcJ2Yky7o
	 4qJ6h0SScNpYt2YRLYTn0M3APsxXSCAgNfuUNtFM+3dskVVN1sFmhTWOqvU9pGq/SJ
	 8J35gbKOe/e5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/5] dmaengine: switchtec-dma: Add config sysfs
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260707162045.23910-4-logang@deltatee.com>
References: <20260707162045.23910-1-logang@deltatee.com>
 <20260707162045.23910-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:55:54 +0000
Message-Id: <20260707165555.350951F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12080-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:logang@deltatee.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,deltatee.com:email,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D43DD71E09B

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Concurrent sysfs writes to different configuration attributes ca=
use lost updates due to an unlocked read-modify-write sequence.
- [Medium] The configuration store function silently ignores writes when th=
e channel is in use by returning success instead of an error code.
- [Medium] Lockless check of `chan->client_count` allows modifying channel =
configuration while the channel is concurrently allocated.

Pre-existing issues:
- [High] Memory leak of DMA channel structures on initialization failure.
- [High] switchtec_dma_alloc_chan_resources leaks DMA memory and descriptor=
s on error paths.
--

--- Patch [3]: [PATCH v1 3/5] dmaengine: switchtec-dma: Add config sysfs at=
tributes ---
commit 8760f8c3c1480cd451ac42e9181aa92c4b359981
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: Add config sysfs attributes

Add sysfs configuration options for switchtec-dma devices.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef9286406159..4841134bd7b83 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1027,6 +1027,145 @@ static int switchtec_dma_alloc_chan_resources(str=
uct dma_chan *chan)
>  	return SWITCHTEC_DMA_SQ_SIZE;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed that
switchtec_dma_alloc_chan_resources() allocates coherent DMA memory and
descriptor rings by calling switchtec_dma_alloc_desc(). If any subsequent
hardware initialization step fails, it returns directly with an error code:

	rc =3D switchtec_dma_alloc_desc(swdma_chan);
	if (rc)
		return rc;

	rc =3D enable_channel(swdma_chan);
	if (rc)
		return rc;

Since the dmaengine core handles allocation failures by dropping the module
reference without calling device_free_chan_resources(), does this permanent=
ly
leak the allocated descriptors and 32KB coherent DMA memory blocks?

> +static __always_inline ssize_t perf_cfg_store(struct dma_chan *chan,
> +		const char *page, size_t count, unsigned int mask)
> +{
> +	struct switchtec_dma_chan *swdma_chan =3D
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_fw_regs __iomem *chan_fw =3D swdma_chan->mmio_chan_fw;
> +	ssize_t ret =3D count;
> +	u32 perf_cfg;
> +	int value;
> +
> +	if (kstrtoint(page, 0, &value) < 0)
> +		return -EINVAL;
> +
> +	if (value < 0 || value > field_max(mask))
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +		ret =3D -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	if (chan->client_count)
> +		goto err_unlock;

[Severity: Medium]
If the channel is in use (chan->client_count is non-zero), the code jumps to
err_unlock but returns ret (which is still initialized to count). Will this
falsely indicate to userspace that the write succeeded instead of returning=
 an
error code like -EBUSY?

[Severity: Medium]
Also, this lockless check of chan->client_count appears to allow a TOCTOU
race. Could a concurrent thread allocate the channel via
dma_request_chan() immediately after this check passes, causing the sysfs
thread to modify the hardware configuration out from under an active DMA
client?

> +
> +	perf_cfg =3D readl(&chan_fw->perf_cfg);
> +	perf_cfg =3D (perf_cfg & ~mask) | field_prep(mask, value);
> +	writel(perf_cfg, &chan_fw->perf_cfg);

[Severity: Medium]
This read-modify-write sequence on the shared MMIO register
chan_fw->perf_cfg appears to be unprotected by hw_ctrl_lock or any other
lock. If there are concurrent sysfs writes to different attributes (like
burst_scale_store and mrrs_store), could they interleave and cause one of
the updates to be lost?

> +
> +err_unlock:
> +	rcu_read_unlock();
> +	return ret;
> +}

[ ... ]

> @@ -1286,6 +1425,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  		goto err_chans_release_exit;
>  	}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but if
dma_async_device_register() fails during probe (which jumps to
err_chans_release_exit just above here), does it leak the dynamically
allocated swdma_chan structures?

The error path calls switchtec_dma_chans_release(), which stops hardware
and frees IRQs, but never calls kfree() on the channels or the
swdma_dev->swdma_chans array itself.

> +	dma_chan_kobject_add(dma, &switchtec_ktype, "switchtec");
> +
>  	pci_dbg(pdev, "Channel count: %d\n", chan_cnt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707162045.2391=
0-1-logang@deltatee.com?part=3D3

