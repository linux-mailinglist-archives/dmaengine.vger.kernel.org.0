Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82341F7190
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2020 03:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFLBGX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jun 2020 21:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLBGV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Jun 2020 21:06:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A043C03E96F;
        Thu, 11 Jun 2020 18:06:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so8431675ejc.1;
        Thu, 11 Jun 2020 18:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWMqM4EWUTN/tZ1PSJ29RPSc7m9eyjQgLenvkceVjOU=;
        b=mNx6536r715NBnskOPn1bdL5xCLTV9aec/WpZqRnZrhvWlD+kxiMUC9R+o/sQtOPK1
         m2ldqoyMAEgUFiwM2DFUto+MuvVzSYlnys5Gwx99yKzZhRVmtm6FI19U8PDeV+0oKHIf
         4qtt5+hz0BWxGpHxFEakWLwDW+m/zs76ThXZ1XMjIyEk5CRBaHHDtzj11Eo3Q3AFYzAl
         Y/SD6ODdt/SSDEo+kliR/bCL7fe9qra4GEEHjAaxEVAiiqWgp+XJyXHBjWRhUkO2MkzE
         JyLgiLlc82/T3yfRmqXBMnPXlTzqI0OaJ0WbFqHQMkBBw73fJCszzV0zQsePLAMWCgpS
         XF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWMqM4EWUTN/tZ1PSJ29RPSc7m9eyjQgLenvkceVjOU=;
        b=ciAPXQXkKHUEDfvDWW39RinX3IgINK8kVvqjqPivlU8EX8AMXi6rSShHzxaIEPUPVS
         3ibGQeOlV8+vsJqBloAhUnPekKbstzA0WZZS3PaL09mIuJydyspfgeJeM/xGXo2fgblZ
         1X0m5jTYzHgbVWZAmiVEw73CIGnEyTOcvQoWFpvB0UDqchL3myHwPQ7zSiMR8ZTEorAm
         yu3uxYnVU5L3H+SwUuECqSzLjX4abCvut/qQqKCnleo5WT3LBxkV+SAqriUjih0d7877
         eYxBceAAqkZq6Zk2eaov0GwS47aGevKHuZCcqkaBQST+euwgvA1vzw5o3kHghrQU+DS5
         RtBA==
X-Gm-Message-State: AOAM5332ALMv7PAsuF3uL8ou10QL8t+KE4F1E+dTll/LDaaXInbI7V8v
        EQJqYrnxng5ja40FaL7wkm0B1OdBHg97Hz3SKow=
X-Google-Smtp-Source: ABdhPJyZ5DVMliAOduWmg47LdIrQ4yp92mfh3e85UoCZsPM9fdn/2djYt+DceiV9URZ9A6OY+OcY2ks7Bhv9wyUHhhI=
X-Received: by 2002:a17:906:5595:: with SMTP id y21mr11305629ejp.61.1591923979560;
 Thu, 11 Jun 2020 18:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
In-Reply-To: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 11 Jun 2020 21:06:07 -0400
Message-ID: <CAMdYzYr+NF7L3KKzcGano=j9V844Gy8gH03hD++CoPe8Ao1QxQ@mail.gmail.com>
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

Good Evening,

I am currently testing this on the rk3399-rockpro64, and it appears to
fully fix the gmac problem without using txpbl.
PCIe also seems to be more stable at high load.
I need to conduct long term testing, but it seems to be doing very well.

Unfortunately it doesn't fix the rk3328 gmac controller.

Tested-by: Peter Geis <pgwipeout@gmail.com>

On Mon, Jun 8, 2020 at 9:15 PM Sugar Zhang <sugar.zhang@rock-chips.com> wrote:
>
>
>
> Changes in v2:
> - fix FATAL ERROR: Unable to parse input tree
>
> Sugar Zhang (13):
>   dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
>   dmaengine: pl330: Add quirk 'arm,pl330-periph-burst'
>   dt-bindings: dma: pl330: Document the quirk 'arm,pl330-periph-burst'
>   ARM: dts: rk3036: Add 'arm,pl330-periph-burst' for dmac
>   ARM: dts: rk322x: Add 'arm,pl330-periph-burst' for dmac
>   ARM: dts: rk3288: Add 'arm,pl330-periph-burst' for dmac
>   ARM: dts: rk3xxx: Add 'arm,pl330-periph-burst' for dmac
>   ARM: dts: rv1108: Add 'arm,pl330-periph-burst' for dmac
>   arm64: dts: px30: Add 'arm,pl330-periph-burst' for dmac
>   arm64: dts: rk3308: Add 'arm,pl330-periph-burst' for dmac
>   arm64: dts: rk3328: Add 'arm,pl330-periph-burst' for dmac
>   arm64: dts: rk3368: Add 'arm,pl330-periph-burst' for dmac
>   arm64: dts: rk3399: Add 'arm,pl330-periph-burst' for dmac
>
>  .../devicetree/bindings/dma/arm-pl330.txt          |  1 +
>  arch/arm/boot/dts/rk3036.dtsi                      |  1 +
>  arch/arm/boot/dts/rk322x.dtsi                      |  1 +
>  arch/arm/boot/dts/rk3288.dtsi                      |  3 ++
>  arch/arm/boot/dts/rk3xxx.dtsi                      |  3 ++
>  arch/arm/boot/dts/rv1108.dtsi                      |  1 +
>  arch/arm64/boot/dts/rockchip/px30.dtsi             |  1 +
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  2 +
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  1 +
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  2 +
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  2 +
>  drivers/dma/pl330.c                                | 44 +++++++++++++++-------
>  12 files changed, 49 insertions(+), 13 deletions(-)
>
> --
> 2.7.4
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
