Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF983246
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHFNIn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 09:08:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:25156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFNIm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Aug 2019 09:08:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 06:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="198305977"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2019 06:08:41 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1huzCi-0008MC-52; Tue, 06 Aug 2019 16:08:40 +0300
Date:   Tue, 6 Aug 2019 16:08:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Bohn <thbohn@gmail.com>
Cc:     dmaengine <dmaengine@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: idma64.0 is keeping my processor awake after boot
Message-ID: <20190806130840.GD30120@smile.fi.intel.com>
References: <CAJEfxfYRZs_XH9Kp7ocB-ZZjAKa8eNo3vgCq1qWtL1Ak+cWS9A@mail.gmail.com>
 <1479226768.24056.23.camel@linux.intel.com>
 <CAJEfxfZAXfOJ79CjbfZWXVK_Y3+1+EQAja2wu3LGUGFzes75kQ@mail.gmail.com>
 <1479291233.24056.35.camel@linux.intel.com>
 <CAJEfxfaz+K-Wpun4Crqu1i5ocXKm0+rJv9=PSP3rqmztdpdH5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJEfxfaz+K-Wpun4Crqu1i5ocXKm0+rJv9=PSP3rqmztdpdH5A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 16, 2016 at 06:14:51PM +0100, Thomas Bohn wrote:
> 2016-11-16 11:13 GMT+01:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Tue, 2016-11-15 at 22:03 +0100, Thomas Bohn wrote:
> >> 2016-11-15 17:19 GMT+01:00 Andy Shevchenko <andriy.shevchenko@linux.in
> >> tel.com>:

> >> > idma64 itself can't be a culprit of such behaviour.
> >> >
> >> > The driver is loaded and bound whenever one of I2C, UART or SPI
> >> > controllers is enumerated and have DMA capability enabled.
> >> >
> >> > So, if you check /proc/interrupt and see what is the counterpart for
> >> > this DMA IP (some driver with .0 at the end) it would be helpful.

Isn't it the same as described in

https://bugzilla.kernel.org/show_bug.cgi?id=177311

-- 
With Best Regards,
Andy Shevchenko


