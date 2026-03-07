Return-Path: <dmaengine+bounces-9318-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kImUEJ2LrGnCqgEAu9opvQ
	(envelope-from <dmaengine+bounces-9318-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 21:33:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6AA22D824
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 21:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3528330151F4
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2026 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC14F2BF3D7;
	Sat,  7 Mar 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lajtb8PL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABF1E51E0;
	Sat,  7 Mar 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772915607; cv=none; b=rJRhQb0jawRNevpubNK8QS99ZJgcRKIenDvUn7G08MApzArAyLTEErMT1wZyzzxCwJcrYAb33B8Ybd+Qh4W93MLyslLoZ8OSrn7w5TSLZAgcQYimgO2PkVJqlLRkl04ajEMVdXnu5K5q7Kxao5P0MbMmPM6vGBCLNiiv7rBpJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772915607; c=relaxed/simple;
	bh=31nT2idXq0b+j8ZBcxl0zy3PJn21/46lvsAvq0uSrZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PACV+6aWlp/E4Ij7M5Z5nvAWZ2FsilMWnb/KNbxKuq06aQZO80XCDSLd2OQrxo2ol/XGbPjHCUxJBf7TzYYFVYu6ViJTBzBRTTAHchk4oj8jDNsU2EvygIFxxNsR0Il+r96VoRb3RAPl1uZudiE1fFVmPuT1ZRcoxPre5qKe6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lajtb8PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B8EC19422;
	Sat,  7 Mar 2026 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772915607;
	bh=31nT2idXq0b+j8ZBcxl0zy3PJn21/46lvsAvq0uSrZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lajtb8PLKfTECoMV48do6LFXGQr0OLrEVgYDwGomgZjaA/+vYMBq5DJk3TKH0yf09
	 8umviV+NpV9V8KosVu1u29DMjDUppkt7HEMYplUgw2w1aLHiTUZcKrU6i4XhiPQ2Oo
	 Ly4i1BSLRHKur85eP2SdyITkSaRvBi7N8GctW5ystyxuWH37lpNvt6833CF768WChW
	 n1LaFhHwBDrVHqAbzyhZYpYMbmd7QJhPuoJD1fx5oQRXUFxbmMgmNx/QAIJ9c9lCfC
	 9S3ku7+aOCkycsqyVHMIOmAMBklTpvbB1nm+IH2tBqCgVsQxWsQexuOJ6fp3AAwotS
	 vRBzbTcMeHFBg==
Date: Sun, 8 Mar 2026 02:03:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFC v11 12/12] dmaengine: qcom: bam_dma: add support for
 BAM locking
Message-ID: <aayLkmDRLMuTzXZv@vaman>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <20260302-qcom-qce-cmd-descr-v11-12-4bf1f5db4802@oss.qualcomm.com>
 <aahHeR9j7q4_ynYK@vaman>
 <CAMRc=Mc48+NyMPkFRa8GPv-odCe=r9WXJWUZYkTsaY53Ev_stQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc48+NyMPkFRa8GPv-odCe=r9WXJWUZYkTsaY53Ev_stQ@mail.gmail.com>
X-Rspamd-Queue-Id: DC6AA22D824
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9318-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,amd.com,vger.kernel.org,lists.infradead.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 04-03-26, 16:27, Bartosz Golaszewski wrote:
> On Wed, Mar 4, 2026 at 3:53 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 02-03-26, 16:57, Bartosz Golaszewski wrote:
> > > Add support for BAM pipe locking. To that end: when starting the DMA on
> > > an RX channel - wrap the already issued descriptors with additional
> > > command descriptors performing dummy writes to the base register
> > > supplied by the client via dmaengine_slave_config() (if any) alongside
> > > the lock/unlock HW flags.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> [snip]
> 
> > > +static struct bam_async_desc *
> > > +bam_make_lock_desc(struct bam_chan *bchan, struct scatterlist *sg,
> > > +                struct bam_cmd_element *ce, unsigned int flag)
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
> > > +     bam_prep_ce_le32(ce, bchan->slave.dst_addr, BAM_WRITE_COMMAND, 0);
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
> >
> > I am not sure I understand this.
> >
> > At start you add a descriptor in the queue, ideally which should be
> > queued after the existing descriptors are completed!
> >
> > Also I thought you want to append Pipe cmd to descriptors, why not do
> > this while preparing the descriptors and add the pipe cmd and start and
> > end of the sequence when you prepare... This was you dont need to create
> > a cookie like this
> >
> 
> Client (in this case - crypto engine) can call
> dmaengine_prep_slave_sg() multiple times adding several logical
> descriptors which themselves can have several hardware descriptors. We
> want to lock the channel before issuing the first queued descriptor
> (for crypto: typically data descriptor) and unlock it once the final
> descriptor is processed (typically command descriptor). To that end:
> we insert the dummy command descriptor with the lock flag at the head
> of the queue and the one with the unlock flag at the tail - "wrapping"
> the existing queue with lock/unlock operations.

Why not do this per prep call submitted to the engine. It would be
simpler to just add lock and unlock to the start and end of transaction.

-- 
~Vinod

