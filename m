Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88E221D1F4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2020 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgGMIlg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jul 2020 04:41:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:46404 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgGMIlg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Jul 2020 04:41:36 -0400
IronPort-SDR: N2547ZEoTeqNBMC8fzTI+8W/jeP0XhIfG0BN8l9wc7hhlqm+JBvkSmXGra4zAeKkmcz4JJcbhi
 v2GohUVTAvhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="213414173"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="213414173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 01:41:35 -0700
IronPort-SDR: BLDNkp2A7Jp4PSPcgGtrrs2mwi6zap10DENFrgIJHJw7qKhjwMhOLvab3Dd19FuZLoaO4IcQvP
 WqfvenKKZrlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="325436277"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2020 01:41:35 -0700
Received: from [10.215.249.14] (mreddy3x-MOBL.gar.corp.intel.com [10.215.249.14])
        by linux.intel.com (Postfix) with ESMTP id 6EEBA58080E;
        Mon, 13 Jul 2020 01:41:32 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] Add Intel LGM soc DMA support.
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, mallikarjunax.reddy@linux.intel.com
References: <cover.1594273437.git.mallikarjunax.reddy@linux.intel.com>
 <6be9b9cfbf6708fe371f280cb94cbdc9c04bdccb.1594273437.git.mallikarjunax.reddy@linux.intel.com>
 <20200709110914.GW3703480@smile.fi.intel.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <e2eae7fc-0726-5156-8676-d64eab991c9e@linux.intel.com>
Date:   Mon, 13 Jul 2020 16:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709110914.GW3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Thanks for the review Andy. My comments inline.

On 7/9/2020 7:09 PM, Andy Shevchenko wrote:
> On Thu, Jul 09, 2020 at 02:01:06PM +0800, Amireddy Mallikarjuna reddy wrote:
>> Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.
>>
>> The main function of the DMA controller is the transfer of data from/to any
>> DPlus compliant peripheral to/from the memory. A memory to memory copy
>> capability can also be configured.
>>
>> This ldma driver is used for configure the device and channnels for data
>> and control paths.
>> +#include "../virt-dma.h"
> I didn't find any evidence this driver utilizes virt-dma API in full.
> For example, there is a virt_dma_desc structure and descriptor management around it.
> Why don't you use it?
Lgm dma soc has its own hardware descriptor.
and each dma channel is associated with a peripheral, it is one to one 
mapping between channel and associated peripheral.
>
