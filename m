Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC65A9DF7
	for <lists+dmaengine@lfdr.de>; Thu,  1 Sep 2022 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiIAR0A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Sep 2022 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiIARZx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Sep 2022 13:25:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE03A4A5;
        Thu,  1 Sep 2022 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662053148; x=1693589148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TmDhYbU8HgErUAJVzSa3J2R5NUU4fr8wdqMREO2cf5U=;
  b=PYyw19nOnLX4Eyi415vFEYxVfBxxGhPsvpI5+Fm5oBVa83x0GtX33CIG
   FdMWXqL1Y2zHTY47e/20P6Qa0AKxzI3aXHcSYfWgiNjyK9FyKVCc7+eN/
   67y/kkzD9zdre0HXwoPWYB+EeELhD27mRAoU5SwuKI0tghNbT1rXffYv4
   +xXOTlteWUGhq5JcD3eZ6llhPYRvcF8Ppf63Jv+E02QcjR7bKJTZbSiZO
   1FyFNo3b/BTV2KFXzNgl/Fm3MP+QwwvuE2jRvmWeVq2sDklCZimfq6iZ8
   nmNdEj8EeNE1FJB6EkmpMl9oU1w9DdUty/lFxPNkTWFdBLbPt1xt5Wn9B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278796633"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="278796633"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:25:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="612589961"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.165.86]) ([10.209.165.86])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:25:47 -0700
Message-ID: <8bced9df-bf93-d2c6-bb7c-8dc2a6aaea6f@intel.com>
Date:   Thu, 1 Sep 2022 10:25:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v5 0/7] dmaengine: Support polling for out of order
 completions
Content-Language: en-US
To:     Ben Walker <benjamin.walker@intel.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220829203537.30676-1-benjamin.walker@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/29/2022 1:35 PM, Ben Walker wrote:
> This series adds support for polling async transactions for completion
> even if interrupts are disabled and transactions can complete out of
> order.
>
> Prior to this series, dma_cookie_t was a monotonically increasing integer and
> cookies could be compared to one another to determine if earlier operations had
> completed (up until the cookie wraps around, then it would break). Now, cookies
> are treated as opaque handles. The series also does some API clean up and
> documents how dma_cookie_t should behave.
>
> This closes out by adding support for .device_tx_status() to the idxd
> driver and then reverting the DMA_OUT_OF_ORDER patch that previously
> allowed idxd to opt-out of support for polling, which I think is a nice
> overall simplification to the dmaengine API.
>
> Changes since version 4:
>   - Rebased
>   - Removed updates to the various drivers that call dma_async_is_tx_complete.
>     These clean ups will be spun off into a separate patch series since they need
>     acks from other maintainers.
>
> Changes since version 3:
>   - Fixed Message-Id in emails. Sorry they were all stripped! Won't
>     happen again.
>
> Changes since version 2:
>   - None. Rebased as requested without conflict.
>
> Changes since version 1:
>   - Broke up the change to remove dma_async_is_tx_complete into a single
>     patch for each driver
>   - Renamed dma_async_is_tx_complete to dmaengine_async_is_tx_complete.
>
> Ben Walker (7):
>    dmaengine: Remove dma_async_is_complete from client API
>    dmaengine: Move dma_set_tx_state to the provider API header
>    dmaengine: Add dmaengine_async_is_tx_complete
>    dmaengine: Add provider documentation on cookie assignment
>    dmaengine: idxd: idxd_desc.id is now a u16
>    dmaengine: idxd: Support device_tx_status
>    dmaengine: Revert "cookie bypass for out of order completion"
>
>   Documentation/driver-api/dmaengine/client.rst | 24 ++----
>   .../driver-api/dmaengine/provider.rst         | 64 ++++++++------
>   drivers/dma/dmaengine.c                       |  2 +-
>   drivers/dma/dmaengine.h                       | 21 ++++-
>   drivers/dma/dmatest.c                         | 14 +--
>   drivers/dma/idxd/device.c                     |  1 +
>   drivers/dma/idxd/dma.c                        | 86 ++++++++++++++++++-
>   drivers/dma/idxd/idxd.h                       |  3 +-
>   include/linux/dmaengine.h                     | 43 +++-------
>   9 files changed, 164 insertions(+), 94 deletions(-)
Besides the stray white space, Reviewed-by: Dave Jiang 
<dave.jiang@gmail.com>
