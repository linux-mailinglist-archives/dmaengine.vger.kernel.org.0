Return-Path: <dmaengine+bounces-907-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79D842BA4
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 19:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96C41F2952E
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0A158D92;
	Tue, 30 Jan 2024 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXgPFVyw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56056158D85;
	Tue, 30 Jan 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638869; cv=none; b=GsZN1qe8dFbLYL5NCtLN5yw0EaltNMYXrkiiZwepEvKYF2osQaC46Jr88CDCJdjD5YW2AnwsNu/PZztfsVk84zJuV4prNorGAANhSy/Y5AZ/m/qeAyJzPg8EBcncGUTQnCEgswg3OvO9F8ZlyRlGX4fqWYyO1BkYh07Tdy0Rvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638869; c=relaxed/simple;
	bh=o8+KFDEHXK0m0UWTRZP+oopOaFtdMnmhqSxrKUL/onc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N716+FNc1DeZviwPlVGohYzKWfQAR6v0SZ43VvMXvef6E8a2yus8bVf/td8cflwaFM6kC/t/aJKiXM7RUy5gxUvaZZWJIU2/qHfr8EOCHdI14xSQXrBrhfSQ7IzdXwZJDsaalt/GW4DwG5PqA/hkSXb1i4i/fFQszpXXA9XrGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXgPFVyw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706638867; x=1738174867;
  h=date:from:to:cc:subject:message-id;
  bh=o8+KFDEHXK0m0UWTRZP+oopOaFtdMnmhqSxrKUL/onc=;
  b=VXgPFVywiUKkwsUTToDaYYflc5Uoqv+8EPKvO/zCVNC8YFQo/Am6kDVa
   uZTL8+8FPB8LoEu05uZXPnTNLZ5iM2xHuHOBTwG2ufj3n6Q5fL7wJ2CQP
   /eeG/bWKxGO6MGqz2oDhuF+1cQtbO64b3B6HmQ7HU4SxQ4seWR0WMjQ7h
   CBxxsM8zKQawhNwYKvhcMek0KgsdjvsJP9vE6c7hdxJjhhZkhQOfW43AP
   N1SJnrKFQCtXVLnDmMmXH7y+g6uvTbBKxf4KoWMUWkkGibZGZ5snVRlFZ
   Jd7gUkFZVaeZxMsZYTILTjyF4F/w/R1DhMhJhR53QLgnQmvoif5RXKwfk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2298591"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="2298591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3782940"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 30 Jan 2024 10:21:03 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUsjE-0000gQ-2f;
	Tue, 30 Jan 2024 18:21:00 +0000
Date: Wed, 31 Jan 2024 02:20:24 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-usb@vger.kernel.org, ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52
Message-ID: <202401310219.t9eXMTcG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52  Add linux-next specific files for 20240130

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202401302044.TYqzwNmq-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202401302054.sXdwijhd-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202401302130.Zw501PI9-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202401302158.oKXhk0gV-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202401302359.PL3jJegi-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Warning: Documentation/gpu/amdgpu/display/display-contributing.rst references a file that doesn't exist: Documentation/GPU/amdgpu/display/mpo-overview.rst
fs/ntfs3/frecord.c:2460:16: warning: unused variable 'i_size' [-Wunused-variable]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/usb/typec/ucsi/ucsi_acpi.c:174 ucsi_dell_sync_write() warn: missing error code? 'ret'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-allyesconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- i386-randconfig-061-20240130
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|-- i386-randconfig-062-20240130
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|-- i386-randconfig-141-20240130
|   |-- fs-bcachefs-btree_locking.c-bch2_trans_relock()-warn:passing-zero-to-PTR_ERR
|   |-- fs-bcachefs-buckets.c-bch2_trans_account_disk_usage_change()-error:we-previously-assumed-trans-disk_res-could-be-null-(see-line-)
|   `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
|-- loongarch-randconfig-r113-20240129
|   |-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-__s-got-unsigned-char-noderef-usertype-__rcu-new
|   |-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-__to-got-unsigned-char-noderef-usertype-__rcu-new
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-__from-got-unsigned-char-noderef-usertype-__rcu-old
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   `-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|-- parisc-randconfig-r133-20240130
|   `-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|-- sh-allmodconfig
|   `-- standard-input:Error:unknown-pseudo-op:cfi_def_
|-- sh-randconfig-r023-20220313
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-allnoconfig
|   `-- Warning:Documentation-gpu-amdgpu-display-display-contributing.rst-references-a-file-that-doesn-t-exist:Documentation-GPU-amdgpu-display-mpo-overview.rst
`-- x86_64-randconfig-161-20240130
    |-- drivers-usb-typec-ucsi-ucsi_acpi.c-ucsi_dell_sync_write()-warn:missing-error-code-ret
    `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
clang_recent_errors
|-- arm-defconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- x86_64-randconfig-002-20240130
|   `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings
|-- x86_64-randconfig-005-20240130
|   `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings
|-- x86_64-randconfig-121-20240130
|   `-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|-- x86_64-randconfig-122-20240130
|   |-- drivers-usb-cdns3-cdns3-gadget.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-q-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|-- x86_64-randconfig-123-20240130
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
`-- x86_64-rhel-8.3-rust
    `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings

elapsed time: 846m

configs tested: 176
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240130   gcc  
arc                   randconfig-002-20240130   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240130   gcc  
arm                   randconfig-002-20240130   gcc  
arm                   randconfig-003-20240130   gcc  
arm                   randconfig-004-20240130   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240130   gcc  
arm64                 randconfig-002-20240130   gcc  
arm64                 randconfig-003-20240130   gcc  
arm64                 randconfig-004-20240130   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240130   gcc  
csky                  randconfig-002-20240130   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240130   clang
hexagon               randconfig-002-20240130   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240130   gcc  
i386         buildonly-randconfig-002-20240130   gcc  
i386         buildonly-randconfig-003-20240130   gcc  
i386         buildonly-randconfig-004-20240130   gcc  
i386         buildonly-randconfig-005-20240130   gcc  
i386         buildonly-randconfig-006-20240130   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240130   gcc  
i386                  randconfig-002-20240130   gcc  
i386                  randconfig-003-20240130   gcc  
i386                  randconfig-004-20240130   gcc  
i386                  randconfig-005-20240130   gcc  
i386                  randconfig-006-20240130   gcc  
i386                  randconfig-011-20240130   clang
i386                  randconfig-012-20240130   clang
i386                  randconfig-013-20240130   clang
i386                  randconfig-014-20240130   clang
i386                  randconfig-015-20240130   clang
i386                  randconfig-016-20240130   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240130   gcc  
loongarch             randconfig-002-20240130   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240130   gcc  
nios2                 randconfig-002-20240130   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240130   gcc  
parisc                randconfig-002-20240130   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc               randconfig-001-20240130   gcc  
powerpc               randconfig-002-20240130   gcc  
powerpc               randconfig-003-20240130   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc64             randconfig-001-20240130   gcc  
powerpc64             randconfig-002-20240130   gcc  
powerpc64             randconfig-003-20240130   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240130   gcc  
riscv                 randconfig-002-20240130   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240130   clang
s390                  randconfig-002-20240130   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240130   gcc  
sh                    randconfig-002-20240130   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240130   gcc  
sparc64               randconfig-002-20240130   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240130   gcc  
um                    randconfig-002-20240130   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240130   gcc  
x86_64       buildonly-randconfig-002-20240130   gcc  
x86_64       buildonly-randconfig-003-20240130   gcc  
x86_64       buildonly-randconfig-004-20240130   gcc  
x86_64       buildonly-randconfig-005-20240130   gcc  
x86_64       buildonly-randconfig-006-20240130   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240130   clang
x86_64                randconfig-002-20240130   clang
x86_64                randconfig-003-20240130   clang
x86_64                randconfig-004-20240130   clang
x86_64                randconfig-005-20240130   clang
x86_64                randconfig-006-20240130   clang
x86_64                randconfig-011-20240130   gcc  
x86_64                randconfig-012-20240130   gcc  
x86_64                randconfig-013-20240130   gcc  
x86_64                randconfig-014-20240130   gcc  
x86_64                randconfig-015-20240130   gcc  
x86_64                randconfig-016-20240130   gcc  
x86_64                randconfig-071-20240130   gcc  
x86_64                randconfig-072-20240130   gcc  
x86_64                randconfig-073-20240130   gcc  
x86_64                randconfig-074-20240130   gcc  
x86_64                randconfig-075-20240130   gcc  
x86_64                randconfig-076-20240130   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240130   gcc  
xtensa                randconfig-002-20240130   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

