Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542B257CBCF
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiGUNZV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 09:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUNZV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 09:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CEDBC1C;
        Thu, 21 Jul 2022 06:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7E361EDF;
        Thu, 21 Jul 2022 13:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF17C3411E;
        Thu, 21 Jul 2022 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658409916;
        bh=TEp7TN6iNqn2rVYEw2fYnbEl+HAU8RZyU1TMyRYGaWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZqJ+bgYsENrmPSM34gGNq7msK1V3BJQ+M7mUUmpx7JtMBqIkMxir63L4Du1IwCyY
         6upZdxgWl+ifXnNmqzCPNiDa3vGQe5xQGKjV7t96eeSnGhh2bzBoqc0SwOdkw6PENN
         APSOcTyCEAq7Y1r5eEVdTeSTAW+roXq+2X8dgbmnGWT6ukyuxA6a0KQAcLCjiz7BfT
         +DXD/8M6NfSUO+otb5Q87QEDcUwnGcGm/n8pdXFjv1HK7BBpeb5jLdydsYwKQm345R
         ztkxjzJclkhSnPyP6DvGxjZJ5yjbbldiYJY3JubJ4HQlis5es50pGZPS+br/oQEV25
         gCnmiJiO0lMbg==
Date:   Thu, 21 Jul 2022 18:55:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] dmaengine: hisilicon: Add dfx feature for hisi
 dma driver
Message-ID: <YtlTuAHTcZnTFo6B@matsya>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220629035549.44181-1-haijie1@huawei.com>
 <20220629035549.44181-7-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629035549.44181-7-haijie1@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-22, 11:55, Jie Hai wrote:

What does dfx mean in title?

> This patch adds dump of registers with debugfs for HIP08
> and HIP09 DMA driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>

?

> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  drivers/dma/hisi_dma.c | 317 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 314 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index dc7c59b21114..b0bc7b18933b 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -78,6 +78,8 @@
>  #define HISI_DMA_POLL_Q_STS_DELAY_US		10
>  #define HISI_DMA_POLL_Q_STS_TIME_OUT_US		1000
>  
> +#define HISI_DMA_MAX_DIR_NAME_LEN		128
> +
>  /*
>   * The HIP08B(HiSilicon IP08) and HIP09A(HiSilicon IP09) are DMA iEPs, they
>   * have the same pci device id but different pci revision.
> @@ -161,9 +163,131 @@ struct hisi_dma_dev {
>  	u32 chan_depth;
>  	enum hisi_dma_reg_layout reg_layout;
>  	void __iomem *queue_base; /* queue region start of register */
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *dbg_hdev_root;

Please do not create your own root and use dmaengine root instead

> +	struct dentry **dbg_chans;
> +#endif
>  	struct hisi_dma_chan chan[];
>  };
>  
> +#ifdef CONFIG_DEBUG_FS
> +struct dentry *hisi_dma_debugfs_root;
> +
> +static const struct debugfs_reg32 hisi_dma_comm_chan_regs[] = {
> +	{"DMA_QUEUE_SQ_DEPTH                ", 0x0008ull},
> +	{"DMA_QUEUE_SQ_TAIL_PTR             ", 0x000Cull},
> +	{"DMA_QUEUE_CQ_DEPTH                ", 0x0018ull},
> +	{"DMA_QUEUE_CQ_HEAD_PTR             ", 0x001Cull},
> +	{"DMA_QUEUE_CTRL0                   ", 0x0020ull},
> +	{"DMA_QUEUE_CTRL1                   ", 0x0024ull},
> +	{"DMA_QUEUE_FSM_STS                 ", 0x0030ull},
> +	{"DMA_QUEUE_SQ_STS                  ", 0x0034ull},
> +	{"DMA_QUEUE_CQ_TAIL_PTR             ", 0x003Cull},
> +	{"DMA_QUEUE_INT_STS                 ", 0x0040ull},
> +	{"DMA_QUEUE_INT_MSK                 ", 0x0044ull},
> +	{"DMA_QUEUE_INT_RO                  ", 0x006Cull},
> +};
> +
> +static const struct debugfs_reg32 hisi_dma_hip08_chan_regs[] = {
> +	{"DMA_QUEUE_BYTE_CNT                ", 0x0038ull},
> +	{"DMA_ERR_INT_NUM6                  ", 0x0048ull},
> +	{"DMA_QUEUE_DESP0                   ", 0x0050ull},
> +	{"DMA_QUEUE_DESP1                   ", 0x0054ull},
> +	{"DMA_QUEUE_DESP2                   ", 0x0058ull},
> +	{"DMA_QUEUE_DESP3                   ", 0x005Cull},
> +	{"DMA_QUEUE_DESP4                   ", 0x0074ull},
> +	{"DMA_QUEUE_DESP5                   ", 0x0078ull},
> +	{"DMA_QUEUE_DESP6                   ", 0x007Cull},
> +	{"DMA_QUEUE_DESP7                   ", 0x0080ull},
> +	{"DMA_ERR_INT_NUM0                  ", 0x0084ull},
> +	{"DMA_ERR_INT_NUM1                  ", 0x0088ull},
> +	{"DMA_ERR_INT_NUM2                  ", 0x008Cull},
> +	{"DMA_ERR_INT_NUM3                  ", 0x0090ull},
> +	{"DMA_ERR_INT_NUM4                  ", 0x0094ull},
> +	{"DMA_ERR_INT_NUM5                  ", 0x0098ull},
> +	{"DMA_QUEUE_SQ_STS2                 ", 0x00A4ull},
> +};
> +
> +static const struct debugfs_reg32 hisi_dma_hip09_chan_regs[] = {
> +	{"DMA_QUEUE_ERR_INT_STS             ", 0x0048ull},
> +	{"DMA_QUEUE_ERR_INT_MSK             ", 0x004Cull},
> +	{"DFX_SQ_READ_ERR_PTR               ", 0x0068ull},
> +	{"DFX_DMA_ERR_INT_NUM0              ", 0x0084ull},
> +	{"DFX_DMA_ERR_INT_NUM1              ", 0x0088ull},
> +	{"DFX_DMA_ERR_INT_NUM2              ", 0x008Cull},
> +	{"DFX_DMA_QUEUE_SQ_STS2             ", 0x00A4ull},
> +};
> +
> +static const struct debugfs_reg32 hisi_dma_hip08_comm_regs[] = {
> +	{"DMA_ECC_ERR_ADDR                  ", 0x2004ull},
> +	{"DMA_ECC_ECC_CNT                   ", 0x2014ull},
> +	{"COMMON_AND_CH_ERR_STS             ", 0x2030ull},
> +	{"LOCAL_CPL_ID_STS_0                ", 0x20E0ull},
> +	{"LOCAL_CPL_ID_STS_1                ", 0x20E4ull},
> +	{"LOCAL_CPL_ID_STS_2                ", 0x20E8ull},
> +	{"LOCAL_CPL_ID_STS_3                ", 0x20ECull},
> +	{"LOCAL_TLP_NUM                     ", 0x2158ull},
> +	{"SQCQ_TLP_NUM                      ", 0x2164ull},
> +	{"CPL_NUM                           ", 0x2168ull},
> +	{"INF_BACK_PRESS_STS                ", 0x2170ull},
> +	{"DMA_CH_RAS_LEVEL                  ", 0x2184ull},
> +	{"DMA_CM_RAS_LEVEL                  ", 0x2188ull},
> +	{"DMA_CH_ERR_STS                    ", 0x2190ull},
> +	{"DMA_CH_DONE_STS                   ", 0x2194ull},
> +	{"DMA_SQ_TAG_STS_0                  ", 0x21A0ull},
> +	{"DMA_SQ_TAG_STS_1                  ", 0x21A4ull},
> +	{"DMA_SQ_TAG_STS_2                  ", 0x21A8ull},
> +	{"DMA_SQ_TAG_STS_3                  ", 0x21ACull},
> +	{"LOCAL_P_ID_STS_0                  ", 0x21B0ull},
> +	{"LOCAL_P_ID_STS_1                  ", 0x21B4ull},
> +	{"LOCAL_P_ID_STS_2                  ", 0x21B8ull},
> +	{"LOCAL_P_ID_STS_3                  ", 0x21BCull},
> +	{"DMA_PREBUFF_INFO_0                ", 0x2200ull},
> +	{"DMA_CM_TABLE_INFO_0               ", 0x2220ull},
> +	{"DMA_CM_CE_RO                      ", 0x2244ull},
> +	{"DMA_CM_NFE_RO                     ", 0x2248ull},
> +	{"DMA_CM_FE_RO                      ", 0x224Cull},
> +};
> +
> +static const struct debugfs_reg32 hisi_dma_hip09_comm_regs[] = {
> +	{"COMMON_AND_CH_ERR_STS             ", 0x0030ull},
> +	{"DMA_PORT_IDLE_STS                 ", 0x0150ull},
> +	{"DMA_CH_RAS_LEVEL                  ", 0x0184ull},
> +	{"DMA_CM_RAS_LEVEL                  ", 0x0188ull},
> +	{"DMA_CM_CE_RO                      ", 0x0244ull},
> +	{"DMA_CM_NFE_RO                     ", 0x0248ull},
> +	{"DMA_CM_FE_RO                      ", 0x024Cull},
> +	{"DFX_INF_BACK_PRESS_STS0           ", 0x1A40ull},
> +	{"DFX_INF_BACK_PRESS_STS1           ", 0x1A44ull},
> +	{"DFX_INF_BACK_PRESS_STS2           ", 0x1A48ull},
> +	{"DFX_DMA_WRR_DISABLE               ", 0x1A4Cull},
> +	{"DFX_PA_REQ_TLP_NUM                ", 0x1C00ull},
> +	{"DFX_PA_BACK_TLP_NUM               ", 0x1C04ull},
> +	{"DFX_PA_RETRY_TLP_NUM              ", 0x1C08ull},
> +	{"DFX_LOCAL_NP_TLP_NUM              ", 0x1C0Cull},
> +	{"DFX_LOCAL_CPL_HEAD_TLP_NUM        ", 0x1C10ull},
> +	{"DFX_LOCAL_CPL_DATA_TLP_NUM        ", 0x1C14ull},
> +	{"DFX_LOCAL_CPL_EXT_DATA_TLP_NUM    ", 0x1C18ull},
> +	{"DFX_LOCAL_P_HEAD_TLP_NUM          ", 0x1C1Cull},
> +	{"DFX_LOCAL_P_ACK_TLP_NUM           ", 0x1C20ull},
> +	{"DFX_BUF_ALOC_PORT_REQ_NUM         ", 0x1C24ull},
> +	{"DFX_BUF_ALOC_PORT_RESULT_NUM      ", 0x1C28ull},
> +	{"DFX_BUF_FAIL_SIZE_NUM             ", 0x1C2Cull},
> +	{"DFX_BUF_ALOC_SIZE_NUM             ", 0x1C30ull},
> +	{"DFX_BUF_NP_RELEASE_SIZE_NUM       ", 0x1C34ull},
> +	{"DFX_BUF_P_RELEASE_SIZE_NUM        ", 0x1C38ull},
> +	{"DFX_BUF_PORT_RELEASE_SIZE_NUM     ", 0x1C3Cull},
> +	{"DFX_DMA_PREBUF_MEM0_ECC_ERR_ADDR  ", 0x1CA8ull},
> +	{"DFX_DMA_PREBUF_MEM0_ECC_CNT       ", 0x1CACull},
> +	{"DFX_DMA_LOC_NP_OSTB_ECC_ERR_ADDR  ", 0x1CB0ull},
> +	{"DFX_DMA_LOC_NP_OSTB_ECC_CNT       ", 0x1CB4ull},
> +	{"DFX_DMA_PREBUF_MEM1_ECC_ERR_ADDR  ", 0x1CC0ull},
> +	{"DFX_DMA_PREBUF_MEM1_ECC_CNT       ", 0x1CC4ull},
> +	{"DMA_CH_DONE_STS                   ", 0x02E0ull},
> +	{"DMA_CH_ERR_STS                    ", 0x0320ull},
> +};
> +#endif /* CONFIG_DEBUG_FS*/
> +
>  static enum hisi_dma_reg_layout hisi_dma_get_reg_layout(struct pci_dev *pdev)
>  {
>  	if (pdev->revision == HISI_DMA_REVISION_HIP08B)
> @@ -720,6 +844,162 @@ static void hisi_dma_init_dma_dev(struct hisi_dma_dev *hdma_dev)
>  	INIT_LIST_HEAD(&dma_dev->channels);
>  }
>  
> +/* --- debugfs implementation --- */
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +static void hisi_dma_debugfs_init(void)
> +{
> +	if (!debugfs_initialized())
> +		return;
> +	hisi_dma_debugfs_root = debugfs_create_dir("hisi_dma", NULL);
> +}
> +
> +static void hisi_dma_debugfs_uninit(void)
> +{
> +	debugfs_remove_recursive(hisi_dma_debugfs_root);
> +}
> +
> +static struct debugfs_reg32 *hisi_dma_get_ch_regs(struct hisi_dma_dev *hdma_dev,
> +						  u32 *regs_sz)
> +{
> +	struct device *dev = &hdma_dev->pdev->dev;
> +	struct debugfs_reg32 *regs;
> +	u32 regs_sz_comm;
> +
> +	regs_sz_comm = ARRAY_SIZE(hisi_dma_comm_chan_regs);
> +	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08)
> +		*regs_sz = regs_sz_comm + ARRAY_SIZE(hisi_dma_hip08_chan_regs);
> +	else
> +		*regs_sz = regs_sz_comm + ARRAY_SIZE(hisi_dma_hip09_chan_regs);
> +
> +	regs = devm_kcalloc(dev, *regs_sz, sizeof(struct debugfs_reg32),
> +			    GFP_KERNEL);
> +	if (!regs)
> +		return NULL;
> +	memcpy(regs, hisi_dma_comm_chan_regs, sizeof(hisi_dma_comm_chan_regs));
> +	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08)
> +		memcpy(regs + regs_sz_comm, hisi_dma_hip08_chan_regs,
> +		       sizeof(hisi_dma_hip08_chan_regs));
> +	else
> +		memcpy(regs + regs_sz_comm, hisi_dma_hip09_chan_regs,
> +		       sizeof(hisi_dma_hip09_chan_regs));
> +
> +	return regs;
> +}
> +
> +static int hisi_dma_create_chan_dir(struct hisi_dma_dev *hdma_dev)
> +{
> +	char dir_name[HISI_DMA_MAX_DIR_NAME_LEN];
> +	struct debugfs_regset32 *regsets;
> +	struct debugfs_reg32 *regs;
> +	struct device *dev;
> +	u32 regs_sz;
> +	int ret;
> +	int i;
> +
> +	dev = &hdma_dev->pdev->dev;
> +
> +	regsets = devm_kcalloc(dev, hdma_dev->chan_num,
> +			       sizeof(*regsets), GFP_KERNEL);
> +	if (!regsets)
> +		return -ENOMEM;
> +
> +	hdma_dev->dbg_chans = devm_kcalloc(dev, hdma_dev->chan_num,
> +					   sizeof(struct dentry *),
> +					   GFP_KERNEL);
> +	if (!hdma_dev->dbg_chans)
> +		return -ENOMEM;
> +
> +	regs = hisi_dma_get_ch_regs(hdma_dev, &regs_sz);
> +	if (!regs)
> +		return -ENOMEM;
> +	for (i = 0; i < hdma_dev->chan_num; i++) {
> +		regsets[i].regs = regs;
> +		regsets[i].nregs = regs_sz;
> +		regsets[i].base = hdma_dev->queue_base + i * HISI_DMA_Q_OFFSET;
> +		regsets[i].dev = dev;
> +
> +		memset(dir_name, 0, HISI_DMA_MAX_DIR_NAME_LEN);
> +		ret = sprintf(dir_name, "channel%d", i);
> +		if (ret < 0)
> +			return ret;
> +
> +		hdma_dev->dbg_chans[i] = debugfs_create_dir(dir_name,
> +					 hdma_dev->dbg_hdev_root);
> +		if (IS_ERR(hdma_dev->dbg_chans[i])) {
> +			hdma_dev->dbg_chans[i]  = NULL;
> +			dev_err(dev, "dbg_chan[%d] create fail!\n", i);
> +			return -EINVAL;
> +		}
> +		debugfs_create_regset32("regs", 0444,
> +					hdma_dev->dbg_chans[i], &regsets[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_dma_debug_register(struct hisi_dma_dev *hdma_dev)
> +{
> +	struct debugfs_regset32 *regset;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = &hdma_dev->pdev->dev;
> +
> +	hdma_dev->dbg_hdev_root = debugfs_create_dir(dev_name(dev),
> +						     hisi_dma_debugfs_root);
> +	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
> +	if (!regset) {
> +		ret = -ENOMEM;
> +		goto hisi_dma_debug_register_fail;
> +	}
> +
> +	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08) {
> +		regset->regs = hisi_dma_hip08_comm_regs;
> +		regset->nregs = ARRAY_SIZE(hisi_dma_hip08_comm_regs);
> +	} else {
> +		regset->regs = hisi_dma_hip09_comm_regs;
> +		regset->nregs = ARRAY_SIZE(hisi_dma_hip09_comm_regs);
> +	}
> +	regset->base = hdma_dev->base;
> +	regset->dev = dev;
> +
> +	debugfs_create_regset32("regs", 0444,
> +				hdma_dev->dbg_hdev_root, regset);
> +
> +	ret = hisi_dma_create_chan_dir(hdma_dev);
> +	if (ret < 0)
> +		goto hisi_dma_debug_register_fail;
> +
> +	return 0;
> +
> +hisi_dma_debug_register_fail:
> +	debugfs_remove_recursive(hdma_dev->dbg_hdev_root);
> +	hdma_dev->dbg_hdev_root = NULL;
> +	return ret;
> +}
> +
> +static void hisi_dma_debug_unregister(void *data)
> +{
> +	struct hisi_dma_dev *hdma_dev = data;
> +
> +	debugfs_remove_recursive(hdma_dev->dbg_hdev_root);
> +	hdma_dev->dbg_hdev_root = NULL;
> +}
> +#else
> +static void hisi_dma_debugfs_init(void) { }
> +static void hisi_dma_debugfs_uninit(void) { }
> +
> +static int hisi_dma_debug_register(struct hisi_dma_dev *hdma_dev)
> +{
> +	return 0;
> +}
> +
> +static void hisi_dma_debug_unregister(void *data) { }
> +#endif /* CONFIG_DEBUG_FS*/
> +/* --- debugfs implementation --- */
> +
>  static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	enum hisi_dma_reg_layout reg_layout;
> @@ -796,10 +1076,19 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	dma_dev = &hdma_dev->dma_dev;
>  	ret = dmaenginem_async_device_register(dma_dev);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(dev, "failed to register device!\n");
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = hisi_dma_debug_register(hdma_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register debugfs!\n");
> +		return ret;
> +	}

why should registering debugfs fail be a driver failure, it can still
work as epxected, pls ignore these errors and remove the error handling
for this piece of code

> +
> +	return devm_add_action_or_reset(dev, hisi_dma_debug_unregister,
> +					hdma_dev);
>  }
>  
>  static const struct pci_device_id hisi_dma_pci_tbl[] = {
> @@ -813,7 +1102,29 @@ static struct pci_driver hisi_dma_pci_driver = {
>  	.probe		= hisi_dma_probe,
>  };
>  
> -module_pci_driver(hisi_dma_pci_driver);
> +static int __init hisi_dma_init(void)
> +{
> +	int ret;
> +
> +	hisi_dma_debugfs_init();
> +
> +	ret = pci_register_driver(&hisi_dma_pci_driver);
> +	if (ret) {
> +		hisi_dma_debugfs_uninit();
> +		pr_err("hisi_dma: can't register hisi dma driver.\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit hisi_dma_exit(void)
> +{
> +	pci_unregister_driver(&hisi_dma_pci_driver);
> +	hisi_dma_debugfs_uninit();
> +}
> +
> +module_init(hisi_dma_init);
> +module_exit(hisi_dma_exit);
>  
>  MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
>  MODULE_AUTHOR("Zhenfa Qiu <qiuzhenfa@hisilicon.com>");
> -- 
> 2.33.0

-- 
~Vinod
