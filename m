Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958C92E20F9
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 20:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgLWTjb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 14:39:31 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:44328 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLWTjb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Dec 2020 14:39:31 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7EE318053B;
        Wed, 23 Dec 2020 20:38:41 +0100 (CET)
Date:   Wed, 23 Dec 2020 20:38:40 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <20201223193840.GA3669192@ravnborg.org>
References: <20201222040645.1323611-1-robh@kernel.org>
 <20201222063908.GB3463004@ravnborg.org>
 <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=ceURT3LBwQyT03W6ftYA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

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
> Do we really want to describe 'phys' hundreds of times? No.
Agree, for common properties we as a minimum want a phy-common.yaml
or some such - and have the description exactly once.

> The
> question I ask on the descriptions is could it be generated instead.
That could also be an idea, but assuming most people look at the source
then the same "most people" would miss the generated descriptions.

But to be clear - I see that phys: is a commonly used property so no
problem to have the description dropped here.
Ack still stands.

	Sam
