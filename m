Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2759557CAAC
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiGUMdZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMdY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 08:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE937644C;
        Thu, 21 Jul 2022 05:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC0C061DB3;
        Thu, 21 Jul 2022 12:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5876C3411E;
        Thu, 21 Jul 2022 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658406803;
        bh=U3HKY3eo89n9BqlckvyAr4J4M8kysFY/9cojjm7aybE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDSxEZN6oB3CajAVy0FTltBjBZFUGTEYORl4FJqaVV0G3Q2E/2voIhbAl9AhWNFcD
         ZTnXFO7wNvbQctOSuoXFXSfMv9hbHKvCaWzEmmBUz0QLISbLKSsVRmkx7Ru6IuGcsI
         CpruinQxCT7K3xTAy5fczW/d5O424qUFqxmduLwDIMf7q7WP73w48KDJKGpBE1NnN7
         1bUdOTkgWteafXFGvZZj7mBZh0tPMOqK9E/FGVPZhg9WAIFxto4YlnyAvnVtg85AhY
         wVlnpqt1GP+Z1l2h0g3gFMK5UTcIi8RDPPhFlLyrS1drJENuJiuVKRkhuxc4m9LFi7
         7izLCanWwCbSw==
Date:   Thu, 21 Jul 2022 18:03:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH 2/3] dmaengine: dw-axi-dmac: do not print NULL LLI during
 error
Message-ID: <YtlHj2f9biaFEK+m@matsya>
References: <20220708170153.269991-1-ben.dooks@sifive.com>
 <20220708170153.269991-3-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708170153.269991-3-ben.dooks@sifive.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-22, 18:01, Ben Dooks wrote:
> During debugging we have seen an issue where axi_chan_dump_lli()
> is passed a NULL LLI pointer which ends up causing an OOPS due
> to trying to get fields from it. Simply print NULL LLI and exit
> to avoid this.

Applied, thanks

> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 75c537153e92..d6ef5f49f281 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1008,6 +1008,11 @@ static void axi_chan_dump_regs(struct axi_dma_chan *chan)
>  static void axi_chan_dump_lli(struct axi_dma_chan *chan,
>  			      struct axi_dma_hw_desc *desc)
>  {
> +	if (!desc->lli) {
> +		dev_err(dchan2dev(&chan->vc.chan), "NULL LLI\n");
> +		return;
> +	}
> +
>  	dev_err(dchan2dev(&chan->vc.chan),
>  		"SAR: 0x%llx DAR: 0x%llx LLP: 0x%llx BTS 0x%x CTL: 0x%x:%08x",
>  		le64_to_cpu(desc->lli->sar),
> -- 
> 2.35.1

-- 
~Vinod
