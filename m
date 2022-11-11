Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638CA625DF7
	for <lists+dmaengine@lfdr.de>; Fri, 11 Nov 2022 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiKKPLV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Nov 2022 10:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiKKPKq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Nov 2022 10:10:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648297BE51;
        Fri, 11 Nov 2022 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668179349; x=1699715349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZB6JYZNEQiujRYOAO+WFXvD9hep/TYyArLu5LIX0BKY=;
  b=CIhct/tyqUi5onA7RD85sGxeDsc6fnlG0wPkNdqWOwTnyMOQK3wEfUgY
   df+V97q9cT6dBgZVQM4S+jZkmw9+WLyyk4orhC/qQJUIUkQ8o8DFY90lG
   +ilEFrZ8OlNSymt3Q8DJGwVzciKVKHzUrdAmZfU2Q23eRBEdOPBAZ1YzE
   U9hY6aPy4Zwr0g7u2j/jUbu0/cHDOMqsSBXYWREhGNjnmWYCAExcvbj/7
   ez9deSacWg79MPPE6hKvpD/49ioAZJviaRZhA9APEHF+/m5IhwIps+x+g
   qg+Vpfn9+d5cqE4BYAHuQg7uL5G4lY435OR1XKM5v1rlQLDswi0ZIKQrT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="310322455"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="310322455"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 07:09:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="780204318"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="780204318"
Received: from ajayitem-mobl1.amr.corp.intel.com (HELO [10.212.52.53]) ([10.212.52.53])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 07:09:02 -0800
Message-ID: <7198b11e-e9e3-6cbe-e2e8-dce3eb998f7e@intel.com>
Date:   Fri, 11 Nov 2022 08:09:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] dmaengine: idxd: Fix crc_val field for completion record
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Nirav N Shah <nirav.n.shah@intel.com>
References: <20221111012715.2031481-1-fenghua.yu@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221111012715.2031481-1-fenghua.yu@intel.com>
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



On 11/10/2022 5:27 PM, Fenghua Yu wrote:
> The crc_val in the completion record should be 64 bits and not 32 bits.
> 
> Fixes: 4ac823e9cd85 ("dmaengine: idxd: fix delta_rec and crc size field for completion record")
> 
> Reported-by: Nirav N Shah <nirav.n.shah@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   include/uapi/linux/idxd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
> index 61ee43823622..09947ae61663 100644
> --- a/include/uapi/linux/idxd.h
> +++ b/include/uapi/linux/idxd.h
> @@ -329,7 +329,7 @@ struct dsa_completion_record {
>   		};
>   
>   		uint32_t	delta_rec_size;
> -		uint32_t	crc_val;
> +		uint64_t	crc_val;
>   
>   		/* DIF check & strip */
>   		struct {
