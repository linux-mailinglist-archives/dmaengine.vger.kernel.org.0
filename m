Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E643D26E99C
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 01:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIQXwC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 19:52:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:62814 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIQXwC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 19:52:02 -0400
IronPort-SDR: tvLjnt3oTb2lstSKyqgCrB3efE5ptCk+Z3M6T2aj1f7INh+ieax4Bt2X+TB7Dt4LSRLd2Y0Z3j
 cpZ6TqKKZjZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147504038"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="147504038"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 16:51:55 -0700
IronPort-SDR: sKYl2n7CV2n/qrByGfT/KHF30CYNtfq36ZzeTbW05uM2a3VJ1rZp0vQaZmvPRKJwTAbWje/OXY
 gVwrTLkmIjqA==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="336600459"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.200.158]) ([10.212.200.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 16:51:55 -0700
Subject: Re: [PATCH v4 0/5] Add shared workqueue support for idxd driver
To:     Randy Dunlap <rdunlap@infradead.org>, vkoul@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
 <e178a1ae-0ce2-70bc-54b9-9e2fae837f06@infradead.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <84e1ec28-4a89-963a-49f6-3bbf1d276603@intel.com>
Date:   Thu, 17 Sep 2020 16:51:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e178a1ae-0ce2-70bc-54b9-9e2fae837f06@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/17/2020 4:43 PM, Randy Dunlap wrote:
> Hi,
> 
> On 9/17/20 2:15 PM, Dave Jiang wrote:
>>
>> ---
>>
>> Dave Jiang (5):
>>        x86/asm: move the raw asm in iosubmit_cmds512() to special_insns.h
>>        x86/asm: add enqcmds() to support ENQCMDS instruction
>>        dmaengine: idxd: add shared workqueue support
>>        dmaengine: idxd: clean up descriptors with fault error
>>        dmaengine: idxd: add ABI documentation for shared wq
>>
> 
> I don't see patch 3/5 in my inbox nor at https://lore.kernel.org/dmaengine/
> 
> Did the email monster eat it?

Grrrrrr looks like Intel email server ate it. Everyone on cc list got it. But 
does not look like it made it to any of the mailing lists. I'll resend 3/5.

> 
> thanks.
> 
>>
>>   Documentation/ABI/stable/sysfs-driver-dma-idxd |   14 ++
>>   arch/x86/include/asm/io.h                      |   46 +++++---
>>   arch/x86/include/asm/special_insns.h           |   17 +++
>>   drivers/dma/Kconfig                            |   10 ++
>>   drivers/dma/idxd/cdev.c                        |   49 ++++++++
>>   drivers/dma/idxd/device.c                      |   91 ++++++++++++++-
>>   drivers/dma/idxd/dma.c                         |    9 --
>>   drivers/dma/idxd/idxd.h                        |   33 +++++-
>>   drivers/dma/idxd/init.c                        |   92 ++++++++++++---
>>   drivers/dma/idxd/irq.c                         |  143 ++++++++++++++++++++++--
>>   drivers/dma/idxd/registers.h                   |   14 ++
>>   drivers/dma/idxd/submit.c                      |   33 +++++-
>>   drivers/dma/idxd/sysfs.c                       |  127 +++++++++++++++++++++
>>   13 files changed, 608 insertions(+), 70 deletions(-)
>>
>> --
>>
> 
