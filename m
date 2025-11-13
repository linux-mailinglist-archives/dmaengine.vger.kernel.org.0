Return-Path: <dmaengine+bounces-7170-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 170CCC58DDC
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BFCD54089E
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145E83451C7;
	Thu, 13 Nov 2025 16:23:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247AA269AEE
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050996; cv=none; b=pxqjG1Kbnw5g8fT+DW9am47O0qdKTMTaSat7pXiro3aRQCA9/l9H7yleICwle/FVLipTZtx1pKwGDsIJrUQQyyFtLUtv+Qd6g4IkGO9QgFXuupFuiI++84DB1hsd3iiYzz+C6EZKdJA1eObXbOU9kOOq2Gh9WKLmAT75VVy31OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050996; c=relaxed/simple;
	bh=tLAT9m5zzv27vIHramdo70fQ6JjFWjWlaXUWQOyCtIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzkBudoVqupPYIyVQHobht53qbB3vj0xS68iaiNvaD1fMFTxfQrJ1VH7O+ZS8NjWfFre1nk5xcKD8SSzH2PCSqttp470pmB9NgpowVKW9druoVYvchqXavRTcv0eH03cLlWsTeka5Q1fdAkNvvEBszFNXPJmDQIrSGIOxj4Ti54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dfa9bfa9c7so616239137.1
        for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 08:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050993; x=1763655793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5xOhgj3KLUbudZf/OSfykos9RtGD8I/iauuwMcQjwE=;
        b=eYvM5GFin5rBy8RHKCYsnBnLgAcK4ZBrEoIBeygza2YGvp0jrjr1X2HN1f054l7xTo
         KmU59KquuqZE0yHLl97NiXKC1d9s39n7kGdDLhQMpHUDRueNfb9lYXMTf3pZKmkoFKXE
         A7uPz95luXg6ejSo/SCzhCkGbIYSSzDmvDY1p6iaeomzdCiPRvJwCM32oqAKCHIO4qKH
         WD5W6QTQAs2+DuO09fpgoqi9Ekb6tS2onCw/oHXjAMOnBq4WuyUp+7dRtyKyjnrjTjAo
         bYBVimQCaqP0f/FPh17d7IULuNfrd8mGJCCdRSw7frxt32H3qG2iF6COjn5zSYzEipuX
         6mbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe8Pr6GhjVHWrke6hqdMfWkk++qou+gJqsdxcffAXVp+NdFLIsDtvcNbgOfCWdv7Mghjzh4ZjqOf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rACMvi7crThO4+WVQcDVrU/AvtucreWa7JzwUtPwkLEKcuOm
	bZbgMynvCvqyh/+HlE3P/Rfvx7ktysD4E+cCgmA/9c8h3zjT4d8v1/fF/kfFAlHd6vg=
X-Gm-Gg: ASbGnct17BQPIcGbpE9Xu/MgrdKapEd5KxIKAOH2tbaMqC6EVnsTY5CO46hG9hIGQV9
	wX2yonFgQ8AmSj1xl5h4AjfUooNuX/GDORmqMH8dbUbo+RknaFKF+BDE9N/MfrtFLrFbZVIG/SY
	Ejm246Qr160a7R43VuvpOdkz/aXWbXCkWCqiLMhPvSgTf9fSZa/24ydYwRPmP0H8rEg2OG9ziJ0
	/xZDqnn08gTyp8/3aSTMIPpN5EBHi5ow9UZR7uVcAUATcFnAmRvCWei/Lx3usIEHwlGQAbDG4nm
	DhxyuZODYtmAipS6MDzPxWA51gvi70KF03q8D27Cy0M5NaL9cVxN61Vszz3wNAU1823+ecPBkV/
	LfCmuwIYa4cKIhKfNND0kotZikDvtoYgAfTkD3xF0b8Q9/E3yVeak/8ELsrKr9domQoVaXR6qIa
	6zSU/uR8rbY4Mf6y+93oFQ3nC8LLj6JYXklXpvbw==
X-Google-Smtp-Source: AGHT+IE2cJrKNzGrWb+OGR65PYCFnUqRuqi5wM/cKOIrTQhzNtROW5aome2CH4g39i91+0QpUBnpxA==
X-Received: by 2002:a05:6102:5808:b0:5db:d60a:6b2f with SMTP id ada2fe7eead31-5dfc534561dmr224708137.0.1763050992745;
        Thu, 13 Nov 2025 08:23:12 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb7232a6esm739524137.9.2025.11.13.08.23.12
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:23:12 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93728bac144so586916241.2
        for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 08:23:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVa/tUOjzp1m3OfwisvMPdM5eaY+E1q3BOPOQ+wTiqH0jyV/snmTW7LuTJHBrtgu/m1MRpbs7g+MOQ=@vger.kernel.org
X-Received: by 2002:a05:6102:a49:b0:5df:b31d:d5ce with SMTP id
 ada2fe7eead31-5dfc567727bmr157516137.28.1763050991936; Thu, 13 Nov 2025
 08:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 17:23:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVP3xOGa4gj6LRBU1fdGPbihAayGF8xUCCZjJctyR-DOQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnISpr8jjnwV1qnu3HpPH36xFUGAy4ZFaDHn-fPMgUSA8TJ75exCa3iTno
Message-ID: <CAMuHMdVP3xOGa4gj6LRBU1fdGPbihAayGF8xUCCZjJctyR-DOQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Thu, 6 Nov 2025 at 13:53, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> After audio full duplex testing, playing the recorded file contains a few
> playback frames for the first time. The rz_dmac_terminate_all() does not

... frames from the previous time?

> reset all the hardware descriptors queued previously, leading to the wrong
> descriptor being picked up during the next DMA transfer. Fix this issue by
> resetting all descriptor headers for a channel in rz_dmac_terminate_all()
> as rz_dmac_lmdesc_recycle() points to the proper descriptor header filled
> by the rz_dmac_prepare_descs_for_slave_sg().
>
> Cc: stable@kernel.org
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

The code change LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

