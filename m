Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD205F4746
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJDQPI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJDQPH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 12:15:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8ADDB;
        Tue,  4 Oct 2022 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664900105; x=1696436105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4PqAkzVq1o2WfBKu7Js2HTHmGzzYQDqt7v8Of/Mnc/4=;
  b=bSnIjH0OvBcXQIkMdcHejrMNTicQu4ZcSmlqozwivaU8Gamq1zt2vyEa
   vG03xjG3iVnT9saF0L+7iOdwkV0ojP6WpfoeffhX4gBIgkrPHLBzDXMRG
   qdQx4JCcIKlwWpgvtJMbeQ2eGya6FGQXudj4BUA4UUByWM5B++7Nch1vk
   bkmtJwsJbTK4c1rje0FhK1h2EhEbZ16+6WmSuwPi/M850jwtSggPt18Iq
   83eEIBdv1ghurQM0FbYCvd60omhyQrivFZGedrxFR3FDcFennDJYNt8mu
   tmRn++dpGYKiISGPjTQYg4w23XbzZ5hDwca2mAz6rW2sT6pmRIPcZJ+V6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="302930163"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="302930163"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:15:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="626235135"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="626235135"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.127.31]) ([10.212.127.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:15:03 -0700
Message-ID: <737bb9da-4979-f0bf-1627-c662f57e5d74@intel.com>
Date:   Tue, 4 Oct 2022 09:15:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH] dmaengine: ioat: Fix spelling mistake "idel" -> "idle"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004160913.154739-1-colin.i.king@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221004160913.154739-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/4/2022 9:09 AM, Colin Ian King wrote:
> There is a spelling mistake in the module description. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks Colin. Guess no one noticed for almost 2 decades. :)

> ---
>   drivers/dma/ioat/dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index e2070df6cad2..79d244011093 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -33,7 +33,7 @@ MODULE_PARM_DESC(completion_timeout,
>   static int idle_timeout = 2000;
>   module_param(idle_timeout, int, 0644);
>   MODULE_PARM_DESC(idle_timeout,
> -		"set ioat idel timeout [msec] (default 2000 [msec])");
> +		"set ioat idle timeout [msec] (default 2000 [msec])");
>   
>   #define IDLE_TIMEOUT msecs_to_jiffies(idle_timeout)
>   #define COMPLETION_TIMEOUT msecs_to_jiffies(completion_timeout)
