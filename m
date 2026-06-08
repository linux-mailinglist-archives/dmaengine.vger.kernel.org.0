Return-Path: <dmaengine+bounces-11293-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SEFtJIJxJmpcWgIAu9opvQ
	(envelope-from <dmaengine+bounces-11293-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 09:38:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D975D6539D9
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 09:38:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VYQw71iJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11293-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11293-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D948E3028035
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 07:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E261390986;
	Mon,  8 Jun 2026 07:35:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9517313E17
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 07:35:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904111; cv=none; b=KDp9cQgiE23FsB7l3NhLaHx6YiFRe3/FA6WBoGJNV8VugGG1tf44ZQnWKNduVzvFktXYCoylD3RUZRcelO5ERVhxp7NbKi9d2TN9RC9eK6t12Qls7N2s/4OJOOh8mwivP39TQPsEYGrwf7qwDYUFmAOD1TfMqU8P7YllzAmkITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904111; c=relaxed/simple;
	bh=M3tP102jS9mg2TyvZMG1C0ceAmSnTgOBtoCcF0Y7eXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmtnIYg7FgwnjeJbJbRu4cwmpmJXq+i3L+hFw49U/XjxChSOpqwj3Qf7ErFXppF35t7yhqOvihEjtl5EWgA5jCnDR/rKICGpdp+K/fc1ab3FznE73rpWI7ILDzOTwWoqc2HctgWvuSMQU1w5gVLjKnOBEmVHjrmzCU3xb2gISVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYQw71iJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563DD1F00893;
	Mon,  8 Jun 2026 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780904110;
	bh=yqIWEDSbFGeJmPwb1shlBrQKo6TuRclrbknqBevSL8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYQw71iJ5Dlof+bBtY/BR1QOQHAfsrI4zDOdPSptwzdGP7jdMJqvBbrXN3W6Xq2Yl
	 kWWl1N8B3AvhfpKU99aE56H2+iU4tHo8byRQ+UUImW+fRgxPWnx4ATOtwYRqBaQyDE
	 YdeWapfwvCPn7WOkuE6t7OFjRa9adn4eP9OA+PaPoutNONsebej1fGriv9m1L6ap8R
	 xojeqoktoO0cVBYX8RyzWhJEJcY4cWcmQSMPTCnsQm+TbHuOx6HbUdxXCsV71H/JYz
	 NbJgtIMPe15DyulW7H6lszBlnOoml/l0ROazso4cCyDGuTY0JDO2d2XIOM7AYqmXLw
	 sc52VLuCo01Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dma: at_hdmac: Fix use-after-free by proper tasklet
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260608072635.148011-1-zenghongling@kylinos.cn>
References: <20260608072635.148011-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:35:09 +0000
Message-Id: <20260608073510.563DD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11293-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D975D6539D9

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The probe error path executes `free_irq()` and `at_dma_cleanup_cha=
nnels()` twice due to a missing return or goto statement after the `err_dma=
_async_device_register` label.
- [High] `at_dma_cleanup_channels()` relies on uninitialized `chan->chan_id=
` values on early probe error paths, causing it to fail to disable interrup=
ts.
--

commit 393b3802c91585b2038e624d6fb8dec3e442b9db
Author: Hongling Zeng <zenghongling@kylinos.cn>

dma: at_hdmac: Fix use-after-free by proper tasklet cleanup

This commit reorders the cleanup paths in the at_hdmac driver to fix a
use-after-free vulnerability. It ensures free_irq() is called before
killing tasklets and freeing memory to prevent running tasklets from
accessing freed memory.

Link: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel.o=
rg/

> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e5b30a57c477a..ac1ba21e34287 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1940,6 +1940,19 @@ static void at_dma_off(struct at_dma *atdma)
>  		cpu_relax();
>  }
> =20
> +static void at_dma_cleanup_channels(struct at_dma *atdma)
> +{
> +	struct dma_chan *chan, *_chan;
> +
> +	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
> +			device_node) {
> +		/* Disable interrupts */
> +		atc_disable_chan_irq(atdma, chan->chan_id);

[Severity: High]
Will this successfully disable interrupts for all channels if probe fails
early?

It looks like chan->chan_id is populated by the DMA engine core inside
dma_async_device_register(). If probe fails before registration is complete,
chan->chan_id will still be zero from the allocation.

This would result in repeatedly attempting to disable the interrupt for
channel 0, leaving the other channels enabled. Since the global IRQ handler
was just removed by free_irq(), could pending interrupts on these active
channels cause an unhandled interrupt storm?

> +		tasklet_kill(&to_at_dma_chan(chan)->vc.task);
> +		list_del(&chan->device_node);
> +	}
> +}

[ ... ]

> @@ -2105,11 +2118,15 @@ static int __init at_dma_probe(struct platform_de=
vice *pdev)
>  err_of_dma_controller_register:
>  	dma_async_device_unregister(&atdma->dma_device);
>  err_dma_async_device_register:
> +	free_irq(platform_get_irq(pdev, 0), atdma);
> +	at_dma_cleanup_channels(atdma);

[Severity: High]
Is a goto or return statement missing here?

If execution reaches err_dma_async_device_register, it appears it will fall
through to err_desc_pool_create below, where free_irq() and
at_dma_cleanup_channels() are called a second time.

Could calling free_irq() twice for the same dev_id trigger a kernel warning
for trying to free an already-free IRQ?

>  	dma_pool_destroy(atdma->memset_pool);
>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->lli_pool);
>  err_desc_pool_create:
>  	free_irq(platform_get_irq(pdev, 0), atdma);
> +	if (atdma->dma_device.channels.next !=3D NULL)
> +		at_dma_cleanup_channels(atdma);
>  err_irq:
>  	clk_disable_unprepare(atdma->clk);
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608072635.1480=
11-1-zenghongling@kylinos.cn?part=3D1

