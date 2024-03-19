Return-Path: <dmaengine+bounces-1435-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BF87F578
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 03:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362C2282A8D
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 02:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418607B3EB;
	Tue, 19 Mar 2024 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJdxgW+m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BE17C2;
	Tue, 19 Mar 2024 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815573; cv=none; b=FsIVYQkg/298gxlH4++suOztrIVzXbu9RukQ8Obm0dLlw8Qhd3aSCeVvpwkNsBLMw6MoIQ9fAUDJVBxsK3fd6N5353dLhyN1FBdoWIrZSN0ZBrjDwBmG5DUcLLt9+vqeGRkCZOpTvOx8z4MJJQGfDkpZJNFg4orSrCVtb6nJInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815573; c=relaxed/simple;
	bh=Ce/1IR3gNnk5L+lz60Q5Bl4OJ4PXviSTM7ZU774ovAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieRHnhtkObGYrhchRpD7G8bZ3YO93BPV91qsL2OZAaYsZd2FawYMbT91GmPfIlpQrdHPm8Vu3T5bH1hB3uvEaNigHtcNr2OxvYTEy+wzyNxoLa1b9syzlglgWFhAGBg6edfC/YxQyRVrdEX6NuQPw1HMQ1B2K6AWgBzi4fBvuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJdxgW+m; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56b84b2c8c8so1434195a12.1;
        Mon, 18 Mar 2024 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710815570; x=1711420370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce/1IR3gNnk5L+lz60Q5Bl4OJ4PXviSTM7ZU774ovAo=;
        b=OJdxgW+mrW5f/uAfkYsO5PREcHVLQa3kf58V7sGKbniu8uOq/cS9CGQ7ENz+xODbzk
         yNbRNFLLm3Olqqpumz/QH32FtBrPHDmdLtqvj2E1xbJ24QMDhIstf0OrVHV4SrRPCnj2
         FNj3otHDKURCIUpzTSVUscAQ4D79wpgQlYuw4dj5FsJQFz6q3TNTiGu69U1mbNbKM+Pk
         pidHQ03/X0/2uciz/6O78jbH2BxmE4st58N1Gx96aQlW0nUbk0Gdo8jvWrlkVlU+PQeU
         OhfvmzW4lNfqnT9DXxoPsUWP2+JXdFQi4sEMTfSaL4dktZmOajDT8f+kNkE/TSD12QCx
         T5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710815570; x=1711420370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce/1IR3gNnk5L+lz60Q5Bl4OJ4PXviSTM7ZU774ovAo=;
        b=XqUqYk0LifjcdcuFC+H7B4in474jrBvictiUtB6Ln1NCtOlqgN7xVemucp9VKOpHMn
         mrFjrMxkoWryZn4kYZSLcuuoKK75W0BdrVcxlcEg6D+3k5IcQi6QoCdIAqWlG6wgKtAi
         /hLPD/ElANLfQruSPI+YLsWuXFX3k1d/Uz9jegMw5mAQmowOAbl9PtG93BS9fmla9LPB
         oRUCbxaGq+ILZXCasRXK+2icLt1Pw2W2Oz+kTitu56rgLYr2ahjmm2F7Cok5hKAp6pwX
         166WvtRe8G3DF7vCqRIwvK/nExuGmvMZqht439JZ0IbF2q1zjbrmtUBkxhsrc4NFBsdH
         CFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe920T/KgF8x3LfG59nFChWG6tulFpuAF+gC879j0V3vCFy+b0FqRHwWqqSG4iYh3TeRd08rWfWxuXALeryM15mOLQO1IOe54vLHTe2M3K+88K/Zl02UphcUtpao3RKI0qPfbnREDbxYqeUtIrWAPJ3L2JVWfuHUeihX1ni/ZIHOcsdTZKV8wRF8CZs7hIQ8Baepx+TVnTLwPe0Utksts=
X-Gm-Message-State: AOJu0Yw948A/JW7O62b/ErOYUMMN/LYhrP4D6CknPGaMRgWwAX6fG+a6
	HrHskbweAkBr7VimK95a+mHD7PlIpMrtTD79VW/fT2MLnrZolYIbFhNM5l/8LAVYtev+d6O2eR7
	fIOhj1GOiV6T09iPYWDtfoQx+tHQUP5vzXkLEoE0B
X-Google-Smtp-Source: AGHT+IGcnqQpgmL0r4nDawnHLqPYrukUQ4GWNgynKdiqKskSoiM6utARTdc9a8/6bqsNVmLnhHF5TWVzizWTA/J4Hmk=
X-Received: by 2002:a05:6402:2690:b0:568:d76f:ec6e with SMTP id
 w16-20020a056402269000b00568d76fec6emr3867142edd.21.1710815569611; Mon, 18
 Mar 2024 19:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
 <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
 <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>
 <20240318-average-likely-6a55c18db7bb@spud> <CAAhV-H4oMoPt7WwWc7wbxy-ShNQ8dPkuTAuvSEGAPBKvkkn24w@mail.gmail.com>
 <20240318-saxophone-sudden-ce0df3a953a8@spud>
In-Reply-To: <20240318-saxophone-sudden-ce0df3a953a8@spud>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Tue, 19 Mar 2024 10:32:13 +0800
Message-ID: <CAJhJPsXKZr7XDC-i1O_tpcgGE9c0yk7S9Qjnpk7hrU0evAJ+FQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
To: Conor Dooley <conor@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:42=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Mar 18, 2024 at 10:26:51PM +0800, Huacai Chen wrote:
> > Hi, Conor,
> >
> > On Mon, Mar 18, 2024 at 7:28=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Mon, Mar 18, 2024 at 03:31:59PM +0800, Huacai Chen wrote:
> > > > On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <keguang.zha=
ng@gmail.com> wrote:
> > > > >
> > > > > Hi Huacai,
> > > > >
> > > > > > Hi, Keguang,
> > > > > >
> > > > > > Sorry for the late reply, there is already a ls2x-apb-dma drive=
r, I'm
> > > > > > not sure but can they share the same code base? If not, can ren=
ame
> > > > > > this driver to ls1x-apb-dma for consistency?
> > > > >
> > > > > There are some differences between ls1x DMA and ls2x DMA, such as
> > > > > registers and DMA descriptors.
> > > > > I will rename it to ls1x-apb-dma.
> > > > OK, please also rename the yaml file to keep consistency.
> > >
> > > No, the yaml file needs to match the (one of the) compatible strings.
> > OK, then I think we can also rename the compatible strings, if possible=
.
>
> If there are no other types of dma controller on this device, I do not
> see why would we add "apb" into the compatible as there is nothing to
> differentiate this controller from.

That's true. 1A/1B/1C only have one APB DMA.
Should I keep the compatible "ls1b-dma" and "ls1c-dma"?

--=20
Best regards,

Keguang Zhang

