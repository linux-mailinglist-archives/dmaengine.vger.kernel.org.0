Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C835621EF
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jun 2022 20:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiF3SWo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jun 2022 14:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiF3SWk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jun 2022 14:22:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFF7A427C4;
        Thu, 30 Jun 2022 11:22:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBDC61063;
        Thu, 30 Jun 2022 11:22:39 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F6993F5A1;
        Thu, 30 Jun 2022 11:22:33 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:21:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     Niklas.Cassel@wdc.com, mail@conchuod.ie, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        sam@ravnborg.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, fancer.lancer@gmail.com,
        daniel.lezcano@linaro.org, palmer@dabbelt.com, palmer@rivosinc.com,
        tglx@linutronix.de, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, masahiroy@kernel.org,
        damien.lemoal@opensource.wdc.com, geert@linux-m68k.org,
        dillon.minfei@gmail.com, joabreu@synopsys.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/15] Canaan devicetree fixes
Message-ID: <20220630182122.j7m32mh3xmxwatga@bogus>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <Yr3PKR0Uj1bE5Y6O@x1-carbon>
 <20220630175318.g2zmu6ek7l5iakve@bogus>
 <d0634053-d882-fcb5-fd56-32dfbcf4d5ba@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0634053-d882-fcb5-fd56-32dfbcf4d5ba@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 30, 2022 at 06:01:09PM +0000, Conor.Dooley@microchip.com wrote:
> On 30/06/2022 18:53, Sudeep Holla wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Jun 30, 2022 at 04:28:26PM +0000, Niklas Cassel wrote:
> >> On Wed, Jun 29, 2022 at 07:43:29PM +0100, Conor Dooley wrote:
> >>> From: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>> Hey all,
> >>> This series should rid us of dtbs_check errors for the RISC-V Canaan k210
> >>> based boards. To make keeping it that way a little easier, I changed the
> >>> Canaan devicetree Makefile so that it would build all of the devicetrees
> >>> in the directory if SOC_CANAAN.
> >>>
> >>> I *DO NOT* have any Canaan hardware so I have not tested any of this in
> >>> action. Since I sent v1, I tried to buy some since it's cheap - but could
> >>> out of the limited stockists none seemed to want to deliver to Ireland :(
> >>> I based the series on next-20220617.
> >>>
> >>
> >> I first tried to apply your series on top of next-20220630,
> >> but was greeted by a bunch of different warnings on boot,
> >> including endless RCU stall warnings.
> >> However, even when booting next-20220630 without your patches,
> >> I got the same warnings and RCU stall.
> >>
> > 
> > Is it possible to share the boot logs please ?
> > Conor is having issues with my arch_topology/cacheinfo updates in -next.
> > I would like to know if your issue is related to that or not ?
> > 
> >> So I tested your series on top of v5.19-rc4 +
> >> commit 0397d50f4cad ("spi: dt-bindings: Move 'rx-sample-delay-ns' to
> >> spi-peripheral-props.yaml") cherry-picked,
> >> (in order to avoid conflicts when applying your series,)
> >> and the board was working as intended, no warnings or RCU stalls.
> >>
> > 
> > If possible can you give this branch[1] a try where my changes are and doesn't
> > have any other changes from -next. Sorry to bother you.
> > 
> > Conor seem to have issue with this commit[2], so if you get issues try to
> > check if [3] works.
> 
> FWIW, my problems with that are not on canaan hw.

I understand that, just helps to eliminate and see what are the possible
issues.

-- 
Regards,
Sudeep
