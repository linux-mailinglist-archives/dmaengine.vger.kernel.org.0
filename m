Return-Path: <dmaengine+bounces-3166-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF2979B0E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 08:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D5B21880
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2B39FEB;
	Mon, 16 Sep 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Gjd1Jy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721111F5F6;
	Mon, 16 Sep 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467394; cv=none; b=G/PaxMD1LxMDuVfZK6tQ2vIN4S3gC6VSYun7f1gvVe24D2PJaPK51TedwsvV3ym2j9ttb0ZQ1MDVTGZWUcF5tbvu+PHpwGbt1bYy47qup/n1MT2Oxhx4S4EtupHwj0mhXjZFzcI2lhA4BJpu9uYos04cB3BW+NgaOky26NcMdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467394; c=relaxed/simple;
	bh=aTB/qw9kD2XFLPT5/Fkbc2KOQyfZHYVKWvGk08K+AgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VC/Jqm4xBQuTwG9VkoP3uMEDzy/Dnro7FvglKLkXnorfouHJ/U1Iz8TfeJApf1utEa5qqPd/poahzklDrh6vyaZaUTzmbkxbhxxK1r/4j5rtjtnW0teeZcFVVl46yA4uCH2xVlDdwmOVbQcCqApJzEA2hzqRWil8BuaImbNBiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Gjd1Jy; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-49bbbebc26dso1331329137.0;
        Sun, 15 Sep 2024 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726467392; x=1727072192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/pWnXCVlNoJ6VkECBnDb2dCNBxxBagSxuCXe+0vj/U=;
        b=l2Gjd1JyEitRZ1w3nwVvpm085GHlb4BEL5hwUGyNAzK6iv8gd3iulFO1EhLcyElYqA
         LAztGfJ/I3T7Ksjf988EwHaGpg8Es8L7UnEK/larYb9Q9RiI205Hi4ZPYU0sKKtZXjCr
         9ZlYuynTC+9aasO9GFhxWjjtbsxNimdEEfkJ5ZE+v47YmUfOWx/lL8H21q7wp2upAFj+
         NUKVrHXn4+mHAPKvZmUxNvQGSD4vdG6+6HkJRNMGl00FCPNId5xozcYmgPk+PbimPcIy
         In+7eI4lGwpSIrsWTtLYO4+9EgqcgeIGsrl4plR5qJJltfRhMAY4we+NhH+y+mnPS8My
         ThKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726467392; x=1727072192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/pWnXCVlNoJ6VkECBnDb2dCNBxxBagSxuCXe+0vj/U=;
        b=lF3i80YcKj92ES3fa2bGZmnjDbVkufvu1Ge360zpF2qhQLEOsbYvtuQgg9Ygo9fYgI
         iPwJ7IS4CjKopwkwWP0tffqJYeE1zXyNX8Anq0x6Kub1J2YSOMIuoQWV1xs+ErE6XPRT
         uDz51mOFxjUJD3Vx7hmqvnxR2EDj6rfO9+yKImxBSdem0EuJoRTviJ5bhTO7Cr5MEpbC
         MuQNG1IcUZHuPs/rC2xP47FJ9dEQYS9W9h6x8Mxe8JZJO7R2wSCcT+AOYHiQyB15tEnu
         kO48rGUZik4A5mt0i3xP6HDT1jxZgryaoSBUwZP4J+dAM2PHAggFCUwZxwiyh1an4piG
         zViA==
X-Forwarded-Encrypted: i=1; AJvYcCUVoJrxbnEXT8ARzagG+CFUZHSqMzGFo0a9czG4w6WJwe5vKHE1HOkkVKqBwfypFbkxet13y8uZ8Q4KY0/j@vger.kernel.org, AJvYcCVHHey3ndOAW7GmSVLZikNINEfn9/7M2umhRHuZk+1G602iWKg8QEGZedhue9p++VDVd3lWC/6wOoVRnWQX@vger.kernel.org, AJvYcCXUnEuLiMBYhoN8J24tYQc19j+h/b/vbNnXpLZ6AnkiBCvNOKIdguW33/3f2nG3A8UYCOhkAf+PolE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yzTnHakuFIxGDu5DJ06c5bIbQbNaiEKecDzJSif6uAeKKlRf
	xe4GENCqS2NnjweyVSIXoYRKJNw3xaiQlsbk0u9Al5vZxwWnEt1PmZZ+9J90gjr2YLcWN5xRpXh
	Wm32MWx10dnwzcV7WAXX0GdYqrzw=
X-Google-Smtp-Source: AGHT+IHuDb4AshHoNGEtNLYb9Aqw/hI5Qvqs88n6Gf2duV4ShPpQUJ+XqeS6TANXDbbWCyu71nmrOqVR6aM2RpwtFvg=
X-Received: by 2002:a05:6102:ccf:b0:48f:db3d:593e with SMTP id
 ada2fe7eead31-49d41513e1fmr10472930137.14.1726467392099; Sun, 15 Sep 2024
 23:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714581792.git.andre.glover@linux.intel.com> <8fe04e86f0907588d210885ac91965960f97f450.1714581792.git.andre.glover@linux.intel.com>
In-Reply-To: <8fe04e86f0907588d210885ac91965960f97f450.1714581792.git.andre.glover@linux.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Sep 2024 14:16:20 +0800
Message-ID: <CAGsJ_4xREUbRWRZEO8EiEBdP9YN0Wip4_p58Cca=B4ZdPb7Mpg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] crypto: add by_n attribute to acomp_req
To: Andre Glover <andre.glover@linux.intel.com>
Cc: tom.zanussi@linux.intel.com, minchan@kernel.org, senozhatsky@chromium.org, 
	hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	fenghua.yu@intel.com, dave.jiang@intel.com, wajdi.k.feghali@intel.com, 
	james.guilford@intel.com, vinodh.gopal@intel.com, bala.seshasayee@intel.com, 
	heath.caldwell@intel.com, kanchana.p.sridhar@intel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:46=E2=80=AFAM Andre Glover
<andre.glover@linux.intel.com> wrote:
>
> Add the 'by_n' attribute to the acomp_req. The 'by_n' attribute can be
> used a directive by acomp crypto algorithms for splitting compress and
> decompress operations into "n" separate jobs.

Hi Andre,

I am definitely in favor of the patchset idea. However, I'm not convinced t=
hat a
separate by_n API is necessary. Couldn=E2=80=99t this functionality be hand=
led
automatically within your driver? For instance, if a large folio is detecte=
d,
could it automatically apply the by_n concept?

Am I overlooking something that makes exposing the API necessary in
this case?

>
> Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
> ---
>  include/crypto/acompress.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
> index 2b73cef2f430..c687729e1966 100644
> --- a/include/crypto/acompress.h
> +++ b/include/crypto/acompress.h
> @@ -25,6 +25,7 @@
>   * @slen:      Size of the input buffer
>   * @dlen:      Size of the output buffer and number of bytes produced
>   * @flags:     Internal flags
> + * @by_n:      by_n setting used by acomp alg
>   * @__ctx:     Start of private context data
>   */
>  struct acomp_req {
> @@ -34,6 +35,7 @@ struct acomp_req {
>         unsigned int slen;
>         unsigned int dlen;
>         u32 flags;
> +       u32 by_n;
>         void *__ctx[] CRYPTO_MINALIGN_ATTR;
>  };
>
> --
> 2.27.0
>

Thanks
Barry

