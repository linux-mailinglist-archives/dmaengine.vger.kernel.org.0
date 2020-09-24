Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74F42774CD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgIXPHq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 11:07:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:61088 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgIXPHq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 11:07:46 -0400
IronPort-SDR: Dq7d68xETq22hAZ9ZEP9rqB7sWIXUvEA3x2MAZM+0ErIDaoLZumuWm9djagsmJ3VfJKHyW54QC
 vRWMEsBlqLxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="141249501"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="141249501"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 08:07:46 -0700
IronPort-SDR: qxBV4ZZ4P1R7IgueUS2vQPZwvQSxI6oYaw87jtCVrwW2WUcK8stV9bonpmW+csntTGSw8BMv52
 c+CM+IKMVg+w==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="292124548"
Received: from abslota-mobl1.amr.corp.intel.com (HELO [10.212.218.169]) ([10.212.218.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 08:07:45 -0700
Subject: Re: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
To:     Borislav Petkov <bp@alien8.de>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@ACULAB.COM, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Matz <matz@suse.de>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
 <20200924130746.GF5030@zn.tnic>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <e561e7a3-32c7-dac5-053d-47a0484b26c8@intel.com>
Date:   Thu, 24 Sep 2020 08:07:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924130746.GF5030@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/24/2020 6:07 AM, Borislav Petkov wrote:
> On Wed, Sep 23, 2020 at 04:10:43PM -0700, Dave Jiang wrote:
>> +/* The dst parameter must be 64-bytes aligned */
>> +static inline void movdir64b(void *dst, const void *src)
>> +{
>> +	/*
>> +	 * Note that this isn't an "on-stack copy", just definition of "dst"
>> +	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
>> +	 * In the MOVDIR64B case that may be needed as you can use the
>> +	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
>> +	 * lets the compiler know how much gets clobbered.
>> +	 */
>> +	volatile struct { char _[64]; } *__dst = dst;
>> +
>> +	/* MOVDIR64B [rdx], rax */
>> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
>> +		     :
>> +		     : "m" (*(struct { char _[64];} **)src), "a" (__dst)
>> +		     : "memory");
>> +}
> 
> Ok, Micha and I hashed it out on IRC, here's what you do. Please keep
> the comments too because we will forget soon again.
> 
> static inline void movdir64b(void *__dst, const void *src)
> {
> 	struct { char _[64]; } *__src = src;
> 	struct { char _[64]; } *__dst = dst;
> 
> 	/*
> 	 * MOVDIR64B %(rdx), rax.
> 	 *
> 	 * Both __src and __dst must be memory constraints in order to tell the
> 	 * compiler that no other memory accesses should be reordered around
> 	 * this one.
> 	 *
> 	 * Also, both must be supplied as lvalues because this tells
> 	 * the compiler what the object is (its size) the instruction accesses.
> 	 * I.e., not the pointers but what they point, thus the deref'ing '*'.
> 	 */
> 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> 		     : "+m" (*__dst)
> 		     :  "m" (*__src), "a" (__dst), "d" (__src));
> }

Thanks Boris. I will update and resend.

> 
> Thx.
> 
