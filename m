Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6685856218D
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jun 2022 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiF3Ryh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jun 2022 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiF3Ryg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jun 2022 13:54:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5611637AA9;
        Thu, 30 Jun 2022 10:54:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DEB31063;
        Thu, 30 Jun 2022 10:54:35 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 713CA3F5A1;
        Thu, 30 Jun 2022 10:54:29 -0700 (PDT)
Date:   Thu, 30 Jun 2022 18:53:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 00/15] Canaan devicetree fixes
Message-ID: <20220630175318.g2zmu6ek7l5iakve@bogus>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <Yr3PKR0Uj1bE5Y6O@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr3PKR0Uj1bE5Y6O@x1-carbon>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 30, 2022 at 04:28:26PM +0000, Niklas Cassel wrote:
> On Wed, Jun 29, 2022 at 07:43:29PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Hey all,
> > This series should rid us of dtbs_check errors for the RISC-V Canaan k210
> > based boards. To make keeping it that way a little easier, I changed the
> > Canaan devicetree Makefile so that it would build all of the devicetrees
> > in the directory if SOC_CANAAN.
> > 
> > I *DO NOT* have any Canaan hardware so I have not tested any of this in
> > action. Since I sent v1, I tried to buy some since it's cheap - but could
> > out of the limited stockists none seemed to want to deliver to Ireland :(
> > I based the series on next-20220617.
> > 
> 
> I first tried to apply your series on top of next-20220630,
> but was greeted by a bunch of different warnings on boot,
> including endless RCU stall warnings.
> However, even when booting next-20220630 without your patches,
> I got the same warnings and RCU stall.
>

Is it possible to share the boot logs please ?
Conor is having issues with my arch_topology/cacheinfo updates in -next.
I would like to know if your issue is related to that or not ?

> So I tested your series on top of v5.19-rc4 +
> commit 0397d50f4cad ("spi: dt-bindings: Move 'rx-sample-delay-ns' to
> spi-peripheral-props.yaml") cherry-picked,
> (in order to avoid conflicts when applying your series,)
> and the board was working as intended, no warnings or RCU stalls.
>

If possible can you give this branch[1] a try where my changes are and doesn't
have any other changes from -next. Sorry to bother you.

Conor seem to have issue with this commit[2], so if you get issues try to
check if [3] works.

Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/c/ae85abf284e7
[2] https://git.kernel.org/sudeep.holla/c/155bd845d17b
[3] https://git.kernel.org/sudeep.holla/c/009297d29faa
