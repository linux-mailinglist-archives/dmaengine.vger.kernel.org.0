Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF12018FF
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2020 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbgFSRBi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jun 2020 13:01:38 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:37424 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbgFSRBh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Jun 2020 13:01:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 45B9480045E5;
        Fri, 19 Jun 2020 17:01:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2LmcmqX_SRgV; Fri, 19 Jun 2020 20:01:26 +0300 (MSK)
Date:   Fri, 19 Jun 2020 20:01:25 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/9] dt-bindings: dma: dw: Convert DW DMAC to DT
 binding
Message-ID: <20200619170125.7ww5ornsqctscine@mobilestation>
References: <20200617234028.25808-1-Sergey.Semin@baikalelectronics.ru>
 <20200617234028.25808-2-Sergey.Semin@baikalelectronics.ru>
 <CAHp75Vd+3ZN51geXg+KiQYVpBZN7F+kgt-2Snw7VDiKiYVqX=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd+3ZN51geXg+KiQYVpBZN7F+kgt-2Snw7VDiKiYVqX=A@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 18, 2020 at 11:21:53AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 18, 2020 at 2:43 AM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > Modern device tree bindings are supposed to be created as YAML-files
> > in accordance with dt-schema. This commit replaces the Synopsis
> > Designware DMA controller legacy bare text bindings with YAML file.
> > The only required prorties are "compatible", "reg", "#dma-cells" and
> > "interrupts", which will be used by the driver to correctly find the
> > controller memory region and handle its events. The rest of the properties
> > are optional, since in case if either "dma-channels" or "dma-masters" isn't
> > specified, the driver will attempt to auto-detect the IP core
> > configuration.
> >
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: linux-mips@vger.kernel.org
> 
> 

> Rob, here are questions to you.

Rob normally is very busy. So I hope you won't mind me answering in his stead.

> 
> > +  dma-channels:
> > +    description: |
> > +      Number of DMA channels supported by the controller. In case if
> > +      not specified the driver will try to auto-detect this and
> > +      the rest of the optional parameters.
> > +    minimum: 1
> > +    maximum: 8
> 
> ...
> 
> > +  multi-block:
> 
> > +      maxItems: 8
> 

> This maximum is defined by above dma-channels property. Is there any
> way to put it in the schema?

Neither Json nor Yaml schema support inter-properties values dependencies
out of box. If it's required, then a back-end must be properly tuned up.
In other words the dt-schema framework should be altered to parse the
"dma-channels" property and to apply the constraint to another property
in accordance with its value.

> 
> ...
> 
> > +  snps,dma-protection-control:
> > +    $ref: /schemas/types.yaml#definitions/uint32
> > +    description: |
> > +      Bits one-to-one passed to the AHB HPROT[3:1] bus. Each bit setting
> > +      indicates the following features: bit 0 - privileged mode,
> > +      bit 1 - DMA is bufferable, bit 2 - DMA is cacheable.
> > +    default: 0
> > +    minimum: 0
> > +    maximum: 7
> 

> AFAIR this is defined by bit flags, does schema have a mechanism to
> define flags-like entries?

Normally a thing like that could be done by means of enum constraints.
But it only works for cases with non-combinable bit-fields, for
instance if there were only either privileged or bufferable or cacheable
modes. Otherwise we would have to describe each combination of the bits
setting, which as you understand would be very clumsy. Seeing there might
be any combination of the HPROT bits setting here we have no choice but
to use the range constraint.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
