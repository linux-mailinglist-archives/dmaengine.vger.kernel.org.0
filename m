Return-Path: <dmaengine+bounces-12089-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AYjuI7G4TWrz9QEAu9opvQ
	(envelope-from <dmaengine+bounces-12089-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 04:40:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32772138C
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 04:40:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YqdEnR5u;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12089-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12089-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D6D1300DEC4
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A643B42E2;
	Wed,  8 Jul 2026 02:40:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61078376BC2
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 02:40:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478447; cv=none; b=ZPiOSPb7+gVIOGy5zxyMnfvtEs+ykkLO481yvvknFVZHOTXCtS8tlg8ro+9axdwApsshkQaBkdhS9NX0JM9tYVbJsYDxbYPHprX0yYK5OI9kLStY/7CUnxGdEoYRUHV43IJZQ6U7NwdS0XTfH69VX7FoZseoWquKBeqpSnzFWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478447; c=relaxed/simple;
	bh=yEjeclicVMLZmnnSFc5qeJgl3FwcTC2FEf9Pn3BMlyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FVMoQMK5IdMot6YCDsAgTp36GeZjNhEUimek6+RSoWpD7qx27crmzG/gQlC1Od9MtY07joQaFXBMIYiaz42WubAugWNo691yQIcEoRSEVOpHy2aFMA+Cdmp5o1rk/ywhvNITAJ7/KqMndPPq7mLgXZKNtgMANhbXpgAAWNUREQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqdEnR5u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01AA1F000E9;
	Wed,  8 Jul 2026 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478446;
	bh=/HgBN/pEr/YIPgVXDWVVmy4GC0wPs/BWiRdntxdt6mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqdEnR5ulxG3hPD+hqfWOeH3gVPgb6RZWwhD8kwDHt78tcthNGxPiJWyAn1ivq5s6
	 ii/hUH3AdnPM2G2p1um1K0IywypGsdLoS2m6BE3t61s35EXoqW1zUpWsssd7lM4any
	 ljYmtQDzb4gqvCx8hWtImKuzWzJYlUcJBKfMF7rGbw37PG5w6yumh8r/PtgyFDZpEG
	 EVydIfq+NzVXJvf36OR1Yq9maDkjEQRHoAbfWh8HF7k8NCbFSdmpq2xhgBH+m5arUC
	 du4j4n85J9frfibWCkk+18WOyFmytPgeaM17qc2TO81izb5jqXs+HP8HWI+cnGai1u
	 o00AJuVHxWVNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dma: at_hdmac: Fix use-after-free by proper tasklet
  cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260708023035.27194-1-zenghongling@kylinos.cn>
References: <20260708023035.27194-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:40:45 +0000
Message-Id: <20260708024045.F01AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12089-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,kylinos.cn:email,sashiko.dev:url,channels.next:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B32772138C

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mismatch between commit message and implementation regarding lis=
t_empty() check
--

--- Patch [1]: [PATCH v3] dma: at_hdmac: Fix use-after-free by proper taskl=
et  cleanup ---
commit e5bf642ad51db020b1e407d27b314f3478d2609a
Author: Hongling Zeng <zenghongling@kylinos.cn>

dma: at_hdmac: Fix use-after-free by proper tasklet cleanup

This commit addresses a use-after-free vulnerability in the cleanup and pro=
be
error paths of the at_hdmac driver. It ensures free_irq() is called before
killing tasklets and freeing other resources, properly synchronizing with
running IRQ handlers.

Closes: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel=
.org/

> Change in v3:
[ ... ]
> - Replace incorrect channels.next !=3D NULL check (always true after
>   INIT_LIST_HEAD) with proper list_empty() check
[ ... ]
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e5b30a57c477a..044a0fb38b7a9 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
[ ... ]
> @@ -1940,6 +1940,20 @@ static void at_dma_off(struct at_dma *atdma)
>  		cpu_relax();
>  }
> =20
> +static void at_dma_cleanup_channels(struct at_dma *atdma)
> +{
> +	struct dma_chan *chan, *_chan;
> +	int i =3D 0;
> +
> +	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
> +			device_node) {

[Severity: Medium]
This isn't a bug, but the v3 changelog explicitly mentions replacing an
incorrect channels.next check with a proper list_empty() check. Does this
function actually implement that check?

While list_for_each_entry_safe() inherently handles empty lists correctly,
making an explicit check functionally unnecessary, there appears to be a
direct contradiction between the stated changes and the final code.

Should the commit message be updated to reflect that the check was simply
removed entirely, or was the list_empty() check accidentally omitted here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708023035.2719=
4-1-zenghongling@kylinos.cn?part=3D1

