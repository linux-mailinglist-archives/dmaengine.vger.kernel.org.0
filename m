Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F125FA1E
	for <lists+dmaengine@lfdr.de>; Mon,  7 Sep 2020 14:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgIGMFi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Sep 2020 08:05:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:56261 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgIGMFA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Sep 2020 08:05:00 -0400
IronPort-SDR: AElRPog+9iygThtvvQJWeFnXHbG1+jdav1IEyqluyoVDW7z/WUMcoNcoXKVwYVsX08yQ8ojhIj
 HQjyZGt3yLjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="145720906"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="145720906"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:04:48 -0700
IronPort-SDR: FIufuOdyessBy11mg2+nioCP7rJNjJg6dWhEj59B/8SR9cQR+6cr0iJoCKG/BJOmJjUHqdoNoT
 DhBCF6bziTGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333145464"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 05:04:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFFt2-00EwVi-1p; Mon, 07 Sep 2020 15:04:40 +0300
Date:   Mon, 7 Sep 2020 15:04:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 6b41030fdc790 broke dmatest badly
Message-ID: <20200907120440.GC1891694@smile.fi.intel.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
 <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 07, 2020 at 12:03:26PM +0100, Vladimir Murzin wrote:
> On 9/4/20 6:34 PM, Andy Shevchenko wrote:
> > It becomes a bit annoying to fix dmatest after almost each release.
> > The commit 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
> > broke my use case when I tried to start busy channel.
> > 
> > So, before this patch
> > 	...
> > 	echo "busy_chan" > channel
> > 	echo 1 > run
> > 	sh: write error: Device or resource busy
> > 	[ 1013.868313] dmatest: Could not start test, no channels configured
> > 
> > After I have got it run on *ALL* available channels.
> 
> Is not that controlled with max_channels? 

How? I would like to run the test against specific channel. That channel is
occupied and thus I should get an error. This is how it suppose to work and
actually did before your patch.

> > dmatest compiled as a module.
> > 
> > Fix this ASAP, otherwise I will send revert of this and followed up patch next
> > week.
> 
> I don't quite get it, you are sending revert and then a fix rather then helping
> with a fix?

Correct.

> What is reason for such extreme (and non-cooperative) flow?

There are few reasons:
 - the patch made a clear regression
 - I do not understand what that patch is doing and how
 - I do not have time to look at it
 - we are now at v5.9-rc4 and it seems like one or two weeks time to get it
   into v5.9 release
 - and I'm annoyed by breaking this module not the first time for the last
   couple of years

And on top of that it's not how OSS community works. Since you replied, I give
you time to figure out what's going on and provide necessary testing if needed.

> P.S.
> Unfortunately, I do not have access to hardware to run reproducer.

So, please, propose a fix without it. I will test myself.

-- 
With Best Regards,
Andy Shevchenko


