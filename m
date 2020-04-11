Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB381A5346
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2020 20:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDKSV3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Apr 2020 14:21:29 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43370 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKSV2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Apr 2020 14:21:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D8BA18030786;
        Sat, 11 Apr 2020 18:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jxLEWrmPJugI; Sat, 11 Apr 2020 21:21:26 +0300 (MSK)
Date:   Sat, 11 Apr 2020 21:21:59 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: dma: dw: Add max burst transaction
 length property bindings
Message-ID: <20200411182159.fjjazqn6jjl3icep@ubsrv2.baikal.int>
References: <20200306131035.10937-1-Sergey.Semin@baikalelectronics.ru>
 <20200306131049.37EDD8030708@mail.baikalelectronics.ru>
 <20200312213330.GA30463@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312213330.GA30463@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 12, 2020 at 04:33:30PM -0500, Rob Herring wrote:
> On Fri, Mar 06, 2020 at 04:10:31PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > This array property is used to indicate the maximum burst transaction
> > length supported by each DMA channel.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  .../devicetree/bindings/dma/snps,dma-spear1340.yaml  | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> > index d7f9383ceb8f..308ec6482064 100644
> > --- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> > +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> > @@ -126,6 +126,18 @@ properties:
> >            enum: [0, 1]
> >            default: 0
> >  
> > +  snps,max-burst-len:
> > +    description: |
> > +      Maximum length of burst transactions supported by hardware.
> > +      It's an array property with one cell per channel in units of
> > +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH field.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      - maxItems: 8
> > +        items:
> > +          enum: [4, 8, 16, 32, 64, 128, 256]
> > +          default: 0
> 
> The default needs to be an allowed value in the enum.

Right. I'll fix it.

-Sergey

> 
> Rob
