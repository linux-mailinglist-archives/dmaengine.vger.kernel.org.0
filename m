Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08F626D90F
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIQKaq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 06:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIQKaj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 06:30:39 -0400
Received: from localhost (unknown [136.185.111.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04A2206BE;
        Thu, 17 Sep 2020 10:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600338638;
        bh=CVPE6uPbeMgGxI3WM4Sv3A8VTCGiCs1wfYTFC2PSQTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqKqWFKtLxoDgULNUJPRXF6UXqls1pgCST4wgtV6EF6S/BqgFsksdm37GVgXqmEkD
         D8tttDzLXlD1fbY4GmFtdydvb3jzk4kgj8G3dUCifdsHNh2hgKL8P9qO+K2bKQ2ItG
         sjBJuplu6YRQR8Wj/Vnko7xCHxLdLfcguORfaQu4=
Date:   Thu, 17 Sep 2020 16:00:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v1 1/3] dmaengine: dmatest: Fix regression when run
 command on misconfigured channel
Message-ID: <20200917103034.GZ2968@vkoul-mobl>
References: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

HI Andy/Vladimir
On 16-09-20, 16:34, Andy Shevchenko wrote:
> From: Vladimir Murzin <vladimir.murzin@arm.com>

Subject of the patch is not apt. It describes the effect of this patch,
which is to fix the regression but does not describe the change. Please
revise it to describe the change done in this patch

> Andy reported that commit 6b41030fdc79 ("dmaengine: dmatest:
> Restore default for channel") broke his scripts for the case
> where "busy" channel is used for configuration with expectation
> that run command would do nothing (and return 0). Instead,
> behavior was (unintentionally) changed to treat such case as
> under-configuration and progress with defaults, i.e. run command
> would start a test with default setting for channel (which would
> use all channels).

but a mis-configured channel returning success and doing nothing does
not look as a good behaviour, I agree it broke Andy's script but the
behaviour was not good to start with ;)

> Restore original behavior with tracking status of channel setter
> so we can distinguish between misconfigured and under-configured
> cases in run command and act accordingly.
> 
> Fixes: 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmatest.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index b2790641370a..4c9a9d7b48bb 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -129,6 +129,7 @@ struct dmatest_params {
>   * @nr_channels:	number of channels under test
>   * @lock:		access protection to the fields of this structure
>   * @did_init:		module has been initialized completely
> + * @last_error:		test has faced configuration issues
>   */
>  static struct dmatest_info {
>  	/* Test parameters */
> @@ -137,6 +138,7 @@ static struct dmatest_info {
>  	/* Internal state */
>  	struct list_head	channels;
>  	unsigned int		nr_channels;
> +	int			last_error;
>  	struct mutex		lock;
>  	bool			did_init;
>  } test_info = {
> @@ -1202,10 +1204,22 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
>  		return ret;
>  	} else if (dmatest_run) {
>  		if (!is_threaded_test_pending(info)) {
> -			pr_info("No channels configured, continue with any\n");
> -			if (!is_threaded_test_run(info))
> -				stop_threaded_test(info);
> -			add_threaded_test(info);
> +			/*
> +			 * We have nothing to run. This can be due to:
> +			 */
> +			ret = info->last_error;
> +			if (ret) {
> +				/* 1) Mis-configuration */
> +				pr_warn("Channel misconfigured, can't continue\n");

I would think this should be error

> +				mutex_unlock(&info->lock);
> +				return ret;
> +			} else {
> +				/* 2) We rely on defaults */
> +				pr_info("No channels configured, continue with any\n");
> +				if (!is_threaded_test_run(info))
> +					stop_threaded_test(info);
> +				add_threaded_test(info);
> +			}
>  		}
>  		start_threaded_tests(info);
>  	} else {
> @@ -1222,7 +1236,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  	struct dmatest_info *info = &test_info;
>  	struct dmatest_chan *dtc;
>  	char chan_reset_val[20];
> -	int ret = 0;
> +	int ret;

Does this belong to this fix?

>  
>  	mutex_lock(&info->lock);
>  	ret = param_set_copystring(val, kp);
> @@ -1230,7 +1244,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  		mutex_unlock(&info->lock);
>  		return ret;
>  	}
> -	/*Clear any previously run threads */
> +	/* Clear any previously run threads */

Lets keep style issues away from fixes please

>  	if (!is_threaded_test_run(info) && !is_threaded_test_pending(info))
>  		stop_threaded_test(info);
>  	/* Reject channels that are already registered */
> @@ -1277,12 +1291,14 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  		goto add_chan_err;
>  	}
>  
> +	info->last_error = ret;
>  	mutex_unlock(&info->lock);
>  
>  	return ret;
>  
>  add_chan_err:
>  	param_set_copystring(chan_reset_val, kp);
> +	info->last_error = ret;
>  	mutex_unlock(&info->lock);
>  
>  	return ret;
> -- 
> 2.28.0

-- 
~Vinod
