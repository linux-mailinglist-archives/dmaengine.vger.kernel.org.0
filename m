Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08AA2E203C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgLWR6I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 12:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgLWR6I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Dec 2020 12:58:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F160C061794;
        Wed, 23 Dec 2020 09:57:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 663CE9E6;
        Wed, 23 Dec 2020 18:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608746243;
        bh=aIE8xGXf1HCeioV2CtalepWGwUaG6UD1DR44h6nu1dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q984DeWns2WpIpS44Mmf+NBIdwZ0VKyg0sn0lxei+qgt/rfO6sWAZCb1+DVvQDi9o
         InOBPu2fmLsVSlUtYnX5YK6WtH1oGzHcsyyF5jg0UJ1C7Zr11yWf/HAantErvmp/qN
         OE98sGc1W7JKZP2xFooqGJIBJ0Zkab3u+qIoO3Hc=
Date:   Wed, 23 Dec 2020 19:57:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <X+OE+6VNC5bCMBlD@pendragon.ideasonboard.com>
References: <20201222040645.1323611-1-robh@kernel.org>
 <20201222063908.GB3463004@ravnborg.org>
 <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 23, 2020 at 10:54:26AM -0700, Rob Herring wrote:
> On Mon, Dec 21, 2020 at 11:39 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Rob,
> >
> > On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> > > 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> > > preferred for a single entry while greater than 1 should have an 'items'
> > > list.
> > >
> > > A meta-schema check for this is pending once these existing cases are
> > > fixed.
> > >
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jassi Brar <jaswinder.singh@linaro.org>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: dmaengine@vger.kernel.org
> > > Cc: alsa-devel@alsa-project.org
> > > Cc: linux-usb@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > With one comment below,
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > > ---
> > > diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > > index 737c1f47b7de..54c361d4a7af 100644
> > > --- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > > @@ -74,11 +74,8 @@ properties:
> > >
> > >    phys:
> > >      maxItems: 1
> > > -    items:
> > > -      - description: phandle + phy specifier pair.
> >
> > The description may help some people, so keeping the
> > description and deleting maxItems would maybe be better.
> 
> Do we really want to describe 'phys' hundreds of times? No. The
> question I ask on the descriptions is could it be generated instead.

I agree. If the description had mentioned why particular PHY was
referenced, I would have kept that, but "the phy is a phy" is probably
not something we want to duplicate everywhere.

-- 
Regards,

Laurent Pinchart
