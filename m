Return-Path: <dmaengine+bounces-3157-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96A9786F0
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2024 19:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B6D1C24079
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2024 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D701B8289E;
	Fri, 13 Sep 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlKRSWa5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263571C14;
	Fri, 13 Sep 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249087; cv=none; b=OAt5GOsWWdpQ/i/5EelzWW1PewpejryH0aQlRryAE/gfvfq3AdOR8lCoYwZDVMdEk60VNHN8knsYusnio7v+brRyw1bLhdYSoCInWrQ2y35P4ZXY8EnQK2p4FUcoUNeN4BHoXjWXSlxEMnVkopEOmNpOQ1iCiC7sQFHm1ShQDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249087; c=relaxed/simple;
	bh=fY3qP5ltlCZX+yqPpCa+44KaFwjOZwWMYefZqtJZzKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFlYSyDGUKkJcuBByUm7G5u0MGqVJVAi8wCtbCBnvDK8hWFs2eMT5jgta5qFzTwtIEQRjpuWFlkZtZYd2NtRmpq0YdaKn0JMNxUpQWKKQCfS9NVBD6E8EQ4teUgVuTlBgk0I8sA+P2N+byunL6kdBOXcjd5W0cQX5OackJC3oCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlKRSWa5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a90349aa7e5so249833066b.0;
        Fri, 13 Sep 2024 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726249084; x=1726853884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ZYRNlSQLbgqSh8L6zRzv83U3SkXdqIYSdeXiPhSUzo=;
        b=VlKRSWa5vmbSPZ89gmzFDrSV5ntEt9eFMzL9IK03AIniXn6XKDOx7lJxPMRa2jrlpJ
         ejzMa/ThPSQDUhcS3k/RYcKBZfixifgTnzYT06Df9PJgrB6UC0FwNM6wXR35woZPaUbQ
         Dj9l6wUurw6fz43LK67b8RHEAqyzM9Rtmwet1W2dfvn2sRBDHU2TWMv3H/8hv1RJmqXj
         XunpfZJAlpAzr75moc3alrtTJ0tcCJbZaV1yvgN3MAMPMapaltECXew8SDrbi3kxXeQ7
         fFoCprcZvJyo6hlyfvsciAb2UsN/wLcmetJfe9MbAIbQ88lp6rM+dmnF0I2XvFGqgIIS
         oNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249084; x=1726853884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZYRNlSQLbgqSh8L6zRzv83U3SkXdqIYSdeXiPhSUzo=;
        b=QQ2m/XDkau0RzH5AjZqC2k4v5xmkRBbVM16tAgij2ODNisg5yTZEp8miBMISgXGG52
         RnX/+zeL9LN8I6bRjF1TwoIfAYz5Jgj3/ecCuYOU43vHB4vO7VM1i2we7/1YSnritDNV
         MFg0QXXgZ2pTLW9gPqEyDBbFF8RPEPkW7b+iQr0oIJtzAit4V6d07Ijm9mgBqE280JIF
         bTsZQhQ4V5Gwvoa6dMzVD8fwKRieHnLu+CcL4/voHMMefvdazlk1Q9bEPa/h7hfg7VOG
         i2MX4rv396Psb1JDf8wRWxmZyc8uG5ZNrGFUmTAe0nfoBGIuoZil7cC74ne5usm4ZfQQ
         6VZw==
X-Forwarded-Encrypted: i=1; AJvYcCVPWlB9KCqVSnsNRxx6tziJ3hxK6DY02UbRnHzIayvjOArc5m74npvKkqBUAbHve9N3/hZ3ZT+kLuQNjj1Cac1C@vger.kernel.org, AJvYcCVt8h0lMX6WXFtSI8Taf+/q+WX9+2Ho9HlPocdh3Wj9YXP6QhDqjAEaMo6UkDAY47onlojgjbICsCM=@vger.kernel.org, AJvYcCWkFkVD67NWr0WRGNuqXBYtGzFO7Rthu1d8wrymAdQjEHlCW0XSjCG7+MfGy8gZpre88OTy3E5zSpnXY5tL@vger.kernel.org
X-Gm-Message-State: AOJu0YyLPJcypOHRSAmENZPUojP9gDWrzuHzy51Wc/YegjMrtbWoU6vS
	RexuBgm6NIJlHhgY+zHtMRPPfhUYgvcVraZwXVOL4AeiNk+qiTd/mSKWFg==
X-Google-Smtp-Source: AGHT+IHIPf2510kWSaFZLijAQCgplBcwd6nKeIqcCMsTFc9d1JBSI93TxnKzIR2l1szbD/0jgEvkWA==
X-Received: by 2002:a17:907:f156:b0:a8d:11c2:2b5 with SMTP id a640c23a62f3a-a9029448c46mr615050166b.21.1726249084081;
        Fri, 13 Sep 2024 10:38:04 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835551sm895717866b.24.2024.09.13.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:38:03 -0700 (PDT)
Message-ID: <de829772e1928cb5707fdae9cb72fe5885216db7.camel@gmail.com>
Subject: Re: [PATCH next] dmaengine: ep93xx: Fix a NULL vs IS_ERR() check in
 probe()
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Nikita Shubin
	 <nikita.shubin@maquefel.me>
Cc: Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Fri, 13 Sep 2024 19:39:10 +0200
In-Reply-To: <459a965f-f49c-45b1-8362-5ac27b56f5ff@stanley.mountain>
References: <459a965f-f49c-45b1-8362-5ac27b56f5ff@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan,

thanks for fixing this!

On Fri, 2024-09-13 at 17:35 +0300, Dan Carpenter wrote:
> This was intended to be an IS_ERR() check, not a NULL check.=C2=A0 The
> ep93xx_dma_of_probe() function doesn't return NULL pointers.
>=20
> Fixes: 4e8ad5ed845b ("dmaengine: cirrus: Convert to DT for Cirrus EP93xx"=
)
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/dma/ep93xx_dma.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index d084bd123c1c..ca86b2b5a913 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -1504,7 +1504,7 @@ static int ep93xx_dma_probe(struct platform_device =
*pdev)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	edma =3D ep93xx_dma_of_probe(pdev);
> -	if (!edma)
> +	if (IS_ERR(edma))
> =C2=A0		return PTR_ERR(edma);
> =C2=A0
> =C2=A0	dma_dev =3D &edma->dma_dev;

--=20
Alexander Sverdlin.


