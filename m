Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFADB5A02B5
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiHXU3J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 16:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiHXU3I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 16:29:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBDB6AA2E;
        Wed, 24 Aug 2022 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661372948; x=1692908948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vCFPdZPhrFOyAb/BVzSWzMNxWwy6MKuSUQZA094hqP8=;
  b=bNNvrlHokcKK5x5S7AmTiukKdts+rcdDTdOqviSZT5y4YpbqW67HeY1N
   UjtjFx2kZZEB3rQ6XTkXc13Bxna3DOkwKfpljRmDdlr60Kh44K5X6sWqg
   Qrflb5WlpjRoiAfxR70cJ2K49gKazVpPZ2BVvYdy4eIhziKWoY/J/ywmZ
   pFPNIRli6we5hLNt2ly6kBLKGi45si3ACNUs+wuTUZWzgIpnbKW2IzNGZ
   I5TgHlYf1Gdw5O/nmRX5bwaVrj1ykUZn4e/Qtlv4IrcPSmEmwNSyRsn3R
   k0U+5/Pz4Gtnd4Nu2WXwRhh93dnnyVvtWfbjp3ZNPRWdOZQVXxQqLF3eh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355794799"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="355794799"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 13:29:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678187365"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.178.56]) ([10.213.178.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 13:29:04 -0700
Message-ID: <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
Date:   Wed, 24 Aug 2022 13:29:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220824192913.2425634-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/24/2022 12:29 PM, Jerry Snitselaar wrote:
> For a software reset idxd_device_reinit() is called, which will walk
> the device workqueues to see which ones were enabled, and try to
> re-enable them. It keys off wq->state being iDXD_WQ_ENABLED, but the
> first thing idxd_enable_wq() will do is see that the state of the
> workqueue is enabled, and return 0 instead of attempting to issue
> a command to enable the workqueue.
>
> So once a workqueue is found that needs to be re-enabled,
> set the state to disabled prior to calling idxd_enable_wq().
> This would accurately reflect the state if the enable fails
> as well.
>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>   drivers/dma/idxd/irq.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 743ead5ebc57..723eeb5328d6 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -52,6 +52,7 @@ static void idxd_device_reinit(struct work_struct *work)
>   		struct idxd_wq *wq = idxd->wqs[i];
>   
>   		if (wq->state == IDXD_WQ_ENABLED) {
> +			wq->state = IDXD_WQ_DISABLED;
Might be better off to insert this line in idxd_wq_disable_cleanup(). I 
think that should put it in sane state.
>   			rc = idxd_wq_enable(wq);
>   			if (rc < 0) {
>   				dev_warn(dev, "Unable to re-enable wq %s\n",
