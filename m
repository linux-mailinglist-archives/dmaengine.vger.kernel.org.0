Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41001D4BCE
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEOK5E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 06:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEOK5E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 06:57:04 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79CEE20709;
        Fri, 15 May 2020 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589540223;
        bh=Kgg+Dz7YYYCNO25bLu1uPRJYR5eSTQcswIqaUpnoW7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BI2Ru00w9RJBYHRds2Xq2Mkxr4W3LfhVlSyAywdh9J29ayepyZOjzpmQNA5e82s/l
         JGIWdKxJ32vIiyZJ+BYhvF+cuQ6YlObvkiOWorw1o6PLwEuWDvApbXHMF4sSW+7XqV
         JW7JA7ufXZkELpNXiq4XJ60LNVGEHtwcRpeDGJwo=
Date:   Fri, 15 May 2020 16:26:58 +0530
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
Message-ID: <20200515105658.GR333670@vkoul-mobl>
References: <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
 <20200511213531.wnywlljiulvndx6s@mobilestation>
 <20200512090804.GR185537@smile.fi.intel.com>
 <20200512114946.x777yb6bhe22ccn5@mobilestation>
 <20200512123840.GY185537@smile.fi.intel.com>
 <20200515060911.GF333670@vkoul-mobl>
 <20200515105137.GK185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515105137.GK185537@smile.fi.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-05-20, 13:51, Andy Shevchenko wrote:
> On Fri, May 15, 2020 at 11:39:11AM +0530, Vinod Koul wrote:
> > On 12-05-20, 15:38, Andy Shevchenko wrote:
> > > On Tue, May 12, 2020 at 02:49:46PM +0300, Serge Semin wrote:
> > > > On Tue, May 12, 2020 at 12:08:04PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, May 12, 2020 at 12:35:31AM +0300, Serge Semin wrote:
> > > > > > On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> > > > > > > On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > > > > > > > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > > > > > > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > I leave it to Rob and Vinod.
> > > It won't break our case, so, feel free with your approach.
> > 
> > I agree the DT is about describing the hardware and looks like value of
> > 1 is not allowed. If allowed it should be added..
> 
> It's allowed at *run time*, it's illegal in *pre-silicon stage* when
> synthesizing the IP.

Then it should be added ..

-- 
~Vinod
