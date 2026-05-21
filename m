Return-Path: <dmaengine+bounces-10691-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL1QLXM4D2rUHwYAu9opvQ
	(envelope-from <dmaengine+bounces-10691-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:53:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B65A9A7E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B16C31BB0D8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AD36AB54;
	Thu, 21 May 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBun0dw+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B4363097
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379117; cv=none; b=rgD7KgBa0wwHtvcChEsSDCmFDuEtSd5PBFweb+wKLwNiY9mX06yWC1unzYFHpqyH9hTOTprgmzw6r9WYYp/zAHh44su5oHUxRTd5GCm8Zu+6ixU6GHAViULMYFgLBA+H5AfIENtLrEAE2/Tb2YlLIjnPoL+D15lU+EiLLzU0qVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379117; c=relaxed/simple;
	bh=Q+pdGepvO4sxq2URs98VJ5lXzq63xrjzMa5zIjjeVpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a4iyg5zuYwLuqZtLNqsiFYZYENGPb+QZjHjuCRSk4rPzXCBQMDADDU/nlJHkJXSEsh494hvLKrUJ7qJJ/RI7udWgSN0HRky7YZDIFNLRvUwnF3gQ4YCK2vqBYnsdxMxQ0NV9nQymcu05J6zn7Z1ftKqCv6yoexRHB9fouj1JsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBun0dw+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DFF1F00A3C;
	Thu, 21 May 2026 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379115;
	bh=xguLcyYNQfxR14nysbCR2kjxy4mGB+wR/DJssc3HWEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBun0dw+RB8aXqolW0eR7WgIT2SRCcogiC30o/tBo1CoScxUfNivuZ8rRTLbLzN8S
	 25dS66RbLZeJi5jsDVs49Sex6wvLNnEfXkg7Bfw/qUzHH6w6oUlJDCsL8sCx/cUrw/
	 KHVa+TCSH1mzFMuNl+a+/Cl6be88419zMI2vlgUIrJK/1VtC7Y7cofb77/7ZVvUDyG
	 gUPH6yuTP0v7AitWhTtm6w+E3IYhwFU3+NcXxzALX69k3+AcQWhd1/y7OHOaOh9qRp
	 R9QVa7b8u1aMMHX/kk82MXhBNB/I+IVDTwg51/qQfUFZvbZ+zmSX4O/WB5+hOySeNt
	 6hd9lyiWd/NZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw-edma: Initialize IRQ data before
 requesting IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260521142153.2957432-4-den@valinux.co.jp>
References: <20260521142153.2957432-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:58:34 +0000
Message-Id: <20260521155834.D8DFF1F00A3C@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10691-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,valinux.co.jp:email,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: AA2B65A9A7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition exists where shared interrupt handlers can access=
 uninitialized channel structures (like spinlocks and list heads), leading =
to a kernel crash. The patch fixes one early-IRQ NULL dereference but leave=
s this secondary crash exposed.
--

commit f0655e3acfc0eee2ccdf6dbee38ba6bad6f04ae5
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Initialize IRQ data before requesting IRQs

This commit fixes a NULL pointer dereference caused by passing an
uninitialized pointer to request_irq(). It resolves the issue by setting
the back pointer for each IRQ before the handler is installed.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..d221e3efcb36b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -929,7 +929,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, =
u32 wr_alloc, u32 rd_alloc)
>  		else
>  			irq->rd_mask |=3D BIT(chan->id);
> =20
> -		irq->dw =3D dw;

[Severity: High]
This isn't a bug introduced by this patch, but does this sequence still lea=
ve
a race condition?

Since dw_edma_irq_request() already registered the shared IRQs before
dw_edma_channel_setup() is called, setting irq->wr_mask or irq->rd_mask
makes the channel visible to the interrupt handler.

If a shared interrupt fires immediately after the mask is updated but
before vchan_init() is called later in this loop:

		if (chan->dir =3D=3D EDMA_DIR_WRITE)
			irq->wr_mask |=3D BIT(chan->id);
		...
		vchan_init(&chan->vc, dma);

Could the handler process the channel and call dw_edma_done_interrupt()
or dw_edma_abort_interrupt()?

If so, these functions would attempt to lock the uninitialized
chan->vc.lock and call vchan_next_desc() on the zeroed desc_issued list
head, which may lead to a crash.

>  		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
> =20
>  		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=3D0x%.8x%.8x, data=3D0x%.8x=
\n",
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142153.2957=
432-1-den@valinux.co.jp?part=3D3

