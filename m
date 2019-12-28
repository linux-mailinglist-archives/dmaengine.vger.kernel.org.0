Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB712BC1F
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 02:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfL1BY1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 20:24:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:24404 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfL1BY0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 20:24:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 17:24:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; 
   d="scan'208";a="215323905"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2019 17:24:22 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1il0q5-000CPm-Q2; Sat, 28 Dec 2019 09:24:21 +0800
Date:   Sat, 28 Dec 2019 09:24:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     kbuild-all@lists.01.org, vkoul@kernel.org,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Gary.Hook@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: Re: [PATCH v2 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
 information
Message-ID: <201912280954.bhIA5CBF%lkp@intel.com>
References: <1577458112-109734-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577458112-109734-1-git-send-email-Sanju.Mehta@amd.com>
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

>> drivers/dma/ptdma/ptdma-dev.c:139:5: sparse: sparse: symbol 'pt_present' was not declared. Should it be static?
   drivers/dma/ptdma/ptdma-dev.c:169:25: sparse: sparse: cast from restricted __le32
   drivers/dma/ptdma/ptdma-dev.c:169:23: sparse: sparse: incorrect type in assignment (different base types)
   drivers/dma/ptdma/ptdma-dev.c:169:23: sparse:    expected unsigned int [usertype]
   drivers/dma/ptdma/ptdma-dev.c:169:23: sparse:    got restricted __le32 [usertype]
   drivers/dma/ptdma/ptdma-dev.c:199:21: sparse: sparse: incorrect type in assignment (different base types)
   drivers/dma/ptdma/ptdma-dev.c:199:21: sparse:    expected restricted __le32 [addressable] [assigned] [usertype] length
   drivers/dma/ptdma/ptdma-dev.c:199:21: sparse:    got unsigned long long [usertype] src_len
   drivers/dma/ptdma/ptdma-dev.c:201:21: sparse: sparse: incorrect type in assignment (different base types)
   drivers/dma/ptdma/ptdma-dev.c:201:21: sparse:    expected restricted __le32 [addressable] [assigned] [usertype] src_lo
   drivers/dma/ptdma/ptdma-dev.c:201:21: sparse:    got unsigned int [usertype]
   drivers/dma/ptdma/ptdma-dev.c:204:21: sparse: sparse: incorrect type in assignment (different base types)
   drivers/dma/ptdma/ptdma-dev.c:204:21: sparse:    expected restricted __le32 [addressable] [assigned] [usertype] dst_lo
   drivers/dma/ptdma/ptdma-dev.c:204:21: sparse:    got unsigned int [usertype]

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
