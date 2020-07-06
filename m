Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD18F215E37
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgGFSVe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 14:21:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:43341 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgGFSVd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 14:21:33 -0400
IronPort-SDR: JGs4GxlP9PGzHSvu2eXbdJr9+O3HI+33inLLUzxC/uR91bEbvO6dNOcoazw3fg5Ay4vKswNYJr
 LtdkVZ0gpsaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="208990011"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="208990011"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 11:21:32 -0700
IronPort-SDR: XNFZSYdpw7Tvw3KS8Zs1yAXWoq/gtp1xa/mA6JeHfHAdhe5OxX9uUO6C7WSLDN7c4zK88SOe7c
 2s5wuBqEQ52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="283120290"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 11:21:32 -0700
Subject: [PATCH v3 1/6] x86/cpufeatures: Enumerate ENQCMD and ENQCMDS
 instructions
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com
Date:   Mon, 06 Jul 2020 11:21:32 -0700
Message-ID: <159405969206.19216.9552068036045362031.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
References: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Work submission instruction comes in two flavors. ENQCMD can be called
both in ring 3 and ring 0 and always uses the contents of PASID MSR when
shipping the command to the device. ENQCMDS allows a kernel driver to
submit commands on behalf of a user process. The driver supplies the
PASID value in ENQCMDS. There isn't any usage of ENQCMD in the kernel
as of now.

The CPU feature flag is shown as "enqcmd" in /proc/cpuinfo.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>

This patch is here only for compilation reasons. Drop when Fenghua's patch
series gets accepted upstream.
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/kernel/cpu/cpuid-deps.c   |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 02dabc9e77b0..4469618c410f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -351,6 +351,7 @@
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
+#define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 3cbe24ca80ab..3a02707c1f4d 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -69,6 +69,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{}
 };
 

