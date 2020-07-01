Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67796210DA8
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbgGAOZf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 10:25:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:10914 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbgGAOZf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 1 Jul 2020 10:25:35 -0400
IronPort-SDR: cIfm1iJQWaOjiTyXPVX7q72ahYaE7P/eYz8R8PxN/9eiuezBkMh0mrDkO4zfAnXYHb8s3BQJjT
 V7vnsGVYsZCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146581188"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="146581188"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 07:25:34 -0700
IronPort-SDR: 6ssmgI/esNp3HbvA3PtblEWxGxOz0l2PkPPh4wl6eA1cbNIhhCbj8XQEYjIKCznfFf30aDhBUT
 en21uh/0B5tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="481318605"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.136.35]) ([10.209.136.35])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2020 07:25:34 -0700
Subject: Re: [PATCH] dmaengine: ioat setting ioat timeout as module parameter
To:     leonid.ravich@dell.com, dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
References: <20200701140849.8828-1-leonid.ravich@dell.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <51ae5d6b-a512-6bdd-6816-f73e60c7d49b@intel.com>
Date:   Wed, 1 Jul 2020 07:25:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701140849.8828-1-leonid.ravich@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/1/2020 7:08 AM, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> DMA transaction time to complition  is a function of
completion

> PCI bandwidth,transaction size and a queue depth.
                 ^ space                channel depth. ioat doesn't have queues.
> So hard coded value for timeouts might be wrong
> for some scenarios.
> 
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> ---
>   drivers/dma/ioat/dma.c | 12 ++++++++++++
>   drivers/dma/ioat/dma.h |  2 --
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index 8ad0ad861c86..7621b5be5cf4 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -26,6 +26,18 @@
>   
>   #include "../dmaengine.h"
>   
> +int complition_timeout = 200;
> +module_param(complition_timeout, int, 0644);
> +MODULE_PARM_DESC(complition_timeout,
> +		"set ioat complition timeout [msec] (default 200 [msec])");

completion_timeout


> +int idle_timeout = 2000;
> +module_param(idle_timeout, int, 0644);
> +MODULE_PARM_DESC(idle_timeout,
> +		"set ioat idel timeout [msec] (default 2000 [msec])");
> +
> +#define IDLE_TIMEOUT msecs_to_jiffies(idle_timeout)
> +#define COMPLETION_TIMEOUT msecs_to_jiffies(complition_timeout)
> +
>   static char *chanerr_str[] = {
>   	"DMA Transfer Source Address Error",
>   	"DMA Transfer Destination Address Error",
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index e6b622e1ba92..f7f31fdf14cf 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -104,8 +104,6 @@ struct ioatdma_chan {
>   	#define IOAT_RUN 5
>   	#define IOAT_CHAN_ACTIVE 6
>   	struct timer_list timer;
> -	#define COMPLETION_TIMEOUT msecs_to_jiffies(100)
> -	#define IDLE_TIMEOUT msecs_to_jiffies(2000)
>   	#define RESET_DELAY msecs_to_jiffies(100)
>   	struct ioatdma_device *ioat_dma;
>   	dma_addr_t completion_dma;
> 
