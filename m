Return-Path: <dmaengine+bounces-10829-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIG2OZLxE2qmHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10829-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:52:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DAA5C6C42
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70C8430120CB
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDAD3AB287;
	Mon, 25 May 2026 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsgh1mfA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8F3AB26A
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691916; cv=none; b=ktUTwzTbJsjXQ1b6c3RFwF1Hte5yqmspJKY/TEPxmW5au6V/KR8QwODmVwjRkzJUgQcFfzghlTTvMDOFPR8jBqY76cTn48yRGCTNTT1QRISn42YGMpmln2mAwD2RvPedaw9h4wL9SZu5pF5y0FQfb7REEH3aE0Wtmh6jNLsCd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691916; c=relaxed/simple;
	bh=i7cva4rdF4meAyiMsJQZwYwHEjbnxqEMpGjp2Eufjz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m2YPv6VBevnCd2LdaxmAabVleH6zs8HOaGsZ0wgNIbOWMUrsI6BKXbDFrGaTKZcY9TUWglKwOiaMBh7KlhMuWcpvIlX3girAmO1kEMkk/FtdcnNF8UnY0eGci29xoxxwBRkvrbQOdb+WbopC9Peye+G1e59gbQ56qSFVrb66zXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsgh1mfA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C961F000E9;
	Mon, 25 May 2026 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691905;
	bh=8YGRKZVCA9OohXeOVAgoRvWzbSggwjx1gqHuVE8KExY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bsgh1mfAI9sjrH8zT5+PaIhOc1gliimOheSUg76WD/cIaF0vTBLGC5WCw0MvoZTPt
	 fPrgEGR1a3jJmjMO/hCqNQ6h8g+/yeOjN4xlzOMYf1VAyDlkI6BgD/CvoVDdgZ/wm0
	 xOq/vP26BhgDPG1kisdtEyk5bNlq4uO0woOl+WRd8wA/+lLh9J6Xlry9CeQnWnbeBE
	 3RxejVbyfsXlZgskDCWtb9b5Km8MfVQVaRMQ3u7Ojnz31zRTBUeYAg/D+HjB3FUPk/
	 fBT7A1izD1S7ay5CwtCI6GEyGS7QqlRG1/+bxtmcS17Ek3WjZnOeMDnrHV6wI0cWTG
	 jqKrYewR2MrQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] dmaengine: dw-edma: Add hardware channel
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260525062420.3315904-2-den@valinux.co.jp>
References: <20260525062420.3315904-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:51:44 +0000
Message-Id: <20260525065145.39C961F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10829-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 62DAA5C6C42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent `list_del()` in `dw_edma_remove()` and list traversal i=
n `dma_request_channel()` without shared locks leads to use-after-free and =
list corruption.
--

commit c5cb897fb30f696459af91c0244d4a68a7560690
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add hardware channel filter

This patch adds a filter function for dma_request_channel() to match a
DesignWare eDMA write/read channel by hardware channel number. This enables
PCI endpoint resource enumeration to supply hardware channel metadata and
lets consumers claim it through the normal DMAengine request path.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..80b4a168225b5 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1189,6 +1189,21 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);

[Severity: High]
This is a pre-existing issue, but does dw_edma_remove() have a concurrency
issue with dma_request_channel() right before this export?

dw_edma_remove() calls dma_async_device_unregister(), which sets the
DMA_PRIVATE capability and drops its reference. However, if a client still
holds a channel, the device reference count remains greater than 0. This
means dma_device_release() is not invoked and the device stays in the
global dma_device_list.

The removal code then iterates over the channels and calls list_del()
on the device_node without holding the dmaengine's private dma_list_mutex:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_remove() {
    ...
    dma_async_device_unregister(&dw->dma);
    list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
                             vc.chan.device_node) {
        tasklet_kill(&chan->vc.task);
        list_del(&chan->vc.chan.device_node);
    }
    ...
}

If dma_request_channel() is called concurrently, it takes dma_list_mutex,
iterates over dma_device_list, and calls private_candidate(). Even though
DMA_PRIVATE is set, private_candidate() still traverses the device channels
list:

drivers/dma/dmaengine.c:private_candidate() {
    ...
    list_for_each_entry(chan, &dev->channels, device_node) {
        ...
    }
    ...
}

Can this result in a concurrent, lockless list_del() and traversal, leading
the traversing thread to dereference poisoned list pointers and crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D1

