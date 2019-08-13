Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E308BBD3
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfHMOpE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 10:45:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:38967 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbfHMOpE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Aug 2019 10:45:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 07:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="327699088"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2019 07:45:02 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hxY2m-0007RB-MC; Tue, 13 Aug 2019 17:45:00 +0300
Date:   Tue, 13 Aug 2019 17:45:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: dw: Update Intel Elkhart Lake Service Engine
 acronym
Message-ID: <20190813144500.GI30120@smile.fi.intel.com>
References: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
 <20190813140729.GC30120@smile.fi.intel.com>
 <82882d82-57e7-dabc-93af-6ec52c3fbc89@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82882d82-57e7-dabc-93af-6ec52c3fbc89@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 13, 2019 at 05:17:24PM +0300, Jarkko Nikula wrote:
> On 8/13/19 5:07 PM, Andy Shevchenko wrote:
> > On Tue, Aug 13, 2019 at 11:06:02AM +0300, Jarkko Nikula wrote:
> > > Intel Elkhart Lake Offload Service Engine (OSE) will be called as
> > > Intel(R) Programmable Services Engine (Intel(R) PSE) in documentation.
> > > 
> > > Update the comment here accordingly.
> > 
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Seems similar we need for UART.
> > 
> You mean a0d993e8c143 ("serial: 8250_lpss: Enable HS UART on Elkhart Lake")?
> No Code or comment on that commit mention OSE, only commit log.

Ah, we can't fix commit messages.
Thanks for checking!

-- 
With Best Regards,
Andy Shevchenko


