Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56005403F4
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jun 2022 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbiFGQlN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jun 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbiFGQlM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jun 2022 12:41:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04649C9644
        for <dmaengine@vger.kernel.org>; Tue,  7 Jun 2022 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654620071; x=1686156071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+TDTqyhjrThydGMc2tTh8G4lFKhZz5m+zIxJecQvkzU=;
  b=WqIbK0RVQ/Z7J4ypLLPhnS90FNN02A/SWrDNQzUDkqzPpOakZFzyir+Y
   JkNFDgcnNWTUPNMvqCwNuJ+LJS31dlg4qaT7Xu3EV55Cqyu2BH16A5xYJ
   mPUz07FTxFg5nznxqqgmduz3emHDk8NK4Up9le4hPGSWB8qkU2SymQ7kO
   83c1NYsyoEZF5sUjjDb41aVBG92AKI5Kwirj0Q3HyV3EceZSyaHva0PC3
   1PH5fAW/iOLr7ZRV3bkc0m+2uCE39wb21WOJZHNNg1gnkw1rEBsMEc4Nq
   FLNHGFiQfppXRdZf5RWNkb3I6skh/I9DKPd4gKr9J1+PytO34oLLaMe8q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277283983"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277283983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:33:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="682821894"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:33:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyc99-000Vrc-SN;
        Tue, 07 Jun 2022 19:33:35 +0300
Date:   Tue, 7 Jun 2022 19:33:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v2 1/2] dmaengine: dw: dmamux: Export the module device
 table
Message-ID: <Yp993+brT3AnqKRx@smile.fi.intel.com>
References: <20220607152215.46731-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607152215.46731-1-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 07, 2022 at 05:22:14PM +0200, Miquel Raynal wrote:
> This is a tristate driver that can be built as a module, as a result,
> the OF match table should be exported with MODULE_DEVICE_TABLE().

Fixes go first in the series.
If this is a fix, it misses Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


