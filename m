Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD621D267
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2020 11:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgGMJDY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jul 2020 05:03:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:62216 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgGMJDY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Jul 2020 05:03:24 -0400
IronPort-SDR: FKCxaN1pN5/QCgaJ8gWMOclLRWVaE1NdRCtLlRgAZNJm62rJfwoFViblSllRzyPVSU20BHqdW9
 ReA4+oFRFCag==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146613402"
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="scan'208";a="146613402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 02:03:23 -0700
IronPort-SDR: UE4MUmNowr4zmxZPYlPAOi4ANrMT2reqcJZxqE4OVXjKiZBFqHzcmqsodXz9YrwexhAtUeGbiW
 qQkWxPT+XivA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="scan'208";a="325440370"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2020 02:03:21 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1juuMr-001ZBW-PN; Mon, 13 Jul 2020 12:03:21 +0300
Date:   Mon, 13 Jul 2020 12:03:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com
Subject: Re: [PATCH v4 2/2] Add Intel LGM soc DMA support.
Message-ID: <20200713090321.GA3703480@smile.fi.intel.com>
References: <cover.1594273437.git.mallikarjunax.reddy@linux.intel.com>
 <6be9b9cfbf6708fe371f280cb94cbdc9c04bdccb.1594273437.git.mallikarjunax.reddy@linux.intel.com>
 <20200709110914.GW3703480@smile.fi.intel.com>
 <e2eae7fc-0726-5156-8676-d64eab991c9e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2eae7fc-0726-5156-8676-d64eab991c9e@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 13, 2020 at 04:41:31PM +0800, Reddy, MallikarjunaX wrote:
> On 7/9/2020 7:09 PM, Andy Shevchenko wrote:
> > On Thu, Jul 09, 2020 at 02:01:06PM +0800, Amireddy Mallikarjuna reddy wrote:
> > > Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.
> > > 
> > > The main function of the DMA controller is the transfer of data from/to any
> > > DPlus compliant peripheral to/from the memory. A memory to memory copy
> > > capability can also be configured.
> > > 
> > > This ldma driver is used for configure the device and channnels for data
> > > and control paths.
> > > +#include "../virt-dma.h"
> > I didn't find any evidence this driver utilizes virt-dma API in full.
> > For example, there is a virt_dma_desc structure and descriptor management around it.
> > Why don't you use it?
> Lgm dma soc has its own hardware descriptor.
> and each dma channel is associated with a peripheral, it is one to one
> mapping between channel and associated peripheral.

And this neither objects nor answers to my question.

Hint: above mentioned structure is an abstraction of hardware descriptors for
easier management in Linux kernel.

-- 
With Best Regards,
Andy Shevchenko


