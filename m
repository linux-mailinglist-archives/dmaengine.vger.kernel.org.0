Return-Path: <dmaengine+bounces-10614-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA2sAqqqDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10614-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:48:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77159F9E2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C803301AA7D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7A225A38;
	Thu, 21 May 2026 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCWz6xsp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD463438AC
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346086; cv=none; b=nHxXssEMyIArp3dFuNxwuKnBbw6p1iYZdMV5El6Svb77ejNBSKOUuoLONcmEDICDOVMDG8qQLgXCCKFjxVajwuelIuVZf70u8ryZHnV/O/mSvTBXdzocEHYQ9o2MDId+pdpxiQ6/7YjIanPM8jG+SFkmUWht/PnNMHI2BFRo10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346086; c=relaxed/simple;
	bh=zVWJKcQ+m2GwP35KMPuPqBMQQEF2fmGmXWvTLAdBVAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PSOXMUgWYQYkiWtsIdao7/Tl30wEShg77knprGsh1YpOzG27Io4hzfh5pfHZj98dPu0pczXPKBCGho3X/eT4Z2bXRdMIZ4epQSzFR6g0pRYuxclWbjs48cPhbpkrQvWkxKx8rUsrV89m/Ys5KQwQz0ZyVxrE3r7UNixpxIuBKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCWz6xsp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EE01F000E9;
	Thu, 21 May 2026 06:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346085;
	bh=p6nyZZ6fD7RbUKi3W9U18LSz00WlWiqBpUCEXQeGQ20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCWz6xspu8n8UQPKWQVrrVmgzoGmPSQRbnP+JPU5tgMTbY5k9EndkIhGr1kiZjzX2
	 f9/bFJT09SVhfBV0dUHv62zvHxeUsjxCHDh1JAS4GHmeYBjGwayqzSkgKIxOOA+l5X
	 cKDgoDDw8RBDSw0QhZD9MtVjs8cLxkCJMllvlrC5ZUXhq0J7Te0NEyA/NQIgwPQMHo
	 rpMmUrPQ1fnE0jj3OAUcStqoy6wzRZ4rDLFNtIVYlk2z7GiMS2JAcO2YYlnSL+nbO+
	 xgjmj9BDwME42nXq2btp7C63Z7TkjUPGOfxR9MZyco92YebzEKjo67oo79hiZ1PZDs
	 62bmcNNkM9Z9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] dmaengine: Make dma_get_slave_channel() public
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260521063115.2842238-2-den@valinux.co.jp>
References: <20260521063115.2842238-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:48:04 +0000
Message-Id: <20260521064804.D8EE01F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10614-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,valinux.co.jp:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 9D77159F9E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Making dma_get_slave_channel() public violates the dmaengine subsy=
stem design and introduces a Use-After-Free (UAF) risk for consumers.
--

commit bca7617ed6ffe5982c4183ddcd7dd50d600573dc
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: Make dma_get_slave_channel() public

This commit moves dma_get_slave_channel() from the private dmaengine header
to the public include/linux/dmaengine.h. This change is intended to allow
PCI endpoint DMA drivers to reserve an exact channel from outside the
drivers/dma subsystem.

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b3d251c9734e9..59be52e74d5ef 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1527,6 +1527,7 @@ struct dma_chan *dma_request_chan(struct device *de=
v, const char *name);
>  struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
>  struct dma_chan *devm_dma_request_chan(struct device *dev, const char *n=
ame);
> =20
> +struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);

[Severity: High]
Does this expose consumers to a use-after-free risk?

The dmaengine core intentionally keeps this function private to prevent
consumers from directly targeting specific channels with unreferenced
pointers.

If an external consumer obtains an unreferenced struct dma_chan pointer
and passes it here, the underlying DMA controller and its channels could be
concurrently unregistered and freed (e.g., via sysfs unbind) before the
private dma_list_mutex is acquired.

This could lead to a UAF read on chan->client_count inside
dma_get_slave_channel().

To safely reserve an exact channel, shouldn't an API that iterates and
references channels while already holding the core mutex be used instead,
such as passing a custom filter function to dma_request_channel()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D1

