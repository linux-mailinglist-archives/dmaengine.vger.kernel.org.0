Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1456429267B
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 13:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgJSLiT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 07:38:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:15665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgJSLiS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 19 Oct 2020 07:38:18 -0400
IronPort-SDR: IF/xl5HcHj3phV+3h1Op20Ofo3G6rU7a4U86gc7pCvYSr39+rS4zEfoTJtpzgjgqGr6soOyRsY
 ATAMDI1AdX1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="146869686"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="146869686"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 04:38:16 -0700
IronPort-SDR: PbkTmHVEmjXGmdMl0H8O1XhKYU9rMrzqJz526ydTKNlgjX6y0Q79gbWatYhc6f32hIxxMpNIS5
 vlUgZj0epi1A==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="523086943"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 04:38:14 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kUTVV-00AY4g-CS; Mon, 19 Oct 2020 14:39:17 +0300
Date:   Mon, 19 Oct 2020 14:39:17 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Sia, Jee Heng" <jee.heng.sia@intel.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Message-ID: <20201019113917.GM4077@smile.fi.intel.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
 <MWHPR12MB18065E87CEE3FD28868EBB9BDE030@MWHPR12MB1806.namprd12.prod.outlook.com>
 <DM5PR1101MB22185FFAE24516B90B13D255DA1E0@DM5PR1101MB2218.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR1101MB22185FFAE24516B90B13D255DA1E0@DM5PR1101MB2218.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 19, 2020 at 01:22:03AM +0000, Sia, Jee Heng wrote:
> > From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > Sent: 16 October 2020 10:51 PM

> > Hi Sia,
> > 
> > Is this patch series available in some public git repo?
> [>>] We do not have public git repo, but the patch series are tested on kernel v5.9

Sia, can you fork a kernel repository on GitHub or GitLab and create there a
branch with this series based on v5.9?

> > I want to test it on our HW with DW AXI DMAC.

Eugeniy, to be honest, it's not a big deal to create one either with help of
lore.kernel.org or patchwork [1].

For your convenience (disclaimer, I can't guarantee I haven't missed something
here) I published it here [2]. Note, I didn't compile it.

[1]: https://patchwork.kernel.org/project/linux-dmaengine/cover/20201012042200.29787-1-jee.heng.sia@intel.com/
[2]: https://gitlab.com/andy-shev/next/-/tree/topic/dw-dma-axi

-- 
With Best Regards,
Andy Shevchenko


