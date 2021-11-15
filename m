Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2AE4505C4
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 14:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhKONp7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 08:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236303AbhKONnM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 08:43:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41D6263225;
        Mon, 15 Nov 2021 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636983617;
        bh=wWcBwOu3cL9+U+zjsSAWtUQyMjCz3CDgA4mV4eUmQEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q4vpjH0uJaOnwWSUMmOGk4RBT6eS8WH2rt9ntVsxRfGOv9U1AcRtQ11fRaF90BIV8
         sqeJ0HBpuF+KPmzxxWjlJGgSJ1OjqCnX5IF3kDB9UyaLteVQzEs63BelRJSGp/MN27
         rl3mqKgow43UyjRBZHGLKQ4QfjwptO5RKrADCb33Z2mbHzpBKSuGr6uGe5kRDEdiBG
         HHrLzrj7SUybGgQXnJJsO7yrqVHV48pmOVUw23xSRWxB7Me79U0ZJtPK4hVpkgoTGX
         utmi82G0Uxv9J6Q2ftbl+jiVLtnlcx62LHYmA20iHfeUpWAVrLzRRvgSwCTpk4pzn6
         ofL6tkRYcgMKA==
Received: by mail-wr1-f46.google.com with SMTP id c4so30714585wrd.9;
        Mon, 15 Nov 2021 05:40:17 -0800 (PST)
X-Gm-Message-State: AOAM531vvlRykWLO92Z09uDzfZtO+Fb+dA5ADjGDxATEsgevQtZfRLx7
        qHnRukW4U5bU8Zx1GyLFIWD6DZ3FSiCQNz2Ea4A=
X-Google-Smtp-Source: ABdhPJydx+lGNyCCL10Ss+u6AlrY7F7Dh3irA5L/rafXQwz2EG7YLwST7GsA7bIvQOTqpVGT64n5uQbouKk1WaS2cho=
X-Received: by 2002:adf:f088:: with SMTP id n8mr7443019wro.411.1636983615679;
 Mon, 15 Nov 2021 05:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-1-arnd@kernel.org> <20211115085403.360194-9-arnd@kernel.org>
 <YZIk6cVb7XibrMjf@pendragon.ideasonboard.com> <CAK8P3a1Fu11-e0CK2of8u3ebdjom84UKuXhBKi5FUs5ZPPdOVA@mail.gmail.com>
 <YZJJVA/92KYH8hQL@pendragon.ideasonboard.com> <CAK8P3a27rPBVbU-PrYR0BE4KV2DyJk7FoXaeDS=FU1=_RSwoQQ@mail.gmail.com>
 <YZJbLol1llm+puDT@pendragon.ideasonboard.com>
In-Reply-To: <YZJbLol1llm+puDT@pendragon.ideasonboard.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Nov 2021 14:39:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a16s6dwvb-7REjF-pmnKod2qQRq+mta-g8pDXbQpGQvHA@mail.gmail.com>
Message-ID: <CAK8P3a16s6dwvb-7REjF-pmnKod2qQRq+mta-g8pDXbQpGQvHA@mail.gmail.com>
Subject: Re: [PATCH 08/11] dmaengine: xilinx_dpdma: stop using slave_id field
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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

On Mon, Nov 15, 2021 at 2:05 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Nov 15, 2021 at 01:38:07PM +0100, Arnd Bergmann wrote:
> > On Mon, Nov 15, 2021 at 12:49 PM Laurent Pinchart wrote:
> >
> > Right. I wonder if there is even a point in using the dmaengine API
> > in that case, I think for other single-purpose drivers we tend to just
> > integrate the functionality in the client driver. No point changing this
> > now of course, but it does feel odd.
>
> I agree, and that's what I would have done as well, if it wasn't for the
> fact that the DMA engine also supports a second client for audio. This
> isn't supported in upstream yet. We could still have created an ad-hoc
> solution, possibly based on the components framework, but the DMA engine
> subsystem wasn't a bad fit.

Ah, makes sense. In this case, I guess the data could have been
part of the DMA specifier after all, in a second cell after the
channel number.

        Arnd
