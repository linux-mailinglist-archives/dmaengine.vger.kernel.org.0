Return-Path: <dmaengine+bounces-2810-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB7948746
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 04:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8301C21EC2
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 02:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3FA8F6D;
	Tue,  6 Aug 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSWMUM63"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447AAD5B;
	Tue,  6 Aug 2024 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910075; cv=none; b=AwDMC1hdLqrW0i2aH1vy1dDE0jQvye0D1zOYe6WW3kS565nIMAn7EvirYLV7ZKKo8tUslL+EtmLysXcoM1vX0wlootSZxa2PeKo72iOg+uo8P5WRDDPCFe4yNF3iWtEhihWqQQjn9t5ZJeTVtvHmN/vOJQvhf9947z0pe10fnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910075; c=relaxed/simple;
	bh=jt59FQqSI9OmpBDvj+W6jJgmftz6aU0OfR2v5brJ7QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaeUTE/+sWcB7pqGD4IZz0N6L3rgtYq8Dwz6Q/I54R/pmmqAdbBU6/8Yw/wffVM/lQpeBGKcE0gY+TyGy/rhvJMHIMYE6nJUDhw6j/Pzi7AdjXniel40GgBkT3awOzOOQKVeW8zIjyhphVZyVfhQ4r/PTQb75D9O2rUcxnJJIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSWMUM63; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so305581a12.0;
        Mon, 05 Aug 2024 19:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722910072; x=1723514872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH0hbgsnu6T52bt7D2n0S9Ogopg+qvghTIRm+AHbkMs=;
        b=HSWMUM63wnDcG39TIghtb+zPOQWxrIi4XpcJjoB2eKiOJSOe6qENf1LUIuwL05J5KI
         qEpz6BJ+inThRBqh/d4IV4Qi/TYrHoYN8C7YaKYj3isvGM9c8eWuTnaSzzBQytnnWder
         500WEh5vNzYo1Mnk9TH0NmHQ3uOW91xAsZJp1jcxdNvLsqKji/3Y6ZJ8TKSLN3d/6p7I
         YqR8Km8rsNgS5cLrKL2vzAAwjR5dgpDa++jrYz7QbM7cEjFd1zqmkrkZEJBsx2saBr4l
         FB221ssDiFMZYp3uUZnXnBPKr3ZYWnMtYJGzkH2xvs6ACnf/A04qkSlmz/isgXB8ufWv
         mrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910072; x=1723514872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zH0hbgsnu6T52bt7D2n0S9Ogopg+qvghTIRm+AHbkMs=;
        b=an/nJABF4tVURYLNZKyAxhZFwNwFnk86++umnRcf8BH74csk8xAKfw31AZuf2RXjZr
         gvOXD4eOvNquuAHor8n/kKNcjMOK2fOmOyGFHUlm0mRAe67AZc5cBIP5LTf53Co/Vcra
         OE7YhvnAeC1nzq2V7OVEjlCdceILDz8KPCVKbC3F/7SfbQD3WrxDy9Bf/rtHBcJHRMVT
         AI7LBbf0Z/l2NXfrjqDu6ePU9B9/+txGUSmg8PorhLefsAXylQiE5Z8n/Kmjwzc5qM7C
         bDzw+T9r4jjpQOOrwEZNou+xITlIRE9RfOXnJK0ku+hJEQj+YpcS+X0dW6mBarJEtGOL
         xKtw==
X-Forwarded-Encrypted: i=1; AJvYcCWtNoNDN0fMLy/mY3NVE10i4y8RqIrb46RxSspfX3q9K7I9jhvw8BKxysfJxZ8x/I84w1oua+K8Exm/uq2UZ63h3kavV02TYLhHyU4M0PQPxBlVLwganml8ambSQjENrNjFDJbyfMvrEHFU2W9JrxIC7rMlzDYtHaaVF9sJPMmpzRGmPoPD7cz33s7XkL7lRZ4WMO29okIvcp4+FziqETY=
X-Gm-Message-State: AOJu0Yye772b3rgfRKEp/9cMiJYFwBGNmaJwSR5ObVrVPzaVbwyBOo9v
	w1Kf7/iLV+ykiboy8dbJIMnnG3bWWsT5AQdN4GttsxEA+gycqgG0ffhc5F/0ZgU62vJ/UvgITY0
	Q2ngRZUD5xJPq+CHFbGXsUJP13dc=
X-Google-Smtp-Source: AGHT+IH8KdNlkin5gZxqjz6qSZjvvOQo2DyRfKySRIFg4fZEIJZgYjqB5SipRayRcG+D3+kKWg+MU4QoRN3B4OC72vs=
X-Received: by 2002:aa7:cf09:0:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5b7f5413badmr9781655a12.25.1722910071747; Mon, 05 Aug 2024
 19:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-loongson1-dma-v11-2-85392357d4e0@gmail.com>
 <202408051242.8kGK28W7-lkp@intel.com> <ZrEAaB_I1S2vM2EE@matsya>
In-Reply-To: <ZrEAaB_I1S2vM2EE@matsya>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Tue, 6 Aug 2024 10:07:15 +0800
Message-ID: <CAJhJPsX16-=HfDMWuYAPSuXL246Sn_L=j1=i+zpUPNK1mED8zA@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
To: Vinod Koul <vkoul@kernel.org>
Cc: kernel test robot <lkp@intel.com>, 
	Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:40=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 05-08-24, 12:58, kernel test robot wrote:
> > Hi Keguang,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on 048d8cb65cde9fe7534eb4440bcfddcf406bb49c]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang-vi=
a-B4-Relay/dt-bindings-dma-Add-Loongson-1-APB-DMA/20240803-111220
> > base:   048d8cb65cde9fe7534eb4440bcfddcf406bb49c
> > patch link:    https://lore.kernel.org/r/20240802-loongson1-dma-v11-2-8=
5392357d4e0%40gmail.com
> > patch subject: [PATCH v11 2/2] dmaengine: Loongson1: Add Loongson-1 APB=
 DMA driver
> > config: sparc64-randconfig-r063-20240804 (https://download.01.org/0day-=
ci/archive/20240805/202408051242.8kGK28W7-lkp@intel.com/config)
> > compiler: sparc64-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240805/202408051242.8kGK28W7-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408051242.8kGK28W7-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_chan_probe':
> > >> drivers/dma/loongson1-apb-dma.c:520:34: warning: '%u' directive writ=
ing between 1 and 10 bytes into a region of size 2 [-Wformat-overflow=3D]
> >      520 |         sprintf(pdev_irqname, "ch%u", chan_id);
> >          |                                  ^~
> >    drivers/dma/loongson1-apb-dma.c:520:31: note: directive argument in =
the range [0, 2147483646]
> >      520 |         sprintf(pdev_irqname, "ch%u", chan_id);
> >          |                               ^~~~~~
> >    drivers/dma/loongson1-apb-dma.c:520:9: note: 'sprintf' output betwee=
n 4 and 13 bytes into a destination of size 4
> >      520 |         sprintf(pdev_irqname, "ch%u", chan_id);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Pls fix these warnings!
>
Sorry for these warnings.
Will fix them ASAP.
Thanks!
> --
> ~Vinod



--=20
Best regards,

Keguang Zhang

