Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB9543FE6E
	for <lists+dmaengine@lfdr.de>; Fri, 29 Oct 2021 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJ2Obj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Oct 2021 10:31:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:32175 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhJ2Obi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 Oct 2021 10:31:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="254259134"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="gz'50?scan'50,208,50";a="254259134"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 07:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="gz'50?scan'50,208,50";a="665848329"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2021 07:29:04 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgSsM-0000O1-Rk; Fri, 29 Oct 2021 14:28:58 +0000
Date:   Fri, 29 Oct 2021 22:27:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     kbuild-all@lists.01.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com
Subject: Re: [PATCH v11 2/4] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <202110292205.AyO0xhLM-lkp@intel.com>
References: <1635427419-22478-3-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <1635427419-22478-3-git-send-email-akhilrajeev@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Akhil,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on vkoul-dmaengine/next arm64/for-next/core v5.15-rc7 next-20211029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Akhil-R/Add-NVIDIA-Tegra-GPC-DMA-driver/20211028-212920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: openrisc-randconfig-r031-20211029 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/020f86b695432467db8b697540871173f6d751c8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Akhil-R/Add-NVIDIA-Tegra-GPC-DMA-driver/20211028-212920
        git checkout 020f86b695432467db8b697540871173f6d751c8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   include/linux/minmax.h:89:28: note: in expansion of macro 'min'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                            ^~~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y)       __careful_cmp(x, y, >)
         |                         ^~~~~~~~~~~~~
   include/linux/minmax.h:89:45: note: in expansion of macro 'max'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                                             ^~~
   drivers/dma/tegra186-gpc-dma.c:692:9: note: in expansion of macro 'clamp'
     692 |         clamp(burst_mmio_width, TEGRA_GPCDMA_MMIOSEQ_BURST_MIN,
         |         ^~~~~
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:28:40: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                        ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   include/linux/minmax.h:89:28: note: in expansion of macro 'min'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                            ^~~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y)       __careful_cmp(x, y, >)
         |                         ^~~~~~~~~~~~~
   include/linux/minmax.h:89:45: note: in expansion of macro 'max'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                                             ^~~
   drivers/dma/tegra186-gpc-dma.c:692:9: note: in expansion of macro 'clamp'
     692 |         clamp(burst_mmio_width, TEGRA_GPCDMA_MMIOSEQ_BURST_MIN,
         |         ^~~~~
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:31:24: note: in definition of macro '__cmp_once'
      31 |                 typeof(x) unique_x = (x);               \
         |                        ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   include/linux/minmax.h:89:28: note: in expansion of macro 'min'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                            ^~~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y)       __careful_cmp(x, y, >)
         |                         ^~~~~~~~~~~~~
   include/linux/minmax.h:89:45: note: in expansion of macro 'max'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                                             ^~~
   drivers/dma/tegra186-gpc-dma.c:692:9: note: in expansion of macro 'clamp'
     692 |         clamp(burst_mmio_width, TEGRA_GPCDMA_MMIOSEQ_BURST_MIN,
         |         ^~~~~
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:31:39: note: in definition of macro '__cmp_once'
      31 |                 typeof(x) unique_x = (x);               \
         |                                       ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   include/linux/minmax.h:89:28: note: in expansion of macro 'min'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                            ^~~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y)       __careful_cmp(x, y, >)
         |                         ^~~~~~~~~~~~~
   include/linux/minmax.h:89:45: note: in expansion of macro 'max'
      89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
         |                                             ^~~
   drivers/dma/tegra186-gpc-dma.c:692:9: note: in expansion of macro 'clamp'
     692 |         clamp(burst_mmio_width, TEGRA_GPCDMA_MMIOSEQ_BURST_MIN,
         |         ^~~~~
   drivers/dma/tegra186-gpc-dma.c: In function 'tegra_dma_prep_dma_memset':
>> drivers/dma/tegra186-gpc-dma.c:785:74: warning: right shift count >= width of type [-Wshift-count-overflow]
     785 |                         FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                                                                          ^~
   drivers/dma/tegra186-gpc-dma.c: In function 'tegra_dma_prep_dma_memcpy':
   drivers/dma/tegra186-gpc-dma.c:852:65: warning: right shift count >= width of type [-Wshift-count-overflow]
     852 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
         |                                                                 ^~
   drivers/dma/tegra186-gpc-dma.c:854:66: warning: right shift count >= width of type [-Wshift-count-overflow]
     854 |                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
         |                                                                  ^~
   drivers/dma/tegra186-gpc-dma.c: In function 'tegra_dma_prep_slave_sg':
   drivers/dma/tegra186-gpc-dma.c:960:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     960 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
         |                                                                                 ^~
   drivers/dma/tegra186-gpc-dma.c:965:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     965 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
         |                                                                                 ^~
   cc1: some warnings being treated as errors


vim +785 drivers/dma/tegra186-gpc-dma.c

   676	
   677	static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
   678					   u32 burst_size, enum dma_slave_buswidth slave_bw,
   679					   int len)
   680	{
   681		unsigned int burst_mmio_width, burst_byte;
   682	
   683		/*
   684		 * burst_size from client is in terms of the bus_width.
   685		 * convert that into words.
   686		 * If burst_size is not specified from client, then use
   687		 * len to calculate the optimum burst size
   688		 */
   689		burst_byte = burst_size ? burst_size * slave_bw : len;
   690		burst_mmio_width = burst_byte / 4;
   691	
 > 692		clamp(burst_mmio_width, TEGRA_GPCDMA_MMIOSEQ_BURST_MIN,
   693		      TEGRA_GPCDMA_MMIOSEQ_BURST_MAX);
   694	
   695		return (fls(burst_mmio_width) - 1) << TEGRA_GPCDMA_MMIOSEQ_BURST_SHIFT;
   696	}
   697	
   698	static int get_transfer_param(struct tegra_dma_channel *tdc,
   699				      enum dma_transfer_direction direction,
   700				      unsigned long *apb_addr,
   701				      unsigned long *mmio_seq,
   702				      unsigned long *csr,
   703				      unsigned int *burst_size,
   704				      enum dma_slave_buswidth *slave_bw)
   705	{
   706		switch (direction) {
   707		case DMA_MEM_TO_DEV:
   708			*apb_addr = tdc->dma_sconfig.dst_addr;
   709			*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.dst_addr_width);
   710			*burst_size = tdc->dma_sconfig.dst_maxburst;
   711			*slave_bw = tdc->dma_sconfig.dst_addr_width;
   712			*csr = TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC;
   713			return 0;
   714		case DMA_DEV_TO_MEM:
   715			*apb_addr = tdc->dma_sconfig.src_addr;
   716			*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.src_addr_width);
   717			*burst_size = tdc->dma_sconfig.src_maxburst;
   718			*slave_bw = tdc->dma_sconfig.src_addr_width;
   719			*csr = TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC;
   720			return 0;
   721		case DMA_MEM_TO_MEM:
   722			*burst_size = tdc->dma_sconfig.src_addr_width;
   723			*csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
   724			return 0;
   725		default:
   726			dev_err(tdc2dev(tdc), "DMA direction is not supported\n");
   727		}
   728	
   729		return -EINVAL;
   730	}
   731	
   732	static struct dma_async_tx_descriptor *
   733	tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
   734				  size_t len, unsigned long flags)
   735	{
   736		struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
   737		unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
   738		struct tegra_dma_desc *dma_desc;
   739		unsigned long csr, mc_seq;
   740	
   741		if ((len & 3) || (dest & 3) || len > max_dma_count) {
   742			dev_err(tdc2dev(tdc),
   743				"DMA length/memory address is not supported\n");
   744			return NULL;
   745		}
   746	
   747		/* Set dma mode to fixed pattern */
   748		csr = TEGRA_GPCDMA_CSR_DMA_FIXED_PAT;
   749		/* Enable once or continuous mode */
   750		csr |= TEGRA_GPCDMA_CSR_ONCE;
   751		/* Enable IRQ mask */
   752		csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
   753		/* Enable the dma interrupt */
   754		if (flags & DMA_PREP_INTERRUPT)
   755			csr |= TEGRA_GPCDMA_CSR_IE_EOC;
   756		/* Configure default priority weight for the channel */
   757		csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
   758	
   759		mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
   760		/* retain stream-id and clean rest */
   761		mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
   762	
   763		/* Set the address wrapping */
   764		mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
   765							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
   766		mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
   767							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
   768	
   769		/* Program outstanding MC requests */
   770		mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
   771		/* Set burst size */
   772		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
   773	
   774		dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
   775		if (!dma_desc)
   776			return NULL;
   777	
   778		dma_desc->bytes_requested = 0;
   779		dma_desc->bytes_transferred = 0;
   780	
   781		dma_desc->bytes_requested += len;
   782		tdc->ch_regs.src_ptr = 0;
   783		tdc->ch_regs.dst_ptr = dest;
   784		tdc->ch_regs.high_addr_ptr =
 > 785				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
   786		tdc->ch_regs.fixed_pattern = value;
   787		/* Word count reg takes value as (N +1) words */
   788		tdc->ch_regs.wcount = ((len - 4) >> 2);
   789		tdc->ch_regs.csr = csr;
   790		tdc->ch_regs.mmio_seq = 0;
   791		tdc->ch_regs.mc_seq = mc_seq;
   792	
   793		tdc->dma_desc = dma_desc;
   794	
   795		return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
   796	}
   797	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--1yeeQ81UyVL57Vl7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--1yeeQ81UyVL57Vl7--
