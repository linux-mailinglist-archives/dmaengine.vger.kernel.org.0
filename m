Return-Path: <dmaengine+bounces-4991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED696A98955
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 14:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A559D3B93B9
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098620F09B;
	Wed, 23 Apr 2025 12:13:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E7208A9;
	Wed, 23 Apr 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410396; cv=none; b=iEgsmWeFNJSyvwzKOkK8ga2mPyYX+JZpGTt9l52iwAoi2uDU6KzVmux2wxpe2RjcD6nwrJVf/mhj9aGph3ZvOFyDC0HikgbaJQXzDpYM8zFmI8HByq8LrXk6Wl4ldbacsMXvVXRBIiheoaVBxSoOGI7oJoVZeaqchNDuAI8Odzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410396; c=relaxed/simple;
	bh=KqGkhnHt5KKOFsOH3M8g9PeFVH9Zptx5GLx5EOPrPfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrXhpLUwGC+235MypF+hwfBGIuAn8IJMzMeQDlPmipMMtwjVQma7bSJrye9VyfG81IRM2nwknH10soZt642cwS64t2bOV7a7cZcFIVzFa0bakf+W9XBdyfPaxZA/pBozLbFwIcWnhAgm7dS43ZIkeoGTncxFGC/pGc3q/F/osHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8ec399427so53684986d6.2;
        Wed, 23 Apr 2025 05:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410393; x=1746015193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SULH9E6OfOiuOFSn6JwiJGJUziMTX0yhjWJBPUXREo=;
        b=F3OqEBVBbCr7rZaUdKh8DRoQUCyvykdhB8TIbhcD4O9puu0Yp2/2VHX8C43VdKu8b8
         fwqMrgp0Sj4A5TrODuthGl0SPXU/X2wzeYVhzVYySp50+/sOR6sS4QNcaS0PHSFGRexH
         THZMMEgVzMz67YwzDmAWs+xvBhQ+2hw/38Xhb66/+AWcPiin0ca+3vMFs19gwiUIHWTU
         1bvti6JtNwN1Bn47rCqjjEivtSGsJzV2jMRuuCVyYv3jVpicMY99p7sKE+lcCPZTDpbZ
         xUksDIb6y9gdnBIc6sJ9AejsDZVa50Qj0TvLsU4/0GMIVjx4MZg5iH1TbxIkP1/209Ba
         5Q7g==
X-Forwarded-Encrypted: i=1; AJvYcCUm4zU5f3jATzI1kWLq8RNn87sSDyoSF8KgA1CGT4k9i/CVOwtf0Yu+lUCpqpSMZwpv41Fz4o5S3TaAZ67u@vger.kernel.org, AJvYcCXSVYrjgjL3Kl9Fs1CYKXkp97X1aoutZhlhRxiHUS5KDzFwOtl7LOQtvEP4BYzelan49pocpCavtWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhe6HlTouDAvO/eLgyjJ3+N/QpbY94upCvvmjYQL8vlYTII0b/
	d6sikaELVTN0ZispnWltoDlTX8j30uBJWFjeKz0PUeeraNVw58S1mBgm9/LjdGg=
X-Gm-Gg: ASbGncuRy2G5jZxENzuCRukqeUY3HZ3yuZIAi6cpB8rRNXyQPjOv7nNpYQ6ESG/dIPn
	etkGb+sqz+17LUl6eY8j4He7/bJw88j5PefAVT9S/N1V7z1dX17l84druQ7afeBSdmAb4vXeOLr
	P9rae46Px0bYap6Q7MT8MGkYOZuiVE8zfHjIfMyqFg/tfsoD6Mck+noxyMNlRbsd52Zo3g3++CA
	Mfju8NC/VqhJCGdASx9kwyYmxrijskxsKICVDJeiYhSKCrN+311Fyy/YCRC/A69yQoL1tuAbhgw
	WeurEDOhEMC92ddyAWCuTzwB0wA8/9d3mhZReQ1gBiwOs52PgXNypxin7l/tW1tZMWQEXLYYUEh
	mH34C4Js=
X-Google-Smtp-Source: AGHT+IHC+aFgtGnPm1xB2tYv6i0gBRJyaEuHgrZxESldA8k5vP8nflnZvzMDzP0HUBuySFtAFA48SQ==
X-Received: by 2002:a05:6214:1c47:b0:6e4:4484:f35b with SMTP id 6a1803df08f44-6f2c465a117mr243415966d6.30.1745410392701;
        Wed, 23 Apr 2025 05:13:12 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfd5f1sm69562506d6.70.2025.04.23.05.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 05:13:12 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5e2fe5f17so586831785a.3;
        Wed, 23 Apr 2025 05:13:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk8TDBFKfso/Xot0RN73lqBoXDbh3BuVnKWYJYksd6wRzQFcc736y7jp1dJ1B2q5XX1C8Wq2QvjYbZxUJZ@vger.kernel.org, AJvYcCWOmyxZAWWU3egZdfWJCMd7AeDOKsmZbVdcQs7gKdxDGU8RNQg466ufMUbR9AfUZWUiygzSyaE09f8=@vger.kernel.org
X-Received: by 2002:a05:620a:43a2:b0:7c5:cd33:4a90 with SMTP id
 af79cd13be357-7c927fa921dmr3570344985a.25.1745410392288; Wed, 23 Apr 2025
 05:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
 <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com> <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
 <aAjTg8dgvxqLQOwQ@vaman>
In-Reply-To: <aAjTg8dgvxqLQOwQ@vaman>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 14:13:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQKG0qptWMi169MVBL1S3hPo1TsaOSxWspoHAwRd+fug@mail.gmail.com>
X-Gm-Features: ATxdqUF4pJfouZNL-puYMjM6qiO82pNopTK5v4xVxIphHVZ_AGt4pYzszuXDaAQ
Message-ID: <CAMuHMdXQKG0qptWMi169MVBL1S3hPo1TsaOSxWspoHAwRd+fug@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
To: Vinod Koul <vkoul@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vinod,

On Wed, 23 Apr 2025 at 13:48, Vinod Koul <vkoul@kernel.org> wrote:
> On 23-04-25, 13:11, Geert Uytterhoeven wrote:
> > On Wed, 23 Apr 2025 at 12:59, Robin Murphy <robin.murphy@arm.com> wrote:
> > > On 2025-04-22 7:11 pm, Geert Uytterhoeven wrote:
> > > > The Arm DMA-350 controller is only present on Arm-based SoCs.
> > >
> > > Do you know that for sure? I certainly don't. This is a licensable,
> > > self-contained DMA controller IP with no relationship whatsoever to any
> > > particular CPU ISA - our other system IP products have turned up in the
> > > wild paired with non-Arm CPUs, so I don't see any reason that DMA-350
> > > wouldn't either.
> >
> > The dependency can always be relaxed later, when the need arises.
> > Note that currently there are no users at all...
>
> True, but do we have any warnings generated as a result, if there are no
> dependency should we still limit a driver to an arch?

I am not aware of any warnings (I built it on MIPS yesterday ;-).
It is just one more question that pops up during "make oldconfig",
and Linus may notice and complain, too...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

