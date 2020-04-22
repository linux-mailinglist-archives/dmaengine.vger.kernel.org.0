Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558431B4DCB
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 21:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDVT6X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 15:58:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:20218 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVT6X (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Apr 2020 15:58:23 -0400
IronPort-SDR: EEwRg7byctDghsc1FPRi5gMLXTE8C4ANQqQeAhSY7L2Sz/u7s6+7dhDwUAADIvaKx/g+ILuVPA
 lD5zRTDhWNew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 12:58:22 -0700
IronPort-SDR: aT2RPqHwr8m51PNAPbDq64LJkS+4JGwNNFc6WOCEF96cg94eEf4Hxm2hVi63X98J66ziHAv+vR
 NorCx654IAEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="457263281"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.134.45.139]) ([10.134.45.139])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2020 12:58:21 -0700
Subject: Re: [PATCH v2 3/3] dmaengine: ioat: adding missed issue_pending to
 timeout handler
To:     leonid.ravich@dell.com, dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
References: <20200416170628.16196-2-leonid.ravich@dell.com>
 <1587583557-4113-1-git-send-email-leonid.ravich@dell.com>
 <1587583557-4113-3-git-send-email-leonid.ravich@dell.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <f84bff8c-7cab-7c29-1a9a-6713a9a9cbf7@intel.com>
Date:   Wed, 22 Apr 2020 12:58:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587583557-4113-3-git-send-email-leonid.ravich@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/22/2020 12:25 PM, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> completion timeout might trigger unnesesery DMA engine hw reboot
> in case of missed issue_pending() .
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> ---
> Changing in v2
>    - add log in case of such scenario
>   drivers/dma/ioat/dma.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index 55a8cf1..a958aaf 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -955,6 +955,14 @@ void ioat_timer_event(struct timer_list *t)
>   		goto unlock_out;
>   	}
>   
> +	/* handle missed issue pending case */
> +	if (ioat_ring_pending(ioat_chan)) {
> +		dev_dbg(to_dev(ioat_chan), "Complition timeout while pending\n")
Completion timeout with pending descriptors.

Also, maybe dev_warn() you think?

> +		spin_lock_bh(&ioat_chan->prep_lock);
> +		__ioat_issue_pending(ioat_chan);
> +		spin_unlock_bh(&ioat_chan->prep_lock);
> +	}
> +
>   	set_bit(IOAT_COMPLETION_ACK, &ioat_chan->state);
>   	mod_timer(&ioat_chan->timer, jiffies + COMPLETION_TIMEOUT);
>   unlock_out:
> 
