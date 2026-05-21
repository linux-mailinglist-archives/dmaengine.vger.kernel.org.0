Return-Path: <dmaengine+bounces-10628-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C1iCFu6DmrBBgYAu9opvQ
	(envelope-from <dmaengine+bounces-10628-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:55:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774A5A074B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F29363019056
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA8348C47;
	Thu, 21 May 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad4Oh2M9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EC1A9F97;
	Thu, 21 May 2026 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349975; cv=none; b=eDv6Tyu2kCmkTB6J3sGEyMymY/+HQEWlNMALVp6Ds+hrxSeFaUFiLa8fxld52TAseMn26gx2DX27mL5Cv14YzgIkoJMDmC63UkZsy0Csi971ZXn4LfXxP41gAr0kFyzEA35GJHksEUB3BO5m4fVt42g2oIvDW58r1NXD8YMxwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349975; c=relaxed/simple;
	bh=HBWxyKqJgOMS5IWUOxQ21BzEb/uQXQYMeOTHw/N3flw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SV9eLWokWsseTD4ceJNX1WXQuLxdsi5QbEW5C+e9KvrE9SOKiWGpU48VgwK8HUSXMJTxRJtU61EP7FbnTl7VeJE8mrx8Oib5G/cWd0YQE6VbXvXVg6A2+i0s8z6x/xpc20w5W3VA+lPXnhESjUfdZuPYcVxgxfLjDjwHNfZLDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad4Oh2M9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88E71F000E9;
	Thu, 21 May 2026 07:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779349974;
	bh=bw7poT7ZxwEMD/0IoEGHTJ3x+a21BZC4NsTxmvZOp4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ad4Oh2M9x0dWEPCu7X8mN5CfLoLF0StVRH2ih0z9xchjFsYQRFEq4+8tx6Jm38tCQ
	 dNw0ZC+x0rF1j0owWbzSKMDLNX1cpZ6G0gF8yPjv+XV0nexnObCFXHIGO7L/5GOKju
	 b9Nw583AmuyNI4JzfJhzfG9yDECGBD+zNSbTzRdS/5VqSIMnWVfRzzPYQv4Fiwep/D
	 JXFraQRJcULX1HNQkU51TRpaKgQ7ZmoFV6al15W1sP8ZL4AbUysJOTCBJnqu979Hei
	 SBgpzyTFhci/9E63bkDXN9N6LgARCkclp6SltWOvCgPEeiC34RlZ1+NxajCBvidDNp
	 22lv/h5lXTHRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] dmaengine: arm-dma350: enable ANYCH interrupt
 for shared IRQ wiring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Guo" <jun.guo@cixtech.com>
Cc: robh@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260521072924.3000282-2-jun.guo@cixtech.com>
References: <20260521072924.3000282-2-jun.guo@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 07:52:53 +0000
Message-Id: <20260521075253.B88E71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10628-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cixtech.com:email,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 1774A5A074B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Enabling the global ANYCH interrupt before clearing channel states=
 and handling error paths can cause spurious interrupt storms and break sha=
red IRQ lines.
--

commit 0bf9d17ebbd8be17166134ed8865c553f2b5eec7
Author: Jun Guo <jun.guo@cixtech.com>

dmaengine: arm-dma350: enable ANYCH interrupt for shared IRQ wiring

This commit enables DMANSECCTRL.INTREN_ANYCHINTR during probe so that chann=
el
interrupts are propagated when integrators wire DMA-350 channels onto a sha=
red
IRQ line.

> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 84220fa83029d..09403aca8bb06 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c

[ ... ]

> @@ -582,6 +587,10 @@ static int d350_probe(struct platform_device *pdev)
>  	dmac->dma.device_issue_pending =3D d350_issue_pending;
>  	INIT_LIST_HEAD(&dmac->dma.channels);
> =20
> +	reg =3D readl_relaxed(base + DMANSECCTRL + NSEC_CTRL);
> +	writel_relaxed(reg | INTREN_ANYCHINTR_EN,
> +		       base + DMANSECCTRL + NSEC_CTRL);
> +

[Severity: High]
Will enabling INTREN_ANYCHINTR_EN here, before clearing the individual chan=
nel
states, potentially cause an interrupt storm on shared IRQ lines?

If a bootloader left a channel with a pending interrupt, this will immediat=
ely
assert the shared interrupt line before the DMA driver has registered its I=
RQ
handler or cleared the channel state in the loop below.

Additionally, if the probe fails midway (for instance, if platform_get_irq
returns an error for a channel):

drivers/dma/arm-dma350.c:d350_probe() {
        ...
        dch->irq =3D platform_get_irq(pdev, i);
        if (dch->irq < 0)
            return dev_err_probe(dev, dch->irq, ...);
}

Does this error path leave the global ANYCH interrupt enabled without sendi=
ng
CH_CMD_CLEAR to the remaining channels? Any uncleared pending interrupt on
those remaining channels could permanently assert the shared IRQ line,
eventually causing the kernel to disable the shared IRQ entirely.

>  	/* Would be nice to have per-channel caps for this... */
>  	memset =3D true;
>  	for (int i =3D 0; i < nchan; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521072924.3000=
282-1-jun.guo@cixtech.com?part=3D1

