Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412F759C050
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiHVNQe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiHVNOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 09:14:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125F4B1D7;
        Mon, 22 Aug 2022 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661174077; x=1692710077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WAob+mo4g+EjtYO9n5soxiAkQ5tVT5mjRP8SgQX0eI0=;
  b=jZXPr9qCo9JjKIHc3Jwj1/MLUZgVVJiWo9AM/77HcWZ+ba78ueL3sn4e
   EMoqs7X7dpG7laA+Cu9y9pgWDNl0ojKNAfmZyC1cn4YudrdtRdl1bJ1Ke
   YVG+siTfYtVeom2EaNNaDr7grbJyDFMcyqd/gM5vyqaLsosXKiu/4LC0R
   wPcO5+t12v/ablQ+MhyQaRz0XiZs1veDUk5gjzf8ZU+TZAyul6wCBGOa+
   RL1JMnw3g/a4ecaxi/51upNhGYbDWZ8yuvxoqSsXg6SKDu2dbmuDAJQty
   lA3s35GcuNuauSTQfPbBjkoVoO2VU6Zm4QQc+JS2U4xAi2eoS1AL+gH7l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273797262"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="273797262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 06:14:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="559740620"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2022 06:14:32 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ7GC-00006j-0k;
        Mon, 22 Aug 2022 13:14:32 +0000
Date:   Mon, 22 Aug 2022 21:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>, peter.ujfalusi@gmail.com,
        vkoul@kernel.org, broonie@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     kbuild-all@lists.01.org, vigneshr@ti.com, kishon@ti.com,
        vaishnav.a@ti.com
Subject: Re: [PATCH 2/2] spi: spi-omap2-mcspi: Use EOW interrupt for
 completion when DMA enabled
Message-ID: <202208222100.SKGSz2m9-lkp@intel.com>
References: <20220822091531.27827-3-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822091531.27827-3-vaishnav.a@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vaishnav,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on broonie-spi/for-next linus/master v6.0-rc2 next-20220822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vaishnav-Achath/spi-spi-omap2-mcspi-Use-EOW-interrupt-for-transfer-completion/20220822-171807
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: arc-randconfig-r043-20220821 (https://download.01.org/0day-ci/archive/20220822/202208222100.SKGSz2m9-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/492d819558f7cb9fb64d860042c6ca17a054c3f7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vaishnav-Achath/spi-spi-omap2-mcspi-Use-EOW-interrupt-for-transfer-completion/20220822-171807
        git checkout 492d819558f7cb9fb64d860042c6ca17a054c3f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/spi/spi-omap2-mcspi.c: In function 'omap2_mcspi_txrx_dma':
>> drivers/spi/spi-omap2-mcspi.c:549:34: warning: variable 'mcspi_dma' set but not used [-Wunused-but-set-variable]
     549 |         struct omap2_mcspi_dma  *mcspi_dma;
         |                                  ^~~~~~~~~


vim +/mcspi_dma +549 drivers/spi/spi-omap2-mcspi.c

d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  543  
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  544  static unsigned
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  545  omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  546  {
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  547  	struct omap2_mcspi	*mcspi;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  548  	struct omap2_mcspi_cs	*cs = spi->controller_state;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11 @549  	struct omap2_mcspi_dma  *mcspi_dma;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  550  	unsigned int		count;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  551  	u8			*rx;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  552  	const u8		*tx;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  553  	struct dma_slave_config	cfg;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  554  	enum dma_slave_buswidth width;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  555  	unsigned es;
e47a682ace0cd5 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-11-06  556  	void __iomem		*chstat_reg;
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  557  	int			wait_res;
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  558  	int ret;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  559  
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  560  	mcspi = spi_master_get_devdata(spi->master);
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  561  	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  562  
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  563  	if (cs->word_len <= 8) {
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  564  		width = DMA_SLAVE_BUSWIDTH_1_BYTE;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  565  		es = 1;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  566  	} else if (cs->word_len <= 16) {
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  567  		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  568  		es = 2;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  569  	} else {
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  570  		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  571  		es = 4;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  572  	}
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  573  
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  574  	count = xfer->len;
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  575  
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  576  	memset(&cfg, 0, sizeof(cfg));
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  577  	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  578  	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  579  	cfg.src_addr_width = width;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  580  	cfg.dst_addr_width = width;
baf8b9f8d260c5 drivers/spi/spi-omap2-mcspi.c Vignesh R       2019-01-15  581  	cfg.src_maxburst = 1;
baf8b9f8d260c5 drivers/spi/spi-omap2-mcspi.c Vignesh R       2019-01-15  582  	cfg.dst_maxburst = 1;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  583  
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  584  	rx = xfer->rx_buf;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  585  	tx = xfer->tx_buf;
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  586  
89e8b9cb846515 drivers/spi/spi-omap2-mcspi.c Vignesh R       2018-10-15  587  	mcspi->slave_aborted = false;
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  588  	reinit_completion(&mcspi->txrxdone);
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  589  	mcspi_write_reg(spi->master, OMAP2_MCSPI_IRQENABLE,	OMAP2_MCSPI_IRQSTATUS_EOW);
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  590  	if (tx)
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  591  		omap2_mcspi_tx_dma(spi, xfer, cfg);
d7b4394e780b02 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-09-11  592  
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  593  	if (rx)
e47a682ace0cd5 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-11-06  594  		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
e47a682ace0cd5 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-11-06  595  
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  596  	ret = mcspi_wait_for_completion(mcspi, &mcspi->txrxdone);
89e8b9cb846515 drivers/spi/spi-omap2-mcspi.c Vignesh R       2018-10-15  597  	omap2_mcspi_set_dma_req(spi, 0, 0);
89e8b9cb846515 drivers/spi/spi-omap2-mcspi.c Vignesh R       2018-10-15  598  	if (ret || mcspi->slave_aborted)
89e8b9cb846515 drivers/spi/spi-omap2-mcspi.c Vignesh R       2018-10-15  599  		return 0;
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  600  
e47a682ace0cd5 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-11-06  601  	/* for TX_ONLY mode, be sure all words have shifted out */
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  602  	if (tx && !rx) {
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  603  		chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  604  		if (mcspi->fifo_depth > 0) {
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  605  			wait_res = mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXFFE);
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  606  			if (wait_res < 0)
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  607  				dev_err(&spi->dev, "TXFFE timed out\n");
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  608  		} else {
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  609  			wait_res = mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS);
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  610  			if (wait_res < 0)
e47a682ace0cd5 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-11-06  611  				dev_err(&spi->dev, "TXS timed out\n");
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  612  		}
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  613  		if (wait_res >= 0 && (mcspi_wait_for_reg_bit(chstat_reg,
d33f473dcd8e69 drivers/spi/spi-omap2-mcspi.c Illia Smyrnov   2013-06-17  614  							     OMAP2_MCSPI_CHSTAT_EOT) < 0))
e47a682ace0cd5 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-11-06  615  			dev_err(&spi->dev, "EOT timed out\n");
e47a682ace0cd5 drivers/spi/spi-omap2-mcspi.c Shubhrajyoti D  2012-11-06  616  	}
492d819558f7cb drivers/spi/spi-omap2-mcspi.c Vaishnav Achath 2022-08-22  617  
ccdc7bf925731e drivers/spi/omap2_mcspi.c     Samuel Ortiz    2007-07-17  618  	return count;
ccdc7bf925731e drivers/spi/omap2_mcspi.c     Samuel Ortiz    2007-07-17  619  }
ccdc7bf925731e drivers/spi/omap2_mcspi.c     Samuel Ortiz    2007-07-17  620  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
