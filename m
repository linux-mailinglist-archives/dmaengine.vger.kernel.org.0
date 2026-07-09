Return-Path: <dmaengine+bounces-12211-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CUmILsauT2rSmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12211-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:23:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394B47322C6
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GLjA1UE3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12211-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12211-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2777325D982
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C42331EC4;
	Thu,  9 Jul 2026 14:11:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6252C029D
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:11:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606293; cv=none; b=F4Ni6fqqKJrd75bADdTYeNQxeElt7NHJAJ6YJdmyt1pVF663mSK+PYIFUeK5LHNPb6FVXxpKZdgosjXbf8MfohzrLq+Hb637IIhOF1Ix8mG4C/v3o1OUO8CKIGrvPHsK6KQd2j+/LQ7A/a+R/4FFxR07lZUxf8uDuP4/hm1t/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606293; c=relaxed/simple;
	bh=hV/F1beu/518CWUMUgEbPaWsw/NxYCjncgtM7MrlVIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K26aJwX5z9CCRMxlz7pbEg/Tfad3h2FBP2hNnvHIegPjssuQS5fVC6dMn0GpeKQ06Rjd1MJbKhWex1tVX+oiJuEGfjD820QVk7u01ompgTiQcojmZmO3sDv2s478IUCKtHhz2pEy/vomn9oDoqUo0YyxY1S4BScXgBSbkneiKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLjA1UE3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796011F00A3A;
	Thu,  9 Jul 2026 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606291;
	bh=XoCi73E3xYLoGT+XIsTHlA2yCnknfqd9Y9QogdSGIf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLjA1UE3cwip+hd4spsEGNvdyl3rgBgfRsoD5zjmOBqf5CjJQW+2pf6iGvMsx7saT
	 P80zIxeDXG0OnCrZ0dZvT4QLnAWJbe382h95A7iAVe02iwnlJXxisYXYz7H7g7JD/M
	 bE6MNL337WxY/HTpJk+sT7qglMcKjFGTVTxCGMReqC53WcoKKCEVZ18TD1fNqKlBE7
	 xrk4uNV/4wBJiRjBfHqYGtx/NXkCDJQpZ1FLpkY5e3LLCb+kZzvSy315WZ8VJnlcXf
	 vrhsaCaa0g+N/u/rwoYlDVWITt0JSQ/4RjDFpBFlJshlMd5amp4JkkULXyqF9Mbbw7
	 NmjIxrcVbjy4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/26] dmaengine: loongson-loongson1-apb-dma: Remove
 redundant dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-4-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-4-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:11:30 +0000
Message-Id: <20260709141131.796011F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12211-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,vivo.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 394B47322C6

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of devm-managed IRQ on error paths inside ls1x_dma=
_alloc_chan_resources() leading to persistent leaks.
- [High] Unsafe IRQF_SHARED handler lacks hardware status verification, ris=
king data corruption.
- [High] API violation: non-atomic readl_poll_timeout macro used in atomic =
context risks hard lockups.
- [High] Incorrect use of the logical sysfs channel device for DMA API oper=
ations and devres allocations.
- [High] Bypassing the devres unregister mechanism causes a Use-After-Free =
and resource leaks.
- [High] Memory for the DMA descriptor is leaked if scatterlist allocation =
fails in ls1x_dma_prep_dma_cyclic().
--

--- Patch [3]: [PATCH 03/26] dmaengine: loongson-loongson1-apb-dma: Remove =
redundant dev_err()/dev_err_probe() ---
commit cc0e2dcbd30ac2febb8a1c6ef2b34cbde416aa33
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: loongson-loongson1-apb-dma: Remove redundant dev_err()/dev_err_p=
robe()

This commit removes redundant dev_err() calls when devm_request_irq() fails=
 in
ls1x_dma_alloc_chan_resources(). Since devm_request_irq() logs its own deta=
iled
error messages, the driver-specific messages are no longer needed.

> diff --git a/drivers/dma/loongson/loongson1-apb-dma.c b/drivers/dma/loong=
son/loongson1-apb-dma.c
> index 89786cbd20ab5..812bd7c2068f9 100644
> --- a/drivers/dma/loongson/loongson1-apb-dma.c
> +++ b/drivers/dma/loongson/loongson1-apb-dma.c
> @@ -162,10 +162,8 @@ static int ls1x_dma_alloc_chan_resources(struct dma_=
chan *dchan)
> =20
>  	ret =3D devm_request_irq(dev, chan->irq, ls1x_dma_irq_handler,
>  			       IRQF_SHARED, dma_chan_name(dchan), chan);
> -	if (ret) {
> -		dev_err(dev, "failed to request IRQ %d\n", chan->irq);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	chan->lli_pool =3D dma_pool_create(dma_chan_name(dchan), dev,
>  					 sizeof(struct ls1x_dma_lli),
>  					 __alignof__(struct ls1x_dma_lli), 0);
>  	if (!chan->lli_pool)
>  		return -ENOMEM;
> =20
>  	/* allocate memory for querying the current lli */
>  	dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>  	chan->curr_lli =3D dma_alloc_coherent(dev, sizeof(struct ls1x_dma_lli),
>  					    &phys, GFP_KERNEL);
>  	if (!chan->curr_lli) {
>  		dma_pool_destroy(chan->lli_pool);
>  		return -ENOMEM;
>  	}

[Severity: High]
This is a pre-existing issue, but is the devm-managed IRQ leaked on this
error path?

If dma_pool_create() or dma_alloc_coherent() fails, we return -ENOMEM witho=
ut
freeing the IRQ requested via devm_request_irq().=20

The devm-managed cleanup won't happen because the channel's sysfs device is=
 not
destroyed, leading to local clients hitting -EBUSY on subsequent allocation
attempts.

[ ... ]

> static inline struct device *chan2dev(struct dma_chan *chan)
> {
> 	return &chan->dev->device;
> }

[Severity: High]
This isn't a bug introduced by this patch, but should this helper be return=
ing
the hardware platform device instead?

This macro returns the logical sysfs channel device instead of the hardware
platform device (dchan->device->dev). Passing this logical device to DMA API
operations like dma_alloc_coherent() or dma_pool_create() can cause allocat=
ion
failures or incorrect mappings on platforms with strict DMA tracking or an
IOMMU.

[ ... ]

> static inline int ls1x_dma_start(struct ls1x_dma_chan *chan,
> 				 dma_addr_t *lli_phys)
> {
[ ... ]
> 	ret =3D readl_poll_timeout(chan->reg_base + LS1X_DMA_CTRL, val,
> 				 !(val & LS1X_DMA_START), 0, 1000);

[Severity: High]
This is a pre-existing issue, but does using readl_poll_timeout() here risk
hard lockups?

ls1x_dma_start() is called from ls1x_dma_resume() and ls1x_dma_issue_pendin=
g()
with the channel's lock held and interrupts disabled:

ls1x_dma_resume()
    guard(spinlock_irqsave)(&chan->vc.lock);
    return ls1x_dma_start(chan, &chan->curr_lli->phys);

Using the non-atomic readl_poll_timeout() macro in an atomic context is uns=
afe
because timekeeping might be suspended, causing the internal ktime_get() to
stall or return invalid values.

[ ... ]

> static struct dma_async_tx_descriptor *
> ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
[ ... ]
> 	desc =3D ls1x_dma_alloc_desc();
> 	if (!desc)
> 		return NULL;
>=20
> 	/* allocate the scatterlist */
> 	sg_len =3D buf_len / period_len;
> 	sgl =3D kmalloc_objs(*sgl, sg_len, GFP_NOWAIT);
> 	if (!sgl)
> 		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but what happens to the allocated
descriptor if kmalloc_objs() fails?

If we fail to allocate the scatterlist, the function returns NULL without
freeing the desc allocated just above it, resulting in a memory leak.

[ ... ]

> static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
> {
[ ... ]
> 	scoped_guard(spinlock, &chan->vc.lock) {
> 		vd =3D vchan_next_desc(&chan->vc);
> 		if (!vd) {
> 			dev_warn(dev,
> 				 "IRQ %d with no active desc on channel %d\n",
> 				 irq, dchan->chan_id);
> 			return IRQ_NONE;
> 		}

[Severity: High]
This is a pre-existing issue, but is it safe for a shared IRQ handler to
assume ownership of the interrupt without checking hardware status?

The handler is registered with IRQF_SHARED, but it processes active descrip=
tors
purely based on whether one is queued in software. If another device sharing
the IRQ line triggers an interrupt, this could prematurely complete the cur=
rent
in-flight DMA transfer and cause data corruption.

[ ... ]

> static void ls1x_dma_chan_remove(struct ls1x_dma *dma)
> {
> 	int id;
>=20
> 	for (id =3D 0; id < dma->nr_chans; id++) {
> 		struct ls1x_dma_chan *chan =3D &dma->chan[id];
>=20
> 		if (chan->vc.chan.device =3D=3D &dma->ddev) {
> 			list_del(&chan->vc.chan.device_node);
> 			tasklet_kill(&chan->vc.task);
> 		}
> 	}
> }

[Severity: High]
This isn't a bug introduced by this patch, but will deleting the channel fr=
om
the list here bypass the devres unregister mechanism?

During module removal or probe failure, manually calling list_del() orphans
the channel from the dmaengine core. When devres later runs
dma_async_device_unregister(), it iterates over an empty list and fails to
unregister the channels.

This permanently leaks the sysfs channel devices and percpu memory, and will
trigger a Use-After-Free when the underlying struct ls1x_dma is freed by
devm_kzalloc cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D3

