Return-Path: <dmaengine+bounces-7290-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F3AC7A37B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 36F5E2E101
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BBD34A3CD;
	Fri, 21 Nov 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mraEb9pi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB75199939
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735766; cv=none; b=lFWeY558iCrvBsRJgoNgOMnIeeeZZ68LIUaLnWb+GtEM9At14lp1dZ8d0GG/XaVvjNeThLudhxXaWCHGtms7CRMmQu+KqPBrjs/8UuiL/XU0qyviat6aEjKG6h+rFbTzxgu1oJCX7dh01XMfdGIsd42axF4p7hyE3ekeSohV0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735766; c=relaxed/simple;
	bh=kcvdwzmTHjfImVyX48L1z8kmzHl3/BcWLpJ7S7bBj3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR8nTEdJit/L9s/IWfChGPblnKCtvFpmisw/ic56CsfzJD/ggDhAc8n8QllEhT0MXkHoGKFxbR0A4EECoJM/OpoG8nDodkQaJpDupp7XLUNuRwvShzJsNGznyVIf9yOsuW0QKnCFMCHskJxOzKKCoaFaJGMJkcZ3ClzbXr7Rwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mraEb9pi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5943b62c47dso2126260e87.1
        for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 06:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763735762; x=1764340562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcvdwzmTHjfImVyX48L1z8kmzHl3/BcWLpJ7S7bBj3M=;
        b=mraEb9pi3/JcMbuoaXF58JeOq0GKs1fotivoH8EZ2pDNlvKjsRnJaLGWfNpqxyBlF/
         bGEvDU6waTMWJI7SwK6hMc8gDL8919T++Fu9AZgU8KpkJOTxDcLZEu6h/HgsBNnXL5QW
         boy2INfbdj3iYviDI2GUA5oIlC2fBQaF7n5CPgo63eQt4fa3ouDXNI0aw7P21g58fi56
         znK1/0i2lRu9Mb4Y/86tFI8ahuoT6GpqKFgdTjx1iF2OqLU2HONTJxI1bP9LNPfbX0Bp
         JWTZOeO0KoGOwJkIf9F9VAAazF5f5HEUXGXdYZCBXtAeQO7LhdBgohf+bQj74LuOsTYz
         a8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735762; x=1764340562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcvdwzmTHjfImVyX48L1z8kmzHl3/BcWLpJ7S7bBj3M=;
        b=RZEphVQ94OpxpFSSyulO5fqL03c39VGbjQ+pY0D0+xoykPv2anlbbTNXaff5wCT2x0
         z4SGMSeWYzntopOuyTYuklz8Wx+C52XCAU7udPOIlaS+k6OY2J91UfKJ/DdJ6nLfCNcY
         /mVTmntmPQOvtAw0+O69tl5herdvaeV89KU260CJcpZcUPkDbexw8uDn2YmwgNm5bkX4
         pigSHHwub2LbNbuqfjgG0IeiTLduQAdoJRK35OJcI+7fTYWut1Hh23mpfX+eN/ORh6Zj
         C75VXDTyEq9i/13w9Sk4hmlR1zQ+T5s2jJabu8P4v6TpqJGAWM3n/iojymmNXCV+6ST+
         7N3g==
X-Forwarded-Encrypted: i=1; AJvYcCVZzXJIn0tsEtUKFxah73kcOD4ccddJJjQ6pReLGRA2EvlaV+UQMdk11A7w9x6DEetBFnj2vVeOPWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUJGWVf4V24mgMppganjAlRtBTteNMtg9Y8CYfgHT0KqW1AJi
	YSnw3oGUPs3sHgpyfvDc4OyZrygYsgGmNVlRNKL4FZoF9c2NOZx7RE+DSEv4vqZx7XxuPwgtWha
	RJL8koqZr8tXgvJEw0+gB6rjBIPqnn/ijMxCEnXKiXQ==
X-Gm-Gg: ASbGncvic7PiHHCZZ+3ySVixg/x4sVujeipo2Rm1G8lTEUWR4d7/0OCYuCgbpIgc565
	VkyMg48qTljFrDpzZ3O7p//bhfQX4ybnG3eERIZZ2TrgtF7K5Acm+8qnIKbuOMKqUoI5Jz4KStD
	i2Er5Q8o4A3q8aaT+LeJkTavL1sUpeZ25/m5ZX/pNPFDstBFpYSLqHUySYAZ3eu1tWB11vqS8zL
	BS3gR+zgcp2udfL9zj3g5Nqu2UsHvdsRfQqx0H5V7SUwtRewQlKWzNQXuefgbbZMT0Vig8UeJKT
	qk5W2Q9IZQZ+KchKzZwD5Lr11g9RBcqz2bej2w==
X-Google-Smtp-Source: AGHT+IEt2uZ9UPqWbRRe+8fGSY15wdsKLC5t0faSbXjvG68jFZ1NGNH9efmvDAFLqXO77pWUDjtREMDkD8mv7aijzwE=
X-Received: by 2002:a05:6512:685:b0:594:27eb:e130 with SMTP id
 2adb3069b0e04-596a3ee50b6mr898634e87.46.1763735762108; Fri, 21 Nov 2025
 06:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
 <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
 <xozu7tlourkzuclx7brdgzzwomulrbznmejx5d4lr6dksasctd@zngg5ptmedej>
 <CAMRc=MdC7haZ9fkCNGKoGb-8R5iB0P2UA5+Fap8Svjq-WdE-=w@mail.gmail.com>
 <m4puer7jzmicbjrz54yx3fsrlakz7nwkuhbyfedqwco2udcivp@ctlklvrk3ixg>
 <CAMRc=MfkVoRGFLSp6gy0aWe_3iA2G5v0U7yvgwLp5JFjmqkzsw@mail.gmail.com> <66nhvrt4krn7lvmsrqoc5quygh7ckc36fax3fgol2feymqfbdp@lqlfye47cs2p>
In-Reply-To: <66nhvrt4krn7lvmsrqoc5quygh7ckc36fax3fgol2feymqfbdp@lqlfye47cs2p>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Nov 2025 15:35:50 +0100
X-Gm-Features: AWmQ_bnh7zWBFnvkFmVPhxTMwiWW-abo3yO-revfh4tghVthdoeoEiGc0JMgThA
Message-ID: <CAMRc=McYTdgoAR8AOz-n5JEroyndML1ZQvW=oxiheye3WQmvRw@mail.gmail.com>
Subject: Re: [PATCH v8 01/11] dmaengine: Add DMA_PREP_LOCK/DMA_PREP_UNLOCK flags
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 9:12=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Nov 13, 2025 at 04:52:56PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Nov 13, 2025 at 1:28=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 11:02:11AM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, Nov 11, 2025 at 1:30=E2=80=AFPM Dmitry Baryshkov
> > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > >
> > > > > On Thu, Nov 06, 2025 at 12:33:57PM +0100, Bartosz Golaszewski wro=
te:
> > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > >
> > > > > > Some DMA engines may be accessed from linux and the TrustZone
> > > > > > simultaneously. In order to allow synchronization, add lock and=
 unlock
> > > > > > flags for the command descriptor that allow the caller to reque=
st the
> > > > > > controller to be locked for the duration of the transaction in =
an
> > > > > > implementation-dependent way.
> > > > >
> > > > > What is the expected behaviour if Linux "locks" the engine and th=
en TZ
> > > > > tries to use it before Linux has a chance to unlock it.
> > > > >
> > > >
> > > > Are you asking about the actual behavior on Qualcomm platforms or a=
re
> > > > you hinting that we should describe the behavior of the TZ in the d=
ocs
> > > > here? Ideally TZ would use the same synchronization mechanism and n=
ot
> > > > get in linux' way. On Qualcomm the BAM, once "locked" will not fetc=
h
> > > > the next descriptors on pipes other than the current one until
> > > > unlocked so effectively DMA will just not complete on other pipes.
> > > > These flags here however are more general so I'm not sure if we sho=
uld
> > > > describe any implementation-specific details.
> > > >
> > > > We can say: "The DMA controller will be locked for the duration of =
the
> > > > current transaction and other users of the controller/TrustZone wil=
l
> > > > not see their transactions complete before it is unlocked"?
> > >
> > > So, basically, we are providing a way to stall TZ's DMA transactions?
> > > Doesn't sound good enough to me.
> >
> > Can you elaborate because I'm not sure if you're opposed to the idea
> > itself or the explanation is not good enough?
>
> I find it a bit strange that the NS-OS (Linux) can cause side-effects to
> the TZ. Please correct me if I'm wrong, but I assumed that TZ should be
> able to function even when LInux is misbehaving.
>

Ok, so the consensus after talking to Qualcomm crypto engineers - and
I understand this is Qualcomm-specific but it should apply to any
similar use-cases - is this:

If the TZ uses BAM locking and it locks the BAM and linux tries to
write to the registers protected by this lock, we'll get an external
abort. Making linux use it too addresses that potential problem.

Linux could potentially lock and never unlock the BAM but TZ could
also just reset it. Also: linux could as well turn the entire device
off. :)

For the Qualcomm use-case this is not an issue - it's about making TZ
and linux work together. I suppose the same would apply to any other
users.

If that could be contained within the crypto driver, there would be no
issue. It's just that in order to pass this bit to the DMA controller,
we need a generic flag. If you have better suggestions, please let me
know.

The flag has to be passed to the BAM driver at the time of calling of
dmaengine_prep_slave_sg() and attrs seems to be the only way with the
current interface. Off the top of my head: we could extend struct
scatterlist to allow passing some arbitrary driver data but that
doesn't sound like a good approach.

Bart

