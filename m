Return-Path: <dmaengine+bounces-9598-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBaWKdNDwWnpRwQAu9opvQ
	(envelope-from <dmaengine+bounces-9598-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 14:44:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 446AF2F3388
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 978C7301DBAC
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42333AB29C;
	Mon, 23 Mar 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIxB7vn8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBE344D9A;
	Mon, 23 Mar 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273333; cv=none; b=YkDG7c3P5YSjqywpoe1mD5yLpq7YVU3WJ1S3xPYcinO0sOuM6ZgshnRqwAx+WoD9rlMTfGw2c0hBddXUh4PcdB3rkEUmgF6/eIp0bi2Cu/PeJoai9G7zW0auraSbIon3m6jC3ryNzaKi+bf2PkbARPJc3z9VxtokI3jdyWSaIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273333; c=relaxed/simple;
	bh=ZtPoRCkru0zgzMg1Dtr1KtTXqI/BbXwaUF7s9LHVs9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAi0xP2Y6j8XcceHQDElLFIvoYwd2UFV9cVaeip6du/EX0OhQKFKW5u3WkNH3lo+G1dTmlULBSSgZQqo66wz64oe6WjR03CCloAmvqhvS931SnA3CSCTXArsbrHZm7AhsDNX1VM6JebyAYurxtKpvmK6WYGwxHCsHrM+RC4+KEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIxB7vn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8C8C2BC9E;
	Mon, 23 Mar 2026 13:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273333;
	bh=ZtPoRCkru0zgzMg1Dtr1KtTXqI/BbXwaUF7s9LHVs9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIxB7vn8lilMCHPxPp+kxXTrecdLy1a7i2KTdVl3MMbLYSvrJVTyOCSfscdRkKN33
	 MCVYxvIfx2UPiEWZASusQSJ0bK67Y3D4sUd1r/Aj1ecHcsFFOROGx+xxJPwRVxhHJQ
	 hZiyy3CaMLMsRjh81BqYBWMfAGWCPCd+cBjNfZIMrByTtUeRZEllBttXO+yg055goV
	 XUWcLiHHgMYd5ePrUwlGkcQIW0yKROm7dH9ZoifRjCDabIRhAXPPAeJG4OG7W8zm5k
	 A934KPuhHN69KZgJbiXYoSEbjW49m/et+1nOeMto3lzz0GYpXBrMAaEonnllPUUEJZ
	 eFuG/V0t6QoXQ==
Date: Mon, 23 Mar 2026 19:11:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v13 05/12] dmaengine: qcom: bam_dma: add support for BAM
 locking
Message-ID: <5i4vef45tsr5oquo4kpdnydgnmmciprpzif3do5g5clfx3ny2e@tfjapk6haitq>
References: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
 <20260317-qcom-qce-cmd-descr-v13-5-0968eb4f8c40@oss.qualcomm.com>
 <hohx2judes5c6na4svpah254hqbaf4kbeyu7prwkprfv5dy7hj@26nxwlvb76yp>
 <CAMRc=McostnmVjE=uV=2KA7-dqLvQ2BAJYTXzANacFpPGgS+Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McostnmVjE=uV=2KA7-dqLvQ2BAJYTXzANacFpPGgS+Sw@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9598-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 446AF2F3388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:36:59PM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 23, 2026 at 10:35 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 03:02:12PM +0100, Bartosz Golaszewski wrote:
> > > Add support for BAM pipe locking. To that end: when starting DMA on an RX
> > > channel - prepend the existing queue of issued descriptors with an
> > > additional "dummy" command descriptor with the LOCK bit set. Once the
> > > transaction is done (no more issued descriptors), issue one more dummy
> > > descriptor with the UNLOCK bit.
> >
> > I've left some comments in v12, but looks like you've missed them.
> 
> Sorry for that, as I explained in private, this email did not end up
> in my inbox and I didn't see it on lore.
> 
> > >
> > > +static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, void *data, size_t len)
> > > +{
> > > +     struct bam_chan *bchan = to_bam_chan(desc->chan);
> > > +     const struct bam_device_data *bdata = bchan->bdev->dev_data;
> > > +     struct bam_desc_metadata *metadata = data;
> > > +
> > > +     if (!data)
> > > +             return -EINVAL;
> > > +
> > > +     if (!bdata->pipe_lock_supported)
> > > +             return -EOPNOTSUPP;
> >
> > As mentioned in v12, you should return 0 to avoid erroring out the clients if
> > pipe lock is not supported.
> >
> 
> If the client attaches the scratchpad register then it probably does
> want to use locking, right? On the other hand, I assume you're
> thinking about a situation where the client wants locking but BAM does
> not support it. It's unlikely but ok, I'll change it.
> 

Locking is supported only since v1.4.0. So I was trying to avoid erroring out
the clients wanting to use DMA on older platforms (pre 1.4.0). I'm not sure if
such platforms exist, but could be possible.

- Mani

> > >
> > > +static struct bam_async_desc *
> > > +bam_make_lock_desc(struct bam_chan *bchan, struct scatterlist *sg,
> > > +                struct bam_cmd_element *ce, unsigned long flag)
> > > +{
> > > +     struct dma_chan *chan = &bchan->vc.chan;
> > > +     struct bam_async_desc *async_desc;
> > > +     struct bam_desc_hw *desc;
> > > +     struct virt_dma_desc *vd;
> > > +     struct virt_dma_chan *vc;
> > > +     unsigned int mapped;
> > > +     dma_cookie_t cookie;
> > > +     int ret;
> > > +
> > > +     sg_init_table(sg, 1);
> > > +
> > > +     async_desc = kzalloc_flex(*async_desc, desc, 1, GFP_NOWAIT);
> > > +     if (!async_desc) {
> > > +             dev_err(bchan->bdev->dev, "failed to allocate the BAM lock descriptor\n");
> > > +             return NULL;
> > > +     }
> > > +
> > > +     async_desc->num_desc = 1;
> > > +     async_desc->curr_desc = async_desc->desc;
> > > +     async_desc->dir = DMA_MEM_TO_DEV;
> > > +
> > > +     desc = async_desc->desc;
> > > +
> > > +     bam_prep_ce_le32(ce, bchan->scratchpad_addr, BAM_WRITE_COMMAND, 0);
> > > +     sg_set_buf(sg, ce, sizeof(*ce));
> > > +
> > > +     mapped = dma_map_sg_attrs(chan->slave, sg, 1, DMA_TO_DEVICE, DMA_PREP_CMD);
> > > +     if (!mapped) {
> > > +             kfree(async_desc);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     desc->flags |= cpu_to_le16(DESC_FLAG_CMD | flag);
> > > +     desc->addr = sg_dma_address(sg);
> > > +     desc->size = sizeof(struct bam_cmd_element);
> > > +
> > > +     vc = &bchan->vc;
> > > +     vd = &async_desc->vd;
> > > +
> > > +     dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
> > > +     vd->tx.flags = DMA_PREP_CMD;
> > > +     vd->tx.desc_free = vchan_tx_desc_free;
> > > +     vd->tx_result.result = DMA_TRANS_NOERROR;
> > > +     vd->tx_result.residue = 0;
> > > +
> > > +     cookie = dma_cookie_assign(&vd->tx);
> > > +     ret = dma_submit_error(cookie);
> > > +     if (ret)
> > > +             return NULL;
> >
> > You are leaking async_desc here.
> >
> 
> Yeah, not only that but also should unmap the sg here too. Thanks.
> 
> > > +
> > > +     return async_desc;
> > > +}
> > > +
> > > +static int bam_do_setup_pipe_lock(struct bam_chan *bchan, bool lock)
> > > +{
> > > +     struct bam_device *bdev = bchan->bdev;
> > > +     const struct bam_device_data *bdata = bdev->dev_data;
> > > +     struct bam_async_desc *lock_desc;
> > > +     struct bam_cmd_element *ce;
> > > +     struct scatterlist *sgl;
> > > +     unsigned long flag;
> > > +
> > > +     lockdep_assert_held(&bchan->vc.lock);
> > > +
> > > +     if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
> > > +         bchan->slave.direction != DMA_MEM_TO_DEV)
> > > +             return 0;
> > > +
> > > +     if (lock) {
> > > +             sgl = &bchan->lock_sg;
> > > +             ce = &bchan->lock_ce;
> > > +             flag = DESC_FLAG_LOCK;
> > > +     } else {
> > > +             sgl = &bchan->unlock_sg;
> > > +             ce = &bchan->unlock_ce;
> > > +             flag = DESC_FLAG_UNLOCK;
> > > +     }
> > > +
> > > +     lock_desc = bam_make_lock_desc(bchan, sgl, ce, flag);
> > > +     if (!lock_desc)
> > > +             return -ENOMEM;
> > > +
> > > +     if (lock)
> > > +             list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
> > > +     else
> > > +             list_add_tail(&lock_desc->vd.node, &bchan->vc.desc_issued);
> > > +
> > > +     bchan->locked = lock;
> >
> > What is this flag for?
> >
> 
> Just a leftover. I'll drop it, thanks.
> 
> > >
> > > +struct bam_desc_metadata {
> > > +     phys_addr_t scratchpad_addr;
> >
> > I think it'd be worth adding a comment for this.
> >
> 
> Will do.
> 
> Bart

-- 
மணிவண்ணன் சதாசிவம்

