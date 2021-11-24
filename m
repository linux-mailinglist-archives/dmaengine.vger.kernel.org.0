Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D621E45CA55
	for <lists+dmaengine@lfdr.de>; Wed, 24 Nov 2021 17:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbhKXQvH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Nov 2021 11:51:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241782AbhKXQvG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Nov 2021 11:51:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBCFD60FDA;
        Wed, 24 Nov 2021 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637772476;
        bh=xZZelNzGy3fEF+TRUP3mu2a2dvknfo0hSlfUMkdbXnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QB2Os1i5AAZ9Xb5Ny2MOKmxAU9QaCl4g4U/BMONy2Go/4aNLCZCzKJp4JxdPfjil5
         qHxNPAYki4sRFQnethGWNHA8GHDZbL88c3bDuLfvcdTBjwqsGNST4xcjN2W+EGY1y0
         TvtMabQArNlwiSl0HxWQWfW+MKM5rssREZWlgFg6NjwjKGpKe6g39mGxEVGA3oaNxX
         HdmkqI2DxHPlkYycjzpNmN6H99QT9uBQ/u82VVGRg2GOI7x+KvH19VBj7dIKiSmSJA
         ADAU0J4jKCyMB/cBewSPJ3BzTq+hVhklOzMuTKcMRu99LF5Z4XVXjwqpsz5TxBueIE
         8jyssOdTheYGg==
Received: by mail-wm1-f48.google.com with SMTP id y196so3016654wmc.3;
        Wed, 24 Nov 2021 08:47:55 -0800 (PST)
X-Gm-Message-State: AOAM531K28KbFrMeUnQZk/r41mjzkGYVAHNfeHOoOjd8aKJH/vtnMiY9
        rKJFj5805AMmrQQp7ia6liNjw/Bzm4EwydV9adE=
X-Google-Smtp-Source: ABdhPJwbFP7vLbm8pNQQOpEuYc09R2zZihV7ND7aqtuJCkGnJDFI12J2lrIBTl3QZQQRaScbWu3GRnefAkQ3ygpVdCU=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr16061185wmi.173.1637772474274;
 Wed, 24 Nov 2021 08:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20211122222203.4103644-1-arnd@kernel.org> <20211122222203.4103644-2-arnd@kernel.org>
 <1dbe0c9f-e209-49e1-f05c-765d9f9b91eb@gmail.com>
In-Reply-To: <1dbe0c9f-e209-49e1-f05c-765d9f9b91eb@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Nov 2021 17:47:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ojMBib+6UGGxO1GyQ4a22RM3yn79Uv=ixQ2KFUCfGrw@mail.gmail.com>
Message-ID: <CAK8P3a0ojMBib+6UGGxO1GyQ4a22RM3yn79Uv=ixQ2KFUCfGrw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ASoC: tegra20-spdif: stop setting slave_id
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        dmaengine@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 24, 2021 at 5:32 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 23.11.2021 01:21, Arnd Bergmann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> The commit message is correct, however you could remove even more code
> here. But there is no need to make a v3 just because this patch because
> I already prepared patchset that revives this S/PDIF driver and enables
> HDMI audio on Tegra20. I'll take care of cleaning up the whole code of
> this driver.

Ok, perfect, thanks for taking a closer look as well.

>
> -       dmareq =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -       if (!dmareq) {
> -               dev_err(&pdev->dev, "No DMA resource\n");
> -               return -ENODEV;
> -       }
> -

Right, I think I considered doing this at some point as well, not sure
why I left it in for the version I posted. Passing the IORESOURCE_DMA
values is clearly wrong by itself and needs to be removed, though
it's not obvious what the correct way of requesting the DMA channel
is for this driver either, without a DT binding or users.

        Arnd
