Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200658D670
	for <lists+dmaengine@lfdr.de>; Wed, 14 Aug 2019 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNOon (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Aug 2019 10:44:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:61935 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHNOon (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Aug 2019 10:44:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 07:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="184330857"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2019 07:44:41 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hxuVz-0004qn-VN; Wed, 14 Aug 2019 17:44:39 +0300
Date:   Wed, 14 Aug 2019 17:44:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 07/12] dmaengine: dw: platform: Enable iDMA 32-bit on
 Intel Elkhart Lake
Message-ID: <20190814144439.GW30120@smile.fi.intel.com>
References: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
 <20190806094054.64871-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094054.64871-7-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 06, 2019 at 12:40:49PM +0300, Andy Shevchenko wrote:
> Intel Elkhart Lake OSE (Offload Service Engine) provides few DMA controllers
> to the host. Enable them in the ACPI glue driver.
> 

Since Jarkko noticed an issue with naming of IP, this and relevant patches has
to be re-done.

> +	/* Elkhart Lake iDMA 32-bit (OSE DMA) */
> +	{ "80864BB4", (kernel_ulong_t)&idma32_chip_pdata },
> +	{ "80864BB5", (kernel_ulong_t)&idma32_chip_pdata },
> +	{ "80864BB6", (kernel_ulong_t)&idma32_chip_pdata },

-- 
With Best Regards,
Andy Shevchenko


