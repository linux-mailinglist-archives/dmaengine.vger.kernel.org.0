Return-Path: <dmaengine+bounces-1194-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32C86CCDE
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 16:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F93F1F2536B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5061419B5;
	Thu, 29 Feb 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A40QmmRk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA713A269;
	Thu, 29 Feb 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220384; cv=none; b=BFmDS9YGuwRnD4n2tGS362abrrwZKnKdhoLTA66ZD0/gNmQ00Jfr8SDvCvc/aSCjfqnoFjKJUNvI0KPELYCnUSDD2MQk3wKIAkYVLm62++cZJIcAZihW4Tt1X/dS1/8ZZTSpIHDJYy0Lyoe8sYuF3VlmoW8Xrz5XfiSqiV/tWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220384; c=relaxed/simple;
	bh=dp25kPE3nvKMZpYYCIqRh0OUPBEE5k7Af31a9VuC7YM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OOnKuyNc7xmEAXjnnNfW2nzY+IMpGf7taSBZzkV3r1deE4pgUEPCsUXhZ2ZtZqAfQpOuUjOhLdRsWs/F/QtaGY5pQKqmkyjt0EkoO+3VKq++WHZgDHeT8rOEco4i1ML/SGSu8ilpvQbn/5WmwU4la43haMdeVhzOYSR49/dAds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A40QmmRk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a443d2b78caso131599866b.1;
        Thu, 29 Feb 2024 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709220381; x=1709825181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDKK+JM2Mc+u4yC69ABwMe5pRMPqiOr3x+G24kQ6OeI=;
        b=A40QmmRkYDVd+lBnBpTcg845ptEtPTNvqn+m/gt0wcsZiBbhGtfqXc5zmKNCU+dDmY
         IeC75gaZr8zXWW8Ft4BcqYFg7BrebIoUbcyod9ZcUkBpTHma7/OLg46eH0u84V0waLC6
         9PW7RQPS1jrvGLoC7Hhi/WRCempfKhNjfpbYp3iwufuhMcTZUVRUJbuQKTapOIx5Shcq
         YiginZh0+JUDWqnkGwIr5exuL3flMrlieAqH8lOcuyhDAHY/FSrm9YD0k8bYsET8FFiM
         N++HNb55w6Jtyja4vxU2pkH/MzgfyIU6rvTw4MvNHSzmw8r4ath5/1QDPFMndfGkWAeO
         ADpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220381; x=1709825181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDKK+JM2Mc+u4yC69ABwMe5pRMPqiOr3x+G24kQ6OeI=;
        b=egdNGsYR9BiS16sbh63NaktkBGcaLt9RQx6q4q59kvG2ghFVN//WnvC9yqccvrC8NM
         m6GadIrawCd0r8dCYgBpoAJ1qcW4utR0Jl6lyGRzD25z49QVlyakRbUPTW1K5Iyfx/nR
         K93mfB5KFmFGGO/9iq3Wt17NsBo6bCeoSHBpdIxw8e+NgsoYGBYdI7bHHa8cxc7oxM9/
         ZKIWaV7G7/5yQ+++2oVzaViMjAtdlzMFNzLAIVlkC7Ka6YyE1SDwC/9WJ8WY5EcRzoHc
         o4gTQRCPtAiwdUD7UKSohsQCNpKqV60yJPsevuqhlcnTWtvlhVEktCc8lDGvFHHbnoFy
         VpFA==
X-Forwarded-Encrypted: i=1; AJvYcCVscIlGwusDkxArRVnoVe1v0hHdzioq8nWtQk+86PVgLYtoz3WvnyeIJrWJqffVh0+6WxVwrKgEaAjDjMFuzAbjZbgnqBhBUuKNWt9gnq1S0OJGTWwvSCt6RX0HQA38LthKzU7o8QL+gUBcQ3u3GXHbOAompUL4Fj9PUU+92UoTrm3RTNd0an17e9lurjTJL5W4QkZjm6RmVG4ZBuD6KRiqXKBjr9isdwEGXp0AUaEpB+RDbEYWgYFgTCsjKbzxItJqZRpAC6X4IictqKbCFgqr+uTeaVN3
X-Gm-Message-State: AOJu0YzCegXV9T9EWHR2GZDYnyRryUQLvNCrdVx9yZRpw8AyhFvAsfWF
	rIQ5/SPXJyV+EXJWq/6XOGdPy2Eerwn6/pv5ng9QdszxWJh3xctM
X-Google-Smtp-Source: AGHT+IH0BbQOh/RTvu68zev6Pz52w9G6f/rWM2ZMM0vlhc9AV/MotVi8zNP8RkVgD5Lo1Htbnl8XeA==
X-Received: by 2002:a17:906:d9c6:b0:a44:4329:c091 with SMTP id qk6-20020a170906d9c600b00a444329c091mr1418331ejb.74.1709220380765;
        Thu, 29 Feb 2024 07:26:20 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id vw3-20020a170907a70300b00a42ee2af521sm778203ejc.137.2024.02.29.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:26:20 -0800 (PST)
Message-ID: <9519dda9acd9db009dcb43102cc9b36943b35217.camel@gmail.com>
Subject: Re: [PATCH v4 5/8] iio: core: Use new helpers from overflow.h in
 iio_device_alloc()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul
 <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>,
 Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org,  linux-hardening@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>,  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 16:29:43 +0100
In-Reply-To: <20240228204919.3680786-6-andriy.shevchenko@linux.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	 <20240228204919.3680786-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 22:41 +0200, Andy Shevchenko wrote:
> We have two new helpers struct_size_with_data() and struct_data_pointer()
> that we can utilize in iio_device_alloc(). Do it so.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
> =C2=A0drivers/iio/industrialio-core.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 1986b3386307..223013725e32 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1644,7 +1644,7 @@ struct iio_dev *iio_device_alloc(struct device *par=
ent,
> int sizeof_priv)
> =C2=A0	size_t alloc_size;
> =C2=A0
> =C2=A0	if (sizeof_priv)
> -		alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN) +
> sizeof_priv;
> +		alloc_size =3D struct_size_with_data(iio_dev_opaque,
> IIO_DMA_MINALIGN, sizeof_priv);
> =C2=A0	else
> =C2=A0		alloc_size =3D sizeof(struct iio_dev_opaque);
> =C2=A0
> @@ -1655,8 +1655,7 @@ struct iio_dev *iio_device_alloc(struct device *par=
ent,
> int sizeof_priv)
> =C2=A0	indio_dev =3D &iio_dev_opaque->indio_dev;
> =C2=A0
> =C2=A0	if (sizeof_priv)
> -		indio_dev->priv =3D (char *)iio_dev_opaque +
> -			ALIGN(sizeof(struct iio_dev_opaque),
> IIO_DMA_MINALIGN);
> +		indio_dev->priv =3D struct_data_pointer(iio_dev_opaque,
> IIO_DMA_MINALIGN);

I'd +1 for implementing what Kees suggested in IIO. Only thing is (I think)=
, we
need to move struct iio_dev indioo_dev to the end of struct iio_dev_opaque.

- Nuno S=C3=A1




