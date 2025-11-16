Return-Path: <dmaengine+bounces-7182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A278C60F58
	for <lists+dmaengine@lfdr.de>; Sun, 16 Nov 2025 04:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71CC34E1FAA
	for <lists+dmaengine@lfdr.de>; Sun, 16 Nov 2025 03:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D35220687;
	Sun, 16 Nov 2025 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X12iNoLd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DE1F5821
	for <dmaengine@vger.kernel.org>; Sun, 16 Nov 2025 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763262582; cv=none; b=E1oPYk6Dx5Z7xR7BJiS8IzU31PY5ZfJrRcvYLoTJP5nSZjVjAFM9p3bf7LlmglSddpWpsxapfCWzyg0vorYR9PJzk5tpFoKxZCsIEZIrRChDKQw9AljKaxhUrXsdkloVTF12eeLnAKIjvA8lGIKqX1k0Te7OkGlGP1SRIYrOIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763262582; c=relaxed/simple;
	bh=atY9y7GGqa2zG7tebr9XLxy0ggIrfaOaHDHwyEx2Zhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHiqZCLOvCsO+z+HG7DF7GzdOBMmLtDXZ6tQwgmSSlYHy4CJu6K7JMjPbZcVCkTbm60wxxqpiXCDxJuhstscH8OxQeE0TzAD1cJ3FQ51PvSeZZrIXQyBtZuZNH5UHEyacuSjPtVyxqYACV7jCG9C16Q2i6C78nrwjEHKVGC3pqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X12iNoLd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-594285c6509so3231250e87.0
        for <dmaengine@vger.kernel.org>; Sat, 15 Nov 2025 19:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763262579; x=1763867379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwhoLl9bGZVzUZ+/CJVXxclpRGhyNNTcXAG5DCFxERM=;
        b=X12iNoLdKuexKcPsKI0PpospksomFKThI3J9aa54e1Pdj7iwT6gIfkYDPRpAaR/6RX
         bXJ3DZFLSh/2XOFKk69UqYLOcbubTnWV8idQZo84o5q983mgpc2gNp0kJc+kWCAUZzaC
         978cHhIlEazYMZhAg+DoxmNF1lPKZj/++IDgD7PLEINhrHmq/2+YqPg55+X/6u/Xffw5
         /Q2nn1/7kcos4mkLdeNqIaIEGidRktBIS4/gQAISAKJUqEcIKjO+gbflMZx5T66k39Kb
         h69iTwaljlwHCS/2se9HyamTzkvgzwaVU53lUSCPKg9VoNFw45KZjrzAWgZsSR3S2lP3
         zI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763262579; x=1763867379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwhoLl9bGZVzUZ+/CJVXxclpRGhyNNTcXAG5DCFxERM=;
        b=ZY7OV4HH2M9Nn6p1pQuXD2Z+Hv1s0dm+9wK6HyvFwIm7WvL8PcYbTMTV+LWr081xLm
         f6Tx//bEv7lmJA5xTv9lZUmkYzCxhQnP2cCcCIdOhzrORDAYXMCnJLRFiIXFOTonvh3f
         8T1zGhGR6XEDLWmKJ1QPpOFCVV1kbESn5gTRGjf5ni7WjbG7RwiVPm/DtcfiNyXXnGsn
         f/nOCyefege1xZabSSAaHkNsL84gVCoYPmZva60HSwIEOUnKDritZ9nYDQH+KMydiGIf
         9UevHCBRv4NwQnq1wRPN/nvdePtmduEh/G98xpy1fsrvIXxOO7Qt7ZPAIDwvw/gKgSAL
         waUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb+jrMnRkPWES/+W02UfhGJ+LCyyRjjjByD6+zmjW7Vdk/ChZH1M1UX5jocCYygoLaNL511bH1+6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CVF/rkTwNqFy87dLfGopA9hP8Boa7ioqa4t5yPunLh2cR9GL
	OmsJyE0pR6cGG27fRwGG9SMzmjcUk7c90Ta9AvZfuYTycCQx7+iFEWr3ydqsEiA85EDiE832fxz
	Mdk6fLWhkORMvQ8Y7ZxOO8yR4NrAtg3U=
X-Gm-Gg: ASbGncv1gddJsgjJNGla4MJ2qVy8GJyvSCEVTvZ3ipQbzJQ7ZdPDTkgDErqYcsT+7JQ
	W1QAg1kQHdvY6U2l8vTlWB2zZQLsL+KB4ColUQWe1dZFsHXi7YikiprntyssNpUSBvBZqt1XJQN
	Ah467hoshjMJ5LWPI+R9aZ2uXr6B+bIc4tMScLy03S9qjv4As6TWV+Yu7MIRNJbXUyE9mZqm6Bj
	YR9+PCeYCi28FtN9HtFwQZ9+ylIqvK7tjBKlnOgJHgTrgmPGlj5GWaRkDtaa3oMkbKvwWTIrfHn
	BS4LTaqRXYf+9jUcHQ==
X-Google-Smtp-Source: AGHT+IEMXhC4/qX8p01/4TItyFnrogOzpqPwRybEBfpc44Xyxht8M6N1UsPhSPX/Oyg+xuOzQOZsEoLboGF6Av/haqg=
X-Received: by 2002:a05:6512:3192:b0:595:7e8e:3bc4 with SMTP id
 2adb3069b0e04-59584211818mr2654334e87.42.1763262578367; Sat, 15 Nov 2025
 19:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110085159.754528-1-zilin@seu.edu.cn>
In-Reply-To: <20251110085159.754528-1-zilin@seu.edu.cn>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Sun, 16 Nov 2025 11:09:01 +0800
X-Gm-Features: AWmQ_bkLJ1jhy0aBouMS-dTUr7ncXyD2QQ0NKv_GX7HBxZMzzqqIiRSxFciIXCM
Message-ID: <CAJhJPsWaa+PN--YV3TXwquW1qLBF-Q=0a7z4kX6pLDyU-JKQ1Q@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: Loongson1: Fix memory leak in ls1x_dma_prep_dma_cyclic()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: vkoul@kernel.org, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 4:52=E2=80=AFPM Zilin Guan <zilin@seu.edu.cn> wrote=
:
>
> In ls1x_dma_prep_dma_cyclic(), a descriptor is allocated with
> ls1x_dma_alloc_desc(). If the subsequent allocation for the scatterlist
> fails, the function returns NULL without freeing the descriptor, which
> causes a memory leak.
>
> Fix this by calling ls1x_dma_free_desc() in the error path to ensure
> the descriptor is freed.
>
> Fixes: e06c432312148 ("dmaengine: Loongson1: Add Loongson-1 APB DMA drive=
r")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/dma/loongson1-apb-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-=
dma.c
> index 255fe7eca212..5ee829bc5c77 100644
> --- a/drivers/dma/loongson1-apb-dma.c
> +++ b/drivers/dma/loongson1-apb-dma.c
> @@ -336,8 +336,10 @@ ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan, dma=
_addr_t buf_addr,
>         /* allocate the scatterlist */
>         sg_len =3D buf_len / period_len;
>         sgl =3D kmalloc_array(sg_len, sizeof(*sgl), GFP_NOWAIT);
> -       if (!sgl)
> +       if (!sgl) {
> +               ls1x_dma_free_desc(&desc->vd);
>                 return NULL;
> +       }
>
>         sg_init_table(sgl, sg_len);
>         for (i =3D 0; i < sg_len; ++i) {
> --
> 2.34.1
>
Reviewed-by: Keguang Zhang <keguang.zhang@gmail.com>

--=20
Best regards,

Keguang Zhang

