Return-Path: <dmaengine+bounces-938-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53D8483E1
	for <lists+dmaengine@lfdr.de>; Sat,  3 Feb 2024 06:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7841C22D2E
	for <lists+dmaengine@lfdr.de>; Sat,  3 Feb 2024 05:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A568B10795;
	Sat,  3 Feb 2024 05:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxJbNA8c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2710A0E;
	Sat,  3 Feb 2024 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936840; cv=none; b=IFdqw8xfB9kPf4f+EfGtaduUweljPxV48/+IkqCGjQHCh4uOSiYoUTw4tU0CBUCIQZ7V6IK5OTjqJuId0k+GDRrOYORcWwV5LTYBSkmVfBeqF97POxa2y4iQ1l53e6rR4d/78EaMDEil6uxOzj0vmWsYwYwa652VQQFXTO0WpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936840; c=relaxed/simple;
	bh=7qV9ExGz4rlsG3u7a9g8VLrFek2xKMCv4MvQ5O+J8Qk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HcaFqT8b1z+PvBJWwwXY1zuSbGL/Tx2Z/eEx6/aNhwQCpk6aEqKQWnvA0B0GmsFiH2+Avq+Brgvt5lrKomjC6XDpn0bz06aOY+AhxcjwvuAe4+mM1L79JEfbvjxyINm96VsFTDSq8x8uAS1U+nNvsnuTBH8ztHjAtchYgE1Srg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxJbNA8c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706936838; x=1738472838;
  h=date:from:to:cc:subject:message-id;
  bh=7qV9ExGz4rlsG3u7a9g8VLrFek2xKMCv4MvQ5O+J8Qk=;
  b=nxJbNA8cafrSVMOTDVEvgq9NgrqIRZGLn4Po4+ktW18Q9yAK9jIANxBH
   NXFL/XkbpjwDfRO27ZbQWbZsswyX6QEuF5yxNYyEDPaZdmUh6+ddoycW9
   zGTW0umqwsOB17a7BetDyMHoo9PZ6SK33YELjCQ50sTn2a0bUOhoQLeuX
   mrBvpNfGTdyKGMwrOFKEfxE+xFU7Hb8vaDWU+5WsSwinISe3tsj5Yvzwc
   H2N+3rpL6R0vmbNRfAChzesdhjc4V7Qkbr35+K9pZ0oBq/nNox7HuUvcH
   H0bosMjM2pxdd0vaYiYNADqTLVAJL8nfDblLU0i/kTSiFozijqS8bol3I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="3254440"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="3254440"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 21:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4870493"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 02 Feb 2024 21:07:14 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW8FE-0004eH-0V;
	Sat, 03 Feb 2024 05:07:12 +0000
Date: Sat, 03 Feb 2024 13:06:55 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 076d56d74f17e625b3d63cf4743b3d7d02180379
Message-ID: <202402031349.faJAWJvP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 076d56d74f17e625b3d63cf4743b3d7d02180379  Add linux-next specific files for 20240202

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402030006.2bwG9hee-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402030306.l4idnFyz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402030631.6mCz0axA-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

or1k-linux-ld: sound_kunit.c:(.text+0x118): undefined reference to `snd_pcm_format_name'
or1k-linux-ld: sound_kunit.c:(.text+0x410): undefined reference to `snd_pcm_format_unsigned'
or1k-linux-ld: sound_kunit.c:(.text+0x490): undefined reference to `snd_pcm_format_width'
or1k-linux-ld: sound_kunit.c:(.text+0x794): undefined reference to `snd_pcm_format_big_endian'
or1k-linux-ld: sound_kunit.c:(.text+0x814): undefined reference to `snd_pcm_format_little_endian'
or1k-linux-ld: sound_kunit.c:(.text+0xa50): undefined reference to `snd_pcm_format_physical_width'
or1k-linux-ld: sound_kunit.c:(.text+0xc48): undefined reference to `snd_pcm_format_set_silence'
sound_kunit.c:(.text+0x258): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `snd_pcm_format_set_silence'
sound_kunit.c:(.text+0x258): undefined reference to `snd_pcm_format_set_silence'
sound_kunit.c:(.text+0x3b0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `snd_pcm_format_signed'
sound_kunit.c:(.text+0x3b0): undefined reference to `snd_pcm_format_signed'
sound_kunit.c:(.text+0x410): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `snd_pcm_format_unsigned'
sound_kunit.c:(.text+0x490): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `snd_pcm_format_width'
sound_kunit.c:(.text+0x54): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `snd_pcm_format_name'
sound_kunit.c:(.text+0x54): undefined reference to `snd_pcm_format_name'
sound_kunit.c:(.text+0x5b4): undefined reference to `snd_pcm_format_width'
sound_kunit.c:(.text+0x734): undefined reference to `snd_pcm_format_little_endian'
sound_kunit.c:(.text+0x9ec): undefined reference to `snd_pcm_format_physical_width'

Unverified Error/Warning (likely false positive, please contact us if interested):

{standard input}:671: Warning: overflow in branch to .L87; converted into longer instruction sequence

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-allyesconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-randconfig-002-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm64-randconfig-004-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-001-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-006-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-011-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- loongarch-randconfig-001-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- m68k-randconfig-r063-20240203
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   `-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|-- nios2-randconfig-002-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- openrisc-randconfig-r013-20211230
|   |-- or1k-linux-ld:sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_big_endian
|   |-- or1k-linux-ld:sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_little_endian
|   |-- or1k-linux-ld:sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_name
|   |-- or1k-linux-ld:sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_physical_width
|   |-- or1k-linux-ld:sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_set_silence
|   |-- or1k-linux-ld:sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_unsigned
|   |-- or1k-linux-ld:sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_width
|   |-- sound_kunit.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-snd_pcm_format_name
|   |-- sound_kunit.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-snd_pcm_format_set_silence
|   |-- sound_kunit.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-snd_pcm_format_signed
|   |-- sound_kunit.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-snd_pcm_format_unsigned
|   |-- sound_kunit.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-snd_pcm_format_width
|   |-- sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_little_endian
|   |-- sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_name
|   |-- sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_physical_width
|   |-- sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_set_silence
|   |-- sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_signed
|   `-- sound_kunit.c:(.text):undefined-reference-to-snd_pcm_format_width
|-- parisc-randconfig-001-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- parisc-randconfig-002-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sh-allmodconfig
|   `-- standard-input:Error:unknown-pseudo-op:cfi_def_
|-- sh-randconfig-002-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sh-randconfig-r024-20230511
|   `-- standard-input:Warning:overflow-in-branch-to-.L87-converted-into-longer-instruction-sequence
|-- sh-randconfig-r062-20240203
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-buildonly-randconfig-005-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-005-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-102-20240203
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-103-20240203
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-r123-20240201
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-got-unsigned-char-noderef-usertype-__rcu-weights
`-- xtensa-randconfig-r052-20240203
    `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
clang_recent_errors
|-- arm-defconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- hexagon-randconfig-r122-20240202
|   `-- net-ipv4-inet_diag.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- powerpc64-randconfig-003-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- s390-randconfig-r133-20240202
|   |-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-src-got-unsigned-char-noderef-usertype-__rcu-table
|   `-- mm-mempolicy.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-dest-got-unsigned-char-noderef-usertype-__rcu-weights
|-- x86_64-buildonly-randconfig-001-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-buildonly-randconfig-004-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-012-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-014-20240202
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
`-- x86_64-randconfig-072-20240202
    `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size

elapsed time: 1456m

configs tested: 178
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240202   gcc  
arc                   randconfig-002-20240202   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         nhk8815_defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240202   gcc  
arm                   randconfig-002-20240202   gcc  
arm                   randconfig-003-20240202   gcc  
arm                   randconfig-004-20240202   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240202   gcc  
arm64                 randconfig-002-20240202   clang
arm64                 randconfig-003-20240202   gcc  
arm64                 randconfig-004-20240202   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240202   gcc  
csky                  randconfig-002-20240202   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240202   clang
hexagon               randconfig-002-20240202   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240202   gcc  
i386         buildonly-randconfig-002-20240202   clang
i386         buildonly-randconfig-003-20240202   gcc  
i386         buildonly-randconfig-004-20240202   clang
i386         buildonly-randconfig-005-20240202   clang
i386         buildonly-randconfig-006-20240202   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240202   gcc  
i386                  randconfig-002-20240202   gcc  
i386                  randconfig-003-20240202   clang
i386                  randconfig-004-20240202   gcc  
i386                  randconfig-005-20240202   gcc  
i386                  randconfig-006-20240202   gcc  
i386                  randconfig-011-20240202   gcc  
i386                  randconfig-012-20240202   gcc  
i386                  randconfig-013-20240202   gcc  
i386                  randconfig-014-20240202   clang
i386                  randconfig-015-20240202   gcc  
i386                  randconfig-016-20240202   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240202   gcc  
loongarch             randconfig-002-20240202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240202   gcc  
nios2                 randconfig-002-20240202   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240202   gcc  
parisc                randconfig-002-20240202   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                      pcm030_defconfig   clang
powerpc               randconfig-001-20240202   clang
powerpc               randconfig-002-20240202   clang
powerpc               randconfig-003-20240202   clang
powerpc64             randconfig-001-20240202   clang
powerpc64             randconfig-002-20240202   gcc  
powerpc64             randconfig-003-20240202   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240202   gcc  
riscv                 randconfig-002-20240202   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240202   clang
s390                  randconfig-002-20240202   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240202   gcc  
sh                    randconfig-002-20240202   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240202   gcc  
sparc64               randconfig-002-20240202   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240202   clang
um                    randconfig-002-20240202   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240202   clang
x86_64       buildonly-randconfig-002-20240202   clang
x86_64       buildonly-randconfig-003-20240202   clang
x86_64       buildonly-randconfig-004-20240202   clang
x86_64       buildonly-randconfig-005-20240202   gcc  
x86_64       buildonly-randconfig-006-20240202   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240202   clang
x86_64                randconfig-002-20240202   clang
x86_64                randconfig-003-20240202   gcc  
x86_64                randconfig-004-20240202   gcc  
x86_64                randconfig-005-20240202   gcc  
x86_64                randconfig-006-20240202   gcc  
x86_64                randconfig-011-20240202   clang
x86_64                randconfig-012-20240202   clang
x86_64                randconfig-013-20240202   gcc  
x86_64                randconfig-014-20240202   clang
x86_64                randconfig-015-20240202   clang
x86_64                randconfig-016-20240202   clang
x86_64                randconfig-071-20240202   gcc  
x86_64                randconfig-072-20240202   clang
x86_64                randconfig-073-20240202   gcc  
x86_64                randconfig-074-20240202   clang
x86_64                randconfig-075-20240202   gcc  
x86_64                randconfig-076-20240202   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240202   gcc  
xtensa                randconfig-002-20240202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

