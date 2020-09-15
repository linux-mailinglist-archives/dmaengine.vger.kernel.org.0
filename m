Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF026A6CE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Sep 2020 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIOOHZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Sep 2020 10:07:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:23295 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgIOOHJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Sep 2020 10:07:09 -0400
IronPort-SDR: p9KEpeHwUmMvXeHoAq6wu/oQaSdg/g3eSJre5TgRd9nKlOq+5nxibakqvL9ENmkNvUHn0C1zjX
 J2m07FXhEwXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="139268073"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="139268073"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:57:04 -0700
IronPort-SDR: Z6/+EF8RhhkhVPC8Hh27QGdjfSdzwLtGEwK+scE+vPVzk01qgRkD7cufVbwNKistdGS8jzU0lw
 x/ueVDvArD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="335671232"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 15 Sep 2020 06:57:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kIBS7-00Gqu6-Uc; Tue, 15 Sep 2020 16:56:59 +0300
Date:   Tue, 15 Sep 2020 16:56:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 6b41030fdc790 broke dmatest badly
Message-ID: <20200915135659.GA3956970@smile.fi.intel.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
 <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
 <20200907120440.GC1891694@smile.fi.intel.com>
 <004640d8-e236-4b75-1bfd-cc386bbf08a6@arm.com>
 <20200907140502.GK1891694@smile.fi.intel.com>
 <54ba60c3-9a04-51ac-688c-425b85202b18@arm.com>
 <578f9c4d-3d29-d1f3-17f7-94dfe24403c4@arm.com>
 <20200915123537.GU3956970@smile.fi.intel.com>
 <d2d43434-d75a-a6cd-c6f9-daaa20260e58@arm.com>
 <20200915134625.GZ3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915134625.GZ3956970@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 15, 2020 at 04:46:25PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 15, 2020 at 01:46:12PM +0100, Vladimir Murzin wrote:
> > On 9/15/20 1:35 PM, Andy Shevchenko wrote:
> > > On Fri, Sep 11, 2020 at 09:34:04AM +0100, Vladimir Murzin wrote:
> > >> On 9/7/20 5:52 PM, Vladimir Murzin wrote:
> 
> ...
> 
> > >> An update on this?
> > > 
> > > Sorry for delay. I have tested your patch and it works for my case. Though I
> > > would amend it a bit (commit message is still a due).
> > 
> > 
> > That's good, but what about behaviour prior d53513d5dc28? Did you (or somebody
> > else) have a chance to confirm that it won't run with plain defaults?

Yes, I may confirm this. I have taken dmatest just before that commit as of
  % git checkout 3f3c75541ffe -- drivers/dma/dmatest.c
and it simple returns 0 and nothing happens.

So, please provide a commit message to your fix, I'll incorporate it and send as a part of the series.

-- 
With Best Regards,
Andy Shevchenko


