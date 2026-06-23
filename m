Return-Path: <dmaengine+bounces-11740-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xuynHuAkOmpA2gcAu9opvQ
	(envelope-from <dmaengine+bounces-11740-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 08:17:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6156B4698
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 08:17:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ohp6WnVp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11740-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11740-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DAD4301A1DF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 06:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4113B3BE1;
	Tue, 23 Jun 2026 06:16:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196A3A1A55
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 06:16:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195399; cv=none; b=LJLfJxsmaN7OSwFmC3lvlP9hdrQpylgZYDxznFMtLV9Zp9QgPyuNlnXlsNGkkwo/RfSjtyoRDCAv0xUZm9fKKpas0wCTkUkg2KYmZlokgQMqncQ2Jhv4hnatWC8ZXiPnfA18fVGtvjVldaCXB2K+AxWM1ipJO8FJnU34G7OcT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195399; c=relaxed/simple;
	bh=dFg9rND19J9MMUPvOZwwKcJ1DALPRptL26j55aDPEo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pcLvG1RqkXuJMHBLlJXX0JLGvWOiV5/1Hrv54RKs4shuXpGhs9MlR380MRtTpe33im0K95SNlU1bMm6zj6XmlxT4/sE/hhT3fOo/+ZtjgYuR12AqGT1jHO8YR+RPliVgTeamsuTf7b5hTT6H1EZFTYkerKV6LuNKg0L9uscNwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohp6WnVp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36061F00A3A;
	Tue, 23 Jun 2026 06:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782195398;
	bh=CwBTr9IWsN1nEq0jJvMIx7ROtEVMxCYGRXBXUeYA+Kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ohp6WnVph6Q5OrbcbPMRfnrybFYfvV57UpVKaA8Wzkz/3nq6wr5LZ0SgpqUBe6XRX
	 H+SZFrSXx7QcMH8OghPk/q5EIcQVan1Xlr1M2YiuGU6kV01iDEtA/FKx8t7vo2oM0X
	 Y1mf5AYHd9DV+6xf6kjhLARiUcXO8Vk82luzjqCA3K6Bt+gjKPhSVIImINBS3uO2Nc
	 QvvGHPhATOg+7bnsJTVlUXWwgjmFIHCBWpIcPwsUW9AWKcxR3k38AISwG6mhW8DS+5
	 xE0p5wqbKCAIbEuK4/+gFlVfeIvu2Y1DnhFihip6s4IgPEhpUcUTnDruHA2viLNfRu
	 2j37eIncJ1jvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: altera-msgdma: fail probe when reset times
 out
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260623060554.13523-1-pengpeng@iscas.ac.cn>
References: <20260623060554.13523-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 06:16:37 +0000
Message-Id: <20260623061637.D36061F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11740-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB6156B4698

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing dma_async_device_unregister() on probe error path leads to=
 Use-After-Free
- [High] IRQ handler requested before data structures are initialized, risk=
ing NULL pointer dereference
--

commit 4e931dfaccbe922ddc5a4a0f0f0b3dd9e532e207
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

dmaengine: altera-msgdma: fail probe when reset times out

This commit updates msgdma_reset() to return an error code when the
controller fails to reset. It also modifies msgdma_probe() to abort the
probe process if the reset times out, preventing the registration of a DMA
engine backed by a stalled controller.

> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
[ ... ]
> @@ -896,7 +899,9 @@ static int msgdma_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
> =20
> -	msgdma_reset(mdev);
> +	ret =3D msgdma_reset(mdev);
> +	if (ret)
> +		goto fail;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential memory
issue in the error handling path just after this code. If
of_dma_controller_register() fails later in the probe, the code branches to
the fail label:

msgdma_probe() {
    ...
    ret =3D dma_async_device_register(dma_dev);
    if (ret)
        goto fail;

    ret =3D of_dma_controller_register(...);
    if (ret =3D=3D -EINVAL)
        ...
    else if (ret && ret !=3D -ENODEV)
        goto fail;
    ...
fail:
    msgdma_dev_remove(mdev);
    return ret;
}

Does msgdma_dev_remove() need to call dma_async_device_unregister() to clean
up the registered device?

Since mdev is allocated with devm_kzalloc(), the dma_device structure is
freed when the probe fails. Will leaving the device registered leave a
dangling pointer in the global dma_device_list leading to a use-after-free?

[Severity: High]
This is also a pre-existing issue, but looking at the earlier setup in
msgdma_probe(), could an interrupt fire before the required structures are
fully initialized?

msgdma_probe() {
    ...
    ret =3D devm_request_irq(&pdev->dev, mdev->irq, msgdma_irq_handler, ...=
);
    ...
    tasklet_setup(&mdev->irq_tasklet, msgdma_tasklet);
    dma_cookie_init(&mdev->dmachan);
    spin_lock_init(&mdev->lock);
    INIT_LIST_HEAD(&mdev->active_list);
    INIT_LIST_HEAD(&mdev->pending_list);
    ...
}

If the hardware is already asserting an interrupt during boot (for example,
left over from a bootloader), will the IRQ handler access uninitialized
structures like mdev->pending_list and trigger a NULL pointer dereference?

Should the interrupt be requested only after these data structures are safe=
ly
initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623060554.1352=
3-1-pengpeng@iscas.ac.cn?part=3D1

