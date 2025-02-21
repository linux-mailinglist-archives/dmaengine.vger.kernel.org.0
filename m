Return-Path: <dmaengine+bounces-4560-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A26A40206
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 22:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FB27A5A52
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2E202C2B;
	Fri, 21 Feb 2025 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntbgDBND"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF520127D;
	Fri, 21 Feb 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173187; cv=none; b=eUyAWm08xxIVoxfRfBhXkbOS3Bzj4IhryPmA5S4kFo2CfuLJOvH/n5V//MalDL2+9/f7DCaJY8I9B1aYOL0dUSucnVtY2+X4bMGHBhStmt+wkkwwaf5uW2FNC1+f7NSqDKh0erU3HTpujeh9oe0muQGVRRdgIM+0a0tagUyE3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173187; c=relaxed/simple;
	bh=0JZr1OTYHU6I546M2sCDypnp4G0f0H3twdTm5RJTP0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPpiGba4tRW643GPBXZx6hNiG6dUmceVAz+1HCOM1ts4+mNm7MU1RePVyfoJyIW4oJuNCwvxantUq+hswgboHh2jUK2Gu33LRHdSueVCeCCgtgl140DXqQ5Xv78VA9DMpbcDMo6b09Q3emzu47mwSbrbGBfAgquBD1Z2KiF8pW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntbgDBND; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-52096b4e163so675237e0c.1;
        Fri, 21 Feb 2025 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740173185; x=1740777985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reoZdkGd6IKDiFN/Zy14cGrpEppzK19WZOoOxv4BnGA=;
        b=ntbgDBND9UleMurHkPbqIavhf4b5Ghnl+mEo+lRaduG9JY4xSO1+wybSn1FvQ5MyZj
         +5ace4/Ei43xPD1WUqywC5cK2kbI7U/h5JTphH9B3A0vK1FzzL5T8R4f4yk4wutdfzs0
         cI5NdbWwzNC1Cjrvi/HHz3S+vZ+0rAxIk10GhXGiwJteqjVnsO+fxduWvl6AI9tUzbyF
         1z4WN5sz56NuZv4KYCnQr87ilZFuaX/Itu4bfbRUiEGCek10qWT4KiaFoMwd8c8wlaWp
         R0W1XpZcHUARrH/IREleoQb5lRDQ+NRKnWM+zlyzkqdn3Ihc9vZYZUSyIaR4YJd0dQSf
         efZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740173185; x=1740777985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reoZdkGd6IKDiFN/Zy14cGrpEppzK19WZOoOxv4BnGA=;
        b=HwtqY1tGB/5JfioyWo8dg53qw3Z0Os9Ui8D+ZFTIg5xCoUwLjzhSS8OLPsPQDVqgr1
         OKK7oJVoFLLeHeskkIX9QswL0fXBP3f/tQCNW8g9msx0/AYNDTUw/8cY6J6xq8IYtOCE
         3BiNuIXKTgrTFPXeEV5EuxN3/+LkzHkh0+iIJkRMrgHZKxLT3E0MaytABCie+w0cH6ur
         y7UnZqk/flbDlQCyOq7hRSmrSqgmfFJKC6nJvPVGc9GYUrrhwyqcc+Ebc0BNcWMdTBz8
         JcpmomyO7HypIY0BFDWRdnUnq5gTPqXIf9h/sIhG5T+gIggBWfmoYsa7lo5ohuauOrJI
         c/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4NuJZNEphdA8Rf4lq4TZvBKPVdVyPhmWYPEt8deJeXbFPuZBkVXbKSV8oBZk8gXaMT4h5K42hKrEX6I1@vger.kernel.org, AJvYcCXAQCIDan4OS1J54dyh92/uNHODrAns4hb2l0ymWu1Y8ihl8jJ9d/mDvQoQiTl16hW1nlLJC0LAJrjCcwRRzG3YYAk=@vger.kernel.org, AJvYcCXiijTHA1SP+fFKJ1kCzJzxlKEWp2S6AE4a+024I6/Y+gy0QToZm/deCcmkmAASu55YvZCp0tjZXnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DvgBu8J+4NI1K4489O4/CCZRjkJH326fmDLBBFN4Jy6UYmmz
	JFXxk7sUE8hfk5Cp9mGacTG7vzDhL6SfUY6WS/YO4wkDMVvkDLoIJBO0WCTKFmvmYZOGI6WfuCT
	2rrg+BoyIWcOEePWb21bMSbPezmU=
X-Gm-Gg: ASbGncvU4gRj8Q0I4gHug6Bsv7kKkRtYQNIu7XZsus8Cy3k6E6byB+htzXod3V3H61r
	UNjf2s6ZjtoWtknjSQqGjxjTbqlDN5AIRvEUf5uoZXZGUASojDzMtko72SDnnqjXIMQAM6o/V7b
	Fw4qib5JSSuWiYQ6kQyDgJ5U/ff/+hnQaVHnaPQrHl
X-Google-Smtp-Source: AGHT+IE6UPS72YkSqlKZ+QYEzcPsJMmz0YCcgutaTCTiSHM5m4OFcCZsb1r7pyS+E5OKHwj5jTicJSV8EkBAW3O4plE=
X-Received: by 2002:a05:6122:488a:b0:520:3e1c:500f with SMTP id
 71dfb90a1353d-521ee45bc56mr2974670e0c.8.1740173185098; Fri, 21 Feb 2025
 13:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-6-fabrizio.castro.jz@renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Feb 2025 21:25:57 +0000
X-Gm-Features: AWEUYZmUQVuSUN907GGzhYeVZd-6WPU13YSQyfpxScQSV9_0kwPc0QsAQTvJNJs
Message-ID: <CA+V-a8tV1gw_m1_5PyQNzf=uRZmYr7N9RMiQxQF+PKxSOE6C4w@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] dmaengine: sh: rz-dmac: Allow for multiple DMACs
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:02=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> dma_request_channel() calls into __dma_request_channel() with
> NULL as value for np, which won't allow for the selection of the
> correct DMAC when multiple DMACs are available.
>
> Switch to using __dma_request_channel() directly so that we can
> choose the desired DMA for the channel. This is in preparation
> of adding DMAC support for the Renesas RZ/V2H(P) and similar SoCs.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v3->v4:
> * No change.
> v2->v3:
> * Added () for calls in changelog.
> v1->v2:
> * No change.
> ---
>  drivers/dma/sh/rz-dmac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 9235db551026..d7a4ce28040b 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -748,7 +748,8 @@ static struct dma_chan *rz_dmac_of_xlate(struct of_ph=
andle_args *dma_spec,
>         dma_cap_zero(mask);
>         dma_cap_set(DMA_SLAVE, mask);
>
> -       return dma_request_channel(mask, rz_dmac_chan_filter, dma_spec);
> +       return __dma_request_channel(&mask, rz_dmac_chan_filter, dma_spec=
,
> +                                    ofdma->of_node);
>  }
>
>  /*
> --
> 2.34.1
>
>

