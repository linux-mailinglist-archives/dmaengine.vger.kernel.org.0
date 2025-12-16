Return-Path: <dmaengine+bounces-7670-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D30CC3DA8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C300E30FBD53
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6F533A9C2;
	Tue, 16 Dec 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuyH9lFr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A5339872
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897266; cv=none; b=Q6RxVqOVzvrJMz11H3qAYoQPnTNAD3MjSxKYaIv+pcQeknAvVYdHvV4o5Xu0T4nfb4OBGScX6hoaDcxwmfoP2be5fTa7bX0vuXfjcstP2XTgjVVFEU2TO4wEflVV2LMBlBXVQCjqlyxl+93oyEjuSs40cNfE3QKN80eegBppH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897266; c=relaxed/simple;
	bh=QPKsKeT3gWgGX03dpUV6lwGL3b/wOT3vbrntiwSEOXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzaEUaJGSx//sPbtRjh9uyJzX/hYywLMJeQrLBSkQipRnQGmZkcNhPO785nJ9nkzv0fyhWavwYrIw6CQh3gNpy44Wr/SNN/Cpx+Pkbk1+Kyh5JFdlER5QVHifEMVjTWSMpwoHqRoEvWGWUmZ9FMYN9Xryvz5TmR7TC7ZI1J4tAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuyH9lFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23514C4CEF1
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765897266;
	bh=QPKsKeT3gWgGX03dpUV6lwGL3b/wOT3vbrntiwSEOXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nuyH9lFr0HElGTm11ozrGEh5GR4mrOxDjzSYPKWiUTV0KViG4zo5T3wFNuCyjUrck
	 LTGWRJD0olCd3ufg1jL1nS1IGG4PPujLwAHClCa47IBYFpOH8MG5yrSJGE2l6aCwcD
	 X5kS0WB6zf9QC9bf3Rgxop6JM0WX3rjubhvvA5bNOzxuUnfGUPLLklnnp5oaZ4YOgM
	 EFU7ZQN0GqIwHD9w/wYky4rfuPW/B83eKO8BXMo1JrTZInJVVqFSBSnueibSeqJImH
	 UGiuVd7I1tW9krQWVUgR9YlCtNupr3d3/zw1wD5xO1+QDghcoNZGXzGnP2s5QI2Yy2
	 NEKnH7RCptepQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5945510fd7aso4011526e87.0
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 07:01:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoy3iw0jUA7kwULhkH4rHik3YK133CzOFti8nQCzyDSseYGISTC31ymgTcrPvwUHEcfKn5V+7A0Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAzrmtnCzNhsm29blBjfBkyhnuV6/U5BTxvPRbQxA916WHBGk
	onhcUD7j3CG+CDzCBwVkUFmstnwG3vRrlmIpbgbcXkHv+GzYry3rdb8TcYA3DMfV/rNxJSSDSiR
	qEuoBT5/cL+Ky4rGCoIFvc6ZvsMYIvTYewrXlA4s9dw==
X-Google-Smtp-Source: AGHT+IG5d6DdYq9LAyVUP18St0s5pfnMgnJzNUjAA/NoQAsSm6+L4uBAJHyDNUiXdMopypVt3tNMTw9B+D8JE4f0jrI=
X-Received: by 2002:a05:6512:23a0:b0:595:910c:8ee9 with SMTP id
 2adb3069b0e04-598faa876f8mr4651161e87.37.1765897264824; Tue, 16 Dec 2025
 07:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org> <aUFX14nz8cQj8EIb@vaman>
In-Reply-To: <aUFX14nz8cQj8EIb@vaman>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 16 Dec 2025 16:00:51 +0100
X-Gmail-Original-Message-ID: <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
X-Gm-Features: AQt7F2rrGRpQXYPK-EvVzXEKVsCh-nkChR-L4QKbJkBv4BRnBUz63CKwNYJ04mc
Message-ID: <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
To: Vinod Koul <vkoul@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Udit Tiwari <quic_utiwari@quicinc.com>, Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 2:00=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 28-11-25, 12:44, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use metadata operations in DMA descriptors to allow BAM users to pass
> > additional information to the engine. To that end: define a new
> > structure - struct bam_desc_metadata - as a medium and define two new
> > commands: for locking and unlocking the BAM respectively. Handle the
> > locking in the .attach() callback.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/dma/qcom/bam_dma.c       | 59 ++++++++++++++++++++++++++++++++=
+++++++-
> >  include/linux/dma/qcom_bam_dma.h | 12 ++++++++
> >  2 files changed, 70 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index c9ae1fffe44d79c5eb59b8bbf7f147a8fa3aa0bd..d1dc80b29818897b333cd22=
3ec7306a169cc51fd 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/dma/qcom_bam_dma.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/device.h>
> >  #include <linux/platform_device.h>
> > @@ -391,6 +392,8 @@ struct bam_chan {
> >       struct list_head desc_list;
> >
> >       struct list_head node;
> > +
> > +     bool bam_locked;
> >  };
> >
> >  static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
> > @@ -655,6 +658,53 @@ static int bam_slave_config(struct dma_chan *chan,
> >       return 0;
> >  }
> >
> > +static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, v=
oid *data, size_t len)
> > +{
> > +     struct virt_dma_desc *vd =3D container_of(desc, struct virt_dma_d=
esc, tx);
> > +     struct bam_async_desc *async_desc =3D container_of(vd, struct bam=
_async_desc,  vd);
> > +     struct bam_desc_hw *hw_desc =3D async_desc->desc;
> > +     struct bam_desc_metadata *metadata =3D data;
> > +     struct bam_chan *bchan =3D to_bam_chan(metadata->chan);
> > +     struct bam_device *bdev =3D bchan->bdev;
> > +
> > +     if (!data)
> > +             return -EINVAL;
> > +
> > +     if (metadata->op =3D=3D BAM_META_CMD_LOCK || metadata->op =3D=3D =
BAM_META_CMD_UNLOCK) {
> > +             if (!bdev->dev_data->bam_pipe_lock)
> > +                     return -EOPNOTSUPP;
> > +
> > +             /* Expecting a dummy write when locking, only one descrip=
tor allowed. */
> > +             if (async_desc->num_desc !=3D 1)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     switch (metadata->op) {
> > +     case BAM_META_CMD_LOCK:
> > +             if (bchan->bam_locked)
> > +                     return -EBUSY;
> > +
> > +             hw_desc->flags |=3D DESC_FLAG_LOCK;
>
> Why does this flag imply for the hardware.

Please rephrase, I don't get what you mean.

>
> I do not like the interface designed here. This is overloading. Can we
> look at doing something better here.
>

It used to be a generic flag in dmaengine visible for all users.
Dmitry argued that it's too Qualcomm-specific for a generic flag and
suggested using the metadata to hide the communication between the QCE
and BAM drivers. I'm open to other suggestions but it has to be a bit
more specific than "do something better". :)

Bartosz

