Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C841450808
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 16:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhKOPSz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 10:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236609AbhKOPSO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 10:18:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06F1363244;
        Mon, 15 Nov 2021 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636989318;
        bh=caNhQR6MItqyqj8aVGADFWmRHHEWyDNeG1UmwE7ptic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V/bQc6DKqJJ9P37PTBVcjhzef7pDvNHRvr3F3EgUQSqR6cy9gSS6hyzZDciApni0a
         3QMWN6MNNmORUy4BghYhYSm0TENrtMowNG+BxfSpe4F6N3jXjJPkkbXvN49Ox0bMTt
         fWhgBksXDZXchbDYG70HcbRVWZGHGtswftEIz2iyfbKUP7KKPZVOsGmmLlIrKIXyeJ
         gzuikhV7beCSHi+4AycaC9/XDi8NPveqOXyRlBsMjwDJnNyhOY3SSISSPPYeOikYGF
         0Xs8EXetoSOIeENEILqVUTpQifde5TJSWu7mnaCK9kgeWQDH6Cm3MkdBV5hVy9UqQz
         656gt9SaY+hCg==
Received: by mail-wm1-f46.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so16153670wme.0;
        Mon, 15 Nov 2021 07:15:17 -0800 (PST)
X-Gm-Message-State: AOAM531xs+IPX2RCSN9J1njBgrefS67r2uh/SdbOMuhx2rxiZT5t7T8V
        vlBbRGV4LnBUfFJsSLR5VfWbdUljPLopFKe/7NA=
X-Google-Smtp-Source: ABdhPJy8n2MSwzh6suyWZ9JESZ+B+WCCwhvtwsBUIZeDj84QhV0+ZckRDxWsOxlhdmOo7jylNl8QiKm3gBRShRPmqHI=
X-Received: by 2002:a1c:2382:: with SMTP id j124mr42651026wmj.35.1636989316377;
 Mon, 15 Nov 2021 07:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-1-arnd@kernel.org> <20211115085403.360194-2-arnd@kernel.org>
 <647b842d-76a1-7a96-3ea7-8a37b62bc18e@metafoo.de> <CAK8P3a2EVseM4t=e982fFhzBGSZxZ2_V-FHwr-fQPd-bkAKaJg@mail.gmail.com>
 <d2dd42fc-e58a-0c06-7f7e-a6a2161c368d@metafoo.de> <5737810c-420a-2f8d-99bf-24a2558d5855@gmail.com>
In-Reply-To: <5737810c-420a-2f8d-99bf-24a2558d5855@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Nov 2021 16:15:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1dGSF-S4msKKWvPYORwYCFvtkNSJwkhtxvETgiQjC7_Q@mail.gmail.com>
Message-ID: <CAK8P3a1dGSF-S4msKKWvPYORwYCFvtkNSJwkhtxvETgiQjC7_Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] ASoC: dai_dma: remove slave_id field
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
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

On Mon, Nov 15, 2021 at 3:46 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 15.11.2021 14:53, Lars-Peter Clausen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> That Tegra SPDIF driver was never used. Still there is a growing
> interest nowadays in making it alive by implementing HDMI audio support
> for Tegra20 SoC. It was on my todo list for a long time, I'll try to
> prioritize that work 5.17, it shouldn't take much effort.
>
> The slave_id should be removed anyways, it won't be needed.

Ok, thanks for the background, I'll mention that in the changelog text then=
.

     Arnd
