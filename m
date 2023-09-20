Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3837A70B4
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 04:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjITCtu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 22:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCtu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 22:49:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70CCA;
        Tue, 19 Sep 2023 19:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695178184; x=1726714184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ER8fiiAPm2caQoOxgx6snBR2K9CLgCFNotUsHekV2Lw=;
  b=KvcnPlB0CAGLFtU5EKc3J2oH3TN2zFvuqaROPWGUU2k2x8YsgWeWO2Vh
   zl5P8KcH4aQOTEp7q7s12NCUVPiDfepvZ+P7aBhv/LhoVyzS1WF6a4/Gg
   jkDQT5zsBbJMDff44nTaMjiBPQ8FaoAPm+QtCOAFCYtfaKZl8OBV8lV7u
   R6OCEgrPE2+xTms4mjXouVzF2powkTgaAtdsuY2wdna7OVZsd+MRzHUCn
   SYUOj4p/KG+nJMqgsBPyLEZiXpkZZ9rKj7GSopuSLsRj9KymFAUyoUbNB
   aCouWoEW8Ce31AcjY/3DrwQl523Jem8lCeGs66To5zrDCu+bpmVlKNpks
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359496823"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="359496823"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 19:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="993408437"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="993408437"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2023 19:49:38 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qinHU-0008C0-1w;
        Wed, 20 Sep 2023 02:49:36 +0000
Date:   Wed, 20 Sep 2023 10:49:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] dmaengine: fsl-edma: add trace event support
Message-ID: <202309201032.LMx2JZTV-lkp@intel.com>
References: <20230919151430.2919042-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919151430.2919042-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.6-rc2 next-20230919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-emda-add-debugfs-support/20230920-010257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230919151430.2919042-3-Frank.Li%40nxp.com
patch subject: [PATCH v2 2/2] dmaengine: fsl-edma: add trace event support
config: x86_64-randconfig-123-20230920 (https://download.01.org/0day-ci/archive/20230920/202309201032.LMx2JZTV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201032.LMx2JZTV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201032.LMx2JZTV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/dma/fsl-edma-trace.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, drivers/dma/fsl-edma-trace.h, ...):
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] saddr @@     got restricted __le32 [usertype] saddr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] saddr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] saddr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] soff @@     got restricted __le16 [usertype] soff @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] soff
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] soff
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr @@     got restricted __le16 [usertype] attr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] attr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] attr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] nbytes @@     got restricted __le32 [usertype] nbytes @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] nbytes
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] nbytes
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] slast @@     got restricted __le32 [usertype] slast @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] slast
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] slast
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] daddr @@     got restricted __le32 [usertype] daddr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] daddr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] daddr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] doff @@     got restricted __le16 [usertype] doff @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] doff
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] doff
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] citer @@     got restricted __le16 [usertype] citer @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] citer
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] citer
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dlast_sga @@     got restricted __le32 [usertype] dlast_sga @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] dlast_sga
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] dlast_sga
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] csr @@     got restricted __le16 [usertype] csr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] csr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] csr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] biter @@     got restricted __le16 [usertype] biter @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] biter
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] biter
   drivers/dma/fsl-edma-trace.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, drivers/dma/fsl-edma-trace.h, ...):
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] saddr @@     got restricted __le32 [usertype] saddr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] saddr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] saddr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] soff @@     got restricted __le16 [usertype] soff @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] soff
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] soff
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr @@     got restricted __le16 [usertype] attr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] attr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] attr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] nbytes @@     got restricted __le32 [usertype] nbytes @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] nbytes
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] nbytes
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] slast @@     got restricted __le32 [usertype] slast @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] slast
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] slast
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] daddr @@     got restricted __le32 [usertype] daddr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] daddr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] daddr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] doff @@     got restricted __le16 [usertype] doff @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] doff
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] doff
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] citer @@     got restricted __le16 [usertype] citer @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] citer
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] citer
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dlast_sga @@     got restricted __le32 [usertype] dlast_sga @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned int [usertype] dlast_sga
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le32 [usertype] dlast_sga
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] csr @@     got restricted __le16 [usertype] csr @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] csr
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] csr
>> drivers/dma/./fsl-edma-trace.h:62:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] biter @@     got restricted __le16 [usertype] biter @@
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     expected unsigned short [usertype] biter
   drivers/dma/./fsl-edma-trace.h:62:1: sparse:     got restricted __le16 [usertype] biter

vim +62 drivers/dma/./fsl-edma-trace.h

    61	
  > 62	DECLARE_EVENT_CLASS(edma_log_tcd,
    63		TP_PROTO(struct fsl_edma_engine *edma, struct fsl_edma_hw_tcd *tcd),
    64		TP_ARGS(edma, tcd),
    65		TP_STRUCT__entry(
    66			__field(struct fsl_edma_engine *, edma)
    67			__field(u32, saddr)
    68			__field(u16, soff)
    69			__field(u16, attr)
    70			__field(u32, nbytes)
    71			__field(u32, slast)
    72			__field(u32, daddr)
    73			__field(u16, doff)
    74			__field(u16, citer)
    75			__field(u32, dlast_sga)
    76			__field(u16, csr)
    77			__field(u16, biter)
    78	
    79		),
    80		TP_fast_assign(
    81			__entry->edma = edma;
    82			__entry->saddr = tcd->saddr,
    83			__entry->soff = tcd->soff,
    84			__entry->attr = tcd->attr,
    85			__entry->nbytes = tcd->nbytes,
    86			__entry->slast = tcd->slast,
    87			__entry->daddr = tcd->daddr,
    88			__entry->doff = tcd->doff,
    89			__entry->citer = tcd->citer,
    90			__entry->dlast_sga = tcd->dlast_sga,
    91			__entry->csr = tcd->csr,
    92			__entry->biter = tcd->biter;
    93		),
    94		TP_printk("\n==== TCD =====\n"
    95			  "  saddr:  0x%08x\n"
    96			  "  soff:       0x%04x\n"
    97			  "  attr:       0x%04x\n"
    98			  "  nbytes: 0x%08x\n"
    99			  "  slast:  0x%08x\n"
   100			  "  daddr:  0x%08x\n"
   101			  "  doff:       0x%04x\n"
   102			  "  citer:      0x%04x\n"
   103			  "  dlast:  0x%08x\n"
   104			  "  csr:        0x%04x\n"
   105			  "  biter:      0x%04x\n",
   106			__entry->saddr,
   107			__entry->soff,
   108			__entry->attr,
   109			__entry->nbytes,
   110			__entry->slast,
   111			__entry->daddr,
   112			__entry->doff,
   113			__entry->citer,
   114			__entry->dlast_sga,
   115			__entry->csr,
   116			__entry->biter)
   117	);
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
