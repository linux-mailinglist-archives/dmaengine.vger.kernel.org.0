Return-Path: <dmaengine+bounces-7756-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071DCC8333
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A39353007B40
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BE33A3F0C;
	Wed, 17 Dec 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUPo9bFt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C23A4EAD
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981914; cv=none; b=D2pq6KvG6yZ5LHh3Ru02hfxkwGbu+mDmlBaYXzzR7ZiOsWC0SLfQGsTKaGQVnJfmyezZ6CUO8RZbZ/1snnVi/Di0e9YUMV6M64ULOPvQDyL1xu2phxxN81lyEWYWzAPqqH2rF6hUENMIzX2urL0elbRTVuARENGx40ql8dhF18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981914; c=relaxed/simple;
	bh=Twvbew+EhoTVlmKoPOFwDPUMzhThCCuzjaszlgaYBqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjslqtI4/ZqfQEspwaXFogcvcDPjlKz19wC3UM7iTcnB8Nj+6gHcZ8piorGF6+xVQNUqpUDgoCi71G+5wn2yM8SA2UfVISEgRn4KzAw5fyvX5YIZSMaW+vtH7qaPLYK5GflLS2X2K25VrmqBv2U8cWbxKB7P1XDQiTVWb3AlNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUPo9bFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4ACC19425
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765981914;
	bh=Twvbew+EhoTVlmKoPOFwDPUMzhThCCuzjaszlgaYBqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RUPo9bFtc96/qXYttmLuf5b2qJRGG2AEJHKICzMNGyHzZMwsja+c39Yj9G356lzxX
	 xqGXEk7Ax1orqqJ8BM69cGPm/fmDohioKToeDpqlTCTG9m1quei6TEbbGz2XMlOKtf
	 3D2x3OcIQuVToEipBXOymcsvk2Tgp/ClTTqbTxRf6Y6cz0d9jZH2+aq/3OzrG+Gyb0
	 5WLrcC7+RwVJAE1mGSDtJmh1sslJsCwqHeh/xTmZb5/1SaTpp7QHdA4Z18L02JIGJ6
	 fjhdccF+3SoRL/mEgmz4/IXXe667wsTIEE0dtOSewDZ4Q9zIAd+rN9jX7vveAvRYyx
	 bXpRu8HDvLylQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-595910c9178so4775413e87.1
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 06:31:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfkgRBq20njQQIBdNy64pYCzPVuVdrcs4XYK1he25k9cqURBQTz8zkIX5DBgFHswWrtmKNLmGxmOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Wgu7/o1/l+foK6LGqMZ4+Jj4MYPYgLYMdzjsEkxWqQiXSmb0
	2vFdmLSpz/dzfo0EMGWQetqBr/MF/DBep4+6EZmNs6Wjsthhyq1ECSxZKQsyxVsoHr7awXz3DFi
	dw+OcBT+bYLCdrvDownxgjyzhO6Vbv4b0HFj7eFUylA==
X-Google-Smtp-Source: AGHT+IGRbLj/uR8hkC4na71nBGSN5MEUADmkjmodn9FYE8tlwpXY9bvs7YlPlkEudqPyCr/JsCwnVXUWF1kCWSOUywU=
X-Received: by 2002:a05:6512:2256:b0:59a:118c:5c78 with SMTP id
 2adb3069b0e04-59a118c5e39mr163631e87.22.1765981912877; Wed, 17 Dec 2025
 06:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
 <aUFX14nz8cQj8EIb@vaman> <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman>
In-Reply-To: <aUF2gj_0svpygHmD@vaman>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 17 Dec 2025 15:31:41 +0100
X-Gmail-Original-Message-ID: <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
X-Gm-Features: AQt7F2pjuaUR7buaWgZYO9r4vqpnu-UacctXZLHNqn9jUOB1mObxTHCF93tVtH0
Message-ID: <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
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

On Tue, Dec 16, 2025 at 4:11=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> > > > +
> > > > +     switch (metadata->op) {
> > > > +     case BAM_META_CMD_LOCK:
> > > > +             if (bchan->bam_locked)
> > > > +                     return -EBUSY;
> > > > +
> > > > +             hw_desc->flags |=3D DESC_FLAG_LOCK;
> > >
> > > Why does this flag imply for the hardware.
>
> s/Why/What !
> >
> > Please rephrase, I don't get what you mean.
>
> I am trying to understand what the flag refers to and why do you need
> this.. What is the problem that lock tries to solve
>

In the DRM use-case the TA will use the QCE simultaneously with linux.
It will perform register I/O with DMA using the BAM locking mechanism
for synchronization. Currently linux doesn't use BAM locking and is
using CPU for register I/O so trying to access locked registers will
result in external abort. I'm trying to make the QCE driver use DMA
for register I/O AND use BAM locking. To that end: we need to pass
information about wanting the command descriptor to contain the
LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
from the QCE driver to the BAM driver. I initially used a global flag.
Dmitry said it's too Qualcomm-specific and to use metadata instead.
This is what I did in this version.

As I said: I'm open to other suggestions but I'm not sure if we have
any other existing options.

What exactly is the problem with using the attach callback?

Bart

