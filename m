Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD5A11DB38
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2019 01:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfLMAnF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Dec 2019 19:43:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731519AbfLMAnF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:05 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A794F21655;
        Fri, 13 Dec 2019 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576197784;
        bh=yEBoIw88FggbZ6XjmcnyG9MA49laclpbOvEXS7yvEvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qkjdHU0hvi2ydGohhuiIKDCARrVNQ26UA2BeURxOTdF8TMn+F6Wfi9N0vJSaM+ss6
         2AO1Npvmp4ou/1Oj9SxpTspQeM9gGiTzGzO3EMOn4NWqqpikn755x8ZI+8x3qN9Zly
         IawariT3DqY851GLiebMIcL2tPJLAGFFmGOKRAAs=
Date:   Thu, 12 Dec 2019 16:43:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        axboe@kernel.dk, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC v2 04/14] mm: create common code from request
 allocation based from blk-mq code
Message-Id: <20191212164303.7fb6e91c20ffe125f87bda57@linux-foundation.org>
In-Reply-To: <157617507410.42350.16156693139630931510.stgit@djiang5-desk3.ch.intel.com>
References: <157617487798.42350.4471714981643413895.stgit@djiang5-desk3.ch.intel.com>
        <157617507410.42350.16156693139630931510.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 12 Dec 2019 11:24:34 -0700 Dave Jiang <dave.jiang@intel.com> wrote:

> Move the allocation of requests from compound pages to a common function
> to allow usages by other callers.

What other callers are expected?

> Since the routine has more to do with
> memory allocation and management, it is moved to be exported by the
> mempool.h and be part of mm subsystem.
> 

Hm, this move doesn't seem to fit very well.  But perhaps it's close
enough.

> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -42,7 +42,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>  			   mm_init.o mmu_context.o percpu.o slab_common.o \
>  			   compaction.o vmacache.o \
>  			   interval_tree.o list_lru.o workingset.o \
> -			   debug.o gup.o $(mmu-y)
> +			   debug.o gup.o request_alloc.o $(mmu-y)

Now there's a regression.  We're adding a bunch of unused code to a
CONFIG_BLOCK=n kernel.

>
> ...
>
> +void request_from_pages_free(struct list_head *page_list)
>
> ...
>
> +int request_from_pages_alloc(void *ctx, unsigned int depth, size_t rq_size,
> +			     struct list_head *page_list, int max_order,
> +			     int node,
> +			     void (*assign)(void *ctx, void *req, int idx))

I find these function names hard to understand.  Are they well chosen?

Some documentation would help.  These are global, exported-to-modules
API functions and they really should be fully documented.

> +{
> +	size_t left;
> +	unsigned int i, j, entries_per_page;
> +
> +	left = rq_size * depth;
> +
> +	for (i = 0; i < depth; ) {

"depth" of what?

> +		int this_order = max_order;
> +		struct page *page;
> +		int to_do;
> +		void *p;
> +
> +		while (this_order && left < order_to_size(this_order - 1))
> +			this_order--;
> +
> +		do {
> +			page = alloc_pages_node(node,
> +						GFP_NOIO | __GFP_NOWARN |
> +						__GFP_NORETRY | __GFP_ZERO,
> +						this_order);
> +			if (page)
> +				break;
> +			if (!this_order--)
> +				break;
> +			if (order_to_size(this_order) < rq_size)
> +				break;
> +		} while (1);

What the heck is all the above trying to do?  Some explanatory comments
are needed, methinks.

> +		if (!page)
> +			goto fail;
> +
> +		page->private = this_order;
> +		list_add_tail(&page->lru, page_list);
> +
> +		p = page_address(page);
> +		/*
> +		 * Allow kmemleak to scan these pages as they contain pointers
> +		 * to additional allocations like via ops->init_request().
> +		 */
> +		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
> +		entries_per_page = order_to_size(this_order) / rq_size;
> +		to_do = min(entries_per_page, depth - i);
> +		left -= to_do * rq_size;
> +		for (j = 0; j < to_do; j++) {
> +			assign((void *)ctx, p, i);
> +			p += rq_size;
> +			i++;
> +		}
> +	}
> +
> +	return i;
> +
> +fail:
> +	request_from_pages_free(page_list);
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL_GPL(request_from_pages_alloc);
