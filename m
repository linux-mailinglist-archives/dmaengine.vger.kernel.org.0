Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613E4347A72
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbhCXOQn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 10:16:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:46310 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235907AbhCXOQg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 10:16:36 -0400
IronPort-SDR: vu4cQx7tA8tG3BSxzWqZYGwNDbdDSWombpqclM2BWpGPsfFp/5PN4w9eKm+xS0zdsuNce3/biA
 rKmihoetgrdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="187403234"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="187403234"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:16:36 -0700
IronPort-SDR: x6trvllIKIswF/DKK2mncVAl555GUtqGxr6YbvG9jP7mkWXGjrUDKPK0rzYOlgeiYKcY5VZqgS
 GrhtkbKYAvuQ==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="442245809"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:16:34 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP4JE-00Fi6V-60; Wed, 24 Mar 2021 16:16:32 +0200
Date:   Wed, 24 Mar 2021 16:16:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Make it dependent to HAVE_IOMEM
Message-ID: <YFtJwKGauUaLf7Wf@smile.fi.intel.com>
References: <20210324121822.18092-1-andriy.shevchenko@linux.intel.com>
 <20210324135116.z3xjyjreni24roez@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324135116.z3xjyjreni24roez@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 04:51:16PM +0300, Serge Semin wrote:
> Hi Andy
> 
> On Wed, Mar 24, 2021 at 02:18:22PM +0200, Andy Shevchenko wrote:
> > Some architectures do not provide devm_*() APIs. Hence make the driver
> > dependent on HAVE_IOMEM.
> 
> You must have meant "HAS_IOMEM", right?

Good catch!
My memory tricked me :-)


-- 
With Best Regards,
Andy Shevchenko


