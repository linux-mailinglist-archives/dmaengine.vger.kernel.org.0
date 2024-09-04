Return-Path: <dmaengine+bounces-3069-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ADB96AE88
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2024 04:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CB11F25CCB
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2024 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504834CD8;
	Wed,  4 Sep 2024 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0OFcP9m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A647BE49;
	Wed,  4 Sep 2024 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725416785; cv=none; b=CqGlwhINudVa1UhS82VLNar9HOSDGde/ovdNdPvYL5rvrlM19Do0nbc1nEx8KN/2NwTuRD9WoJSnGEENrT+7D4f5LGpRmgjBpPRJXXqGHBzWFV8MjQxJ6Q2RWcT9WUlsNuxpB5U4zRCNFeZZh+PJVWydx8BREYTI3ofXIyYrcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725416785; c=relaxed/simple;
	bh=fGqcaUGD7w63fzDnkRodwcT5MdyQ1hCOZd4iEMWLs8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gk6H5BN1oDwb5ZofKlJTdIrQH5cMtGEPGmcbGSGyETJNOkPLzeBT4eJOpuEN5hkasX6ST0GGeM+N+GXW+82okYnwW63l3FZ7fXqz27QAomRfNRbrz85+V+2pTvCZmFoi1QETbpHK8wIOeh3S+5MUR8pb1RAphlyZGfNlrlG5MbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0OFcP9m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c4d4f219so2080714f8f.1;
        Tue, 03 Sep 2024 19:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725416782; x=1726021582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSBdS1j11Zy+2xCDBIJ9EylWTf0s1FdTfmv9gHVQNOg=;
        b=C0OFcP9mCOzkX3TBmuAN/mKGTnTdTA9NcCdidYBx+np5RhrEFrKu33SlXSY0Hz+e56
         YEYfdUnOPtvt4JakE82Irlns8Yn8QaECSsQH3PsRM60WvJ0wcDY9VvNdF2POLxRKZtMq
         yZ7P61QtFpOBXsBfuArvfDSAxAMp/xYDD38fXzSJ7bQBY4igJFFZ5btKFsZj0s++gy+z
         5QmfiTjvyTuFAKQWhp2wXNeaZhY3ANW7cJWeHp4Y35fetPbBoGz7utXrIitt7bc/2g4U
         s+r6dbWAceqp6l3cUbPhpqjV3B0yjaO6vYX5Gq4avnyBeolfipgwzHAWVus/Rg+aHzfz
         eE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725416782; x=1726021582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSBdS1j11Zy+2xCDBIJ9EylWTf0s1FdTfmv9gHVQNOg=;
        b=O0KhuvGf7mekzkMWaq07HIkqEEVNTgOLeIK5zwA54YUj5d29gKfxm2ZeGHgYMXzhZW
         nUoWIlgeoTGLpTYNzhViadTaB6IwZyDw9L8CNIpufvbdk31VLbAUMMK63Fpv0ZDnSL5a
         cgAAs19P8/MhzWsYqFWpqtzY8FexuH7jWLSzdS3MO8eVPZB+1eLbPnl4kEuuZpfHCGo1
         xuKRQYKjK+CxWR7sP6izq1Gobo7rMB+kbntRpbl7Jyus7R27GnyPVdOvE7Xfn7htCBgf
         c/i/4u2RmN/wudKiTvat1rWLfUnP0RMZyESn+X3czGqyVAzRB7l+M/KsWhdibldS4+pd
         PuMA==
X-Forwarded-Encrypted: i=1; AJvYcCUbi90L9DDIw3ReZRdOzcE6kKe+GBzBQ0BlpTabaQjEGaRQOnBfS9ViZU0UYSBcN3hJALrDVcpkXluyTQ==@vger.kernel.org, AJvYcCVUVuOyba1hcrg0kJYcPhqXYI4dSuF6O2JPQzAWRbtKBlGUiAnrf0K/MmFC3TFoqSlpoYBD3ZLWyPfA2tq/Slu+@vger.kernel.org, AJvYcCW0gLvU5TD8dO1VbzQDZpQ/H7Z1U9V1lg9OfLZ2WvuSb1JwVOi9rG/9Au1a4M26jp/+EtK0Ptg6gjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JsKVJGgWAuHRUlDcakhfFWR3HnWIhdQbTgz1VcBMES9R1QAL
	Qsd9fR4Qk9S5yBSjoJf4x3m+xyD2H0BsHj+WgJ4lL7vbr7Kqm6yvjhiVTqIbYTLcBgXHabA8HUa
	NHGn13lOlAUsKo4eBBI1abkloJTE=
X-Google-Smtp-Source: AGHT+IGhzYhL4tArFqipUAT+kGGdRT0RgYSWXwyvMi268koMsgcW5NLg9Ennz8x3rZhCa17/E99QMWrsaKEDcAY6vBM=
X-Received: by 2002:a5d:59a4:0:b0:368:75:2702 with SMTP id ffacd0b85a97d-374ecc6774bmr4935282f8f.13.1725416781590;
 Tue, 03 Sep 2024 19:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904014803.2034939-1-lihongbo22@huawei.com>
In-Reply-To: <20240904014803.2034939-1-lihongbo22@huawei.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Wed, 4 Sep 2024 10:25:45 +0800
Message-ID: <CAJhJPsV75K=yawL-vV1MHbXNZssB3sphPjN4gPZN3EbASgzG4A@mail.gmail.com>
Subject: Re: [PATCH -next] dmaengine: Loongson1: Annotate struct ls1x_dma_chan
 with __counted_by()
To: Hongbo Li <lihongbo22@huawei.com>
Cc: vkoul@kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:39=E2=80=AFAM Hongbo Li <lihongbo22@huawei.com> wr=
ote:
>
> Add the __counted_by compiler attribute to the flexible array member
> entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/dma/loongson1-apb-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-=
dma.c
> index ca43c67a8203..be0dbda84dd2 100644
> --- a/drivers/dma/loongson1-apb-dma.c
> +++ b/drivers/dma/loongson1-apb-dma.c
> @@ -78,7 +78,7 @@ struct ls1x_dma_chan {
>  struct ls1x_dma {
>         struct dma_device ddev;
>         unsigned int nr_chans;
> -       struct ls1x_dma_chan chan[];
> +       struct ls1x_dma_chan chan[] __counted_by(nr_chans);
>  };
>
>  static irqreturn_t ls1x_dma_irq_handler(int irq, void *data);
> --
> 2.34.1
>

Reviewed-by: Keguang Zhang <keguang.zhang@gmail.com>

--=20
Best regards,

Keguang Zhang

