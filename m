Return-Path: <dmaengine+bounces-2737-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C81B93BFB3
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5631C2142C
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D632198A3D;
	Thu, 25 Jul 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/2UQy7C"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AB198822;
	Thu, 25 Jul 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902073; cv=none; b=q9t2Ri9Hy75X5QX+K17iaL7a4Ux36N4yyD5xwKewsJCT06erDMkCwfbCLdLe5SfJD+RLoTIIiSHuQAnMPao2opNF53+B0HLcEmas5Hmb43VdGxYs79FzQLoBx8+9eZbmOLNAC6GAd0pvtgIEcdwE7FZyG+IezkpS4okh5xw6WEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902073; c=relaxed/simple;
	bh=NZZtN0VCcYttTqcOC4cpJJ/bAsc+jb9SL5tobmej0LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUwbuZPrIZy630+Eie2GjxLbLzKNo+3RI3LsKx6DuD4EbfVl3Q647StjzJ+n5bi0tXEsPaBWwbRx8LroDUmH/svKXZTzGOxj4v0t8tC4mg2YkTIVfz2+UhcDS3e+9LFFEJSOQK4YC2KmjlyEEdw3AyuwhpmzgGbXPXxokteVyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/2UQy7C; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efa9500e0so687155e87.3;
        Thu, 25 Jul 2024 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721902070; x=1722506870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD42VmJRlxXsGWTnYAPzNLw6t8bjEMubS59XLOw/47w=;
        b=a/2UQy7CpXP4asDw9O3+G4/AE2ZPuewB4vfPFOatW2kz4/5jYLvQSawZkPYjjZxcfl
         /ODVFZr7bKvEKdDBELx5eqq2ZakuWp+UgUQJNoxxnh8AodoJiqRARvWHHx63sohpuJce
         B0lhOJGyaKmVSJhBEMUtOLWn1cpJaXrw9bRTj22Q8FKZGbLy/7Tom7tm5kyFoWRuANFD
         oJfpVB4+MkFFkWLoM9207DbHYHELvoxIM05snWRSV2G2vV8N3f9+6XfsNjpOZvLVi2l1
         LmKVmz9Y83qhp3C1hcFUMjtWXxh4BdZZbo54Xe+YSuLMFJDdqhMQR4MGwHKc6zjqOOKW
         em9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721902070; x=1722506870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD42VmJRlxXsGWTnYAPzNLw6t8bjEMubS59XLOw/47w=;
        b=biWma7xrwhHWveTDuPIpNQMy+cUrlYTRvaYiH8LqfcYKwXrTQ3vTffOzjn98KDDcsL
         ZrwldJj3RmND6bcSGBfS94xh258+0TUhHkq+HYse21V/XeSpfuHtO/O8kWVEmbuAqPxy
         eD6J67fTgsB6Bp54sU7Wh4XADMxbibGQPRvscyI/gsHSpx8LTPUKCOKss0eYU8kEPqCX
         +2/BHyE72Y1MTm/Qdd2rc35aqiUhglTaUx4metMU+g2AKHwsKsMMLgVL3kjqXIVi3JUC
         MxzHmb8JfkPJsDy8Hp2JVzu9K/JGADDDgYXeTbKC+jorLGuw/8CuBOMsldSNLq7gKWv2
         BeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3ohQZzPqSTUmpBzeiPMBWmmYv+YUFtO0HYzlSL9fJLfUdddf0loJoAad2rp3nkFJk7+H5NQUVDaPkAX35dc9iQe5CG1WLcoE5uPE2iKJMxVCN/3ZJIJqrzLEd0NpDlxKWkZnkJVr1gsJtf6yVZjUQdJHlQecTg/zYYtRZB143e3SdHr9yEqJNjcYYJR6dYFqCKuUhxe5/hVrsfvNZAE=
X-Gm-Message-State: AOJu0Yw1BPnV1kZ4xllhvluY8A1bBOLMkocHLiclyhh6blusWLUZTSTd
	WnhlkquHc0huJqQKu+zDYqPY1yZw9H1oziD+MsDMmpfWsb1v6Tw/A4OLPBgzkWUH3YzszL9POXZ
	gkNM3RoAaUsfw9KeErelopPwDvQw=
X-Google-Smtp-Source: AGHT+IF4IFL3+gcH+1199eJGE05ikuNcJwCnDJTe11RZIgz0eMjtD/WVR0wukU/wKD9o3kdpX5aJ0JR2FJvm0WDgo3g=
X-Received: by 2002:a05:6512:3dac:b0:52c:df6f:a66 with SMTP id
 2adb3069b0e04-52fd6092895mr1147948e87.58.1721902069431; Thu, 25 Jul 2024
 03:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-loongson1-dma-v9-2-5ce8b5e85a56@gmail.com>
 <202407140536.iIizeGVy-lkp@intel.com> <ZqHpWKLhRUi0N5Ps@matsya>
In-Reply-To: <ZqHpWKLhRUi0N5Ps@matsya>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Thu, 25 Jul 2024 18:07:13 +0800
Message-ID: <CAJhJPsWi4Fs3o-XmDStMtAjxcdbobWXBy2ZopgdHftf_JMA19w@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/2] dmaengine: Loongson1: Add Loongson-1 APB
 DMA driver
To: Vinod Koul <vkoul@kernel.org>
Cc: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>, 
	kernel test robot <lkp@intel.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 1:57=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 14-07-24, 05:11, kernel test robot wrote:
> > Hi Keguang,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on d35b2284e966c0bef3e2182a5c5ea02177dd32e4]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang-vi=
a-B4-Relay/dt-bindings-dma-Add-Loongson-1-APB-DMA/20240711-191657
> > base:   d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> > patch link:    https://lore.kernel.org/r/20240711-loongson1-dma-v9-2-5c=
e8b5e85a56%40gmail.com
> > patch subject: [PATCH RESEND v9 2/2] dmaengine: Loongson1: Add Loongson=
-1 APB DMA driver
> > config: i386-allmodconfig (https://download.01.org/0day-ci/archive/2024=
0714/202407140536.iIizeGVy-lkp@intel.com/config)
> > compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240714/202407140536.iIizeGVy-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407140536.iIizeGVy-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/printk.h:598,
> >                     from include/asm-generic/bug.h:22,
> >                     from arch/x86/include/asm/bug.h:87,
> >                     from include/linux/bug.h:5,
> >                     from include/linux/fortify-string.h:6,
> >                     from include/linux/string.h:374,
> >                     from include/linux/scatterlist.h:5,
> >                     from include/linux/dmapool.h:14,
> >                     from drivers/dma/loongson1-apb-dma.c:8:
> >    drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_start':
> > >> drivers/dma/loongson1-apb-dma.c:137:34: warning: format '%x' expects=
 argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka=
 'long long unsigned int'} [-Wformat=3D]
> >      137 |         dev_dbg(chan2dev(dchan), "cookie=3D%d, starting hwde=
sc=3D%x\n",
>
> You should not use %x for dma_addr_t, please see documentation
>
Will fix this in next version.
Thanks!

> --
> ~Vinod



--=20
Best regards,

Keguang Zhang

