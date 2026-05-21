Return-Path: <dmaengine+bounces-10594-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PvVYBOZuDmq8+gUAu9opvQ
	(envelope-from <dmaengine+bounces-10594-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 04:33:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C9359E1AD
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 04:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 218543029ADF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D51374E67;
	Thu, 21 May 2026 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUFcPfPq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409B374E59;
	Thu, 21 May 2026 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330784; cv=none; b=RH9MZIodXJjDz5JGPcnZjGyM7xCHAHjVgA+Bxd7a+AtTgk9iyb0/GlYDTIzlOR123ERkZIrpXOMAOnSa3r1dWV5I9joL8NTPtBbJdMgyWuFEgednb3Ac2Qu5fjglHYJ9MYKRqXe9bpyIQZaFCtYzwh33r0A3U4AQmuMghDEE8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330784; c=relaxed/simple;
	bh=bSouOYjbO9wQisXnE3DbDRACrnMK3pdhQu8bBdpajJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sfLVWNrCfadLN29xnK+OX+sZM0fQ5lALJxq+9nuhEZqRKLc/N3ACZnoKs5spD3ltVDHMfxvEZw2ZST2d1FVNZsIhcZA/4AeoCp01We6cTXtMpaXFIy2DEpcxVCPhHU1jsIy/ijSijXlhTLciB/JXzf+5e2MNUojhgOryXQdEAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUFcPfPq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B64D1F000E9;
	Thu, 21 May 2026 02:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330782;
	bh=EruT6tbNFZLtddN5V3nDgOjDRfmWNl79RdOq4jgTVi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUFcPfPqTFz2sKhLB1AYdw0iPUMztRlrFrYitnBl8Ud6nVpy6WiuRgPTiBRhKEIHq
	 sDouHbnt7wbwyRQXzSDXh6u/vmRtGVdD2u2Vi3YR/xwcVnVTotNSAPmjAWrZ86CKvk
	 BX9lQVBA/Me2Toi2jgITzR4ndnO/XJnu8McuYK0rWutwiiVzCBi/2KwLciSqFogEww
	 P4UeDZ9hdX6YZSSuZNpRN/7cWLo+7yqPDgpoOJjqqS9/+TV5Mdt/nZoDpu62Xoncmm
	 Kb/ZvhGQUtVqzCBD+YeaEhDxrppsmJmQsAHhFuOJGCWeRfur+DZpKkAGA9oqEbwKaO
	 +35FL3I53C7dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] crypto: atmel: Use dmaengine_prep_config_sg()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260520-dma_prep_config-v6-9-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-9-06e49b7acb38@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 02:33:02 +0000
Message-Id: <20260521023302.7B64D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10594-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,nxp.com:email];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 73C9359E1AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Tasklets can be rescheduled after they are killed during device re=
moval, leading to a Use-After-Free.
- [High] The device unbind path does not wait for active crypto transforms =
(TFMs) to be freed, leading to a Use-After-Free.
- [High] Pending requests in the crypto queue are not completed or flushed =
during device removal.
- [High] Calling `dmaengine_terminate_sync()` from atomic context (tasklet/=
softirq) in the error path.
--

commit 8fb292764f2c30a42b59a7ee1bce9dcae3cc201f
Author: Frank Li <Frank.Li@nxp.com>

crypto: atmel: Use dmaengine_prep_config_sg() API

This commit simplifies the driver by replacing dmaengine_slave_config()
and dmaengine_prep_slave_sg() with the combined dmaengine_prep_config_sg()
API. It converts both configuration and descriptor preparation failures to
return -ENOMEM.

> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index b393689400b4c..d890b5a277b9c 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_=
aes_dev *dd,
[ ... ]
> -	err =3D dmaengine_slave_config(dma->chan, &config);
> -	if (err)
> -		return err;
> -
> -	desc =3D dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
> -				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	desc =3D dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
> +					&config);
>  	if (!desc)
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but can this error path lead to a kernel BUG
by sleeping in an atomic context?

If dmaengine_prep_config_sg() fails and returns NULL, it seems the failure
propagates up to atmel_aes_dma_start() which might jump to an error label
and call dmaengine_terminate_sync().

Since the crypto request queue is processed via atmel_aes_queue_task()
(a tasklet running in softirq context), wouldn't calling
dmaengine_terminate_sync() (which uses might_sleep()) from this atomic
context cause issues?

[Severity: High]
This is a pre-existing issue, but does device removal have a use-after-free
vulnerability if a DMA transfer completes concurrently?

In atmel_aes_remove(), tasklet_kill() is called before
atmel_aes_dma_cleanup(). If a DMA transfer completes immediately after
tasklet_kill(), the interrupt callback (atmel_aes_dma_callback()) could
execute and schedule the queue_task tasklet again via tasklet_schedule().

Since the aes_dd driver data structure is managed via devm_kzalloc() and
freed upon return from atmel_aes_remove(), would the tasklet subsequently
access freed memory when it runs?

[Severity: High]
This is a pre-existing issue, but does the unbind path properly wait for
active crypto transforms (TFMs) to be freed?

In atmel_aes_remove(), the driver unregisters its algorithms using
crypto_unregister_algs(). This prevents new TFMs from being instantiated,
but it doesn't appear to revoke or wait for active TFMs to be freed.

Because aes_dd is allocated using devm_kzalloc() and freed once
atmel_aes_remove() completes, could subsequent crypto operations triggered
by userspace via remaining TFMs dereference the freed aes_dd structure?

[Severity: High]
This is a pre-existing issue, but are pending requests in the crypto queue
completed or flushed during device removal?

During device unbind and atmel_aes_remove(), it appears the driver never
purges, aborts, or flushes the crypto requests currently waiting in
aes_dd->queue.

When the device structure is freed by devres, wouldn't all queued
asynchronous requests be lost without invoking their completion callbacks,
causing callers waiting on wait_for_completion() to hang indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-dma_prep_c=
onfig-v6-0-06e49b7acb38@nxp.com?part=3D9

