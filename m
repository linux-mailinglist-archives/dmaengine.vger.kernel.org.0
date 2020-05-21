Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA81DC4E6
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2020 03:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgEUBrJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 May 2020 21:47:09 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:34352 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgEUBrJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 May 2020 21:47:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A36508030776;
        Thu, 21 May 2020 01:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L0UijymJus4x; Thu, 21 May 2020 04:47:06 +0300 (MSK)
Date:   Thu, 21 May 2020 04:47:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] dmaengine: dw: Introduce max burst length hw
 config
Message-ID: <20200521014705.ha7mpxoio4gitjox@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-6-Sergey.Semin@baikalelectronics.ru>
 <20200508114153.GK185537@smile.fi.intel.com>
 <20200512140820.ssjv6pl7busqqi3t@mobilestation>
 <20200512191208.GG185537@smile.fi.intel.com>
 <20200515063950.GI333670@vkoul-mobl>
 <20200517193818.jaiwgzgz7tutj4mk@mobilestation>
 <20200519170714.GT374218@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200519170714.GT374218@vkoul-mobl.Dlink>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 19, 2020 at 10:37:14PM +0530, Vinod Koul wrote:
> On 17-05-20, 22:38, Serge Semin wrote:
> > On Fri, May 15, 2020 at 12:09:50PM +0530, Vinod Koul wrote:
> > > On 12-05-20, 22:12, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2020 at 05:08:20PM +0300, Serge Semin wrote:
> > > > > On Fri, May 08, 2020 at 02:41:53PM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, May 08, 2020 at 01:53:03PM +0300, Serge Semin wrote:

[nip]

> > > > > > But let's see what we can do better. Since maximum is defined on the slave side
> > > > > > device, it probably needs to define minimum as well, otherwise it's possible
> > > > > > that some hardware can't cope underrun bursts.
> > > > > 
> > > > > There is no need to define minimum if such limit doesn't exists except a
> > > > > natural 1. Moreover it doesn't exist for all DMA controllers seeing noone has
> > > > > added such capability into the generic DMA subsystem so far.
> > > > 
> > > > There is a contract between provider and consumer about DMA resource. That's
> > > > why both sides should participate in fulfilling it. Theoretically it may be a
> > > > hardware that doesn't support minimum burst available in DMA by a reason. For
> > > > such we would need minimum to be provided as well.
> > > 
> > > Agreed and if required caps should be extended to tell consumer the
> > > minimum values supported.
> > 
> > Sorry, it's not required by our hardware. Is there any, which actually has such
> > limitation? (minimum burst length)
> 
> IIUC the idea is that you will tell maximum and minimum values supported
> and client can pick the best value. Esp in case of slave transfers
> things like burst, msize are governed by client capability and usage. So
> exposing the set to pick from would make sense

Agreed. I'll add min_burst capability.

-Sergey

> 
> -- 
> ~Vinod
