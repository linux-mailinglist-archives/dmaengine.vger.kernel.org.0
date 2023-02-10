Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0066B691A5F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 09:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjBJIwj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 03:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjBJIwh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 03:52:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684CF86604;
        Fri, 10 Feb 2023 00:52:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F368BB819FF;
        Fri, 10 Feb 2023 08:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC1CC4339C;
        Fri, 10 Feb 2023 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676019153;
        bh=b9gMs1487OIYHQi0ARcJ5R4NCZS2UW0MwzlcA2/gRik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNFHb51aeeQH+PWL5x586wmWyqkJ9b0uz3FDWekQZ8wXfoj9ngsgEwztZc8R8B2Am
         eze/AcRFLucFA8jzzgSxlqZlK9Q6OeLgngQXLtSpl43sUTXTc6qYN82UdmSggMgDeU
         mmzKNZzEfi6MHYuNYGKguJ6cpdX/TXPuLuLB++TYA2U5cfT2oSPhAMw7F009NXG0GF
         F0gE4dauC1uzfBQlT3OUOq9DEYiJqKA5RLEnvUbAVRJjOBfllZy+dOnbpFuPO3569g
         08TyIT0aOrly/x/byQnUR+A0K2WWc2BOfcd9moxZ0Q2rauGPbKB0Bf1AEC+fOP6J5U
         Q9jgWxd0YPMdg==
Date:   Fri, 10 Feb 2023 14:22:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: dw-edma: reduce stack usage after
 debugfs rework
Message-ID: <Y+YFzDm4XOnzZTpM@matsya>
References: <20230130185101.2883245-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130185101.2883245-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-01-23, 19:50, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the dw_edma_debugfs_entry arrays are no longer compile-time
> constant, they take up space on the stack, which exceeds the warning
> limit after inlining:
> 
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
> void dw_edma_v0_debugfs_on(struct dw_edma *dw)
> 
> Work around this by preventing dw_edma_debugfs_regs_{wr,rd} from both
> being inlined together, which cuts the stack frame size in half and
> makes it fit below the warning limit.
> 
> Fixes: 5c0373eafd83 ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rebase on top of dmaengine tree

I dont have 5c0373eafd83 in my tree, I guess that went thru PCI tree, so
I am going to defer this after merge window

> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 42380bf64a70..6542060bd01a 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -136,7 +136,8 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
>  	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
>  }
>  
> -static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> +static noinline_for_stack void
> +dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
> @@ -197,7 +198,8 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  	}
>  }
>  
> -static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
> +static noinline_for_stack void
> +dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
> -- 
> 2.39.0

-- 
~Vinod
