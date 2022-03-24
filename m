Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B1F4E687A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352556AbiCXSQJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiCXSQI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 14:16:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30AA8ED9
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 11:14:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so5629051plo.0
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kaWyOFUTIvk7Jf/C253NUkUi7ERn3SB2Cf+AuYAeK5I=;
        b=amB2XOhqEhJQzky4D/NKJxmo5mgT7AHDpjkIdKEpr/M9SRrGbDmIJKdhcVytEu/4L7
         htCJrv4/j43jObsH4ywenMqqmYlNVK2yBCj1vogP6lnGaC6BYwUqy3WjRNyDaf6oxCs4
         YtrFZe7aMzI6EIIofn54JjExiJCeOH6Tzu2gdqZFfsGcv4eBvohezzn09Klr62eKVFO7
         lOMbXNKsUH+Kb85LmSYR0M9ScZo+E6NvpWc9mgVCz5JWAXAU4WwZzLb4xrelrBDc6DF8
         Si4h3M2gz4kl/bm1RGkobe1CLqnqaqhouujzDaaokzWGJfrXIXRk4KDudjWy6g1pn5Vm
         QLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kaWyOFUTIvk7Jf/C253NUkUi7ERn3SB2Cf+AuYAeK5I=;
        b=OUq9bVa90+njG4E4YVdAg+17Evor+0WiuleIp4BSW/aGYBQxEN7sMVfUBYyW3yuqzk
         eXoN92n676MvBGuOFuJzTvujRiFw/tb+r1b12l+oVm74I3Mcg9Z/g3aD89sLkwjA2O3m
         DxODLPoLTO+KIMlsGFhyu5m0k+RWN5StLz1I1QYInI93yUquCcOM7CVFunpg0HezfdF8
         jKXDRzwNAg8aqATEAdxvCq7VqP0FlJRomT5lirlgLo6my0N5Wub6RFVzrBOLXMy9GfSo
         y+vB64UsmjODgTkp9uGStH3Thbgnext8PqDT3xT+i0iL401p0ZgDN3+C0e/zpMxyzIPt
         vL3w==
X-Gm-Message-State: AOAM531S6YmMN3JNC9Q4t846Zh5MFEabDgXavhfJcqtnuRYssUDYvBon
        hhIl83ifuDtNgdKrRlBDXanN
X-Google-Smtp-Source: ABdhPJwua8sOXe+hMuGfnKTODS9uECovRKgCETxT8KTPmXOFY4YzITVwYpfUP+ddtha72kZJ5pnBSA==
X-Received: by 2002:a17:902:c401:b0:154:1398:a16b with SMTP id k1-20020a170902c40100b001541398a16bmr7152359plk.67.1648145675984;
        Thu, 24 Mar 2022 11:14:35 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm4622229pfj.152.2022.03.24.11.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:14:35 -0700 (PDT)
Date:   Thu, 24 Mar 2022 23:44:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/25] dmaengine: dw-edma: Add dw_edma prefix to the
 DebugFS nodes descriptor
Message-ID: <20220324181429.GW2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-15-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:25AM +0300, Serge Semin wrote:
> The rest of the locally defined and used methods and structures have
> dw_edma prefix in their names. It's right in accordance with the kernel
> coding style to follow the locally defined rule of naming. Let's add that
> prefix to the debugfs_entries structure too especially seeing it's name
> may be confusing as if that structure belongs to the global DebugFS space.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Man

> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 808eed212be8..afd519d9568b 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -46,7 +46,7 @@ static struct {
>  	void					__iomem *end;
>  } lim[2][EDMA_V0_MAX_NR_CH];
>  
> -struct debugfs_entries {
> +struct dw_edma_debugfs_entry {
>  	const char				*name;
>  	void __iomem				*reg;
>  };
> @@ -94,7 +94,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
>  
> -static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
> +static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
>  				       int nr_entries, struct dentry *dir)
>  {
>  	int i;
> @@ -108,8 +108,7 @@ static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
>  static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
>  				    struct dentry *dir)
>  {
> -	int nr_entries;
> -	const struct debugfs_entries debugfs_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		REGISTER(ch_control1),
>  		REGISTER(ch_control2),
>  		REGISTER(transfer_size),
> @@ -120,6 +119,7 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
>  		REGISTER(llp.lsb),
>  		REGISTER(llp.msb),
>  	};
> +	int nr_entries;
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
>  	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
> @@ -127,7 +127,7 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
>  
>  static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  {
> -	const struct debugfs_entries debugfs_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
>  		WR_REGISTER(engine_en),
>  		WR_REGISTER(doorbell),
> @@ -148,7 +148,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  		WR_REGISTER(ch67_imwr_data),
>  		WR_REGISTER(linked_list_err_en),
>  	};
> -	const struct debugfs_entries debugfs_unroll_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
>  		/* eDMA channel context grouping */
>  		WR_REGISTER_UNROLL(engine_chgroup),
>  		WR_REGISTER_UNROLL(engine_hshake_cnt.lsb),
> @@ -191,7 +191,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  
>  static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  {
> -	const struct debugfs_entries debugfs_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
>  		RD_REGISTER(engine_en),
>  		RD_REGISTER(doorbell),
> @@ -213,7 +213,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  		RD_REGISTER(ch45_imwr_data),
>  		RD_REGISTER(ch67_imwr_data),
>  	};
> -	const struct debugfs_entries debugfs_unroll_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
>  		/* eDMA channel context grouping */
>  		RD_REGISTER_UNROLL(engine_chgroup),
>  		RD_REGISTER_UNROLL(engine_hshake_cnt.lsb),
> @@ -256,7 +256,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  
>  static void dw_edma_debugfs_regs(void)
>  {
> -	const struct debugfs_entries debugfs_regs[] = {
> +	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		REGISTER(ctrl_data_arb_prior),
>  		REGISTER(ctrl),
>  	};
> -- 
> 2.35.1
> 
