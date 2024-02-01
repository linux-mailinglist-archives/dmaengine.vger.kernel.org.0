Return-Path: <dmaengine+bounces-925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDC845DCF
	for <lists+dmaengine@lfdr.de>; Thu,  1 Feb 2024 17:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A51B1C28ED0
	for <lists+dmaengine@lfdr.de>; Thu,  1 Feb 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C97E0FD;
	Thu,  1 Feb 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZrC0RLl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2331F60F;
	Thu,  1 Feb 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806505; cv=none; b=fFHOxDTktNbysbtqgJPFhTLdUO3ZTMIcCOve9BOkR5uwjORd1vzCfuVzxSb5YRXhOE/8IQCcWnVkZZiKXTRx+6e9UMOtINaEp1s1im98VZCX42wlsoc2zk014/D0NcNR//wgVXFBiOj3aFcaxO+53Ka5Oy90hqitelOeqGTYMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806505; c=relaxed/simple;
	bh=S9aqOhi7FfCfUW110X68Pu/3ngg4TBhJ6fh8tSbJTJg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h064h3aRzrTCdRmKwQdsYHvCGIVyIcAEkuuMxNl0JfphEkEOQ6nSTVtLE0pTlhBZ+VDI2+S48Rlmgcsu3fHzeD4U5ffTW4xgJKh0sbcLPRIsIDu0UhIx0btjFqL7CQX1QI2GE2By7b72SBcKeVINeyzawEwTBmF076+5VSUPYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZrC0RLl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706806503; x=1738342503;
  h=date:from:to:cc:subject:message-id;
  bh=S9aqOhi7FfCfUW110X68Pu/3ngg4TBhJ6fh8tSbJTJg=;
  b=TZrC0RLll90vHI6g48JeFEj3QR4TwqKBzR4dYsa9mwo77HWIAh2Jz4iQ
   OcEQQLopV7O6O0+4XmddeP+CvkPt3fM1t7iWR/VCLpy1Whg2D2YyNLeN0
   1RLsnI6FvLdyngnEV2+5HlOBIgLj+0/1w0F06owFIzTxQ4hyJLS1n06Pf
   BNBxGas9MVS8u1BYAdTQDApPc5ZwGg11WVQtT4SZ6fYpwxaCDxfiXZ8jI
   mV66nZaIGtVTTirjcP25gUGc7QfCppeg2UOlQEvxckAW48he9PuAp3xp6
   lIPs3JtalPQrx+R9j98dYis4ZUxAv0i4E5y3lKKJKjuGtmrkeZaMdvJkd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22438924"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="22438924"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4436160"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 01 Feb 2024 08:54:59 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVaL2-0002zN-2N;
	Thu, 01 Feb 2024 16:54:56 +0000
Date: Fri, 02 Feb 2024 00:54:42 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 51b70ff55ed88edd19b080a524063446bcc34b62
Message-ID: <202402020037.EMvofdJ6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 51b70ff55ed88edd19b080a524063446bcc34b62  Add linux-next specific files for 20240201

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402011430.vDOuYPku-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402011519.RwyEbkrS-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

iptable_nat.c:(.rodata+0x58): undefined reference to `ipt_do_table'
iptable_nat.c:(.text+0x228): undefined reference to `ipt_alloc_initial_table'
iptable_nat.c:(.text+0x294): undefined reference to `ipt_register_table'
iptable_nat.c:(.text+0x8): undefined reference to `ipt_unregister_table_exit'
ld.lld: error: undefined symbol: snd_pcm_format_big_endian
ld.lld: error: undefined symbol: snd_pcm_format_little_endian
ld.lld: error: undefined symbol: snd_pcm_format_name
ld.lld: error: undefined symbol: snd_pcm_format_physical_width
ld.lld: error: undefined symbol: snd_pcm_format_set_silence
ld.lld: error: undefined symbol: snd_pcm_format_signed
ld.lld: error: undefined symbol: snd_pcm_format_unsigned
ld.lld: error: undefined symbol: snd_pcm_format_width
loongarch64-linux-ld: iptable_nat.c:(.rodata+0x80): undefined reference to `ipt_do_table'
make[2]: *** kselftest/livepatch/test_modules: No such file or directory.  Stop.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-001-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm-randconfig-004-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm-sama5_defconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm64-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm64-randconfig-004-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- csky-randconfig-r131-20240201
|   |-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- sound-core-sound_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-snd_pcm_format_t-usertype-format-got-int
|   `-- sound-core-sound_kunit.c:sparse:sparse:restricted-snd_pcm_format_t-degrades-to-integer
|-- i386-buildonly-randconfig-001-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-buildonly-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-buildonly-randconfig-006-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-141-20240201
|   `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
|-- loongarch-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- loongarch-randconfig-r004-20230730
|   |-- iptable_nat.c:(.rodata):undefined-reference-to-ipt_do_table
|   |-- iptable_nat.c:(.text):undefined-reference-to-ipt_alloc_initial_table
|   |-- iptable_nat.c:(.text):undefined-reference-to-ipt_register_table
|   |-- iptable_nat.c:(.text):undefined-reference-to-ipt_unregister_table_exit
|   `-- loongarch64-linux-ld:iptable_nat.c:(.rodata):undefined-reference-to-ipt_do_table
|-- loongarch-randconfig-r123-20240201
|   |-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-__to-got-unsigned-char-noderef-usertype-__rcu-new
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-__from-got-unsigned-char-noderef-usertype-__rcu-old
|-- m68k-randconfig-r111-20240201
|   `-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|-- microblaze-randconfig-r133-20240201
|   |-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|   `-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   `-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|-- powerpc-randconfig-003-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sh-allmodconfig
|   `-- standard-input:Error:unknown-pseudo-op:cfi_def_
|-- sparc64-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-allnoconfig
|   `-- Warning:Documentation-gpu-amdgpu-display-display-contributing.rst-references-a-file-that-doesn-t-exist:Documentation-GPU-amdgpu-display-mpo-overview.rst
|-- x86_64-buildonly-randconfig-003-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-005-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-015-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-071-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-074-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-161-20240201
|   |-- fs-bcachefs-btree_locking.c-bch2_trans_relock()-warn:passing-zero-to-PTR_ERR
|   |-- fs-bcachefs-buckets.c-bch2_trans_account_disk_usage_change()-error:we-previously-assumed-trans-disk_res-could-be-null-(see-line-)
|   `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
|-- x86_64-randconfig-r123-20240201
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|-- x86_64-randconfig-r132-20240201
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
`-- x86_64-rhel-8.3-bpf
    `-- make:kselftest-livepatch-test_modules:No-such-file-or-directory.-Stop.
clang_recent_errors
|-- arm-defconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm-randconfig-004-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm64-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- hexagon-randconfig-r015-20220417
|   |-- ld.lld:error:undefined-symbol:snd_pcm_format_big_endian
|   |-- ld.lld:error:undefined-symbol:snd_pcm_format_little_endian
|   |-- ld.lld:error:undefined-symbol:snd_pcm_format_name
|   |-- ld.lld:error:undefined-symbol:snd_pcm_format_physical_width
|   |-- ld.lld:error:undefined-symbol:snd_pcm_format_set_silence
|   |-- ld.lld:error:undefined-symbol:snd_pcm_format_signed
|   |-- ld.lld:error:undefined-symbol:snd_pcm_format_unsigned
|   `-- ld.lld:error:undefined-symbol:snd_pcm_format_width
|-- hexagon-randconfig-r113-20240201
|   |-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|   |-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|   |-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   `-- net-core-sock_diag.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- riscv-randconfig-002-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-buildonly-randconfig-003-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-006-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-072-20240201
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-122-20240201
|   `-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
`-- x86_64-rhel-8.3-rust
    `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings

elapsed time: 731m

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
arc                   randconfig-001-20240201   gcc  
arc                   randconfig-002-20240201   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                             mxs_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240201   gcc  
arm                   randconfig-002-20240201   clang
arm                   randconfig-002-20240201   gcc  
arm                   randconfig-003-20240201   gcc  
arm                   randconfig-004-20240201   clang
arm                   randconfig-004-20240201   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240201   gcc  
arm64                 randconfig-002-20240201   clang
arm64                 randconfig-002-20240201   gcc  
arm64                 randconfig-003-20240201   gcc  
arm64                 randconfig-004-20240201   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240201   gcc  
csky                  randconfig-002-20240201   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240201   clang
hexagon               randconfig-002-20240201   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240201   gcc  
i386         buildonly-randconfig-002-20240201   gcc  
i386         buildonly-randconfig-003-20240201   gcc  
i386         buildonly-randconfig-004-20240201   gcc  
i386         buildonly-randconfig-005-20240201   gcc  
i386         buildonly-randconfig-006-20240201   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240201   gcc  
i386                  randconfig-002-20240201   gcc  
i386                  randconfig-003-20240201   gcc  
i386                  randconfig-004-20240201   gcc  
i386                  randconfig-005-20240201   gcc  
i386                  randconfig-006-20240201   gcc  
i386                  randconfig-011-20240201   clang
i386                  randconfig-012-20240201   clang
i386                  randconfig-013-20240201   clang
i386                  randconfig-014-20240201   clang
i386                  randconfig-015-20240201   clang
i386                  randconfig-016-20240201   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240201   gcc  
loongarch             randconfig-002-20240201   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240201   gcc  
nios2                 randconfig-002-20240201   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240201   gcc  
parisc                randconfig-002-20240201   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc               randconfig-001-20240201   clang
powerpc               randconfig-001-20240201   gcc  
powerpc               randconfig-002-20240201   clang
powerpc               randconfig-002-20240201   gcc  
powerpc               randconfig-003-20240201   gcc  
powerpc64             randconfig-001-20240201   clang
powerpc64             randconfig-002-20240201   clang
powerpc64             randconfig-003-20240201   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240201   gcc  
riscv                 randconfig-002-20240201   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240201   gcc  
s390                  randconfig-002-20240201   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240201   gcc  
sh                    randconfig-002-20240201   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240201   gcc  
sparc64               randconfig-002-20240201   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240201   gcc  
um                    randconfig-002-20240201   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240201   clang
x86_64       buildonly-randconfig-002-20240201   clang
x86_64       buildonly-randconfig-003-20240201   clang
x86_64       buildonly-randconfig-003-20240201   gcc  
x86_64       buildonly-randconfig-004-20240201   clang
x86_64       buildonly-randconfig-005-20240201   clang
x86_64       buildonly-randconfig-006-20240201   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240201   clang
x86_64                randconfig-002-20240201   gcc  
x86_64                randconfig-003-20240201   gcc  
x86_64                randconfig-004-20240201   gcc  
x86_64                randconfig-005-20240201   gcc  
x86_64                randconfig-006-20240201   clang
x86_64                randconfig-011-20240201   clang
x86_64                randconfig-012-20240201   gcc  
x86_64                randconfig-013-20240201   gcc  
x86_64                randconfig-014-20240201   clang
x86_64                randconfig-015-20240201   gcc  
x86_64                randconfig-016-20240201   gcc  
x86_64                randconfig-071-20240201   gcc  
x86_64                randconfig-072-20240201   clang
x86_64                randconfig-073-20240201   clang
x86_64                randconfig-074-20240201   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240201   gcc  
xtensa                randconfig-002-20240201   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

