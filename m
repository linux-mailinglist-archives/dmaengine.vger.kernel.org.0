Return-Path: <dmaengine+bounces-7169-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00106C58BDB
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD2484FF11C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C973563C4;
	Thu, 13 Nov 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UnhyHl5P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32E3559F5
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049192; cv=none; b=ho0TWuc3HDIegYH/6J6wf8XcsWfbhXITiKk69yPonehCUgMkds6o/rgoI313ChM5ouGshNcDDE5xYZrtJdim+DlzdsOZZdgvSTI9PCDZTUAYKnRCrYYqq7g/lkxQzNdGVdz7zc9JlmqNEL7MRXyJ9rDaclSwu8qI7ADXw9Km7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049192; c=relaxed/simple;
	bh=OX60sKiYWBPN5NRPN15Ciaf9MOmCSXUCmyYmlQRE8wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOc23oez/9+oGW8oV53VZJj3dFjnR+rDzsG48HFsV52Gk1EKh+1k0Yl7zGtV4G0BdhiYlNw1IsIbbEWlCbFIpvaF77u8Fv8kwddtn7jxJEynIj/gjMvFsXPTw+FUNTtwsBlWb/jsVtek9UJhbUJYMKXSBS2uqbOhBlpesNBYvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UnhyHl5P; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59581e32163so582434e87.1
        for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 07:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763049188; x=1763653988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX60sKiYWBPN5NRPN15Ciaf9MOmCSXUCmyYmlQRE8wQ=;
        b=UnhyHl5Pnheicwm/Lo3266MWOD40MLGfAm6zN124i5VRXHIGIdAfmPbI+hKGkSA96p
         23cUzQWcaBUZmknmwMOZAgjabWEFqOzRioN6ooYqxGs6OFBymc6rtli14+wArQeA9aPE
         DKQOjlpLSjbAreNJZ2gt3t3Xaz17Zue9OeSdXvw1TzoKgmOh1GtwrjqXcXHCtbq1KAJB
         hzvy+QhJ3JBX+wiPFUPpIoKtPQtPbTSBCkfmLFHlpX8DuJWcgF2RD/4htVqFvzE0QJFm
         v4QKy6NIleF9eTSPZR4lun5A9FQYImGaCpgtPcVk9/twQEJGfSvLDMCwVgyCeIbxUju1
         XLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049188; x=1763653988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OX60sKiYWBPN5NRPN15Ciaf9MOmCSXUCmyYmlQRE8wQ=;
        b=HkKy6J3ST+hFHCp3HTtyaRTa+k1YlXyHsLFbKIj8+Pl5BCLaaaJ5mKS/oAnnEM2pVJ
         mdpwY4UiVuRBm3HwymMk/RySQdoqYf3phM2TQ6j4qNo9va7l+d7xh9dsnBC6idbEr/ZX
         Hb/yQnHEpUG05uzBayf1OrssGv/IO9jLGj84mSGjgN8fZoQ0exyrDUUyYoHP1q7Ljln0
         XYikvbNWJApdTHJVwY0EK4pEo5b6AoKU4NkhxzVEARb1XTuPbtJJlEz+bQbLjYLO7ahL
         yb7mTXuENhdTHT+J06FuwnluE2uWDnw4ZYxGLew8T3bAldJHCfttB3VR0r4U490UqE5K
         M5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX5CDQYCxMB68Z9Tw9naLoVrOVfVW0YfWawqayxy+GWFZv7kkwAnLbGLlPY5KnOvlNqDTcBlDOPNsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyye2IKxT73lqkO8S68vNW25qzZgwBOyoQUf4ZovbCX5hccFP8U
	G+utpItRmbD47/XNZem4+2ay+Z0IMPeUZ+UI7UEkxXFcP61G/b5UgogU1riSVKDkoy+buq3oAXA
	825DxJJCYR6VeXf/qTpjvHmQIIhT115CcFBXKfHXQDw==
X-Gm-Gg: ASbGncswfZpqwhU8mVl0LeDzMlSfh9DDRYMap0TQorKETMPaXpQis0tHQ6lxoRM+5OK
	hCgUpih39X55FbTAmKpCThsW9OYwPQ/MyCZTlilqyFEz+tXNCzXbBG2TQ3D5TDNY/rozJ9Wr0Y+
	mUtFWweioHzmGvJuzCvtZWWssbpby00hkz6sO9h20kSyn32+MHr7mhlAKL3MkkKYv0ODXPufu1U
	WJK8+bOFneX7Z8gtPWn9ObTb8/tFmndCp+Cb1oAfiRHmI+gMQvtkQiq8ugQ7N8xeGwY1HZN+TN8
	ilzjh2WItwnWyIgI
X-Google-Smtp-Source: AGHT+IGEIHUfqwrlVSTNHLgDVI05vKsEFSndBnbm0aaakSseNyRK8XPAjnLHbbfGqrZ6iuP/tkAMQ67bsZMfd+4juQg=
X-Received: by 2002:a05:6512:108e:b0:594:34c4:a325 with SMTP id
 2adb3069b0e04-59576e31216mr2694783e87.46.1763049188065; Thu, 13 Nov 2025
 07:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
 <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
 <xozu7tlourkzuclx7brdgzzwomulrbznmejx5d4lr6dksasctd@zngg5ptmedej>
 <CAMRc=MdC7haZ9fkCNGKoGb-8R5iB0P2UA5+Fap8Svjq-WdE-=w@mail.gmail.com> <m4puer7jzmicbjrz54yx3fsrlakz7nwkuhbyfedqwco2udcivp@ctlklvrk3ixg>
In-Reply-To: <m4puer7jzmicbjrz54yx3fsrlakz7nwkuhbyfedqwco2udcivp@ctlklvrk3ixg>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 16:52:56 +0100
X-Gm-Features: AWmQ_blYu02FWethcWw51M6XQQsBTFUfg16XB4nlVnnodZzkOPobVgGS07ncuc4
Message-ID: <CAMRc=MfkVoRGFLSp6gy0aWe_3iA2G5v0U7yvgwLp5JFjmqkzsw@mail.gmail.com>
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

On Thu, Nov 13, 2025 at 1:28=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Nov 13, 2025 at 11:02:11AM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 11, 2025 at 1:30=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Thu, Nov 06, 2025 at 12:33:57PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Some DMA engines may be accessed from linux and the TrustZone
> > > > simultaneously. In order to allow synchronization, add lock and unl=
ock
> > > > flags for the command descriptor that allow the caller to request t=
he
> > > > controller to be locked for the duration of the transaction in an
> > > > implementation-dependent way.
> > >
> > > What is the expected behaviour if Linux "locks" the engine and then T=
Z
> > > tries to use it before Linux has a chance to unlock it.
> > >
> >
> > Are you asking about the actual behavior on Qualcomm platforms or are
> > you hinting that we should describe the behavior of the TZ in the docs
> > here? Ideally TZ would use the same synchronization mechanism and not
> > get in linux' way. On Qualcomm the BAM, once "locked" will not fetch
> > the next descriptors on pipes other than the current one until
> > unlocked so effectively DMA will just not complete on other pipes.
> > These flags here however are more general so I'm not sure if we should
> > describe any implementation-specific details.
> >
> > We can say: "The DMA controller will be locked for the duration of the
> > current transaction and other users of the controller/TrustZone will
> > not see their transactions complete before it is unlocked"?
>
> So, basically, we are providing a way to stall TZ's DMA transactions?
> Doesn't sound good enough to me.

Can you elaborate because I'm not sure if you're opposed to the idea
itself or the explanation is not good enough?

Bartosz

