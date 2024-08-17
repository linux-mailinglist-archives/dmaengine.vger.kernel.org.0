Return-Path: <dmaengine+bounces-2882-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD595562B
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 09:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5CA283984
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183561422C7;
	Sat, 17 Aug 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUCopgOZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3213DDCD;
	Sat, 17 Aug 2024 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879667; cv=none; b=ur1S/bj8/5W9qywUZIercF5BkdBdVHQ6exvTxxi1XK7uH71vp781XO5s4Fk/N7fqVLpuGiJVZgQsdtrSQh9UyaB7byzDqhuBsia1i5hTa8uZGrMIrdsxq2pFdcGjQOzszBw5jU3ZCG0BRqLRXoR4LiprXlFFj5JWCjlHVl8U+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879667; c=relaxed/simple;
	bh=YmjnadZprPl5LhU0GawUbqbFaPXJOac0OebQ4z6+rOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B3iWzCimfEN6NJE0zWb4tdsxEm3q58F3iLXVK39E0orZHv7h+UjK2ZvtXdX29YU/7IIwPIfhzaH/3Xh6CHirqSPEs965dSutABT3LHHp0sBI8gOw3Yb04NAu2ydSc1TuLcofmYUBdLjV1hHeDe8xDwGJbeJ6BuLuwdKnHeJzeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUCopgOZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so2002682a91.2;
        Sat, 17 Aug 2024 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723879664; x=1724484464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fjk2EI8ZiEP4zfYt0Qe13udGW0VGF08C7NmtxZPQvvA=;
        b=dUCopgOZRDN3iaVCkgrjqU3iRcYPzhxv/aY2X7YN/upzeqtyjG5M0bo2Ac1tv4SrVN
         oTW5Ohz4yQvYIf5aTJG2++kN33NZz2XJwUXBboMRzQT8wwbIIMf75yARhuMo1ed1g65S
         vDDpMDrm324Q4uSATvm3xp3PZjkeaSwFLyhauGHQRaIniu2iFuHxS+HOdXvt0F+NLJNI
         oLjzbi7dT5szXaMDQOP6QsmVq2HqKvhbt8AYURsdlgb1pw7pdDIgycuYnL3K/amewnkf
         Aor41Bod7d02lakgALT7wN8K0bL3bQtVyEENX/+t2azHLWF/kboSP8CZKeU5gYInXsyv
         u90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723879664; x=1724484464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fjk2EI8ZiEP4zfYt0Qe13udGW0VGF08C7NmtxZPQvvA=;
        b=FU+QbaPgUhwOMkfAVjc4qBO/hUqx5+vhD1yv0hSU5SGe3XjEOqW2l9YsIMpqaf7Oad
         zP2DkJnekpkfGtHk3kl8X7V6/wa8yMCwTfFNe0bUetSSKEXX/O5Thq1B+HO/37L+uzlT
         5Yhg5mWn4HkzJ3hVtagv9mt3ijqLETiXrWyounqLo5PUDZFR2tKTA4dke9Lm1in6CKsn
         SwV2y1s3jwZlu1+iSvgcx3Nl9xctgQ8LvhkC3GDB2qz3YRkI5HYgoQjVnNqtOF4OEOZ/
         60m07XsbX10LJaw924Du+pA0MLprKFj6RFGjS0IAwSuXSoda9NIINhj/nUjGK5URoFYk
         Iisw==
X-Forwarded-Encrypted: i=1; AJvYcCXCELrrbIl6yAwzpLHTY0ww8Aqj5zfMZICWtylwahXyUj/RcAOZ+S0wE1ZFlad/P/tgy8m+zum3c+m/TAD0RH6F2ArqHJeid+4D4xclT8uy7AOiouICKTPJS/utsLBTljdRwew8
X-Gm-Message-State: AOJu0YxQmTmRThEtvxoyQUx1AHOU2yTg2XLZqraMXcyyBCeufFDiimTq
	J+ZDqSeMJyINBYTw3nMNMAL3SwNXhdxoV0Utntr1JnHFybIaQXVfuI9lTDkx
X-Google-Smtp-Source: AGHT+IE6X6NdUFqH5STro3RyFQKnmXLcd7Q/tjaJtzJodMhcakvq4bBfNlQl3NZjm0J23S7MY4VzKw==
X-Received: by 2002:a17:90b:1286:b0:2d0:86a:fbd with SMTP id 98e67ed59e1d1-2d3e00f08fcmr5267786a91.32.1723879664083;
        Sat, 17 Aug 2024 00:27:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:1031:6067:f4e3:ef39:b58b:607e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b228sm3179929a91.14.2024.08.17.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 00:27:43 -0700 (PDT)
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
Subject: [PATCH V2] Documentation: Fix spelling mistakes
Date: Sat, 17 Aug 2024 12:57:24 +0530
Message-Id: <20240817072724.6861-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling mistakes in the documentation to improve readability.

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
V1: https://lore.kernel.org/all/20240810183238.34481-1-av2082000@gmail.com
V1 -> V2:
- Write the commit description in imperative mode.
- Fix grammer mistakes in the sentence.
---
 Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst | 4 ++--
 Documentation/arch/arm64/cpu-hotplug.rst                 | 2 +-
 Documentation/arch/powerpc/ultravisor.rst                | 2 +-
 Documentation/arch/riscv/vector.rst                      | 2 +-
 Documentation/arch/x86/mds.rst                           | 2 +-
 Documentation/arch/x86/x86_64/fsgs.rst                   | 4 ++--
 Documentation/process/backporting.rst                    | 6 +++---
 7 files changed, 11 insertions(+), 11 deletions(-)

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
index 75dd88a62e1d..3987f5f76a9d 100644
--- a/Documentation/arch/riscv/vector.rst
+++ b/Documentation/arch/riscv/vector.rst
@@ -15,7 +15,7 @@ status for the use of Vector in userspace. The intended usage guideline for
 these interfaces is to give init systems a way to modify the availability of V
 for processes running under its domain. Calling these interfaces is not
 recommended in libraries routines because libraries should not override policies
-configured from the parant process. Also, users must noted that these interfaces
+configured from the parent process. Also, users must note that these interfaces
 are not portable to non-Linux, nor non-RISC-V environments, so it is discourage
 to use in a portable code. To get the availability of V in an ELF program,
 please read :c:macro:`COMPAT_HWCAP_ISA_V` bit of :c:macro:`ELF_HWCAP` in the
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


