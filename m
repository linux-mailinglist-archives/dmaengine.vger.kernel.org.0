Return-Path: <dmaengine+bounces-10139-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF1KEHma72kbDQEAu9opvQ
	(envelope-from <dmaengine+bounces-10139-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:18:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F447721C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA01307426F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2EB36074F;
	Mon, 27 Apr 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccnzw+ca"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBD31159C;
	Mon, 27 Apr 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310233; cv=none; b=Fcv4IoDZLX3sKWsgNOQ8O4PaaewmbZwoxkKixz636T8pqy4uWOZFrewhtFadeg+pU6ZgZfIdqfxHlVcJWrQTwl5HcoJPVtz8Am3a5jJRG3t9E3/oM/ZPsAbQIja/uXZT9aI/MAXKbnuhZx6l4P+M76jj9PsNCslk1cwz/y7GQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310233; c=relaxed/simple;
	bh=745VKRe61Lf8afs4o89V2mPmcfGcqMzEwAyCkwUFzR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1sRQB/PoXn0uxh+TitWaBvdnAW19gbxBnm3Dzp0XHxW99/oz6sU6VR3f4pX9xsvdA6BU1sAwtZWkIiSjUipNvJgXRqPa20U5FMMAoy4fahOKIW7n1Fmw5KAEo0EonS8TO3wKRhiClcV+NL66QBcQt5E+J2PQ6d6aEYjXXAkv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccnzw+ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC974C2BCB5;
	Mon, 27 Apr 2026 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310232;
	bh=745VKRe61Lf8afs4o89V2mPmcfGcqMzEwAyCkwUFzR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccnzw+capg6i/qeCJEEZZnJkaeh2P8NEABjGdQ84B8/8ElHQuhaIfwHK4KyIZjuzW
	 fShA2udW2NQ0Ct7kJfcn/Kb043ljqkq7hTjPsRqwiNPGH9FmgvMogRNjEATWGrG26g
	 6zW5qtX0OAMj+t+S60HkjDsyGYMrisyc3m/7o9VPvVvQnsaPOrT5y+ZTzyh8Xto7fx
	 AWFGU9d3c0Mo3tNoddRUR02dQmZ5LMWSNNkmTWtszo39IueJ4zsAp4+3T5NcIhGntz
	 oVxgjUbjxhRTuJF8KweLMZaWvhi+rfu1/RR3XrUIQOPEazAae4t8SpoXJ0czDjJbhT
	 7qOjNG8l7cqnA==
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
Subject: [RFC PATCH v1 1/9] uaccess: Split check_zeroed_user() out of usercopy.c
Date: Mon, 27 Apr 2026 19:13:42 +0200
Message-ID: <a6d39afb167871e0459946dfd6b28bc994ae3c81.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4389; i=chleroy@kernel.org; h=from:subject:message-id; bh=745VKRe61Lf8afs4o89V2mPmcfGcqMzEwAyCkwUFzR4=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxmtvkzq83WmyICs092/GNmylHyYwx1uy/R0rjqso Tc19NiJjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCRrBxGhr1T21lnr9ow8bLw mlcX9LlDfR53LmTbs/fCv2dGAh23RTkY/gpGWFpU+sbMuNm2suHwI9OT2xZsfrLc1dbD4+idxHd 72DkA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D05F447721C
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
	TAGGED_FROM(0.00)[bounces-10139-lists,dmaengine=lfdr.de];
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

Until commit f5a1a536fa14 ("lib: introduce copy_struct_from_user()
helper"), lib/usercopy.c was containing only the out-line version
of user copy fonctions.

That commit added function check_zeroed_user() into the same file.
Move that function into a new file named usercheck.c, so that next
patch can change usercopy.c build to a conditional build.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 lib/Makefile                    |  1 +
 lib/{usercopy.c => usercheck.c} | 22 ------------
 lib/usercopy.c                  | 62 ---------------------------------
 3 files changed, 1 insertion(+), 84 deletions(-)
 copy lib/{usercopy.c => usercheck.c} (73%)

diff --git a/lib/Makefile b/lib/Makefile
index f33a24bf1c19..7c0334d7675b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -59,6 +59,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
+obj-y += usercheck.o
 obj-y += string_helpers.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
diff --git a/lib/usercopy.c b/lib/usercheck.c
similarity index 73%
copy from lib/usercopy.c
copy to lib/usercheck.c
index b00a3a957de6..15b0d9a18435 100644
--- a/lib/usercopy.c
+++ b/lib/usercheck.c
@@ -2,32 +2,10 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/export.h>
-#include <linux/fault-inject-usercopy.h>
-#include <linux/instrumented.h>
 #include <linux/kernel.h>
-#include <linux/nospec.h>
-#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/wordpart.h>
 
-/* out-of-line parts */
-
-#if !defined(INLINE_COPY_FROM_USER)
-unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
-{
-	return _inline_copy_from_user(to, from, n);
-}
-EXPORT_SYMBOL(_copy_from_user);
-#endif
-
-#if !defined(INLINE_COPY_TO_USER)
-unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
-{
-	return _inline_copy_to_user(to, from, n);
-}
-EXPORT_SYMBOL(_copy_to_user);
-#endif
-
 /**
  * check_zeroed_user: check if a userspace buffer only contains zero bytes
  * @from: Source address, in userspace.
diff --git a/lib/usercopy.c b/lib/usercopy.c
index b00a3a957de6..7a93f56d81dd 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,14 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/compiler.h>
-#include <linux/errno.h>
 #include <linux/export.h>
-#include <linux/fault-inject-usercopy.h>
-#include <linux/instrumented.h>
-#include <linux/kernel.h>
-#include <linux/nospec.h>
-#include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/wordpart.h>
 
 /* out-of-line parts */
 
@@ -27,57 +19,3 @@ unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif
-
-/**
- * check_zeroed_user: check if a userspace buffer only contains zero bytes
- * @from: Source address, in userspace.
- * @size: Size of buffer.
- *
- * This is effectively shorthand for "memchr_inv(from, 0, size) == NULL" for
- * userspace addresses (and is more efficient because we don't care where the
- * first non-zero byte is).
- *
- * Returns:
- *  * 0: There were non-zero bytes present in the buffer.
- *  * 1: The buffer was full of zero bytes.
- *  * -EFAULT: access to userspace failed.
- */
-int check_zeroed_user(const void __user *from, size_t size)
-{
-	unsigned long val;
-	uintptr_t align = (uintptr_t) from % sizeof(unsigned long);
-
-	if (unlikely(size == 0))
-		return 1;
-
-	from -= align;
-	size += align;
-
-	if (!user_read_access_begin(from, size))
-		return -EFAULT;
-
-	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
-	if (align)
-		val &= ~aligned_byte_mask(align);
-
-	while (size > sizeof(unsigned long)) {
-		if (unlikely(val))
-			goto done;
-
-		from += sizeof(unsigned long);
-		size -= sizeof(unsigned long);
-
-		unsafe_get_user(val, (unsigned long __user *) from, err_fault);
-	}
-
-	if (size < sizeof(unsigned long))
-		val &= aligned_byte_mask(size);
-
-done:
-	user_read_access_end();
-	return (val == 0);
-err_fault:
-	user_read_access_end();
-	return -EFAULT;
-}
-EXPORT_SYMBOL(check_zeroed_user);
-- 
2.49.0


