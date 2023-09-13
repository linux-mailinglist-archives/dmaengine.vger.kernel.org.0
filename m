Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3F79E493
	for <lists+dmaengine@lfdr.de>; Wed, 13 Sep 2023 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbjIMKIa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Sep 2023 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbjIMKI0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Sep 2023 06:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9336619B4
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694599702; x=1726135702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwDr3IKLlAqEBaHrnAQsnwV8YabWsCAnONEq1+Cb1Bc=;
  b=M2XOlnh81lekHwAGYx/bsP+li72MdOmcOZFlJbsa0/jP6/efxYRM5g9K
   Ed8aLWfyyWMcn6tuMXDMg3KmE//iZZUdAaFkmbDmjuPSp94gm3udQxnP9
   E/i0S4XqGHjFmxs+khVnXWn3Ez7hF0jwbIQRW+Vzu5WQDd7c55fgdEbaj
   tQqaqgWrLqCfbmZEUxng+rLcOQrh0Q/ahiRmT6cgAepV78fS3TezhtgjX
   L8YioN1MD47hEWz5YqTKo4QehiA717q0jsTl5Ji5wtQdmr1AV+c2QDAfY
   U/DM+S0Jo7psI4yNx9oqezUz7lyHv05QvqriAKP6D3DRsdLCSoFEJy41s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378530409"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="378530409"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="834253253"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="834253253"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Sep 2023 03:08:20 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgMnC-0000N9-1p;
        Wed, 13 Sep 2023 10:08:18 +0000
Date:   Wed, 13 Sep 2023 18:07:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tan En De <ende.tan@starfivetech.com>, dmaengine@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Eugeniy.Paltsev@synopsys.com,
        vkoul@kernel.org, Tan En De <ende.tan@starfivetech.com>
Subject: Re: [1/1] dmaengine: dw-axi-dmac: Support src_maxburst and
 dst_maxburst
Message-ID: <202309131749.P3k6i6Fz-lkp@intel.com>
References: <20230913083249.1244-1-ende.tan@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913083249.1244-1-ende.tan@starfivetech.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tan-En-De/dmaengine-dw-axi-dmac-Support-src_maxburst-and-dst_maxburst/20230913-163406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230913083249.1244-1-ende.tan%40starfivetech.com
patch subject: [1/1] dmaengine: dw-axi-dmac: Support src_maxburst and dst_maxburst
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309131749.P3k6i6Fz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131749.P3k6i6Fz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131749.P3k6i6Fz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'dma_chan_prep_dma_memcpy':
>> drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:955:32: warning: returning 'int' from a function with return type 'struct dma_async_tx_descriptor *' makes pointer from integer without a cast [-Wint-conversion]
     955 |                         return -EINVAL;
         |                                ^
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:962:32: warning: returning 'int' from a function with return type 'struct dma_async_tx_descriptor *' makes pointer from integer without a cast [-Wint-conversion]
     962 |                         return -EINVAL;
         |                                ^


vim +955 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

   884	
   885	static struct dma_async_tx_descriptor *
   886	dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
   887				 dma_addr_t src_adr, size_t len, unsigned long flags)
   888	{
   889		struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
   890		size_t block_ts, max_block_ts, xfer_len;
   891		struct axi_dma_hw_desc *hw_desc = NULL;
   892		struct axi_dma_desc *desc = NULL;
   893		u32 xfer_width, reg, num, src_burst_trans_len, dst_burst_trans_len;
   894		u64 llp = 0;
   895		u8 lms = 0; /* Select AXI0 master for LLI fetching */
   896	
   897		dev_dbg(chan2dev(chan), "%s: memcpy: src: %pad dst: %pad length: %zd flags: %#lx",
   898			axi_chan_name(chan), &src_adr, &dst_adr, len, flags);
   899	
   900		max_block_ts = chan->chip->dw->hdata->block_size[chan->id];
   901		xfer_width = axi_chan_get_xfer_width(chan, src_adr, dst_adr, len);
   902		num = DIV_ROUND_UP(len, max_block_ts << xfer_width);
   903		desc = axi_desc_alloc(num);
   904		if (unlikely(!desc))
   905			goto err_desc_get;
   906	
   907		desc->chan = chan;
   908		num = 0;
   909		desc->length = 0;
   910		while (len) {
   911			xfer_len = len;
   912	
   913			hw_desc = &desc->hw_desc[num];
   914			/*
   915			 * Take care for the alignment.
   916			 * Actually source and destination widths can be different, but
   917			 * make them same to be simpler.
   918			 */
   919			xfer_width = axi_chan_get_xfer_width(chan, src_adr, dst_adr, xfer_len);
   920	
   921			/*
   922			 * block_ts indicates the total number of data of width
   923			 * to be transferred in a DMA block transfer.
   924			 * BLOCK_TS register should be set to block_ts - 1
   925			 */
   926			block_ts = xfer_len >> xfer_width;
   927			if (block_ts > max_block_ts) {
   928				block_ts = max_block_ts;
   929				xfer_len = max_block_ts << xfer_width;
   930			}
   931	
   932			hw_desc->lli = axi_desc_get(chan, &hw_desc->llp);
   933			if (unlikely(!hw_desc->lli))
   934				goto err_desc_get;
   935	
   936			write_desc_sar(hw_desc, src_adr);
   937			write_desc_dar(hw_desc, dst_adr);
   938			hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
   939	
   940			reg = CH_CTL_H_LLI_VALID;
   941			if (chan->chip->dw->hdata->restrict_axi_burst_len) {
   942				u32 burst_len = chan->chip->dw->hdata->axi_rw_burst_len;
   943	
   944				reg |= (CH_CTL_H_ARLEN_EN |
   945					burst_len << CH_CTL_H_ARLEN_POS |
   946					CH_CTL_H_AWLEN_EN |
   947					burst_len << CH_CTL_H_AWLEN_POS);
   948			}
   949			hw_desc->lli->ctl_hi = cpu_to_le32(reg);
   950	
   951			dst_burst_trans_len = chan->config.dst_maxburst ?
   952						__ffs(chan->config.dst_maxburst) - 1 :
   953						DWAXIDMAC_BURST_TRANS_LEN_4;
   954			if (dst_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
 > 955				return -EINVAL;
   956			reg |= dst_burst_trans_len << CH_CTL_L_DST_MSIZE_POS;
   957	
   958			src_burst_trans_len = chan->config.src_maxburst ?
   959						__ffs(chan->config.src_maxburst) - 1 :
   960						DWAXIDMAC_BURST_TRANS_LEN_4;
   961			if (src_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
   962				return -EINVAL;
   963			reg |= src_burst_trans_len << CH_CTL_L_SRC_MSIZE_POS;
   964	
   965			reg = (xfer_width << CH_CTL_L_DST_WIDTH_POS |
   966			       xfer_width << CH_CTL_L_SRC_WIDTH_POS |
   967			       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
   968			       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS);
   969			hw_desc->lli->ctl_lo = cpu_to_le32(reg);
   970	
   971			set_desc_src_master(hw_desc);
   972			set_desc_dest_master(hw_desc, desc);
   973	
   974			hw_desc->len = xfer_len;
   975			desc->length += hw_desc->len;
   976			/* update the length and addresses for the next loop cycle */
   977			len -= xfer_len;
   978			dst_adr += xfer_len;
   979			src_adr += xfer_len;
   980			num++;
   981		}
   982	
   983		/* Set end-of-link to the last link descriptor of list */
   984		set_desc_last(&desc->hw_desc[num - 1]);
   985		/* Managed transfer list */
   986		do {
   987			hw_desc = &desc->hw_desc[--num];
   988			write_desc_llp(hw_desc, llp | lms);
   989			llp = hw_desc->llp;
   990		} while (num);
   991	
   992		return vchan_tx_prep(&chan->vc, &desc->vd, flags);
   993	
   994	err_desc_get:
   995		if (desc)
   996			axi_desc_put(desc);
   997		return NULL;
   998	}
   999	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
