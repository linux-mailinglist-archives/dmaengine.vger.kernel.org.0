Return-Path: <dmaengine+bounces-11559-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4HyCN1ZxMWq4jQUAu9opvQ
	(envelope-from <dmaengine+bounces-11559-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:52:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4CB691762
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RvQNpqoE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11559-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11559-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D50530071FD
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7244BCB8;
	Tue, 16 Jun 2026 15:52:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019BF44CF2C
	for <dmaengine@vger.kernel.org>; Tue, 16 Jun 2026 15:52:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625125; cv=none; b=DZwRPiQeQ9uaf/m9PbQG0qJk4wb98ljhLNzbTbnZbj9VJNmLcFXXYpy9DZyhOAOkUoeEtTfmw7MjiEJU2ZdxgQ/88j9hhQz1V3qawAvsAhbtO/QVCau8n/O79TtiVw22cb6FGWdi0cnEJOtJngURAkoyXMaPpqpep1mxghT/0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625125; c=relaxed/simple;
	bh=eV2Fs0lqY6x+CXy0HCMMWZchlnRwSCqcmNY/46dNdXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Baf9FgBDliilEXyPJiSB+Wcb5eu1ht0rdyZBDkcd8V+w+nbf4KACg/R9XCuMqoKtQpueSuVdgAb9Z0aB0wftKOLGBKlhORLAPiH785iXu4PS7mD6xIj7QOSqP7PeRPk2A82aubaWVbrzwd+lv1lN71jBMd/RUvq8NIL/XTijpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvQNpqoE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916701F000E9;
	Tue, 16 Jun 2026 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625123;
	bh=IpPuckz9W2t/xQ1TRfH+xInEbmCiF9srSALRZ9x2y1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvQNpqoEpoUStsdEXaZhoE5YfBQYRRlQWHIQ0AfGJoPaIhY3j9AL/IcIpJ0YLtl2U
	 rksXgI+xuNAet5jKvXqKO8ns1CcmuoKlwF+5nviJGV2XxCJ57iZRuaRHumppjr7ER4
	 LxH14XM6z68a1HSbnXL7cbGn10sXlDBJuSjDpSvNV0Ezxh1VdHT4zGLbWcApvB/3my
	 ///L4eOTKukv1wSKO1gB8jPf6Yci6Ng361lyaxk0YzVCoeNeeCWYPrI5K8yqMWrHks
	 GhUwEUSjnFaHiKzzg2KLNSQJmiLp6umLdiktE1HH/iphlfNOLnbBVSEos90MEZz9vO
	 v/fOf3CNS7CJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TnVubyBTw6EgdmlhIEI0IFJlbGF5?= <devnull+nuno.sa.analog.com@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
References: <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:52:03 +0000
Message-Id: <20260616155203.916701F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11559-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nuno.sa.analog.com@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nuno.sa.analog.com];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E4CB691762

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Undefined behavior in core DMA alignment evaluation due to `dma_de=
v->copy_align` being assigned a linear byte count instead of a log2 `enum d=
maengine_alignment` value.
--

commit 2d09a8a33c5c8dffff764bd74b8c4ad0ea6d4224
Author: Nuno S=C3=A1 <nuno.sa@analog.com>

dmaengine: dma-axi-dmac: Switch to bitmap-based address width masks

This commit advertises the source and destination bus widths through the new
address mask helpers instead of open-coding the legacy mask. It moves the
driver onto a representation that can express widths of 32 bytes and above.

> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index d47ff27e1408f..19c258d511ca3 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
[ ... ]
> @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *=
pdev)
>  	dma_dev->device_terminate_all =3D axi_dmac_terminate_all;
>  	dma_dev->device_synchronize =3D axi_dmac_synchronize;
>  	dma_dev->dev =3D &pdev->dev;
> -	dma_dev->src_addr_widths =3D BIT(dmac->chan.src_width);
> -	dma_dev->dst_addr_widths =3D BIT(dmac->chan.dest_width);
> +	ret =3D dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> +	if (ret)
> +		return ret;
> +	ret =3D dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> +	if (ret)
> +		return ret;
>  	dma_dev->directions =3D BIT(dmac->chan.direction);
>  	dma_dev->residue_granularity =3D DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>  	dma_dev->max_sg_burst =3D 31; /* 31 SGs maximum in one burst */

[Severity: High]
This is a pre-existing issue, but does assigning a linear byte count to
copy_align cause undefined behavior now that bus widths of 32 bytes and
above are supported?

Looking further down in axi_dmac_probe():

	dma_dev->copy_align =3D (dmac->chan.address_align_mask + 1);

The copy_align field expects an enum dmaengine_alignment representing the
log2 of the required alignment bytes, rather than a linear byte count.

If a bus width of 32 bytes is used, copy_align evaluates to 32. When the
DMA core uses is_dma_copy_aligned(), it calculates (1 << copy_align) - 1.
Could shifting a 32-bit integer by 32 cause undefined behavior and wrap
around to 1 on some architectures, completely bypassing DMA alignment
constraints?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-dmaengine-=
support-wider-dma-masks-v1-0-da23a8dcb756@analog.com?part=3D2

