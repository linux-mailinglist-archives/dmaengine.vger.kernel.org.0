Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72230713486
	for <lists+dmaengine@lfdr.de>; Sat, 27 May 2023 13:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjE0LsG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 May 2023 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjE0LsG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 May 2023 07:48:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6FEBB;
        Sat, 27 May 2023 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685188084; x=1716724084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HduercbIudkggjRz+jUJoxBAuOs1kh2dy/JWAQRuJ1A=;
  b=AJF9oalWwT5MrVh3Vqve0ySTGfSTWc9/5LYM30EHkyrcWOp2emOR/wZd
   hlp8Hahm0cSynLQmheQcXZkeeOANa/OrGTrLrYgMsDl7y049xxe4iEGqB
   yQQIgAs+Q6R1LB8YorA9Bj54qCJIJdctNLd1bQrb1v0KLb5/fA1MDMz6Z
   UvwFu68JwAT7RbyFajpoUJ9osxurxj9MU7XbvU5Af9E8kOSP61TIoGFWp
   5ZMWuTllxNTSdGoDzeN+TgQxytKUgporKZmhZ4WIHHpniXoaipdDNu8rl
   cAfysNmj05hRVsbSerP9V8yYesjzSJgC/r0fOiuLXwaBtAmK1HWMLweFT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="353233280"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="353233280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 04:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="849822661"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="849822661"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2023 04:48:02 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2sOv-000JwM-0c;
        Sat, 27 May 2023 11:48:01 +0000
Date:   Sat, 27 May 2023 19:47:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Nishad Saraf <nishads@amd.com>,
        max.zhen@amd.com, sonal.santan@amd.com, nishad.saraf@amd.com,
        Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH V1 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Message-ID: <202305271937.niKlwa4h-lkp@intel.com>
References: <1685119795-11729-2-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685119795-11729-2-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lizhi,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Hou/dmaengine-amd-qdma-Add-AMD-QDMA-driver/20230527-005214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/1685119795-11729-2-git-send-email-lizhi.hou%40amd.com
patch subject: [PATCH V1 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230527/202305271937.niKlwa4h-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d300fd23b7ecbcc89512dba3fa745941c1c03fac
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lizhi-Hou/dmaengine-amd-qdma-Add-AMD-QDMA-driver/20230527-005214
        git checkout d300fd23b7ecbcc89512dba3fa745941c1c03fac
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305271937.niKlwa4h-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__ffsdi2" [drivers/dma/amd/amd-qdma.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
