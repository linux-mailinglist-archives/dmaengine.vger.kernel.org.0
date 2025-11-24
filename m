Return-Path: <dmaengine+bounces-7304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5C5C7F4EC
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 08:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE9D9343484
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1912EA481;
	Mon, 24 Nov 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I33TT0OJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14342EB5BA
	for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971120; cv=none; b=cxfA2u4YAo0BQDvdmaFTcWBlW5j2UVOresQsw8vVkm9sv+ForpfPgS/PIyFGS579qikxfmmuFMEgNqz3+nTNfrxCoMACJWUi0O+kurIGoPnfNftE082KQJy43kj/r8Z2uv7MVnjGcfb4299tsKa5ZwbyfLI2Gv8YEX+eKi+pRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971120; c=relaxed/simple;
	bh=NWcIh1ErMKd6H6vWOXjkKaKPaSynKkQ1yr0ovtWLPOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecPdsJ/v3S9YQ3a0HeuwUNi7bptyO4bWEvRNsmJ/YYOq7S0fg5tVdBJRhd0r1jxFUCwAuHXtvC1K2zebggyXwWstRLdf0IR+RsT5nvUQLC0Ns0Nr8huj0cWx1a0sK9cNOCAKEhSSl6swSiy6iQq03URukVL7UxE+6bHjz+SUtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I33TT0OJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5959105629bso3824777e87.2
        for <dmaengine@vger.kernel.org>; Sun, 23 Nov 2025 23:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763971117; x=1764575917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWcIh1ErMKd6H6vWOXjkKaKPaSynKkQ1yr0ovtWLPOA=;
        b=I33TT0OJEb9/OFO2gkbCI3phaDWFP+Ti5ip/OEnu5ixwXHacVDCYj4uaoQGN8g/HuV
         Li/Bk2mSRTPPSRYJ6jLVswJXZ81gc4P96gkoA4DX5DmSOd1L8KGk25LLg+At9eCPbCOA
         aSM08lZOdKZnwAgaHQ9M51eXaxj/XRPKcvnMjwbZq2yVDS9iNUBU0kI1MDZHlldnHqlN
         nAIomMNSre3hIDUoLAUaTlY5a2H0fLJVGHrPE8x5oTi4jvQTFLIj7aCdUUku4lB4q3Cn
         c0v69bUDHArBh0egw0OIyJUtMslXi66c+YfBBput6MSdSrWF3Tcj29WDDuhIA/l576pU
         p4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971117; x=1764575917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWcIh1ErMKd6H6vWOXjkKaKPaSynKkQ1yr0ovtWLPOA=;
        b=KP14oCC7tORh7YvquGLDQflvWY6iCGkRXgRPdk4jYpyL8iXNXA7ScF9oFCP4j8xrjQ
         puCKafuI2FSzFEup6wEsFr53hn9cADf0rioW4GfZjPB2N5qf4esGS52exWpvZWZ18/W9
         gG7s1azW5SesaMwN04VZhZvTGN3DQnOjb9UWxxLOv/sqcCitvMLkDhi/AVpV81ltKD2g
         Ks5TTUVpspWs9Sw8lyhWMEpyfKSvCa3ajRdrdkbLhJP0LJ4zfMRhRJ1v7VGca/V9XNPI
         mtL2IbSxg7POTlf/tOv9YsujvNB7VfUjjIS5AJr9XPJNkW/sYFyruObCm+XuugEbgcHD
         55dA==
X-Forwarded-Encrypted: i=1; AJvYcCWySl/8p83WeTnYxejJqBVTx9QEmZDgm48M7aNs7Q8wWwxG2FSGj/FcmE93xZ5SqHJqJOA5ear5zDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmUT79YrcZo/XgPLBrYA580wSo7mu4EB0KmFvtMAvbHHtUo01
	aK0E0SKanqjn50e5/M5Lb4JtNwD5Kj9rMFfjwkwD5dO59gJ3Rj/pYETzUCtEJhjzKkMBQ8C+3PS
	cxfNXeXxieNNv+vqyQ9yxLgasi/87bFz2k+PAEElWGA==
X-Gm-Gg: ASbGncv1UCud1pcRQMjButQxmaI4SzOuSh4KR5g+I+lLdPa0hYKTpxE99+kJACu4HBq
	yHGxeWWdAnEz7MFSIWTSxuJryoKODDwlxbQuA40M1Sv9CyEsCX9q1Lu6d8HmVe+E+Hd+YvxG8PV
	W/u+oBWR3QTrOl+H9sCOu+dXFOJzttAa3dgj1kPv9WduuCntZdRnn6bYHKpy8DkO2cp9mbTl5Gz
	a0dkVmj7nPzfpnd40VOkCFUaXJW2mFyvjz2OpiyLI7EaC7N520mLWRgaKcvz6cOE7R+Wl2hzVmL
	xKZAr5QHhOUeRRnm8v2f9pvyg+Y=
X-Google-Smtp-Source: AGHT+IFcmJtPui/jBi6YtKb/aiSxS8z0bfSVfYVMb9+ydpmidfbDyj+CR4bSFaYUCQ/R4d2g2KsnKpT2GI4I13mnEbs=
X-Received: by 2002:a05:6512:3ba2:b0:592:f931:4f9 with SMTP id
 2adb3069b0e04-596a3ed3116mr3904528e87.16.1763971116547; Sun, 23 Nov 2025
 23:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
 <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org> <aSF97DVdACd7h-LI@vaman>
In-Reply-To: <aSF97DVdACd7h-LI@vaman>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 24 Nov 2025 08:58:24 +0100
X-Gm-Features: AWmQ_bnFVEXOuKYb9j2pc5yJlnN9LcrNBHyUT4HcQ7ozcEEzYxWhG4VU4QDS380
Message-ID: <CAMRc=McGzOEOKqkdtArALWTm3WjKNtgcw1VZzaz_7ZPgFqh=vQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: qcom: bam_dma: convert tasklet to a workqueue
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 10:10=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrot=
e:
>
> On 06-11-25, 16:44, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There is nothing in the interrupt handling that requires us to run in
> > atomic context so convert the tasklet to a workqueue.
>
> The reason dmaengine drivers use tasklets is higher priority to handle
> dma interrupts... This is by design for this subsystem.
>
> There was an attempt in past to do conversion away from tasklets [1]:
> We need something similar apprach here. I can queue up first two though
>
> 1: https://lore.kernel.org/all/20240327160314.9982-1-apais@linux.microsof=
t.com/
> --
> ~Vinod

Ah, I wasn't aware of this. I tested some simple use cases with QCE
and it worked so I assumed it's fine. Yes, please queue the first two
ones and I'll revisit this later.

Bart

