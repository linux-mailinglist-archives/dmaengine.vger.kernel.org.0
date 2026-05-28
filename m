Return-Path: <dmaengine+bounces-10992-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHjVDoQlGGqZeQgAu9opvQ
	(envelope-from <dmaengine+bounces-10992-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:22:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD185F1363
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 709EC3030B0A
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39FD3C5DC3;
	Thu, 28 May 2026 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBkPQgIX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C883C1F51
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967199; cv=none; b=l9AZ+34USFvgBfwNrlRT+5NdwrZ6UBInm+oUUtNvBYbh6pkJofl6u/nrGQ016qyml7U8SWX9G2XNCH+xLEga/ks7ljRZw3kHgZIWDV39+94Me0c0WP0Rm8PfYjVRdGTzet38O/NhQmY+SaVEXSdbT7ZduPGo9lHlqgOCpAQ0DJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967199; c=relaxed/simple;
	bh=umjmzWI999Z8sGgeuvp0E/7M0dQBRokslaaoXkdxik8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h10ASw9DGHdDfSbGyv6+MlIxhfU4ERuiL2+j/9CFtUie8LEscrtNGEJJrWdeKHDYNp1MuVyHtLO8NC+hzXyQoH12Ir04LOdkzW5ZJs0d3cInXqhBYYMUZsEX5ZS1okoJFW8IwPtNKq+XmB/wRYvSH5TwApS+QlUdGTKWifB7AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBkPQgIX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DA81F000E9;
	Thu, 28 May 2026 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779967198;
	bh=L0Dtf9KKSEtFY/7xme2iGRfVamj1zPJxTVACs8elzPI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dBkPQgIX10qEiPH5Z5fLsspZsBzPRQhXTJR8JOPHeEo225nAti6Mqyh+sD9W09h6w
	 DMKF4IRIpI6/JpcibQ3/Fg72r1Q04fguwsPu9dxgAZdh4PQ9nt93J2g2bzEuYJ+5da
	 G1F1KylSJIqOInEJ3Um2/8T4o72T8YMmVbcPLcxCcehcYLcw/6cWenNv0TavfOe7yZ
	 wYI/D+RE+yB8T9q03W8/EXGjK5Ye1OSVrb0u9xB6lw9zetut8cpwI+EmJTNNkvZhuD
	 XpeT58ta457IU31U/ITpaup9aXXXxQ8vKtT+uNgq4H5ni1tFdCYLDgYf4hSiDxdDgR
	 sGkqFbcEsO0ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] dmaengine: nbpfaxi: Drop unused platform_device_id
 array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <5f7380828873e2375e319ef091178d11a277a0ac.1779965563.git.u.kleine-koenig@baylibre.com>
References: <5f7380828873e2375e319ef091178d11a277a0ac.1779965563.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 11:19:57 +0000
Message-Id: <20260528111958.49DA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.84 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10992-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AD185F1363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for `of_device_get_match_data()` in `nbpf_probe=
`.
- [High] Incorrect teardown order in `nbpf_remove()` can lead to hangs or s=
ystem lockups.
- [High] The IRQ parsing loop in `nbpf_probe` will infinite loop if the dev=
ice provides fewer than 9 valid IRQs.
--

commit d301198fc76e0a445cdebcc7c4a6a82f78f759b5
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>

dmaengine: nbpfaxi: Drop unused platform_device_id array

The dma-nbpf driver only probes devices from device tree and fails to
probe devices relying on the traditional platform device probe path.
This patch removes the unused platform_device_id array to prevent
misleading module metadata.

> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 334425faac00b..05d7321629cc8 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1486,20 +1486,6 @@ static void nbpf_remove(struct platform_device *pd=
ev)
>  	clk_disable_unprepare(nbpf->clk);
>  }

[Severity: High]
This is a pre-existing issue, but is the teardown order in this function
safe?

It looks like the driver frees the DMA channel IRQs and kills the tasklets
before calling dma_async_device_unregister().

Could this allow new requests to be submitted while the driver is being
torn down? Unregistering the DMA device is typically done first to prevent
new requests and drain the framework.

Additionally, the hardware clock is disabled via clk_disable_unprepare()=20
before explicitly terminating active DMA transactions. If a transfer is
running when the module is removed or unbound, could gating the clock of
an active AXI DMA engine cause a system bus lockup?

[ ... ]

> @@ -1523,7 +1509,6 @@ static struct platform_driver nbpf_driver =3D {
>  		.of_match_table =3D nbpf_match,
>  		.pm =3D pm_ptr(&nbpf_pm_ops),
>  	},
> -	.id_table =3D nbpf_ids,
>  	.probe =3D nbpf_probe,

[Severity: High]
This isn't a bug introduced by this patch, but does the probe function
handle a missing compatible string safely?

If the driver is manually bound via sysfs (e.g., using driver_override) to
a platform device that has an of_node but an unrecognized or absent
compatible string, of_device_get_match_data() will return NULL.
Dereferencing this NULL pointer to access num_channels would cause a
kernel panic.

[Severity: High]
This is another pre-existing issue in nbpf_probe(), but does the IRQ
parsing loop handle devices with fewer than 9 valid IRQs correctly?

If platform_get_irq_optional() encounters an out-of-bounds index, it
returns -ENXIO. The loop evaluates:

    if (irq < 0 && irq !=3D -ENXIO)
        return irq;

This ignores the -ENXIO error but doesn't break out of the loop. The
irqbuf[irqs++] =3D irq assignment is skipped, so the loop variable irqs is
never incremented.

Since the loop condition (irqs < ARRAY_SIZE(irqbuf)) remains true and i
increments without bound, could this cause an infinite loop during probe
for devices providing fewer than 9 IRQs?

>  	.remove =3D nbpf_remove,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5f7380828873e2375e3=
19ef091178d11a277a0ac.1779965563.git.u.kleine-koenig@baylibre.com?part=3D1

