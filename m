Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1426C38BF
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCUR50 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCUR4v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 13:56:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD6755502;
        Tue, 21 Mar 2023 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679421390; x=1710957390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8K5vfDprZBz9UKiXrybQ7Br3/0gW61+NlbwJq+CAH20=;
  b=eEjUgie0Os1R/+462AkQzHBD2H4/6DyR3wl6T8m5yPsv9cBI55/05LAT
   a61vjozXuFrL5EGbPJnnaBwGj4I5KmWNzcfisDVc9ZWVyJ2g2Rzyg5Tdw
   I1AQf63cFiyy2Eyquvr87qxLeI+qllIg/DHhcG5Y2NuXm7yD6Ti4yA8Ba
   JLiudo/yi8kxwpFwsz1ssN4ypLtCb7rrTzFHjafVE8IEO1LZvbk0koAel
   4xm1Uq3QO8NhWnpaOLtIDU43lBMH5XPI/Dy/v8nP7HOHjpkUnPCa1DLh+
   Fpc0PZSWvddYX2JytzLK9gdXVSYmFctQ95Och+UqjtQvTx7A7YLKopUnw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401588150"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="401588150"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 10:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="1011045403"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="1011045403"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Mar 2023 10:56:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pegDh-006q3N-1A;
        Tue, 21 Mar 2023 19:56:25 +0200
Date:   Tue, 21 Mar 2023 19:56:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Niyas Sait <niyas.sait@linaro.org>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Message-ID: <ZBnvyXyCRpdZBslo@smile.fi.intel.com>
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
 <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 21, 2023 at 07:53:33PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 21, 2023 at 04:02:41PM +0000, Niyas Sait wrote:
> > This patch refactors the ACPI DMA layer to support platforms without
> > shared info descriptor in CSRT.
> > 
> > Shared info descriptor is optional and vendor specific (not
> > standardized) and not used by Arm platforms.

Btw, what is the real argument of not using this table?

Yes, I know that this is an MS extension, but why ARM needs something else and
why even that is needed at all? CSRT is only for the _shared_ DMA resources
and I think most of the IPs nowadays are using private DMA engines (or
semi-private when driver based on ID can know which channel services which
device).


-- 
With Best Regards,
Andy Shevchenko


