Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74904502AD
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 11:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhKOKp1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 05:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237647AbhKOKpZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 05:45:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 605EE63232;
        Mon, 15 Nov 2021 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636972950;
        bh=GF5ppKwJBGyzBz8YYmc0v0PuTfRZzEb8KsPYdX9kZys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ah/2tRgiVpL5fsi7FPpcL635JDhcln6l2ExZIWHTLBUbMjdBJtz0DoVh8A2lD2GeS
         Vn5loajjfQVDFPQtLSRLZGgFOOu9gaKK3ygqoSrLlln9jWXCpaNqhh48lZ8c+k+4gu
         sRf7wuCD69gIDwdqAcDKjxNp/YsEuFSMvDDDQT7VHpaJYuJxZPW/xofRGd5PidTsHa
         kAWstx1aMCAeHyFhdJIprnubYysWs5QAKZBMy/vWApTOP0uD7D8phUBIQiY3lLQ5f/
         +MVP+HB9F9xrWDthVsi8GxjjhUCyNhOn85FTRAs3rVEuGA/K5Upw6e+cpw5gK86TyV
         zRQeafG4VMnqA==
Received: by mail-wm1-f48.google.com with SMTP id i12so12630047wmq.4;
        Mon, 15 Nov 2021 02:42:30 -0800 (PST)
X-Gm-Message-State: AOAM533V71Zs+sw2dEBymXO02n62snMw7/lgyzhTvq1NziLMRdPVOwAr
        Jwd8dWTGYB1PEaibVHYthPczN0VjzeXVDRxaY3I=
X-Google-Smtp-Source: ABdhPJxXAexhirAvGW2LKyfe3zijMEf2dKYT5qfqRJ6eAMXzz6GR60sm0yXhnH6+pWfe4YG9EjpedQhiHwxXAXFjyDM=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr57234330wmi.173.1636972948695;
 Mon, 15 Nov 2021 02:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-1-arnd@kernel.org> <20211115085403.360194-2-arnd@kernel.org>
 <647b842d-76a1-7a96-3ea7-8a37b62bc18e@metafoo.de>
In-Reply-To: <647b842d-76a1-7a96-3ea7-8a37b62bc18e@metafoo.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Nov 2021 11:42:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2EVseM4t=e982fFhzBGSZxZ2_V-FHwr-fQPd-bkAKaJg@mail.gmail.com>
Message-ID: <CAK8P3a2EVseM4t=e982fFhzBGSZxZ2_V-FHwr-fQPd-bkAKaJg@mail.gmail.com>
Subject: Re: [PATCH 01/11] ASoC: dai_dma: remove slave_id field
To:     Lars-Peter Clausen <lars@metafoo.de>
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
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 15, 2021 at 11:14 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 11/15/21 9:53 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This field is never set, and serves no purpose, so remove it.
>
> I agree that we should remove it. Its been legacy support code for a
> while, but the description that there is no user is not right.
>
> The tegra20_spdif driver obviously uses it and that user is removed in
> this patch. I think it makes sense to split that out into a separate
> patch with a description why the driver will still work even with
> slave_id removed. Maybe the best is to remove the whole tegra20_spdif
> driver.

Ok, I'll split out the tegra patch and try to come up with a better
description for it. What I saw in that driver is it just passes down the
slave_id number from a 'struct resource', but there is nothing in
the kernel that sets up this resource.

Do you or someone else have more information on the state of this
driver? I can see that it does not contain any of_device_id based
probing, so it seems that this is either dead code, the platform_device
gets created by some other code that is no longer compatible with
this driver.

      Arnd
