Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1DC1BA9EA
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgD0QQ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgD0QQ7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:16:59 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055E0206BF;
        Mon, 27 Apr 2020 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588004218;
        bh=L7kBpyy244k+lGgSRicOkFwawYQe+J2Ovs32uQpF/hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFh9/uxll8rsXIWK7SaPOBL5ZgTWf0y50cSGN4Ng6lgyMI1ftVQAgSqleKGUKG+vm
         m3xmz0zhiuhs4Yj/4iOyy00ZFN5HP/KnawWp6rhDlASTy/dNM3w3MbASEgcocDG5Qe
         K+x1lt/Fk2SQi6OFcjghNho2UtlLDMTunZbiLO4c=
Date:   Mon, 27 Apr 2020 21:46:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Seraj Alijan <seraj.alijan@sondrel.com>
Subject: Re: [PATCH v1 2/6] dmaengine: dmatest: Fix process hang when reading
 'wait' parameter
Message-ID: <20200427161654.GL56386@vkoul-mobl.Dlink>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
 <20200424161147.16895-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424161147.16895-2-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-04-20, 19:11, Andy Shevchenko wrote:
> If we do
> 
>   % echo 1 > /sys/module/dmatest/parameters/run
>   [  115.851124] dmatest: Could not start test, no channels configured
> 
>   % echo dma8chan7 > /sys/module/dmatest/parameters/channel
>   [  127.563872] dmatest: Added 1 threads using dma8chan7
> 
>   % cat /sys/module/dmatest/parameters/wait
>   ... !!! HANG !!! ...
> 
> The culprit is the commit 6138f967bccc
> 
>   ("dmaengine: dmatest: Use fixed point div to calculate iops")
> 
> which makes threads not to run, but pending and being kicked off by writing
> to the 'run' node. However, it forgot to consider 'wait' routine to avoid
> above mentioned case.
> 
> In order to fix this, check for really running threads, i.e. with pending
> and done flags unset.
> 
> It's pity the culprit commit hadn't updated documentation and tested all
> possible scenarios.
> 
> Fixes: 6138f967bccc ("dmaengine: dmatest: Use fixed point div to calculate iops")
> Cc: Seraj Alijan <seraj.alijan@sondrel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmatest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 4993e3e5c5b01..307622e765996 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -240,7 +240,7 @@ static bool is_threaded_test_run(struct dmatest_info *info)
>  		struct dmatest_thread *thread;
>  
>  		list_for_each_entry(thread, &dtc->threads, node) {
> -			if (!thread->done)
> +			if (!thread->done && !thread->pending)
>  				return true;
>  		}
>  	}
> @@ -1192,7 +1192,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  		mutex_unlock(&info->lock);
>  		return ret;
>  	}
> -	/*Clear any previously run threads */
> +	/* Clear any previously run threads */

This does not belong to this patch, can you please split it out...

-- 
~Vinod
