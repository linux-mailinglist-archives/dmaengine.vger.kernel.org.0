Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAD713493
	for <lists+dmaengine@lfdr.de>; Sat, 27 May 2023 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjE0L7I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 May 2023 07:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjE0L7I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 May 2023 07:59:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5BF3;
        Sat, 27 May 2023 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685188746; x=1716724746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1TPmWjxOFqFxwsJrDeSGVc93SPSkph7oWPfkq3d7EoY=;
  b=F5xKAbIu1969PhFilFrU4AIrFQ398jTFhaS8bvB60B1a+52zMfSoyxTY
   nRB4z2Q7LsAYWpP87Jjj0vjUh4ZNbF3bgm47Hc522rxIagRDAuncka3/H
   7ktaihs/YtK0Ugwz4GqL+VEZ+4jS9lxOJuAbifqVZkL2n102pe04YsKRn
   4dxV4yT3Bj56tCBO/PvSsnDzwax72KVMJ88Mshl1Xu4FGScHnTEkwmFG2
   sx6vnRHsaHAqhMzuLa5c+fa+053j4tgTrXNFc+RacH8K/dmYvxeBj2yrg
   /jhXWIPhr3dEV2Aoh6v5h8bYe83AScJbFOX9eDV7TyWeQFbaHAIHDU5m2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="353233929"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="353233929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 04:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="817840389"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="817840389"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2023 04:59:02 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2sZZ-000Jwm-1H;
        Sat, 27 May 2023 11:59:01 +0000
Date:   Sat, 27 May 2023 19:58:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 10/12] dmaengine: fsl-edma: move tcd into struct
 fsl_dma_chan
Message-ID: <202305271951.gmRobs3a-lkp@intel.com>
References: <20230526143639.1037099-11-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526143639.1037099-11-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on robh/for-next linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-clean-up-EXPORT_SYMBOL_GPL-in-fsl-edma-common-c/20230526-224442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230526143639.1037099-11-Frank.Li%40nxp.com
patch subject: [PATCH v1 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
config: i386-randconfig-s003-20230526 (https://download.01.org/0day-ci/archive/20230527/202305271951.gmRobs3a-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/913c495a6c017a70bd6d7a518a9edbd361212985
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/dmaengine-fsl-edma-clean-up-EXPORT_SYMBOL_GPL-in-fsl-edma-common-c/20230526-224442
        git checkout 913c495a6c017a70bd6d7a518a9edbd361212985
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305271951.gmRobs3a-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/dma/fsl-edma-common.c:367:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:367:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:368:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:368:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:370:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:370:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:371:9: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] soff @@
   drivers/dma/fsl-edma-common.c:371:9: sparse:     expected unsigned short [usertype] val
   drivers/dma/fsl-edma-common.c:371:9: sparse:     got restricted __le16 [usertype] soff
>> drivers/dma/fsl-edma-common.c:371:9: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le16 [usertype] soff @@
   drivers/dma/fsl-edma-common.c:371:9: sparse:     expected unsigned int [usertype] val
   drivers/dma/fsl-edma-common.c:371:9: sparse:     got restricted __le16 [usertype] soff
   drivers/dma/fsl-edma-common.c:373:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:373:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:374:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:374:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:376:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:376:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:377:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:377:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:378:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:378:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:380:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:380:9: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:388:9: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:388:9: sparse: sparse: cast from restricted __le16

vim +371 drivers/dma/fsl-edma-common.c

   353	
   354	static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
   355					  struct fsl_edma_hw_tcd *tcd)
   356	{
   357		u16 csr = 0;
   358	
   359		/*
   360		 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
   361		 * endian format. However, we need to load the TCD registers in
   362		 * big- or little-endian obeying the eDMA engine model endian,
   363		 * and this is performed from specific edma_write functions
   364		 */
   365		edma_write_tcdreg(fsl_chan, 0, csr);
   366	
   367		edma_write_tcdreg(fsl_chan, (s32)tcd->saddr, saddr);
   368		edma_write_tcdreg(fsl_chan, (s32)tcd->daddr, daddr);
   369	
   370		edma_write_tcdreg(fsl_chan, (s16)tcd->attr, attr);
 > 371		edma_write_tcdreg(fsl_chan, tcd->soff, soff);
   372	
   373		edma_write_tcdreg(fsl_chan, (s32)tcd->nbytes, nbytes);
   374		edma_write_tcdreg(fsl_chan, (s32)tcd->slast, slast);
   375	
   376		edma_write_tcdreg(fsl_chan, (s16)tcd->citer, citer);
   377		edma_write_tcdreg(fsl_chan, (s16)tcd->biter, biter);
   378		edma_write_tcdreg(fsl_chan, (s16)tcd->doff, doff);
   379	
   380		edma_write_tcdreg(fsl_chan, (s32)tcd->dlast_sga, dlast_sga);
   381	
   382		if (fsl_chan->is_sw) {
   383			csr = le16_to_cpu(tcd->csr);
   384			csr |= EDMA_TCD_CSR_START;
   385			tcd->csr = cpu_to_le16(csr);
   386		}
   387	
   388		edma_write_tcdreg(fsl_chan, (s16)tcd->csr, csr);
   389	}
   390	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
