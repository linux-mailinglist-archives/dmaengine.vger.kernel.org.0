Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6959EAFC
	for <lists+dmaengine@lfdr.de>; Tue, 23 Aug 2022 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiHWS1X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Aug 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiHWS1E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Aug 2022 14:27:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018D3C8D5;
        Tue, 23 Aug 2022 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661273180; x=1692809180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dUi+7JqD+p5hV/9OPEqX43GBsNQ+YwFNKuWsnUPogWE=;
  b=Cr8FcDMNZf0ZTbPp8fkFZC3IGufFEvOPJ5mU9by7AZzuRGZzZ27cL3O+
   6HOIXGCelNZyG12bwIBOMW7ooezynAFZVRJ1spOGXk7WCnvFe4XjIakyu
   e39LVu2CvfwDZoimrZjCy1FfvHxuCERTUeRvKzcO0+QAsb3V+ZtN5nYq3
   xbXiVnDN1tg9UK8wPm1CPUI6PeBR4sj5Vq6L44S4pUhjmlY/8E4nGdDOh
   Ln9kEGtle3Eve/ZbAEWWZZJI7+/gr+qskmNZotEzYbo4nEiSkRrP/29HV
   u9ym5wZS1aIgahbrO+yD8RhwFhAMq1V9Q8UdSkTVTGudjZO7AoWk2KLY8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="280712546"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="280712546"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:46:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="612470634"
Received: from tdrohan-mobl1.amr.corp.intel.com (HELO [10.212.86.80]) ([10.212.86.80])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:46:19 -0700
Message-ID: <905d3feb-f75b-e91c-f3de-b69718aa5c69@intel.com>
Date:   Tue, 23 Aug 2022 09:46:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
 <20220823163709.2102468-1-jsnitsel@redhat.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220823163709.2102468-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/23/2022 9:37 AM, Jerry Snitselaar wrote:
> idxd_device_clear_state() now grabs the idxd->dev_lock
> itself, so don't grab the lock prior to calling it.
>
> This was seen in testing after dmar fault occurred on system,
> resulting in lockup stack traces.
>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Fixes: cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on device driver removal")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks Jerry!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2: add Fixes tag, and add subsystem to summary
>
>   drivers/dma/idxd/irq.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 743ead5ebc57..5b9921475be6 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -324,13 +324,11 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
>   			idxd->state = IDXD_DEV_HALTED;
>   			idxd_wqs_quiesce(idxd);
>   			idxd_wqs_unmap_portal(idxd);
> -			spin_lock(&idxd->dev_lock);
>   			idxd_device_clear_state(idxd);
>   			dev_err(&idxd->pdev->dev,
>   				"idxd halted, need %s.\n",
>   				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
>   				"FLR" : "system reset");
> -			spin_unlock(&idxd->dev_lock);
>   			return -ENXIO;
>   		}
>   	}
