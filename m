Return-Path: <dmaengine+bounces-12019-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9lyuNEB0R2rcYQAAu9opvQ
	(envelope-from <dmaengine+bounces-12019-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:35:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03B7001FD
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:35:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OiKo0LaJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12019-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12019-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 379203093E60
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2026 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722D3603D5;
	Fri,  3 Jul 2026 08:10:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E82FE0F
	for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2026 08:10:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066204; cv=none; b=h7ssvo87Ty+xtCPC+42/iDfyMznDIbWkZUoHrvCPRXp8XvpxY4zPTb9wuRqqgzsrn1n3hF+tGcC2wGURbysC8CCM54Egimxmid9YqbtBz1bKeuE0pkbV9SFFyys+ufUej2IKWVo0Yk8lND34+1JeAyIxTnIUA4trU96kds7jsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066204; c=relaxed/simple;
	bh=vQQXq2lawDCaWSJKP1rsy9O1jetNFtJvi03Ibhv3GPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ra0dUlZA/EBG0ra4+SBeCpo3dl7MBkvbP39XSB7CQUXczR8YTrxpybSZXvV1MJ/vzMmVXNF2+jy6P/MCuYeyUI5qdvpUH+c7NirzC7bCATp8Rp8qU8QIDfbVMdSoYfL0u01ql3kcOxtTCcSMEI7t2O7AETOI2pj9kpeIfjrKL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiKo0LaJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29531F000E9;
	Fri,  3 Jul 2026 08:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066203;
	bh=5PpcjSA8ZQ3XjXSvoiHozrmAOyx7rkCIU5kVIG3m2HI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OiKo0LaJ7eyYaQpp1BdCA0mfk5YzEjbBgGmAkl/2ndBRPsM7w4CCV52pcz2bRO2Me
	 P/fO9whSe05SAbF9g0Yscy9ayAjSoIkW4+ZMv0wxg7hZGFiXE31TuEn3SRyUl2CPw0
	 o6RLeWNxCin1mrUNuFoS/UgF5I1qAb9vKSgDO9Di3Ln6GzsSCa5d/w9+qmL9fgqq9I
	 MpFDV5RTjw7YDIVDp51Kcxy/v6YZFL3tZ3lu4e6qrRonHYczSfbKwDg9EHDYEaouyj
	 c2BXIf5oIyAeYe/e4pakcyanbC/78egHZj6Nq42WIbohfUqVQVvmZTYTNhsqms7fN7
	 EM/tSivgiBDXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Taedcke" <christian.taedcke@weidmueller.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:10:02 +0000
Message-Id: <20260703081002.F29531F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12019-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weidmueller.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA03B7001FD

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ collection loop in nbpf_probe() will infinite loop and per=
manently hang the kernel during probe if the device tree defines fewer than=
 9 interrupts.
- [High] Shared IRQs are requested before enabling the device clock, which =
can cause a bus fault if a shared interrupt fires early.
- [High] nbpf_desc_page_alloc() leaks a DMA-capable page and passes an inco=
rrect size to dma_unmap_single() on mapping failures.
--

commit 4b0854f80b4f9ee26435b82925b2ce35ade384d6
Author: Christian Taedcke <christian.taedcke@weidmueller.com>

dmaengine: nbpfaxi: Fix setting channel irqs in probe()

This commit fixes an issue in the IRQ assignment loop for nbpfaxi channels.
When the error IRQ is not the last entry in the buffer, the previous loop
terminated early, leaving the last channel without an IRQ. The update itera=
tes
over all collected IRQs instead of the channel count to fix this.

> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc8..b1f06f0bd0d50 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pde=
v)
>  		if (irqs =3D=3D num_channels + 1) {
>  			struct nbpf_channel *chan;
> =20
> -			for (i =3D 0, chan =3D nbpf->chan; i < num_channels;
> -			     i++, chan++) {
> +			for (i =3D 0, chan =3D nbpf->chan; i < irqs; i++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] =3D=3D eirq)
> -					i++;
> -				if (i >=3D ARRAY_SIZE(irqbuf))
> +					continue;
> +				if (chan >=3D nbpf->chan + num_channels)
>  					return -EINVAL;
>  				chan->irq =3D irqbuf[i];
> +				chan++;
>  			}
>  		} else {
>  			/* 2 IRQs and more than one channel */

While reviewing this patch, I noticed a few pre-existing issues in this dri=
ver.

[Severity: High]
This is a pre-existing issue, but does the IRQ collection loop earlier in
nbpf_probe() have a potential infinite loop?

drivers/dma/nbpfaxi.c:nbpf_probe() {
    ...
	for (i =3D 0; irqs < ARRAY_SIZE(irqbuf); i++) {
		irq =3D platform_get_irq_optional(pdev, i);
		if (irq < 0 && irq !=3D -ENXIO)
			return irq;
		if (irq > 0)
			irqbuf[irqs++] =3D irq;
	}
    ...
}

If the device tree defines fewer than 9 interrupts, platform_get_irq_option=
al()
will return -ENXIO, which bypasses the loop break condition. Because the ir=
qs
counter never increments in this case, the i variable increments infinitely,
hanging the kernel during probe.


[Severity: High]
This is a pre-existing issue, but could this shared IRQ request cause an ea=
rly
interrupt leading to a bus fault?

drivers/dma/nbpfaxi.c:nbpf_probe() {
    ...
	ret =3D devm_request_irq(dev, eirq, nbpf_err_irq,
			       IRQF_SHARED, "dma error", nbpf);
    ...
	ret =3D clk_prepare_enable(nbpf->clk);
    ...
}

The error IRQ is requested here as shared, allowing it to fire immediately
if another device raises the line. Since the device clock is not enabled
until much later, is there a race window where register reads by the early
ISR could crash?


[Severity: High]
This is a pre-existing issue, but is there a memory leak and incorrect sizi=
ng
in the DMA mapping error path of nbpf_desc_page_alloc()?

drivers/dma/nbpfaxi.c:nbpf_desc_page_alloc() {
    ...
unmap_error:
	while (i--) {
		ldesc--; hwdesc--;

		dma_unmap_single(dchan->device->dev, ldesc->hwdesc_dma_addr,
				 sizeof(hwdesc), DMA_TO_DEVICE);
	}

	return -ENOMEM;
}

In this error path, sizeof(hwdesc) evaluates to the pointer size instead of
the actual struct size. Additionally, the page allocated for dpage doesn't
appear to be freed before returning, leaking a DMA-capable page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-upstreamin=
g-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com?part=3D1

