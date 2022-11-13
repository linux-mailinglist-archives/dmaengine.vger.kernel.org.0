Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3B6272E9
	for <lists+dmaengine@lfdr.de>; Sun, 13 Nov 2022 23:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiKMW2P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Nov 2022 17:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKMW2O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Nov 2022 17:28:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8E163AA;
        Sun, 13 Nov 2022 14:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5CD860BEF;
        Sun, 13 Nov 2022 22:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783A3C433D6;
        Sun, 13 Nov 2022 22:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668378493;
        bh=7jgz+wTHdR6XWg7YJswtTBfD3CPiL4NILZnLTMhGD68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuxkEyUOtgy/DOUiEzkGNzSVEcrtpI1vVTBatn7MN1sUXHejMAK6wHxroO7atR6Oa
         coEVzJ0efZzxX41AiwC8JLhkH2e/ZyVRlJ5NmobAd9a0hvKvgqd69bM5h5JGmzbSb3
         55e53s5BPOSDS8GAJbprl2PYP5jJ6qxRsQ0y4cNxujgGCMKwQKY/GrbBtbugFqKm9Z
         3VCTZxPt3m95YAgkqpSgXJSpqCDc+lhRl4uIP5y3UcZQRbvdd2oU4tzzxaCP98BRlG
         flOQmCi39q1pa89nH2oeY4+uraT29l+w2lKSZ1oLOxC+idnFoJ00s/JPRnoIDwi2Ju
         3IKmux5o4IRRw==
Date:   Mon, 14 Nov 2022 03:58:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Nirav N Shah <nirav.n.shah@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Fix crc_val field for completion record
Message-ID: <Y3FveOiymPb3fpWc@matsya>
References: <20221111012715.2031481-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111012715.2031481-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-11-22, 17:27, Fenghua Yu wrote:
> The crc_val in the completion record should be 64 bits and not 32 bits.
> 
> Fixes: 4ac823e9cd85 ("dmaengine: idxd: fix delta_rec and crc size field for completion record")
> 

Please no empty line after the fixes tag!

Applied after removing the empty line, thanks

> Reported-by: Nirav N Shah <nirav.n.shah@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  include/uapi/linux/idxd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
> index 61ee43823622..09947ae61663 100644
> --- a/include/uapi/linux/idxd.h
> +++ b/include/uapi/linux/idxd.h
> @@ -329,7 +329,7 @@ struct dsa_completion_record {
>  		};
>  
>  		uint32_t	delta_rec_size;
> -		uint32_t	crc_val;
> +		uint64_t	crc_val;
>  
>  		/* DIF check & strip */
>  		struct {
> -- 
> 2.32.0

-- 
~Vinod
