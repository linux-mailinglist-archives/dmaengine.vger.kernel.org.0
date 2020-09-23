Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9762275C56
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIWPre (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 11:47:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:33632 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPrd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Sep 2020 11:47:33 -0400
IronPort-SDR: UyRufnYM5KdWeeQHrppq5jObGE13GiqJr4WwbpZu5D6PuKlb9eFSywfZCLZOS+tc7sEhPmxX3f
 s8DhCOeeAL4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="161855399"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="161855399"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 08:47:33 -0700
IronPort-SDR: HYS3YyIhjzxpL9xNueBLE8HpUGLaaAXCXx5CJaZvZWwSGs7LBujxk5r0KP3kilOKEbmK5xYn84
 1IiGIj34YQrA==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="486485705"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.218.1]) ([10.212.218.1])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 08:47:32 -0700
Subject: Re: [PATCH v4 2/5] x86/asm: add enqcmds() to support ENQCMDS
 instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
 <160037732334.3777.8083106831110728138.stgit@djiang5-desk3.ch.intel.com>
 <20200923110837.GH28545@zn.tnic>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <10b6c333-b252-eb9c-db82-91a93232e1a0@intel.com>
Date:   Wed, 23 Sep 2020 08:47:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923110837.GH28545@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/23/2020 4:08 AM, Borislav Petkov wrote:
> On Thu, Sep 17, 2020 at 02:15:23PM -0700, Dave Jiang wrote:
>> Add enqcmds() in x86 io.h instead of special_insns.h.
> 
> Why? It is an asm wrapper for a special instruction.

Ok will move.

> 
>> MOVDIR64B
>> instruction can be used for other purposes. A wrapper was introduced
>> in io.h for its command submission usage. ENQCMDS has a single
>> purpose of submit 64-byte commands to supported devices and should
>> be called directly.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   arch/x86/include/asm/io.h |   29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>> index d726459d08e5..b7af0bf8a018 100644
>> --- a/arch/x86/include/asm/io.h
>> +++ b/arch/x86/include/asm/io.h
>> @@ -424,4 +424,33 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
>>   	}
>>   }
>>   
>> +/**
>> + * enqcmds - copy a 512 bits data unit to single MMIO location
> 
> Your #319433 doc says
> 
> "ENQCMDS — Enqueue Command Supervisor"
> 
> Now *how* that enqueueing is done you can explain in the comment below.

Ok will add.

> 
>> + * @dst: destination, in MMIO space (must be 512-bit aligned)
>> + * @src: source
>> + *
>> + * Submit data from kernel space to MMIO space, in a unit of 512 bits.
>> + * Order of data access is not guaranteed, nor is a memory barrier
>> + * performed afterwards. The command returns false (0) on failure, and true (1)
>> + * on success.
> 
> The command or the function?

Function. Will fix.
> 
>  From what I see below, the instruction sets ZF=1 to denote that it needs
> to be retried and ZF=0 means success, as the doc says. And in good UNIX
> tradition, 0 means usually success and !0 failure.
> 
> So why are you flipping that?

Ok will return 0 for success and -ERETRY for failure.

> 
>> + * Warning: Do not use this helper unless your driver has checked that the CPU
>> + * instruction is supported on the platform.
>> + */
>> +static inline bool enqcmds(void __iomem *dst, const void *src)
>> +{
>> +	bool retry;
>> +
>> +	/* ENQCMDS [rdx], rax */
>> +	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90\t\n"
> 								    ^^^^
> No need for those last two chars.

Ok will remove.

> 
>> +		     CC_SET(z)
>> +		     : CC_OUT(z) (retry)
>> +		     : "a" (dst), "d" (src));
> 
> <---- newline here.

Will fix.

> 
>> +	/* Submission failure is indicated via EFLAGS.ZF=1 */
>> +	if (retry)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   #endif /* _ASM_X86_IO_H */
> 
> Thx.
> 

Thank you very much for reviewing Boris. Very much appreciated!
