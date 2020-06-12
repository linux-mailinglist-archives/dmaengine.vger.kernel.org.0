Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744EF1F719A
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2020 03:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFLBPd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jun 2020 21:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLBPd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Jun 2020 21:15:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17CCC03E96F;
        Thu, 11 Jun 2020 18:15:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k8so5279100edq.4;
        Thu, 11 Jun 2020 18:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrXOAPR1wUIoCz970nhKAMLDJMKaQFBhK9kaj7+c6o0=;
        b=SScLMHqvdfTGJ4XcYw/pdc3oc6RjUnJ5qkedbCLfkGyQGpxl/6/5SFXJAJoi6ninOB
         v5uAGMs+3NrtiOooTsQw22dcG0kHNgNrTEgCTxXgE/SQ6MPMMly9DuEZ5R940F/QmDSR
         ijJp+63tgkpG//qDR2D99dezWkbQJ0WM57e9I2mGLaZInRIu1In5Ozhj57a38WJUn6JN
         uRTEdNkH8idNZNrl72iWC51hmQS9/6ZIds+qo366r1GUPGFJ3Lt5R+NSmjhJm9cf8kbZ
         1lc1ty5ZDfMBN8b6CIRbk8hA4ma52xhvz+yoz6KFKfu0rahW8caETMgbWXlIHNgkdeam
         JW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrXOAPR1wUIoCz970nhKAMLDJMKaQFBhK9kaj7+c6o0=;
        b=a/P3OpJegvTYsSfAknczOqrrCBYFbfD1+Ya87/Fg6CbPUCxHWhZYr+fwoTvxJf61J4
         n2baodlo3SPViUAy8aSGKf+DCn7Omk6HIHHnGjfDGY3yIczvYdhyOFD3YOV0FcP4nAoE
         EdfOry/WmHO9xa+cg0OKgJu4NO3oOb3NIFJAh7NahL/1Sa9yfPIcbBFCowldf3NM2v3p
         FxM0VPvYjhgisuQ6KTdIrlbxZKm68zzt6s3GkrrrJwVioSNogkhCL/bWyg1GNJZmPgXJ
         BwLMru5c3H/8HslUpXbRK2GAHpDHNBIfP5RuL7/o6g7D51hfJHFM9ium+UCU46moOST6
         SW6g==
X-Gm-Message-State: AOAM533ioQfODSdF14FwlFrihyE6hHfABNwSA7VBcrsR8nchggJrdgqb
        gEjQPJfk7OOeExSTz1XPzRDWg2oKX6VrJlm3w1M=
X-Google-Smtp-Source: ABdhPJy9T4eu6IOqnyeQMZ34m2hL2Q7kSjQjI0lZKf4aSXI+VN7o0jMNAKociU3mfaxZazZru8sdte/ZygxwmqluBuM=
X-Received: by 2002:a50:cdc6:: with SMTP id h6mr9230698edj.111.1591924530127;
 Thu, 11 Jun 2020 18:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com> <CAMdYzYr+NF7L3KKzcGano=j9V844Gy8gH03hD++CoPe8Ao1QxQ@mail.gmail.com>
In-Reply-To: <CAMdYzYr+NF7L3KKzcGano=j9V844Gy8gH03hD++CoPe8Ao1QxQ@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 11 Jun 2020 21:15:17 -0400
Message-ID: <CAMdYzYqRTbePLKZ6q39Ao3sgLU0xUvrLmwYTVU3feEb4ob6FuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/13] Patches to improve transfer efficiency for
 Rockchip SoCs.
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, Carlos de Paula <me@carlosedp.com>,
        dmaengine@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 11, 2020 at 9:06 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> Good Evening,
>
> I am currently testing this on the rk3399-rockpro64, and it appears to
> fully fix the gmac problem without using txpbl.
> PCIe also seems to be more stable at high load.
> I need to conduct long term testing, but it seems to be doing very well.

Belay that, it does make it harder to trigger, but the issue still
remains on the rk3399.

>
> Unfortunately it doesn't fix the rk3328 gmac controller.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
>
> On Mon, Jun 8, 2020 at 9:15 PM Sugar Zhang <sugar.zhang@rock-chips.com> wrote:
> >
> >
> >
> > Changes in v2:
> > - fix FATAL ERROR: Unable to parse input tree
> >
> > Sugar Zhang (13):
> >   dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
> >   dmaengine: pl330: Add quirk 'arm,pl330-periph-burst'
> >   dt-bindings: dma: pl330: Document the quirk 'arm,pl330-periph-burst'
> >   ARM: dts: rk3036: Add 'arm,pl330-periph-burst' for dmac
> >   ARM: dts: rk322x: Add 'arm,pl330-periph-burst' for dmac
> >   ARM: dts: rk3288: Add 'arm,pl330-periph-burst' for dmac
> >   ARM: dts: rk3xxx: Add 'arm,pl330-periph-burst' for dmac
> >   ARM: dts: rv1108: Add 'arm,pl330-periph-burst' for dmac
> >   arm64: dts: px30: Add 'arm,pl330-periph-burst' for dmac
> >   arm64: dts: rk3308: Add 'arm,pl330-periph-burst' for dmac
> >   arm64: dts: rk3328: Add 'arm,pl330-periph-burst' for dmac
> >   arm64: dts: rk3368: Add 'arm,pl330-periph-burst' for dmac
> >   arm64: dts: rk3399: Add 'arm,pl330-periph-burst' for dmac
> >
> >  .../devicetree/bindings/dma/arm-pl330.txt          |  1 +
> >  arch/arm/boot/dts/rk3036.dtsi                      |  1 +
> >  arch/arm/boot/dts/rk322x.dtsi                      |  1 +
> >  arch/arm/boot/dts/rk3288.dtsi                      |  3 ++
> >  arch/arm/boot/dts/rk3xxx.dtsi                      |  3 ++
> >  arch/arm/boot/dts/rv1108.dtsi                      |  1 +
> >  arch/arm64/boot/dts/rockchip/px30.dtsi             |  1 +
> >  arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  2 +
> >  arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  1 +
> >  arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  2 +
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  2 +
> >  drivers/dma/pl330.c                                | 44 +++++++++++++++-------
> >  12 files changed, 49 insertions(+), 13 deletions(-)
> >
> > --
> > 2.7.4
> >
> >
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
