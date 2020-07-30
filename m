Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F187F233714
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgG3QrH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 12:47:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:46047 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3QrH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jul 2020 12:47:07 -0400
IronPort-SDR: CPysFfUPK8cmg5fuf7blBEltC97QtPBpTk1vZva0ko8tx0U40955ydNwouBLW+QJ26i4Om+w5n
 WrQ1b+Z7lSUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131709839"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="131709839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:47:06 -0700
IronPort-SDR: 6W6SbbiJ950GAjFH2MPvKiZWg0mKlPzfwMuDC8JFR2Wm/uv7CuBzrsqn/6Y95ianlAKePyKgTa
 uUpJVlOsVaRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="286915453"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2020 09:47:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1Bhv-004zTE-7c; Thu, 30 Jul 2020 19:47:03 +0300
Date:   Thu, 30 Jul 2020 19:47:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dmaengine: dw: Activate FIFO-mode for memory
 peripherals only
Message-ID: <20200730164703.GY3703480@smile.fi.intel.com>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-3-Sergey.Semin@baikalelectronics.ru>
 <20200730162428.GU3703480@smile.fi.intel.com>
 <20200730163154.qqrlas4zrybvocno@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730163154.qqrlas4zrybvocno@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 30, 2020 at 07:31:54PM +0300, Serge Semin wrote:
> On Thu, Jul 30, 2020 at 07:24:28PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 30, 2020 at 06:45:42PM +0300, Serge Semin wrote:

...

> > > Thanks to the commit ???????????? ("dmaengine: dw: Initialize channel

...

> > > Note the DMA-engine repository git.infradead.org/users/vkoul/slave-dma.git
> > > isn't accessible. So I couldn't find out the Andy' commit hash to use it in
> > > the log.
> 
> > It's dmaengine.git on git.kernel.org.
> 
> Ah, thanks! I've just found out that the repo address has been changed. But I've
> also scanned the "next" branch of the repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> 
> Your commit isn't there. Am I missing something?

It's a fix. It went to upstream branch (don't remember its name by heart in
Vinod's repo).

-- 
With Best Regards,
Andy Shevchenko


