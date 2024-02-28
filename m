Return-Path: <dmaengine+bounces-1163-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA086B9A1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C89288FFD
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1818626A;
	Wed, 28 Feb 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WZdI/dYh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A5224DD
	for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154417; cv=none; b=UJN+XW7rTuWXtc4BljAOQSo/re7UkZJzlqygnTCcu2OdpGti/gVgsI+kBTO46To+IFR+xls71GeSpx4buFF9ml4DVSAOkybgEnf/bG6sLP5O8Q4G5zhjAN23vPZOdFMPnDDNLpy1dDY7Wfx5+1lO7mN4A4/FC0n4ysm4mkcAgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154417; c=relaxed/simple;
	bh=W1ZYBflfUhdAouE0pOYAV1USIGeEhj4/mDueEW2Z+Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJoNb2O2e5xzhuRIEDF2zSAt6TAxz/Pl+92IHUMTOhDfVY9MgChDP72XrlQDg2bWXH1j8NQGvGh6j+++fG8nwCSwjxG3yoEK2tptTVjb2+gwaO9O0OM+VU11UAnvpkQUF8kXbJq7jmeFEiVb87FZ8PI3sqMfDT5JPCPMq9cNNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WZdI/dYh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so2094011fa.2
        for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709154413; x=1709759213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmX+Mg8DwC1a64ptniME0FOf6Y2hLo/XRFDdCGOyX9A=;
        b=WZdI/dYhlB1hE/knlgq22/tGN86PkXRPvpgfxFsLKIDYmJMTPAR3xcTp84AJfJU/uK
         8UrwhBBM/O2g2DM4UCzlTjjzjJvs2zvQkWGKLdtEyIQCsJJC9VsjYGV45G1gVdscgrTZ
         0d4dWRhwZ879YLIL6sYAS/cTOgRobLZ5sJiw8KW5wJpgRGEVV5GQICGwv9yJlZHknPNy
         Lg0WcNvQjYS3qyopzDCNDCRbcq8RWpMszIPv/CfaowPs7y0O059aIuVcZbteZ1BHcANt
         vaSDcHkm3DxBDMwAoC9k5otjv9OaY/Oe432obKtVvnByRd7jvRIIxMs0Qn2EkPKRuXyl
         aCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709154413; x=1709759213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmX+Mg8DwC1a64ptniME0FOf6Y2hLo/XRFDdCGOyX9A=;
        b=lxc0luSiNN6AwgvlvtA8NWac/ftoWgDevJ577TD4UsSjwug8RiOufAVfSwSYtyhrS/
         ggk8BDaLOgRYhDcdlXu+DZ+hReOeCd6Cla5UcR/FPLGqJqXReSEeIJcTW+l9Ggraq2/V
         sQ4e47GtVty4k6YFy/FTwjdF+/qFjycrlyehMecxI5CRvUI+sGx/1zqvfjg/ypX9PUQA
         FJC/X2OQTaZkAC1jwSLmt9LEQIm6JzSUqOip/O/lmZPbOR+LpLWa0eCMQOX+qMQTtpUA
         IdNcrY0d7HHjFRfFTtZjsJx+ZOwl9Ky2m8san7GIkWXeRwo8PCwSOifrjHIqMTtS9jmn
         Qhrg==
X-Forwarded-Encrypted: i=1; AJvYcCWnZGtGIfcyznybRKQXEpAgJ1U6Kn2PDgDt6HVLRxr+WpRZXP58jPlqXSH4vBHjU8tnpK6dg57mFwYrsvLkBHPNbbRuNPiir5MZ
X-Gm-Message-State: AOJu0YxefKEkbEJU6UnoIjG3fDR682+TG8xVa1Sc8E0CH+N000KzmArA
	YW5SfjSjgpw59DZIG9PgOKTBNUN1VYJZ9mAaj8EeylZ0sPhHHlCoVkjsNwK6KOUqXHhr9F9rSEX
	+FHfSxpj4klG55ufNP7WhOng5wljhjPxeTF+3qw==
X-Google-Smtp-Source: AGHT+IHFKLqFU5Cgzin7P0k7JTCfB8cszu6gI0ABgsQXe9Y2C5+iENgDQ+Fh6N+s2L6qUDJ2dT/Ym/tDSlGQJiBEQrg=
X-Received: by 2002:a2e:2a81:0:b0:2d2:f6e0:5de1 with SMTP id
 q123-20020a2e2a81000000b002d2f6e05de1mr24236ljq.46.1709154413023; Wed, 28 Feb
 2024 13:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228204919.3680786-4-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 28 Feb 2024 15:06:42 -0600
Message-ID: <CAMknhBFbQ2BmGd18wC0odO-b_bWvJEO3FCYEtpvhB1fF+MEFgg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] iio: core: NULLify private pointer when there is
 no private data
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In iio_device_alloc() when size of the private data is 0,
> the private pointer is calculated to behind the valid data.
> NULLify it for good.
>
> Fixes: 6d4ebd565d15 ("iio: core: wrap IIO device into an iio_dev_opaque o=
bject")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/industrialio-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 4302093b92c7..bd305fa87093 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1654,8 +1654,12 @@ struct iio_dev *iio_device_alloc(struct device *pa=
rent, int sizeof_priv)
>                 return NULL;
>
>         indio_dev =3D &iio_dev_opaque->indio_dev;
> -       indio_dev->priv =3D (char *)iio_dev_opaque +
> -               ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> +
> +       if (sizeof_priv)
> +               indio_dev->priv =3D (char *)iio_dev_opaque +
> +                       ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINA=
LIGN);
> +       else
> +               indio_dev->priv =3D NULL;

Do we actually need the else branch here since we use kzalloc() and
therefore indio_dev->priv should already be NULL?

>
>         indio_dev->dev.parent =3D parent;
>         indio_dev->dev.type =3D &iio_device_type;
> --
> 2.43.0.rc1.1.gbec44491f096
>
>

