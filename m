Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51A1A010E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 13:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH1LxD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 07:53:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:21549 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfH1LxD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Aug 2019 07:53:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 04:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="171519671"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 04:53:01 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i2wVY-0007co-Ih; Wed, 28 Aug 2019 14:53:00 +0300
Date:   Wed, 28 Aug 2019 14:53:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] dmaengine: dw: Enable for Intel Elkhart Lake
Message-ID: <20190828115300.GL2680@smile.fi.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
 <20190821041144.GG12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821041144.GG12733@vkoul-mobl.Dlink>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 21, 2019 at 09:41:44AM +0530, Vinod Koul wrote:
> On 20-08-19, 16:15, Andy Shevchenko wrote:
> > On Intel Elkhart Lake the DMA controllers can be provided by Intel® PSE
> > (Programmable Services Engine) and exposed either as PCI or ACPI devices.
> > 
> > To support both schemes here is a patch series.
> > 
> > First two patches fixes minor issues in DMA ACPI layer, patches 3-5 enables
> > Intel Elkhart Lake DMA controllers that exposed as ACPI devices, patch 6 is
> > clean up, patch 7 is fix for possible race on ->remove() stage, patch 8 is
> > follow up clean up and patches 9-10 is a split for better maintenance.
> 
> Applied all, thanks

Thank you!

Though I haven't seen yet them in Linux next. Can we give at least the rest of
the time, till the release, to dangle them in Linux next?

-- 
With Best Regards,
Andy Shevchenko


