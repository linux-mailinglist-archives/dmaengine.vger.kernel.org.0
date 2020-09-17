Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEC26E990
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIQXn3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQXn3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Sep 2020 19:43:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B82FC06174A;
        Thu, 17 Sep 2020 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+QooxsRPLy4jqdonZqXT/xWaR2mYqwJaHtHqYhdaYX0=; b=RKsRpsBgrvEUJYxCzE0Z0nrivI
        IsQ902HTw9JOSWpoS0kcKymTAkWeUKlQ6xVMu/iEvYp0RLyBGxCffC7hPS3dAWybwadDQjbBW22Si
        fTkIJoxFkGERqF0Xu5eTJ4I9lo2yk3ddJM59dLOZD2dm2piJNNJga/ObeVSEeBEYfZe+lYkrcKXoH
        ecRTVrg4O8JTaIb3mFIH4aNN5GldrGJdKHFucpwRkFCjDEqoeqUxB2Ko5dNIWTwsSnnZZDOR9oxP5
        s2EnSAjq+cDx6N8L7QgCkteR/uauic3snm8oys6pLRAqlGSoq4J8+Qy2YlJlavwF9LtAfgfhkz2rF
        axFKh2ww==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ3Yk-0000zj-7L; Thu, 17 Sep 2020 23:43:26 +0000
Subject: Re: [PATCH v4 0/5] Add shared workqueue support for idxd driver
To:     Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e178a1ae-0ce2-70bc-54b9-9e2fae837f06@infradead.org>
Date:   Thu, 17 Sep 2020 16:43:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 9/17/20 2:15 PM, Dave Jiang wrote:
> 
> ---
> 
> Dave Jiang (5):
>       x86/asm: move the raw asm in iosubmit_cmds512() to special_insns.h
>       x86/asm: add enqcmds() to support ENQCMDS instruction
>       dmaengine: idxd: add shared workqueue support
>       dmaengine: idxd: clean up descriptors with fault error
>       dmaengine: idxd: add ABI documentation for shared wq
> 

I don't see patch 3/5 in my inbox nor at https://lore.kernel.org/dmaengine/

Did the email monster eat it?

thanks.

> 
>  Documentation/ABI/stable/sysfs-driver-dma-idxd |   14 ++
>  arch/x86/include/asm/io.h                      |   46 +++++---
>  arch/x86/include/asm/special_insns.h           |   17 +++
>  drivers/dma/Kconfig                            |   10 ++
>  drivers/dma/idxd/cdev.c                        |   49 ++++++++
>  drivers/dma/idxd/device.c                      |   91 ++++++++++++++-
>  drivers/dma/idxd/dma.c                         |    9 --
>  drivers/dma/idxd/idxd.h                        |   33 +++++-
>  drivers/dma/idxd/init.c                        |   92 ++++++++++++---
>  drivers/dma/idxd/irq.c                         |  143 ++++++++++++++++++++++--
>  drivers/dma/idxd/registers.h                   |   14 ++
>  drivers/dma/idxd/submit.c                      |   33 +++++-
>  drivers/dma/idxd/sysfs.c                       |  127 +++++++++++++++++++++
>  13 files changed, 608 insertions(+), 70 deletions(-)
> 
> --
> 

-- 
~Randy

