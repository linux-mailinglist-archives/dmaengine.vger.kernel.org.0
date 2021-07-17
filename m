Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674093CC2B1
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhGQLBJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 07:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQLBI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jul 2021 07:01:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCBCC06175F;
        Sat, 17 Jul 2021 03:58:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a6so17748753ljq.3;
        Sat, 17 Jul 2021 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=riZ0swWsKuGdDEmTdXrsgKlYgCsX0yiDWHJgVmDqtqw=;
        b=gQ2X7WOZi437l1jmm5+BK4QO1RqNBrUHSEdBTC7ImGYfaTzp5LjTgvuaf7JeZM9kgt
         Ao0eY3JqsMHtZTJLgEt6eD2+4joiWuEKchrJnihmJ2ETlwZnHWNAQQ0+eDhfUtBefFeS
         bOo+rvqY/nWcTtnaqXiUYS4myF7yEMVYz6n8fORpCvTH96ESlr/58aNJhobT4sruDwLA
         UEIqswXX4J8DH0+dejnpK6MIa6HKmMf/BGdDiYGPHUWJQslx4aVpyNWqxaoynj+RwrtS
         tnP25GwSmxRFPR5VgcSr3mlWSe0azI8HoXm/pMM0mhNhBtq5RYOyeFRjiO2iIk96/HNS
         IqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=riZ0swWsKuGdDEmTdXrsgKlYgCsX0yiDWHJgVmDqtqw=;
        b=LXqWpUMnoIoNluIE55uiiKW5IzDTW7fgp73kOd97WdFHR69OQVx86tq6dvgvydAdIT
         seRDKkoeZnffIawwrjPO0ZAqIDYoNYhwwutd1TfEC05UOOClbYpE8VreszM1iWDH4bVD
         b6+j+MZTOveFjQi9QymMll1TSEM0Gi71rqaCRBwpMqSYDqEDXoy/yz8cnOTUrh8QU/c5
         ErzyKFKgsAWKczbd6FMtRW8UjiXgJuA/1Ei6YrZQBVOeHwyh8yoD2Lvw/p8I+oBeN/0U
         phYwh6ailinGMY3qRmhXmjTYYyR+++WWP3w0zoaJklrf3wKc4RoGU+fILal4zcmoFoUQ
         5Kvg==
X-Gm-Message-State: AOAM532xDxjXBdUqEtpW7F9oAF47ojY9vVvAJDZmzafV35S4jRguQktZ
        Kiz/8Dv+7V4rqNMD39I4krQXBpNm1eAa1GW0FeE=
X-Google-Smtp-Source: ABdhPJwooc9NPIkEHpAlWzWz1Ob6W8OdIMQH6EtwbSE5QM5bp1olWeWauSTAOJ9Y5IsQlqaPRywsVJQSFE11Bu3ueJw=
X-Received: by 2002:a2e:8554:: with SMTP id u20mr13308698ljj.257.1626519490015;
 Sat, 17 Jul 2021 03:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210704153314.6995-1-keguang.zhang@gmail.com> <YO5yo8v/tRZLGEdo@matsya>
In-Reply-To: <YO5yo8v/tRZLGEdo@matsya>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Sat, 17 Jul 2021 18:57:58 +0800
Message-ID: <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod Koul <vkoul@kernel.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On 04-07-21, 23:33, Keguang Zhang wrote:
>
> > +static struct platform_driver ls1x_dma_driver =3D {
> > +     .probe  =3D ls1x_dma_probe,
> > +     .remove =3D ls1x_dma_remove,
> > +     .driver =3D {
> > +             .name   =3D "ls1x-dma",
> > +     },
> > +};
> > +
> > +module_platform_driver(ls1x_dma_driver);
>
> so my comment was left unanswered, who creates this device!

Sorry!
This patch will create the device: https://patchwork.kernel.org/patch/12281=
691

>
> --
> ~Vinod



--
Best regards,

Kelvin Cheung
