Return-Path: <dmaengine+bounces-7998-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F916CEE0E5
	for <lists+dmaengine@lfdr.de>; Fri, 02 Jan 2026 10:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5D133004F3C
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jan 2026 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE852D7D42;
	Fri,  2 Jan 2026 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcGZrTP1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D02D6E67
	for <dmaengine@vger.kernel.org>; Fri,  2 Jan 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767346024; cv=none; b=cb2Al4gRRjuh9ie+levz36fPDITy9mx0uv59U7YJGbd8lWuJeRqy0l1+63XsyN7lQCn6pvhPb9pctZSrZs3HO+uihdIZj1P9R37igV7Qd6CiGfA5eY1FuB2LnAFCWg4y18xGHsqhP2i8oq/t7T6RGY5f33EUnsv8dmFspjc4+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767346024; c=relaxed/simple;
	bh=zhOdsilIOpFy7RE9BrjIwOGH+E2b1jt2eSTpNCSig2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFJFYJx0fL0qmLRtte4N+zCtrLMQS7narNCNMie5BDt6P/15jS6LUyVepafKYajV793z6hOpVvYy1OrDmuXNI5PMKePOmb/Tzv98AX6heAcdlq4ZDxiAfaZW1oI4t3hdhaXu7OvgCLtoIQ177Gcnc5vuSYRS1dpYrJ2k8P9TZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcGZrTP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B1CC2BCB5
	for <dmaengine@vger.kernel.org>; Fri,  2 Jan 2026 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767346023;
	bh=zhOdsilIOpFy7RE9BrjIwOGH+E2b1jt2eSTpNCSig2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bcGZrTP1czIbKinXhirw5u1G2cgaQ0imIvOr7jlOhlKwDTDRPNVPYJhxTsxXWPzhl
	 tyHtGIyOqUNBWggexEd13+l2thCqqwnweO19qSUhc0vRovllz1SxmJY8s8JosMhWeH
	 B6RFnSVkn8SoXrrn9zPwcXcP+6HKvatgmQAu+NR5cKmO6gDbL72kCmf1vlT/GctgQd
	 FKv3Pqu6TK1nW0LcUIic8H+8oRKcuD7e/TL6mD+KLgrcJDCGgIDh/EOHl2BDPUbl3o
	 WO0qMD0qty30EEfVKY+p8fQHzwouftoDHMb+zKQlCpkyXgE8RcTs5g5yvCqo0JLCx1
	 L7CKe/b1vaEPQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957d7e0bf3so11450029e87.0
        for <dmaengine@vger.kernel.org>; Fri, 02 Jan 2026 01:27:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1CqHi/eKlvCl8A9fura+pkLt7MimHVAwcNbbSHi52koj1EHxdtlYOD4Vqy53ZrvM7/599dDUMdY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlAra2rad6/XXItXr1mGaFBRxqr5urs3HVIrpKvEeRIaLW9DJ
	1RgUIkqhEjbufMjmvgM+OIcDbbWDbX2KK/us3lOPaf8UtQ4v/KwiFKhvwZ/xb1VAvx0ASDRj2sg
	TE8WbP/VHIbdczOC/kgsEmePCiiwDYbVqSaTp7mqPdw==
X-Google-Smtp-Source: AGHT+IGS6HyGkOxL4zMMncygsftVJSozubE2oliBcuDCo0C8dufE1QbfRsrXj1oTZQ3PuFzr/9pnA6p2PmqiWL0TJ2U=
X-Received: by 2002:a05:6512:3408:b0:59b:2086:2c with SMTP id
 2adb3069b0e04-59b2086022fmr7537605e87.8.1767346022140; Fri, 02 Jan 2026
 01:27:02 -0800 (PST)
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
 <aVZh3hb32r1oVcwG@vaman>
In-Reply-To: <aVZh3hb32r1oVcwG@vaman>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 10:26:49 +0100
X-Gmail-Original-Message-ID: <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
X-Gm-Features: AQt7F2pObE1W--bUw5Y840QtJiQ3WP88EyUtNwKC7BerIjnzNxXQ-dH1OgcfROM
Message-ID: <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
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

On Thu, Jan 1, 2026 at 1:00=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote:
>
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
> Client are users of dmaengine. So how does the crypto driver figure out
> when to lock/unlock. Why not do this always...?
>

It *does* do it always. We assume the TA may be doing it so the crypto
driver is converted to *always* perform register I/O with DMA *and* to
always lock the BAM for each transaction later in the series. This is
why Dmitry inquired whether all the HW with upstream support actually
supports the lock semantics.

Bart

