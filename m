Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02C7D7295
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjJYRrN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYRrN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 13:47:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC32CC;
        Wed, 25 Oct 2023 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698256031; x=1729792031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y51ew40oLjwa3836YhR+S3DSxiZGQ240PtjmogMYv8s=;
  b=cAf7mHYKTfu+ZBqa/ipE2E48e+yFyY3ce3p3jX+zS5xSz3PaQgxmRtTT
   BnDgTNQTOD0bMXH8vRJXsamRqKKvnzKutcnaH479I2i0PTFJ85/jcfIk8
   +m6L3PayoFKUPLhB3/hZ0+rJYTVZbEfuGgjN8ZtsR/lmKY0oTsSbb23b8
   h4Gh6Or4/LUfnWfQFBvT4PsgYZzkgLfyA+Yx8V4N814K/UVbUlW8vybn4
   5tRAhidR5pgGMnZqNwxPoIGgztEQCzT++i6eC7+q142wXkGswJYjZc6eE
   elFbeGQVTJf1rnpVoICIh/4ya5a3fzQ8HRHP/1H0edkYzB4xGPL3PBDYJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="386247418"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="386247418"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 10:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="793909382"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="793909382"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2023 10:46:21 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvhxS-00094f-2p;
        Wed, 25 Oct 2023 17:46:18 +0000
Date:   Thu, 26 Oct 2023 01:46:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 1/3] dmaengine: sprd: support dma device suspend/resume
Message-ID: <202310260136.yDATuOfv-lkp@intel.com>
References: <20231025120500.8914-1-kaiwei.liu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025120500.8914-1-kaiwei.liu@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kaiwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.6-rc7 next-20231025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kaiwei-Liu/dmaengine-sprd-delete-enable-opreation-in-probe/20231025-201524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20231025120500.8914-1-kaiwei.liu%40unisoc.com
patch subject: [PATCH 1/3] dmaengine: sprd: support dma device suspend/resume
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231026/202310260136.yDATuOfv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310260136.yDATuOfv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260136.yDATuOfv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/sprd-dma.c: In function 'sprd_dma_suspend_noirq':
   drivers/dma/sprd-dma.c:1296:38: error: 'struct dev_pm_info' has no member named 'usage_count'
    1296 |             (atomic_read(&(dev->power.usage_count)) > 1))
         |                                      ^
   drivers/dma/sprd-dma.c: In function 'sprd_dma_resume_early':
   drivers/dma/sprd-dma.c:1305:38: error: 'struct dev_pm_info' has no member named 'usage_count'
    1305 |             (atomic_read(&(dev->power.usage_count)) > 1))
         |                                      ^
   drivers/dma/sprd-dma.c: At top level:
>> drivers/dma/sprd-dma.c:1302:12: warning: 'sprd_dma_resume_early' defined but not used [-Wunused-function]
    1302 | static int sprd_dma_resume_early(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/sprd-dma.c:1293:12: warning: 'sprd_dma_suspend_noirq' defined but not used [-Wunused-function]
    1293 | static int sprd_dma_suspend_noirq(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +/sprd_dma_resume_early +1302 drivers/dma/sprd-dma.c

  1292	
> 1293	static int sprd_dma_suspend_noirq(struct device *dev)
  1294	{
  1295		if ((pm_runtime_status_suspended(dev)) ||
  1296		    (atomic_read(&(dev->power.usage_count)) > 1))
  1297			return 0;
  1298	
  1299		return sprd_dma_runtime_suspend(dev);
  1300	}
  1301	
> 1302	static int sprd_dma_resume_early(struct device *dev)
  1303	{
  1304		if ((pm_runtime_status_suspended(dev)) ||
  1305		    (atomic_read(&(dev->power.usage_count)) > 1))
  1306			return 0;
  1307	
  1308		return sprd_dma_runtime_resume(dev);
  1309	}
  1310	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
