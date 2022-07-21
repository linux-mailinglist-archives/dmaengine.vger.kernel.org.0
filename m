Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD557CAC6
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGUMla (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 08:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiGUMl3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 08:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A342F036;
        Thu, 21 Jul 2022 05:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4ADC61DB9;
        Thu, 21 Jul 2022 12:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF54C3411E;
        Thu, 21 Jul 2022 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658407287;
        bh=yKWs4PgNGipCK9ntDwu3bnF939W2b6qem2fqmc2yDWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MG+8X9ku8nIqtDQ9M0LU52LgiGj79yq7t0AIvebKu1H3wTjVfxHlfVAlODNbPh8Vp
         SMCGCOVhpZIJakJCBIQDxQY5sQSYW1HL2ViwbxZVuFelT5ZuQkLHe7Vpsmazc/Ehkt
         SPZRzAAvNXSFLPFcQoqIxWWB5HcKXfQOpDGhfV83YwarU0xsfKHD9nhHjyh6pTX7O3
         QxuqUDfD0Ngo06enzO4xUcFAq1XBvmjnxWbd2TxV9DcqXJqV5rOGT8O3bjuEKxXxbZ
         YDOw0ktN6tvL5Ah2VKsVSJnhps7BITrI8prAYMgXFN83knTPjLTlCfDnxQb0Ujwc4n
         v8NMTsnHNhVjA==
Date:   Thu, 21 Jul 2022 18:11:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Tony Zhu <tony.zhu@intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Zhang <li4.zhang@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Correct IAX operation code names
Message-ID: <YtlJcwuIjw8v9wA0@matsya>
References: <20220707002052.1546361-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707002052.1546361-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-07-22, 17:20, Fenghua Yu wrote:
> Some IAX operation code nomenclatures are misleading or don't match with
> others:
> 
> 1. Operation code 0x4c is Zero Compress 32. IAX_OPCODE_DECOMP_32 is a
>    misleading name. Change it to IAX_OPCODE_ZERO_COMP_32.
> 2. Operation code 0x4d is Zero Compress 16. IAX_OPCODE_DECOMP_16 is a
>    misleading name. Change it to IAX_OPCODE_ZERO_COMP_16.
> 3. IAX_OPCDE_FIND_UNIQUE is corrected to match with other nomenclatures.

Applied, thanks

> 
> Co-developed-by: Li Zhang <li4.zhang@intel.com>
> Signed-off-by: Li Zhang <li4.zhang@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  include/uapi/linux/idxd.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
> index bce7c43657d5..095299c75828 100644
> --- a/include/uapi/linux/idxd.h
> +++ b/include/uapi/linux/idxd.h
> @@ -89,14 +89,14 @@ enum iax_opcode {
>  	IAX_OPCODE_CRC64,
>  	IAX_OPCODE_ZERO_DECOMP_32 = 0x48,
>  	IAX_OPCODE_ZERO_DECOMP_16,
> -	IAX_OPCODE_DECOMP_32 = 0x4c,
> -	IAX_OPCODE_DECOMP_16,
> +	IAX_OPCODE_ZERO_COMP_32 = 0x4c,
> +	IAX_OPCODE_ZERO_COMP_16,
>  	IAX_OPCODE_SCAN = 0x50,
>  	IAX_OPCODE_SET_MEMBER,
>  	IAX_OPCODE_EXTRACT,
>  	IAX_OPCODE_SELECT,
>  	IAX_OPCODE_RLE_BURST,
> -	IAX_OPCDE_FIND_UNIQUE,
> +	IAX_OPCODE_FIND_UNIQUE,
>  	IAX_OPCODE_EXPAND,
>  };
>  
> -- 
> 2.32.0

-- 
~Vinod
