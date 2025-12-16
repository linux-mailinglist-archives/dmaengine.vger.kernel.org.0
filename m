Return-Path: <dmaengine+bounces-7673-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD09CC3E4C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D7A308BB26
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE23502A9;
	Tue, 16 Dec 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D28rT3n9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FE329E5B;
	Tue, 16 Dec 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897862; cv=none; b=YstLVBBEvDnb20bz4bpD82QkGTgPK53+wRYp2YBbICTWCrVHl++D2r81BR6vt/aiG40hY1Mq9Ub/1dj42USRg1VgDqaCwMZgY9Kw0wZo83rxlMAU/Ms+cbMFA69hIujHLk03QKY9duDVfHQAYHRoQrfnRMjZ5RD0fGfTfEnybTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897862; c=relaxed/simple;
	bh=0wUOhvNJfmtyqd/XorY2juPcs4vJJ/uawdDjV9JrIeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeCZtUL4MIlUpJZ3XxX7Zqa5F+WyDCJOEVyeTO78CGPNR4h5uDnB0yBpt/yPWrqZETQsxqlfImVQfTrkanAQAPEqLxxMM5P1XQdeX+hk9CH3dZJzgacZvOXkaloSY2bePBV3TDZG1fSWe/amlAAhVh4s+3sTA0Ql4iFb7zcF55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D28rT3n9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D93C4CEF1;
	Tue, 16 Dec 2025 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765897861;
	bh=0wUOhvNJfmtyqd/XorY2juPcs4vJJ/uawdDjV9JrIeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D28rT3n9BsdrjFbjDLVxceXWFhcNG6oWjyTtEhA5F2agEMD2XYsxjUgOE3VqeonBy
	 Vh4mset5E38dINz639V8ciWcs+6TQ4sDMvY0LS2bz4AjWNfpq5WDAtaD2naCoeyJg3
	 QFz1CoxLoNHrT19AK2Cqdr5f5kPn8psBzgSg4NyNy6fNja7wZBbsigV2GoJyBg12k4
	 JIJdWn6q/zm6QNXqibVglaDXO4PCuEFDRNX/x/2I08hbeBMBz2cNml60yHGWbqQlIY
	 NjjIw/r7Iy+T9DmmD+oytSU9pCoqmPDT8D0N1aKRkvjXcQJdTZqyaozn0CeQ58lgIJ
	 SeXmannxsGH7w==
Date: Tue, 16 Dec 2025 20:40:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Message-ID: <aUF2gj_0svpygHmD@vaman>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
 <aUFX14nz8cQj8EIb@vaman>
 <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>

On 16-12-25, 16:00, Bartosz Golaszewski wrote:
> On Tue, Dec 16, 2025 at 2:00 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 28-11-25, 12:44, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Use metadata operations in DMA descriptors to allow BAM users to pass
> > > additional information to the engine. To that end: define a new
> > > structure - struct bam_desc_metadata - as a medium and define two new
> > > commands: for locking and unlocking the BAM respectively. Handle the
> > > locking in the .attach() callback.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/dma/qcom/bam_dma.c       | 59 +++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/dma/qcom_bam_dma.h | 12 ++++++++
> > >  2 files changed, 70 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > > index c9ae1fffe44d79c5eb59b8bbf7f147a8fa3aa0bd..d1dc80b29818897b333cd223ec7306a169cc51fd 100644
> > > --- a/drivers/dma/qcom/bam_dma.c
> > > +++ b/drivers/dma/qcom/bam_dma.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/dma-mapping.h>
> > > +#include <linux/dma/qcom_bam_dma.h>
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/device.h>
> > >  #include <linux/platform_device.h>
> > > @@ -391,6 +392,8 @@ struct bam_chan {
> > >       struct list_head desc_list;
> > >
> > >       struct list_head node;
> > > +
> > > +     bool bam_locked;
> > >  };
> > >
> > >  static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
> > > @@ -655,6 +658,53 @@ static int bam_slave_config(struct dma_chan *chan,
> > >       return 0;
> > >  }
> > >
> > > +static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, void *data, size_t len)
> > > +{
> > > +     struct virt_dma_desc *vd = container_of(desc, struct virt_dma_desc, tx);
> > > +     struct bam_async_desc *async_desc = container_of(vd, struct bam_async_desc,  vd);
> > > +     struct bam_desc_hw *hw_desc = async_desc->desc;
> > > +     struct bam_desc_metadata *metadata = data;
> > > +     struct bam_chan *bchan = to_bam_chan(metadata->chan);
> > > +     struct bam_device *bdev = bchan->bdev;
> > > +
> > > +     if (!data)
> > > +             return -EINVAL;
> > > +
> > > +     if (metadata->op == BAM_META_CMD_LOCK || metadata->op == BAM_META_CMD_UNLOCK) {
> > > +             if (!bdev->dev_data->bam_pipe_lock)
> > > +                     return -EOPNOTSUPP;
> > > +
> > > +             /* Expecting a dummy write when locking, only one descriptor allowed. */
> > > +             if (async_desc->num_desc != 1)
> > > +                     return -EINVAL;
> > > +     }
> > > +
> > > +     switch (metadata->op) {
> > > +     case BAM_META_CMD_LOCK:
> > > +             if (bchan->bam_locked)
> > > +                     return -EBUSY;
> > > +
> > > +             hw_desc->flags |= DESC_FLAG_LOCK;
> >
> > Why does this flag imply for the hardware.

s/Why/What !
> 
> Please rephrase, I don't get what you mean.

I am trying to understand what the flag refers to and why do you need
this.. What is the problem that lock tries to solve

> >
> > I do not like the interface designed here. This is overloading. Can we
> > look at doing something better here.
> >
> 
> It used to be a generic flag in dmaengine visible for all users.
> Dmitry argued that it's too Qualcomm-specific for a generic flag and
> suggested using the metadata to hide the communication between the QCE
> and BAM drivers. I'm open to other suggestions but it has to be a bit
> more specific than "do something better". :)
> 
> Bartosz

-- 
~Vinod

