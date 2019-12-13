Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4102D11ED87
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2019 23:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLMWHa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Dec 2019 17:07:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:6679 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLMWHa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 13 Dec 2019 17:07:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 14:06:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="221003419"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2019 14:06:50 -0800
Subject: Re: [PATCH RFC v2 04/14] mm: create common code from request
 allocation based from blk-mq code
To:     Andrew Morton <akpm@linux-foundation.org>, axboe@kernel.dk
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, hpa@zytor.com
References: <157617487798.42350.4471714981643413895.stgit@djiang5-desk3.ch.intel.com>
 <157617507410.42350.16156693139630931510.stgit@djiang5-desk3.ch.intel.com>
 <20191212164303.7fb6e91c20ffe125f87bda57@linux-foundation.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <87c977f7-1c4d-a21d-8b7b-2d2b8fb317bb@intel.com>
Date:   Fri, 13 Dec 2019 15:06:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212164303.7fb6e91c20ffe125f87bda57@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/12/19 5:43 PM, Andrew Morton wrote:
> On Thu, 12 Dec 2019 11:24:34 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Move the allocation of requests from compound pages to a common function
>> to allow usages by other callers.
> 
> What other callers are expected?

I'm introducing usage in the dmaengine subsystem. So it will be block 
and dmaengine subsystem so far.

> 
>> Since the routine has more to do with
>> memory allocation and management, it is moved to be exported by the
>> mempool.h and be part of mm subsystem.
>>
> 
> Hm, this move doesn't seem to fit very well.  But perhaps it's close
> enough.

I'm open to suggestions.

> 
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -42,7 +42,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>>   			   mm_init.o mmu_context.o percpu.o slab_common.o \
>>   			   compaction.o vmacache.o \
>>   			   interval_tree.o list_lru.o workingset.o \
>> -			   debug.o gup.o $(mmu-y)
>> +			   debug.o gup.o request_alloc.o $(mmu-y)
> 
> Now there's a regression.  We're adding a bunch of unused code to a
> CONFIG_BLOCK=n kernel.

I will introduce a KCONFIG value and have block and dmaegine select it 
to build this new code in when needed.

> 
>>
>> ...
>>
>> +void request_from_pages_free(struct list_head *page_list)
>>
>> ...
>>
>> +int request_from_pages_alloc(void *ctx, unsigned int depth, size_t rq_size,
>> +			     struct list_head *page_list, int max_order,
>> +			     int node,
>> +			     void (*assign)(void *ctx, void *req, int idx))
> 
> I find these function names hard to understand.  Are they well chosen?

The names could probably be better. Maybe
context_alloc_from_pages() and context_free_from_pages()?

So the background of this was I saw a block of code in block-mq that I 
can utilize in the new dmanegine request allocation. The code block is 
for mq to allocate pre-allocate requests from pages. I contacted Jens 
and he was ok with moving it to a common location out of blk-mq code. 
Maybe the name request is too specific and for a "general" allocator 
helper does not make sense.

> 
> Some documentation would help.  These are global, exported-to-modules
> API functions and they really should be fully documented.

Yes I will add more comments in regard to this function.

Jens, since you are the original write of this code, do you mind 
providing some commentary as to some of the quirks of this code block? I 
can do my best to try to explain it but you probably know the the code 
much better than me. Thanks!

> 
>> +{
>> +	size_t left;
>> +	unsigned int i, j, entries_per_page;
>> +
>> +	left = rq_size * depth;
>> +
>> +	for (i = 0; i < depth; ) {
> 
> "depth" of what?
> 
>> +		int this_order = max_order;
>> +		struct page *page;
>> +		int to_do;
>> +		void *p;
>> +
>> +		while (this_order && left < order_to_size(this_order - 1))
>> +			this_order--;
>> +
>> +		do {
>> +			page = alloc_pages_node(node,
>> +						GFP_NOIO | __GFP_NOWARN |
>> +						__GFP_NORETRY | __GFP_ZERO,
>> +						this_order);
>> +			if (page)
>> +				break;
>> +			if (!this_order--)
>> +				break;
>> +			if (order_to_size(this_order) < rq_size)
>> +				break;
>> +		} while (1);
> 
> What the heck is all the above trying to do?  Some explanatory comments
> are needed, methinks.
> 
>> +		if (!page)
>> +			goto fail;
>> +
>> +		page->private = this_order;
>> +		list_add_tail(&page->lru, page_list);
>> +
>> +		p = page_address(page);
>> +		/*
>> +		 * Allow kmemleak to scan these pages as they contain pointers
>> +		 * to additional allocations like via ops->init_request().
>> +		 */
>> +		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
>> +		entries_per_page = order_to_size(this_order) / rq_size;
>> +		to_do = min(entries_per_page, depth - i);
>> +		left -= to_do * rq_size;
>> +		for (j = 0; j < to_do; j++) {
>> +			assign((void *)ctx, p, i);
>> +			p += rq_size;
>> +			i++;
>> +		}
>> +	}
>> +
>> +	return i;
>> +
>> +fail:
>> +	request_from_pages_free(page_list);
>> +	return -ENOMEM;
>> +}
>> +EXPORT_SYMBOL_GPL(request_from_pages_alloc);
