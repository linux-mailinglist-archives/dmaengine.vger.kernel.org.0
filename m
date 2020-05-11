Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9651CE505
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgEKUFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 16:05:32 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49948 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgEKUFc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 16:05:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9901C8030807;
        Mon, 11 May 2020 20:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TaAw1Br-ho0e; Mon, 11 May 2020 23:05:29 +0300 (MSK)
Date:   Mon, 11 May 2020 23:05:28 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-mips@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508111242.GH185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> > This array property is used to indicate the maximum burst transaction
> > length supported by each DMA channel.
> 
> > +  snps,max-burst-len:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      Maximum length of burst transactions supported by hardware.
> > +      It's an array property with one cell per channel in units of
> > +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH (data-width) field.
> > +    items:
> > +      maxItems: 8
> > +      items:
> 
> > +        enum: [4, 8, 16, 32, 64, 128, 256]
> 
> Isn't 1 allowed?

Burst length of 1 unit is supported, but in accordance with Data Book the MAX
burst length is limited to be equal to a value from the set I submitted. So the
max value can be either 4, or 8, or 16 and so on.

-Sergey

> 
> > +        default: 256
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
