Return-Path: <dmaengine+bounces-2952-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D84395CDAE
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 15:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8061E1C2151F
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B418660D;
	Fri, 23 Aug 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As401vIt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687518562A;
	Fri, 23 Aug 2024 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419329; cv=none; b=bBGl66z0YXsarVFmN7Lg3Z72tn5gqZjbWKBowkg4hYNAuhXvNbUS+S4nmWJhAtj4JYWSYqPuJQ3aU+BihI2ogW7HAnJuw9spSbMOcNF3Jc6+p17Q+OV8/IU9gdlgD97hZ9GRK9gcHgxwwlk1j+s3gkZa8QmnNk2fqcJFc+g41yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419329; c=relaxed/simple;
	bh=rKQeq9bwcqO/L2Pc1fcDLl8VQQ0iK8rcr8CMjfMKesY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4G3tl5fzJAmZ+fOcgGeXj5RiLDy+5HiEzGiPf9ISSHkgmvbQl4jnsDzM/D9glXqbZfsEe7uRARbQ6eQicJIQLO9VmH6cFkcLiMGSY7E6dW/MMKBHLieDAXp9AFe4o1vYgpLCsa5wJBdhdRT0ltNhzqZP0fV37eVhKS/qkQHrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As401vIt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f4f2cda058so8505871fa.1;
        Fri, 23 Aug 2024 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724419326; x=1725024126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKQeq9bwcqO/L2Pc1fcDLl8VQQ0iK8rcr8CMjfMKesY=;
        b=As401vIt6S3cGkGuIo5ksmamF2bihJh0dWesM9lt51/L1YiUEJTO0D+izmnntbkV2G
         7y70sR7KmPXVqld0PSjJTg5/LBS0apZkEfK3tLA1lImboc7gqxg8/xeBucepONHx7QfJ
         vL+lJEmDLLHiN3MVd9lp/wTIjvx0GkbhC1noQldqN9wJAzsMY47oZ7bzuzXiDlSOa2QB
         AiAgJa+kph/Id8vuZ2adIJ1/Fc/mvVWFiYAJV68k+FmoLwzpn2p5hvP0gXaw0eoHSHFW
         QSWJvPGcluSCdiHJCOgjUWBuhefHXlg8tbRYyteFzsEWohy+VG3TUGqnaq0KGPni/Uqr
         i7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419326; x=1725024126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKQeq9bwcqO/L2Pc1fcDLl8VQQ0iK8rcr8CMjfMKesY=;
        b=k4a5QPXLz7CVR+s4Z9ICs9ivDDA5TPN9OKCkPQuHzikHwxbFjOJgNfQNe6g6zHZIZw
         atXKn6UuLXr3QKbvXvITgMZBMwZ6lfFmxlSGkauUKuGIS3rqd8emb74kBeJHbc3Tsfpf
         JlXLSu7LNf2eRY2j34cHu+wq525x/xKts1McxK0oH3pHoNos3LNNxUvu4G5ee0ehEmfD
         OaHdMBG2PGwSM1HDHRMCq+ETQP3pxMxprDLyVS70OiEmaazdv9tVyJr5XIQBcvwx4II/
         Pfuof00lY8CvczpIz/UhQn0b8Tw8CF0564Nck2TI3hTDPfcZ7B+9uLXNfR7o2lpp/fUA
         8lpA==
X-Forwarded-Encrypted: i=1; AJvYcCVAzl2Jq6IykgBHcTUmQP9oAqSdRxDEbHTCDa4y179lloGBKOE1TAysDjdRVHjrZoAdE1uiZ0F7ktU7rHbv@vger.kernel.org, AJvYcCWTLLyUrnoz5l+Oi26/IGxbwybsf3Z3aZVINhXXCLD7V4u0aRaZcbAFB2gAgxLZfzoZtnLavredAHbu6fIo@vger.kernel.org, AJvYcCXAMeN88oRz8VsWVi2UxCNhN9y/TqXk4//oUn4z6bnbfomE4Ndh3X/etPYhfTlqZGN5De6VID3oy/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFf6xgGxSMpMt4ea/rpbcuasjfTNPJaYnAI2BG8NZ44F2R8Fw
	kuVaeyRpMX+mMCdpPyGcnkfWUNcN3L4e+DmSkjVpPXESHy2RDbweUxyC0pRbqfQzwdAkiMVSc1C
	xOpMtjMO7YL1XXWYGb/VvPc5gqUA=
X-Google-Smtp-Source: AGHT+IEzM+VHYtlD/p1yI/jFgtHiWv1VA11NrUMshIJ18cFE55GPaqypnHWhkeG4F3ahbzmUNS+DF7kuUVxSigjUdzk=
X-Received: by 2002:a2e:d19:0:b0:2f3:f39f:3714 with SMTP id
 38308e7fff4ca-2f4f491623amr8452071fa.13.1724419325227; Fri, 23 Aug 2024
 06:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080756.7415-1-fancer.lancer@gmail.com> <n6grskuq722vnogwp5obiwzv4pxs5bbqddadesffezhvba5cjh@d6shcrvpxujg>
In-Reply-To: <n6grskuq722vnogwp5obiwzv4pxs5bbqddadesffezhvba5cjh@d6shcrvpxujg>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Aug 2024 16:21:24 +0300
Message-ID: <CAHp75VdXqS6xqdsQCyhaMNLvzwkFn9HU8k9SLcT=KSwF9QPN4Q@mail.gmail.com>
Subject: Re: [PATCH RFC] dmaengine: dw: Prevent tx-status calling desc
 callback (Fix UART deadlock!)
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:48=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> Hi folks
>
> Any comments or suggestion about the change? The kernel occasionally
> _deadlocks_ without it for the DW UART + DW DMAC hardware setup.

I have no time to look at that, but FWIW with a stress tests on older
machines I have seen something similar from time to time (less than
10% reproducibility ration IIRC).

P.S. Is there is any possibility to have a step-by-step reproducer?
Also can we utilise (and update if needed) the open source project
https://github.com/cbrake/linux-serial-test?

--=20
With Best Regards,
Andy Shevchenko

