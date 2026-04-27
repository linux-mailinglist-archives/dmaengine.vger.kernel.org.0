Return-Path: <dmaengine+bounces-10140-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE8lEv6a72kbDQEAu9opvQ
	(envelope-from <dmaengine+bounces-10140-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:21:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB24774A4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D4BA30A9218
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED83E3175;
	Mon, 27 Apr 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZa57++f"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC33770B;
	Mon, 27 Apr 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310252; cv=none; b=j7cBcKTYNlba7cJV2AV0a9gLsn3bCWWV1FXKptQDehLbBF+nudT5ldad3Q2KGFLE7APlRzXlyH8rz0x9DaldbToDuE3q/yOYC7z+3va78v5M8+8cJZ+EKZRacNHqNCfCRpE2XPMTJxPp3fkPG3Hc3q1Hlpv9OIRwZJ3NqpBL/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310252; c=relaxed/simple;
	bh=2A3pp34TaOBrBLCc7n3D/0VUADnJLMBU+ywYlmILDq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvJPG62fa9uCUAI3nGeWO54Fc3zZ/V6rMDrvh1CjjmzgOcsLMw7gfi3/FLE02k4w/SqlRkSxPP3ij8T0U3EbY7oHN+v6y2Em8iPVjKXetQUJrvqT/gNBhVwUrmDbg3yRraukPIGK3KUUrAUKAU+n8Ep/ecN7TY3q6oV+vYKw4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZa57++f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEAAC2BCB5;
	Mon, 27 Apr 2026 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310252;
	bh=2A3pp34TaOBrBLCc7n3D/0VUADnJLMBU+ywYlmILDq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZa57++f4J+GqwvmN6cOlz8Y1H7GNDryi4ZRD+CJk+hBQU7Iobf+tE7/GXYinO2zm
	 iEth1up0MDkLOAxzQiz5mqcfHR3P06TXmSl3XzIFaDPQuFHo3UkJmapo/kW88jy3aQ
	 3aznlfwGIxcYhdaW4V5tVjatVhcyAHWEKfRp+CGH8zAHmw+dzciaz6iCaNPprV57bn
	 8osxBss4ioepFyLm+2kR+UIAIIrgH8FbX9Dl39gcSvCHEwtnH4JUk+pOBX2jvh7BG3
	 7M8Bd9CW5MVAHSPSRYqg08B9eeC3kSJm80fJ6QSe91ed2+rsgDjp3uvvAKjOOY8v3a
	 6k1/LUiGGTPUw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-x25@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v1 2/9] uaccess: Convert INLINE_COPY_{TO/FROM}_USER to kconfig and reduce ifdefery
Date: Mon, 27 Apr 2026 19:13:43 +0200
Message-ID: <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18999; i=chleroy@kernel.org; h=from:subject:message-id; bh=2A3pp34TaOBrBLCc7n3D/0VUADnJLMBU+ywYlmILDq0=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxl942rk7qV/z0wpsopc/EjgrOKra6+/qq3zDzp1o 3Cx5MQvcR2lLAxiXAyyYoosx/9z75rR9SU1f+oufZg5rEwgQxi4OAVgIuKajAx/ndKvMf5+vP6+ 0DUOzaI/8u977T8/tn8jYyzy8FHU4dqzDP9dp5oyP1vg/Kml4FbUFMnSvxpN1/NNNGPF159+JNd bVcIDAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0FB24774A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_TO(0.00)[nvidia.com,linux-foundation.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-10140-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Among the 21 architectures supported by the kernel, 16 define both
INLINE_COPY_TO_USER and INLINE_COPY_FROM_USER while the 5 other ones
don't define any of the two.

To simplify and reduce risk of mistakes, convert them to a single
kconfig item named CONFIG_ARCH_WANTS_NOINLINE_COPY which will be
selected by the 5 architectures that don't want inlined copy.

To minimise complication in a later patch, also remove
ifdefery and replace it with IS_ENABLED().

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/alpha/Kconfig                    |  1 +
 arch/arc/include/asm/uaccess.h        |  3 ---
 arch/arm/include/asm/uaccess.h        |  2 --
 arch/arm64/include/asm/uaccess.h      |  3 ---
 arch/csky/Kconfig                     |  1 +
 arch/hexagon/include/asm/uaccess.h    |  3 ---
 arch/loongarch/include/asm/uaccess.h  |  3 ---
 arch/m68k/include/asm/uaccess.h       |  3 ---
 arch/microblaze/include/asm/uaccess.h |  2 --
 arch/mips/include/asm/uaccess.h       |  3 ---
 arch/nios2/include/asm/uaccess.h      |  2 --
 arch/openrisc/include/asm/uaccess.h   |  2 --
 arch/parisc/include/asm/uaccess.h     |  3 ---
 arch/powerpc/Kconfig                  |  1 +
 arch/riscv/Kconfig                    |  1 +
 arch/s390/include/asm/uaccess.h       |  3 ---
 arch/sh/include/asm/uaccess.h         |  2 --
 arch/sparc/include/asm/uaccess_32.h   |  3 ---
 arch/sparc/include/asm/uaccess_64.h   |  2 --
 arch/um/include/asm/uaccess.h         |  3 ---
 arch/x86/Kconfig                      |  1 +
 arch/xtensa/include/asm/uaccess.h     |  2 --
 include/asm-generic/uaccess.h         |  2 --
 include/linux/uaccess.h               | 32 ++++++++++++---------------
 lib/Kconfig                           |  3 +++
 lib/Makefile                          |  3 ++-
 lib/usercopy.c                        |  4 ----
 rust/helpers/uaccess.c                |  2 +-
 28 files changed, 25 insertions(+), 70 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7b7dafe7d9df..65e533cead6b 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -11,6 +11,7 @@ config ALPHA
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_WANTS_NOINLINE_COPY_USER
 	select FORCE_PCI
 	select PCI_DOMAINS if PCI
 	select PCI_SYSCALL if PCI
diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 1e8809ea000a..e8b161b37a03 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -628,9 +628,6 @@ static inline unsigned long __clear_user(void __user *to, unsigned long n)
 	return res;
 }
 
-#define INLINE_COPY_TO_USER
-#define INLINE_COPY_FROM_USER
-
 #define __clear_user			__clear_user
 
 #include <asm-generic/uaccess.h>
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index d6ae80b5df36..7280c162bb71 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -616,8 +616,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 }
 #define __clear_user(addr, n)		(memset((void __force *)addr, 0, n), 0)
 #endif
-#define INLINE_COPY_TO_USER
-#define INLINE_COPY_FROM_USER
 
 static inline unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index b0c83a08dda9..1e20ec91b56f 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -456,9 +456,6 @@ do {									\
 	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
 } while (0)
 
-#define INLINE_COPY_TO_USER
-#define INLINE_COPY_FROM_USER
-
 extern unsigned long __must_check __arch_clear_user(void __user *to, unsigned long n);
 static inline unsigned long __must_check __clear_user(void __user *to, unsigned long n)
 {
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4331313a42ff..d010d7eb47bf 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -40,6 +40,7 @@ config CSKY
 	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	select ARCH_WANTS_NOINLINE_COPY_USER
 	select COMMON_CLK
 	select CLKSRC_MMIO
 	select CSKY_MPINTC if CPU_CK860
diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index bff77efc0d9a..4bf863217636 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -26,9 +26,6 @@ unsigned long raw_copy_from_user(void *to, const void __user *from,
 				     unsigned long n);
 unsigned long raw_copy_to_user(void __user *to, const void *from,
 				   unsigned long n);
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
 __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count);
 #define __clear_user(a, s) __clear_user_hexagon((a), (s))
 
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
index 438269313e78..72a04ac88549 100644
--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -292,9 +292,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return __copy_user((__force void *)to, from, n);
 }
 
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
  * @addr: Destination address, in user space.
diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
index 64914872a5c9..20e249a6ad07 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -377,9 +377,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 		return __constant_copy_to_user(to, from, n);
 	return __generic_copy_to_user(to, from, n);
 }
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	type *__gk_dst = (type *)(dst);					\
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index 3aab2f17e046..3355f541e12a 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -250,8 +250,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	return __copy_tofrom_user(to, (__force const void __user *)from, n);
 }
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
 
 /*
  * Copy a null terminated string from userspace.
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index c0cede273c7c..8714caefbac8 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -433,9 +433,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return __cu_len_r;
 }
 
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
 extern __kernel_size_t __bzero(void __user *addr, __kernel_size_t size);
 
 /*
diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index 6ccc9a232c23..46d7312a1c96 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -57,8 +57,6 @@ extern unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n);
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
 
 extern long strncpy_from_user(char *__to, const char __user *__from,
 			      long __len);
diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index d6500a374e18..c84effde867a 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -218,8 +218,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long size)
 {
 	return __copy_tofrom_user((__force void *)to, from, size);
 }
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
 
 extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index 6c531d2c847e..1dd6a1dd653f 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -197,7 +197,4 @@ unsigned long __must_check raw_copy_to_user(void __user *dst, const void *src,
 					    unsigned long len);
 unsigned long __must_check raw_copy_from_user(void *dst, const void __user *src,
 					    unsigned long len);
-#define INLINE_COPY_TO_USER
-#define INLINE_COPY_FROM_USER
-
 #endif /* __PARISC_UACCESS_H */
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e93df95b79e7..6816f402fe3d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -187,6 +187,7 @@ config PPC
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
 	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
+	select ARCH_WANTS_NOINLINE_COPY_USER
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select AUDIT_ARCH_COMPAT_GENERIC
 	select BINFMT_ELF
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d235396c4514..492b920c1a51 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -88,6 +88,7 @@ config RISCV
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
+	select ARCH_WANTS_NOINLINE_COPY_USER if MMU
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index dff035372601..2e0472c20da0 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -30,9 +30,6 @@ void debug_user_asce(int exit);
 #define uaccess_kmsan_or_inline __always_inline
 #endif
 
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
 static uaccess_kmsan_or_inline __must_check unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long size)
 {
diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index a79609eb14be..0cd75308e6d3 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -95,8 +95,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	return __copy_user((__force void *)to, from, n);
 }
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
 
 /*
  * Clear the area and return remaining number of bytes
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index 43284b6ec46a..e01f43c6421c 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -190,9 +190,6 @@ static inline unsigned long raw_copy_from_user(void *to, const void __user *from
 	return __copy_user((__force void __user *) to, from, n);
 }
 
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
 static inline unsigned long __clear_user(void __user *addr, unsigned long size)
 {
 	unsigned long ret;
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index b825a5dd0210..62ee0b074fec 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -231,8 +231,6 @@ unsigned long __must_check raw_copy_from_user(void *to,
 unsigned long __must_check raw_copy_to_user(void __user *to,
 					   const void *from,
 					   unsigned long size);
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
 
 unsigned long __must_check raw_copy_in_user(void __user *to,
 					   const void __user *from,
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 0df9ea4abda8..1e14260c7f0f 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -27,9 +27,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 #define __access_ok __access_ok
 #define __clear_user __clear_user
 
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
 #include <asm-generic/uaccess.h>
 
 static inline int __access_ok(const void __user *ptr, unsigned long size)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f3f7cb01d69d..c1e58d8c6864 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -143,6 +143,7 @@ config X86
 	select ARCH_WANTS_CLOCKSOURCE_READ_INLINE	if X86_64
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
+	select ARCH_WANTS_NOINLINE_COPY_USER
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 56aec6d504fe..f9e1623a7be9 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -237,8 +237,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	prefetch(from);
 	return __xtensa_copy_user((__force void *)to, from, n);
 }
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
 
 /*
  * We need to return the number of bytes not cleared.  Our memset()
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index b276f783494c..fb33a71fd24e 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -91,8 +91,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	memcpy((void __force *)to, from, n);
 	return 0;
 }
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
 #endif /* CONFIG_UACCESS_MEMCPY */
 
 /*
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 56328601218c..bd1201c81d94 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -83,8 +83,8 @@
  * with that.  They should not be used directly; they are used to implement
  * the 6 functions (copy_{to,from}_user(), __copy_{to,from}_user_inatomic())
  * that are used instead.  Out of those, __... ones are inlined.  Plain
- * copy_{to,from}_user() might or might not be inlined.  If you want them
- * inlined, have asm/uaccess.h define INLINE_COPY_{TO,FROM}_USER.
+ * copy_{to,from}_user() might or might not be inlined.  If you don't want them
+ * inlined, select CONFIG_ARCH_WANTS_NOINLINE_COPY_USER.
  *
  * NOTE: only copy_from_user() zero-pads the destination in case of short copy.
  * Neither __copy_from_user() nor __copy_from_user_inatomic() zero anything
@@ -157,8 +157,8 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 }
 
 /*
- * Architectures that #define INLINE_COPY_TO_USER use this function
- * directly in the normal copy_to/from_user(), the other ones go
+ * Architectures that don't select CONFIG_ARCH_WANTS_NOINLINE_COPY_USER use
+ * this function directly in the normal copy_to/from_user(), the other ones go
  * through an extern _copy_to/from_user(), which expands the same code
  * here.
  */
@@ -190,10 +190,9 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 	memset(to + (n - res), 0, res);
 	return res;
 }
-#ifndef INLINE_COPY_FROM_USER
+
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
-#endif
 
 static inline __must_check unsigned long
 _inline_copy_to_user(void __user *to, const void *from, unsigned long n)
@@ -207,21 +206,19 @@ _inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 	}
 	return n;
 }
-#ifndef INLINE_COPY_TO_USER
+
 extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
-#endif
 
 static __always_inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (!check_copy_size(to, n, false))
 		return n;
-#ifdef INLINE_COPY_FROM_USER
-	return _inline_copy_from_user(to, from, n);
-#else
-	return _copy_from_user(to, from, n);
-#endif
+	if (IS_ENABLED(ARCH_WANTS_NOINLINE_COPY_USER))
+		return _copy_from_user(to, from, n);
+	else
+		return _inline_copy_from_user(to, from, n);
 }
 
 static __always_inline unsigned long __must_check
@@ -230,11 +227,10 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 	if (!check_copy_size(from, n, true))
 		return n;
 
-#ifdef INLINE_COPY_TO_USER
-	return _inline_copy_to_user(to, from, n);
-#else
-	return _copy_to_user(to, from, n);
-#endif
+	if (IS_ENABLED(ARCH_WANTS_NOINLINE_COPY_USER))
+		return _copy_to_user(to, from, n);
+	else
+		return _inline_copy_to_user(to, from, n);
 }
 
 #ifndef copy_mc_to_kernel
diff --git a/lib/Kconfig b/lib/Kconfig
index 00a9509636c1..a2e07d4dd2bf 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -68,6 +68,9 @@ config ARCH_HAS_STRNCPY_FROM_USER
 config ARCH_HAS_STRNLEN_USER
 	bool
 
+config ARCH_WANTS_NOINLINE_COPY_USER
+	bool
+
 config GENERIC_STRNCPY_FROM_USER
 	def_bool !ARCH_HAS_STRNCPY_FROM_USER
 
diff --git a/lib/Makefile b/lib/Makefile
index 7c0334d7675b..f4d577910671 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -57,9 +57,10 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
-	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
+	 once.o refcount.o rcuref.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
 obj-y += usercheck.o
+obj-$(CONFIG_ARCH_WANTS_NOINLINE_COPY_USER) += usercopy.o
 obj-y += string_helpers.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 7a93f56d81dd..d2deb4b0a3c5 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -4,18 +4,14 @@
 
 /* out-of-line parts */
 
-#if !defined(INLINE_COPY_FROM_USER)
 unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	return _inline_copy_from_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_from_user);
-#endif
 
-#if !defined(INLINE_COPY_TO_USER)
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	return _inline_copy_to_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_to_user);
-#endif
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
index d9625b9ee046..01de4fbbcc84 100644
--- a/rust/helpers/uaccess.c
+++ b/rust/helpers/uaccess.c
@@ -14,7 +14,7 @@ rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return copy_to_user(to, from, n);
 }
 
-#ifdef INLINE_COPY_FROM_USER
+#ifndef CONFIG_ARCH_WANTS_NOINLINE_COPY_USER
 __rust_helper
 unsigned long rust_helper__copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-- 
2.49.0


