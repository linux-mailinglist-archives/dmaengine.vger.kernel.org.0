Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35283224BEE
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jul 2020 16:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGROky (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jul 2020 10:40:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38918 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgGROkx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 18 Jul 2020 10:40:53 -0400
Received: from x2f7f83e.dyn.telefonica.de ([2.247.248.62] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jwo0t-0007Eg-A6; Sat, 18 Jul 2020 16:40:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Carlos de Paula <me@carlosedp.com>,
        dmaengine@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/14] Patches to improve transfer efficiency for Rockchip SoCs.
Date:   Sat, 18 Jul 2020 16:40:29 +0200
Message-ID: <1883465.KieDo6KLrp@phil>
In-Reply-To: <1593439555-68130-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1593439555-68130-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Montag, 29. Juni 2020, 16:05:41 CEST schrieb Sugar Zhang:
> Changes in v3:
> - rephrase commit message
> - fix typos in commit message
> - split the patch for [PATCH V2 1/14]
> - reorder the patch series
> 
> Changes in v2:
> - fix FATAL ERROR: Unable to parse input tree
> 
> Sugar Zhang (14):
>   dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
>   dmaengine: pl330: Improve transfer efficiency for the dregs
>   dt-bindings: dma: pl330: Document the quirk 'arm,pl330-periph-burst'
>   dmaengine: pl330: Add quirk 'arm,pl330-periph-burst'
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

applied the patches 5-14 but merged them into one for arm32
and one for arm64 and did some slight reordering when the new
property was added at the bottom of the node.

Thanks
Heiko


