Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDAF39865E
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFBKXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhFBKX3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Jun 2021 06:23:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2BC061756;
        Wed,  2 Jun 2021 03:20:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622629219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycehTrtSkbzNyxkb7pYteowZNnr3e/3i4uwrIdUn4ks=;
        b=goUuSDeF84WkaAOZwHO7jxr8b6qzOlP5Z8RALkPRnEgu/QgIAO9AYiqvP3EQePtlz4ISWM
        P9xXodHXj0EhuqHSWGw8w49Xiwpqvtr7ueb0D2IcXvsJSIiJhqyNuzxgW1zZ6lIl7k58Q3
        2mpAA3Mw2hFEToZ19NiMsIab9COwDaUi/+R2WY3Oobff+ok36o2gJDUsOFZKnoeNLt9lfK
        owDobF+aH6xCaqaBxsoqXADNmnwhU9tvV3JIE5rkiloCmw26kJmbDxKs3ctZ905F84gzvH
        XtM2rrAh/5DHvYlG8MViQXAq+YmGW1G30ySblTZSpk7SdDVkJrIBWut8quG2xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622629219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycehTrtSkbzNyxkb7pYteowZNnr3e/3i4uwrIdUn4ks=;
        b=QFU8uRFnQvM4DJ8WlmWMQuSSa53t7e7ZnEkgELkmq1CQdCWE4GgFM9XNxOOfO7dszlJ+pX
        EAJJgXit3+y5mDCA==
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove update_pasid()
In-Reply-To: <YLdZ7bZDPNup1n9c@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com> <1600187413-163670-10-git-send-email-fenghua.yu@intel.com> <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLdZ7bZDPNup1n9c@zn.tnic>
Date:   Wed, 02 Jun 2021 12:20:18 +0200
Message-ID: <87k0nc1sbh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 02 2021 at 12:14, Borislav Petkov wrote:

> On Sat, May 29, 2021 at 11:17:30AM +0200, Thomas Gleixner wrote:
>> --- a/arch/x86/include/asm/disabled-features.h
>> +++ b/arch/x86/include/asm/disabled-features.h
>> @@ -56,11 +56,8 @@
>>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>>  #endif
>>  
>> -#ifdef CONFIG_IOMMU_SUPPORT
>> -# define DISABLE_ENQCMD	0
>> -#else
>> -# define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
>> -#endif
>> +/* Force disable because it's broken beyond repair */
>> +#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
>
> Yeah, for that to work we need:
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 2 Jun 2021 12:07:52 +0200
> Subject: [PATCH] dmaengine: idxd: Use cpu_feature_enabled()
>
> When testing x86 feature bits, use cpu_feature_enabled() so that
> build-disabled features can remain off, regardless of what CPUID says.
>
> Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for spotting this!

       tglx

