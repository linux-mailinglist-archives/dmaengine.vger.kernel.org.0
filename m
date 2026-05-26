Return-Path: <dmaengine+bounces-10967-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBvlHXYIFmpNhAcAu9opvQ
	(envelope-from <dmaengine+bounces-10967-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:54:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDC5DC7BD
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D96300639D
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789A3C0A02;
	Tue, 26 May 2026 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9burDNB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99037DEAD
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828686; cv=none; b=sK6ACut1r+5gC7xIsQH8ZK+GMvHvh3PxRxY4kubLj/0fMYuc34kNJj+Eysr1POPHi1s8X39ABGcuujy/scIubUblVe7OxujkRtbbA7wYRiRJWgvqk1BVEBlLuWKRBWKUj1eRKaeHNvqVqPVG9JW4vnUinNmYYbDqN+dc/rwVHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828686; c=relaxed/simple;
	bh=lHqmV3/Z0U05y1e1CEW/94RUnjnT5emoayv4KOTKzdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PJtTveEKbQSkZG10HMiSQrLv7OkRtjn9RugBiSmCDMQMFHywrS7h7+98ZgDH9aTBhpFgeXrwQDg5Sbr/5JSiTvVY3AoXgD7b3i8LMT8/Cg/ITNXdwp98bSfOXo24JQCn5DQh7eDGRSxFXIEAA1u9gc61D1+u6uTVHdFwiyRUgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9burDNB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78841F000E9;
	Tue, 26 May 2026 20:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779828685;
	bh=4FfRDZ5uVpjWH9f0AL/CeB4QQ5iNaEFBS/l2NgwzIXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9burDNBVnGEKnGGzCdSkDyP86lgoxhlHypCpiw9wCuzG6WsOvsOwX8zOwoDKN1b3
	 5IJvzGIFDykXgBYmFtttVk9tE4M/nKyzwIvnN9wB/CgLCyiCEUBRHuzk5AKQkJRzGN
	 WIgjirQ+g84kEkFpa8AE/iyU3S2ezW4fSBHqs+IWZkl95eWfUiGat9MXhaLZEs0X2g
	 GNX55alddRWoNxErdFRkjQCGe+QIBGwjmjjCmHN5FR4RaU4Sz6kWf3RURjYARMYubw
	 B4apy8aa5tYn+3AsTTPPZWCXScTTJBt6SCXNeCpef+rtNa36aMdtYEf3B2zMDz7V6u
	 LtewbwzrczHOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] dmaengine: ti: omap-dma: turn lch_map into a flexible
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260526201327.13225-1-rosenp@gmail.com>
References: <20260526201327.13225-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 20:51:24 +0000
Message-Id: <20260526205124.C78841F000E9@smtp.kernel.org>
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
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10967-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: C8BDC5DC7BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Type mismatch and bypassed bounds check for `lch_count`.
- [Medium] Undocumented behavioral changes and bug fixes silently included =
in the patch.

Pre-existing issues:
- [High] Teardown race condition and unconditional devres WARN_ON in remove=
().
--

commit 274cec0b6701807c53603cef31b387fd271e1ddd
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: turn lch_map into a flexible array

Convert the separately-allocated lch_map pointer array to a C99 flexible
array member at the end of struct omap_dmadev and annotate it with
__counted_by(lch_count). The probe is reordered so platform_data lookup
and the lch_count determination happen before the parent allocation.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99a..0cccd66636284 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
[ ... ]
> @@ -1656,36 +1656,55 @@ static int omap_dma_probe(struct platform_device =
*pdev)
>  {
>  	const struct omap_dma_config *conf;
> +	struct omap_system_dma_plat_info *plat;
>  	struct omap_dmadev *od;
> +	int lch_count;
[ ... ]
> +	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels", &lch=
_count)) {
> +		dev_info(&pdev->dev, "Missing dma-channels property, using %u.\n",
> +			 OMAP_SDMA_CHANNELS);
> +		lch_count =3D OMAP_SDMA_CHANNELS;
> +	}
> +
> +	if (lch_count > OMAP_SDMA_CHANNELS) {
> +		dev_err(&pdev->dev, "invalid dma-channels value %u\n", lch_count);
> +		return -EINVAL;
> +	}
> +
> +	od =3D devm_kzalloc(&pdev->dev, struct_size(od, lch_map, lch_count), GF=
P_KERNEL);

[Severity: Medium]
Is it possible for a malformed Device Tree to bypass this bounds check?

The variable lch_count is declared as a signed int but its address is passed
to of_property_read_u32().

If a Device Tree provides a dma-channels value of 0x80000000 or greater,
of_property_read_u32() writes it as a negative number. This would bypass the
bounds check above since it performs a signed comparison.

Consequently, struct_size() would implicitly cast the negative value to a
massive size_t value, resulting in an integer overflow and an unintended
-ENOMEM allocation failure rather than gracefully rejecting the invalid DT
property with -EINVAL.

Could lch_count be declared as a u32 to avoid this and the -Wpointer-sign
warning?

[ ... ]
> @@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *p=
dev)
>  			if (od->ll123_supported)
>  				dma_pool_destroy(od->desc_pool);
>  			omap_dma_free(od);
> +			return rc;
>  		}
>  	}

[Severity: Medium]
This isn't a bug, but should this fix be documented in the commit message or
separated into a standalone commit?

This silently fixes a missing return statement on the error path, which is
unrelated to the flexible array conversion described in the commit message.

[ ... ]
> @@ -1852,7 +1853,7 @@ static void omap_dma_remove(struct platform_device =
*pdev)
>  	struct omap_dmadev *od =3D platform_get_drvdata(pdev);
>  	int irq;
> =20
> -	if (od->cfg->may_lose_context)
> +	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
>  		cpu_pm_unregister_notifier(&od->nb);

[Severity: Medium]
This isn't a bug, but should this fix also be split out or documented?

Checking od->cfg->needs_busy_check here patches a PM notifier resource leak,
which seems unrelated to the flexible array conversion.

[Severity: High]
This is a pre-existing issue, but does omap_dma_remove() have a teardown ra=
ce
condition?

Looking at the rest of omap_dma_remove():

drivers/dma/ti/omap-dma.c:omap_dma_remove() {
        ...
        irq =3D platform_get_irq(pdev, 1);
        devm_free_irq(&pdev->dev, irq, od);

        dma_async_device_unregister(&od->ddev);
        ...
}

The function explicitly frees the IRQ handler via devm_free_irq() before
calling dma_async_device_unregister().

If active DMA transfers complete after the IRQ is freed, they will trigger =
an
unhandled interrupt. Since the IRQ is shared, repeatedly raising unhandled
interrupts will cause the core IRQ subsystem to permanently disable the
shared IRQ line.

Also, for legacy devices where irq <=3D 0, the driver skips requesting the =
IRQ
during probe but still unconditionally passes the invalid/negative IRQ to
devm_free_irq() during remove. Does this cause devres to fail its resource
lookup and trigger a warning stack trace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526201327.1322=
5-1-rosenp@gmail.com?part=3D1

