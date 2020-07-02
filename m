Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2475211F09
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGBIl2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 04:41:28 -0400
Received: from foss.arm.com ([217.140.110.172]:54194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgGBIl2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 04:41:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9574131B;
        Thu,  2 Jul 2020 01:41:27 -0700 (PDT)
Received: from [10.57.4.63] (unknown [10.57.4.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 608233F68F;
        Thu,  2 Jul 2020 01:41:26 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: dmatest: stop completed threads when running
 without set channel
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        grygorii.strashko@ti.com
References: <20200701101225.8607-1-peter.ujfalusi@ti.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <7b0a12bc-7c3e-69c1-f589-a8aa16d109c3@arm.com>
Date:   Thu, 2 Jul 2020 09:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200701101225.8607-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/1/20 11:12 AM, Peter Ujfalusi wrote:
> The completed threads were not cleared and consequent run would result
> threads accumulating:
> 
> echo 800000 > /sys/module/dmatest/parameters/test_buf_size
> echo 2000 > /sys/module/dmatest/parameters/timeout
> echo 50 > /sys/module/dmatest/parameters/iterations
> echo 1 > /sys/module/dmatest/parameters/max_channels
> echo "" > /sys/module/dmatest/parameters/channel
> [  237.507265] dmatest: Added 1 threads using dma1chan2
> echo 1 > /sys/module/dmatest/parameters/run
> [  244.713360] dmatest: Started 1 threads using dma1chan2
> [  246.117680] dmatest: dma1chan2-copy0: summary 50 tests, 0 failures 2437.47 iops 977623 KB/s (0)
> 
> echo 1 > /sys/module/dmatest/parameters/run
> [  292.381471] dmatest: No channels configured, continue with any
> [  292.389307] dmatest: Added 1 threads using dma1chan3
> [  292.394302] dmatest: Started 1 threads using dma1chan2
> [  292.399454] dmatest: Started 1 threads using dma1chan3
> [  293.800835] dmatest: dma1chan3-copy0: summary 50 tests, 0 failures 2624.53 iops 975014 KB/s (0)
> 
> echo 1 > /sys/module/dmatest/parameters/run
> [  307.301429] dmatest: No channels configured, continue with any
> [  307.309212] dmatest: Added 1 threads using dma1chan4
> [  307.314197] dmatest: Started 1 threads using dma1chan2
> [  307.319343] dmatest: Started 1 threads using dma1chan3
> [  307.324492] dmatest: Started 1 threads using dma1chan4
> [  308.730773] dmatest: dma1chan4-copy0: summary 50 tests, 0 failures 2390.28 iops 965436 KB/s (0)
> 
> Fixes: 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmatest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 18f10154ba19..45d4d92e91db 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -1185,6 +1185,8 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
>  	} else if (dmatest_run) {
>  		if (!is_threaded_test_pending(info)) {
>  			pr_info("No channels configured, continue with any\n");
> +			if (!is_threaded_test_run(info))
> +				stop_threaded_test(info);
>  			add_threaded_test(info);
>  		}
>  		start_threaded_tests(info);
> 

I should admit I did not run dmatest back to back. Unfortunately, I do not have access to hardware to
give it a try nor I have enough confidence to review the change :( Sorry for the bug!

Cheers
Vladimir
