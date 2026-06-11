Return-Path: <dmaengine+bounces-11484-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ioNGFm8mK2ob3QMAu9opvQ
	(envelope-from <dmaengine+bounces-11484-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:19:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B386467567C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:19:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=omM9EBTo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11484-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11484-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6417C3179A32
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3FF32860B;
	Thu, 11 Jun 2026 21:19:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A4369D59
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:19:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212756; cv=none; b=McxurQWsk4xkx45WwCs7WJfUDKnyOaCBPXXl5MY19MC1nUjHc2bbmVi5JT/aOyKHL7mSOhr+LhR/gh1afClv8dSkj90Gprma560ORXWm3zERujo4ZJ8sH2BTtjQ2EipxS8wMGLU8CFFTwdNNmdJ2ktRi8axCT/uF2tDa/vUV0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212756; c=relaxed/simple;
	bh=G0Y2kYFxPvABJSjJ0JAQZFuQtKeCecVEtrq4FJAfmRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNTJPRoZqfXfIjTfX/XHveg8NwccSm76o3AFH0of/oQnMt+URVkxFiNaaXAE+8rrnGlAyTyHI/IaQMpL8fRNlEaQh9JV/VcEa/AI3QdHuWL6wc23w2siYjKftHGPP29WQfyVg7uLoHitJIN/S+5uc0O3dD1igwWMbvt2gaFXgUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omM9EBTo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685191F000E9;
	Thu, 11 Jun 2026 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781212754;
	bh=fWY6UBoPChow4Ixdlbp9B0WKRPANk2syjkLhnFyE5rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omM9EBToW7KLucg3j2hi9r1+/ZqWTEu8HXovvPh7FG6fu5RH7UfFVjQ9tSUsSsdlI
	 k9LzobO2voD27fPgSeEoQOcclPg9rG2hjIaZ97l0dBirRmRgSuuKJpSi3deHy4hhtw
	 NNLW0b/Ds3a49zofi646CAI2a6hq8i3MdjG5l5LrB3uOTUzv+T2xIVtwjukZeWOiiL
	 330XFiwRRqQR8v/Bhn+MG8QI7vJItoVyKdmrR/HoTIA0IUexjXVN4IdndVLbBl6hlp
	 LEELHS6+Z34ANfTXsoPMA6os1j9GaErFvl9VdxfJ4hE3NaFYant2h8CjfITGOuYGCQ
	 UJbjLTAujn6gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 9/9] dmaengine: mv_xor: add missing platform remove
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260611210721.81979-10-rosenp@gmail.com>
References: <20260611210721.81979-10-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 21:19:13 +0000
Message-Id: <20260611211914.685191F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11484-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B386467567C

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Resource leaks in the newly introduced mv_xor_remove function: mis=
sing clk_disable_unprepare, clk_put, and irq_dispose_mapping.

Pre-existing issues:
- [High] Incorrect teardown sequence in mv_xor_channel_remove leads to Use-=
After-Free due to delayed free_irq and missing tasklet_kill.
--

commit 9ff45f7ddd6e175cd19bc1dcad7a0c33d39a5914
Author: Rosen Penev <rosenp@gmail.com>
dmaengine: mv_xor: add missing platform remove function

The driver was missing a remove callback, so channels, DMA devices, and IRQs
were never cleaned up on driver unbind. This patch implements mv_xor_remove
to undo probe operations.

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 25ed61f1b0899..6065daec69ba9 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1460,8 +1460,19 @@ static int mv_xor_probe(struct platform_device *pd=
ev)
>  	return ret;
>  }
> =20
> +static void mv_xor_remove(struct platform_device *pdev)
> +{
> +	struct mv_xor_device *xordev =3D platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i =3D 0; i < MV_XOR_MAX_CHANNELS; i++)
> +		if (xordev->channels[i])
> +			mv_xor_channel_remove(xordev->channels[i]);

[Severity: High]
Are we missing the teardown of the clock and IRQ mappings here?

Looking at the error path in mv_xor_probe(), we have explicit cleanup
for these resources:

drivers/dma/mv_xor.c:mv_xor_probe() {
...
err_channel_add:
    for (i =3D 0; i < MV_XOR_MAX_CHANNELS; i++)
        if (xordev->channels[i]) {
            mv_xor_channel_remove(xordev->channels[i]);
            if (pdev->dev.of_node)
                irq_dispose_mapping(xordev->channels[i]->irq);
        }

    if (!IS_ERR(xordev->clk)) {
        clk_disable_unprepare(xordev->clk);
        clk_put(xordev->clk);
    }
...
}

Does omitting clk_disable_unprepare(), clk_put(), and irq_dispose_mapping()
in mv_xor_remove() leak the clock reference and IRQ descriptors when the
driver is unbound?

[Severity: High]
This is a pre-existing issue, but calling mv_xor_channel_remove() here duri=
ng
unbind exposes a teardown sequence problem.

In mv_xor_channel_remove(), dma_free_wc() is called before free_irq(), and
there is no tasklet_kill() for the irq_tasklet:

drivers/dma/mv_xor.c:mv_xor_channel_remove() {
        ...
        dma_free_wc(dev, MV_XOR_POOL_SIZE,
                    mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
        ...
        free_irq(mv_chan->irq, mv_chan);

        return 0;
}

If an interrupt fires after dma_free_wc() but before free_irq(), the handler
can schedule the irq_tasklet which will access the freed descriptor pool.

Furthermore, without tasklet_kill(), a pending tasklet could execute after
mv_chan is freed by devres, resulting in a use-after-free.

Could this unbind sequence trigger these race conditions?

> +}
> +
>  static struct platform_driver mv_xor_driver =3D {
>  	.probe		=3D mv_xor_probe,
> +	.remove		=3D mv_xor_remove,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611210721.8197=
9-10-rosenp@gmail.com?part=3D1

