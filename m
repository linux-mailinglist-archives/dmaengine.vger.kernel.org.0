Return-Path: <dmaengine+bounces-10451-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHa9FFgPBWrvRwIAu9opvQ
	(envelope-from <dmaengine+bounces-10451-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:55:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5F53C27A
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD80D3016CA3
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744238D400;
	Wed, 13 May 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvUydXaJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FD184;
	Wed, 13 May 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716501; cv=none; b=DZ2Mt+oRivcK8VLQs/3VK0LvGS/NF2D+hUhSecKah6PPp8Y4FpXNQsYgpAN6K6aqEbQP+JCTQ25cx6Cwm3ZC6LG5ROs5I/1Z0G0Uji4ear8oNsfAIxjP27NEU8trlT7vBmUQ9eXH4DM+FTNndSKPIKwklvW2g9yoDlbmSbAqDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716501; c=relaxed/simple;
	bh=evQHOw2dQf4OuTeUzalmIlHr3ylZFYPAqqfBiZOG6MA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CvIvwMSfN+L4y+ZSNYzLRj0WWyGlBPziEls19QgTg66PPxZ9FdxfLdLGMETWkqox27i6GAM5N6x8wDb5Iu7wCHeC+hdaqUse+kfdlJM7rvkSRsg6a3KDEsLjLalsvTe4zgUIt0oMYnJqBGGuro0h2m3ciRFU6HEqNYsqC5NTcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvUydXaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738CDC19425;
	Wed, 13 May 2026 23:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716500;
	bh=evQHOw2dQf4OuTeUzalmIlHr3ylZFYPAqqfBiZOG6MA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nvUydXaJ9/IJsDq4V7IXClUJ2cJucEO9+F1qS+f71vjiQkKo6FfKC8IfvXSlJvTL5
	 vzm367jR3TXI2BpqI3AE9xvAZiKw4zW2fFF+mS+S4yGPL4+3LoKZVCAqHfd17O892S
	 CQMOI1zRxQ4ffza8xln2KEU+6JnPldowU7BVUK9O3CJTE5dyr7hhu4qB71KCa+tuAB
	 UAZ89LWM4lv0AvTdNJX+0eyfOuBFnbBhxkAWgcHGDZIPAwyzsIREIvURpsBBCMjDsA
	 Cr8jzxOPk7dqz9VKNGHG5ukGxR5XyJoPx6l1whMuKYK1f+VVbNKkO6e3+Wn+AngNK2
	 /XgcWQ68g4Olw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260512-dma_prep_config-v5-2-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-2-26865bf7d935@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:54:59 +0000
Message-Id: <20260513235500.738CDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A2D5F53C27A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10451-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Same-CPU deadlock due to `spin_lock()` usage in `dmaengine_prep_co=
nfig_sg_safe()` without disabling interrupts or bottom halves.
- [Medium] Meaningful documentation and implementation mismatch regarding t=
he synchronization primitive.
--

commit ed90e3a56790f8af46ffd2c002993a841a7927be
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: Add safe API to combine configuration and preparation

This commit introduces dmaengine_prep_config_sg_safe() and
dmaengine_prep_config_single_safe() to provide a reentrant-safe way to
combine slave configuration and transfer preparation. It uses a new device
callback or falls back to a per-channel lock.

> Drivers may implement the new device_prep_config_sg() callback to perform
> both steps atomically. If the callback is not provided, the helpers fall
> back to calling dmaengine_slave_config() followed by
> dmaengine_prep_slave_sg() under per-channel mutex protection.

This isn't a bug, but the commit message mentions mutex protection while
the code implements a spinlock. Could the commit message be updated to
reflect the actual synchronization primitive used?

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index defa377d2ef54..83e8547de89bf 100644
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
> +
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_lock(&chan->lock);

Can this cause a same-CPU deadlock?

The documentation in struct dma_chan notes that *_prep() may be called
from a completion callback. Since completion callbacks often execute in
softirq or hardirq contexts, if a thread calls this function from
process context, local interrupts remain enabled.

If a DMA interrupt fires on the same CPU while the lock is held, the
completion callback could attempt to call this function again to queue
the next transfer, leading it to wait on the already-held chan->lock.

Does this fallback path need to use spin_lock_irqsave() and
spin_unlock_irqrestore() to safely disable interrupts?

> +
> +	tx =3D dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_unlock(&chan->lock);
> +
> +	return tx;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-dma_prep_c=
onfig-v5-0-26865bf7d935@nxp.com?part=3D2

