Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A78ED391
	for <lists+dmaengine@lfdr.de>; Sun,  3 Nov 2019 15:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKCOff (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 Nov 2019 09:35:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:31578 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfKCOfe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 3 Nov 2019 09:35:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 06:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,263,1569308400"; 
   d="scan'208";a="195205369"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2019 06:35:32 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iRGya-0008Wg-4E; Sun, 03 Nov 2019 22:35:32 +0800
Date:   Sun, 3 Nov 2019 22:34:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <a.gordeev.box@gmail.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <201911032232.QyQMzYkg%lkp@intel.com>
References: <d5301a136caa6cd1cfcfedf31e426a18a7c05c12.1572441900.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5301a136caa6cd1cfcfedf31e426a18a7c05c12.1572441900.git.a.gordeev.box@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Alexander,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.4-rc5]
[cannot apply to next-20191031]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Alexander-Gordeev/dmaengine-avalon-Intel-Avalon-MM-DMA-Interface-for-PCIe/20191102-044059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0dbe6cb8f7e05bc9611602ef45980a6c57b245a3
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-6-g57f8611-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/dma/avalon/avalon-hw.c:17:22: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] src_lo @@    got restrunsigned int [usertype] src_lo @@
>> drivers/dma/avalon/avalon-hw.c:17:22: sparse:    expected unsigned int [usertype] src_lo
>> drivers/dma/avalon/avalon-hw.c:17:22: sparse:    got restricted __le32 [usertype]
>> drivers/dma/avalon/avalon-hw.c:18:22: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] src_hi @@    got restrunsigned int [usertype] src_hi @@
>> drivers/dma/avalon/avalon-hw.c:18:22: sparse:    expected unsigned int [usertype] src_hi
   drivers/dma/avalon/avalon-hw.c:18:22: sparse:    got restricted __le32 [usertype]
>> drivers/dma/avalon/avalon-hw.c:19:22: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] dst_lo @@    got restrunsigned int [usertype] dst_lo @@
>> drivers/dma/avalon/avalon-hw.c:19:22: sparse:    expected unsigned int [usertype] dst_lo
   drivers/dma/avalon/avalon-hw.c:19:22: sparse:    got restricted __le32 [usertype]
>> drivers/dma/avalon/avalon-hw.c:20:22: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] dst_hi @@    got restrunsigned int [usertype] dst_hi @@
>> drivers/dma/avalon/avalon-hw.c:20:22: sparse:    expected unsigned int [usertype] dst_hi
   drivers/dma/avalon/avalon-hw.c:20:22: sparse:    got restricted __le32 [usertype]
>> drivers/dma/avalon/avalon-hw.c:21:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] ctl_dma_len @@    got restrunsigned int [usertype] ctl_dma_len @@
>> drivers/dma/avalon/avalon-hw.c:21:27: sparse:    expected unsigned int [usertype] ctl_dma_len
   drivers/dma/avalon/avalon-hw.c:21:27: sparse:    got restricted __le32 [usertype]
>> drivers/dma/avalon/avalon-hw.c:22:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
>> drivers/dma/avalon/avalon-hw.c:22:27: sparse:    expected unsigned int
   drivers/dma/avalon/avalon-hw.c:22:27: sparse:    got restricted __le32 [usertype]
   drivers/dma/avalon/avalon-hw.c:23:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/dma/avalon/avalon-hw.c:23:27: sparse:    expected unsigned int
   drivers/dma/avalon/avalon-hw.c:23:27: sparse:    got restricted __le32 [usertype]
   drivers/dma/avalon/avalon-hw.c:24:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/dma/avalon/avalon-hw.c:24:27: sparse:    expected unsigned int
   drivers/dma/avalon/avalon-hw.c:24:27: sparse:    got restricted __le32 [usertype]
--
>> drivers/dma/avalon/avalon-core.c:346:27: sparse: sparse: mixing different enum types:
>> drivers/dma/avalon/avalon-core.c:346:27: sparse:    unsigned int enum dma_transfer_direction
>> drivers/dma/avalon/avalon-core.c:346:27: sparse:    unsigned int enum dma_data_direction

vim +17 drivers/dma/avalon/avalon-hw.c

    13	
    14	static void setup_desc(struct dma_desc *desc, u32 desc_id,
    15			       u64 dest, u64 src, u32 size)
    16	{
  > 17		desc->src_lo = cpu_to_le32(src & 0xfffffffful);
  > 18		desc->src_hi = cpu_to_le32((src >> 32));
  > 19		desc->dst_lo = cpu_to_le32(dest & 0xfffffffful);
  > 20		desc->dst_hi = cpu_to_le32((dest >> 32));
  > 21		desc->ctl_dma_len = cpu_to_le32((size >> 2) | (desc_id << 18));
  > 22		desc->reserved[0] = cpu_to_le32(0x0);
    23		desc->reserved[1] = cpu_to_le32(0x0);
    24		desc->reserved[2] = cpu_to_le32(0x0);
    25	}
    26	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
