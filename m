Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B31D4C2B
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 13:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgEOLLR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 07:11:17 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36082 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgEOLLR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 May 2020 07:11:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 44F708029EC9;
        Fri, 15 May 2020 11:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 54LBlF8pMoKn; Fri, 15 May 2020 14:11:13 +0300 (MSK)
Date:   Fri, 15 May 2020 14:11:12 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200515111112.4umynrpgzjnca223@mobilestation>
References: <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
 <20200511213531.wnywlljiulvndx6s@mobilestation>
 <20200512090804.GR185537@smile.fi.intel.com>
 <20200512114946.x777yb6bhe22ccn5@mobilestation>
 <20200512123840.GY185537@smile.fi.intel.com>
 <20200515060911.GF333670@vkoul-mobl>
 <20200515105137.GK185537@smile.fi.intel.com>
 <20200515105658.GR333670@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515105658.GR333670@vkoul-mobl>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 15, 2020 at 04:26:58PM +0530, Vinod Koul wrote:
> On 15-05-20, 13:51, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 11:39:11AM +0530, Vinod Koul wrote:
> > > On 12-05-20, 15:38, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2020 at 02:49:46PM +0300, Serge Semin wrote:
> > > > > On Tue, May 12, 2020 at 12:08:04PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, May 12, 2020 at 12:35:31AM +0300, Serge Semin wrote:
> > > > > > > On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> > > > > > > > On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > > > > > > > > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> > 
> > ...
> > 
> > > > I leave it to Rob and Vinod.
> > > > It won't break our case, so, feel free with your approach.
> > > 
> > > I agree the DT is about describing the hardware and looks like value of
> > > 1 is not allowed. If allowed it should be added..
> > 
> > It's allowed at *run time*, it's illegal in *pre-silicon stage* when
> > synthesizing the IP.
> 
> Then it should be added ..

Vinod, max-burst-len is "MAXimum" burst length not "run-time or current or any
other" burst length. It's a constant defined at the IP-core synthesis stage and
according to the Data Book, MAX burst length can't be 1. The allowed values are
exactly as I described in the binding [4, 8, 16, 32, ...]. MAX burst length
defines the upper limit of the run-time burst length. So setting it to 1 isn't
about describing a hardware, but using DT for the software convenience.

-Sergey

> 
> -- 
> ~Vinod
