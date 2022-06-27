Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EFF55CD72
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiF0Fu5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiF0Fup (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 01:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6711A5FA9;
        Sun, 26 Jun 2022 22:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBFAB6125A;
        Mon, 27 Jun 2022 05:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1A2C341C8;
        Mon, 27 Jun 2022 05:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656309021;
        bh=viTgpc0ZXjhdDBzCZ8VzjBVCUhW3/DRBr454jT9Y9SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdcFSFZIQCIYZhXRmGp4FgqzQinaNm3I9bYxlmml0qfnWx8uCridG4BL8NQV+tfUb
         Sxh0QHvhryaoOPMVsOyP0ZJfgHQwQj3pQQxw8paw7ijrsFyG2Bc3DB739U+eAyeFIw
         NrMZZhBl+KTSd4xWxeTRHgorAOg2qU9ZkQZPdC84wYe+xIV//7V8lHDXZ6y5pBAyrB
         pg8l2ubcBZJT2irqF1X3+nMhL74fkJFRt6URZeRhEmiKH4Y+GMaIkq49exTGxo4r9M
         TGdT3s4y3ZO235Upxv2em/nCkzvNBMBMG3XmiXuIiyX4CklO0kCdZYtlb4AXvBxsCO
         AgupdcdKlc+xQ==
Date:   Mon, 27 Jun 2022 11:20:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] Documentation: Add debugfs doc for hisi_dma
Message-ID: <YrlFFm+/dgC53JJH@matsya>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220625074422.3479591-8-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625074422.3479591-8-haijie1@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-22, 15:44, Jie Hai wrote:
> Add debugfs descriptions for HiSilicon DMA driver.
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  Documentation/ABI/testing/debugfs-hisi-dma | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-dma
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-dma b/Documentation/ABI/testing/debugfs-hisi-dma
> new file mode 100644
> index 000000000000..162c97945748
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hisi-dma

debugfs is not an ABI so no need to document this, so pls drop this

> @@ -0,0 +1,9 @@
> +What:           /sys/kernel/debug/hisi_dma/<bdf>/regs
> +Date:           Mar 2022
> +Contact:        dmaengine@vger.kernel.org
> +Description:    Dump the debug registers from the hisi dma.
> +
> +What:           /sys/kernel/debug/hisi_dma/<bdf>/channel[id]/regs
> +Date:           Mar 2022
> +Contact:        dmaengine@vger.kernel.org
> +Description:    Dump the channel related debug registers from the hisi dma.
> -- 
> 2.33.0

-- 
~Vinod
