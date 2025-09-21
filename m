Return-Path: <dmaengine+bounces-6664-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5FBB8D4E8
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 06:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C727A16EE
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 04:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF3296BCB;
	Sun, 21 Sep 2025 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8W+f2Q9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9825C6FF;
	Sun, 21 Sep 2025 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758429815; cv=none; b=gGAZW0zCu23GSfvWmszWIxi09NjFAVLwTMYaYTPqwNdgybfrQ6/gR3Wrzyzathcf4bZESCbFF073IDIhxkjxSipqTsjPFG0JkNuMMrtsywmiIvxEKQhkveFG7PePMyFsGbcycWDIwRdS064bHgiOlB1Xuya7P3sR9Rtll2TVbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758429815; c=relaxed/simple;
	bh=U/6aYvciv7wPkVNop93gO0dgz3bi/mpTw4Fjq0YUBCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwgeg1AAkDi2cRgdsKzF82/X4zDFnEzpelbnSiOavgJLvud2aIE/zReIHLRg7Py2MnqXlFvKYXza++pB3+cw7tI5pome9HZYSe+IOF9so3MMtmlOcV+jv1DoLVaFB/VROwYc11kmtuy7O5HTxESYfcA09jo8XSowLbzcft1lxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8W+f2Q9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758429814; x=1789965814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U/6aYvciv7wPkVNop93gO0dgz3bi/mpTw4Fjq0YUBCo=;
  b=n8W+f2Q9NiZuZjpuVA4oHtsNgWUKeCJBz/Q4+pWZJ0cAQqcRtwNlxcXo
   oorbujiXFWQds/W4ZPkKY2cw1+Ndw9R63OcY4trKUljGPHXwa+epjUJG8
   ImnatBQLPQYygpA8XKllf+EKriFcQbf7UvD0qFd5kuXOt+e3AsBec+Eki
   V79eLngannmoSxXxxEIClJxDO1Q8P5JTj1dprfMf+9b+9FAU3kz9VDdtH
   Xet2bWcNqmnI3B5NzKv5ijXac2XXt6c96dZnchjns3pXhoBH27iPcnKuu
   vcnG49VrPjq5JI5L8kwptl/gOfE92n18T0ngdsobMemC8k1JPxQ2W1UqG
   w==;
X-CSE-ConnectionGUID: 66but7PYTjyNHrtqpG+MPg==
X-CSE-MsgGUID: 9+YSVYXbS0e0vrVkEmy9Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="59945722"
X-IronPort-AV: E=Sophos;i="6.18,282,1751266800"; 
   d="scan'208";a="59945722"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 21:43:33 -0700
X-CSE-ConnectionGUID: 9N0FngPCSY64MExk2m5y7A==
X-CSE-MsgGUID: eHAV4rnKRfq7zVz5rQm3vQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 20 Sep 2025 21:43:28 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0Bv3-0000RB-1l;
	Sun, 21 Sep 2025 04:43:25 +0000
Date: Sun, 21 Sep 2025 12:42:40 +0800
From: kernel test robot <lkp@intel.com>
To: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org,
	Dang Huynh <dang.huynh@mainlining.org>
Subject: Re: [PATCH 08/10] dmaengine: Add RDA IFC driver
Message-ID: <202509211252.z0s0XcXk-lkp@intel.com>
References: <20250919-rda8810pl-mmc-v1-8-d4f08a05ba4d@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-rda8810pl-mmc-v1-8-d4f08a05ba4d@mainlining.org>

Hi Dang,

kernel test robot noticed the following build errors:

[auto build test ERROR on ae2d20002576d2893ecaff25db3d7ef9190ac0b6]

url:    https://github.com/intel-lab-lkp/linux/commits/Dang-Huynh-via-B4-Relay/dt-bindings-gpio-rda-Make-interrupts-optional/20250919-025331
base:   ae2d20002576d2893ecaff25db3d7ef9190ac0b6
patch link:    https://lore.kernel.org/r/20250919-rda8810pl-mmc-v1-8-d4f08a05ba4d%40mainlining.org
patch subject: [PATCH 08/10] dmaengine: Add RDA IFC driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250921/202509211252.z0s0XcXk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509211252.z0s0XcXk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509211252.z0s0XcXk-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/rda-ifc.c: In function 'rda_ifc_prep_slave_sg':
>> drivers/dma/rda-ifc.c:180:28: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     180 |                 control |= FIELD_PREP(IFC_CTL_SIZE, 0);
         |                            ^~~~~~~~~~


vim +/FIELD_PREP +180 drivers/dma/rda-ifc.c

   145	
   146	static struct dma_async_tx_descriptor *rda_ifc_prep_slave_sg(struct dma_chan *chan,
   147			struct scatterlist *sgl, unsigned int sg_len,
   148			enum dma_transfer_direction direction, unsigned long dma_flags,
   149			void *context)
   150	{
   151		struct rda_ifc_chan *ifc_chan = to_ifc_chan(chan);
   152		struct rda_ifc *ifc = ifc_chan->rda_ifc;
   153		struct device *dev = dmaengine_get_dma_device(chan);
   154		struct scatterlist *sg;
   155		unsigned long flags;
   156		u32 control = 0;
   157		int width;
   158		int i;
   159	
   160		if (sg_len > ifc->sg_max) {
   161			dev_err(dev, "sg_len %d overflowed (max sg %d)\n",
   162					sg_len, ifc->sg_max);
   163			return NULL;
   164		}
   165	
   166		if (direction != ifc_chan->direction) {
   167			dev_err(dev, "Inconsistent transfer direction\n");
   168			return NULL;
   169		}
   170	
   171		spin_lock_irqsave(&ifc_chan->lock, flags);
   172	
   173		if (ifc_chan->direction == DMA_DEV_TO_MEM)
   174			width = ifc_chan->sconfig.src_addr_width;
   175		else
   176			width = ifc_chan->sconfig.dst_addr_width;
   177	
   178		switch (width) {
   179		case DMA_SLAVE_BUSWIDTH_1_BYTE:
 > 180			control |= FIELD_PREP(IFC_CTL_SIZE, 0);
   181			break;
   182		case DMA_SLAVE_BUSWIDTH_2_BYTES:
   183			control |= FIELD_PREP(IFC_CTL_SIZE, 1);
   184			break;
   185		case DMA_SLAVE_BUSWIDTH_4_BYTES:
   186			control |= FIELD_PREP(IFC_CTL_SIZE, 2);
   187			break;
   188		default:
   189			return NULL;
   190		}
   191	
   192		for_each_sg(sgl, sg, sg_len, i) {
   193			if (!IS_ALIGNED(sg_dma_address(sg), width)) {
   194				dev_err(dev, "Unaligned DMA address\n");
   195				spin_unlock_irqrestore(&ifc_chan->lock, flags);
   196				return NULL;
   197			}
   198	
   199			writel(sg_dma_address(sg), ifc_chan->chan_base + IFC_REG_SG_START_ADDR + (8 * i));
   200			writel(sg_dma_len(sg), ifc_chan->chan_base + IFC_REG_SG_TC + (8 * i));
   201		}
   202	
   203		control |= FIELD_PREP(IFC_CTL_REQ_SRC, ifc_chan->request_id) |
   204			IFC_CTL_CH_RD_HW_EXCH |
   205			FIELD_PREP(IFC_CTL_SG_NUM, sg_len-1);
   206		writel(control, ifc_chan->chan_base);
   207	
   208		spin_unlock_irqrestore(&ifc_chan->lock, flags);
   209	
   210		dma_async_tx_descriptor_init(&ifc_chan->tx, chan);
   211		ifc_chan->tx.tx_submit = rda_ifc_tx_submit;
   212	
   213		return &ifc_chan->tx;
   214	}
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

