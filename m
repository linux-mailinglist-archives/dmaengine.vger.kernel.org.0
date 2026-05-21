Return-Path: <dmaengine+bounces-10589-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJRvEFFODmrL9gUAu9opvQ
	(envelope-from <dmaengine+bounces-10589-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 02:14:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22859D35F
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 02:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF90313F7C2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832A1367;
	Thu, 21 May 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIuWImD+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE738D;
	Thu, 21 May 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321666; cv=none; b=kuWY2xCToifQ9Vp/d2WjA3Rcne+cFPNWyjpydYEdQLzFDLfR17nrK8c7c2SObi0DZnyVCQUN0eonn4ZRY55zJThFhO9K5K8LpNhsePqZKv86Q1O9SnwCSxc8x7oaNQ0Y8g5ucFc2m0G4fMlGIXaRjth0yu/MCfB8sU/XwqJDsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321666; c=relaxed/simple;
	bh=pwSJSYU9cznATXMgM3xhGDH1nDlH7PgqH8npGdJLWoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VrwfHIs7Zj70/cr6iCKXdi1S7kUuxfSXjXfAIHih8DEqyy3uw4JVe7o66WGWhWxt7Wwp3Re3sc/ljs8nD29SKN2UBLf9H8Ks7CfM0/cJnMvATvbY8UB5pAm/Vur4XXHXucB9b8IyRWseJoUGQ99ZEnlfc/hjAO3DYCq2ZiCvi9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIuWImD+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1891F000E9;
	Thu, 21 May 2026 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321665;
	bh=0mTsg7wDVrJ601hu11hXIoijakWFRj85pr7MRpWzKtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IIuWImD+8zJPbkHaoBy7+tj+aukhpvm4G2ixzNIFQY3yJGH63evu97vo8mRz5Ur18
	 fDvKFUPxr8rYLaGIdRRsO4u6kg2Ka41Ee/zVC7pnNLoONopnUBMoGv6UJzHRUenqGH
	 vVHcs0DSlz7drbzahWnU5l0phkxjwnvsFXI6NtfpdmK+rqXGlTXwRUVb0q8RJpAJ2K
	 Xxo7YVZV/SYpx9lXoYyPT9eEsF8utFJFP27C6XvVHPwnDWiUTeWbNseHfNswBWvtmZ
	 ZDKYptRgbgkOjW2ZdMHihIhi7qM1gAx5+feYLg8YfneXp3cy0Ll71QxW6d06dXvzjx
	 A+C6BxPxeWTIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260520-dma_prep_config-v6-2-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-2-06e49b7acb38@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 00:01:04 +0000
Message-Id: <20260521000104.CC1891F000E9@smtp.kernel.org>
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
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10589-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,lists.linux.dev:replyto];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 9B22859D35F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Stack-allocated scatterlist in dmaengine_prep_config_single_sa=
fe() leads to use-after-free when consumed asynchronously by DMA drivers.
--

commit 7f280444e5ae16961e6f77cb674cd3ac061779a0
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: Add safe API to combine configuration and preparation

This commit introduces two helpers to combine DMA slave configuration and
transfer preparation atomically. Drivers can either provide a new callback
or the helpers will serialize the operations using a per-channel spinlock.

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index defa377d2ef54..6fe46c0c94527 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
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
Can this lead to a use-after-free if the DMA driver consumes the scatterlist
asynchronously?

The scatterlist sg is allocated on the stack here. While some drivers might
process the scatterlist synchronously during the device_prep_slave_sg or
device_prep_config_sg callbacks, others (such as qdma) may save the sgl
pointer internally to process later during tx_submit or hardware enqueue.

By the time the driver accesses the saved sgl pointer, this function will
have returned and the stack frame will be destroyed.

> +}
> +
>  #ifdef CONFIG_RAPIDIO_DMA_ENGINE

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-dma_prep_c=
onfig-v6-0-06e49b7acb38@nxp.com?part=3D2

