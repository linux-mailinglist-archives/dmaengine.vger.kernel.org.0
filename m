Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4403A6B7A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhFNQTm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 12:19:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36894 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhFNQTm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Jun 2021 12:19:42 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 55119A59;
        Mon, 14 Jun 2021 18:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623687457;
        bh=vN6UQFf2qEAon/wrw/8BklVuLhi9CRlkMcfM6BKim9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H950cR5eqUa9VJfmzWJJnJoFekSjQk7uzTBPEmVyZM9PArvnlgeLshWRARyvbtwLW
         VvvEYXN9TUFSPP4zJNdirwaR+Pp01p18+A69pmfkp18RqKRduLLb/Q65D5caOdZOwl
         kZMvjeqerKnnTUu95jpw1qoMuoWmVXmbGdg06gBs=
Date:   Mon, 14 Jun 2021 19:17:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Message-ID: <YMeBDfrVLZxSkVnL@pendragon.ideasonboard.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdUQRHtVFhqmgi5EE2TNobspM3tNTP10gz-yPDJSK31ytA@mail.gmail.com>
 <OS0PR01MB5922B2355864A98B14C6DE6D86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YMdnzdCvX/ur9qVr@pendragon.ideasonboard.com>
 <OS0PR01MB59227DFC38FD6CF6C568A90E86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59227DFC38FD6CF6C568A90E86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Mon, Jun 14, 2021 at 04:09:04PM +0000, Biju Das wrote:
> > On Mon, Jun 14, 2021 at 12:54:02PM +0000, Biju Das wrote:
> > > > On Fri, Jun 11, 2021 at 1:36 PM Biju Das wrote:
> > > > > Document RZ/G2L DMAC bindings.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > > @@ -0,0 +1,132 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > > +1.2
> > > > > +---
> > > > > +$id:
> > > > > +https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2F
> > > > > +devi
> > > > > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%23&amp;data=0
> > > > > +4%7C
> > > > > +01%7Cbiju.das.jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da
> > > > > +0c0%
> > > > > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7
> > > > > +CUnk
> > > > > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> > > > > +1haW
> > > > > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5Jh%2FxPaia5ZOY0CrViQCcrNtzuDej
> > > > > +p8wo
> > > > > +Nrx9iO0ht8%3D&amp;reserved=0
> > > > > +$schema:
> > > > > +https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2F
> > > > > +devi
> > > > > +cetree.org%2Fmeta-
> > schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cbiju.das.
> > > > > +jz%40bp.renesas.com%7C4b547e10cbe64b6f4d8508d92f2da0c0%7C53d82571
> > > > > +da19
> > > > > +47e49cb4625a166a4a2a%7C0%7C0%7C637592695286846809%7CUnknown%7CTWF
> > > > > +pbGZ
> > > > > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > > > > +Mn0%
> > > > > +3D%7C1000&amp;sdata=5qQ1PljM3e4Bn4%2FjdldYUHRBQL3jArJgRIAdLnhJraw
> > > > > +%3D&
> > > > > +amp;reserved=0
> > 
> > *sigh*
> > 
> > > > > +
> > > > > +title: Renesas RZ/G2L DMA Controller
> > > > > +
> > > > > +maintainers:
> > > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: "dma-controller.yaml#"
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    items:
> > > > > +      - enum:
> > > > > +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
> > > >
> > > > Please use "renesas,r9a07g044-dmac".
> > >
> > > OK. Will change.
> > >
> > > > > +      - const: renesas,rz-dmac
> > > >
> > > > Does this need many changes for RZ/A1H and RZ/A2M?
> > >
> > > It will work on both RZ/A1H and RZ/A2M. I have n't tested since I don't have the board.
> > > There is some difference in MID bit size. Other wise both identical.
> > >
> > > > > +  renesas,rz-dmac-slavecfg:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +    description: |
> > > > > +      DMA configuration for a slave channel. Each channel must
> > > > > + have an array of
> > > > > +      3 items as below.
> > > > > +      first item in the array is MID+RID
> > > >
> > > > Already in dmas.
> > > >
> > > > > +      second item in the array is slave src or dst address
> > > >
> > > > As pointed out by Rob, already known by the slave driver.
> > > >
> > > > > +      third item in the array is channel configuration value.
> > > >
> > > > What exactly is this?
> > 
> > What would prevent the DMA client from passing the configuration to the
> > DMA channel through the DMA engine API, just like it passes the slave
> > source or destination address ?
> 
> On RZ/G2L, there is 1 case(SSIF ch2) where MID+RID is same for both tx and rx. 
> The only way we can distinguish it is from channel configuration value.

Are those two different hardware DMA channels ? And configuration values
change between the two ?

> > > > Does the R-Car DMAC have this too? If yes, how does its driver
> > > > handle it?
> > >
> > > On R-CAR DMAC, we have only MID + RID values. Where as here we
> > > have channel configuration value With different set of parameter
> > > as mentioned in Table 16.4.
> > >
> > > Please see Page 569, Table 16.4 On-Chip Module requests section.
> > >
> > > For eg:- as per Rob's suggestion, I have modelled the driver with
> > > the below entries in ALSA driver for playback/record use case.
> > >
> > > dmas = <&dmac 0x255 0x10049c18 CH_CFG(0x1,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>,
> > >        <&dmac 0x256 0x10049c1c
> > > CH_CFG(0x0,0x0,0x1,0x0,0x2,0x1,0x1,0x0)>;
> > > dma-names = "tx", "rx";
> > >
> > > Using first parameter, it gets dmac channel. using second and third
> > > parameter it configures the channel.

-- 
Regards,

Laurent Pinchart
