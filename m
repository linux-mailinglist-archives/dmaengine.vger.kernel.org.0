Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBC612BBD7
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 00:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfL0X5I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 18:57:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:43813 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfL0X5I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 18:57:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 15:57:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="scan'208";a="418456292"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Dec 2019 15:57:05 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ikzTd-0001sD-79; Sat, 28 Dec 2019 07:57:05 +0800
Date:   Sat, 28 Dec 2019 07:56:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     kbuild-all@lists.01.org, vkoul@kernel.org,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Gary.Hook@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: Re: [PATCH v2 1/3] dmaengine: ptdma: Initial driver for the AMD
 PassThru DMA engine
Message-ID: <201912280738.zotyIgEi%lkp@intel.com>
References: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sanjay,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Sanjay-R-Mehta/Add-AMD-PassThru-DMA-Engine-driver/20191227-234539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 46cf053efec6a3a5f343fead837777efe8252a46
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/dma/ptdma/ptdma-dev.c:151:25: sparse: sparse: cast from restricted __le32
>> drivers/dma/ptdma/ptdma-dev.c:151:23: sparse: sparse: incorrect type in assignment (different base types)
>> drivers/dma/ptdma/ptdma-dev.c:151:23: sparse:    expected unsigned int [usertype]
>> drivers/dma/ptdma/ptdma-dev.c:151:23: sparse:    got restricted __le32 [usertype]
   drivers/dma/ptdma/ptdma-dev.c:180:21: sparse: sparse: incorrect type in assignment (different base types)
>> drivers/dma/ptdma/ptdma-dev.c:180:21: sparse:    expected restricted __le32 [addressable] [assigned] [usertype] length
>> drivers/dma/ptdma/ptdma-dev.c:180:21: sparse:    got unsigned long long [usertype] src_len
   drivers/dma/ptdma/ptdma-dev.c:182:21: sparse: sparse: incorrect type in assignment (different base types)
>> drivers/dma/ptdma/ptdma-dev.c:182:21: sparse:    expected restricted __le32 [addressable] [assigned] [usertype] src_lo
>> drivers/dma/ptdma/ptdma-dev.c:182:21: sparse:    got unsigned int [usertype]
   drivers/dma/ptdma/ptdma-dev.c:185:21: sparse: sparse: incorrect type in assignment (different base types)
>> drivers/dma/ptdma/ptdma-dev.c:185:21: sparse:    expected restricted __le32 [addressable] [assigned] [usertype] dst_lo
   drivers/dma/ptdma/ptdma-dev.c:185:21: sparse:    got unsigned int [usertype]

vim +151 drivers/dma/ptdma/ptdma-dev.c

   132	
   133	static int pt_core_execute_cmd(struct ptdma_desc *desc,
   134				       struct pt_cmd_queue *cmd_q)
   135	{
   136		u32 *mp;
   137		__le32 *dp;
   138		u32 tail;
   139		int	i;
   140		int ret = 0;
   141	
   142		if (desc->dw0.soc) {
   143			desc->dw0.ioc = 1;
   144			desc->dw0.soc = 0;
   145		}
   146		mutex_lock(&cmd_q->q_mutex);
   147	
   148		mp = (u32 *)&cmd_q->qbase[cmd_q->qidx];
   149		dp = (__le32 *)desc;
   150		for (i = 0; i < 8; i++)
 > 151			mp[i] = cpu_to_le32(dp[i]); /* handle endianness */
   152	
   153		cmd_q->qidx = (cmd_q->qidx + 1) % cmd_queue_length;
   154	
   155		/* The data used by this command must be flushed to memory */
   156		wmb();
   157	
   158		/* Write the new tail address back to the queue register */
   159		tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
   160		iowrite32(tail, cmd_q->reg_tail_lo);
   161	
   162		/* Turn the queue back on using our cached control register */
   163		iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
   164		mutex_unlock(&cmd_q->q_mutex);
   165	
   166		return ret;
   167	}
   168	
   169	int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
   170				     struct pt_passthru_engine *pt_engine)
   171	{
   172		struct ptdma_desc desc;
   173	
   174		cmd_q->cmd_error = 0;
   175	
   176		memset(&desc, 0, Q_DESC_SIZE);
   177	
   178		desc.dw0.val = CMD_DESC_DW0_VAL;
   179	
 > 180		desc.length = pt_engine->src_len;
   181	
 > 182		desc.src_lo = lower_32_bits(pt_engine->src_dma);
   183		desc.dw3.src_hi = upper_32_bits(pt_engine->src_dma);
   184	
 > 185		desc.dst_lo = lower_32_bits(pt_engine->dst_dma);
   186		desc.dw5.dst_hi = upper_32_bits(pt_engine->dst_dma);
   187	
   188		return pt_core_execute_cmd(&desc, cmd_q);
   189	}
   190	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
