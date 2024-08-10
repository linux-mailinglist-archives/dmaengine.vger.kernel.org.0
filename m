Return-Path: <dmaengine+bounces-2836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B683594DDF3
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 20:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467CF282487
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05B49626;
	Sat, 10 Aug 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4H/T12C"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD793AC2B;
	Sat, 10 Aug 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723314791; cv=none; b=cpwO2D4sRrBZWJ8o4OiHSpNZXA3KOPlTKMNT9n6h8myu8yQd7yrgJDfbxqMTyYbTSD1TT5W19UiXjQfDa+I9RzHySmG/dRvPYtHSmZeprHaofQsEOBN6rxUVXwfHh5fIZ8jRAhp5rA0/A9mUpQB7K96tWLseG3fm9MteCZyte/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723314791; c=relaxed/simple;
	bh=eGls9Tl2rVMSGkjMNb8pZodrbzu5qJSlgdgmQqLdUd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=meN/tLAVcLZWF/XMkYk3L+nF0A7IWtZx1WvfpIs9wCsLV/1k4GTmi+q7FwqG5x0Ufc7RzNlb2gFQqChoJNDBIQxhPHmeVg/9rN3wzgy6egNtmAn9vMsgWm7PoiGJ03p3iIVL9oKiKC64tXXO1cu+zTbL4k5zU91ceAamjkIn4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4H/T12C; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7106cf5771bso2599658b3a.2;
        Sat, 10 Aug 2024 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723314789; x=1723919589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4c+whqw7VCHvGEHz3FeHPPNwPTgAPKV0FJKHEoguag=;
        b=l4H/T12C7T6rEbRe/VqzGsTPVjrMYKIGc2NrNf0UFepErZ/Mtw2RM63jlTPsJfynL4
         2U8vtvAsb26Am4rBPwVd5AxZ78MOEt2YMbvU2sFh5ZeB/Uce7U3+TtzC5qUv29K1eVe8
         BwkxjvjOTfkDzTkxp+KmtRboYGY9sEv37EsPvraCzh6rjolhAdwp5Bj5ZO4YPZdtjO60
         GuS5O0gjSwyEXLGcWREgmTUlRfc4cWnOP8O0eYCgakgHnqiOJgPONVhfXTsSyTmUrYVT
         TbrVubl+Phbz0VChnI7lteUo/Ag31/Bsec5ItiobTXQZcGnHjmbgAN/wtt6ykZX2Zn8c
         JEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723314789; x=1723919589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4c+whqw7VCHvGEHz3FeHPPNwPTgAPKV0FJKHEoguag=;
        b=XuMiVej3WM9VqdF7tkYa+g+TtiTla4b4/D8x2aGMNCujnIwNyhD0UsNMkEv4zi4nMY
         1RNOz/5CYmhorroyZSEyRmyclcsk+x83ICYAtGTi10cN6kByuNpUrUtFU82bJYuYYUxH
         1wSApzgW8s1k1T9wSIzWbBpcVSy01m2zAkoIlh6+NudjQ2L+Idn/8MRtndShVE43WaqP
         4K85oe5AmYBxCFSkjQgAiAYWqdVf0e9a2LdcP0lpiM+rCAy1YuJ0qf13pC/qgBkD4OXn
         KOXXO5badnWjwGR2pIVlWhi2g+D5HYa3PMejvPS9NIAzcYmIIf4h2bkN3C+grmtUGfHe
         w5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVmP+mIDdzL7JOhs+o8C1QDPSf0D7aMitrEpdp0XHfF8sp4UiSwodm+xCT6DfsDWziTjc8CzWGPzbQcYanVN2jch2XHQQw1Zk+bPkUPC9BffE97jZosMTyrWorlslb7hmetIUXy
X-Gm-Message-State: AOJu0Yy0INdz+pyj3Mg2NdZgZ7yeuMFXnv02dwUUosPbWrTcbF2gKGP2
	KSRr1P+ngAN8d6DW7wK4tElXrw2Aa1bKUVIYABo0BOQaxgEGDVm2LKpvviF9
X-Google-Smtp-Source: AGHT+IGAmoob6M2YfzT7qs47bzAguInmQOEGahZYxNNUI6bjBDtp76GyhC9jEtaDU6a7uIsymMEwLw==
X-Received: by 2002:a05:6a00:4f89:b0:70b:30ce:dfdb with SMTP id d2e1a72fcca58-710dc77f957mr4797138b3a.24.1723314789127;
        Sat, 10 Aug 2024 11:33:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:10b8:2b0a:a61f:9daf:ba70:6c3d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a43ccdsm1503418b3a.138.2024.08.10.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 11:33:08 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: linux-doc@vger.kernel.org,
	ricardo@marliere.net
Cc: av2082000@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	amelie.delaunay@foss.st.com,
	corbet@lwn.net,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bhelgaas@google.com,
	conor.dooley@microchip.com,
	costa.shul@redhat.com,
	dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	workflows@vger.kernel.org
Subject: [PATCH] Documentation: Fix spelling mistakes
Date: Sun, 11 Aug 2024 00:02:38 +0530
Message-Id: <20240810183238.34481-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected spelling mistakes in the documentation to improve readability.

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst | 4 ++--
 Documentation/arch/arm64/cpu-hotplug.rst                 | 2 +-
 Documentation/arch/powerpc/ultravisor.rst                | 2 +-
 Documentation/arch/riscv/vector.rst                      | 2 +-
 Documentation/arch/sparc/oradax/oracle-dax.rst           | 2 +-
 Documentation/arch/x86/mds.rst                           | 2 +-
 Documentation/arch/x86/x86_64/fsgs.rst                   | 4 ++--
 Documentation/process/backporting.rst                    | 6 +++---
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst b/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
index 2945e0e33104..301aa30890ae 100644
--- a/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
+++ b/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
@@ -359,7 +359,7 @@ Driver updates for STM32 DMA-MDMA chaining support in foo driver
     descriptor you want a callback to be called at the end of the transfer
     (dmaengine_prep_slave_sg()) or the period (dmaengine_prep_dma_cyclic()).
     Depending on the direction, set the callback on the descriptor that finishes
-    the overal transfer:
+    the overall transfer:
 
     * DMA_DEV_TO_MEM: set the callback on the "MDMA" descriptor
     * DMA_MEM_TO_DEV: set the callback on the "DMA" descriptor
@@ -371,7 +371,7 @@ Driver updates for STM32 DMA-MDMA chaining support in foo driver
   As STM32 MDMA channel transfer is triggered by STM32 DMA, you must issue
   STM32 MDMA channel before STM32 DMA channel.
 
-  If any, your callback will be called to warn you about the end of the overal
+  If any, your callback will be called to warn you about the end of the overall
   transfer or the period completion.
 
   Don't forget to terminate both channels. STM32 DMA channel is configured in
diff --git a/Documentation/arch/arm64/cpu-hotplug.rst b/Documentation/arch/arm64/cpu-hotplug.rst
index 76ba8d932c72..8fb438bf7781 100644
--- a/Documentation/arch/arm64/cpu-hotplug.rst
+++ b/Documentation/arch/arm64/cpu-hotplug.rst
@@ -26,7 +26,7 @@ There are no systems that support the physical addition (or removal) of CPUs
 while the system is running, and ACPI is not able to sufficiently describe
 them.
 
-e.g. New CPUs come with new caches, but the platform's cache toplogy is
+e.g. New CPUs come with new caches, but the platform's cache topology is
 described in a static table, the PPTT. How caches are shared between CPUs is
 not discoverable, and must be described by firmware.
 
diff --git a/Documentation/arch/powerpc/ultravisor.rst b/Documentation/arch/powerpc/ultravisor.rst
index ba6b1bf1cc44..6d0407b2f5a1 100644
--- a/Documentation/arch/powerpc/ultravisor.rst
+++ b/Documentation/arch/powerpc/ultravisor.rst
@@ -134,7 +134,7 @@ Hardware
 
       * PTCR and partition table entries (partition table is in secure
         memory). An attempt to write to PTCR will cause a Hypervisor
-        Emulation Assitance interrupt.
+        Emulation Assistance interrupt.
 
       * LDBAR (LD Base Address Register) and IMC (In-Memory Collection)
         non-architected registers. An attempt to write to them will cause a
diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
index 75dd88a62e1d..e4a28def318a 100644
--- a/Documentation/arch/riscv/vector.rst
+++ b/Documentation/arch/riscv/vector.rst
@@ -15,7 +15,7 @@ status for the use of Vector in userspace. The intended usage guideline for
 these interfaces is to give init systems a way to modify the availability of V
 for processes running under its domain. Calling these interfaces is not
 recommended in libraries routines because libraries should not override policies
-configured from the parant process. Also, users must noted that these interfaces
+configured from the parent process. Also, users must noted that these interfaces
 are not portable to non-Linux, nor non-RISC-V environments, so it is discourage
 to use in a portable code. To get the availability of V in an ELF program,
 please read :c:macro:`COMPAT_HWCAP_ISA_V` bit of :c:macro:`ELF_HWCAP` in the
diff --git a/Documentation/arch/sparc/oradax/oracle-dax.rst b/Documentation/arch/sparc/oradax/oracle-dax.rst
index d1e14d572918..54ccb35ed51d 100644
--- a/Documentation/arch/sparc/oradax/oracle-dax.rst
+++ b/Documentation/arch/sparc/oradax/oracle-dax.rst
@@ -197,7 +197,7 @@ Memory Constraints
 ==================
 
 The DAX hardware operates only on physical addresses. Therefore, it is
-not aware of virtual memory mappings and the discontiguities that may
+not aware of virtual memory mappings and the discontinuities that may
 exist in the physical memory that a virtual buffer maps to. There is
 no I/O TLB or any scatter/gather mechanism. All buffers, whether input
 or output, must reside in a physically contiguous region of memory.
diff --git a/Documentation/arch/x86/mds.rst b/Documentation/arch/x86/mds.rst
index c58c72362911..5a2e6c0ef04a 100644
--- a/Documentation/arch/x86/mds.rst
+++ b/Documentation/arch/x86/mds.rst
@@ -162,7 +162,7 @@ Mitigation points
    3. It would take a large number of these precisely-timed NMIs to mount
       an actual attack.  There's presumably not enough bandwidth.
    4. The NMI in question occurs after a VERW, i.e. when user state is
-      restored and most interesting data is already scrubbed. Whats left
+      restored and most interesting data is already scrubbed. What's left
       is only the data that NMI touches, and that may or may not be of
       any interest.
 
diff --git a/Documentation/arch/x86/x86_64/fsgs.rst b/Documentation/arch/x86/x86_64/fsgs.rst
index 50960e09e1f6..d07e445dac5c 100644
--- a/Documentation/arch/x86/x86_64/fsgs.rst
+++ b/Documentation/arch/x86/x86_64/fsgs.rst
@@ -125,7 +125,7 @@ FSGSBASE instructions enablement
 FSGSBASE instructions compiler support
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
+GCC version 4.6.4 and newer provide intrinsics for the FSGSBASE
 instructions. Clang 5 supports them as well.
 
   =================== ===========================
@@ -135,7 +135,7 @@ instructions. Clang 5 supports them as well.
   _writegsbase_u64()  Write the GS base register
   =================== ===========================
 
-To utilize these instrinsics <immintrin.h> must be included in the source
+To utilize these intrinsics <immintrin.h> must be included in the source
 code and the compiler option -mfsgsbase has to be added.
 
 Compiler support for FS/GS based addressing
diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
index e1a6ea0a1e8a..a71480fcf3b4 100644
--- a/Documentation/process/backporting.rst
+++ b/Documentation/process/backporting.rst
@@ -73,7 +73,7 @@ Once you have the patch in git, you can go ahead and cherry-pick it into
 your source tree. Don't forget to cherry-pick with ``-x`` if you want a
 written record of where the patch came from!
 
-Note that if you are submiting a patch for stable, the format is
+Note that if you are submitting a patch for stable, the format is
 slightly different; the first line after the subject line needs tobe
 either::
 
@@ -147,7 +147,7 @@ divergence.
 It's important to always identify the commit or commits that caused the
 conflict, as otherwise you cannot be confident in the correctness of
 your resolution. As an added bonus, especially if the patch is in an
-area you're not that famliar with, the changelogs of these commits will
+area you're not that familiar with, the changelogs of these commits will
 often give you the context to understand the code and potential problems
 or pitfalls with your conflict resolution.
 
@@ -197,7 +197,7 @@ git blame
 Another way to find prerequisite commits (albeit only the most recent
 one for a given conflict) is to run ``git blame``. In this case, you
 need to run it against the parent commit of the patch you are
-cherry-picking and the file where the conflict appared, i.e.::
+cherry-picking and the file where the conflict appeared, i.e.::
 
     git blame <commit>^ -- <path>
 
-- 
2.25.1


