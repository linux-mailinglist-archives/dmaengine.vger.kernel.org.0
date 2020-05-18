Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0A1D87A0
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2020 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgERSxb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 May 2020 14:53:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:62800 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgERSx3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 May 2020 14:53:29 -0400
IronPort-SDR: ZBocod/JK+yg8rXgln9MNLrsF5EvG/H5RaEq/XY3b6y2c5LQDwzs99qYxhTYzTgGv/BxxUp99+
 D3tIQO6AzlTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 11:53:28 -0700
IronPort-SDR: cLVedVr6YcxA8xA0ut8H7CaJzpO1BRWydUdj5v/+TxjTIeCNF5A+EjQWMU/EkcEs1iNx8aFK8v
 WTptPQ3FY4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="267620881"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2020 11:53:26 -0700
Subject: [PATCH v2 1/9] x86/cpufeatures: Enumerate ENQCMD and ENQCMDS
 instructions
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com, dave.hansen@intel.com
Date:   Mon, 18 May 2020 11:53:26 -0700
Message-ID: <158982800677.37989.4568229540286901733.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
References: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

A user space application can execute ENQCMD instruction to submit work
to device. The kernel executes ENQCMDS instruction to submit work to
device.

There is a lot of other enabling needed for the instructions to actually
be usable in user space and the kernel, and that enabling is coming later
in the series and in device drivers.

The CPU feature flag is shown as "enqcmd" in /proc/cpuinfo.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/kernel/cpu/cpuid-deps.c   |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2c95a3efc2d9..8fc5a71b1e29 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -352,6 +352,7 @@
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
+#define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index fec83cc74b9e..81d26dc51d44 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -71,6 +71,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_IBT,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{}
 };
 

