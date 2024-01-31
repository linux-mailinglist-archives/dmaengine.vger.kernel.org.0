Return-Path: <dmaengine+bounces-917-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CE844211
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 15:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFCAB29FFC
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AFD84A48;
	Wed, 31 Jan 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwHc1IiM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A583CAA;
	Wed, 31 Jan 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712042; cv=none; b=aahN5xZ6ge5Qi/Gk1RN5vY1gp7J6TP1rTz37/EtvuQ0XhJZ0AyJ5/oARbuYW7bdrA85ruOqb+8Edk9bsiAk/oCYswSQUr0eqHO17ejZ3wqbXXTX+Q+8njgSi/TxRVNN+0zgU/7Hql9bDNTtBY0iOWayGXQKCHUmtd+O0+ySkCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712042; c=relaxed/simple;
	bh=JzDKV/e525CLow2aSr7kvC01CJp0vYxWBR4UV8y0kT8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jDbP2nJrqGK7GFnrPNXHgaAdL4bduKjJS9ZykZr2i+r9YJIoLj0hEp/LFsh+xQj4mylhJFzLwC62Z/iG9grFuehW8dFWY28B054QblxHFogZohO2dREioPI0H4s2kPz5YYmUSQt354PMD3x0MCEEG1zuFCE54Q5eKB/5qA4OZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwHc1IiM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706712040; x=1738248040;
  h=date:from:to:cc:subject:message-id;
  bh=JzDKV/e525CLow2aSr7kvC01CJp0vYxWBR4UV8y0kT8=;
  b=iwHc1IiMdjLvyQJs8Dao1IzhaJamSZKW/Ypmse/76VhGnqULShhsSPgA
   /bg0wKyLYsj/zAQHNsSVzhLepFv8JtmHQ+7Slo2E4ppLV87S08+wE3ioi
   h+vl/8+1bByMc17zKJzwRcaKqRzpvQhj69ctRY0sfibCA2Ea3MZPCb6zB
   +f/7HoXR5tFx4igvjHb0QAlAPdfnZhxp6ZjshUSKFTB5qbboVOQbMSAKB
   YRLEdtyDPY/IuJibqHm1UpYUO1ol1IaKlglxRpmu+IBUJz7N+owMd2dWV
   hLjZ5LZUf1PyW6+KOkA0MJg+2C9Mi1QqBYEWlc+VTuUa29ZgtzuxvaKqZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3453367"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3453367"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4077211"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 31 Jan 2024 06:40:36 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVBlQ-0001dU-17;
	Wed, 31 Jan 2024 14:40:32 +0000
Date: Wed, 31 Jan 2024 22:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 06f658aadff0e483ee4f807b0b46c9e5cba62bfa
Message-ID: <202401312230.etMTMMa8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 06f658aadff0e483ee4f807b0b46c9e5cba62bfa  Add linux-next specific files for 20240131

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202401311655.FJYxii3p-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

error[E0425]: cannot find value `WORK_CPU_UNBOUND` in crate `bindings`

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-001-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm-allmodconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-allyesconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- i386-randconfig-012-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-013-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   `-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|-- nios2-randconfig-001-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- parisc-randconfig-002-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- powerpc64-randconfig-r132-20240131
|   |-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|-- powerpc64-randconfig-r133-20240131
|   |-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-q-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|-- sh-allmodconfig
|   `-- standard-input:Error:unknown-pseudo-op:cfi_def_
|-- sh-randconfig-001-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sparc-randconfig-001-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sparc-randconfig-r112-20240131
|   `-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|-- sparc-randconfig-r131-20240131
|   |-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|   |-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|   |-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|-- sparc64-randconfig-002-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sparc64-randconfig-r051-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-allnoconfig
|   `-- Warning:Documentation-gpu-amdgpu-display-display-contributing.rst-references-a-file-that-doesn-t-exist:Documentation-GPU-amdgpu-display-mpo-overview.rst
|-- x86_64-randconfig-005-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-006-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-121-20240131
|   |-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-q-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|-- xtensa-randconfig-001-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
`-- xtensa-randconfig-r122-20240131
    `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
clang_recent_errors
|-- arm-defconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm64-randconfig-002-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm64-randconfig-r053-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm64-randconfig-r123-20240131
|   |-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|   |-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|   |-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|-- i386-buildonly-randconfig-001-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-buildonly-randconfig-002-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-001-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-003-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-006-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-051-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-053-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-061-20240131
|   |-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|-- i386-randconfig-062-20240131
|   |-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|   |-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|   |-- sound-core-sound_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-snd_pcm_format_t-usertype-format-got-int
|   `-- sound-core-sound_kunit.c:sparse:sparse:restricted-snd_pcm_format_t-degrades-to-integer
|-- i386-randconfig-141-20240131
|   |-- fs-bcachefs-btree_locking.c-bch2_trans_relock()-warn:passing-zero-to-PTR_ERR
|   |-- fs-bcachefs-buckets.c-bch2_trans_account_disk_usage_change()-error:we-previously-assumed-trans-disk_res-could-be-null-(see-line-)
|   `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
|-- i386-randconfig-r113-20240131
|   `-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|-- riscv-randconfig-r111-20240131
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-got-unsigned-char-noderef-usertype-__rcu-static-addressable-toplevel-iw_table
|-- riscv-randconfig-r121-20240131
|   |-- drivers-usb-cdns3-cdns3-gadget.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|   `-- fs-ntfs3-fslog.c:sparse:sparse:restricted-__le32-degrades-to-integer
|-- x86_64-buildonly-randconfig-002-20240131
|   `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings
|-- x86_64-buildonly-randconfig-003-20240131
|   `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings
|-- x86_64-buildonly-randconfig-005-20240131
|   `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings
|-- x86_64-buildonly-randconfig-006-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-011-20240131
|   `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings
|-- x86_64-randconfig-012-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-013-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-102-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-103-20240131
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-161-20240131
|   `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
`-- x86_64-rhel-8.3-rust
    `-- error-E0425:cannot-find-value-WORK_CPU_UNBOUND-in-crate-bindings

elapsed time: 740m

configs tested: 180
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240131   gcc  
arc                   randconfig-002-20240131   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   clang
arm                      integrator_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                   randconfig-001-20240131   clang
arm                   randconfig-002-20240131   clang
arm                   randconfig-003-20240131   clang
arm                   randconfig-004-20240131   clang
arm                        spear6xx_defconfig   gcc  
arm                           spitz_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240131   clang
arm64                 randconfig-002-20240131   clang
arm64                 randconfig-003-20240131   clang
arm64                 randconfig-004-20240131   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240131   gcc  
csky                  randconfig-002-20240131   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240131   clang
hexagon               randconfig-002-20240131   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240131   clang
i386         buildonly-randconfig-002-20240131   clang
i386         buildonly-randconfig-003-20240131   clang
i386         buildonly-randconfig-004-20240131   clang
i386         buildonly-randconfig-005-20240131   clang
i386         buildonly-randconfig-006-20240131   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240131   clang
i386                  randconfig-002-20240131   clang
i386                  randconfig-003-20240131   clang
i386                  randconfig-004-20240131   clang
i386                  randconfig-005-20240131   clang
i386                  randconfig-006-20240131   clang
i386                  randconfig-011-20240131   gcc  
i386                  randconfig-012-20240131   gcc  
i386                  randconfig-013-20240131   gcc  
i386                  randconfig-014-20240131   gcc  
i386                  randconfig-015-20240131   gcc  
i386                  randconfig-016-20240131   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240131   gcc  
loongarch             randconfig-002-20240131   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                           ip27_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240131   gcc  
nios2                 randconfig-002-20240131   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240131   gcc  
parisc                randconfig-002-20240131   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc               randconfig-001-20240131   clang
powerpc               randconfig-002-20240131   clang
powerpc               randconfig-003-20240131   clang
powerpc64             randconfig-001-20240131   clang
powerpc64             randconfig-002-20240131   clang
powerpc64             randconfig-003-20240131   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240131   clang
riscv                 randconfig-002-20240131   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240131   gcc  
s390                  randconfig-002-20240131   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240131   gcc  
sh                    randconfig-002-20240131   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240131   gcc  
sparc64               randconfig-002-20240131   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240131   clang
um                    randconfig-002-20240131   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240131   clang
x86_64       buildonly-randconfig-002-20240131   clang
x86_64       buildonly-randconfig-003-20240131   clang
x86_64       buildonly-randconfig-004-20240131   clang
x86_64       buildonly-randconfig-005-20240131   clang
x86_64       buildonly-randconfig-006-20240131   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240131   gcc  
x86_64                randconfig-002-20240131   gcc  
x86_64                randconfig-003-20240131   gcc  
x86_64                randconfig-004-20240131   gcc  
x86_64                randconfig-005-20240131   gcc  
x86_64                randconfig-006-20240131   gcc  
x86_64                randconfig-011-20240131   clang
x86_64                randconfig-012-20240131   clang
x86_64                randconfig-013-20240131   clang
x86_64                randconfig-014-20240131   clang
x86_64                randconfig-015-20240131   clang
x86_64                randconfig-016-20240131   clang
x86_64                randconfig-071-20240131   clang
x86_64                randconfig-072-20240131   clang
x86_64                randconfig-073-20240131   clang
x86_64                randconfig-074-20240131   clang
x86_64                randconfig-075-20240131   clang
x86_64                randconfig-076-20240131   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240131   gcc  
xtensa                randconfig-002-20240131   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

