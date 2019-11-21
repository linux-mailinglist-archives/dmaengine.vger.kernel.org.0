Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C822105779
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUQwW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Nov 2019 11:52:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:23669 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUQwW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Nov 2019 11:52:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 08:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="205204778"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2019 08:52:19 -0800
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
 <20191121105913.GB6540@zn.tnic>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <ef6bc4a4-b307-9bc4-f3be-f7ab7232d303@intel.com>
Date:   Thu, 21 Nov 2019 09:52:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121105913.GB6540@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/21/19 3:59 AM, Borislav Petkov wrote:
> On Wed, Nov 20, 2019 at 05:10:41PM -0700, Dave Jiang wrote:
>> I'll add the check on the destination address. The call is modeled after
>> __iowrite64_copy() / __iowrite32_copy() in lib/iomap_copy.c. Looks like
>> those functions do not check for the alignment requirements either.
> 
> So just because they don't check, you don't need to check either?

No what I mean was those primitives are missing the checks and we should 
probably address that at some point.

> 
> Can you guarantee that all callers will always do the right thing?
> 
> I mean, if you don't care too much, why even write "(must be 512-bit
> aligned)"? Who cares then if the data is aligned or not...
> 


>>>> + * @dst: destination, in MMIO space (must be 512-bit aligned)
>>>> + * @src: source
>>>> + * @count: number of 512 bits quantities to submit
>>>
>>> Where's that check on the data?
>>
>> I don't follow?
> 
> What do you do if the caller doesn't submit data in 512 bits quantities?
> 

How would I detect that? Add a size (in bytes) parameter for the total 
source data?
