Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA245FD74
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 09:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352970AbhK0IrD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Nov 2021 03:47:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:33922 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhK0IpD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 27 Nov 2021 03:45:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="299151605"
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="299151605"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 00:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="652368341"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2021 00:41:44 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqtHE-0009Gv-3M; Sat, 27 Nov 2021 08:41:44 +0000
Date:   Sat, 27 Nov 2021 16:41:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v13 2/4] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <202111271635.HuTbjmfG-lkp@intel.com>
References: <1637573292-13214-3-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637573292-13214-3-git-send-email-akhilrajeev@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Akhil,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on vkoul-dmaengine/next arm64/for-next/core v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Akhil-R/Add-NVIDIA-Tegra-GPC-DMA-driver/20211122-173019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: csky-randconfig-r005-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271635.HuTbjmfG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7707da9f914433ccc5718dd3431153d3b5bf485d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Akhil-R/Add-NVIDIA-Tegra-GPC-DMA-driver/20211122-173019
        git checkout 7707da9f914433ccc5718dd3431153d3b5bf485d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash drivers/ kernel//

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/dma/tegra186-gpc-dma.c: In function 'tegra_dma_prep_dma_memset':
>> drivers/dma/tegra186-gpc-dma.c:791:74: warning: right shift count >= width of type [-Wshift-count-overflow]
     791 |                         FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                                                                          ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:791:25: note: in expansion of macro 'FIELD_PREP'
     791 |                         FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                         ^~~~~~~~~~
>> drivers/dma/tegra186-gpc-dma.c:791:74: warning: right shift count >= width of type [-Wshift-count-overflow]
     791 |                         FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                                                                          ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:791:25: note: in expansion of macro 'FIELD_PREP'
     791 |                         FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                         ^~~~~~~~~~
   In file included from drivers/dma/tegra186-gpc-dma.c:8:
>> drivers/dma/tegra186-gpc-dma.c:791:74: warning: right shift count >= width of type [-Wshift-count-overflow]
     791 |                         FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                                                                          ^~
   include/linux/bitfield.h:95:34: note: in definition of macro 'FIELD_PREP'
      95 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
   In file included from <command-line>:
   drivers/dma/tegra186-gpc-dma.c: In function 'tegra_dma_prep_dma_memcpy':
   drivers/dma/tegra186-gpc-dma.c:858:65: warning: right shift count >= width of type [-Wshift-count-overflow]
     858 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
         |                                                                 ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:858:17: note: in expansion of macro 'FIELD_PREP'
     858 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
         |                 ^~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:858:65: warning: right shift count >= width of type [-Wshift-count-overflow]
     858 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
         |                                                                 ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:858:17: note: in expansion of macro 'FIELD_PREP'
     858 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
         |                 ^~~~~~~~~~
   In file included from drivers/dma/tegra186-gpc-dma.c:8:
   drivers/dma/tegra186-gpc-dma.c:858:65: warning: right shift count >= width of type [-Wshift-count-overflow]
     858 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
         |                                                                 ^~
   include/linux/bitfield.h:95:34: note: in definition of macro 'FIELD_PREP'
      95 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
   In file included from <command-line>:
   drivers/dma/tegra186-gpc-dma.c:860:66: warning: right shift count >= width of type [-Wshift-count-overflow]
     860 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                                                                  ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:860:17: note: in expansion of macro 'FIELD_PREP'
     860 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                 ^~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:860:66: warning: right shift count >= width of type [-Wshift-count-overflow]
     860 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                                                                  ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:860:17: note: in expansion of macro 'FIELD_PREP'
     860 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                 ^~~~~~~~~~
   In file included from drivers/dma/tegra186-gpc-dma.c:8:


vim +791 drivers/dma/tegra186-gpc-dma.c

   737	
   738	static struct dma_async_tx_descriptor *
   739	tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
   740				  size_t len, unsigned long flags)
   741	{
   742		struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
   743		unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
   744		struct tegra_dma_desc *dma_desc;
   745		unsigned long csr, mc_seq;
   746	
   747		if ((len & 3) || (dest & 3) || len > max_dma_count) {
   748			dev_err(tdc2dev(tdc),
   749				"DMA length/memory address is not supported\n");
   750			return NULL;
   751		}
   752	
   753		/* Set dma mode to fixed pattern */
   754		csr = TEGRA_GPCDMA_CSR_DMA_FIXED_PAT;
   755		/* Enable once or continuous mode */
   756		csr |= TEGRA_GPCDMA_CSR_ONCE;
   757		/* Enable IRQ mask */
   758		csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
   759		/* Enable the dma interrupt */
   760		if (flags & DMA_PREP_INTERRUPT)
   761			csr |= TEGRA_GPCDMA_CSR_IE_EOC;
   762		/* Configure default priority weight for the channel */
   763		csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
   764	
   765		mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
   766		/* retain stream-id and clean rest */
   767		mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
   768	
   769		/* Set the address wrapping */
   770		mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
   771							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
   772		mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
   773							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
   774	
   775		/* Program outstanding MC requests */
   776		mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
   777		/* Set burst size */
   778		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
   779	
   780		dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
   781		if (!dma_desc)
   782			return NULL;
   783	
   784		dma_desc->bytes_requested = 0;
   785		dma_desc->bytes_transferred = 0;
   786	
   787		dma_desc->bytes_requested += len;
   788		tdc->ch_regs.src_ptr = 0;
   789		tdc->ch_regs.dst_ptr = dest;
   790		tdc->ch_regs.high_addr_ptr =
 > 791				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
   792		tdc->ch_regs.fixed_pattern = value;
   793		/* Word count reg takes value as (N +1) words */
   794		tdc->ch_regs.wcount = ((len - 4) >> 2);
   795		tdc->ch_regs.csr = csr;
   796		tdc->ch_regs.mmio_seq = 0;
   797		tdc->ch_regs.mc_seq = mc_seq;
   798	
   799		tdc->dma_desc = dma_desc;
   800	
   801		return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
   802	}
   803	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
