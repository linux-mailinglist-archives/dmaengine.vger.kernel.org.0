Return-Path: <dmaengine+bounces-7888-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1051CD94A4
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3611030203B9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45530B538;
	Tue, 23 Dec 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuqJCMbK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BC327C0D
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493344; cv=none; b=th9FSVhtePYUbU+3uKnkfeXlsr9yJe4SMCOtguJjeDBrWlq28K+h5c20au3acymiZRw64lsyCVdRkwUPMS8D6oFr6paq+mFxNqKWqqPpsYoe9QEHPH3zNkJwtMMaNda5+agW7hl8kh88cOXCrUuVP6sSreVWQV3djFewW9g5OTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493344; c=relaxed/simple;
	bh=q74XfHjULmeZRVR70YO063B1k67wiYkqtFS+7ft6XU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHwH2acTz8M+SISCRR9tuXgZJfmbR5AG9VtH7xVfBxyZOfw1XHIDQl4fPIc73Q8iA1wyMO/ZhYeY9MunQuVvFL+AsTS1NHDA89PxMHZmZECKvMPhzTbfEBMg/9UJd4hOUcfkFqbwsFccFxHtv70jIKuo1IoVwWnhCo2mFBx2QhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuqJCMbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F366C2BCAF
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766493344;
	bh=q74XfHjULmeZRVR70YO063B1k67wiYkqtFS+7ft6XU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FuqJCMbKoSr7nAlkhWbosDuqfgXyBovvFv27gNRQ/sdGJFCCQv+wV0IJ+ruSsLof3
	 6rozBUycIa1wkEHMkLjVv/tCGWSIs6OzO5khD1IzU8Zl7N2G5sPDb+m0ACIdxMy0jB
	 ACX+KYYNXreuqz98CjeuetiDx9sWJurwSZD1VF18gKlGE3AebLI/rAAwCIbXkycrqT
	 93vZEbJpEKKHCo0gRuzpxvoWhy15+BssmW1f0tU4r+m14cb42SDixRRN6mfS3tI7cj
	 9F2wTuDrbn79aInI4gQhFQ8w/JHmnHUZydszsC9K5WV/Tk06/rCyCBxrayjbCpD3/h
	 /rmTC+GPfw74g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37ce27af365so43173561fa.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 04:35:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkuYyrqDUYfmz83tk2Em4jHROZtBvyGtEv/i3jOr8ibtjbNUifvAq8C+PbMoMx/q+M8ndIY89R83Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+gnKyeeyN0Y4fAHtqrpvxUtosEddgXWtMDMSUOKZDDxmdCzJ
	QrI6+8sz7xGo/FzznXXgGSSchN+LEZ0Zoywc6iN7bjcTnt/4I9zmOfbARMRTmEMwBY48onf9ZAN
	IYk2TucP3Uk+JhTIyVCFk9rBiGDmwbRLygGCDjjaUqg==
X-Google-Smtp-Source: AGHT+IHzGMp/lUo841FNq6eKIEsyBk22ZwXTxkqvHm+j8oaPP30fI/e45HM5cEWeUxoNo4uYstP9Q7EEle5NpDVyVoc=
X-Received: by 2002:a2e:a908:0:b0:37e:6884:67e8 with SMTP id
 38308e7fff4ca-381215e9191mr41558841fa.2.1766493342788; Tue, 23 Dec 2025
 04:35:42 -0800 (PST)
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
 <aUpyrIvu_kG7DtQm@vaman>
In-Reply-To: <aUpyrIvu_kG7DtQm@vaman>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 23 Dec 2025 13:35:30 +0100
X-Gmail-Original-Message-ID: <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
X-Gm-Features: AQt7F2oSGCQtIaLV5R5D9XkRDpY-kRDfqZja_OqWHGJExvMJA-6WqMsyJ0COlNU
Message-ID: <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
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

On Tue, Dec 23, 2025 at 11:45=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrot=
e:
>
> On 17-12-25, 15:31, Bartosz Golaszewski wrote:
> > On Tue, Dec 16, 2025 at 4:11=E2=80=AFPM Vinod Koul <vkoul@kernel.org> w=
rote:
>
> > >
> > > I am trying to understand what the flag refers to and why do you need
> > > this.. What is the problem that lock tries to solve
> > >
> >
> > In the DRM use-case the TA will use the QCE simultaneously with linux.
>
> TA..?

Trusted Application, the one to which we offload the decryption of the
stream. That's not really relevant though.

>
> > It will perform register I/O with DMA using the BAM locking mechanism
> > for synchronization. Currently linux doesn't use BAM locking and is
> > using CPU for register I/O so trying to access locked registers will
> > result in external abort. I'm trying to make the QCE driver use DMA
> > for register I/O AND use BAM locking. To that end: we need to pass
> > information about wanting the command descriptor to contain the
> > LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
> > from the QCE driver to the BAM driver. I initially used a global flag.
> > Dmitry said it's too Qualcomm-specific and to use metadata instead.
> > This is what I did in this version.
>
> Okay, how will client figure out should it set the lock or not? What are
> the conditions where the lock is set or not set by client..?
>

I'm not sure what you refer to as "client". The user of the BAM engine
- the crypto driver? If so - we convert it to always lock/unlock
assuming the TA *may* use it and it's better to be safe. Other users
are not affected.

Bartosz

