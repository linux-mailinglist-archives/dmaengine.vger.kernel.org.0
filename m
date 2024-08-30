Return-Path: <dmaengine+bounces-3034-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED05965547
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 04:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0EAB21336
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 02:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A2B38DD6;
	Fri, 30 Aug 2024 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqTsl9jB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCA1D1315;
	Fri, 30 Aug 2024 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985270; cv=none; b=fBfJuwL3tW+IQULllC+ZSUewybQtp90ypOy8vnVpQQhGLmnkxo4RLc9SeJcLfsH2QdJlnw06yyRtvtT0d5CsoohYxjFELSZdyvAS+DpXYl2z2zrlDnRpZKy4YRq4CPkicJHJlUStgVZshTvRtheLDtSRPCUBxSeevmK6pxJNp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985270; c=relaxed/simple;
	bh=LOof/t2NUWiTeBa2AsgWfvL+WqDqQ6X+dghfFyiWXTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+QwXQUL0f74LJMKHquoh1tH8i+ZOIydkzJy4zTj/Rr3yoLlhynp7W+f7dvdYe+PHtpqMQnXb1nv9hvf2yTfbT4ykW2K7B0NRpm/Fve53RF2hMjK+lAZCQX+M5anlyA+oibAKHMqjrBwqa/Ee6+y/u+mqCf1Xm3PKpcLp99TLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqTsl9jB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c218866849so1614546a12.0;
        Thu, 29 Aug 2024 19:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724985267; x=1725590067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8Ad0vhCQH1uXxmJFwkA6/WDAbjLvvOwQmA263Zu0vg=;
        b=MqTsl9jB22+wLsu8CWlHTeTdVqWUdDxjg1ois4E/Lba2haGI+4rR00c0d+KR5DBtQf
         NkBJdq5JxDo4AtqXNGN20fI5wlePDBVl71EX7lEBn3MDaJ2bTWZr5QhSKLu3GhbuBm1i
         Q+ipM0I7zOUxiyS5idubYhSSVTXKD5NkTQ+tlXTgjjIPsZMgfI9yLLyf4+4EeJ5wlD9T
         czSa3phJBwNFqacdthAvMACwvafhz4EVrM9rQmEdL2vfC3WxNeyxfK61LSalmWnyJOY0
         ZiiitQdbTWtxnlxvSyzDzFjiCok0nO8gd9Dn8jIR8mVVlmjjop7MYsfO7/DjfVKuNNch
         VcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724985267; x=1725590067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8Ad0vhCQH1uXxmJFwkA6/WDAbjLvvOwQmA263Zu0vg=;
        b=Ku2r8MqpNEoJx9FuYizdU2smTfSa/EKGKN1FyAeDPMQA7rYtTRRFDQ37BOVISz6Cjf
         O2Kwf02cbQ9XieIcUnPU1nXuLLM8s9AEvx2bB3iLGGueORbtOUAif4E6jiV6sMWa+ChS
         bQdE/BhMwSuOEegXQfPs4fGq2tVzlEJuCcRurkzRr6RleVImS5aqCjgsdm10upzgKod0
         E40OhBBafUCduNPrRrN1gGgQvhokP/bTmqbJc3dAtGqqYkyT72oo2D3I+z1gx6LJyykF
         Pio8WfiSY3Jd5ntzbp9B8uwgQnAC7LXWNs/iO67Ag7/GogSkmHCxBGv0G8WCdKpG0ia7
         VoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/+rKLGCGCHST40bQKQQb3fO3WHI7i5a1qcIRe2Kp7OHnMEKyd9H9erZIMYc884ecUZyKVO7hbqUMRnfoi@vger.kernel.org, AJvYcCUv+1QlSmKsXPs0O/bcC+R2Qcqf8tSwcwhxD1f58nt30ErYsX0dnKNVO5IFs+fk9FPgdasLEPcuA9RC@vger.kernel.org, AJvYcCVUMoLFAdC5mpAylzKKq2CkRbPJdVIRcfxLarvUVLILkjYSFxRxCBhwTEEnh3J+QCTd2l981pKCqemo@vger.kernel.org, AJvYcCX/Bb6qoRsOrQZwiLZP4cwLy05iVIhDJBuSS1npoAq/KEFxx816QB+HvHDHEXAgaGsGN5PPO9zkGi5Jpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygAqk6RFzKVf8l/E3+yvJFFNQvDW7fxJZlFb6KFeZ2wWhjD6Dz
	uC8z4thxonXvdggdAXjCaPmNERdUap70K5/GO6eLUgcRr2pgBh7GX9Gt0HVGGagc5FhRIlsy2TW
	FsirAUY1v7VBf7K4C2XfB9uvJJn0=
X-Google-Smtp-Source: AGHT+IFQrNg75kF7kiJPUlYxIIiKf55yBoI6UVMLJgvVyo5i04fsIpAbiwR+z3ZW+wSuT9d0rrkbPaENP1uLevEziZQ=
X-Received: by 2002:a05:6402:3201:b0:5be:e01c:6b5f with SMTP id
 4fb4d7f45d1cf-5c21ed9feb2mr4182113a12.33.1724985266036; Thu, 29 Aug 2024
 19:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809-loongson1-dma-v12-0-d9469a4a6b85@gmail.com> <172495263311.385951.8113964072819506950.b4-ty@kernel.org>
In-Reply-To: <172495263311.385951.8113964072819506950.b4-ty@kernel.org>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Fri, 30 Aug 2024 10:33:49 +0800
Message-ID: <CAJhJPsVVSCnhS0dMXu-e0XTc-eHounx9RX7MZnCogJx-tBRerw@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] Add support for Loongson1 APB DMA
To: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:30=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:
>
>
> On Fri, 09 Aug 2024 18:30:57 +0800, Keguang Zhang wrote:
> > Add the driver and dt-binding document for Loongson1 APB DMA.
> >
> > Changes in v12:
> > - Delete superfluous blank lines in the examples section.
> > - Move the call to devm_request_irq() into ls1x_dma_alloc_chan_resource=
s()
> >   to use dma_chan_name() as a parameter.
> > - Move the call to devm_free_irq() into ls1x_dma_free_chan_resources() =
accordingly.
> > - Rename ls1x_dma_alloc_llis() to ls1x_dma_prep_lli().
> > - Merge ls1x_dma_free_lli() into ls1x_dma_free_desc().
> > - Add ls1x_dma_synchronize().
> > - Fix the error handling of ls1x_dma_probe().
> > - Some minor fixes and improvements.
> > - Link to v11: https://lore.kernel.org/r/20240802-loongson1-dma-v11-0-8=
5392357d4e0@gmail.com
> >
> > [...]
>
> Applied, thanks!
>
Great!
Thanks very much!

> [1/2] dt-bindings: dma: Add Loongson-1 APB DMA
>       commit: 7ea270bb93e4ce165bb4f834c29c05e9815b6ca8
> [2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
>       commit: e06c432312148ddb550ec55b004e32671657ea23
>
> Best regards,
> --
> ~Vinod
>
>


--=20
Best regards,

Keguang Zhang

