Return-Path: <dmaengine+bounces-8075-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C4CF84D1
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 13:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A34C30361DD
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE092DA75C;
	Tue,  6 Jan 2026 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szG3dNaZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C6242D89
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702027; cv=none; b=kDoeSTOg9iOmVkNfU7FMrnluEHrAvQDCINLKI+r6GKBuxnyji+SyjLXzuKC9pvxXk1qm8ZsQU77pjmDx+tc42rTaOsMicgar0tllbq4qkiVlTW6O1PF/stBR9K61wWb8u4edjWNwWs5pnfQqmHpqChwL1qA86dBvA2LqbP8KsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702027; c=relaxed/simple;
	bh=WeihQnzULL5ReZ1WSNOJlegujvsKvpc8qcS09s0GfCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovmpf2voceCsIWD2TZcXFyuFi9Aj09MdYU+MLAzXekPsPTZK0UP0ikG5pYMiZ1vXVLlvQrW3jWq1mOISpx+fQE/91zuCNYc9mjX27N0S9dHIQRn1LAhrfa4BRimC2PPnfupCt0mmg3qXUj55SiwlqR46jtrSd5I2uI6RIVWk7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szG3dNaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131CDC19422
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702027;
	bh=WeihQnzULL5ReZ1WSNOJlegujvsKvpc8qcS09s0GfCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=szG3dNaZBdsiJh86/Aalpg4FsmNcyaj3IYV4ok84hTDobawGrLqMNJJPsyZqNiqc0
	 /qM7ucsfLCGKATgvxPXtuyOAJSxmN1hJdlk65Eeer6vqnZA2+3ezdrsyPYElLtdARD
	 CUvNwN/ox6d7oQc5lzmnSYI1XZt5xna9Ofw0wiohruXl2yCZ8F/LS1c+wT/aw7P68l
	 xjG0/Ygod491SiWVsn/Ms/oYXv9ra3GprcQh5PjrWAKM1kwbeeip2Kl0uxuv9AhTO5
	 WDmHKBf2wHAaaEZa1Wq2TqgnLO20CEpmjbqDYOOztaLwvKZLZKTTZ33Tdzj6JAYrp1
	 b+SAbafP5rwZg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b6a987346so274738e87.3
        for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 04:20:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8wlk955pqkMPsgrs5s2CZNF/QtCbSmj8OGdaPioxL3wvZTkPshWwD1E5WGr8v2fogxYsLCxixEkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxne8zNTXkTbq96PRfN38s1+Q7Y6feB2VKZZnjmO39mN07g4fKp
	cWNcL3AQookGjHDbKnAZCwhkAsfNIIIOGQdYoGBn/p5pCrUz6+86xb+GO8WRJ3ALvnH7+46fi9z
	E+38zdQK7ftDDzMScdlMzfLOiGsIbJ307swRbSY4P/Q==
X-Google-Smtp-Source: AGHT+IFx8nmopRtdPvy2vs4YbNQIpmVdCKW26mAOQptIblPti0KoPLS0IvUN6CFUKIjuyb6dXhRAvaO9RxHVoFJhqjo=
X-Received: by 2002:ac2:4215:0:b0:59b:6c3d:5373 with SMTP id
 2adb3069b0e04-59b6c3d53b3mr84520e87.7.1767702025661; Tue, 06 Jan 2026
 04:20:25 -0800 (PST)
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
 <aVf5WUe9cAXZHxPJ@vaman> <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
In-Reply-To: <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 6 Jan 2026 13:20:12 +0100
X-Gmail-Original-Message-ID: <CAMRc=McyTAvshqgfwTYpN1Av3Z4K=udzrr5t12fwcsBc=vtrcA@mail.gmail.com>
X-Gm-Features: AQt7F2q1ahQ11FMaw_VOtAKsOF6Acj2JjLhWv_yxQJgI5ojADI61utbgGQpaYTQ
Message-ID: <CAMRc=McyTAvshqgfwTYpN1Av3Z4K=udzrr5t12fwcsBc=vtrcA@mail.gmail.com>
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

On Fri, Jan 2, 2026 at 6:14=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, Jan 2, 2026 at 5:59=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrot=
e:
> >
> > On 02-01-26, 10:26, Bartosz Golaszewski wrote:
> > > On Thu, Jan 1, 2026 at 1:00=E2=80=AFPM Vinod Koul <vkoul@kernel.org> =
wrote:
> > > >
> > > > > >
> > > > > > > It will perform register I/O with DMA using the BAM locking m=
echanism
> > > > > > > for synchronization. Currently linux doesn't use BAM locking =
and is
> > > > > > > using CPU for register I/O so trying to access locked registe=
rs will
> > > > > > > result in external abort. I'm trying to make the QCE driver u=
se DMA
> > > > > > > for register I/O AND use BAM locking. To that end: we need to=
 pass
> > > > > > > information about wanting the command descriptor to contain t=
he
> > > > > > > LOCK/UNLOCK flag (this is what we set here in the hardware de=
scriptor)
> > > > > > > from the QCE driver to the BAM driver. I initially used a glo=
bal flag.
> > > > > > > Dmitry said it's too Qualcomm-specific and to use metadata in=
stead.
> > > > > > > This is what I did in this version.
> > > > > >
> > > > > > Okay, how will client figure out should it set the lock or not?=
 What are
> > > > > > the conditions where the lock is set or not set by client..?
> > > > > >
> > > > >
> > > > > I'm not sure what you refer to as "client". The user of the BAM e=
ngine
> > > > > - the crypto driver? If so - we convert it to always lock/unlock
> > > > > assuming the TA *may* use it and it's better to be safe. Other us=
ers
> > > > > are not affected.
> > > >
> > > > Client are users of dmaengine. So how does the crypto driver figure=
 out
> > > > when to lock/unlock. Why not do this always...?
> > > >
> > >
> > > It *does* do it always. We assume the TA may be doing it so the crypt=
o
> > > driver is converted to *always* perform register I/O with DMA *and* t=
o
> > > always lock the BAM for each transaction later in the series. This is
> > > why Dmitry inquired whether all the HW with upstream support actually
> > > supports the lock semantics.
> >
> > Okay then why do we need an API?
> >
> > Just lock it always and set the bits in the dma driver
> >
>
> We need an API because we send a locking descriptor, then a regular
> descriptor (or descriptors) for the actual transaction(s) and then an
> unlocking descriptor. It's a thing the user of the DMA engine needs to
> decide on, not the DMA engine itself.
>
> Also: only the crypto engine needs it for now, not all the other users
> of the BAM engine.
>

Hi Vinod, is there anything else I can do or more information I can
provide in order to move this forward?

Bartosz

