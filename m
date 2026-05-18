Return-Path: <dmaengine+bounces-10504-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOPPFunPCmru8QQAu9opvQ
	(envelope-from <dmaengine+bounces-10504-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 10:38:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F64568F59
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE1DD3024735
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A83E3165;
	Mon, 18 May 2026 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmzijAMv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547133E3152
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092961; cv=none; b=k/VJQhko7Z4pyNJpy1XgKw4gtPxXPf7vsZI9YWEeSo+Ch66H+uH76AY0pggPjsKyieNo3E22i9/ORa5zo/PqQpfOpbsA47F+YgCHhVCVqJNg86unnWOKvuCZXt3gVLjCiuFckz6gN1tFQgYUtfPpgWcDnGf5fIZvTxjwy5seP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092961; c=relaxed/simple;
	bh=CpuDIxYd1+369FpJgQg4IuYg3AFqk+zlKXYLpZkEZvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R5Xk+Yr6eigBE7YflYigZmQR9inCcZbbYlwJseKvozj0Cdk7rTnBwW7z0kqCaVOZST57sOIUPDhl0QV7R4M3awYuoeBIP7OnOr3g97lZhJQ1tYvBMqVXiLrjszKChGjihPkDJJTZounK8pQ6hfgxr0n8GOTrzOaLTBQJSvN5TYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmzijAMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BB1C2BCB7;
	Mon, 18 May 2026 08:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092960;
	bh=CpuDIxYd1+369FpJgQg4IuYg3AFqk+zlKXYLpZkEZvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HmzijAMviG2fDrmpiGnp53N2b/Fq3vWglHM2kTX3nXsGO7MucvxWOlr+yoWugUY7D
	 oki1QMfTurriN+f2+VHuW0mn0u4gvMjvhcjoeZUYAqurn72lvuLtb8vPWp+8S/i6sk
	 UXwyj5GMq0jblL9Xr3v+F5sJz8KWP+TMOfk3B+wOWiCNfOKrRIkzAhjal3QBmtr5ra
	 zOWehCNw1gypm+wNSadW8WB3I4PIhukRSRY2Nw21QS26euYc6xq8s9gJFkQ2VNnQjO
	 g2Bu9nv0oLg5j6EuabXSQvHqUdTkPCa7pOPS+tOcVq1ik9I9qvt+8cwG44mGEu/7gj
	 meuOytX1zfHsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: Fix device kref underflow in dma_chan_put()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com>
References: <20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 08:29:20 +0000
Message-Id: <20260518082920.B9BB1C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E7F64568F59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10504-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Pre-existing Use-After-Free vulnerabilities in dma_chan_put() and =
dma_release_channel() due to device memory release before teardown complete=
s.
--

commit dcce1cbcc027c7a50b03bed56fe875a7390be677
Author: Shivank Garg <shivankg@amd.com>

dmaengine: Fix device kref underflow in dma_chan_put()

This commit addresses a device kref underflow by ensuring the device refere=
nce
is only dropped when the client count reaches zero, matching the slow-path =
get.

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -515,7 +515,9 @@ static void dma_chan_put(struct dma_chan *chan)
>  		chan->route_data =3D NULL;
>  	}
> =20
> -	dma_device_put(chan->device);
> +	/* This channel is not in use anymore, drop the device ref */
> +	if (!chan->client_count)
> +		dma_device_put(chan->device);
>  	module_put(dma_chan_to_owner(chan));
>  }

This isn't a bug introduced by this patch, but does this sequence present
a use-after-free risk?

If dma_device_put() drops the final reference to the device (for example,
if the provider module previously unregistered the DMA device), it can
trigger the device release callback and free the dma_device and dma_chan
memory.

If that happens, module_put(dma_chan_to_owner(chan)) will dereference the
freed memory, as dma_chan_to_owner() accesses chan->device->owner.

Additionally, when dma_chan_put() is called from dma_release_channel(),
returning from this function leads to further accesses of the freed memory.
dma_release_channel() continues to access chan->device->privatecnt,
chan->device->cap_mask, chan->slave, and chan->name, which could cause a
series of use-after-free issues during teardown or hot-unplug.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-dmaengine-=
kref-fix-v1-1-4d6125048fb7@amd.com?part=3D1

