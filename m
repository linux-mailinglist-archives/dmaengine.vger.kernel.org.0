Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262EB6B0EDE
	for <lists+dmaengine@lfdr.de>; Wed,  8 Mar 2023 17:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCHQjJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 11:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCHQjH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 11:39:07 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB23AAC;
        Wed,  8 Mar 2023 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678293546; x=1709829546;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=ODeJT1y7+5l/0fnzDBV2KuWm6PnkPYss1HOKRTfEPcI=;
  b=cSz8ur/Ad685vK9N9f5F51wV+IsrnCKrqWW3IopefYXqh9I20v8KmmbZ
   tywi68vA3hYH9X+Q51IkqNTqzTAEJDJ7K0V/bwMpmenHuUqjAkrXG5KbN
   JbYrTswowp+UbJCV+tfg/zXrJg5WKWCHmUIxQowjYXkPP5CsAfUnIlX4q
   FyMr21l+69Ymdo0czNy+hXw6aj7bkzUo7v+8IXebuJIgm9rxihk7tWrOW
   09P4/npUdKOjFvdek8TZHqS8qCjyMQP8csc5xBUH0/UY9adg6Fx8iCJpN
   dObpAZho1lQsu2Ei37zhmoiPAJiWgfWYc8AYMogyJdgNcPUOJmo9iXr+f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422475873"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422475873"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 08:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626983258"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="626983258"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2023 08:39:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZwoi-00HW19-04;
        Wed, 08 Mar 2023 18:39:04 +0200
Date:   Wed, 8 Mar 2023 18:39:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: Actually use devm_add_action_or_reset()
Message-ID: <ZAi6Jy/F4n5I6KHn@smile.fi.intel.com>
References: <20230213112138.32118-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213112138.32118-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 13, 2023 at 01:21:38PM +0200, Andy Shevchenko wrote:
> It appears that the commit a1beaa50b583 ("dmaengine: Simplify
> dmaenginem_async_device_register() function") mentions
> devm_add_action_or_reset() the actual change utilised devm_add_action()
> call by mistake.
> 
> Fix the issue by switching to devm_add_action_or_reset().

Vinod, are you okay with this fix?

-- 
With Best Regards,
Andy Shevchenko


