Return-Path: <dmaengine+bounces-5014-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54FA99F65
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 05:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A0B442039
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 03:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E91C8631;
	Thu, 24 Apr 2025 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyY0SXQI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD171A316A;
	Thu, 24 Apr 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464246; cv=none; b=HbdHup15StPgh9Zkf8B+YfSE3/pcJxrZvt0IpEXdmXK8RPZOelBc/OOQJiGjjdtgF0SiammA9ba+IgvRwBNaBZavYVmt0oLML70ti5PxmAYCUm16kBbf9fErM9IaayoQL8TpCDlencdkInj+FTkc2B8pU4LceuFLw8ekMsd4l5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464246; c=relaxed/simple;
	bh=/p3HVjFgpxqGQ0V/0D9C9PiDNbGsiswou45qg6NTwtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t388JYm69WAqYlNyqLmipd/DdoUQPjzVJ2Lcf+6ZqTPmvWlb5m7mumw7Is+XCACTEZaBaFIw4NPngIUT6b7XeP/uvGGzZIo6fauJgSpfT4uITlreA2o5crl8zzr4Uh5KeoMK9DP9+QutoiJK5ftyLHL32dgkD8Lq5swiC6WYoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyY0SXQI; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so4901631fa.2;
        Wed, 23 Apr 2025 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745464243; x=1746069043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1Co0cn3i/A9qHsD58ViRmTVSi6PlF7GGnjifnz4juU=;
        b=JyY0SXQIM882aVXORUattmPHBAo2WIehb6Y6m78XCchdPMmPkhVp3iksxvzYd3UK70
         ODsdCxRqNkvm2+oI9Uam7Z7O2MIM0/FIpa3EufEIRx7VmoAfKv/0FWB/6kkvVXwjeAJT
         aHtfNI5HGFRJwqdM9ASPzcAsprQukHTrDf6TUTZT3JUcEgxHHQFXHz77HyKtNi/mUS5o
         8SeE96xlQMnP/l0YJYOj6Kb/tlTqMFDDyUGfOEf/ee+PZSPPAjF3fRzm6shwZGKdaM5/
         kFSYs953OgWc4kYPEgd3AOk+FGSn5k+bX08B1Qb9e5fn+BCSdsYYQD8Wj2F5xeMbnFb6
         YiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745464243; x=1746069043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1Co0cn3i/A9qHsD58ViRmTVSi6PlF7GGnjifnz4juU=;
        b=UhO+gG+KBGAhww5mYO2fjO34YhqB59ZF3nciElt2v+t+o+aodkgC4iSmqk5x3prbPy
         z3idnoA4knhVDnOu5SwmR2WAFvCJJ3YxqyGy4Tv/651vod823Fi17u1ae4970C7nqswx
         fYH5yjBkEabE8ePOquL+c65c9rdSB2112A0+1hVKRrwfTukYFbDCcfBB8PZY/AH9FqfD
         GfIEzjpd63YbyG53Qmi0ekae0i0TKnHPSjylihRmCYtormlhhZsxKNf5+gzim6Ikdy3o
         5RxbvqUPMqXh7ISbggComgskQRPndiVulWwjHk6FX8OHQeQliULTF6qBtu8dUTLCed/J
         o/iA==
X-Forwarded-Encrypted: i=1; AJvYcCUjuH1ojWF2TV70JD3Ixa6jHAyH1cZGhm6jB6jdJHC9tGSh74uhaivpI8C3t+ylzfaCiqT0eJtCez5dCxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQ7Efur7VJ4m6nDHl7gOUEr9MsfqFUYuDBA3OoPNFuqPcz4da
	9xby7bTjSekOLP3vGmNqFmZEW/hGPD5nqlwGnawxb7fH0WYahp9XPYxlKM/ZgsXyIsig1lfyxAO
	Wmh2nIJY637P+SfL1JCxxFieBMiE=
X-Gm-Gg: ASbGncshFvJOKZChAjx8KBhhrkgK2hEhTbkkTksFPwvl+SonTr4luSyO7LofQwkxWrq
	jYvPEkoD+pHX6/SbOISUcAW7SQr1JTaIH4+Abo+OynFtiqWyekGJINMCZK1lrIE6nnvuHFmv5eG
	es5uMrUEpMH5Tr7ZnjhbWn8A==
X-Google-Smtp-Source: AGHT+IGZPSs7I6wLb18rgC6nawaXmuu+0OnenPZD2gVkjXjHu/WC+qoSZNv9ANWDtXHAuVFiIVEFsiL/H6OUSYZNrTI=
X-Received: by 2002:a2e:a99c:0:b0:30b:d474:12d1 with SMTP id
 38308e7fff4ca-3179fcc7607mr3719251fa.30.1745464242862; Wed, 23 Apr 2025
 20:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Thu, 24 Apr 2025 11:10:32 +0800
X-Gm-Features: ATxdqUFb6X6iv50PzP6nEFnaRkPadE_lrFGoYoV1uyUuwfYYHIe7ojHQ5K9Gtgo
Message-ID: <CAEnQdOrR19H84EooKsFTMCPypeEZwR3GD7FA-sj=toxQP-Xoyg@mail.gmail.com>
Subject: Re: [PATCH v1] dmaengine: ti: Add NULL check in udma_probe()
To: peter.ujfalusi@gmail.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan.lynch@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter, Vinod,

I hope this email finds you well. I wanted to follow up on my previous patc=
h
submission to check if there are any additional feedback or changes you'd l=
ike
me to address. If so, I=E2=80=99d be happy to incorporate them and send a v=
2.

Please let me know your thoughts. Thanks for your time and review!

Best regards,
Henry

Henry Martin <bsdhenrymartin@gmail.com> =E4=BA=8E2025=E5=B9=B44=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=B8=89 10:39=E5=86=99=E9=81=93=EF=BC=9A
>
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> udma_probe() does not check for this case, which results in a NULL
> pointer dereference.
>
> Add NULL check after devm_kasprintf() to prevent this issue.
>
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/dma/ti/k3-udma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7ed1956b4642..f1c2f8170730 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5582,7 +5582,8 @@ static int udma_probe(struct platform_device *pdev)
>                 uc->config.dir =3D DMA_MEM_TO_MEM;
>                 uc->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
>                                           dev_name(dev), i);
> -
> +               if (!uc->name)
> +                       return -ENOMEM;
>                 vchan_init(&uc->vc, &ud->ddev);
>                 /* Use custom vchan completion handling */
>                 tasklet_setup(&uc->vc.task, udma_vchan_complete);
> --
> 2.34.1
>

