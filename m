Return-Path: <dmaengine+bounces-857-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B1840BE4
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34F41F23DD3
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4B154BF0;
	Mon, 29 Jan 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIg1ffA0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0715B0ED;
	Mon, 29 Jan 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546297; cv=none; b=lQj0rKOQWhYyUggeYtSOcX4T4U9qWL4FW5mZaEEgVJ+uXlEBoxBYhzjlxC98U0ElapUSt5Gzq2ZTGgTPi2OXpW45C3i7i/AoC+MS2AhtxAcqVIyDvdJ8uSoLxc2iFOVoiQRIU1CNLFQhYkawTe5HeEFBv6rsMvb/G9jiF2G4Byk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546297; c=relaxed/simple;
	bh=uYwcOR5brX7r9+JRwYX8+VbyycUQFdGKUH1m0kNYxxo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uf3NDmerISQFxXUPu1nLHQHpDJfs9orxzXgaPpGq9pSf5HtlSi9NtA1OSm652sY63LKLQYEYgqIl5nFpWZGjudBtB/p+lasKF4PfpkCGZPamTXKsoBt84MZFSwR2VZul2+fK8SU+yVZl/zX2oK/59czlbGSPaBeoHEwwAKJyjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIg1ffA0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706546296; x=1738082296;
  h=date:from:to:cc:subject:message-id;
  bh=uYwcOR5brX7r9+JRwYX8+VbyycUQFdGKUH1m0kNYxxo=;
  b=gIg1ffA0Cz8wUVlZ4yykZJCvd/zWqsRbvJrDZb9d/29brNYjPfkojxoW
   4v7AHUmC/cPPeVuttLelumeo7G7/upZAEhzs9P/nzrD2+SYskaoQv6fBL
   xJrws+IH9pKeNQrzxFUqyFFu7ZKZMTwGM+zEfelyc5plG9cfWR9SuoIdE
   6dGN+QjSle3cUITq33tPdYgfJW5bn9ixrLM2t6DmSrQVqofuOKV6/DKcH
   DSPh5ZbzeuGsPBlqphYt8bZhtbwXOC/1pzkSMGjWcGFsfepVsVi8oTHaa
   cGvV7Pzgjy1aSfutjsS5MTqx1GE4Ndi1v4hyzbyUJFdHR1VEHwVDA1YSm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2827047"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2827047"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:38:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="907175661"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907175661"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 08:38:01 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUUdz-0004SK-36;
	Mon, 29 Jan 2024 16:37:59 +0000
Date: Tue, 30 Jan 2024 00:37:19 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 596764183be8ebb13352b281a442a1f1151c9b06
Message-ID: <202401300015.JNiXkpyb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 596764183be8ebb13352b281a442a1f1151c9b06  Add linux-next specific files for 20240129

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202401291400.2iU26ixw-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

s390-linux-ld: drivers/of/kexec.c:399:(.text+0x944): undefined reference to `crashk_res'

Unverified Error/Warning (likely false positive, please contact us if interested):

{standard input}:936: Error: unknown pseudo-op: `.cfi_def_'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-allyesconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-randconfig-002-20240129
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-randconfig-004-20240129
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- m68k-randconfig-r121-20240129
|   `-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   `-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|-- s390-randconfig-r023-20230616
|   `-- s390-linux-ld:drivers-of-kexec.c:(.text):undefined-reference-to-crashk_res
|-- sh-allmodconfig
|   `-- standard-input:Error:unknown-pseudo-op:cfi_def_
|-- sparc64-randconfig-r131-20240129
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
`-- x86_64-randconfig-161-20240129
    `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
clang_recent_errors
|-- arm-defconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
`-- hexagon-randconfig-r122-20240129
    `-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static

elapsed time: 755m

configs tested: 177
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240129   gcc  
arc                   randconfig-002-20240129   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20240129   gcc  
arm                   randconfig-002-20240129   gcc  
arm                   randconfig-003-20240129   gcc  
arm                   randconfig-004-20240129   gcc  
arm                           spitz_defconfig   clang
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240129   gcc  
arm64                 randconfig-002-20240129   gcc  
arm64                 randconfig-003-20240129   gcc  
arm64                 randconfig-004-20240129   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240129   gcc  
csky                  randconfig-002-20240129   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240129   clang
hexagon               randconfig-002-20240129   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240129   gcc  
i386         buildonly-randconfig-002-20240129   gcc  
i386         buildonly-randconfig-003-20240129   gcc  
i386         buildonly-randconfig-004-20240129   gcc  
i386         buildonly-randconfig-005-20240129   gcc  
i386         buildonly-randconfig-006-20240129   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240129   gcc  
i386                  randconfig-002-20240129   gcc  
i386                  randconfig-003-20240129   gcc  
i386                  randconfig-004-20240129   gcc  
i386                  randconfig-005-20240129   gcc  
i386                  randconfig-006-20240129   gcc  
i386                  randconfig-011-20240129   clang
i386                  randconfig-012-20240129   clang
i386                  randconfig-013-20240129   clang
i386                  randconfig-014-20240129   clang
i386                  randconfig-015-20240129   clang
i386                  randconfig-016-20240129   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240129   gcc  
loongarch             randconfig-002-20240129   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240129   gcc  
nios2                 randconfig-002-20240129   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240129   gcc  
parisc                randconfig-002-20240129   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc               randconfig-001-20240129   gcc  
powerpc               randconfig-002-20240129   gcc  
powerpc               randconfig-003-20240129   gcc  
powerpc64             randconfig-001-20240129   gcc  
powerpc64             randconfig-002-20240129   gcc  
powerpc64             randconfig-003-20240129   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20240129   gcc  
riscv                 randconfig-002-20240129   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240129   clang
s390                  randconfig-002-20240129   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240129   gcc  
sh                    randconfig-002-20240129   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240129   gcc  
sparc64               randconfig-002-20240129   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240129   gcc  
um                    randconfig-002-20240129   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240129   gcc  
x86_64       buildonly-randconfig-002-20240129   gcc  
x86_64       buildonly-randconfig-003-20240129   gcc  
x86_64       buildonly-randconfig-004-20240129   gcc  
x86_64       buildonly-randconfig-005-20240129   gcc  
x86_64       buildonly-randconfig-006-20240129   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240129   clang
x86_64                randconfig-002-20240129   clang
x86_64                randconfig-003-20240129   clang
x86_64                randconfig-004-20240129   clang
x86_64                randconfig-005-20240129   clang
x86_64                randconfig-006-20240129   clang
x86_64                randconfig-011-20240129   gcc  
x86_64                randconfig-012-20240129   gcc  
x86_64                randconfig-013-20240129   gcc  
x86_64                randconfig-014-20240129   gcc  
x86_64                randconfig-015-20240129   gcc  
x86_64                randconfig-016-20240129   gcc  
x86_64                randconfig-071-20240129   gcc  
x86_64                randconfig-072-20240129   gcc  
x86_64                randconfig-073-20240129   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240129   gcc  
xtensa                randconfig-002-20240129   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

