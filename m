Return-Path: <dmaengine+bounces-8002-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33BCEF0A5
	for <lists+dmaengine@lfdr.de>; Fri, 02 Jan 2026 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1A0D30021EA
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jan 2026 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B422836B1;
	Fri,  2 Jan 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qutM4XzB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F503176ADE
	for <dmaengine@vger.kernel.org>; Fri,  2 Jan 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374057; cv=none; b=idwqfnPSHHEImuTS+v35uuzcL+w1KrVBLphjZboJ0Gw1VNIseprR5daeMELujZItQxViiMc8dxQQRW76Vr3h1AUELIO7cyU/0y3Drf2N4MBSCnQr6mywa4FIKG5g+jsxX6vU2N78i0N40EtfMqvKgwpWuKu1Ejv3h67ZQLaHTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374057; c=relaxed/simple;
	bh=R6dmOb7p8xJel1QxDvWRfkmJfdH87GHXzodWhp+pqzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWo2ug00bWjWYUwi460stnz+3dAavnzXCYsJv37jXxcrOKxGy79fiGDmPlk/gKfdz/sTv3lsH7POo6XnEagyB1Z7AUgPfhfsYSQq5pjZP8w9DuK3ZCl6ydRjcV0oNhqVTbVSG3Y61dBc5iwG2v6AKaYuX1Nvgqv8zQo6Z+xFpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qutM4XzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B88C19424
	for <dmaengine@vger.kernel.org>; Fri,  2 Jan 2026 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767374057;
	bh=R6dmOb7p8xJel1QxDvWRfkmJfdH87GHXzodWhp+pqzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qutM4XzBI043D7B/jJARhLR2e5HfrWl/uOdrZ9Xi4USlB7OQU/Yt3yqy+8hrB4O6X
	 z4i/sUoO1X+ypn2NJ74rppttl9J4VKOqujDw3QM4O5jBHuh7OjAAFlPDC8a0vaNc4K
	 FLz1bXc393A8RxFUfpSg6FUfa9pQnfNfNceecwU2qPhzM1aO9dFeUVBmAN5rPMyCmb
	 N9DIcoklGZsv0Zg9qpo+ZCei7TeoEjj/H15mx+49EoUTgTj10EGoQD9/G/rzS4ZG7w
	 M8XBZr1L2TQNuWP9a8mAw2SGZl8mR/MnZnLqmKdcJ7+V0xdKvNZP3Dw2XF6BYjTeuh
	 NvbSIJY9ZMyOA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5958931c9c7so13998618e87.2
        for <dmaengine@vger.kernel.org>; Fri, 02 Jan 2026 09:14:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQAxhwZ+Kr3rrlU6i14h4t2VSHbOzDJg2XyvWUC8JOr1H9jyVF8G93XXR313/+0wKaYkPiJk2ZucY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywss7vYlJAQIm7xPkEMopwdNL/sk2rZGzl6HB+Pf+nuWVsockZY
	k5TRcfvqK9VdhrSylryKC/NVeMmqvwqfRz+Q7JQLV67xCvplW1zGWlI4R4FbHyxZthBOQNX8v0N
	lY6aQuaMl7+cQJowrM8AWEoIYfvrOzn0WNzrtUHRiLQ==
X-Google-Smtp-Source: AGHT+IHV2zByoLl6AUOgy1s7wJzSUumpVgbYasCQ8jZfLwQVGm88Ij0ul2K30P8OfX5b1FsgpDShkqlq2bAFvN8YTbU=
X-Received: by 2002:a05:6512:3f09:b0:595:81c1:c55 with SMTP id
 2adb3069b0e04-59a17d74426mr16156505e87.8.1767374055558; Fri, 02 Jan 2026
 09:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
 <aUFX14nz8cQj8EIb@vaman> <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman> <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman> <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman> <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman>
In-Reply-To: <aVf5WUe9cAXZHxPJ@vaman>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 18:14:02 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
X-Gm-Features: AQt7F2o_SWu6QkybNXv1EzXBF2ZAUPo7cvQ3Ie-kbYTBiaz38B4U0n86nK8RvVg
Message-ID: <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
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

On Fri, Jan 2, 2026 at 5:59=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 02-01-26, 10:26, Bartosz Golaszewski wrote:
> > On Thu, Jan 1, 2026 at 1:00=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wr=
ote:
> > >
> > > > >
> > > > > > It will perform register I/O with DMA using the BAM locking mec=
hanism
> > > > > > for synchronization. Currently linux doesn't use BAM locking an=
d is
> > > > > > using CPU for register I/O so trying to access locked registers=
 will
> > > > > > result in external abort. I'm trying to make the QCE driver use=
 DMA
> > > > > > for register I/O AND use BAM locking. To that end: we need to p=
ass
> > > > > > information about wanting the command descriptor to contain the
> > > > > > LOCK/UNLOCK flag (this is what we set here in the hardware desc=
riptor)
> > > > > > from the QCE driver to the BAM driver. I initially used a globa=
l flag.
> > > > > > Dmitry said it's too Qualcomm-specific and to use metadata inst=
ead.
> > > > > > This is what I did in this version.
> > > > >
> > > > > Okay, how will client figure out should it set the lock or not? W=
hat are
> > > > > the conditions where the lock is set or not set by client..?
> > > > >
> > > >
> > > > I'm not sure what you refer to as "client". The user of the BAM eng=
ine
> > > > - the crypto driver? If so - we convert it to always lock/unlock
> > > > assuming the TA *may* use it and it's better to be safe. Other user=
s
> > > > are not affected.
> > >
> > > Client are users of dmaengine. So how does the crypto driver figure o=
ut
> > > when to lock/unlock. Why not do this always...?
> > >
> >
> > It *does* do it always. We assume the TA may be doing it so the crypto
> > driver is converted to *always* perform register I/O with DMA *and* to
> > always lock the BAM for each transaction later in the series. This is
> > why Dmitry inquired whether all the HW with upstream support actually
> > supports the lock semantics.
>
> Okay then why do we need an API?
>
> Just lock it always and set the bits in the dma driver
>

We need an API because we send a locking descriptor, then a regular
descriptor (or descriptors) for the actual transaction(s) and then an
unlocking descriptor. It's a thing the user of the DMA engine needs to
decide on, not the DMA engine itself.

Also: only the crypto engine needs it for now, not all the other users
of the BAM engine.

Bartosz

