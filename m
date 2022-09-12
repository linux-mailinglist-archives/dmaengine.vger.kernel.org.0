Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC205B5D14
	for <lists+dmaengine@lfdr.de>; Mon, 12 Sep 2022 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiILP0f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Sep 2022 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiILP0e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Sep 2022 11:26:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8182713EB2
        for <dmaengine@vger.kernel.org>; Mon, 12 Sep 2022 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662996393; x=1694532393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QBu4L0OnyCS3R9BiE4M4O3g5J7oe/k8WLwVIVbN7/Gg=;
  b=G2ojRyvJxmXF8WFLjvfVgHlsLCt9/Kp4CBLnsl/yNU5JOvBcloVlhKfJ
   D8dFlUkNfjxYbgaKwxYHui1kkOIsznihHutJlXrat7P7Q9XfjNmQO62RM
   JCKqgQCkVd8+OMoHVA0NzvRtCVhDrtcEnuQQGy8CPqyPzHp3Ivr7X9M57
   N4ZPLNUre4W1SLupMjFX0AspOGYHMYgjtdQ2Kz70CCaWt2mwduYTWfPcD
   YVkh5Z6/avwiPFwQc1wrocT6zVJlwby1rDhcDvcGx14Lucv/gkFk+h+vN
   aU8SFaWp+fLDidp30URuzsTy1xlyvgwambisVs6itN10uAsQ/6lAEpeqf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="278284348"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="278284348"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 08:26:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705190391"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.48.79]) ([10.212.48.79])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 08:26:13 -0700
Message-ID: <a5e1de92-c3a3-50b5-5ebb-322aec19a612@intel.com>
Date:   Mon, 12 Sep 2022 08:26:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] dmaengine: ioat: remove unused declarations in dma.h
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, vkoul@kernel.org,
        vinod.koul@intel.com
Cc:     dmaengine@vger.kernel.org
References: <20220911091817.3214271-1-cuigaosheng1@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220911091817.3214271-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/11/2022 2:18 AM, Gaosheng Cui wrote:
> ioat_ring_alloc_order and ioat_ring_max_alloc_order have
> been removed since commit cd60cd96137f ("dmaengine: IOATDMA:
> Removing descriptor ring reshape"), so remove them.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks.

> ---
>   drivers/dma/ioat/dma.h | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 140cfe3782fb..35e06b382603 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -196,10 +196,8 @@ extern const struct sysfs_ops ioat_sysfs_ops;
>   extern struct ioat_sysfs_entry ioat_version_attr;
>   extern struct ioat_sysfs_entry ioat_cap_attr;
>   extern int ioat_pending_level;
> -extern int ioat_ring_alloc_order;
>   extern struct kobj_type ioat_ktype;
>   extern struct kmem_cache *ioat_cache;
> -extern int ioat_ring_max_alloc_order;
>   extern struct kmem_cache *ioat_sed_cache;
>   
>   static inline struct ioatdma_chan *to_ioat_chan(struct dma_chan *c)
