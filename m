Return-Path: <dmaengine+bounces-7293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA47C7B146
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 18:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6354E4D40
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A226B760;
	Fri, 21 Nov 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="v8zLkXCM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAA1E5B95
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746334; cv=none; b=sk29PVoDWHNX++sVFgUfeQxNFopfXfSuJpW9+CaOxh62/PkmRkx5nWRAEMpWqwKDPuSKZpwksfhAzLBVfjUBG2IIsEkwIZqILbeKOdzetjrCovrHOj5Ft0pIJGCa6yzQTTlAK94qOqvj1THomF/nUxEZSZpGrZ29fFMe0w0sYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746334; c=relaxed/simple;
	bh=kth0y7HTa9SOKIU9g0nLJ1NK5z0zg64snesxFb7xaaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0OUwJRYMHl+OdcUtVo71ZuwgOYJd7/8U9rdgVfshUgy3ODIqsmoyOI8JUv5Pe1TvOuJin24Ki9zI3dUAVfLoKeGrOVK+uWWxYJ6gHdtsw87mB9Fo06CUx0EZdlXXxyaAW+xF0K20oUYxb/bNpfEUg979x69TbDjAgN0cEYX2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=v8zLkXCM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59584301f0cso2523860e87.0
        for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 09:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763746331; x=1764351131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kth0y7HTa9SOKIU9g0nLJ1NK5z0zg64snesxFb7xaaU=;
        b=v8zLkXCMMFZcibfoyLGEaykfU0GqSzBf/fH8MzvfOx4UpRlJtaZZ45ZSTu/2lasd7n
         Yne74jDpttIVknxLguSWthBre3JFNRoUK6tMT52M4fex+CxTb3TJMvO/r3DEniCL/ams
         hWBWsa9zEW6h7qQTmeV2WkJ8h//2KVzAthUREbfx+4kMnbk7SpuxDC7mef08sDvfNe0j
         fBtzNGSoCwcTDlvI9c2t1E9MQRm0/sOTCfFt1i4KajiA3M3nZcmRY9C/AAsVVczz29UZ
         DbR+PPOK80PG0Ht+PzGhNT326rqyxKZrjGXIuy2Bk694a1fcGEl9BpXm1KN1WQL6X4yG
         o8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763746331; x=1764351131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kth0y7HTa9SOKIU9g0nLJ1NK5z0zg64snesxFb7xaaU=;
        b=LxeT+7FAWvgykc8EOLhHZdGaXNWzWvPO4PuNSJ9AZkxnhzw6xcnkhSih0btlT4RXdT
         +ZdJ9jKB2vSa5HnK6cOI1qtycEgh0QfM/xi/lXNdpPU8SnVvkpOWTeWyGAaLjSr99Kz1
         AJPKFY1YOXpX6NK0iqlTeJ9Nk2wq3tg0kQTgW4V0qsV9Rm/m7I8eNHARI17IvqwsTNmk
         faxcevuJKo7gfcUz7XFMfRupBusMR88isYa5hR2DfAYCivxu+1jbHC6aX9illlKVSyED
         hZ4rCh4CC8E7nat9LzvDPLsiHo1a3RG5AoCIw8NdBoYlMeDZM08KBYuj/uZ4GMKAN1O2
         EoYA==
X-Forwarded-Encrypted: i=1; AJvYcCUIBV+80ZtZkZ7AOX9y126fwBUX3Ru7y3Vy11tQMyUuE8+kxZa5HuE9VKHk8JYpe90KGr/S282NENE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUWzibACcRfyaEjePpJTnbDSMQRnOpeM7snZthAS8n9AsDKig
	+Glm0QiCTlhxjmldFemcNO75Cbks4BMTH/HWaAZ+a2w0kstsK8Q32ZCV58SOBM8hjVnm3p4xIWj
	T2tE9Zxgy30e9bvhwEPr0qqZzRAvOukxyPBdYCvvvqQ==
X-Gm-Gg: ASbGncvwJYOqCLJtOsLPOUIoDClwfdKb1mWDUmnEdUc7pUrD201kd4Hr/PwVSXigJjk
	MyAtV4/KpmFaDBSalz66seFqGrQjm0P/I4VgpggfH7QUE66A1SY/ie0kaAb+rSLU9DPOfKZALqq
	gBe+GUeA4JLKKuMTYDcsrJ20L/B5odo5EuJfghnJmo3zvlqlaf+7DzZl8GNqHkFVpwMMVgtt32c
	8vg9h/8aZai3X3IsDRJKd65abst04n5IS396VhIxCfCkbiPb0kD4URxGa72J59yuBbTtpUs2ajZ
	+xYeO1JdOogRYGajPhNDRa+Sha0=
X-Google-Smtp-Source: AGHT+IFrdM3hZhHWz0WyuYbt+MGt6Thaf3kFt5DbPs90YPkIC9rrtnEFnyWeJ+DyEDb8IAb42i1R+G+ZOCDA0C98CKc=
X-Received: by 2002:ac2:4e0a:0:b0:595:8258:ccc7 with SMTP id
 2adb3069b0e04-596a3e9eb1bmr1000163e87.1.1763746330475; Fri, 21 Nov 2025
 09:32:10 -0800 (PST)
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
 <CAMRc=MfkVoRGFLSp6gy0aWe_3iA2G5v0U7yvgwLp5JFjmqkzsw@mail.gmail.com>
 <66nhvrt4krn7lvmsrqoc5quygh7ckc36fax3fgol2feymqfbdp@lqlfye47cs2p>
 <CAMRc=McYTdgoAR8AOz-n5JEroyndML1ZQvW=oxiheye3WQmvRw@mail.gmail.com> <whxi2ikode53vrxqpanryw74zd7oovfielgdvhpkka5zy76g75@dxreidnb77y5>
In-Reply-To: <whxi2ikode53vrxqpanryw74zd7oovfielgdvhpkka5zy76g75@dxreidnb77y5>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Nov 2025 18:31:59 +0100
X-Gm-Features: AWmQ_bnls5aC2uYMxiloODvlLPPtaHGzyORZnXBgt1VZ07gmTcD09CgNCNE_vtQ
Message-ID: <CAMRc=MfqYiuLaz_28nE+5QSdiG-MyTk885HSO4OYz8Wf4myfJQ@mail.gmail.com>
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

On Fri, Nov 21, 2025 at 5:36=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> >
> > The flag has to be passed to the BAM driver at the time of calling of
> > dmaengine_prep_slave_sg() and attrs seems to be the only way with the
> > current interface. Off the top of my head: we could extend struct
> > scatterlist to allow passing some arbitrary driver data but that
> > doesn't sound like a good approach.
>
> Can we use DMA metadata in order to pass the lock / unlock flags
> instead? I might be missing something, but the LOCK / UNLOCK ops defined
> in this patchset seem to be too usecase-specific. Using metadata seems
> to allow for this kind of driver-specific sidechannel.
>

I'll look into it, thanks.

Bart

