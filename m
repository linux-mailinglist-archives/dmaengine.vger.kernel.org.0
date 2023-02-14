Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD269563B
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 03:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBNCAP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 21:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBNCAO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 21:00:14 -0500
Received: from out-104.mta0.migadu.com (out-104.mta0.migadu.com [IPv6:2001:41d0:1004:224b::68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066C1A95B
        for <dmaengine@vger.kernel.org>; Mon, 13 Feb 2023 18:00:12 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:00:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676340010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9BBRNOThmuII/oJg0K0CReT+0wqbnh62GSU+44RXkto=;
        b=cy1SXxOwYTU78nyphvzLu6qsQro8J4/28gVLEdfOjyj029FovqDM4ywnTT2S8omUa3uuAL
        LdkuX1yONb8pgc2DZjlEXcziHwHfgmjGNm1+Yiy3w0uKkgGXiGUEV1EyaBYjPLwkJuV7Me
        YIQOXO5A0aOv0Zb+M/BLHkfwmA9oSKw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     kernel test robot <lkp@intel.com>
Cc:     Sergey.Semin@baikalelectronics.ru, oe-kbuild-all@lists.linux.dev,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <Y+rrJfzNzDXwFzf/@chq-MS-7D45>
References: <20230213132411.65524-4-cai.huoqing@linux.dev>
 <202302132344.oOgPHjYP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302132344.oOgPHjYP-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13 2月 23 23:20:19, kernel test robot wrote:
> Hi Cai,
> 
> Thank you for the patch! Yet something to improve:
Will include <linux/io-64-nonatomic-lo-hi.h>
> 
> [auto build test ERROR on next-20230213]
> [cannot apply to vkoul-dmaengine/next linus/master v6.2-rc8 v6.2-rc7 v6.2-rc6 v6.2-rc8]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cai-Huoqing/dmaengine-dw-edma-Rename-dw_edma_core_ops-structure-to-dw_edma_plat_ops/20230213-213412
> patch link:    https://lore.kernel.org/r/20230213132411.65524-4-cai.huoqing%40linux.dev
> patch subject: [PATCH v3 3/4] dmaengine: dw-edma: Add support for native HDMA
> config: i386-randconfig-a016-20230213 (https://download.01.org/0day-ci/archive/20230213/202302132344.oOgPHjYP-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/04d89cfa187deda4fa5a7cc947dbb797ce05e72f
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Cai-Huoqing/dmaengine-dw-edma-Rename-dw_edma_core_ops-structure-to-dw_edma_plat_ops/20230213-213412
>         git checkout 04d89cfa187deda4fa5a7cc947dbb797ce05e72f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 olddefconfig
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302132344.oOgPHjYP-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/dma/dw-edma/dw-hdma-v0-core.c: In function 'dw_hdma_v0_write_ll_data':
> >> drivers/dma/dw-edma/dw-hdma-v0-core.c:195:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
>      195 |                 writeq(sar, &lli->sar.reg);
>          |                 ^~~~~~
>          |                 writel
>    cc1: some warnings being treated as errors
> 
> 
> vim +195 drivers/dma/dw-edma/dw-hdma-v0-core.c
> 
>    177	
>    178	static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
>    179					     u32 control, u32 size, u64 sar, u64 dar)
>    180	{
>    181		ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
>    182	
>    183		if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>    184			struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
>    185	
>    186			lli->control = control;
>    187			lli->transfer_size = size;
>    188			lli->sar.reg = sar;
>    189			lli->dar.reg = dar;
>    190		} else {
>    191			struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
>    192	
>    193			writel(control, &lli->control);
>    194			writel(size, &lli->transfer_size);
>  > 195			writeq(sar, &lli->sar.reg);
>    196			writeq(dar, &lli->dar.reg);
>    197		}
>    198	}
>    199	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
