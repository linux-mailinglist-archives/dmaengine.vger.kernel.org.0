Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8923E2741A8
	for <lists+dmaengine@lfdr.de>; Tue, 22 Sep 2020 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVL5p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 07:57:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:60919 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgIVL5p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Sep 2020 07:57:45 -0400
IronPort-SDR: wS3+BrNSK/StMAJXXm7N9fLnzCAoIeRm4pbXVX1ZyZ7gwkewN7MS/iCqxLvvYW0VgTdNklPHg+
 8rNslVEWramQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222178612"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="222178612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:57:45 -0700
IronPort-SDR: 0G/K/u2v0dMCN/gPZZJIP5/8mgL/rqaOsL3Bzol2wuFzT7RSIn9mqNKkCt+Wr/ICX/SHO5QaD5
 Ey/wEMSGrHxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="338271813"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2020 04:57:43 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kKgpB-0015B5-4P; Tue, 22 Sep 2020 14:51:09 +0300
Date:   Tue, 22 Sep 2020 14:51:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v1 3/3] dmaengine: dmatest: Return boolean result
 directly in filter()
Message-ID: <20200922115109.GP3956970@smile.fi.intel.com>
References: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
 <20200916133456.79280-3-andriy.shevchenko@linux.intel.com>
 <5d865914-5481-0fe8-55d1-0c8efb6c481a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d865914-5481-0fe8-55d1-0c8efb6c481a@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 17, 2020 at 12:39:27PM +0300, Peter Ujfalusi wrote:
> On 16/09/2020 16.34, Andy Shevchenko wrote:
> > There is no need to have a conditional for boolean expression when
> > function returns bool. Drop unnecessary code and return boolean
> > result directly.
> > 
> > While at it, drop unneeded casting from void *.
> 
> my test scripts are working fine with the three patch applied.
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Vinod: for all three patches ^^
> 
> Andy, Vladimir: thanks for the fixes!

Thanks for testing! I'll apply your tag to v2 (assuming you are okay with
slight changes Vinod requested).

-- 
With Best Regards,
Andy Shevchenko


