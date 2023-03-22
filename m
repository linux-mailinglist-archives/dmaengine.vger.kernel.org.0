Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EB6C4685
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCVJeu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCVJeq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 05:34:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED55B5EB;
        Wed, 22 Mar 2023 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679477685; x=1711013685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fK4x/+YRfUIRtZ+pvcmEGyczE+hU9nK++OpjJJk8DUk=;
  b=IfMrtFNdLu6GGHMWXh0tioOFSdmyeJ8BIHRbvBPEPUXRo/4GuvDNFxwm
   Covi3dbABIAiSM/VS9//UnjbizYQHEMBlVRiCmcn2bxlMhSMGe7SFYHtH
   CPKRfEVQGNAI93AfUalsyLmfoUuh8Z4AwITdiikOQ1ZKrjc3MXNVP7rjs
   D+ER90a8i05YHRDDa69cft6dxor/z7jFkY0bj7myHgwvwAa17FonbZXf6
   qhyyw8Jk5x6f/1Oea7ErCxfXZj2sA2WYjXFLRNhLK95mInVe8aG8i9Ill
   YnZzHvH0vZ988+vKPebhS3ZwHeb3VbTjkjSz7ijhTaSDJIaqtq4KzymOn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="323011291"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="323011291"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 02:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="770982993"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="770982993"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Mar 2023 02:34:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peurg-00757N-0c;
        Wed, 22 Mar 2023 11:34:40 +0200
Date:   Wed, 22 Mar 2023 11:34:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Niyas Sait <niyas.sait@linaro.org>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Message-ID: <ZBrLr4QDdZpgs3RV@smile.fi.intel.com>
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
 <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
 <6e90881b-ba24-7f5a-e80d-1ae7fc9d9382@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e90881b-ba24-7f5a-e80d-1ae7fc9d9382@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 22, 2023 at 07:56:11AM +0000, Niyas Sait wrote:
> On 21/03/2023 17:53, Andy Shevchenko wrote:
> 
> > can_we_avoid_long_name_of_the_functions_please() ?
> 
> Sure, will do that.
> 
> > Also is this renaming is a must?
> 
> It is not a must. I considered the existing method with shared info
> as a special case as it uses non standard descriptors from CSRT table
> and introduced the new function to handle it.
> 
> > Btw, what is the real argument of not using this table?
> > 
> > Yes, I know that this is an MS extension, but why ARM needs something else and
> > why even that is needed at all? CSRT is only for the _shared_ DMA resources
> > and I think most of the IPs nowadays are using private DMA engines (or
> > semi-private when driver based on ID can know which channel services which
> > device).
> 
> The issue is that shared info descriptor is not part of CSRT definition [1]
> and I think it is not standardized or documented anywhere.
> 
> I was specifically looking at NXP I.MX8MP platform and the DMA lines for
> devices are specified using FixedDMA resource descriptor. I think other Arm
> platforms like RPi have similar requirement.

Perhaps, but my question is _why_ is it so?
I.o.w. what is the technical background for this solution.

> [1] https://uefi.org/sites/default/files/resources/CSRT%20v2.pdf

-- 
With Best Regards,
Andy Shevchenko


