Return-Path: <dmaengine+bounces-10401-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJAyASDgA2qA/gEAu9opvQ
	(envelope-from <dmaengine+bounces-10401-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 04:21:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794752C3C1
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD9B03019192
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 02:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E611A23A6;
	Wed, 13 May 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iva7/ziM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A2146588;
	Wed, 13 May 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638809; cv=none; b=LtrNiQdWJZ8bw1MNtaweUxcI7nPMd5/+u77X80ALX+eqz0S7IxZZRbQnKKoQNHI4ruate4TynwB7VKyxWd4XbPvViiV9mWaSI6S/xaE+brKcrDzunEXocooaSzk5NFJP4QZTSQasfKy0SxDk49E9NhzLqaK9BEOuO0vDxK3/txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638809; c=relaxed/simple;
	bh=oJRZD2R5Q+su3BrG4e0aUYgo/7agh7h1UKz1nZVPIlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFkWZ1Z8Tmry8NoaCIEbTuNgytD/vFY9HZ8HhrYQIZyRy6PXQiLYLm27yj6wNqN/PSwTqWuj9PvzFSnpVhoxEdD6Ji9LTOSEmcp72dB349e16b7XTbToez1JeBrTCufSY+/lrcK1cwREg2O5S0SnRN3sqv9x3MpmYTAVLduSitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iva7/ziM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A3EC2BCB0;
	Wed, 13 May 2026 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778638809;
	bh=oJRZD2R5Q+su3BrG4e0aUYgo/7agh7h1UKz1nZVPIlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Iva7/ziMgAXeMbKBLcsQ+cm3RpTlbBMityb0f2XUTvF1hGwzBoCHtCdE3d5CqzPnM
	 kMXzny5a1Oi0MXRYTmE7oHUQMiKGC6lP1V3qvZO/23sycWz2OIkxgB8PQIc/2AtMUL
	 K9HkfPFLiveCAmQ0hB+oYCWWwrSkJ5JpILz7ogBZYc1E+V9bCIozfFRPK+5eIbENhM
	 HPDET+qwlExvA2MHC633K1ld+Ha7g1c7hSPQlTOWdDij/dBnIU5OeiizDgM4DZxiI6
	 EWXELo9xXwAYzDG5WOaeNqp+u3DNr/QGHfWSfAcXL7xvlHmpEJEnnL8D6NoemHut6g
	 zmnjJFzIgw0/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/23] dmaengine: sdxi: Allocate administrative
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-7-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-7-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:20:08 +0000
Message-Id: <20260513022009.22A3EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 5794752C3C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url,amd.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10401-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect error check for `dma_pool_zalloc()` allocation using the=
 DMA handle instead of the virtual address.
--

commit 67ceee55512586a3fbe30b9f642ed7c90819e736
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Allocate administrative context

This commit creates the control structure hierarchy in memory for the
per-function administrative context. It uses devres to queue the cleanup
since the admin context is a device-scope resource.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> new file mode 100644
> index 0000000000000..27821cfaf0311
> --- /dev/null
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> +/* Allocate a context and its control structure hierarchy in memory. */
> +static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
> +{

[ ... ]

> +	cxt->cxt_ctl =3D dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
> +				       &cxt->cxt_ctl_dma);
> +	if (!cxt->cxt_ctl_dma)
> +		return NULL;

Could this incorrectly treat a valid allocation as a failure?

A DMA handle of 0 is a valid DMA address on many hardware platforms and
IOMMU configurations. If dma_pool_zalloc() succeeds and returns a DMA
address of 0, checking the DMA handle might falsely trigger this error
path and return NULL.

Should this check the returned virtual address (!cxt->cxt_ctl) instead,
similar to how the subsequent cxt_sts and write_index allocations are
validated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D7

