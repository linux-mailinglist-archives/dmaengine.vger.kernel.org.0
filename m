Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6A7D5AD4
	for <lists+dmaengine@lfdr.de>; Tue, 24 Oct 2023 20:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbjJXSoZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Oct 2023 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjJXSoZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Oct 2023 14:44:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3C12C;
        Tue, 24 Oct 2023 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698173062; x=1729709062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXiUqDTjJlLIfMRjPSDr+1lzyNKgBoHGKVQdpfNmqY8=;
  b=hcVwqSt718wpKv4DJWwNltj/5u6fSw53QEivE872BngUGa1PGCXmyyuq
   7CVkEL81lz8Kyrs/UULmlL5DnLCNBhIUtG/4CYNI0GqV294wVgq7xxWnc
   WMs2J9rV5y7glYZlLliXmv7fUs2J1+2CvPMAJg/kXwVV7oPSn+3Bl6dah
   ZPO4jL6QYvVihfSaSQrpvsJmagV0KStB9j6+0iaWuubmEzYyoFXAMxkHR
   bG8rUga3MzEelKaSqBslwYPQi0dug1JyEy/OOnlAjCdBcvc/KTQt4wxjA
   eD5If/tSR0KijipOwqXisZ3VsDB2SYZLZ02V/ibPg8BVSFWFZxMxDtymj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389993640"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="389993640"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 11:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6558967"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 11:44:12 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvMO0-0008AD-2M;
        Tue, 24 Oct 2023 18:44:16 +0000
Date:   Wed, 25 Oct 2023 02:43:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Mengqi <guomengqi3@huawei.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, xuqiang36@huawei.com,
        chenweilong@huawei.com, guomengqi3@huawei.com
Subject: Re: [PATCH v5 1/2] dmaengine: Add HiSilicon Ascend SDMA engine
 support
Message-ID: <202310250208.jwwNXco0-lkp@intel.com>
References: <20231021093454.39822-2-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021093454.39822-2-guomengqi3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Guo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.6-rc7 next-20231024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guo-Mengqi/dmaengine-Add-HiSilicon-Ascend-SDMA-engine-support/20231021-174034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20231021093454.39822-2-guomengqi3%40huawei.com
patch subject: [PATCH v5 1/2] dmaengine: Add HiSilicon Ascend SDMA engine support
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20231025/202310250208.jwwNXco0-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310250208.jwwNXco0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310250208.jwwNXco0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/mmu_context.h:18,
                    from include/linux/mmu_context.h:5,
                    from drivers/iommu/iommu-sva.c:5:
>> include/asm-generic/mm_hooks.h:10:40: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      10 | static inline int arch_dup_mmap(struct mm_struct *oldmm,
         |                                        ^~~~~~~~~
   include/asm-generic/mm_hooks.h:16:42: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      16 | static inline void arch_exit_mmap(struct mm_struct *mm)
         |                                          ^~~~~~~~~
   include/asm-generic/mm_hooks.h:20:38: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      20 | static inline void arch_unmap(struct mm_struct *mm,
         |                                      ^~~~~~~~~
   include/asm-generic/mm_hooks.h:25:15: error: unknown type name 'bool'
      25 | static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
         |               ^~~~
   include/asm-generic/mm_hooks.h:26:17: error: unknown type name 'bool'
      26 |                 bool write, bool execute, bool foreign)
         |                 ^~~~
   include/asm-generic/mm_hooks.h:1:1: note: 'bool' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
     +++ |+#include <stdbool.h>
       1 | /* SPDX-License-Identifier: GPL-2.0 */
   include/asm-generic/mm_hooks.h:26:29: error: unknown type name 'bool'
      26 |                 bool write, bool execute, bool foreign)
         |                             ^~~~
   include/asm-generic/mm_hooks.h:26:29: note: 'bool' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
   include/asm-generic/mm_hooks.h:26:43: error: unknown type name 'bool'
      26 |                 bool write, bool execute, bool foreign)
         |                                           ^~~~
   include/asm-generic/mm_hooks.h:26:43: note: 'bool' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
>> arch/openrisc/include/asm/mmu_context.h:21:61: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      21 | extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
         |                                                             ^~~~~~~~~
>> arch/openrisc/include/asm/mmu_context.h:21:36: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
      21 | extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
         |                                    ^~~~~~~~~~~
   arch/openrisc/include/asm/mmu_context.h:23:36: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      23 | extern void destroy_context(struct mm_struct *mm);
         |                                    ^~~~~~~~~
   arch/openrisc/include/asm/mmu_context.h:25:30: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
      25 |                       struct task_struct *tsk);
         |                              ^~~~~~~~~~~
   arch/openrisc/include/asm/mmu_context.h:24:30: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      24 | extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
         |                              ^~~~~~~~~
   arch/openrisc/include/asm/mmu_context.h:33:17: error: unknown type name 'pgd_t'
      33 | extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
         |                 ^~~~~
   include/linux/mmu_context.h:39:15: error: unknown type name 'bool'
      39 | static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
         |               ^~~~
   include/linux/mmu_context.h: In function 'arch_pgtable_dma_compat':
   include/linux/mmu_context.h:41:16: error: 'true' undeclared (first use in this function)
      41 |         return true;
         |                ^~~~
   include/linux/mmu_context.h:7:1: note: 'true' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
       6 | #include <asm/mmu.h>
     +++ |+#include <stdbool.h>
       7 | 
   include/linux/mmu_context.h:41:16: note: each undeclared identifier is reported only once for each function it appears in
      41 |         return true;
         |                ^~~~
   include/linux/mmu_context.h:42:1: error: control reaches end of non-void function [-Werror=return-type]
      42 | }
         | ^
   cc1: some warnings being treated as errors


vim +10 include/asm-generic/mm_hooks.h

d6dd61c831226f Jeremy Fitzhardinge 2007-05-02   9  
c10e83f598d080 Thomas Gleixner     2017-12-14 @10  static inline int arch_dup_mmap(struct mm_struct *oldmm,
d6dd61c831226f Jeremy Fitzhardinge 2007-05-02  11  				struct mm_struct *mm)
d6dd61c831226f Jeremy Fitzhardinge 2007-05-02  12  {
c10e83f598d080 Thomas Gleixner     2017-12-14  13  	return 0;
d6dd61c831226f Jeremy Fitzhardinge 2007-05-02  14  }
d6dd61c831226f Jeremy Fitzhardinge 2007-05-02  15  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
