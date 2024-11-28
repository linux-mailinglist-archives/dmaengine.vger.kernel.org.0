Return-Path: <dmaengine+bounces-3808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09D9DB531
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 11:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28A2B2677E
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501D15854A;
	Thu, 28 Nov 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcXYQsDO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E284E1C
	for <dmaengine@vger.kernel.org>; Thu, 28 Nov 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788071; cv=none; b=hYf4qO86Hrz6Kq4XKCmUKr6ogTBJUF71PPCEwU1CF5p8PgnZsD1K75kvKMXzslp+mZMbP1VH4MffFADNkWOSxPurPTexy4Hkpx202cEK5fDqyTEYbpm8tUUfLAAFiB0G4fMLvZTKCW+3+8bDhkDz2XjnYmwrg4UYokHkn3zbIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788071; c=relaxed/simple;
	bh=sr3m4q8NQ+yWL/GM/aZn5V9dc0T5vWuPfLus3LYfktY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgyPrMsOesoQkIgRTgx/StkorCLzNu+iQihCKRz1/Ui1HwaAUY1aVza3Rld9/qg4WO4wp49VAzuFD1RpZcmIWaVvy7ujCipZZfcl7fOmxTD8naky16YChaPEgghXurAZ6JG4RqSbf3xCWHodDZAZ/ll3wgI67z4PCGBIlEPOKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XcXYQsDO; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea55a2a38bso356016b6e.1
        for <dmaengine@vger.kernel.org>; Thu, 28 Nov 2024 02:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732788068; x=1733392868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JSLLTaqyAduW2ArQyIX+tknhwh7psIKkLCezIRIcTH8=;
        b=XcXYQsDOVnb5OSSZRZLXmh31hn3L6YyBR2PD/2RPec60zcwpDj7AsJFMikOmPsI4GI
         LAnZoIZODfViqK4ZaoRj4fSCyzSYvvGoEGme98f75LL3WYAB9bO1TWIJE/yjKiLJxnJy
         4DhXdV6LqwUJbHC6NW+QvTfP1/DXZBbBnfdxczJHYvaVDxGKh4EJjfSoyKsn3PmNI4Gp
         gKYnoLC6MESdtHXfGcVqAd9Ct3yH8g6PDS7gAPcgpVGMw81SJu+QkF28kJ9+Hy0va7/q
         c/anAN8ucdsXaO965M/Ulf9BxYqhqo6XI50wE/JUFxDeO3AW6isHdtWmWjtHB0F7aneS
         BLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788068; x=1733392868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSLLTaqyAduW2ArQyIX+tknhwh7psIKkLCezIRIcTH8=;
        b=qeonfniG8X3BCqTqsq2ZeJqp2eSJQsuaKxChHp2KiFo2fYtKsjuR8qUMFjjVCt7kFF
         0OLvvYDr9UKG4v9Q7sa2nhIcS5v7JRqw3lgI5KTqbQ6zHGTPEzLq1tSS9xHxeXzlqgKc
         9E/MTkzFu66bUhj+X+uDsSetrs83L2s2cg+DXf+2F1Y2tOzWcjoM1uSFXO3OCg5n+98y
         W3F7zZcFNf7UNSABE6advHFZjrtTfapKaw0BZzML0NJKyGIxk7mwUl4ShlIqnhGfSg4K
         wUr18L0TjMn8KUoBqRubdc5vSfWINvRo6uk59g0CGQsdHBDhyzZoWnGFvpILXBisGktq
         bokA==
X-Forwarded-Encrypted: i=1; AJvYcCXV+3PqjxeMgZ/4ABP/BwU2yrOMl/Af6V/zlCW1pBl28/f044DAZwa1kQEf154sSJ40TNOVkdT8iOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASBal/BUbGldSVs3NkxZbCRfKVAA7zanvE+3VqkucTOj9xTBQ
	nhMTk/6qoLFCF7n/axgiwpnv9jsPqLxVMExTOgnAw8r+J1EPl0oD8/LJL4a9OQbjsknPSjuV6EL
	u61TSDVDh7xy38zz7dVh7LsuTVF5tP4ZruMjdiw==
X-Gm-Gg: ASbGncusbm44YIQTHVDVF2L/9py3pwO3ECIRLQIcSrpffPW7hDB0WNZZzf3XRNROuvv
	+WsbqZGmT/kDvAFDLwcr9THi/G50gC36yTA==
X-Google-Smtp-Source: AGHT+IFQJ2vqlwir+TVj8VrxIEsFkK/0glqr+WYlo4RXfaelhJ1mOeWad0OAsfuEv05eXPQ6Wfy96mNVzfuVmE7f838=
X-Received: by 2002:a05:6808:d51:b0:3e5:cf3b:4fc5 with SMTP id
 5614622812f47-3ea6dbd5d8dmr6480398b6e.15.1732788068001; Thu, 28 Nov 2024
 02:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuaWJYQcxQ=3UqQbbuD_YNdOS_KB46N=mh47rxE049f-Q@mail.gmail.com>
 <20241125162354.GD2067874@thelio-3990X>
In-Reply-To: <20241125162354.GD2067874@thelio-3990X>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Nov 2024 15:30:56 +0530
Message-ID: <CA+G9fYuf6A+3gjNfifnd5cRL5oOU6HA2j-KXaaP90mskNVrV9Q@mail.gmail.com>
Subject: Re: korg-clang-19-lkftconfig-hardening: TI x15 board - PC is at
 edma_probe (drivers/dma/ti/edma.c
To: Nathan Chancellor <nathan@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	dmaengine@vger.kernel.org, lkft-triage@lists.linaro.org, 
	peter.ujfalusi@gmail.com, Vinod Koul <vkoul@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kees@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 21:53, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Naresh,
>
> + Kees and linux-hardening, since this is a hardening configuration.
>
> On Mon, Nov 25, 2024 at 07:34:22PM +0530, Naresh Kamboju wrote:
> > The arm TI x15 board boot has failed with the Linux next, mainline
> > and the Linux stable. Please find boot log and build links.
> >
> > The boot failed with clang tool chain and PASS with gcc-13.
> >
> > Device: TI x15 device
> > Boot pass: gcc-13
>
> Are the UBSAN options getting enabled with GCC as well? I am somewhat
> surprised that they are not agreeing here, unless this is a __counted_by
> related issue? Does this not happen with GCC 14 as well? It would be
> nice if we could get a copy of GCC 15 with __counted_by into TuxMake for
> validation of __counted_by between the two compilers easily. I did not
> see any obvious instances of __counted_by in edma_probe() but
> admittedly, I did not look too hard.
>
> > Boot failed: clang-19
> > Configs: korg-clang-19-lkftconfig-hardening
> > Boot pass: qemu-armv7 (Additional info)
> >
> > This is always reproducible.
> >
> > x15 beagleboard:
> >   boot:
> >     * clang-nightly-lkftconfig-hardening
> >     * korg-clang-19-lkftconfig-hardening
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Log details:
> > ------------
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 6.12.0 (tuxmake@tuxmake) (ClangBuiltLinux
> > clang version 19.1.4 (https://github.com/llvm/llvm-project.git
> > aadaa00de76ed0c4987b97450dd638f63a385bed), ClangBuiltLinux LLD 19.1.4
> > (https://github.com/llvm/llvm-project.git
> > aadaa00de76ed0c4987b97450dd638f63a385bed)) #1 SMP @1732428891
> > [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=30c5387d
> > <>
> > [    3.543395] pcieport 0000:00:00.0: PME: Signaling with IRQ 136
> > [    3.556976] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
>
> Can you turn off UBSAN_TRAP and see if that gives us any indication as
> to where exactly UBSAN_BOUNDS is triggering here? It is not entirely
> clear because we do not seem to have a line number in edma.c from
> decoding the stacktrace.

Anders made a new build with UBSAN_TRAP turn off and the boot pass
 CONFIG_UBSAN_TRAP=n
on arm TI x15 device.

Link Log:
--------
 - https://lkft.validation.linaro.org/scheduler/job/8008096#L1846
 - https://storage.tuxsuite.com/public/linaro/anders/builds/2pR6MSNK0MqztHMe45eAqWYlIaf/

- Naresh

