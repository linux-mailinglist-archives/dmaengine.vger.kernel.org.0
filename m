Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A542E3B3070
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFXNvD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 09:51:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:10479 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXNvC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 09:51:02 -0400
IronPort-SDR: xzLlZI5+kEBqArLOYeRMZftr+x53l8+aDKmt/ne4//faJpN15hn5kUNYiiOeAsDr/BMUZxtNKw
 +vpi5CjrWf5w==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="229055471"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="229055471"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 06:48:43 -0700
IronPort-SDR: l/LDOrqJ72DELXn8h3blCTXre0OjHXcLW7jOXTExR2GpjargMW6Z0fIDG0uAgNnLcrop+9H+5b
 FntMzwRXa6eg==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="445310086"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 06:48:42 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lwPig-0050va-Ba; Thu, 24 Jun 2021 16:48:38 +0300
Date:   Thu, 24 Jun 2021 16:48:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v2 1/1] dmaengine: dw: Program xBAR hardware for Elkhart
 Lake
Message-ID: <YNSNNmd/OYxUDGhW@smile.fi.intel.com>
References: <20210614133018.66931-1-andriy.shevchenko@linux.intel.com>
 <YNRpkMMDE5B9NY9J@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNRpkMMDE5B9NY9J@matsya>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 24, 2021 at 04:46:32PM +0530, Vinod Koul wrote:
> On 14-06-21, 16:30, Andy Shevchenko wrote:
> > Intel Elkhart Lake PSE DMA implementation is integrated with crossbar IP
> > in order to serve more hardware than there are DMA request lines available.
> > 
> > Due to this, program xBAR hardware to make flexible support of PSE peripheral.
> > 
> > The Device-to-Device has not been tested and it's not supported by DMA Engine,
> > but it's left in the code for the sake of documenting hardware features.
> 
> Kernel does not like to keep dead code, please remove this. It can be
> added back when we have users

I would rather keep it as documentation (converted to comment perhaps).
In any case, it seems the suitable point of time to contribute will be
already after v5.14-rc1.

-- 
With Best Regards,
Andy Shevchenko


