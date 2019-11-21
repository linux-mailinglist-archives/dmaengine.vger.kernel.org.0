Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6370A104785
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 01:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUA1j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 19:27:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:64139 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfKUA1j (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 19:27:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="204989376"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 16:27:37 -0800
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1911210120410.29534@nanos.tec.linutronix.de>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <9504173f-29b5-40a6-3fa8-4bfd498e2e31@intel.com>
Date:   Wed, 20 Nov 2019 17:27:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911210120410.29534@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/20/19 5:22 PM, Thomas Gleixner wrote:
> On Wed, 20 Nov 2019, Luck, Tony wrote:
>> On Wed, Nov 20, 2019 at 10:53:39PM +0100, Borislav Petkov wrote:
>>> On Wed, Nov 20, 2019 at 02:23:49PM -0700, Dave Jiang wrote:
>>>> +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
>>>> +				    size_t count)
>>>
>>> An iosubmit function which returns void and doesn't tell its callers
>>> whether it succeeded or not? That looks non-optimal to say the least.
>>
>> That's the underlying functionality of the MOVDIR64B instruction. A
>> posted write so no way to know if it succeeded. When using dedicated
>> queues the caller must keep count of how many operations are in flight
>> and not send more than the depth of the queue.
>>
>>> Why isn't there a fallback function which to call when the CPU doesn't
>>> support movdir64b?
>>
>> This particular driver has no option for fallback. Descriptors can
>> only be submitted with MOVDIR64B (to dedicated queues ... in later
>> patch series support for shared queues will be added, but those require
>> ENQCMD or ENQCMDS to submit).
>>
>> The driver bails out at the beginning of the probe routine if the
>> necessary instructions are not supported:
>>
>> +       /*
>> +        * If the CPU does not support write512, there's no point in
>> +        * enumerating the device. We can not utilize it.
>> +        */
>> +       if (!cpu_has_write512())
>> +               return -ENXIO;
>>
>> Though we should always get past that as this PCI device ID shouldn't
>> every appear on a system that doesn't have the support. Device is on
>> the die, not a plug-in card.
> 
> Then the condition in the iosubmit function is just prone to silently paper
> over any bug in a driver:
> 
>> +       if (!cpu_has_write512())
>> +               return;
> 
> This should at least issue a WARN_ON_ONCE()

Thanks! I'll be adding the WARN_ON_ONCE() for the cap check. Also with 
the alignment check Borislav mentioned, I'll add a WARN_ON() for failures.


> 
> Thanks,
> 
> 	tglx
> 
