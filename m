Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47F1CF48A
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgELMim (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 08:38:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:29143 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELMim (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 May 2020 08:38:42 -0400
IronPort-SDR: VkWmPzneX9LNlzsLsx8GQeQd3rKF1ORl72YYX8j04ijjXT13G4NUUbuY7ZB8n5WD7TVCeuf/b6
 0IWLU0De3VzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:38:41 -0700
IronPort-SDR: pjLjBdE9D2a4APL55HZwnwPVi9BgWVq/KAIUuq5ZJlncezMc2fiRyJtto+cb2MGsL2bfk5r8Pf
 kv0Qg0HksgfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="262108558"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 12 May 2020 05:38:37 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYUBE-006CfE-IT; Tue, 12 May 2020 15:38:40 +0300
Date:   Tue, 12 May 2020 15:38:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <20200512123840.GY185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
 <20200511213531.wnywlljiulvndx6s@mobilestation>
 <20200512090804.GR185537@smile.fi.intel.com>
 <20200512114946.x777yb6bhe22ccn5@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512114946.x777yb6bhe22ccn5@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 02:49:46PM +0300, Serge Semin wrote:
> On Tue, May 12, 2020 at 12:08:04PM +0300, Andy Shevchenko wrote:
> > On Tue, May 12, 2020 at 12:35:31AM +0300, Serge Semin wrote:
> > > On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> > > > On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > > > > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:

...

I leave it to Rob and Vinod.
It won't break our case, so, feel free with your approach.

P.S. Perhaps at some point we need to
1) convert properties to be u32 (it will simplify things);
2) convert legacy ones to proper format ('-' instead of '_', vendor prefix added);
3) parse them in core with device property API.

-- 
With Best Regards,
Andy Shevchenko


