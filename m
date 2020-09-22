Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9432741A4
	for <lists+dmaengine@lfdr.de>; Tue, 22 Sep 2020 13:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIVL4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 07:56:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:60775 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgIVL4P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Sep 2020 07:56:15 -0400
IronPort-SDR: 5Dj7mAD0N2zH45jpO1kp/ZVnwQaKlu3WtFVeNax/dMYn1FEHzMPho7F/VerTN9mby91vxMwYSv
 g5kPCplM/3Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222178335"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="222178335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:56:11 -0700
IronPort-SDR: 2TO8iPbPnLqtkywBF5N77qlUB6hWiu47NCEGjaLBq/GjlzeR+Ab23IeqlXNN8XBhKzCho+O4HM
 cfcBMwBUwC6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="338271567"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2020 04:56:09 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kKglW-00158p-HK; Tue, 22 Sep 2020 14:47:22 +0300
Date:   Tue, 22 Sep 2020 14:47:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v1 1/3] dmaengine: dmatest: Fix regression when run
 command on misconfigured channel
Message-ID: <20200922114722.GO3956970@smile.fi.intel.com>
References: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
 <20200917103034.GZ2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917103034.GZ2968@vkoul-mobl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 17, 2020 at 04:00:34PM +0530, Vinod Koul wrote:

Thanks for review, my answers below.

> On 16-09-20, 16:34, Andy Shevchenko wrote:
> > From: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> Subject of the patch is not apt. It describes the effect of this patch,
> which is to fix the regression but does not describe the change. Please
> revise it to describe the change done in this patch

OK!

> > Andy reported that commit 6b41030fdc79 ("dmaengine: dmatest:
> > Restore default for channel") broke his scripts for the case
> > where "busy" channel is used for configuration with expectation
> > that run command would do nothing (and return 0). Instead,
> > behavior was (unintentionally) changed to treat such case as
> > under-configuration and progress with defaults, i.e. run command
> > would start a test with default setting for channel (which would
> > use all channels).
> 
> but a mis-configured channel returning success and doing nothing does
> not look as a good behaviour, I agree it broke Andy's script but the
> behaviour was not good to start with ;)

Which used to be a previous behaviour. I don't understand what should I do here
as after this patch (and even after the initial multi-channel support patch)
the behaviour is like you desire.

> > Restore original behavior with tracking status of channel setter
> > so we can distinguish between misconfigured and under-configured
> > cases in run command and act accordingly.
> > 
> > Fixes: 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/dma/dmatest.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> > index b2790641370a..4c9a9d7b48bb 100644
> > --- a/drivers/dma/dmatest.c
> > +++ b/drivers/dma/dmatest.c
> > @@ -129,6 +129,7 @@ struct dmatest_params {
> >   * @nr_channels:	number of channels under test
> >   * @lock:		access protection to the fields of this structure
> >   * @did_init:		module has been initialized completely
> > + * @last_error:		test has faced configuration issues
> >   */
> >  static struct dmatest_info {
> >  	/* Test parameters */
> > @@ -137,6 +138,7 @@ static struct dmatest_info {
> >  	/* Internal state */
> >  	struct list_head	channels;
> >  	unsigned int		nr_channels;
> > +	int			last_error;
> >  	struct mutex		lock;
> >  	bool			did_init;
> >  } test_info = {
> > @@ -1202,10 +1204,22 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
> >  		return ret;
> >  	} else if (dmatest_run) {
> >  		if (!is_threaded_test_pending(info)) {
> > -			pr_info("No channels configured, continue with any\n");
> > -			if (!is_threaded_test_run(info))
> > -				stop_threaded_test(info);
> > -			add_threaded_test(info);
> > +			/*
> > +			 * We have nothing to run. This can be due to:
> > +			 */
> > +			ret = info->last_error;
> > +			if (ret) {
> > +				/* 1) Mis-configuration */
> > +				pr_warn("Channel misconfigured, can't continue\n");
> 
> I would think this should be error

OK!

> > +				mutex_unlock(&info->lock);
> > +				return ret;
> > +			} else {
> > +				/* 2) We rely on defaults */
> > +				pr_info("No channels configured, continue with any\n");
> > +				if (!is_threaded_test_run(info))
> > +					stop_threaded_test(info);
> > +				add_threaded_test(info);
> > +			}
> >  		}
> >  		start_threaded_tests(info);
> >  	} else {
> > @@ -1222,7 +1236,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
> >  	struct dmatest_info *info = &test_info;
> >  	struct dmatest_chan *dtc;
> >  	char chan_reset_val[20];
> > -	int ret = 0;
> > +	int ret;
> 
> Does this belong to this fix?

Relatively. It goes under category that we can clean this up because it has
relation to what we need below. I will leave it in v2 as it is in v1.

> >  	mutex_lock(&info->lock);
> >  	ret = param_set_copystring(val, kp);
> > @@ -1230,7 +1244,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
> >  		mutex_unlock(&info->lock);
> >  		return ret;
> >  	}
> > -	/*Clear any previously run threads */
> > +	/* Clear any previously run threads */
> 
> Lets keep style issues away from fixes please

OK!

> >  	if (!is_threaded_test_run(info) && !is_threaded_test_pending(info))
> >  		stop_threaded_test(info);
> >  	/* Reject channels that are already registered */
> > @@ -1277,12 +1291,14 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
> >  		goto add_chan_err;
> >  	}
> >  
> > +	info->last_error = ret;
> >  	mutex_unlock(&info->lock);
> >  
> >  	return ret;
> >  
> >  add_chan_err:
> >  	param_set_copystring(chan_reset_val, kp);
> > +	info->last_error = ret;
> >  	mutex_unlock(&info->lock);
> >  
> >  	return ret;
> > -- 
> > 2.28.0
> 
> -- 
> ~Vinod

-- 
With Best Regards,
Andy Shevchenko


