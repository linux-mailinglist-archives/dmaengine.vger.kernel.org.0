Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07E36825EE
	for <lists+dmaengine@lfdr.de>; Tue, 31 Jan 2023 08:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjAaHyj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Jan 2023 02:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjAaHyh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 Jan 2023 02:54:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E8A30281;
        Mon, 30 Jan 2023 23:54:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f34so22906099lfv.10;
        Mon, 30 Jan 2023 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3UB2wsc83MArKTJGJW3EePeDr6MsyyvFxES+baeN/4=;
        b=ZGGXLy5w9WeMvHwSr7+C0rrfvyoY3QKCCBHUbvvQ7gUI70sXxH/LrbYTSpkY033H6f
         +EECuFa8i5U2gtz2SLa2wYizhq6kSGdb27XL/GkTPtm8dVg2ufcLrZHMBcy+BPNmnzMV
         jhg4x+dAUuHUzDLYdJh0V/KSWrKVSXKfHJ/yhI+ik0crgBmMui9WWSEbg7aa5CPwYdyY
         EBj2me25LQSaCqtYpJmEA7YP1N3B8TAqzx3MsluKB9VLdSK9cvx8ijZ8z60aReZsNF9F
         wBxtgpMcug7+X/5km06fqkLbNcJ+KXA3cFH2t8iK4Jwwp6176izBYgIbiRgr+deNM/FY
         IGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3UB2wsc83MArKTJGJW3EePeDr6MsyyvFxES+baeN/4=;
        b=xkREAoS2EgI/tCLkTMN59j6Ezq6FCSwpKsiYvucik08/qNc83lvmWz3gv2ZiIBuCoG
         e4zsL2DhKfWR+XZd2/OzBho0S10kJbSNuRkWCc4jmEtwWk5RlYVt8C5m8wvOSfp4F7EP
         YOeZrvNYt5a03GRKRp63JWSwR+qoTtBRx8js7M/kAR4xswCzuj5614VnKmmnB/E0hX0p
         /pfkKfneuT3cWXAarmgUsq8HCqpMff2qaLnPM5AAFGOy9kdbCUV1heo/Iu1U17TJe2lU
         P8cuAOoxJ1HqC7tG0AcfT1nYgD7aOU5cYeCIepiL5E2f7tnTtsFuUgA5a/G1Ux0pMTV/
         rLAA==
X-Gm-Message-State: AO0yUKVPZlRe2zm9Z4VO7PTUjl9M+xnNGV7ijblHYclAaCxvtH786bgX
        aeXHfset7JYOvfktxELD78b66q8oF+A=
X-Google-Smtp-Source: AK7set/LcL+urIEbKZ7/pp2YLvqDSc3QO0Bgy+Deb4ae7zWLxkbQ/ZaKA/92eAEqKE9kV6+HPmx2Jg==
X-Received: by 2002:a05:6512:2212:b0:4d8:7f17:d0e9 with SMTP id h18-20020a056512221200b004d87f17d0e9mr87607lfu.14.1675151673602;
        Mon, 30 Jan 2023 23:54:33 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id d6-20020ac244c6000000b004d6d0261a5bsm925209lfm.206.2023.01.30.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 23:54:33 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:54:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: dw-edma: reduce stack usage after
 debugfs rework
Message-ID: <20230131075430.ecssjouom2kc5apx@mobilestation>
References: <20230130185101.2883245-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130185101.2883245-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 30, 2023 at 07:50:42PM +0100, Arnd Bergmann wrote:
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

Great! Thanks for the patch.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

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
