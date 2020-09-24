Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BD277AF5
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 23:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIXVPO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 17:15:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:42526 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXVPO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 17:15:14 -0400
IronPort-SDR: 9/EG00OT+djQ0vQV9pP7pX4ag7yPfhYjjtMBnfYq8HbG0yfgJbjrmK8Du6xAH4yhC8i62mSSXl
 NMSL2P4p4ZxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222942021"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="222942021"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 14:15:13 -0700
IronPort-SDR: WcKeJWQzcoUExwCtjl7mZnHmD3aR88prAjCiW9aGwma3Ahaup+b48hXP1DiCsD9AN63FdO1abM
 wOTM0z8bwGbA==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="383207219"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.218.169]) ([10.212.218.169])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 14:15:12 -0700
Subject: Re: [PATCH v6 2/5] x86/asm: Add enqcmds() to support ENQCMDS
 instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@ACULAB.COM, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-3-dave.jiang@intel.com> <20200924185822.GQ5030@zn.tnic>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <e9687687-b748-6d38-2ce4-14507b513259@intel.com>
Date:   Thu, 24 Sep 2020 14:14:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924185822.GQ5030@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/24/2020 11:58 AM, Borislav Petkov wrote:
> On Thu, Sep 24, 2020 at 11:00:38AM -0700, Dave Jiang wrote:
>> +/**
>> + * enqcmds - copy a 512 bits data unit to single MMIO location
> 
> You forgot to fix this.
> 
>> + * @dst: destination, in MMIO space (must be 512-bit aligned)
>> + * @src: source
>> + *
>> + * The ENQCMDS instruction allows software to write a 512 bits command to
>> + * a 512 bits aligned special MMIO region that supports the instruction.
>> + * A return status is loaded into the ZF flag in the RFLAGS register.
>> + * ZF = 0 equates to success, and ZF = 1 indicates retry or error.
>> + *
>> + * The enqcmds() function uses the ENQCMDS instruction to submit data from
>> + * kernel space to MMIO space, in a unit of 512 bits. Order of data access
>> + * is not guaranteed, nor is a memory barrier performed afterwards. The
>> + * function returns 0 on success and -EAGAIN on failure.
>> + *
>> + * Warning: Do not use this helper unless your driver has checked that the CPU
>> + * instruction is supported on the platform and the device accepts ENQCMDS.
>> + */
>> +static inline int enqcmds(void __iomem *dst, const void *src)
>> +{
>> +	int zf;
>> +
>> +	/* ENQCMDS [rdx], rax */
>> +	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
>> +		     CC_SET(z)
>> +		     : CC_OUT(z) (zf)
>> +		     : "a" (dst), "d" (src));
> 
> Those operands need to be specified the same way as for movdir64b.
> 
> I've done that to save roundtrip time - simply replace yours with this
> one after having tested it on actual hardware, of course.

Thanks Boris! Very much appreciate this. I have tested and everything is good.

> 
> ---
>  From 39cbdc81d657efcb73c0f7d7ab5e5c53f439f267 Mon Sep 17 00:00:00 2001
> From: Dave Jiang <dave.jiang@intel.com>
> Date: Thu, 24 Sep 2020 11:00:38 -0700
> Subject: [PATCH] x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Currently, the MOVDIR64B instruction is used to atomically submit
> 64-byte work descriptors to devices. Although it can encounter errors
> like device queue full, command not accepted, device not ready, etc when
> writing to a device MMIO, MOVDIR64B can not report back on errors from
> the device itself. This means that MOVDIR64B users need to separately
> interact with a device to see if a descriptor was successfully queued,
> which slows down device interactions.
> 
> ENQCMD and ENQCMDS also atomically submit 64-byte work descriptors
> to devices. But, they *can* report back errors directly from the
> device, such as if the device was busy, or device not enabled or does
> not support the command. This immediate feedback from the submission
> instruction itself reduces the number of interactions with the device
> and can greatly increase efficiency.
> 
> ENQCMD can be used at any privilege level, but can effectively only
> submit work on behalf of the current process. ENQCMDS is a ring0-only
> instruction and can explicitly specify a process context instead of
> being tied to the current process or needing to reprogram the IA32_PASID
> MSR.
> 
> Use ENQCMDS for work submission within the kernel because a Process
> Address ID (PASID) is setup to translate the kernel virtual address
> space. This PASID is provided to ENQCMDS from the descriptor structure
> submitted to the device and not retrieved from IA32_PASID MSR, which is
> setup for the current user address space.
> 
> See Intel Software Developer’s Manual for more information on the
> instructions.
> 
>   [ bp:
>     - Make operand constraints like movdir64b() because both insns are
>       basically doing the same thing, more or less.
>     - Fixup comments and cleanup. ]
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Link: https://lkml.kernel.org/r/20200924180041.34056-3-dave.jiang@intel.com
> ---
>   arch/x86/include/asm/special_insns.h | 42 ++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 2f0c8a39c796..2c18c780b2d5 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -262,6 +262,48 @@ static inline void movdir64b(void *dst, const void *src)
>   		     :  "m" (*__src), "a" (__dst), "d" (__src));
>   }
>   
> +/**
> + * enqcmds - Enqueue a command in supervisor (CPL0) mode
> + * @dst: destination, in MMIO space (must be 512-bit aligned)
> + * @src: 512 bits memory operand
> + *
> + * The ENQCMDS instruction allows software to write a 512-bit command to
> + * a 512-bit-aligned special MMIO region that supports the instruction.
> + * A return status is loaded into the ZF flag in the RFLAGS register.
> + * ZF = 0 equates to success, and ZF = 1 indicates retry or error.
> + *
> + * This function issues the ENQCMDS instruction to submit data from
> + * kernel space to MMIO space, in a unit of 512 bits. Order of data access
> + * is not guaranteed, nor is a memory barrier performed afterwards. It
> + * returns 0 on success and -EAGAIN on failure.
> + *
> + * Warning: Do not use this helper unless your driver has checked that the
> + * ENQCMDS instruction is supported on the platform and the device accepts
> + * ENQCMDS.
> + */
> +static inline int enqcmds(void __iomem *dst, const void *src)
> +{
> +	const struct { char _[64]; } *__src = src;
> +	struct { char _[64]; } *__dst = dst;
> +	int zf;
> +
> +	/*
> +	 * ENQCMDS %(rdx), rax
> +	 *
> +	 * See movdir64b()'s comment on operand specification.
> +	 */
> +	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
> +		     CC_SET(z)
> +		     : CC_OUT(z) (zf), "+m" (*__dst)
> +		     : "m" (*__src), "a" (__dst), "d" (__src));
> +
> +	/* Submission failure is indicated via EFLAGS.ZF=1 */
> +	if (zf)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
>   #endif /* __KERNEL__ */
>   
>   #endif /* _ASM_X86_SPECIAL_INSNS_H */
> 
