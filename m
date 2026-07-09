Return-Path: <dmaengine+bounces-12233-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OLZAN/S2T2q5nAIAu9opvQ
	(envelope-from <dmaengine+bounces-12233-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:57:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A397328BD
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:57:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RB8PBTLH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12233-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12233-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE965319DDE4
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DCC331EC4;
	Thu,  9 Jul 2026 14:35:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A22A331EDB;
	Thu,  9 Jul 2026 14:35:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607712; cv=none; b=pPK+nFCLcNSVqzfZKG373wyeiCjNxSFOx/8ZZfx2FHB5dwu1EFP8otINJHe0DuywHd1pZ8y5Csf5iG2mWW/kV7eONmXG3Mc0nPToJ7KtgXt6N2T361mLc1VVlou2FhBJueTuV4eI07EPO5z4EZyfF+1TWymjMqMlgHkWYLuppAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607712; c=relaxed/simple;
	bh=oRFC9pu2NxDmbXCh/isTQ0wlAkDALwgkurJCM+OY20E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bkXEezjRSqLhdbW7enRR01MjF+N8NoQTLkHzT6F/xklUYd6Ca/YtqrF+T6IFurZZEPdvrKSYArX+gTDeerd9glZBOjGQLaPVLRuJjndoIQkAKzGaDBMeIw8NbkTrsVXn7EjcRL/Xj8Rif5wE4mbODvu+IGySUe1w9Kn7lIlM3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB8PBTLH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A241F000E9;
	Thu,  9 Jul 2026 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607711;
	bh=JagGdoZ9syEEXetxGLY0LKmvc8TwoXpKnxQ4W4MEkys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RB8PBTLHgmnXnyqx3AFWb1YbAmc7Rt41PR2TfrwWX2HZmmRoDDFr2a+cWoY4XIy5Z
	 xOxTYZ7bRh2LAOhtBDnJEttqj1LhABfhp3ibltSMjhOLp0B17Z9bC+VV8TAgH5U651
	 2qCLi/0+8Y6uOsZSRVyQ4gNXG5+fF+6LdFYXoooW7Bp2+Lh5bjeIS1idrYPHBkJsww
	 Ulrw+gzTK0wIOlhbze1oVQo0PgOgJjLTXuuyiUsLEWiU9MXCmf6NVKdn7vuHpAnI9X
	 tld3SWdyIMXEicBJ8eEeUJQv6kobpO+diLyc7pOgDiNDh5FSOUhUIV/FZ0diobYguQ
	 NHpxl5aETcdnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/26] dmaengine: sun4i-dma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-22-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-22-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:35:10 +0000
Message-Id: <20260709143510.A5A241F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12233-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,vivo.com:email,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:linux-sunxi@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40A397328BD

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing tasklet_kill() for virtual DMA channels in device teardown=
 (remove and probe error paths) leads to Use-After-Free.
- [High] Ongoing DMA hardware transfers are not gracefully stopped in sun4i=
_dma_remove() before clock disable.
- [High] Race condition between sun4i_dma_interrupt() and sun4i_dma_termina=
te_all() leads to NULL pointer dereference and Use-After-Free.
- [Medium] Incorrect DMA residue calculation in sun4i_dma_tx_status() for q=
ueued (unstarted) contracts.
- [Low] sun4i_dma_of_xlate() strictly validates against hardcoded max DRQ t=
ype limits rather than the SoC-specific config.
--

--- Patch [21]: [PATCH 21/26] dmaengine: sun4i-dma: Remove redundant dev_er=
r()/dev_err_probe() ---
commit 0e16200d5dd839cadb8ffc88ed67f75051cff988
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: sun4i-dma: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index d2321f7287d20..303d71ba0ab61 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -1337,7 +1337,7 @@ static int sun4i_dma_probe(struct platform_device *=
pdev)
>  	ret =3D devm_request_irq(&pdev->dev, priv->irq, sun4i_dma_interrupt,
>  			       0, dev_name(&pdev->dev), priv);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "Cannot request IRQ\n");
> +		return ret;
> =20
>  	ret =3D dmaenginem_async_device_register(&priv->slave);
>  	if (ret)

[Severity: High]
This is a pre-existing issue, but does driver unbind safely tear down
the virtual channels?

drivers/dma/sun4i-dma.c:sun4i_dma_remove() {
    struct sun4i_dma_dev *priv =3D platform_get_drvdata(pdev);

    /* Disable IRQ so no more work is scheduled */
    disable_irq(priv->irq);

    of_dma_controller_free(pdev->dev.of_node);
}

If the driver is unbound while an interrupt has scheduled a tasklet,
dma_async_device_unregister() called by devres will free the DMA channels
and the associated priv->vchans memory.

Since there is no tasklet_kill(&vchan->vc.task) call to cancel pending
tasklets, could the scheduled tasklet execute after the memory is freed
and cause a use-after-free?


[Severity: High]
This is another pre-existing issue in the same function, but does this
safely stop active DMA transfers?

drivers/dma/sun4i-dma.c:sun4i_dma_remove() {
    struct sun4i_dma_dev *priv =3D platform_get_drvdata(pdev);

    /* Disable IRQ so no more work is scheduled */
    disable_irq(priv->irq);

    of_dma_controller_free(pdev->dev.of_node);
}

If the driver is unbound while a DMA transfer is actively executing, the
hardware configuration registers are not cleared to halt the channels.

When devres subsequently disables the DMA controller's clock mid-transactio=
n,
can this forcefully lock up the AXI/AHB bus or corrupt memory?


[Severity: High]
This is a pre-existing issue, but is there a race condition between the
interrupt handler and channel termination?

drivers/dma/sun4i-dma.c:sun4i_dma_interrupt() {
    ...
    contract =3D vchan->contract;

    /*
     * Disable the IRQ and free the pchan if it's an end
     * interrupt (odd bit)
     */
    if (bit & 1) {
        spin_lock(&vchan->vc.lock);

        /*
         * Move the promise into the completed list now that
         * we're done with it
         */
        list_move_tail(&vchan->processing->list,
                       &contract->completed_demands);
    ...
}

The contract pointer is read before acquiring vchan->vc.lock. Concurrently,
sun4i_dma_terminate_all() on another CPU could acquire the lock, set
vchan->processing to NULL, free the active contract, and release the lock.

When sun4i_dma_interrupt() subsequently acquires the lock, it performs a
list_move_tail() using vchan->processing->list.

Could this cause a guaranteed NULL pointer dereference since
vchan->processing would be NULL, as well as a use-after-free when accessing
the freed contract structure?


[Severity: Medium]
This is a pre-existing issue, but does this calculate the residue correctly
for queued contracts?

drivers/dma/sun4i-dma.c:sun4i_dma_tx_status() {
    ...
    promise =3D list_first_entry_or_null(&contract->demands,
                                       struct sun4i_dma_promise, list);
    if (promise && pchan) {
        bytes -=3D promise->len;
        if (pchan->is_dedicated)
            bytes +=3D readl(pchan->base + SUN4I_DDMA_BYTE_COUNT_REG);
        else
            bytes +=3D readl(pchan->base + SUN4I_NDMA_BYTE_COUNT_REG);
    }
    ...
}

If vchan_find_desc() returns a pending, unstarted contract, and the virtual
channel is currently executing a different contract on a physical channel,
this code unconditionally assumes the hardware byte count belongs to the
queried contract.

By subtracting the queried contract's promise length and adding the executi=
ng
contract's hardware residue, can this return corrupted residue values for
queued transfers?


[Severity: Low]
This is a pre-existing issue, but does the validation correctly restrict
endpoints on all SoC variants?

drivers/dma/sun4i-dma.c:sun4i_dma_of_xlate() {
    ...
    /* Make sure the endpoint looks sane */
    if ((is_dedicated && endpoint >=3D SUN4I_DDMA_DRQ_TYPE_LIMIT) ||
        (!is_dedicated && endpoint >=3D SUN4I_NDMA_DRQ_TYPE_LIMIT))
        return NULL;
    ...
}

The validation uses hardcoded limits like SUN4I_DDMA_DRQ_TYPE_LIMIT (32)
regardless of the SoC variant.

If a device tree requests an endpoint of 20 on a suniv_f1c100s device, which
has a limit of 10, would this bypass the check and program out-of-bounds
DRQ indices into the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D21

