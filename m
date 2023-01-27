Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39A567EEAB
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jan 2023 20:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjA0TpX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Jan 2023 14:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjA0Toh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Jan 2023 14:44:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B323DA3;
        Fri, 27 Jan 2023 11:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674848600; x=1706384600;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gNaKQGnzHPYbcAgS3cjTiHH8Z+jL4wUPLd6PA7b6yKM=;
  b=NpwRzvv2hQrKkdSPmJH3Sy1Za5MabqBX53pHUuJJgkA1BNQjm/Xdm0XR
   oylzb4RHE7j3iEu/D6yT5jOfh5+EGiUuKcVL0LfQU201TiE93t2dEPQ0x
   nqf8JzKkCh7AZ4RvAxFpueIJnjc96t02BpZSWidtLq2rNhYlPcro+X03a
   EXVklMNYgO4zuNWgj0GHwqTSPCJsVAtEhu6GhmxPYcJ6srFm+mhNltvDF
   +usAUCqVvhaW5K0oDapgnKk9oAAs/zhbfilmUFUKmlJYtQYsQ8QCe5l/h
   6Y0PM3OZralv3XKdWROZ7HRuj0uyj7yg64+rPAmHKY+VE4e4U8QF7w58t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="328461828"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="328461828"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:40:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="613295634"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="613295634"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.66.36]) ([10.212.66.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:40:24 -0800
Message-ID: <a3f1229c-9c1e-03a8-4000-13af0970b0de@intel.com>
Date:   Fri, 27 Jan 2023 12:40:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] dmaengine: idxd: Fix default allowed read buffers value
 in group
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Ramesh Thomas <ramesh.thomas@intel.com>,
        Nikhil Rao <nikhil.rao@intel.com>
References: <20230127192855.966929-1-fenghua.yu@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230127192855.966929-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/27/23 12:28 PM, Fenghua Yu wrote:
> Currently default read buffers that is allowed in a group is 0.
> grpcfg will be configured to max read buffers that IDXD can support if
> the group's allowed read buffers value is 0. But 0 is an invalid
> read buffers value and user may get confused when seeing the invalid
> initial value 0 through sysfs interface.
> 
> To show only valid allowed read buffers value and eliminate confusion,
> directly initialize the allowed read buffers to IDXD's max read buffers.
> User still can change the value through sysfs interface.
> 
> Suggested-by: Ramesh Thomas <ramesh.thomas@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Nikhil Rao <nikhil.rao@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/device.c | 12 ++++++------
>   drivers/dma/idxd/init.c   |  5 +++++
>   2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 29dbb0f52e18..8d0e3aab2ad2 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -699,7 +699,11 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
>   		group->num_engines = 0;
>   		group->num_wqs = 0;
>   		group->use_rdbuf_limit = false;
> -		group->rdbufs_allowed = 0;
> +		/*
> +		 * The default value is the same as the value of
> +		 * total read buffers in GRPCAP.
> +		 */
> +		group->rdbufs_allowed = idxd->max_rdbufs;
>   		group->rdbufs_reserved = 0;
>   		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
>   			group->tc_a = 1;
> @@ -934,11 +938,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
>   			group->grpcfg.flags.tc_b = group->tc_b;
>   		group->grpcfg.flags.use_rdbuf_limit = group->use_rdbuf_limit;
>   		group->grpcfg.flags.rdbufs_reserved = group->rdbufs_reserved;
> -		if (group->rdbufs_allowed)
> -			group->grpcfg.flags.rdbufs_allowed = group->rdbufs_allowed;
> -		else
> -			group->grpcfg.flags.rdbufs_allowed = idxd->max_rdbufs;
> -
> +		group->grpcfg.flags.rdbufs_allowed = group->rdbufs_allowed;
>   		group->grpcfg.flags.desc_progress_limit = group->desc_progress_limit;
>   		group->grpcfg.flags.batch_progress_limit = group->batch_progress_limit;
>   	}
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 529ea09c9094..b2df604e8a5f 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -302,6 +302,11 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   			group->tc_a = -1;
>   			group->tc_b = -1;
>   		}
> +		/*
> +		 * The default value is the same as the value of
> +		 * total read buffers in GRPCAP.
> +		 */
> +		group->rdbufs_allowed = idxd->max_rdbufs;
>   	}
>   
>   	return 0;
