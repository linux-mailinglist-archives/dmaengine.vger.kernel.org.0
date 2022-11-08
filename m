Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC77F62192E
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 17:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiKHQOT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 11:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiKHQOS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 11:14:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193FF13CE0;
        Tue,  8 Nov 2022 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667924058; x=1699460058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+SalQDIftpGV1y96eUwtO7Aw99Xo9hl/udl63LYREOE=;
  b=LA6CCH7eVnXsSk3juolWP6c1uTnhq+EYBU4HNIuxPaFajiSiVGGQ7U/A
   PDIjDHded0FOkGwqJE3EoJ6q1WOIcpaq2kW6sJZrSeJHegNoIQSduaQ8+
   CIDr+S5NHWO2RnnRqiHcSpf7GID0lk8ykqJCQkVFChX6jmzcF7uvjN7FD
   MpubVnG8BEMLlYngs3vs8a8nNIvrqFXctRnrxeOXNarBz7z26cpn68h1F
   51Zz/GFigUA25PTNRtoGRti5srgvOoGuQmKlQ5Kq2iKXdsFWIyNFLghTy
   G3+/gIXfSjWYZF2hDgZ3EVL/t2ONSU6PESQETYLb4/K1RjymbF1V2W6Lp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291122765"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="291122765"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:13:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="630921892"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="630921892"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.98.44]) ([10.212.98.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:13:58 -0800
Message-ID: <b7527fc3-8750-69b8-40fa-214962ef50ed@intel.com>
Date:   Tue, 8 Nov 2022 08:13:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] dmaengine: idxd: Add descriptor definitions for 16
 bytes of pattern in memory fill operation
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20221108003944.2095567-1-fenghua.yu@intel.com>
 <20221108003944.2095567-2-fenghua.yu@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221108003944.2095567-2-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/7/2022 4:39 PM, Fenghua Yu wrote:
> The memory fill operation (0x04) can fill in memory with either 8 bytes
> or 16 bytes of pattern. To fill in memory with 16 bytes of pattern, the
> first 8 bytes are provided in pattern lower in bytes 16-23 and the next
> 8 bytes are in pattern upper in bytes 40-47 in the descriptor. Currently
> only 8 bytes of pattern is enabled.
> 
> Add descriptor definitions for pattern lower and pattern upper so that
> user can use 16 bytes of pattern to fill memory.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   include/uapi/linux/idxd.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
> index 095299c75828..04a2f6411820 100644
> --- a/include/uapi/linux/idxd.h
> +++ b/include/uapi/linux/idxd.h
> @@ -179,6 +179,7 @@ struct dsa_hw_desc {
>   		uint64_t	rdback_addr;
>   		uint64_t	pattern;
>   		uint64_t	desc_list_addr;
> +		uint64_t	pattern_lower;
>   	};
>   	union {
>   		uint64_t	dst_addr;
> @@ -243,6 +244,11 @@ struct dsa_hw_desc {
>   			uint16_t	dest_app_tag_seed;
>   		};
>   
> +		/* Fill */
> +		struct {

I don't think the anon struct is needed here. If there are others, that 
can be added later with the next patch that needs it.

> +			uint64_t	pattern_upper;
> +		};
> +
>   		uint8_t		op_specific[24];
>   	};
>   } __attribute__((packed));
