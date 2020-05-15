Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454F21D4B8D
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 12:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEOKvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 06:51:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:48323 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgEOKvj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 06:51:39 -0400
IronPort-SDR: 9FKqJQSzsTTp2bRC61Oa2xkR/B2/JxHpm7hnAfbG9Snxd8dejrqnqbU6BFTIniK3Z+GI4znv57
 qatolTwWZ3cw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 03:51:39 -0700
IronPort-SDR: bQmEm3KvsMGShLrikAYJH2NXMbSjsZgSZKRjHrRKH5W29Nm8n+oMC4cS7qpI0ezRzzQLgbLrth
 yR0QAGXaCLaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="438270817"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2020 03:51:34 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZXwH-006qGW-B9; Fri, 15 May 2020 13:51:37 +0300
Date:   Fri, 15 May 2020 13:51:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
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
Message-ID: <20200515105137.GK185537@smile.fi.intel.com>
References: <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
 <20200511213531.wnywlljiulvndx6s@mobilestation>
 <20200512090804.GR185537@smile.fi.intel.com>
 <20200512114946.x777yb6bhe22ccn5@mobilestation>
 <20200512123840.GY185537@smile.fi.intel.com>
 <20200515060911.GF333670@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515060911.GF333670@vkoul-mobl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 15, 2020 at 11:39:11AM +0530, Vinod Koul wrote:
> On 12-05-20, 15:38, Andy Shevchenko wrote:
> > On Tue, May 12, 2020 at 02:49:46PM +0300, Serge Semin wrote:
> > > On Tue, May 12, 2020 at 12:08:04PM +0300, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2020 at 12:35:31AM +0300, Serge Semin wrote:
> > > > > On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> > > > > > On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > > > > > > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > > > > > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:

...

> > I leave it to Rob and Vinod.
> > It won't break our case, so, feel free with your approach.
> 
> I agree the DT is about describing the hardware and looks like value of
> 1 is not allowed. If allowed it should be added..

It's allowed at *run time*, it's illegal in *pre-silicon stage* when
synthesizing the IP.

-- 
With Best Regards,
Andy Shevchenko


