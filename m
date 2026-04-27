Return-Path: <dmaengine+bounces-10147-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DfKJ2Oc72kbDQEAu9opvQ
	(envelope-from <dmaengine+bounces-10147-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:26:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A6477849
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFBE53124E3E
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00C3E7148;
	Mon, 27 Apr 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8kV5Zhk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC59339714;
	Mon, 27 Apr 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310365; cv=none; b=FMMCJWBZRrjjYSiA3eaR054EBybd+MBN+lSN3BN5CocSCcm8tIENJh1D+pCEesMt/NXdLvmDrgdKbTCry0Ws+gXSliqYGgAikUbOn+Q+F0KGjeL6CPBJrSP/6A4kIKVX2k8i7JaCo/d+VNC51IcRSJYDEqTpxQo1Wefcb3LD8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310365; c=relaxed/simple;
	bh=xblTv37x9V4gU3cvmA9ILfz6xXNOv0sNe2zU9C6a5nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhQrdf7UOghUHj346nNBuNK4t8QKwv42weWTHzLB9J9H1Pg4KEcSn0eVYUQ5ec4lrY6ahBwiH6ofUxBY24/Bicz662twTEYvS8xMs3PQ8bMO23fNazIbxyRHabz7++ADrmyPHUUZtHt6Ieg+neofEfeiXp9GpsZ8FZ+KHzEUFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8kV5Zhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25EEC2BCB7;
	Mon, 27 Apr 2026 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310364;
	bh=xblTv37x9V4gU3cvmA9ILfz6xXNOv0sNe2zU9C6a5nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8kV5Zhk7HZbxy8X7mxqUL5UgTTJPPuuLtSKHKOe5PwbIiNodL9/7ESxRbcOMv4dB
	 NN/pd897F5mMQZv6MW+RM/3mikWvqmJGQCtupbd6YHiobStaCQu79RRkwt3Bs1rL/A
	 WmXtcy3vIzgejB2MGSu6MrKJ33itreKKdFlemNypyCUExoUHGXA1bHbqFqaNX4ujdd
	 iXZiXWTV/w69yfgs2V8e+zdWAilhhtsvDDxzPIT8CbbievjXPmrPwVloE5aoqLKmYP
	 ca2+sf92YJQm2mLHcpyNlGd6mMQP6QhUed6Hx8vk/CloBjO7tSgz4fayv+CeXka+Fz
	 NwGM6tvALNVmQ==
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
Subject: [RFC PATCH v1 9/9] uaccess: Convert small fixed size copy_{to/from}_user() to scoped user access
Date: Mon, 27 Apr 2026 19:13:50 +0200
Message-ID: <8780eb2ef80575931a339e5225bc80eb13e9be6c.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638; i=chleroy@kernel.org; h=from:subject:message-id; bh=xblTv37x9V4gU3cvmA9ILfz6xXNOv0sNe2zU9C6a5nw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxlr/n9yu2DE7uwkCZGbl0uCp6Y1JLvZTPpz+P/PY xNqPMoaOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE9HwZ/ns82Ho9PV2Q+7Pp 5fqvs6O/v3YN+3EgL+Wk4b/co1rlkZ8YGVZxmDl7XFiUcmPSTPW14WGSHT6/1u4pcTY2cjD0U7P bzAkA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C1A6477849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_TO(0.00)[nvidia.com,linux-foundation.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-10147-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

copy_{to/from}_user() is a heavy function optimised for copy of large
blocs of memory between user and kernel space.

When the number of bytes to be copied is known at build time and small,
using scoped user access removes the burden of that optimisation.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 include/linux/uaccess.h | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 33b7d0f5f808..3ac544527af2 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -50,6 +50,8 @@
  #define mask_user_address(src) (src)
 #endif
 
+#define SMALL_COPY_USER		64
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
@@ -191,6 +193,9 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 	return res;
 }
 
+static __always_inline __must_check unsigned long
+_small_copy_from_user(void *to, const void __user *from, unsigned long n);
+
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
 
@@ -207,6 +212,9 @@ _inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return n;
 }
 
+static __always_inline __must_check unsigned long
+_small_copy_to_user(void __user *to, const void *from, unsigned long n);
+
 extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
 
@@ -215,6 +223,8 @@ copy_from_user_common(void *to, const void __user *from, unsigned long n, bool p
 {
 	if (!check_copy_size(to, n, false))
 		return n;
+	if (!partial && __builtin_constant_p(n) && n <= SMALL_COPY_USER)
+		return _small_copy_from_user(to, from, n);
 	if (IS_ENABLED(ARCH_WANTS_NOINLINE_COPY_USER))
 		return _copy_from_user(to, from, n);
 	else
@@ -239,6 +249,8 @@ copy_to_user_common(void __user *to, const void *from, unsigned long n, bool par
 	if (!check_copy_size(from, n, true))
 		return n;
 
+	if (!partial && __builtin_constant_p(n) && n <= SMALL_COPY_USER)
+		return _small_copy_to_user(to, from, n);
 	if (IS_ENABLED(ARCH_WANTS_NOINLINE_COPY_USER))
 		return _copy_to_user(to, from, n);
 	else
@@ -838,6 +850,41 @@ for (bool done = false; !done; done = true)					\
 #define scoped_user_rw_access(uptr, elbl)				\
 	scoped_user_rw_access_size(uptr, sizeof(*(uptr)), elbl)
 
+static __always_inline __must_check unsigned long
+_small_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	might_fault();
+	instrument_copy_from_user_before(to, from, n);
+	scoped_user_read_access_size(from, n, failed) {
+		/*
+		 * Ensure that bad access_ok() speculation will not lead
+		 * to nasty side effects *after* the copy is finished:
+		 */
+		if (!can_do_masked_user_access())
+			barrier_nospec();
+		unsafe_copy_from_user(to, from, n, failed);
+	}
+	instrument_copy_from_user_after(to, from, n, 0);
+	return 0;
+failed:
+	instrument_copy_from_user_after(to, from, n, n);
+	return n;
+}
+
+static __always_inline __must_check unsigned long
+_small_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	scoped_user_write_access_size(to, n, failed)
+		unsafe_copy_to_user(to, from, n, failed);
+	return 0;
+failed:
+	return n;
+}
+
 /**
  * get_user_inline - Read user data inlined
  * @val:	The variable to store the value read from user memory
-- 
2.49.0


