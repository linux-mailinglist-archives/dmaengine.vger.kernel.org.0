Return-Path: <dmaengine+bounces-11620-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5IBoKrv4M2rUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-11620-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 15:55:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F9F6A0BB9
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 15:55:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hbapDLn4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11620-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11620-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 961C83014A97
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1103BE62A;
	Thu, 18 Jun 2026 13:55:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18013352C3F
	for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 13:55:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790905; cv=none; b=nozyvnEudTtyhTXVEoc2y/e++TluycWs9m3jyRbJLmTuVNHlEzcfe02f7LdgSx5aL9C0To5amxZMTr/2tUt1KzmFRrg8WZv9gdqeCjkWUMbGei+58ra4LikAtTQZimIAxrbA9AIncJPXi2vVV2VJt0lNHLUImLXPKlpBc+JIvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790905; c=relaxed/simple;
	bh=Avu+f8Oyau3AuySIRxulpNvukhn9xTj+TGcg5QJ7oOU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mct7PVQiy+nP377MMpYyhvIrBUVMth6AKYKLpe5/caBe8wx09kOo9D4hLYyj3l0Yy9NrpYpIUpKdMK84VPgbCrIALIWY4R1+5prW8kZXdGFrma7lsn05mgtY6CyfDcVg6flBBzN/heqemhbrbYQMyGeDJgEsJ3hgnY6Pw3+7kYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbapDLn4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755401F000E9;
	Thu, 18 Jun 2026 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781790903;
	bh=kJ8WtHbUYlRbVTuLohD18VH3Ta1fdrDjFNymLa/iAyE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hbapDLn4zPMn+YaDZjC9m6ygPUIpbqt5yeIJYxfEIzrRz0JG0HvkhjDONrANaoZJO
	 5T+TNBRYT0/CzlJ/DocMi/nPTB+cLU7MU/MUmM1S7q8Rbv2GmajH1iSiRUq0KBOpls
	 nYxxJ9euYMlZoWgFXgkJDg0l/rXVAxaMMP3ljr8eDCVaHvHhoqkD53UlpBrwpSg9xm
	 Fa7pZOrkoVZp3geN/LcS27c31KqsGlumZC6iwvVbqzEJP4S+zQxr5D40NmUI/dFrLb
	 LacNPlwKPcAJsR2oy00eHZzofnvbYYBRH1dmbP3zH6kfNV2G9gC1Yca343NFeJHD8T
	 +1MTyxTRAtIAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix use-after-free in idxd_free()
 and idxd_alloc() error paths
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260618113254.493582-1-bogdan.codres@windriver.com>
References: <ajMNBgdsvdLPCt7X@lizhi-Precision-Tower-5810>
 <20260618113254.493582-1-bogdan.codres@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 13:55:03 +0000
Message-Id: <20260618135503.755401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11620-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,windriver.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26F9F6A0BB9

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Widespread double-free vulnerabilities and use-after-free of i=
nternal arrays and workqueues on probe failure paths.
- [High] Kernel panic via `destroy_workqueue(NULL)` in `idxd_conf_device_re=
lease()` during early allocation failures.
--

commit 5374b010ac47ca9ae57388435db01f775b2c068e
Author: Bogdan Codres <bogdan.codres@windriver.com>

dmaengine: idxd: fix use-after-free in idxd_free() and idxd_alloc() error p=
aths

This patch fixes a use-after-free bug in the error paths of idxd_free() and
idxd_alloc(). It removes duplicate frees by letting put_device() handle all
resource cleanup via the release callback.

> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f1cfc7790d950..def37db80d5b8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -601,15 +601,18 @@ static void idxd_read_caps(struct idxd_device *idxd)

[ ... ]

> +/*
> + * Release an idxd device that was allocated (device_initialize() was ca=
lled)
> + * but never successfully registered. put_device() drops the last refere=
nce and
> + * triggers idxd_conf_device_release() which frees all resources includi=
ng the
> + * ida, opcap_bmap, and the idxd structure itself.
> + */
>  static void idxd_free(struct idxd_device *idxd)
>  {
>  	if (!idxd)
>  		return;
> =20
>  	put_device(idxd_confdev(idxd));

[Severity: Critical]
This is a pre-existing issue, but does centralizing the cleanup around
put_device() here expose a double-free during probe failures?

If idxd_probe() fails after partial initialization (like a failure in
idxd_device_load_config()), it explicitly calls idxd_cleanup_internals(idxd)
which frees several pointers and destroys the workqueue:

idxd_cleanup_internals() {
    ...
    destroy_workqueue(idxd->wq);
}

However, it doesn't set these pointers to NULL. When the error propagates
and eventually calls idxd_free(), put_device() triggers
idxd_conf_device_release() which attempts to free those same pointers again:

idxd_conf_device_release() {
    ...
    destroy_workqueue(idxd->wq);
    kfree(idxd->groups);
    kfree(idxd->wqs);
    kfree(idxd->engines);
}

Could this result in slab corruption and a double-destroy of the workqueue?

Also, sub-cleanup functions like idxd_clean_wqs() exhibit a similar pattern
where put_device() triggers idxd_conf_wq_release() (freeing the wq, wqcfg,
and opcap_bmap), but the cleanup loop immediately calls kfree(wq) and
bitmap_free() again.

> -	bitmap_free(idxd->opcap_bmap);
> -	ida_free(&idxd_ida, idxd->id);
> -	kfree(idxd);
>  }
> =20
>  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_=
driver_data *data)

[ ... ]

> @@ -649,8 +652,12 @@ static struct idxd_device *idxd_alloc(struct pci_dev=
 *pdev, struct idxd_driver_d
>  	return idxd;
> =20
>  err_name:
> +	/* device_initialize() was called, so put_device() will trigger
> +	 * idxd_conf_device_release() which frees ida, opcap_bmap, and idxd.
> +	 * Do not fall through to err_opcap/err_ida.
> +	 */
>  	put_device(conf_dev);

[Severity: High]
This isn't a bug introduced by this patch, but will this put_device() call
trigger a kernel panic if early allocation fails?

If idxd_alloc() jumps to the err_name label (for instance, if
dev_set_name() fails), idxd->wq has not been allocated yet. Because
device_initialize() was called, put_device() synchronously invokes the
release callback:

idxd_conf_device_release() {
    ...
    destroy_workqueue(idxd->wq);
}

Since destroy_workqueue() does not check for NULL before dereferencing its
argument, does this result in a deterministic panic when idxd->wq is NULL?

> -	bitmap_free(idxd->opcap_bmap);
> +	return NULL;
>  err_opcap:
>  	ida_free(&idxd_ida, idxd->id);
>  err_ida:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618113254.4935=
82-1-bogdan.codres@windriver.com?part=3D1

