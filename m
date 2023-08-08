Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8707744E6
	for <lists+dmaengine@lfdr.de>; Tue,  8 Aug 2023 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjHHSb0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Aug 2023 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjHHSbJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Aug 2023 14:31:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82EB4F08;
        Tue,  8 Aug 2023 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691517067; x=1723053067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfHZb7jTrJDIeX504oyNI889yH88C3wdHdQ0aKD/m78=;
  b=gLtN2lAYEQCNudXJ2Ft6SMF9yHjqINl483wXAmoDta8VC+hcuXw9QR9l
   AyoANWmgAGduCKF7IvSLpQu5sWxIGApjiTZEVkGxwecpNszkWcJfatuwS
   unRgQVMvRm1r8DfsSErCzj1ML7Ap/UPOChzgfA/BA4M7Wmjuh/LOo5cn+
   PeuWjlIkcrg0Y7009H5xQCTif3T9hdoVkYY2FgD4k0Q8uJDOCYykVbOwU
   NiLkzZpNoQ24Dh26crNowMbpFQjDqqaKtTerTn8xp3jpdMwWr5k3ImK13
   g3tZIJST3WzQ1tlZl/crgj+4t/4WsNYUmCfJrpzJxIPVYnHtxAHjOHAIK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="355856823"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="355856823"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731501652"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="731501652"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2023 10:25:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTQSN-000FEM-2I;
        Tue, 08 Aug 2023 20:25:19 +0300
Date:   Tue, 8 Aug 2023 20:25:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: Remove unused declaration
 dma_chan_cleanup()
Message-ID: <ZNJ6f2ifosu8obFl@smile.fi.intel.com>
References: <20230808150517.36632-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808150517.36632-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 08, 2023 at 11:05:17PM +0800, Yue Haibing wrote:
> Commit f27c580c3628 ("dmaengine: remove 'bigref' infrastructure")
> removed the implementation but leave declaration.

"...left declaration in place. Remove it."

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


