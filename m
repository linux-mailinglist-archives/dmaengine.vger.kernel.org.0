Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB53778E51
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 13:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjHKLz4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 07:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjHKLzw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 07:55:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D2630F9;
        Fri, 11 Aug 2023 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691754946; x=1723290946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yL2t/ELliYKokE6XTNebDyRG6ZbSc3aEkOP9T0lLnXo=;
  b=an8u1T/hm5APWDG2y+fHZTjATHWPPLRFgQEzJnx3gkyHYYOpIk4qDx7S
   tUnREaznVXj9kRNlrDJ6BWrMGy9OHN6o84M2Y8BkzS9mOFJ6+iqAmy6yo
   xqnS9H3q1qRQki6o6KELttq/ewkhLz8IIWXy7hvHSCzIe2VwFg1lsP7H2
   ULEv2jAq66rcw0CmxOP/2iVG2KtjFTDtY3pbrjyVxNMlicoYJEHTRv8LG
   i3eMLDMmAatJL1y8MXxP2y8R1m8EVxNqmH1qQavwdnNjAbNOc0xT3Rrv3
   YMHgl8oKAtku/u4PLv20U5jVOl/VIkyGmchFSEghEE411uQCikq2eejOL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356620252"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="356620252"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 04:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="767649852"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="767649852"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2023 04:55:41 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUQk0-0007lw-26;
        Fri, 11 Aug 2023 11:55:40 +0000
Date:   Fri, 11 Aug 2023 19:55:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Mengqi <guomengqi3@huawei.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, guomengqi3@huawei.com,
        xuqiang36@huawei.com
Subject: Re: [PATCH 1/2] dmaengine: Add HiSilicon Ascend SDMA engine support
Message-ID: <202308111941.5SysB2x2-lkp@intel.com>
References: <20230811034822.107229-2-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811034822.107229-2-guomengqi3@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Guo,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guo-Mengqi/dmaengine-Add-HiSilicon-Ascend-SDMA-engine-support/20230811-115823
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230811034822.107229-2-guomengqi3%40huawei.com
patch subject: [PATCH 1/2] dmaengine: Add HiSilicon Ascend SDMA engine support
config: csky-randconfig-r003-20230811 (https://download.01.org/0day-ci/archive/20230811/202308111941.5SysB2x2-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308111941.5SysB2x2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308111941.5SysB2x2-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/ascend_sdma.c:191:6: warning: no previous prototype for 'set_sdma_channel_info' [-Wmissing-prototypes]
     191 | void set_sdma_channel_info(struct dma_chan *c, int pasid)
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:30,
                    from drivers/dma/ascend_sdma.c:4:
   drivers/dma/ascend_sdma.c: In function 'of_sdma_collect_info':
   include/linux/kern_levels.h:5:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:508:9: note: in expansion of macro 'printk'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:508:16: note: in expansion of macro 'KERN_WARNING'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/dma/ascend_sdma.c:234:17: note: in expansion of macro 'pr_warn'
     234 |                 pr_warn("reg size %#llx check failed, use %#x\n",
         |                 ^~~~~~~
   drivers/dma/ascend_sdma.c: At top level:
   drivers/dma/ascend_sdma.c:490:33: warning: no previous prototype for 'sdma_prep_dma_memcpy' [-Wmissing-prototypes]
     490 | struct dma_async_tx_descriptor *sdma_prep_dma_memcpy(
         |                                 ^~~~~~~~~~~~~~~~~~~~
   drivers/dma/ascend_sdma.c:520:5: warning: no previous prototype for 'sdma_terminate_all' [-Wmissing-prototypes]
     520 | int sdma_terminate_all(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/dma/ascend_sdma.c:528:6: warning: no previous prototype for 'sdma_synchronize' [-Wmissing-prototypes]
     528 | void sdma_synchronize(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~
   drivers/dma/ascend_sdma.c:535:17: warning: no previous prototype for 'sdma_tx_status' [-Wmissing-prototypes]
     535 | enum dma_status sdma_tx_status(struct dma_chan *chan,
         |                 ^~~~~~~~~~~~~~
   drivers/dma/ascend_sdma.c: In function 'sdma_tx_status':
>> drivers/dma/ascend_sdma.c:545:9: error: implicit declaration of function 'dsb' [-Werror=implicit-function-declaration]
     545 |         dsb(sy);
         |         ^~~
>> drivers/dma/ascend_sdma.c:545:13: error: 'sy' undeclared (first use in this function); did you mean 'sc'?
     545 |         dsb(sy);
         |             ^~
         |             sc
   drivers/dma/ascend_sdma.c:545:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/dma/ascend_sdma.c:540:22: warning: variable 'ch_ctrl_reg' set but not used [-Wunused-but-set-variable]
     540 |         u32 irq_reg, ch_ctrl_reg;
         |                      ^~~~~~~~~~~
   drivers/dma/ascend_sdma.c: In function 'sdma_start_transfer':
>> drivers/dma/ascend_sdma.c:633:9: error: implicit declaration of function 'dmb'; did you mean 'rmb'? [-Werror=implicit-function-declaration]
     633 |         dmb(sy);
         |         ^~~
         |         rmb
   drivers/dma/ascend_sdma.c:633:13: error: 'sy' undeclared (first use in this function); did you mean 's8'?
     633 |         dmb(sy);
         |             ^~
         |             s8
   drivers/dma/ascend_sdma.c: At top level:
   drivers/dma/ascend_sdma.c:638:6: warning: no previous prototype for 'sdma_issue_pending' [-Wmissing-prototypes]
     638 | void sdma_issue_pending(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~
   drivers/dma/ascend_sdma.c:651:6: warning: no previous prototype for 'sdma_free_chan_resources' [-Wmissing-prototypes]
     651 | void sdma_free_chan_resources(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/dsb +545 drivers/dma/ascend_sdma.c

   527	
 > 528	void sdma_synchronize(struct dma_chan *chan)
   529	{
   530		struct sdma_chan *sc = to_sdma_chan(chan);
   531	
   532		vchan_synchronize(&sc->vc);
   533	}
   534	
 > 535	enum dma_status sdma_tx_status(struct dma_chan *chan,
   536			dma_cookie_t cookie,
   537			struct dma_tx_state *txstate)
   538	{
   539		u32 cq_head, cq_tail, cq_count;
   540		u32 irq_reg, ch_ctrl_reg;
   541		struct sdma_cq_entry *cq_entry;
   542		struct sdma_chan *sc = to_sdma_chan(chan);
   543		enum dma_status ret = DMA_IN_PROGRESS;
   544	
 > 545		dsb(sy);
   546		irq_reg = readl(sc->io_base + SDMAM_IRQ_STATUS_REG);
   547		ch_ctrl_reg = readl(sc->io_base + SDMAM_CH_CTRL_REG);
   548	
   549		if (irq_reg & SDMAM_IRQ_IOC_MASK) {
   550			writel(irq_reg, sc->io_base + SDMAM_IRQ_STATUS_REG);
   551	
   552			cq_head = sc->cq_head;
   553			cq_tail = sdma_channel_get_cq_tail(sc);
   554			cq_count = sdma_queue_count(cq_head, cq_tail, SDMA_CQ_LENGTH);
   555			if (!cq_count) {
   556				pr_err("unexpected complete irq\n");
   557				ret = DMA_ERROR;
   558				goto out;
   559			}
   560	
   561			for (; cq_count; cq_count--) {
   562				cq_entry = sc->cq_base + cq_head;
   563				if (cq_entry->vld != sc->cq_vld || cq_entry->status) {
   564					pr_err("cq_entry invalid, vld: %u, cq_vld: %u, status: %u\n",
   565							cq_entry->vld, sc->cq_vld, cq_entry->status);
   566					ret = DMA_ERROR;
   567				}
   568				if (++cq_head == SDMA_CQ_LENGTH) {
   569					sc->cq_vld ^= 1;
   570					cq_head = 0;
   571				}
   572			}
   573	
   574			sc->cq_head = cq_head;
   575			sdma_channel_set_cq_head(sc, cq_head);
   576			sc->sq_head = sdma_channel_get_sq_head(sc);
   577			sc->cq_tail = cq_tail;
   578	
   579			if (ret != DMA_ERROR) {
   580				ret = DMA_COMPLETE;
   581				vchan_cookie_complete(&sc->desc->vd);
   582			}
   583		} else if (irq_reg & SDMAM_IRQ_IOE_MASK) {
   584			writel(irq_reg, sc->io_base + SDMAM_IRQ_STATUS_REG);
   585			pr_err("sdma ioe interrupt occur, status: %#x\n", irq_reg);
   586			sdma_error_handle(sc);
   587	
   588			ret = DMA_ERROR;
   589		}
   590	
   591	out:
   592		return ret;
   593	}
   594	
   595	static void sdma_start_transfer(struct sdma_chan *pchan)
   596	{
   597		u16 sq_tail = pchan->sq_tail;
   598		struct sdma_sq_entry *entry = pchan->sq_base + sq_tail;
   599		struct sdma_desc *desc;
   600		struct virt_dma_desc *vd;
   601	
   602		vd = vchan_next_desc(&pchan->vc);
   603		if (!vd) {
   604			pchan->desc = NULL;
   605			return;
   606		}
   607		list_del(&vd->node);
   608		desc = to_sdma_desc(vd);
   609		pchan->desc = desc;
   610	
   611		memcpy(entry, &desc->entry, sizeof(struct sdma_sq_entry));
   612	
   613		entry->src_streamid = pchan->sdev->streamid;
   614		entry->dst_streamid = pchan->sdev->streamid;
   615	
   616		entry->sns          = 1;
   617		entry->dns          = 1;
   618		entry->ie           = 0;
   619		entry->partid       = 0;
   620		entry->mpamns       = 1;
   621		if (pchan->pasid) {
   622			entry->sssv            = 1;
   623			entry->dssv            = 1;
   624			entry->src_substreamid = pchan->pasid;
   625			entry->dst_substreamid = pchan->pasid;
   626		} else {
   627			entry->sssv = 0;
   628			entry->dssv = 0;
   629		}
   630		sq_tail = (sq_tail + 1) & (SDMA_SQ_LENGTH - 1);
   631		entry->ie = 1;
   632	
 > 633		dmb(sy);
   634		sdma_channel_set_sq_tail(pchan, sq_tail);
   635		pchan->sq_tail = sq_tail;
   636	}
   637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
