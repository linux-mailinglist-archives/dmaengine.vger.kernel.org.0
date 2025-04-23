Return-Path: <dmaengine+bounces-5008-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6130A98D34
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3352A3BFF6B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9E27FD63;
	Wed, 23 Apr 2025 14:34:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388A27CCD7;
	Wed, 23 Apr 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418882; cv=none; b=LiENEIoP1BEqMLNP4+/02rEjrtp2N76StUXszBdM4KvTQuVerAbIeiwbo+m+WvVJwFej7Z5RNTPKDDeFO7Y9tmWJN0172WB799B/erxs2hmlVh7I8iftgaymqG3xG+8RQflSIksuEC5yukMB+r0UNOq8QN8vkqcbkWogVb0sKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418882; c=relaxed/simple;
	bh=a4y38McJMKy/vRssLXic7j050ogA7R8SzlVsEuJfxXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4QV68AFvIdsoFDxiZf9/aC4Q2tYQBIHktbsP3Anc6OcDTMAwWxFVJeEzRxbRHORIduh7K7JadHpwyzrKdstjKFKb6L1K4sJmiyCDrAeIbRKJByAy/W4WMyyoZyLZXgy+ClFhPFWSFCvKhGKgjPHaVaM9FpFhVH1p67BvxhdfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c09f8369cso2046716a34.3;
        Wed, 23 Apr 2025 07:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745418879; x=1746023679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9rr401OufXElmvBl3vcgyDTpasOf1VvGYueuVS+Uto=;
        b=wCmv0BMGv20hmwQVIcYcwElTWK/uJjjlftryEeyKVszRCnW9VOOc0S8hM6dV0WfwNE
         LkDbOpwiIRgpxi1wRekrX8QR5qJ/dDmo/ht5gtren7zFVjrVQEpI6abO3/nUf4hwZUZx
         vAsdPBK8pKC45sgKnG5Js89t4Y9oZcaxzMICcQojvuOMN3zocgfsmVY+o39MBG9TxeqP
         BAGKfl1gN6GZA+NgqsNqYtQndKC3yHn7OWwV13WgK9wnl1uEXnLf34mwPLy4/9pk04HP
         p181ZfbcUAv9nXyIRjKak+NzYwzRs5bUvw4TOrCxvFTRvvbBj9iSs13bZCYUx/g5ZhIh
         sumg==
X-Forwarded-Encrypted: i=1; AJvYcCVUMh5AVPFmhLmwk4PXlaMTjtYiMHlRsIujJBZ+/5y8ejZGlMXUerGPeh7NpleN6jh0I7YGZOfsbmo=@vger.kernel.org, AJvYcCVulTDqC+J+BEyhmRetVlGX7b5Aeii0q3uHZgbRxp7kffN/QJEvI1VirdN3GgWGY1qfhHGujWbJLppxiA7P@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaPApIlKppNUBVlt+JUYc64qCOeNqDrlxy9vJhEGGegWxZxA5
	MOhLrvTTgPUlNBefutAqFFsw5dqcJI1oea8243fMnUR0X/XdV81pO4A8w0Pwz7M=
X-Gm-Gg: ASbGnctVuHVaroQ6G2o2ZUL7XQUSLuB4hqjlecdys8nyzzRj5enGnUPgRhgY2atSr+7
	2e/hWHCJmKDs4K2gXToEUXOQ37sVUMDoBOdColE4v+6pU02KTinzwll0ClsiAblCuifABkz7t/o
	hUTyJA/Sn3t+EjwIw9YClSrkygZi5fc/8WbbHwY44nJ3AuZYV30yb7wBqbDS3JJetVIb7Q0pDZx
	6ijt4UYuRARUxxYIEji+0YNbbZUA+hSOE8akl40jZOG5+a0+NjRnyBR+Gr5iUIJLLJncTAhEC+x
	3tsAEWAvMtp4fcqPWd/eX3JgO7DikAtvMtouAhlyjLGVSRbuQGSyG/Tkajchnejwoczi77vVBep
	8wg/Txl6Y1iLU/A==
X-Google-Smtp-Source: AGHT+IHlzHCBDmy9BNkihH1ZqyB0xcMuxmZgs6yCc2qsrV0j7sHrbggCUuBKrVp9xUwskqJcsKjjjw==
X-Received: by 2002:a05:6830:630b:b0:72c:3235:3b99 with SMTP id 46e09a7af769-730062f6de9mr11561949a34.19.1745418878978;
        Wed, 23 Apr 2025 07:34:38 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300478c51asm2536121a34.8.2025.04.23.07.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:34:38 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7303d9d5edeso478837a34.1;
        Wed, 23 Apr 2025 07:34:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV00euaNTmKxQwHfvVKaLJ3cvaEJbgnyNAo/YofeL/hNHcgA7bJpeFJ5HOemRf8YqMYbmMhx8Ud7arPiGd5@vger.kernel.org, AJvYcCVmdhn/m/CyhpVLm/eMT7HMEoQEAtNnM4TjzoKSnwHQ9y8pfRB8zOnRA80m8xWpdnTpLPzQUKXyEfk=@vger.kernel.org
X-Received: by 2002:a05:6830:6687:b0:72b:8ec3:9297 with SMTP id
 46e09a7af769-730062f764bmr15710973a34.21.1745418878334; Wed, 23 Apr 2025
 07:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
 <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com> <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
 <aAjTg8dgvxqLQOwQ@vaman> <CAMuHMdXQKG0qptWMi169MVBL1S3hPo1TsaOSxWspoHAwRd+fug@mail.gmail.com>
 <aAjaPV/2DSyPAGRB@vaman> <b7557def-d0a1-4035-9586-a2651e28ab24@arm.com>
In-Reply-To: <b7557def-d0a1-4035-9586-a2651e28ab24@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 16:34:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWoxPc71YYrEMdPwdq-HOhmP2jNiwo1+-8o6_v4YJ0NHQ@mail.gmail.com>
X-Gm-Features: ATxdqUEnXX6HpwpOQNi-bNaBAYBUuz0gKv8TfTPMoWQoV5DcAvXfFibPzFN2Uu4
Message-ID: <CAMuHMdWoxPc71YYrEMdPwdq-HOhmP2jNiwo1+-8o6_v4YJ0NHQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Wed, 23 Apr 2025 at 15:29, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2025-04-23 1:17 pm, Vinod Koul wrote:
> > On 23-04-25, 14:13, Geert Uytterhoeven wrote:
> >> On Wed, 23 Apr 2025 at 13:48, Vinod Koul <vkoul@kernel.org> wrote:
> >>> On 23-04-25, 13:11, Geert Uytterhoeven wrote:
> >>>> On Wed, 23 Apr 2025 at 12:59, Robin Murphy <robin.murphy@arm.com> wrote:
> >>>>> On 2025-04-22 7:11 pm, Geert Uytterhoeven wrote:
> >>>>>> The Arm DMA-350 controller is only present on Arm-based SoCs.
> >>>>>
> >>>>> Do you know that for sure? I certainly don't. This is a licensable,
> >>>>> self-contained DMA controller IP with no relationship whatsoever to any
> >>>>> particular CPU ISA - our other system IP products have turned up in the
> >>>>> wild paired with non-Arm CPUs, so I don't see any reason that DMA-350
> >>>>> wouldn't either.
> >>>>
> >>>> The dependency can always be relaxed later, when the need arises.
> >>>> Note that currently there are no users at all...
>
> Huh? There is now an upstream DT binding, and DTs using that binding
> most certainly already exist - not least the one I have, but I'm not the
> only one. We don't have a requirement that bindings must have
> upstream-supported consumers.

Dependencies in Kconfig are not related to DT bindings, they only
control what can be built?

> >>> True, but do we have any warnings generated as a result, if there are no
> >>> dependency should we still limit a driver to an arch?
> >>
> >> I am not aware of any warnings (I built it on MIPS yesterday ;-).
> >> It is just one more question that pops up during "make oldconfig",
> >> and Linus may notice and complain, too...
>
> Well, yeah? It's a new driver for some (relatively) new hardware; every
> release always adds loads of new drivers for things I don't personally
> care about, so I press "n" a lot when updating my config, just like I
> imagine most other people do, Linus included.

Please read [1] and ask yourself if Linux wants to see a question
about Arm DMA-350 when configuring a kernel for his AMD Threadripper
workstation...

> > True, give there are no users, lets pick this and drop if we get a non
> > arm user
>
> Well by that logic surely it should just depend on COMPILE_TEST, because
> there are no ARM or ARM64 "users" either?

If you want to push it that far, fine for me ;-)

> FWIW the not-quite-upstream platform I developed on (a custom build of
> fvp-base-revc with a DMA-350 component added) did happen to be ARM64, as
> are some other Arm-internal designs and one available SoC that I do know
> of containing DMA-350; I am not aware of any Linux-capable 32-bit
> platforms to justify an ARM dependency, so I'd consider that just as
> arbitrarily pulled out of thin air.

OK, then the ARM dependency can be dropped for now.
I had done a quick Google search to find SoCs that contain a DMA-350
instance, and had only found a Cortex-M0-based SoC, so I assumed it
would be used on ARM, too.

> But then to pick another example at random, XILINX_DMA equally has no
> "users", so please make that depend on something arbitrary as well for
> consistency; it's only fair.

Sure, there are lots of Kconfig symbols that could benefit from
additional dependencies. Unfortunately my time is limited, so usually
I create and send patches for new Kconfig symbols only....

Thanks!

[1] https://lore.kernel.org/all/CAHk-=wg+38EHPKGou1MqXwAAXC30cM8sMgZAGnZ7TcFO4L9J2w@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

