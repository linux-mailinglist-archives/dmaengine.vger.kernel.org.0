Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A1A1666
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2019 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfH2Kjq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Aug 2019 06:39:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:23978 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfH2Kjq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Aug 2019 06:39:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="180840772"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2019 03:39:44 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3HqB-0003NX-Kf; Thu, 29 Aug 2019 13:39:43 +0300
Date:   Thu, 29 Aug 2019 13:39:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] dmaengine: dw: Enable for Intel Elkhart Lake
Message-ID: <20190829103943.GT2680@smile.fi.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
 <20190821041144.GG12733@vkoul-mobl.Dlink>
 <20190828115300.GL2680@smile.fi.intel.com>
 <20190829043241.GO2672@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829043241.GO2672@vkoul-mobl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 29, 2019 at 10:02:41AM +0530, Vinod Koul wrote:
> On 28-08-19, 14:53, Andy Shevchenko wrote:
> > On Wed, Aug 21, 2019 at 09:41:44AM +0530, Vinod Koul wrote:

> > Though I haven't seen yet them in Linux next. Can we give at least the rest of
> > the time, till the release, to dangle them in Linux next?
> 
> Heh, looks like my script failed to push and I failed to notice. I have
> pushed last night and it should be in linux-next today.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


