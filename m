Return-Path: <dmaengine+bounces-10706-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHM3HKZCD2r/IQYAu9opvQ
	(envelope-from <dmaengine+bounces-10706-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:36:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFAE5AA5E0
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1B2232CCFE3
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D903C7693;
	Thu, 21 May 2026 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QafJvOeo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110B3D4117;
	Thu, 21 May 2026 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383438; cv=none; b=gS1iHqrmMnU7SqiBpgNKatnVH6Bwk31Na2TasPiAb1/68EWlzw9lGeLOEPOv3GXL/QxzOF+rydvXg5Z/H/11zxDa35bQNRGlFYNb3NRUShMWlp3XLQXN25uD5+D/kmEQIE0BDKuN0aov0aFlWdhJCDfbmVTSrzD7iftx3YrhLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383438; c=relaxed/simple;
	bh=/1isw1mdHz0vRKCjclQDSOCqBuwwwsdEYrhFx6Vreto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqUVsy0mI7kjQ4NB059h0WLiATDuha5NP5pjt5uITR8L2wtSHXvWcIjTSmp/LSfXNTsNy45u7S3WTO+Cjz2wecq/0qRGYjBVnAG09fiG+roK/LbIY6q+QsdouNGTzX5V5y3BtWCzDG28U2Bdnkfnk7z7/cJxhCleppqCqZ1mTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QafJvOeo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82EA1F000E9;
	Thu, 21 May 2026 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779383435;
	bh=jU/mcdx/nesOs1zaSjw0doWiuiW9lsPo6zsHtxkxd0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QafJvOeoKQjm/UtKCIu1vCxryRKtlSs1U3xlV5OH8ltO7j6q07Dudb/HGjFj6BSBq
	 fo8WWnYw4T91SH1BCVkCqLAV4qprEWSkb6AqJmqEeFl4KAD0IKs+lx0qmC1wzRtfbe
	 vl84OZgGKZ9pe5Qy5Rh0gNkc5eWY5CKP9AyTLXG9BU2+jBjUzRTke2LHoLJAjrbfIg
	 jismNZuRQMrbts0ymELIu9yiXlPBtisjnR452dMDMq3dcotIGzv2soH6lBKTuIlgJU
	 5MukWBoJ9cDWxatU61OKVeHzRHs2yUhiJU7ZbY0XhYjPBklP5B6eSm8G6We9cB4RLa
	 C7BGPorroxUMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260521-dma_prep_config-v7-2-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-2-1f73f4899883@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 17:10:35 +0000
Message-Id: <20260521171035.A82EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10706-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: DAFAE5AA5E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Calling `device_config` or `device_prep_slave_sg` while holding a =
spinlock with interrupts disabled (`spin_lock_irqsave`) will cause lockups =
and `WARN_ON_ONCE` in drivers that use bottom-half locks.
- [Medium] `spinlock_flags` may be used uninitialized and the lock may beco=
me unbalanced due to re-evaluation of `chan->device->device_prep_config_sg`=
 across an opaque function call.

Pre-existing issues:
- [Critical] The function `dmaengine_prep_config_single_safe` passes a stac=
k-allocated `scatterlist` to the DMA engine driver, which causes a stack us=
e-after-free if the driver defers processing the scatterlist.
--

commit d2363736f5c7b002b0f30c81cef1791d2f12abd2
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: Add safe API to combine configuration and preparation

Introduce new safe APIs to atomically combine slave configuration and trans=
fer
preparation. The new functions fall back to calling slave_config and
prep_slave_sg under a channel spinlock if the device doesn't support the
atomic callback.

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index defa377d2ef54..6fe46c0c94527 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h

[ ... ]

> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist =
*sgl,
> +			      unsigned int sg_len,
> +			      enum dma_transfer_direction dir,
> +			      unsigned long flags,
> +			      struct dma_slave_config *config)
> +{
> +	struct dma_async_tx_descriptor *tx;
> +	unsigned long spinlock_flags;
> +
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_lock_irqsave(&chan->lock, spinlock_flags);
> +
> +	tx =3D dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);

[Severity: High]
Will this cause lockups or warnings in drivers that use bottom-half locks?

Since spin_lock_irqsave() disables hard interrupts, calling into
dmaengine_prep_config_sg() invokes the underlying DMA driver's
device_prep_slave_sg() or device_config() callbacks. Some drivers use
bottom-half locks in these implementations:

dmaengine_prep_config_sg_safe()
  spin_lock_irqsave()
    dmaengine_prep_config_sg()
      chan->device->device_prep_slave_sg()
        td_prep_slave_sg()
          td_desc_get()
            spin_lock_bh()

When the driver eventually calls spin_unlock_bh(), it invokes
local_bh_enable(), which triggers a WARN_ON_ONCE(irqs_disabled()) because
hard interrupts were disabled by the outer spin_lock_irqsave().

> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_unlock_irqrestore(&chan->lock, spinlock_flags);

[Severity: Medium]
Could this lead to an uninitialized variable usage or an unbalanced lock?

The condition checking chan->device->device_prep_config_sg is evaluated
twice, before and after calling dmaengine_prep_config_sg(). Because that
function invokes opaque function pointers passing chan, the compiler must
assume memory reachable through chan might be modified.

This forces the compiler to consider a control flow path where the condition
is initially false (skipping spin_lock_irqsave and leaving spinlock_flags
uninitialized) but evaluates to true after the opaque call, leading to
spin_unlock_irqrestore() with uninitialized flags and an unbalanced lock.

Even if this doesn't happen dynamically, it can emit a -Wmaybe-uninitialized
warning that breaks builds with -Werror. Caching the condition in a local
boolean variable would prevent this.

> +
> +	return tx;
> +}
> +
> +/**
> + * dmaengine_prep_config_single_safe - prepare a single-buffer DMA trans=
fer
> + *                                     with atomic slave configuration u=
pdate

[ ... ]

> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
> +				  size_t len, enum dma_transfer_direction dir,
> +				  unsigned long flags,
> +				  struct dma_slave_config *config)
> +{
> +	struct scatterlist sg;
> +
> +	sg_init_table(&sg, 1);
> +	sg_dma_address(&sg) =3D buf;
> +	sg_dma_len(&sg) =3D len;
> +
> +	return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir, flags, config);

[Severity: Critical]
This is a pre-existing issue, but does passing a stack-allocated scatterlist
to the driver cause a stack use-after-free if the driver defers processing?

The scatterlist sg is allocated on the stack and passed down to the
underlying DMA engine's device_prep_slave_sg() callback. While some drivers
consume the scatterlist synchronously, others save the pointer to process
it asynchronously later:

uniphier_mdmac_prep_slave_sg()
  md->sgl =3D sgl;

uniphier_mdmac_handle()
  dereferences md->sgl

Because dmaengine_prep_config_single_safe() returns immediately, the stack
frame is destroyed. When the DMA driver later accesses the saved pointer
from an IRQ context, it accesses freed stack memory.

This pattern already exists in dmaengine_prep_slave_single(), but
replicating it here propagates the regression to the new API.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-dma_prep_c=
onfig-v7-0-1f73f4899883@nxp.com?part=3D2

