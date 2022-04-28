Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E8512CD7
	for <lists+dmaengine@lfdr.de>; Thu, 28 Apr 2022 09:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiD1Hd4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Apr 2022 03:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbiD1Hd4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Apr 2022 03:33:56 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B9BE694B3;
        Thu, 28 Apr 2022 00:30:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4022F80C1;
        Thu, 28 Apr 2022 07:27:35 +0000 (UTC)
Date:   Thu, 28 Apr 2022 10:30:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 4/6] ARM: dts: am33xx: use new 'dma-channels/requests'
 properties
Message-ID: <YmpCn+g7oN+1HWSY@atomide.com>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
 <20220427161126.647073-5-krzysztof.kozlowski@linaro.org>
 <YmmJfInA0hNQOhDN@robh.at.kernel.org>
 <CAGE=qrp1GAVxDF4b1iBigdvbONwsF0jhfcLG-Xt3pjm8VAEdiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGE=qrp1GAVxDF4b1iBigdvbONwsF0jhfcLG-Xt3pjm8VAEdiQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [220427 19:23]:
> On Wed, 27 Apr 2022 at 20:20, Rob Herring <robh@kernel.org> wrote:
> > > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > > index f6ec85d58dd1..55ffb0813ded 100644
> > > --- a/arch/arm/boot/dts/am33xx.dtsi
> > > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > > @@ -461,8 +461,8 @@ cppi41dma: dma-controller@2000 {
> > >                               interrupts = <17>;
> > >                               interrupt-names = "glue";
> > >                               #dma-cells = <2>;
> > > -                             #dma-channels = <30>;
> > > -                             #dma-requests = <256>;
> > > +                             dma-channels = <30>;
> > > +                             dma-requests = <256>;
> >
> > You could keep the old properties for compatibility and to apply
> > immediately.
> 
> Indeed, that's a nice solution. Any preference from TI SoC maintainers?

Makes sense to me to avoid dependencies.

Regards,

Tony
