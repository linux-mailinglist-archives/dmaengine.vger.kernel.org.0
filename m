Return-Path: <dmaengine+bounces-10571-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNVRJW7VDWrW3wUAu9opvQ
	(envelope-from <dmaengine+bounces-10571-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 17:38:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A7B591103
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ADC83252B08
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF43EF65F;
	Wed, 20 May 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZLigGPg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B763EF647
	for <dmaengine@vger.kernel.org>; Wed, 20 May 2026 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290452; cv=none; b=HjuHdJAFgfkcvQMUvE7vZeGYXO7y7rwsRMq4trejZnt6JdsuFJ51OGejIpVMLidUC4HKwoqNvKeo87HWl29BzxCnElWLWh8tIlbmGZSKP8LiwNmr3mR5SLWLOljXj5N3crqX+kfQApocespUc7/4+1HjcG7r7Nk+KUp9z30tEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290452; c=relaxed/simple;
	bh=U78t2XTsdrkSpcOvUZs+LVTmlnbRVaN74O53WhwC1MI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rpSSKUF0Fs6XBN/1pXqe3nKsWlj8Pz6zTzGPXWWeSDsG3g4sMCkhWgiMld4d3qTV2uM4ko3Q4ZELHhcb4P31oqxeUqnTFbgLxqqfpzV61Y8ReUSMex4EgIhi7l87XusDKUSJrFhMgw0Yy+HHlCSfrG5BTQqNdkpveNf+zznvSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZLigGPg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFA01F000E9;
	Wed, 20 May 2026 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290451;
	bh=iDBpk58XcX3X6MEiBEReNCQfEt0+qC/zNj6OgOvFmaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZLigGPgKBWXjT56ZKwPTt/SQvk80BfgTJaYFQ4ukFi74UyoFvVEBWGB4ofC8X9dA
	 tGUrh58bYI9sL0kgD5bHdP5UBJ4H/zH3zkmrZaIeInRJL0YP3Xb3q7Rq5CR0P+Lrmd
	 SO0XDplX/LpGZ4IJFxPoFhCcph6VUZwS3rFhPlGVHBNq1b40DbByxcIvpsLPIOqupE
	 ywn76POB1bcC6BJ8jKwNOF0VjLhJU0hqIabfej7LYC7gr12MiJ/AZKR4MTRxz3vl/P
	 7nOJJkwngduGc2nU4KkNwuMXkzUDvZmDmcjTH66HFh108cVXMkRA8NhWE6K0vMPi0x
	 nXC8M1wagvHlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix problems on initialization error
 path.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steve Wahl" <steve.wahl@hpe.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260520143732.119407-1-steve.wahl@hpe.com>
References: <20260520143732.119407-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 15:20:49 +0000
Message-Id: <20260520152050.8BFA01F000E9@smtp.kernel.org>
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
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10571-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F0A7B591103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Double Free & Double Destroy
- [High] Immediate Double Free in child device cleanup functions
- [High] Use-After-Free and Double Free due to dangling pointers in registr=
ation rollback
--

commit 36d73f2b6ed131031e13332b322a76ce56830ad7
Author: Steve Wahl <steve.wahl@hpe.com>
Subject: dmaengine: idxd: fix problems on initialization error path.

This patch fixes double frees and NULL pointer dereferences in the IDXD
initialization error paths by ensuring allocations are freed only once
during the device release callback, and checking if the workqueue exists
before destroying it.

> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f1cfc7790d950..227e323cc5a0b 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c

[ ... ]

> @@ -649,8 +646,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev=
 *pdev, struct idxd_driver_d
>  	return idxd;
> =20
>  err_name:
> +	/*
> +	 * once device_initialize(conf_dev) is called,
> +	 * put_device(conf_dev) will end up calling
> +	 * idxd_conf_device_release() which will free the rest.
> +	 */
>  	put_device(conf_dev);

[Severity: High]
This is a pre-existing issue, but does a similar pattern cause immediate do=
uble
frees in the child device cleanup functions?

In functions like idxd_clean_wqs(), idxd_clean_groups(), and
idxd_clean_engines() (as well as their setup error paths), cleanup is perfo=
rmed
by calling put_device() on the child kobjects.

This drops the reference count to 0 and synchronously invokes the sysfs rel=
ease
callback (e.g., idxd_conf_wq_release(), idxd_conf_group_release()), which s=
afely
frees the structure (kfree(wq)) and its internal allocations.

However, immediately after put_device() returns, these cleanup functions
explicitly call kfree() on the exact same device structure (and inner point=
ers
like wq->wqcfg). Will this result in immediate double frees when unloading =
the
driver or failing initialization?


[Severity: High]
This isn't a bug introduced by this patch, but are there dangling pointers =
in
the registration rollback that cause a use-after-free?

If idxd_register_wq_devices() (or equivalent engine/group registration
functions) fails, its error rollback drops references to all child devices =
via
put_device() or device_unregister(), which invokes their release callbacks =
and
frees them.

It does not remove the dangling pointers from the idxd->wqs (or groups/engi=
nes)
arrays.

The error then bubbles up to idxd_pci_probe_alloc(), which jumps to
err_dev_register and calls idxd_cleanup(). This eventually calls
idxd_clean_wqs(), which iterates over the full idxd->wqs array and
unconditionally calls put_device() and kfree() on the already-freed pointer=
s.

> +	return NULL;
>  err_opcap:
>  	ida_free(&idxd_ida, idxd->id);
>  err_ida:

[ ... ]

> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d251095c350f..d5ffc641c8567 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device =
*dev)
>  {
>  	struct idxd_device *idxd =3D confdev_to_idxd(dev);
> =20
> -	destroy_workqueue(idxd->wq);
> +	if (idxd->wq)
> +		destroy_workqueue(idxd->wq);

[Severity: High]
This isn't a bug introduced by this patch, but do the error paths from
idxd_probe() still cause a double free and double destroy?

If an error occurs in idxd_probe() (e.g., idxd_device_load_config() fails),
idxd_cleanup_internals() or idxd_setup_internals() error paths are invoked.
These functions manually free arrays (idxd->groups, idxd->wqs, idxd->engine=
s)
and destroy the workqueue (destroy_workqueue(idxd->wq)) but leave the point=
ers
non-NULL.

When the error propagates up to idxd_pci_probe_alloc(), it calls idxd_free()
which calls put_device(). This triggers idxd_conf_device_release().

Because the pointers are still non-NULL, idxd_conf_device_release()
unconditionally calls kfree() on the arrays a second time and executes
destroy_workqueue(idxd->wq) again on the already-destroyed workqueue.

>  	kfree(idxd->groups);
>  	bitmap_free(idxd->wq_enable_map);
>  	kfree(idxd->wqs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520143732.1194=
07-1-steve.wahl@hpe.com?part=3D1

