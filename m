Return-Path: <dmaengine+bounces-11396-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KtX9EBouKWowSAMAu9opvQ
	(envelope-from <dmaengine+bounces-11396-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 11:27:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC0667D4E
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 11:27:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eqDaR9ac;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11396-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11396-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845F3352C0B8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF3399358;
	Wed, 10 Jun 2026 09:10:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337ED3B71D0
	for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 09:10:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082635; cv=none; b=XXk3p7Z48f9OgoHl4DWeo+04ke72JnpvgrZlcICxmJmdsX1IrlrfK9luvgDN1EAGiEp31Z9y2QqF1AnfVZAii0+W1D28WyXhq4sp+dV8NpGWNgOT3DYW2GoJPEJFVnbqlO8J1kO5Vjz647EY0r9f18GYt8d2qqVvV7dGh0eOUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082635; c=relaxed/simple;
	bh=huO8RLY1XhRGNqfEKlLYNIjbKn5PDQaDuTHUx3Z6ZbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TuDMcg2l1BeYtHCjlFZAORTPvawIcIQRgGBpdqtWVkHY8OZN7r1UZFuDOYCh5kygqUenrrS/TG8BToHAMVWknl6T1cKsbraV748zhEhY0vCLXoioWqFZzKKMqz18hNE0TZzDes8FtYoWLxAgn+GE6xQJ1t8ZCtQE6YRh0rIDLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqDaR9ac; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39EA1F00893;
	Wed, 10 Jun 2026 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082633;
	bh=w/xRJE2SiIjYfcHWtlbRssemV4QoOQ/GDewmT5Baft4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eqDaR9acfj9YqbM03kHm7lg0DEKhbJo6KAXDWF9eD+Q/64l4vkMRaUR3yvzrQI029
	 Ms4+CPQjodWj5dTDYElQlo0ZOW8FI5kOPeJSYIAMl2Rugy+Ixh6LOBrINvkw8mXjYH
	 mQ7cJ8z9s9uZNKner+Eg8oYQFTTPGtJsw/FP1qYtyBkmgiHp+M28qsuINH9bC6eKnv
	 5W+l4BJqeHrktv7pw/V1Atq7Ve0JYL3sLInogrwQOM9aWLQ2YRfiYEPhiq42myQ6Wv
	 ivc9DtsCq6guCkWMgrQIZmnAkazHLCPduyt52oMrtFlOClJtQyp6hUEV1wi5FE/Cd0
	 PV77cox40mHKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] dma: mv_xor: add missing platform remove function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260610065737.118211-3-rosenp@gmail.com>
References: <20260610065737.118211-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 09:10:32 +0000
Message-Id: <20260610091033.A39EA1F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11396-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DCC0667D4E

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing tasklet_kill() leads to a Use-After-Free during driver unb=
ind.
- [High] Object lifetime mismatch between devres and the dmaengine framewor=
k causes use-after-free on driver unbind.
- [High] The driver unmaps DMA buffers and disables clocks during removal w=
ithout explicitly stopping the DMA hardware.
- [High] A crafted or unexpectedly large Device Tree causes a heap buffer o=
verflow in mv_xor_probe when xordev->xor_type =3D=3D XOR_ARMADA_37XX.
- [High] Unsafe DMA buffer allocation and reversed DMA mapping directions f=
or dummy buffers.
--

commit c4face3fac6884413550ece128f62a970eb9f8e3
Author: Rosen Penev <rosenp@gmail.com>

dma: mv_xor: add missing platform remove function

This commit introduces a remove callback for the mv_xor driver to clean up
channels and irq mappings upon driver unbind.

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index a97fa0038652d..3fc39cca7cbd3 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1452,8 +1452,22 @@ static int mv_xor_probe(struct platform_device *pd=
ev)
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but is there a potential array overflow in
mv_xor_probe() for Armada 37XX devices?

For XOR_ARMADA_37XX, max_channels is set to num_present_cpus() without capp=
ing
it to MV_XOR_MAX_CHANNELS (which is 2):

    if (xordev->xor_type =3D=3D XOR_ARMADA_37XX)
        max_channels =3D num_present_cpus();

If the device tree provides more than two child nodes and there are more th=
an
two CPUs, could the loop sequentially storing allocated channel pointers ex=
ceed
the bounds of the fixed-size xordev->channels array?

[Severity: High]
This is a pre-existing issue, but are the dummy_src and dummy_dst buffers in
struct mv_xor_chan safely aligned and mapped?

They are embedded in the struct without cache-line alignment, and their map=
ping
directions in mv_xor_channel_add() appear to be swapped:

    mv_chan->dummy_src_addr =3D dma_map_single(dma_dev->dev,
        mv_chan->dummy_src, MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);

Since mv_xor_prep_dma_interrupt() uses dummy_src as the read source and
dummy_dst as the write destination, unmapping dummy_src with DMA_FROM_DEVICE
will invalidate the CPU cache.

Could this invalidation corrupt adjacent struct members sharing the same ca=
che
line?
=20
> +static void mv_xor_remove(struct platform_device *pdev)
> +{
> +	struct mv_xor_device *xordev =3D platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i =3D 0; i < MV_XOR_MAX_CHANNELS; i++)
> +		if (xordev->channels[i]) {
> +			mv_xor_channel_remove(xordev->channels[i]);

[Severity: High]
This isn't a bug introduced by this patch, but does mv_xor_channel_remove()
need to call tasklet_kill()?

When the driver unregisters the DMA device:

    dma_async_device_unregister(&mv_chan->dmadev);

it leaves pending tasklets capable of executing asynchronously.

Because the channel and DMA descriptor pool are freed by devres, could an
executing tasklet access freed memory if it runs after this cleanup?

[Severity: High]
This is a pre-existing issue, but does enabling driver unbind expose an
object lifetime mismatch?

The driver dynamically allocates mv_chan using devm_kzalloc(), which is fre=
ed
by devres when remove() completes.

Since dma_async_device_unregister() does not forcefully revoke client
references, could active clients holding a channel reference trigger a
use-after-free when they access or release the channel later?

[Severity: High]
This isn't a bug introduced by this patch, but does the hardware need to be
quiesced before tearing down the channel?

mv_xor_channel_remove() destructively unmaps dummy buffers via
dma_unmap_single(), and then devres disables the clock.

If a DMA transaction is currently in flight, could the hardware continue
writing to unmapped memory or hang the AXI bus?

> +			if (pdev->dev.of_node)
> +				irq_dispose_mapping(xordev->channels[i]->irq);
> +		}
> +}

[ ... ]

>  static struct platform_driver mv_xor_driver =3D {
>  	.probe		=3D mv_xor_probe,
> +	.remove		=3D mv_xor_remove,
>  	.suspend        =3D mv_xor_suspend,
>  	.resume         =3D mv_xor_resume,
>  	.driver		=3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610065737.1182=
11-1-rosenp@gmail.com?part=3D2

