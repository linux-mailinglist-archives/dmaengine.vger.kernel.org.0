Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DDB1D4596
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 08:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgEOGJT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 02:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgEOGJS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 02:09:18 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62AAE2065F;
        Fri, 15 May 2020 06:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589522958;
        bh=kgLtAKAfE9tPkcpQWYFZxlQ+PomFFTOqOI8Aot+uWlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpXT4he0xdWcmrcjS/VNjmglDEDWEmj7Vq5dRgrt8nABPbVNpJdj7fQGxuf5pbFTW
         sX6vt6Rt6SyZc0kmQsycfvi27XzW5xB1arzxtopdHNvrEf5B9Wf36v7BA7aq9ErklA
         M3tNNI2EvAsesfJnoomkv6nPDwSLn/APVqdO7Cgo=
Date:   Fri, 15 May 2020 11:39:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200515060911.GF333670@vkoul-mobl>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
 <20200511213531.wnywlljiulvndx6s@mobilestation>
 <20200512090804.GR185537@smile.fi.intel.com>
 <20200512114946.x777yb6bhe22ccn5@mobilestation>
 <20200512123840.GY185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512123840.GY185537@smile.fi.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-05-20, 15:38, Andy Shevchenko wrote:
> On Tue, May 12, 2020 at 02:49:46PM +0300, Serge Semin wrote:
> > On Tue, May 12, 2020 at 12:08:04PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 12, 2020 at 12:35:31AM +0300, Serge Semin wrote:
> > > > On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> > > > > On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > > > > > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > > > > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> 
> ...
> 
> I leave it to Rob and Vinod.
> It won't break our case, so, feel free with your approach.

I agree the DT is about describing the hardware and looks like value of
1 is not allowed. If allowed it should be added..

> P.S. Perhaps at some point we need to
> 1) convert properties to be u32 (it will simplify things);
> 2) convert legacy ones to proper format ('-' instead of '_', vendor prefix added);
> 3) parse them in core with device property API.

These suggestions are good and should be done.

-- 
~Vinod
