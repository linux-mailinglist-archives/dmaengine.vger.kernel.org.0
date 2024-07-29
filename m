Return-Path: <dmaengine+bounces-2759-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EEB93F5F4
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8DA1F22589
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C361149C4D;
	Mon, 29 Jul 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH/nuxBN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE01148FE1;
	Mon, 29 Jul 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257764; cv=none; b=op1USOD/K/02nUjtCAyLeHnuR/CJEKDWVKj6IeMgmUbDmtFkJGdXoQNi4ZgL+5oeOvdz7WDrUwuaVfWMwtxnPNL/AkMnD67he3RS2ot4PJI+jcvdBUZYrBUKBFs4HezvjClfdQCe/uyOrPze9zEPRk9gSJAQhW/LtKZWNedwtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257764; c=relaxed/simple;
	bh=yp8Y9Dip8DSGCmHHwje5HV5mtF25REE/X+2S8lF6exw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPLmOPBrevrjGBvPn2zlw3Y/uLDv6n2kUTNkSnL7g9HB4FSyRs6W1tK5IT8sUTKpZtsfDS5Wn5CEmSa9xbbXEsT/VJNUe03CanojYan+mxHLBAdXrc28HGX9mdsDbZWGD7MzU5k/OzqB0/2MtoA1TPZL6KIGyDLci7jfR8NVDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH/nuxBN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so39987351fa.2;
        Mon, 29 Jul 2024 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257761; x=1722862561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+SHx7NLarzUQJttZx/UL50p3XbT43LUQzIyvyMh5qc=;
        b=cH/nuxBNmwpm1f7b9NNuTT4BAZ9LOotD18TI/zGU8S49oiAAQdLyIyzFuFLTCfovuD
         /NWmrbGI5VAFt3Z/aUdKpWyeEFuJSHDsbzW7sDSU3wx5Ad2mINIQBmVC5zAt4TrT2GaC
         6rCGfLIRNzIe5c1Wzvng4LVKOco7tvrFMQMhFEA4YIXKTcHKK05fUVKM++OjeZktgA8d
         Yr48y1LADcDK1y6e2+1WZs+JTK1oXwq1/MJCWWq8xlGBf4qD4UJJs49hGM9o4GUNqMgN
         spG8lDpA7XIQjO5o16Xt5qpf2pL6Wmg/RDqzBG7OtX4txArSaQ+DkEVy8NvsDTaqB6kz
         9DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257761; x=1722862561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+SHx7NLarzUQJttZx/UL50p3XbT43LUQzIyvyMh5qc=;
        b=FED+VIQ33xtoThO2zTHT6NuPv6YGqD/1nz3pYR8pYwBXrKpnx/IQEGARBadUuwHUla
         Ukq+Q2Nd8vRygCK2pv+WGS9bZc4qI4WOBzVHlJ+FVliUbAsBIgdG20TFEFtfKnyECvBC
         NtZVhoC0EB/LinNLNU19sWxHD7l+fAGEmVx+9iSX+fndx9ALD4gjCztCz0qJNDAlvqrH
         oSokljRWPNVWjzKPMRqxjPIf3ulOTbMapRjPPji9dVZ08pANCnbBiRAtaqp26kuYKUFK
         oJX0yIkkFB27HVPLFkDzCemJAfhRoqJ4Y1zHs53tNN/unj7rsfGnK1/83gfBCQ2nHAbr
         ie0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkp0YCRRrbcchXl3dJmSmv+LhqY53UyOrzXNWSyNiyGDMXJTUEmP9rxSyLImCyyXKaOx1gy4hIFP4aDSrl9z6m7i+PUbXSLjFOuKDfgFL8FlYWWtWzDCAJflfmGf25I2U1SuHa0fPAFmO5hQR/hc/KmnwSboXEkNYrMW4YM/bkx3roqCg=
X-Gm-Message-State: AOJu0YzD9gfrlvwChP8mwrrCgx8i6r6dg5aJpNPugiLfwviqK6PL36QO
	NwUTM+qO3xDrgl4XG69P7uAwr15yfwysdIyRClN3HHPwuivwk/bKnoj7TnPJ85m6vULcQ2y66Ur
	lApbDKKqkdQ790A20SS98qYv3Ia4=
X-Google-Smtp-Source: AGHT+IFx/JAJN6hMd2OA7VlWKt2ZMfRpaXKwoXE5AXkNHXjAt/8Vn3UBgg+/SdvA9YVDCyRXZkJUyfyKstWkcGE9bGE=
X-Received: by 2002:a2e:a314:0:b0:2ef:20ae:d113 with SMTP id
 38308e7fff4ca-2f12ee5abf3mr46470491fa.40.1722257760588; Mon, 29 Jul 2024
 05:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-loongson1-dma-v10-2-31bf095a6fa6@gmail.com> <624be618-1a1a-422c-85e9-be3e1d182adf@web.de>
In-Reply-To: <624be618-1a1a-422c-85e9-be3e1d182adf@web.de>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 29 Jul 2024 20:55:24 +0800
Message-ID: <CAJhJPsUb4KibbFtPJ3-byrsB2Yv82eGczkcysNrJjJ7WiYYhxQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 5:40=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > This patch adds =E2=80=A6
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.10#n94
>
Will drop "This patch".
>
> =E2=80=A6
> > +++ b/drivers/dma/loongson1-apb-dma.c
> > @@ -0,0 +1,675 @@
> =E2=80=A6
> > +static int ls1x_dma_resume(struct dma_chan *dchan)
> > +{
> =E2=80=A6
> > +     spin_lock_irqsave(&chan->vchan.lock, flags);
> > +     ret =3D ls1x_dma_start(chan, &chan->curr_lli->phys);
> > +     spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > +
> > +     return ret;
> > +}
> =E2=80=A6
>
> Under which circumstances would you become interested to apply a statemen=
t
> like =E2=80=9Cguard(spinlock_irqsave)(&chan->vchan.lock);=E2=80=9D?
> https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/spinlock.h#=
L574
>
Will switch to guard() and scoped_guard().
Thanks!

> Regards,
> Markus



--=20
Best regards,

Keguang Zhang

