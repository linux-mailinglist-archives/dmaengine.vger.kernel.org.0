Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28676160CD
	for <lists+dmaengine@lfdr.de>; Wed,  2 Nov 2022 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKBK37 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Nov 2022 06:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKBK36 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Nov 2022 06:29:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C4638C;
        Wed,  2 Nov 2022 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667384998; x=1698920998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lhbEfJ05wgHz8sN63U6Q3zvR5dLafMlrMr3x4O4sHTA=;
  b=KBfc3O+7KyZyyQv8rg4cko4kQs8rr8v7PsxhAg5UxvBaSEhwm8ZK7zgj
   xhx4ZRgxP/3Cp8uLCoo6fiUwKgmEs4WmgLyNkYfpVgLeU+wVHoveDrnXQ
   1n4JXUXb4l2CxVLAS6cUe/vdG7rIt50rkPOqVVZvUTTJ7IPQ917Bv44A7
   EXsEdUFMlj6J4wNJF24Fd2efIDpl2P2TSeu/jiqwjq0Ddr/+1fsIKK51f
   tmQGJJUWrv84fsXR3GIY78oYpfL+w2mrFLYsI/ZzpDY14lovJmC7QcbUY
   UCme2ptF5lFIMjBR5JiJThg+1kuSvQlveTkiUpKXCWoDTReZPZiRKg+G9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289083009"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="289083009"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="612190193"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="612190193"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2022 03:29:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqB0L-006813-1u;
        Wed, 02 Nov 2022 12:29:53 +0200
Date:   Wed, 2 Nov 2022 12:29:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: devres: add missing
 devm_acpi_dma_controller_free() helper
Message-ID: <Y2JGoTBMkrzKctsC@smile.fi.intel.com>
References: <20221102022701.1407289-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102022701.1407289-1-yangyingliang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 02, 2022 at 10:27:01AM +0800, Yang Yingliang wrote:
> Add missing devm_acpi_dma_controller_free() to devres.rst, it's introduced
> by commit 1b2e98bc1e35 ("dma: acpi-dma: introduce ACPI DMA helpers").

OK

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 1b2e98bc1e35 ("dma: acpi-dma: introduce ACPI DMA helpers")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index ff8158274fb3..aac9c1e39ebc 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -438,6 +438,7 @@ SERDEV
>  
>  SLAVE DMA ENGINE
>    devm_acpi_dma_controller_register()
> +  devm_acpi_dma_controller_free()
>  
>  SPI
>    devm_spi_alloc_master()
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


