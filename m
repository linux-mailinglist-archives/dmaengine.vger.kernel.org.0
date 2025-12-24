Return-Path: <dmaengine+bounces-7937-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B790DCDBB92
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 09:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BB0304C1E1
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4832F765;
	Wed, 24 Dec 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk8aS6CN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76A32F740
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566700; cv=none; b=qDeLnAqOPlWdukBMuhcdtkIfKRUyuwhZDtUjt0D2FGnBrVI9JttpGBkG0jV1MHbT/NSX5zJxppoD3V+bm5JemxwggwJjj4R8OJ5gnAVlq9OPVCeI6JgKREiG0xwBt4rYvy2ML3P9x9v+loARNwlivPgexEAhEg417pjHDhpWNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566700; c=relaxed/simple;
	bh=Agykw1UWdIlmNGGbRoXH+kiyz33Jt+a4FoRWg6PklU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDGJ9Hn6f3v600DYjQeuJJ+3DnuJBo6kLx0v5Ta4x5lle3TT54UfJcFy3cWG2x0Rdt7F4ZCqG4SEYlLtjW7MplPvZERX9VJGgwHoUEkNR16zocVgZZaRgD8wVjv2rfp7Npr0UcrdzHcfutrprg8YsCjcTplTyAqH7duP4g7CqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk8aS6CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2856DC19425
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766566700;
	bh=Agykw1UWdIlmNGGbRoXH+kiyz33Jt+a4FoRWg6PklU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uk8aS6CNHa2N9goRBT70lisCoGZ/qslnwI/4uAOjYVi6An1lxsPrxD/36VGZnKGKv
	 M0gfjH0vjkwRugI3jokP4VNSKo0lMjcMD/U25o2KA+rX9/z/yloiIdFKOOoxuD8SiB
	 y051UzPLRvcLRURh44irYqegoUz4a4MKcruFAFeqZZzrlDy4rbrX9qHLkzaIZ8iKho
	 fbH9Lhg8dnQ4uSjTc3+vnFJtxCXNnygVfUEmZt2anTbBQIeo5+oKELZm7odFlWA/Oe
	 IMTkg/+sopwcg7WM8Myrw2U8cfKHcyade3Tzgp3BoEg8fikYJeT+tcdXSqUZRlIorI
	 yKFWHGZNbombg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37b9728a353so71872701fa.0
        for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 00:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtVgBZUI1MGI55oM0meH6LhW6AVfccLTtcM5E4HmbyhLamfjfifu+6pCQSNT7FYSk1XFN5kMO0y6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3x3YZ6RwYZTSsTK4sddO5nreyUqeiKnFIkOMOrdvJIyU2Pd1
	Fv1za10LFONQkRUxbLvKr8DvhKr5TA3voZ0fv8LjeN/nUAWLD59YO4N5q7je+p8GEWjdQR1jxOD
	BzalFld1V3ZaDq8y7WsYY/Cr5bQZAdPWneCTopu1ULQ==
X-Google-Smtp-Source: AGHT+IEingVT+n+8YdVgTso4ZzTuzbOc22MHQbhbirPXhrT8luipXdASVItpQL6PNdBu/f24535BGV92RvU1trjKZ4c=
X-Received: by 2002:a05:651c:1541:b0:37f:aa44:2cd6 with SMTP id
 38308e7fff4ca-38121614ef5mr54061241fa.28.1766566698742; Wed, 24 Dec 2025
 00:58:18 -0800 (PST)
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
 <c2ctqk7z6n5mmrr2namz4psmpcohefyv6qu6gkycqykzgdpz2u@2qwils6lwwz4>
In-Reply-To: <c2ctqk7z6n5mmrr2namz4psmpcohefyv6qu6gkycqykzgdpz2u@2qwils6lwwz4>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 24 Dec 2025 09:58:05 +0100
X-Gmail-Original-Message-ID: <CAMRc=Md8nAVWvKK=Vib7TKVzC15M4FmET7TCCdrdS74DKQQjzg@mail.gmail.com>
X-Gm-Features: AQt7F2qHo8ax2BJ5527NPXgH7eTCAHicS5tGpM49gAynivHaNzKegq2WIJRBUwc
Message-ID: <CAMRc=Md8nAVWvKK=Vib7TKVzC15M4FmET7TCCdrdS74DKQQjzg@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 9:19=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Dec 23, 2025 at 01:35:30PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Dec 23, 2025 at 11:45=E2=80=AFAM Vinod Koul <vkoul@kernel.org> =
wrote:
> > >
> > > On 17-12-25, 15:31, Bartosz Golaszewski wrote:
> > > > On Tue, Dec 16, 2025 at 4:11=E2=80=AFPM Vinod Koul <vkoul@kernel.or=
g> wrote:
> > >
> > > > >
> > > > > I am trying to understand what the flag refers to and why do you =
need
> > > > > this.. What is the problem that lock tries to solve
> > > > >
> > > >
> > > > In the DRM use-case the TA will use the QCE simultaneously with lin=
ux.
> > >
> > > TA..?
> >
> > Trusted Application, the one to which we offload the decryption of the
> > stream. That's not really relevant though.
> >
> > >
> > > > It will perform register I/O with DMA using the BAM locking mechani=
sm
> > > > for synchronization. Currently linux doesn't use BAM locking and is
> > > > using CPU for register I/O so trying to access locked registers wil=
l
> > > > result in external abort. I'm trying to make the QCE driver use DMA
> > > > for register I/O AND use BAM locking. To that end: we need to pass
> > > > information about wanting the command descriptor to contain the
> > > > LOCK/UNLOCK flag (this is what we set here in the hardware descript=
or)
> > > > from the QCE driver to the BAM driver. I initially used a global fl=
ag.
> > > > Dmitry said it's too Qualcomm-specific and to use metadata instead.
> > > > This is what I did in this version.
> > >
> > > Okay, how will client figure out should it set the lock or not? What =
are
> > > the conditions where the lock is set or not set by client..?
> > >
> >
> > I'm not sure what you refer to as "client". The user of the BAM engine
> > - the crypto driver? If so - we convert it to always lock/unlock
> > assuming the TA *may* use it and it's better to be safe. Other users
> > are not affected.
>
> Just to confirm, we support QCE since IPQ4019 and MSM8996. Is lock
> semantics supported on those platforms?
>

Yes, locking is supported on BAM since version 1.4. The only user of
this feature right now is the crypto engine and even on IPQ4019 and
MSM8996 the crypto BAM is version 1.7.

Bartosz

