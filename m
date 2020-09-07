Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5774260200
	for <lists+dmaengine@lfdr.de>; Mon,  7 Sep 2020 19:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgIGRQC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Sep 2020 13:16:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:20639 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgIGOFQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Sep 2020 10:05:16 -0400
IronPort-SDR: IgAsIwDA8S7ENlPv2PaAahJcZmchWJR+no1N2jkYQ3Y18wCo1tI7d0YC8LWArBgaJ7JmW4prmZ
 0wp8LKLhTixg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="155502738"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="155502738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 07:05:07 -0700
IronPort-SDR: W5bICGtupvhRG8tLXXl/uMiMMKuzvlrwsEV0RPGVStBNuRX2iI0HB0wmYqcaoAkMEEIYABBAdX
 hmFGDB2GUpWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="333172749"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 07:05:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFHlW-00Ey1l-Qa; Mon, 07 Sep 2020 17:05:02 +0300
Date:   Mon, 7 Sep 2020 17:05:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 6b41030fdc790 broke dmatest badly
Message-ID: <20200907140502.GK1891694@smile.fi.intel.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
 <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
 <20200907120440.GC1891694@smile.fi.intel.com>
 <004640d8-e236-4b75-1bfd-cc386bbf08a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004640d8-e236-4b75-1bfd-cc386bbf08a6@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 07, 2020 at 02:06:23PM +0100, Vladimir Murzin wrote:
> On 9/7/20 1:06 PM, Andy Shevchenko wrote:
> > On Mon, Sep 07, 2020 at 12:03:26PM +0100, Vladimir Murzin wrote:
> >> On 9/4/20 6:34 PM, Andy Shevchenko wrote:
> >>> It becomes a bit annoying to fix dmatest after almost each release.
> >>> The commit 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
> >>> broke my use case when I tried to start busy channel.
> >>>
> >>> So, before this patch
> >>> 	...
> >>> 	echo "busy_chan" > channel
> >>> 	echo 1 > run
> >>> 	sh: write error: Device or resource busy
> >>> 	[ 1013.868313] dmatest: Could not start test, no channels configured
> >>>
> >>> After I have got it run on *ALL* available channels.
> >>
> >> Is not that controlled with max_channels? 
> > 
> > How? I would like to run the test against specific channel. That channel is
> > occupied and thus I should get an error. This is how it suppose to work and
> > actually did before your patch.
> 
> Since you highlighted "ALL" I though that was an issue, yet looks like you
> expect run command would do nothing, correct?

Yes!

> IIUC attempt to add already occupied channel is producing error regardless of
> my patch and I do not see how error could come from run command.

We need to save the status somewhere that the channel setter has been called
unsuccessfully. And propagate an error to the run routine.

> As for my patch it restores behaviour of how it supposed to work prior d53513d5dc28
> where run command would execute with default settings if under-configured.

Yeah, yet another breaking patch series (I have fixed one bug in that) which
has been dumped and someone disappeared...

Yes, and here is a corner case. I have batch script which fills sysfs
parameters with something meaningful. However, when error happens in channel
setter the run kick off, luckily, b/c of regression you have noticed, doesn't
happen.

And this behaviour as far as I remember was previously before the d53513d5dc28.
At least I remember that I wrote my scripts few years ago and they worked.

> >>> dmatest compiled as a module.
> >>>
> >>> Fix this ASAP, otherwise I will send revert of this and followed up patch next
> >>> week.
> >>
> >> I don't quite get it, you are sending revert and then a fix rather then helping
> >> with a fix?
> > 
> > Correct.
> > 
> >> What is reason for such extreme (and non-cooperative) flow?
> > 
> > There are few reasons:
> >  - the patch made a clear regression
> >  - I do not understand what that patch is doing and how
> >  - I do not have time to look at it
> >  - we are now at v5.9-rc4 and it seems like one or two weeks time to get it
> >    into v5.9 release
> >  - and I'm annoyed by breaking this module not the first time for the last
> >    couple of years
> > 
> > And on top of that it's not how OSS community works. Since you replied, I give
> > you time to figure out what's going on and provide necessary testing if needed.
> > 
> >> P.S.
> >> Unfortunately, I do not have access to hardware to run reproducer.
> > 
> > So, please, propose a fix without it. I will test myself.
> > 
> 

-- 
With Best Regards,
Andy Shevchenko


