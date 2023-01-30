Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69257681759
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjA3RM5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 12:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbjA3RM4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 12:12:56 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6B52707;
        Mon, 30 Jan 2023 09:12:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id w11so19991577lfu.11;
        Mon, 30 Jan 2023 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D62GER4Lk6Sql93WCwNqYaonlXbgkp6yM7h5Sm5ivzc=;
        b=dD6YY2hoYZXgZFA69hvlbDckIzFQENNCUET9v6fVVgLpM+auFCSfwstd/cMkN/3Cmw
         yaTGxIvAY3t2xyS4jGDyZDU011UqpcPjn61DjJ+QZN0WH5maL7RkS2A9JSBpaOJlK+z5
         8GAQFtn+oJ9izwfge1uolnfbgFe4Pw9dlDselXZ6XpFNmc9w3wJ7BSN9K9aY2hBqR27k
         BZpoD1ZSqBppfUc8wyJhKk+KTzFaM50I0NZ9sX8jZtX33tNc0fRUpLI82s/Zbn7BMVea
         rD/0UKIeevihrw3LTH9EGX1/ODY9opLKh3QThpUpDwfpAn2vSQvMASQVBbNKzN4jXj/9
         a7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D62GER4Lk6Sql93WCwNqYaonlXbgkp6yM7h5Sm5ivzc=;
        b=AawQd7+51GB8EjSkVd/kXw4QYQOIlOZBjzImUl03O54/6FJY58SFpiOdBrAD7KRIjL
         2RlEx8wbKW/xde2mAEWM4sWDx6xZ9X1W42fIYK2S15hpd2AupDhnwuYqCPkSM/6hsNYJ
         nNP2tDYlVfAwfbg/IBCwIm0FVpomNpmihvGuKdyUKeZtg8XT/TvNBX4D60WkfW/c3cAV
         JHnfCe/oOH8CXCIopII9G8ijFlLA+U7MxOkC8pg1Rct7Cku5j3CDak3N1ZxggnZTbVHE
         4zITNNzZ/1q+frG34GBb7mG4+z3lMnasvjjEAH5h67StEXhG0SSHaJLOqDOPoULRPn8T
         lAqg==
X-Gm-Message-State: AFqh2koRwfE7uHQV0mb9AnGKbrksESz8uJejIn4NO3ZNFfmHNjctZ8gk
        eroBrsytWymSY7BOtcDk7ec=
X-Google-Smtp-Source: AMrXdXtpdn8f/inA6CvYrxcbGozVQh80VWze9s3Rdz6Ejq4m6LU/z0K0+D19wveMU9GQMMukz1r/eg==
X-Received: by 2002:a05:6512:1286:b0:4d5:82bc:549e with SMTP id u6-20020a056512128600b004d582bc549emr15977781lfs.60.1675098772590;
        Mon, 30 Jan 2023 09:12:52 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id k23-20020a192d17000000b004cb3fbc7925sm879490lfj.77.2023.01.30.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:12:52 -0800 (PST)
Date:   Mon, 30 Jan 2023 20:12:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: reduce stack usage after debugfs
 rework
Message-ID: <20230130171250.5ve3clop4tjv73ri@mobilestation>
References: <20230130130826.596171-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130130826.596171-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd

On Mon, Jan 30, 2023 at 02:08:10PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the dw_edma_debugfs_entry arrays are no longer compile-time
> constant, they take up space on the stack, which exceeds the
> warning limit after inlining:
> 
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
> void dw_edma_v0_debugfs_on(struct dw_edma *dw)
> 

> Work around this by marking the functions with the largest arrays
> as 'noinline_for_stack' to make them not use up space on the same
> stack together.

You mean the same stack !frame!, right?

> 
> Fixes: 5c0373eafd83 ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 7be23c26ac88..9dfcbbdfb27b 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -116,7 +116,8 @@ static void dw_edma_debugfs_create_x32(struct dw_edma *dw,
>  	}
>  }
>  

> -static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
> +static noinline_for_stack void
> +dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
>  				    u16 ch, struct dentry *dent)

This doesn't seem like required. Does it? This method is called from
two functions: dw_edma_debugfs_regs_wr() and dw_edma_debugfs_regs_rd()
and if I am not mistaken will unlikely be inlined. Even if compiler will
inline it the stack memory consumption won't change much since the
functions aren't called from each other.

>  {
>  	struct dw_edma_debugfs_entry debugfs_regs[] = {
> @@ -136,9 +137,10 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
>  	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
>  }
>  
> -static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> +static noinline_for_stack void
> +dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  {

> -	static const struct dw_edma_debugfs_entry debugfs_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
>  		WR_REGISTER(dw, engine_en),
>  		WR_REGISTER(dw, doorbell),
> @@ -159,7 +161,7 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  		WR_REGISTER(dw, ch67_imwr_data),
>  		WR_REGISTER(dw, linked_list_err_en),
>  	};
> -	static const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {

I am confused how come these locals've turned to be static const?
Neither my patches nor the Bjorn repo provide such changes:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/dma/dw-edma/dw-edma-v0-debugfs.c?h=next#n139
they were supposed to be just const.

What repo is this patch based on?

>  		/* eDMA channel context grouping */
>  		WR_REGISTER_UNROLL(dw, engine_chgroup),
>  		WR_REGISTER_UNROLL(dw, engine_hshake_cnt.lsb),
> @@ -197,7 +199,8 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>  	}
>  }
>  

> -static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
> +static noinline void

noinline_for_stack, right?

-Serge(y)

> +dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
> -- 
> 2.39.0
> 
