Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D3225E0E0
	for <lists+dmaengine@lfdr.de>; Fri,  4 Sep 2020 19:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIDReH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Sep 2020 13:34:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:39671 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDReG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 4 Sep 2020 13:34:06 -0400
IronPort-SDR: ch+lJtxW20XJKg5Det7rupJ1tIxIHYNN8tnMz1+etlSAg1GwQlxtrSK70tRGEp4DpYEWvBIJGr
 BnwMnkVf7UOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="158777510"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="158777510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 10:34:05 -0700
IronPort-SDR: K3kRztovWwAt9rAHupMhlLdFwh1+m9dI0xvXC0FAeePgfjJzmbkkVSv7rH76ww8Rhdg+ww4lUR
 cGmFXdj8u4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332238510"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 10:34:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEFb7-00EKre-Gk; Fri, 04 Sep 2020 20:34:01 +0300
Date:   Fri, 4 Sep 2020 20:34:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     dmaengine@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: 6b41030fdc790 broke dmatest badly
Message-ID: <20200904173401.GH1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It becomes a bit annoying to fix dmatest after almost each release.
The commit 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
broke my use case when I tried to start busy channel.

So, before this patch
	...
	echo "busy_chan" > channel
	echo 1 > run
	sh: write error: Device or resource busy
	[ 1013.868313] dmatest: Could not start test, no channels configured

After I have got it run on *ALL* available channels.

dmatest compiled as a module.

Fix this ASAP, otherwise I will send revert of this and followed up patch next
week.

-- 
With Best Regards,
Andy Shevchenko


