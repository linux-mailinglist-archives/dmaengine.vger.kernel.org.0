Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA11F6C4DD5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 15:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjCVOeE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjCVOeA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 10:34:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192A27497;
        Wed, 22 Mar 2023 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495600; x=1711031600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z1iRri0eBPqvUL2gJgBO1g46Y4Dzoqj6rLL+2BQRDQs=;
  b=aq2NsDGwQKAEQFw8eK5UbTdz7kqNm4Hef8X8sOy5dUvHCUafuroTrelm
   SQ4jEcWZltW3BL04z1xHQsd0BxAmjUS3ylGscJfF/XnFz6dG1EjO3za8S
   xXaxDq9Of1ea7IJ1SxHtrs2ct1Wb+pjvSyCtQjYMv3UWzOynbyQ/vsKjM
   bXjd6QQkf4O4M+2I4v2H8d4LqUQlX4oHJdBwwpLEe6gR04maZvTSKwZt4
   GipmFEdu/CHRaGtDX+adAvcl6Cga/9mBiI6GGO4OFEyBh2TCA1QPDjc08
   Znu0lKSHw9y9wrJsGmJglw0DE3wsAMRI6aIH5v0Rq2kSgefDA5auhkk+i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341587315"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="341587315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="746345583"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="746345583"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2023 07:32:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pezWG-007AJ8-1o;
        Wed, 22 Mar 2023 16:32:52 +0200
Date:   Wed, 22 Mar 2023 16:32:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Niyas Sait <niyas.sait@linaro.org>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Message-ID: <ZBsRlJ0o9Amf402f@smile.fi.intel.com>
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
 <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
 <6e90881b-ba24-7f5a-e80d-1ae7fc9d9382@linaro.org>
 <ZBrLr4QDdZpgs3RV@smile.fi.intel.com>
 <7ecf4fbf-392e-7c55-b731-2d61f962ddeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ecf4fbf-392e-7c55-b731-2d61f962ddeb@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 22, 2023 at 12:00:36PM +0000, Niyas Sait wrote:
> On 22/03/2023 09:34, Andy Shevchenko wrote:

...

> > > > Btw, what is the real argument of not using this table?
> > > > 
> > > > Yes, I know that this is an MS extension, but why ARM needs something else and
> > > > why even that is needed at all? CSRT is only for the_shared_  DMA resources
> > > > and I think most of the IPs nowadays are using private DMA engines (or
> > > > semi-private when driver based on ID can know which channel services which
> > > > device).
> > > The issue is that shared info descriptor is not part of CSRT definition [1]
> > > and I think it is not standardized or documented anywhere.
> > > 
> > > I was specifically looking at NXP I.MX8MP platform and the DMA lines for
> > > devices are specified using FixedDMA resource descriptor. I think other Arm
> > > platforms like RPi have similar requirement.
> > Perhaps, but my question is_why_  is it so?
> > I.o.w. what is the technical background for this solution.
> > 
> 
> NXP I.MX8MP board uses shared DMA controller and the current ACPI firmware
> describes DMA request lines for devices using ACPI FixedDMA descriptors.
> 
> > JFYI: ARM platform(s) use SPCR, which is also not a part of the specification.
> 
> SPCR and CSRT tables have permissive licensing and probably okay to use
> them.
> 
> The main issue is that the shared info descriptor in the CSRT table is not a
> standard and none of the arm platforms uses them.

SPCR is not standard either. So, that's to show that this is not an argument.

Are those firmwares already in the wild? Why they can't be fixed and why
existing CSRT shared info data structure can't be used.

> >> [1]https://uefi.org/sites/default/files/resources/CSRT%20v2.pdf

-- 
With Best Regards,
Andy Shevchenko


