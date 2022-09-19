Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078C5BD6D1
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 00:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiISWHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISWHQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 18:07:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1DBA185;
        Mon, 19 Sep 2022 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663625235; x=1695161235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rS1slsHy+dU726B1W3R32Wrj7qAosqj4bBu6SUkKBjI=;
  b=SxPLmF3Q6d4YNxw8ORK2bSAw7xk5C/6tnaIaHPRgEBgfCISLtBBpvKpP
   FVdn0aaSwu5V5NlMpsJDD9p/lEibyhjk2W8soZ49C3QqGph3FETb6aMM9
   NXqLpxmGfabtIR7ATGkN/WLI2fwlsHDo/tuLgn3gBM7jTpaegZVDUlHxp
   viqY2BFR7Nx3fNekVRgSPS7MmB2cFCKPNfq6uPfG7zb0FshiNampWvfy7
   yfXh59wLtX5YcreRS7X3hO14PDfOFbaHlK7K5JxzRbETwPtGTZbr3PifA
   Pfv6BDYZeiCq6vY8O2r+3RpjAomwJd2LCSHhjYsbVbMOoGR+LajbXrgSF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385822666"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="385822666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 15:07:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="687154127"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.95.27]) ([10.212.95.27])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 15:07:10 -0700
Message-ID: <f43b7882-0d78-3977-9c42-665b21c1d03f@intel.com>
Date:   Mon, 19 Sep 2022 15:07:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 0/2] dmaengine: idxd: Fix up re-enabling device workqueues
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Fengqian Gao <fengqian.gao@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>
References: <20220919215553.600246-1-jsnitsel@redhat.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220919215553.600246-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/19/2022 2:55 PM, Jerry Snitselaar wrote:
> Currently if a software reset is attempted on an idxd device
> the workqueues will not be re-enabled, because it will see
> incorrectly see that wq->state is already set to IDXD_WQ_ENABLED.
> So set the workqueue state to disabled in idxd_wq_disable_cleanup(),
> and use a bitmap to track which workqueues have been enabled so they
> can be re-enabled during device re-initialization.
>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>

For the series,

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thank you Jerry!

> Jerry Snitselaar (2):
>    dmaengine: idxd: Set wq state to disabled in idxd_wq_disable_cleanup()
>    dmaengine: idxd: track enabled workqueues in bitmap
>
>   drivers/dma/idxd/device.c | 4 +++-
>   drivers/dma/idxd/idxd.h   | 2 ++
>   drivers/dma/idxd/init.c   | 6 ++++++
>   drivers/dma/idxd/irq.c    | 4 ++--
>   drivers/dma/idxd/sysfs.c  | 1 +
>   5 files changed, 14 insertions(+), 3 deletions(-)
>
