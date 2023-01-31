Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA46824C4
	for <lists+dmaengine@lfdr.de>; Tue, 31 Jan 2023 07:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAaGpQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Jan 2023 01:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjAaGpQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 Jan 2023 01:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01C40BF9;
        Mon, 30 Jan 2023 22:44:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FA96141C;
        Tue, 31 Jan 2023 06:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF8DC433EF;
        Tue, 31 Jan 2023 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675147365;
        bh=7brZNx5qtKiUnkOW/MJ4BAj/ITNdtNtLA2ye7w6FtsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCY40BsNzVoNShpFsgRdXUv91QX3SrahBKzH+Mi/J2THbh7IVzxtKkyNJgpZGxwlm
         QKVnHVlcBvoQMStlQBRzK+vn58LP/pVAFnfHkEzmZjWRGAP9LUIGoievxClbTnDpbI
         faT7aaRHxmBywAjkp8XJB6HWPWyZHn7LTE9csfZElA0rFNKjHUfTpI99hF8nCLuHpQ
         1yqGsZdnfUBAzmhWPC2IKpzF8o8Nj39MpQ1WrxFKehZKNmfBE0L3Gob4bj0pjDoXDb
         t5e/vy8GpkoGYOMjme2YJuwoYVjek9nJcDxw7uOW0vYQ+/Hdt46NvnpKVZ2LgcJKCQ
         vMpZ8oOfe6A7w==
Date:   Tue, 31 Jan 2023 12:12:37 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: dw-edma: reduce stack usage after
 debugfs rework
Message-ID: <20230131064237.GA5548@thinkpad>
References: <20230130185101.2883245-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130185101.2883245-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 30, 2023 at 07:50:42PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the dw_edma_debugfs_entry arrays are no longer compile-time

This sentence doesn't look complete to me.

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

Small style comment below, with that:

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
> v2: rebase on top of dmaengine tree
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

For consistency, the function arguments could be wrapped:

static noinline_for_stack void dw_edma_debugfs_regs_wr(struct dw_edma *dw,
						       struct dentry *dent)

I could see that with the addition of "noinline_for_stack", the arguments are
shifted towards the end of the line. But this style matches rest of the
functions in this file.

Thanks,
Mani

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
> 

-- 
மணிவண்ணன் சதாசிவம்
