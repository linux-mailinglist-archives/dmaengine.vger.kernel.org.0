Return-Path: <dmaengine+bounces-6377-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825DFB43456
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A85E3A2940
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475D2BCF6C;
	Thu,  4 Sep 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Qa/594VY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEF2BD013
	for <dmaengine@vger.kernel.org>; Thu,  4 Sep 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971516; cv=none; b=sRBLa13cogE2R/tsG1IE68v1eHR/JIJgO0130IxX9JUHMT1MqiZvvXVMcJk7k5xObEgcoB/RMdUr63C/cnWvJt6AggoTfm0Yt5OJsACP4g0cB81EyziDCIk0O183NZli6cN91N1Eo5UcwlS503uK47hO80TajQdE+ClIxZCXejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971516; c=relaxed/simple;
	bh=FbWK51zuCaG8lucEmAI2mMSW2LMRM66FMsNCbZr0bsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jG1NH0c2xCipx8fJEyZbukvFhNs5SfWqZaFEiS7OMivKxuhPZ8sWoG6eB7hi5piV+ZrlSCAlrw0s1FL4LwnwuvRCClRGRfRpfKf7d/p2rgNG2ufqAYNU5fa8+9gmZwO9RparifLL33u18LzRqj9eDicuPAfkRYma0TYlPofWv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Qa/594VY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d601859f5so7382687b3.0
        for <dmaengine@vger.kernel.org>; Thu, 04 Sep 2025 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1756971513; x=1757576313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgZhEVyr6juMKHl8gJtC0+SUexeCcUE2zJAQWjvjjYs=;
        b=Qa/594VY144d8eUYeEDOopGKk3mz6bShQeBJSj5P6Oto5M+ZRqTfxQm3Qp33/XBEBa
         P7smKXEjdRdAppPabTCgPQo7QUyVETn4IjTmnrFj6qvQJm9EHps2b2csd9hWzoBPBTgw
         N8UlV03MKStQ1UDYreW0y3JXmssm1g4ygTT976J0dzDc4NTbEYlAisFlGJS+85avHpSv
         9ePHF7bvn2V+HNfDtLPOZIuBVoclRi+e94IzxyR/q0aqJYB6crD8YE7tk/ee/6SOXvqd
         QXZYHL38NMZ3VOC+gFgtK4WdAoSK4uHeEuRFRcQZ6Sthsq8ghezsgBd8j48e/3Q9HxZo
         L7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756971513; x=1757576313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgZhEVyr6juMKHl8gJtC0+SUexeCcUE2zJAQWjvjjYs=;
        b=fXGtL7JVzGIhNXMyC+97WfXdPaqsxIVF4Ci6X/xYaDJfSSjYWVIrd2QSud7r7IWMn1
         0QQ7YsnRehACnjx82v+KjSUzsb5qUO7kklKihYbFH7LZjryUr5aRwiI1sQaPaXp1vEpG
         T/rX5V01+KfoFaI3IlViMcSmxZfeAnp0QyTACs27yPcHtNEdPIs0l1RffjGaG67PfDfd
         bVH1vma53ApWCYR64cqUXWolt1WVJ91r12wPcY6owCtTOarGQ40w4+AbqkU4fc8EE5HO
         0IzZSoVt4SNmwesz0HGdKJzg3S1SSVDszOYDSaPF1b3oFccQCL0H980ZJgJcej8crF7V
         /1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXrXKzVGhR6P1jIHjZ6nFMcehCERc8FS5L0dgEcd2wyHxjNi8Fp1omtypQkZ3SxUFcnQP5KQ48UpOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hAiPPqrebQhPVV8Q9K48GBA5i1hBXVeXrKaX7Ukd1bxm+RcP
	dJXgyZTIHV8yvyxEuIbHdNG1fX/pw+a9Vm4pj5GDBjK54rY4Mua0Fo3TvH9cmA1QsVbaJwZZTbQ
	+sepVKfcCFjgds8SOQYNvES6nuxj5N3HutasixvKM6Q==
X-Gm-Gg: ASbGncs01LCG4YMARMI266yEcD4d4Sx3HGPouM9hNN92XbY++EbdSwA+QYWRFbBsHBf
	CXd5pe03b5Ck0Wtf57Xd4xQ5vsz9UentTGYZ4l8FUxAOYZpHWdPpRm931l+Rc53/A2UZF4UxXyO
	XqOr8mqdb1Z8Mavbl6DXmDbgVtlAQ8eSSHbw51Filzn5+ibwWtzQ97Oxt//+5H0z1smxVfDh9DY
	RK0ox7poeY=
X-Google-Smtp-Source: AGHT+IHAqMzaONaSYMHfHIGLX6FXI5tM+wIyElctL+Mo7Yefx4I8BbosB/7EjveV6AmnpmC/MA9KKw31I0NQom67AQc=
X-Received: by 2002:a05:690c:312:b0:723:8ccd:6898 with SMTP id
 00721157ae682-7238ccd7709mr174479327b3.10.1756971512980; Thu, 04 Sep 2025
 00:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
 <a07b0ebf-25e7-48ba-a1da-2c04fc0e027f@app.fastmail.com> <20250903165931.GA3288670@ax162>
In-Reply-To: <20250903165931.GA3288670@ax162>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 4 Sep 2025 15:38:21 +0800
X-Gm-Features: Ac12FXwiXF9IvfBYbe4zzNOtF-jes20CBabfcX8-C-vzxRaxmAjm9PLipHmDVBM
Message-ID: <CAH1PCMYWWkThMosDMW=wZZWZ8d_c4_zQWhJOJPKe354LPiV1bA@mail.gmail.com>
Subject: Re: next-20250903 x86_64 clang-20 allyesconfig mmp_pdma.c:1188:14:
 error: shift count >= width of type [-Werror,-Wshift-count-overflow]
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	clang-built-linux <llvm@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	dmaengine@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Vinod Koul <vkoul@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Benjamin Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 12:59=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, Sep 03, 2025 at 02:04:10PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 3, 2025, at 12:08, Naresh Kamboju wrote:
> >
> > > Build error:
> > > drivers/dma/mmp_pdma.c:1188:14: error: shift count >=3D width of type
> > > [-Werror,-Wshift-count-overflow]
> > >  1188 |         .dma_mask =3D DMA_BIT_MASK(64),   /* force 64-bit DMA
> > > addr capability */
> > >       |                     ^~~~~~~~~~~~~~~~
> > > include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT=
_MASK'
> > >    73 | #define DMA_BIT_MASK(n) (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n=
))-1))
> > >       |                                                      ^ ~~~
> >
> > I see two separate issues:
> >
> > 1. The current DMA_BIT_MASK() definition seems unfortunate, as the
> > '(n) =3D=3D 64' check is meant to avoid this problem, but I think this
> > only works inside of a function, not in a static structure definition.
>
> Right, this is one of our longest outstanding issues :/
>
> https://github.com/ClangBuiltLinux/linux/issues/92
> https://github.com/llvm/llvm-project/issues/38137
>
> This only happens at global scope.
>
> > This could perhaps be avoided by replacing the ?: operator with
> > __builtin_choose_expr(), but that likely causes other build failures.
>
> Yeah, that makes the problem worse somehow even though GCC says the
> non-taken option should not be evaluated...
>
>   drivers/dma/mmp_pdma.c:1188:14: error: shift count >=3D width of type [=
-Werror,-Wshift-count-overflow]
>    1188 |         .dma_mask =3D DMA_BIT_MASK(64),   /* force 64-bit DMA a=
ddr capability */
>         |                     ^~~~~~~~~~~~~~~~
>   include/linux/dma-mapping.h:73:70: note: expanded from macro 'DMA_BIT_M=
ASK'
>      73 | #define DMA_BIT_MASK(n) __builtin_choose_expr((n) =3D=3D 64, ~0=
ULL, (1ULL<<(n))-1)
>         |                                                                =
      ^ ~~~
>   drivers/dma/mmp_pdma.c:1323:27: error: shift count >=3D width of type [=
-Werror,-Wshift-count-overflow]
>    1323 |                 dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
>         |                                         ^~~~~~~~~~~~~~~~
>   include/linux/dma-mapping.h:73:70: note: expanded from macro 'DMA_BIT_M=
ASK'
>      73 | #define DMA_BIT_MASK(n) __builtin_choose_expr((n) =3D=3D 64, ~0=
ULL, (1ULL<<(n))-1)
>         |                                                                =
      ^ ~~~
>

Thanks Nathan for the information here and above.

> > Guodong, how about a patch to drop all the custom dma_mask handling
> > and instead just use dma_set_mask_and_coherent(DMA_BIT_MASK(64))
> > or dma_set_mask_and_coherent(DMA_BIT_MASK(32)) here? Instead of
> > passing the mask in the mmp_pdma_ops, you can replace it e.g. with
> > a 'bool addr64' flag, or an 'int dma_width' number that
> > gets passed into the DMA_MASK_MASK().
>

Thanks, Arnd. I'll send a patch to clean up and simplify the logic.

> If this works, I think it is worth pursuing to avoid this bogus
> warning/error.
>
> Cheers,
> Nathan

