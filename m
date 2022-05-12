Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3952511D
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355856AbiELPTj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355561AbiELPTi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 11:19:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B661F8F39
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:19:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so5186808pjq.2
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DSt0xkJ+BW2PgCTCVUPVK/qLKLtbgi3m1rHHR642fm4=;
        b=i3BYAH9kJgWu4O5rmng8wQOsQPLB8eyOSGpTCE17cVEJz/2TND8VvQC3h9HuJfFuSs
         QKNhJC4hXCjhL24GDBkcUXU4/H89IY7N51fSlXbYJi54SZoM403WT0N4gJu9q74JvAwS
         ocjt1e5MA245o8Y9qsDYTFzSipom3/DZSa/1N4Ddy5Ww/3pC22OEAPJHjkmQ/b1Parzd
         e+G0tapfHAigdy9GOmu+1mXUf3Y535CbPnUrCP8VK8qNFMULPw91ynopnp3UCeXnHSC9
         J/K5tAj8MTSh42rqNbhXRxj1gCw37+ucxNm+SolhpPlq8OhOkoPLwiE+gzfmHMlUpCjJ
         YQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DSt0xkJ+BW2PgCTCVUPVK/qLKLtbgi3m1rHHR642fm4=;
        b=KzhpwIByrr9XZeOKIuFj86K4G0AbkB99G50+R0eG/dL+DfeQXz69GAIR9XD/pUmH0m
         rdnTgBiQ9J+hPeQzR21xCX5AFFEi39PQ2y6HdRSF1gX1G6KRogCUF8a7YZ3D4OZMZhJk
         t4FFVwDqbBt4ZG4vAx3/tUUei1ZI1cEwjcm0StXVmOBS+L/XEs86SbCn2B9Topd72Zei
         tXasTjK5cfnyGYKtGAZN8lGDA7uuAML+DE+RURtEwHxWAKTHBi3rzEMwe4xeO/JKMZvc
         CMleoHdP6PBWQ5XJr07ac6rp5LiNOcH4QNx340EdweBiGvQO+9VXFnJmHufTVf5OBqND
         45oA==
X-Gm-Message-State: AOAM533/CNj9NURMpjpn8uu7YkNXi351Ao81TvA7LuJlKbAUCL7GyRdo
        xNhSop9j+Uvsv6NH8CIPzB+I
X-Google-Smtp-Source: ABdhPJx7sA2WWhN2y3DDOWHQOaG352kV9vpBOJZqmyZC8YDV0+2wAKO6krRVber1+FIuS7ZBaDMXaQ==
X-Received: by 2002:a17:90b:4a42:b0:1dc:6bfa:bc40 with SMTP id lb2-20020a17090b4a4200b001dc6bfabc40mr68735pjb.215.1652368776204;
        Thu, 12 May 2022 08:19:36 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id n23-20020a17090a929700b001cd60246575sm2003553pjo.17.2022.05.12.08.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:19:33 -0700 (PDT)
Date:   Thu, 12 May 2022 20:49:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/26] dmaengine: dw-edma: Rename DebugFS dentry
 variables to 'dent'
Message-ID: <20220512151925.GL35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-16-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:50:53AM +0300, Serge Semin wrote:
> Since we are about to add the eDMA channels direction support to the
> debugfs module it will be confusing to have both the DebugFS directory and
> the channels direction short names used in the same code. As a preparation
> patch let's convert the DebugFS dentry 'dir' variables to having the
> 'dent' name so to prevent the confusion.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> ---
> 
> Changelog v2:
> - This is a new patch added in v2. (@Manivannan)
> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 46 ++++++++++++------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 78f15e4b07ac..7bb3363b40e4 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -96,7 +96,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
>  
>  static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
> -				       int nr_entries, struct dentry *dir)
> +				       int nr_entries, struct dentry *dent)
>  {
>  	struct dw_edma_debugfs_entry *entries;
>  	int i;
> @@ -109,13 +109,13 @@ static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
>  	for (i = 0; i < nr_entries; i++) {
>  		entries[i] = ini[i];
>  
> -		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> +		debugfs_create_file_unsafe(entries[i].name, 0444, dent,
>  					   &entries[i], &fops_x32);
>  	}
>  }
>  
>  static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
> -				    struct dentry *dir)
> +				    struct dentry *dent)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		REGISTER(ch_control1),
> @@ -131,10 +131,10 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
>  	int nr_entries;
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
> +	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dent);
>  }
>  
> -static void dw_edma_debugfs_regs_wr(struct dentry *dir)
> +static void dw_edma_debugfs_regs_wr(struct dentry *dent)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
> @@ -171,34 +171,34 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  		WR_REGISTER_UNROLL(ch6_pwr_en),
>  		WR_REGISTER_UNROLL(ch7_pwr_en),
>  	};
> -	struct dentry *regs_dir, *ch_dir;
> +	struct dentry *regs_dent, *ch_dent;
>  	int nr_entries, i;
>  	char name[16];
>  
> -	regs_dir = debugfs_create_dir(WRITE_STR, dir);
> +	regs_dent = debugfs_create_dir(WRITE_STR, dent);
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> +	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
>  
>  	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
>  		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
>  		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
> -					   regs_dir);
> +					   regs_dent);
>  	}
>  
>  	for (i = 0; i < dw->wr_ch_cnt; i++) {
>  		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
>  
> -		ch_dir = debugfs_create_dir(name, regs_dir);
> +		ch_dent = debugfs_create_dir(name, regs_dent);
>  
> -		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dir);
> +		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dent);
>  
>  		lim[0][i].start = &regs->type.unroll.ch[i].wr;
>  		lim[0][i].end = &regs->type.unroll.ch[i].padding_1[0];
>  	}
>  }
>  
> -static void dw_edma_debugfs_regs_rd(struct dentry *dir)
> +static void dw_edma_debugfs_regs_rd(struct dentry *dent)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
> @@ -236,27 +236,27 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  		RD_REGISTER_UNROLL(ch6_pwr_en),
>  		RD_REGISTER_UNROLL(ch7_pwr_en),
>  	};
> -	struct dentry *regs_dir, *ch_dir;
> +	struct dentry *regs_dent, *ch_dent;
>  	int nr_entries, i;
>  	char name[16];
>  
> -	regs_dir = debugfs_create_dir(READ_STR, dir);
> +	regs_dent = debugfs_create_dir(READ_STR, dent);
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> +	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
>  
>  	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
>  		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
>  		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
> -					   regs_dir);
> +					   regs_dent);
>  	}
>  
>  	for (i = 0; i < dw->rd_ch_cnt; i++) {
>  		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
>  
> -		ch_dir = debugfs_create_dir(name, regs_dir);
> +		ch_dent = debugfs_create_dir(name, regs_dent);
>  
> -		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dir);
> +		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dent);
>  
>  		lim[1][i].start = &regs->type.unroll.ch[i].rd;
>  		lim[1][i].end = &regs->type.unroll.ch[i].padding_2[0];
> @@ -269,16 +269,16 @@ static void dw_edma_debugfs_regs(void)
>  		REGISTER(ctrl_data_arb_prior),
>  		REGISTER(ctrl),
>  	};
> -	struct dentry *regs_dir;
> +	struct dentry *regs_dent;
>  	int nr_entries;
>  
> -	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
> +	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> +	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
>  
> -	dw_edma_debugfs_regs_wr(regs_dir);
> -	dw_edma_debugfs_regs_rd(regs_dir);
> +	dw_edma_debugfs_regs_wr(regs_dent);
> +	dw_edma_debugfs_regs_rd(regs_dent);
>  }
>  
>  void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
