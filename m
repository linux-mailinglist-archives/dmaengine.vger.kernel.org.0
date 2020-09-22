Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657412741AA
	for <lists+dmaengine@lfdr.de>; Tue, 22 Sep 2020 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIVL6E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 07:58:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:10008 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgIVL6D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Sep 2020 07:58:03 -0400
IronPort-SDR: F4LNkLofkUxzh6ObvKq4MJV4bEKEsArDfM+8CnJDaTvhlVPpXHd09sSOL7KlqC31p2MAUVR2No
 7fHz54mTBJ0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="140065266"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="140065266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:58:03 -0700
IronPort-SDR: gtIw4TkoGmsPaxjaEx3JK2CLJquLAVlTDOEJ0iz108AtW8SwHgBYOuvQji+Fr9Amp8pazPcqcV
 09Ta7yRtdlXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="338271893"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2020 04:58:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kKgth-0015E7-9Z; Tue, 22 Sep 2020 14:55:49 +0300
Date:   Tue, 22 Sep 2020 14:55:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v1 1/3] dmaengine: dmatest: Fix regression when run
 command on misconfigured channel
Message-ID: <20200922115549.GQ3956970@smile.fi.intel.com>
References: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
 <20200917103034.GZ2968@vkoul-mobl>
 <20200922114722.GO3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922114722.GO3956970@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 22, 2020 at 02:47:22PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 17, 2020 at 04:00:34PM +0530, Vinod Koul wrote:
> > On 16-09-20, 16:34, Andy Shevchenko wrote:
> > > From: Vladimir Murzin <vladimir.murzin@arm.com>

> > > Andy reported that commit 6b41030fdc79 ("dmaengine: dmatest:
> > > Restore default for channel") broke his scripts for the case
> > > where "busy" channel is used for configuration with expectation
> > > that run command would do nothing (and return 0). Instead,
> > > behavior was (unintentionally) changed to treat such case as
> > > under-configuration and progress with defaults, i.e. run command
> > > would start a test with default setting for channel (which would
> > > use all channels).
> > 
> > but a mis-configured channel returning success and doing nothing does
> > not look as a good behaviour, I agree it broke Andy's script but the
> > behaviour was not good to start with ;)
> 
> Which used to be a previous behaviour. I don't understand what should I do here
> as after this patch (and even after the initial multi-channel support patch)
> the behaviour is like you desire.

Okay, I have dropped the part '(and return 0)' to avoid ambiguity.

> > > Restore original behavior with tracking status of channel setter
> > > so we can distinguish between misconfigured and under-configured
> > > cases in run command and act accordingly.

-- 
With Best Regards,
Andy Shevchenko


