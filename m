Return-Path: <dmaengine+bounces-10709-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKxeB8NJD2ptIgYAu9opvQ
	(envelope-from <dmaengine+bounces-10709-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 20:06:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B750E5AAC3E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 20:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C52F313F4A4
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036D3F20F9;
	Thu, 21 May 2026 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfSyHBKf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03343383999;
	Thu, 21 May 2026 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386214; cv=none; b=CH1+SKkSbrNeuhTBYfJSwgcRyJL2y6ibRF6vxIVmziu0TEUJEXDoVhzhmaER7apaK9STL/T4ARWaEl+MrQshpePXL5OiX2YYBwBxX8XwLy+xuX4LszrfnywUIp87UepPIa5vIn0Tr0Y63oxx3KPelnhnJjbNVVn8VJU/p4rs8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386214; c=relaxed/simple;
	bh=XRoTVbnIyqP475fih3SVHdWXf6t892ryq6slZqiiCCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJ5RazSuUsd2XEnou8bv7tY7AFQb2Qe8fZlx8kRvoxoc4v1mO29k+F0vcmlBU1rBZwFPuRjS58ThonQT+7WVQEw/YEN11AjRsP0L1wEdEemAoGiwfC3pTBApamG5y/+FhXFS+jkzQANElKwASJ3bG1VLfZLztDIFuufOexQq6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfSyHBKf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6D21F000E9;
	Thu, 21 May 2026 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779386212;
	bh=eB/j6ATIwgsH3uci5eOfboJ2Yx8Cpf2o0kuamFrN578=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VfSyHBKfeeCbnabMfK5hR7EUDsv3qgqQvFJnrkmoWIZlat1TJMl8h9PLapHzxJpGL
	 N0epgHsFlt0i0xgTpo6UqthhlYbeu/UZ5vsV446/wEE91FMSdlyztNSzkTzJQMKdrx
	 a52f5qK8IDkkkba3aMFVDe6S9e6RL8m6Jf3+asbH8p/0TqieQcAKfyiSsZSd1VjDVH
	 hJBiYIH0LbngHJ8ca/t9sjQSumb3N8d2JtujibLAm0FfYX5RHe75aQ2DisAmKYocCr
	 kMRYqpyMdWV2nOw6cdnLilerTZFfLKva7mC5J4lgwOlJvYoUqIYr7Noidku6eYF9wT
	 CxKZCn17xuFzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521-dma_prep_config-v7-4-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-4-1f73f4899883@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 17:56:51 +0000
Message-Id: <20260521175652.5A6D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10709-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,nxp.com:email];
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
X-Rspamd-Queue-Id: B750E5AAC3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `dw_edma_device_prep_config_sg` callback modifies channel conf=
iguration locklessly, breaking the atomicity guarantee expected by the DMA =
engine framework.
--

commit be13dc9c4b2aec5db6e6e0dc4003902282d50c88
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use new .device_prep_config_sg() callback

This commit implements the new device_prep_config_sg() callback for the
dw-edma driver. It aims to combine configuration and descriptor preparation
into a single step.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..92572dd8131e6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er)
>  }
> =20
>  static struct dma_async_tx_descriptor *
> -dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist =
*sgl,
> -			     unsigned int len,
> -			     enum dma_transfer_direction direction,
> -			     unsigned long flags, void *context)
> +dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist=
 *sgl,
> +			      unsigned int len,
> +			      enum dma_transfer_direction direction,
> +			      unsigned long flags,
> +			      struct dma_slave_config *config)
>  {
>  	struct dw_edma_transfer xfer;
> =20
> @@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, =
struct scatterlist *sgl,
>  	xfer.flags =3D flags;
>  	xfer.type =3D EDMA_XFER_SCATTER_GATHER;
> =20
> +	if (config && dw_edma_device_config(dchan, config))
> +		return NULL;

[Severity: High]
Does this lockless configuration introduce a race condition?

The dmaengine_prep_config_sg_safe API is documented to be re-entrant and
skips acquiring the per-channel spinlock if the driver implements the
device_prep_config_sg callback, relying entirely on the driver to ensure
atomic configuration and descriptor preparation.

However, dw_edma_device_prep_config_sg() directly calls
dw_edma_device_config(), which mutates shared channel state (such as
chan->config, chan->non_ll, and chan->configured) without taking any
internal locks.

If multiple threads concurrently prepare transfers on the same channel,
these updates will race. This could lead to corrupted channel states where
dw_edma_device_transfer() may read interleaved or invalid parameters, such
as an incorrect non_ll flag.

Note that even if a subsequent patch in the series partially mitigates this
by passing the config object to resolve source and destination address race=
s,
it still calls dw_edma_device_config() which locklessly modifies chan->non_=
ll
and chan->config, leaving the underlying race on the shared channel state
unresolved.

> +
>  	return dw_edma_device_transfer(&xfer);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-dma_prep_c=
onfig-v7-0-1f73f4899883@nxp.com?part=3D4

