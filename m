Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09913CC2AE
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhGQK4A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 06:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQK4A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jul 2021 06:56:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1B0C06175F;
        Sat, 17 Jul 2021 03:53:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a6so17737277ljq.3;
        Sat, 17 Jul 2021 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DCRC3rQb6QUFHodoiHVlMqRF0dyiXmaZMG9uskF+xX8=;
        b=TWOYlUzJ6mAil9DPO60Vrg9hPzn756jShGgHB5ifi05EcMAMeGV7aZmStVVfQz1FNN
         p2WqVSazQwFXlyAKT6IDfGl29DvEW8JtyX+Fdkwy+s/iKaAOunaL+Jp6uj2KcHoejDC0
         6UBlMfhPzJAtuX/8zsfg0MG+Ai4UJ0fdv7ECnTOyuBNlQebr4FccMCCo3t1L2edgyLOR
         6W3kEVo+FC6zpXaPxJ2CNMmgab1RqwF9k8Yyv8fAHpO9Jy33BpVY4r2fGCGLqqafK0nt
         0QBfgc60otZaOG1tUlbzUXzbHVyoNwXCLWBC8FI3IT+2jJTHKJDN/wKj2zLvNqjvD8oU
         7NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DCRC3rQb6QUFHodoiHVlMqRF0dyiXmaZMG9uskF+xX8=;
        b=FfOr//LatlsLr2Sge5EOByGKVqLmp/ZnSmcoEhFAbKnk82HGU8D/qN8Z+uL+odRqNQ
         GWRhcSSf6fBhiAx0tKvYf0qMkNtLrias8dURz1OYjYlZPlcvJSK6fN2q6rb0q9g4gr/1
         AXXKCucwo924uR8YxIJRWzF/mdrp29sOa2qUJKSWvKi4p5luiX25cQR60dEODTDZb3yk
         DjybVCyJJuO60FHjd7IxLcYiV0qN8abJq49g9gMwopuG8K6nBNdACJn1H7xnJRmBXVi2
         bIBi0w2owycximEydBHoXrU2nngzsy5gFzx8/ye51Qz3bGwqU0PK/DE/FA1dS7sBjCP+
         YINw==
X-Gm-Message-State: AOAM532vTAEE7TXtIw0n8WCeWdjd+/+vgcpJ49C8xT+dFS3BA2g8ViyJ
        cpp2lCxw4is5oHlpR1a2c8J8Cr1itRDyWcXKvW4=
X-Google-Smtp-Source: ABdhPJwIv1nSMaBkgtLZ1JeUIDv1zTV+jTgiz3WR+enxsQIMSv3tLHCFmKp0AFfeW+Sdkv3Zw0Pxd2ria7DJrBhoEE0=
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr13146709ljk.265.1626519180043;
 Sat, 17 Jul 2021 03:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210704153314.6995-1-keguang.zhang@gmail.com> <YO5yo8v/tRZLGEdo@matsya>
In-Reply-To: <YO5yo8v/tRZLGEdo@matsya>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Sat, 17 Jul 2021 18:52:48 +0800
Message-ID: <CAJhJPsWBbfHresHYpmsydsuf=1LFtc-ZPuAX+bi_a2nx=y0zAw@mail.gmail.com>
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
This patch will create the device: https://patchwork.kernel.org/patch/12357=
539

>
> --
> ~Vinod



--=20
Best regards,

Kelvin Cheung
