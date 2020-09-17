Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2226E9A6
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 01:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIQX4J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 19:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIQX4J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Sep 2020 19:56:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EAC06174A;
        Thu, 17 Sep 2020 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qLkUz/wGrNt/88Ha+h+Kz8s+E0LsPfpK9gkn8CAhG28=; b=odxn3Jaa81ConedWtWX7gdVN8z
        VL91AOAkk0TdCauhiahDnRxGk10Q+ek3WaMdS51moylz1ydynS9FGNOiAFx5xumowvw3rheys09kP
        /AvtTIVO/8GJNIzrLYDCwCPKeGXB++Hk20GoU83/DviUTWgEUGmduDdKg6nleyT/a/vTR0sBd562E
        HRyLQpae0LmYyq9Lng2mAU8K5ICzmjmulSLVirIXDazw5jDiQkOgDrMD/T44JJPhTRTSDiGfWy7Cg
        AXS06m3/e5wniZbCH9jA29z8FRduT9p7L7l+8zueolDJyNVNGJSAmWqW++3FPitks9hKX+97KAbpm
        TxSO3ogg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ3l1-0001jZ-EL; Thu, 17 Sep 2020 23:56:07 +0000
Subject: Re: [PATCH v4 0/5] Add shared workqueue support for idxd driver
To:     Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
 <e178a1ae-0ce2-70bc-54b9-9e2fae837f06@infradead.org>
 <84e1ec28-4a89-963a-49f6-3bbf1d276603@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b4d8c50-8a82-9110-bc6c-ffb6b50e6c0c@infradead.org>
Date:   Thu, 17 Sep 2020 16:56:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <84e1ec28-4a89-963a-49f6-3bbf1d276603@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 9/17/20 4:51 PM, Dave Jiang wrote:
> 
> 
> On 9/17/2020 4:43 PM, Randy Dunlap wrote:
>> Hi,
>>
>> On 9/17/20 2:15 PM, Dave Jiang wrote:
>>>
>>> ---
>>>
>>> Dave Jiang (5):
>>>        x86/asm: move the raw asm in iosubmit_cmds512() to special_insns.h
>>>        x86/asm: add enqcmds() to support ENQCMDS instruction
>>>        dmaengine: idxd: add shared workqueue support
>>>        dmaengine: idxd: clean up descriptors with fault error
>>>        dmaengine: idxd: add ABI documentation for shared wq
>>>
>>
>> I don't see patch 3/5 in my inbox nor at https://lore.kernel.org/dmaengine/
>>
>> Did the email monster eat it?
> 
> Grrrrrr looks like Intel email server ate it. Everyone on cc list got it. But does not look like it made it to any of the mailing lists. I'll resend 3/5.

Got it. Thanks.

>>
>> thanks.
>>
>>>
>>>   Documentation/ABI/stable/sysfs-driver-dma-idxd |   14 ++
>>>   arch/x86/include/asm/io.h                      |   46 +++++---
>>>   arch/x86/include/asm/special_insns.h           |   17 +++
>>>   drivers/dma/Kconfig                            |   10 ++
>>>   drivers/dma/idxd/cdev.c                        |   49 ++++++++
>>>   drivers/dma/idxd/device.c                      |   91 ++++++++++++++-
>>>   drivers/dma/idxd/dma.c                         |    9 --
>>>   drivers/dma/idxd/idxd.h                        |   33 +++++-
>>>   drivers/dma/idxd/init.c                        |   92 ++++++++++++---
>>>   drivers/dma/idxd/irq.c                         |  143 ++++++++++++++++++++++--
>>>   drivers/dma/idxd/registers.h                   |   14 ++
>>>   drivers/dma/idxd/submit.c                      |   33 +++++-
>>>   drivers/dma/idxd/sysfs.c                       |  127 +++++++++++++++++++++
>>>   13 files changed, 608 insertions(+), 70 deletions(-)
>>>
>>> -- 
>>>
>>


-- 
~Randy

