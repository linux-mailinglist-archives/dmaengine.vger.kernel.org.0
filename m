Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14E6C38AB
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCURxr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 13:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCURxr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 13:53:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0AD44A3;
        Tue, 21 Mar 2023 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679421226; x=1710957226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3WVZy+X1m9RUq5HX/lmquCwfQA/+BsTXRv/yIT64h5g=;
  b=l6ErauN++OR3RkK0WMS0au4BADNeMMMEM9VfXX61Kc5/ZQakWEFw2mop
   BLGUz+OMN1vKGBN0qJPXmF4A7RVADXPsUGmbg7A6CriigdIRktuT3azBs
   7CupC8Mp/npi8WYrhA2qwpbsxEXEoCuxSZmP/buRc1yPLCYVPpGwQlM48
   EuojXxtzhyk1SBjFdKWy0c4jIK5xIfWrPryDBFhc3yV0u5nP0RTZlRRFa
   JUGk+P6Ipke32Qyh4xDzhmKWgc7nA5OeRRfKL4tjld/y8GY3JvSb6RRJy
   2yMmndeJv4T/KhMPCgVvotnXXS4jGLLYkVkVglNc2AlbhJ207zsp4N5tr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401587160"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="401587160"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 10:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="792195640"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="792195640"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2023 10:53:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pegAv-006pzw-1q;
        Tue, 21 Mar 2023 19:53:33 +0200
Date:   Tue, 21 Mar 2023 19:53:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Niyas Sait <niyas.sait@linaro.org>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Message-ID: <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321160241.1339538-1-niyas.sait@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 21, 2023 at 04:02:41PM +0000, Niyas Sait wrote:
> This patch refactors the ACPI DMA layer to support platforms without
> shared info descriptor in CSRT.
> 
> Shared info descriptor is optional and vendor specific (not
> standardized) and not used by Arm platforms.
> ---
> 
> The main changes in this patch are as follows:
> 
> - Renamed acpi_dma_controller_register to acpi_dma_controller_register_with_csrt_shared_desc to reflect its new functionality. 

can_we_avoid_long_name_of_the_functions_please() ?

Also is this renaming is a must?

-- 
With Best Regards,
Andy Shevchenko


