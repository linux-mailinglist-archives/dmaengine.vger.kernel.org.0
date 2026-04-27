Return-Path: <dmaengine+bounces-10143-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLvzG6Kc72kbDQEAu9opvQ
	(envelope-from <dmaengine+bounces-10143-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:28:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D770E4778CB
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BEA30E63B9
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A63E3C5B;
	Mon, 27 Apr 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVYqWJ9y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0C339714;
	Mon, 27 Apr 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310313; cv=none; b=kz1l/ngozsI96xXmZj6JdhkNwseDzgqerxTXCHsNjAg9NGRCe6Mu7W0EKXK67K2FdRvUXEULmOGYX4325KFDzMUKJ0521x6D1/g1RzTBJi6tqyFzjZ483MbRx7eMXfAUA7eSdWOsyiw6BpsKwWFvXyXEFv0O3WL/xcnlU7oU8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310313; c=relaxed/simple;
	bh=ykb2AFsFlD4OWf31v2pDwxXHhaD6RIAaFdGo66PLJJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSBj76P4hslpjmEe+0DTh7B7VJy6FPKr2F3CwXFTNv7FEgiJq6BvShoVgJeKdk1v7jcLGkpJYZoVd7+kl32Abi2MSKzQ1TBnSfnvxI2paqsXnCMvdUcmd0u7U7cv2p7iTjVrgb0aI/0pg9b+BmbiXEzHL+oHUqvrnzjWtgnri2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVYqWJ9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31802C2BCF4;
	Mon, 27 Apr 2026 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310312;
	bh=ykb2AFsFlD4OWf31v2pDwxXHhaD6RIAaFdGo66PLJJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVYqWJ9y3YbZh7SD1t9FZfVCwwasAh9H5TbUiJGW0WBLo8QeGfk22g4AfRfUPPWqU
	 Aoc8LlWA/aSMgy9dc9PmA3AGYLZUU5W7rwnOfj07vTIJFBwTSF9yiiM4DvkX1/MBQu
	 db67uJWBEaWIGjEVq27JeF6TjgL+v+lGhLnh5fqlRmMpg7nUlTADncH5wD5lENeOzx
	 AnSeuD99A4n/GOBDGHS6YE5DsSz3FUwz6A+06zvkQMMGJou23G/4wgzSuudbgGF0+O
	 Dmr1a73NapDMfoHC1BZSTwINTaDSDCQgyzzeSi4wB6M2kWQzSVBg/2nN/ihP2WWDMt
	 aSuTg8ZLqpxJg==
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
Subject: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial() when relevant
Date: Mon, 27 Apr 2026 19:13:46 +0200
Message-ID: <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=54038; i=chleroy@kernel.org; h=from:subject:message-id; bh=ykb2AFsFlD4OWf31v2pDwxXHhaD6RIAaFdGo66PLJJQ=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxnT8I410Uhy0qp/RVcua12akXn97Jr7B907GK1ex fMIJG+93FHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAmYtrO8D+j/Q7HhgvHVxxp 95Tc/nBGsdAKdauVyxVmaezQe2149M4LRoa79udnSurd+iisF/Rta6/v3KKjtnV8bRpT1XZWfDZ UYGEHAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D770E4778CB
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
	TAGGED_FROM(0.00)[bounces-10143-lists,dmaengine=lfdr.de];
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

In a subsequent patch, copy_{to/from}_user() will be modified to
return -EFAULT when copy fails.

Among the 6000 calls to copy_{to/from}_user(), around 2% rely on
copy_{to/from}_user() doing partial copies and returning amount of not
copied bytes. Change those users to copy_{to/from}_user_partial().

This change was done based on whether callers assign the returned value
to a variable or just check whether the return value is 0 or not.

Several of them only use it for debug to print the amount of bytes not
copied. Those could maybe be changed to stop reporting that amount and
not be converted to partial copy.

Some not trivial handling might have been unecessarily converted. This
is not a problem and they can be converted back later for better
performance.

The callers where located with following commands then reviewed one by
one:

	sed -i s/"return copy_to_user("/"return copy_to_user_partial("/g `git grep -l "return copy_to_user("`
	sed -i s/" = copy_to_user("/" = copy_to_user_partial("/g `git grep -l " = copy_to_user("`
	sed -i s/" += copy_to_user("/" += copy_to_user_partial("/g `git grep -l " += copy_to_user("`
	sed -i s/" -= copy_to_user("/" -= copy_to_user_partial("/g `git grep -l " -= copy_to_user("`

Then the same was done with copy_from_user().

During the review, patterns like the following were rejected and kept
as is:

-	return copy_to_user(osf_stat, &tmp, sizeof(tmp)) ? -EFAULT : 0;
+	return copy_to_user_partial(osf_stat, &tmp, sizeof(tmp)) ? -EFAULT : 0;

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/alpha/kernel/osf_sys.c                    |  4 ++--
 arch/alpha/kernel/termios.c                    |  2 +-
 arch/arc/kernel/disasm.c                       |  2 +-
 arch/arm64/include/asm/gcs.h                   |  2 +-
 arch/arm64/kernel/signal32.c                   |  2 +-
 arch/mips/kernel/rtlx.c                        |  8 ++++----
 arch/mips/kernel/vpe.c                         |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c            |  4 ++--
 arch/powerpc/kvm/book3s_64_mmu_radix.c         |  4 ++--
 arch/powerpc/kvm/book3s_hv.c                   |  2 +-
 arch/riscv/kernel/signal.c                     |  2 +-
 arch/s390/include/asm/idals.h                  |  8 ++++----
 arch/sparc/kernel/termios.c                    |  2 +-
 arch/um/kernel/process.c                       |  2 +-
 arch/x86/lib/insn-eval.c                       |  2 +-
 arch/x86/um/signal.c                           |  2 +-
 drivers/android/binder_alloc.c                 |  2 +-
 drivers/comedi/comedi_fops.c                   |  4 ++--
 drivers/dma/idxd/cdev.c                        |  2 +-
 drivers/firmware/efi/test/efi_test.c           |  2 +-
 drivers/fsi/fsi-scom.c                         |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  2 +-
 drivers/gpu/drm/i915/gt/intel_sseu.c           |  4 ++--
 drivers/gpu/drm/i915/i915_gem.c                |  4 ++--
 drivers/hwtracing/intel_th/msu.c               |  2 +-
 drivers/misc/ibmvmc.c                          |  2 +-
 drivers/misc/vmw_vmci/vmci_host.c              |  2 +-
 drivers/most/most_cdev.c                       |  2 +-
 drivers/net/ieee802154/ca8210.c                |  4 ++--
 drivers/net/wireless/ath/wil6210/debugfs.c     |  2 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  2 +-
 drivers/net/wireless/ti/wlcore/debugfs.c       |  2 +-
 drivers/ps3/ps3-lpm.c                          |  2 +-
 drivers/s390/crypto/zcrypt_api.h               |  4 ++--
 drivers/spi/spidev.c                           |  2 +-
 .../staging/media/atomisp/pci/atomisp_cmd.c    |  8 ++++----
 drivers/tty/tty_ioctl.c                        | 14 +++++++-------
 drivers/tty/vt/vc_screen.c                     |  4 ++--
 drivers/usb/gadget/function/f_hid.c            |  4 ++--
 drivers/usb/gadget/function/f_printer.c        |  2 +-
 drivers/vfio/vfio_iommu_type1.c                |  4 ++--
 drivers/xen/xenbus/xenbus_dev_frontend.c       |  2 +-
 fs/namespace.c                                 |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c                         |  2 +-
 fs/proc/base.c                                 |  4 ++--
 include/linux/bpfptr.h                         |  2 +-
 include/linux/sockptr.h                        |  4 ++--
 ipc/msg.c                                      |  8 ++++----
 ipc/sem.c                                      |  8 ++++----
 ipc/shm.c                                      | 18 +++++++++---------
 kernel/regset.c                                |  2 +-
 kernel/sys.c                                   |  4 ++--
 lib/kfifo.c                                    |  8 ++++----
 mm/kasan/kasan_test_c.c                        |  4 ++--
 mm/memory.c                                    |  2 +-
 net/x25/af_x25.c                               |  2 +-
 rust/helpers/uaccess.c                         |  4 ++--
 sound/pci/emu10k1/emufx.c                      |  4 ++--
 sound/pci/rme9652/hdsp.c                       |  6 +++---
 sound/soc/intel/avs/probes.c                   |  6 +++---
 sound/soc/sof/compress.c                       | 12 ++++++------
 sound/soc/sof/sof-client-probes.c              |  6 +++---
 62 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 7b6543d2cca3..c8ea39fdbb9f 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -944,7 +944,7 @@ get_tv32(struct timespec64 *o, struct timeval32 __user *i)
 static inline long
 put_tv32(struct timeval32 __user *o, struct timespec64 *i)
 {
-	return copy_to_user(o, &(struct timeval32){
+	return copy_to_user_partial(o, &(struct timeval32){
 				.tv_sec = i->tv_sec,
 				.tv_usec = i->tv_nsec / NSEC_PER_USEC},
 			    sizeof(struct timeval32));
@@ -953,7 +953,7 @@ put_tv32(struct timeval32 __user *o, struct timespec64 *i)
 static inline long
 put_tv_to_tv32(struct timeval32 __user *o, struct __kernel_old_timeval *i)
 {
-	return copy_to_user(o, &(struct timeval32){
+	return copy_to_user_partial(o, &(struct timeval32){
 				.tv_sec = i->tv_sec,
 				.tv_usec = i->tv_usec},
 			    sizeof(struct timeval32));
diff --git a/arch/alpha/kernel/termios.c b/arch/alpha/kernel/termios.c
index a4c29a22edf7..a3693c29a0fd 100644
--- a/arch/alpha/kernel/termios.c
+++ b/arch/alpha/kernel/termios.c
@@ -52,5 +52,5 @@ int kernel_termios_to_user_termio(struct termio __user *termio,
 	v.c_cc[_VEOL2]  = termios->c_cc[VEOL2];
 	v.c_cc[_VSWTC]  = termios->c_cc[VSWTC];
 
-	return copy_to_user(termio, &v, sizeof(struct termio));
+	return copy_to_user_partial(termio, &v, sizeof(struct termio));
 }
diff --git a/arch/arc/kernel/disasm.c b/arch/arc/kernel/disasm.c
index ccc7e8c39eb3..a3ef9d079e7f 100644
--- a/arch/arc/kernel/disasm.c
+++ b/arch/arc/kernel/disasm.c
@@ -34,7 +34,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 	/* This fetches the upper part of the 32 bit instruction
 	 * in both the cases of Little Endian or Big Endian configurations. */
 	if (userspace) {
-		bytes_not_copied = copy_from_user(ins_buf,
+		bytes_not_copied = copy_from_user_partial(ins_buf,
 						(const void __user *) addr, 8);
 		if (bytes_not_copied > 6)
 			goto fault;
diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 8fa0707069e8..7ee23a8130b0 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -139,7 +139,7 @@ static inline u64 get_user_gcs(unsigned long __user *addr, int *err)
 
 	/* Ensure previous GCS operation are visible before we read the page */
 	gcsb_dsync();
-	ret = copy_from_user(&load, addr, sizeof(load));
+	ret = copy_from_user_partial(&load, addr, sizeof(load));
 	if (ret != 0)
 		*err = ret;
 	return load;
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index bb3b526ff43f..7016d2a3bb76 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -53,7 +53,7 @@ static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
 	cset.sig[0] = set->sig[0] & 0xffffffffull;
 	cset.sig[1] = set->sig[0] >> 32;
 
-	return copy_to_user(uset, &cset, sizeof(*uset));
+	return copy_to_user_partial(uset, &cset, sizeof(*uset));
 }
 
 static inline int get_sigset_t(sigset_t *set,
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 18c509c59f33..bc468064194d 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -262,13 +262,13 @@ ssize_t rtlx_read(int index, void __user *buff, size_t count)
 	/* then how much from the read pointer onwards */
 	fl = min(count, (size_t)lx->buffer_size - lx->lx_read);
 
-	failed = copy_to_user(buff, lx->lx_buffer + lx->lx_read, fl);
+	failed = copy_to_user_partial(buff, lx->lx_buffer + lx->lx_read, fl);
 	if (failed)
 		goto out;
 
 	/* and if there is anything left at the beginning of the buffer */
 	if (count - fl)
-		failed = copy_to_user(buff + fl, lx->lx_buffer, count - fl);
+		failed = copy_to_user_partial(buff + fl, lx->lx_buffer, count - fl);
 
 out:
 	count -= failed;
@@ -304,13 +304,13 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 	/* first bit from write pointer to the end of the buffer, or count */
 	fl = min(count, (size_t) rt->buffer_size - rt->rt_write);
 
-	failed = copy_from_user(rt->rt_buffer + rt->rt_write, buffer, fl);
+	failed = copy_from_user_partial(rt->rt_buffer + rt->rt_write, buffer, fl);
 	if (failed)
 		goto out;
 
 	/* if there's any left copy to the beginning of the buffer */
 	if (count - fl)
-		failed = copy_from_user(rt->rt_buffer, buffer + fl, count - fl);
+		failed = copy_from_user_partial(rt->rt_buffer, buffer + fl, count - fl);
 
 out:
 	count -= failed;
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index b05ee21a1d67..5a8d72d6c80c 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -854,7 +854,7 @@ static ssize_t vpe_write(struct file *file, const char __user *buffer,
 		return -ENOMEM;
 	}
 
-	count -= copy_from_user(v->pbuffer + v->len, buffer, count);
+	count -= copy_from_user_partial(v->pbuffer + v->len, buffer, count);
 	if (!count)
 		return -EFAULT;
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ccb3d138f46..1c43c7b8e801 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -2028,7 +2028,7 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 		n = p->chars_left;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf + p->buf_index, n);
+		r = copy_to_user_partial(buf, p->buf + p->buf_index, n);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index += n;
@@ -2068,7 +2068,7 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 		p->chars_left = n;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf, n);
+		r = copy_to_user_partial(buf, p->buf, n);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index = n;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 933fc7cb9afc..0a27e018d27b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -1307,7 +1307,7 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 		n = p->chars_left;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf + p->buf_index, n);
+		r = copy_to_user_partial(buf, p->buf + p->buf_index, n);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index += n;
@@ -1407,7 +1407,7 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 		p->chars_left = n;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf, n);
+		r = copy_to_user_partial(buf, p->buf, n);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index = n;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..4c7a8f687c99 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2916,7 +2916,7 @@ static ssize_t debugfs_timings_read(struct file *file, char __user *buf,
 		return 0;
 	if (len > p->buflen - pos)
 		len = p->buflen - pos;
-	n = copy_to_user(buf, p->buf + pos, len);
+	n = copy_to_user_partial(buf, p->buf + pos, len);
 	if (n) {
 		if (n == len)
 			return -EFAULT;
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 59784dc117e4..4630dbad7428 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -139,7 +139,7 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	 * Copy the whole vector content from user space datap. Use
 	 * copy_from_user to prevent information leak.
 	 */
-	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
+	return copy_from_user_partial(current->thread.vstate.datap, datap, riscv_v_vsize);
 }
 
 static long save_cfiss_state(struct pt_regs *regs, void __user *sc_cfi)
diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
index 06e1ec2afd5a..d86f4eb1ce42 100644
--- a/arch/s390/include/asm/idals.h
+++ b/arch/s390/include/asm/idals.h
@@ -301,14 +301,14 @@ static inline size_t idal_buffer_to_user(struct idal_buffer *ib, void __user *to
 	BUG_ON(count > ib->size);
 	for (i = 0; count > IDA_BLOCK_SIZE; i++) {
 		vaddr = dma64_to_virt(ib->data[i]);
-		left = copy_to_user(to, vaddr, IDA_BLOCK_SIZE);
+		left = copy_to_user_partial(to, vaddr, IDA_BLOCK_SIZE);
 		if (left)
 			return left + count - IDA_BLOCK_SIZE;
 		to = (void __user *)to + IDA_BLOCK_SIZE;
 		count -= IDA_BLOCK_SIZE;
 	}
 	vaddr = dma64_to_virt(ib->data[i]);
-	return copy_to_user(to, vaddr, count);
+	return copy_to_user_partial(to, vaddr, count);
 }
 
 /*
@@ -323,14 +323,14 @@ static inline size_t idal_buffer_from_user(struct idal_buffer *ib, const void __
 	BUG_ON(count > ib->size);
 	for (i = 0; count > IDA_BLOCK_SIZE; i++) {
 		vaddr = dma64_to_virt(ib->data[i]);
-		left = copy_from_user(vaddr, from, IDA_BLOCK_SIZE);
+		left = copy_from_user_partial(vaddr, from, IDA_BLOCK_SIZE);
 		if (left)
 			return left + count - IDA_BLOCK_SIZE;
 		from = (void __user *)from + IDA_BLOCK_SIZE;
 		count -= IDA_BLOCK_SIZE;
 	}
 	vaddr = dma64_to_virt(ib->data[i]);
-	return copy_from_user(vaddr, from, count);
+	return copy_from_user_partial(vaddr, from, count);
 }
 
 #endif
diff --git a/arch/sparc/kernel/termios.c b/arch/sparc/kernel/termios.c
index ee64965c27cd..db9c07b7d5ee 100644
--- a/arch/sparc/kernel/termios.c
+++ b/arch/sparc/kernel/termios.c
@@ -27,7 +27,7 @@ int kernel_termios_to_user_termio(struct termio __user *termio,
 		v.c_cc[_VMIN] = termios->c_cc[VMIN];
 		v.c_cc[_VTIME] = termios->c_cc[VTIME];
 	}
-	return copy_to_user(termio, &v, sizeof(struct termio));
+	return copy_to_user_partial(termio, &v, sizeof(struct termio));
 }
 
 int user_termios_to_kernel_termios(struct ktermios *k,
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 63b38a3f73f7..d41625dfa00b 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -252,7 +252,7 @@ EXPORT_SYMBOL(uml_strdup);
 
 int copy_from_user_proc(void *to, void __user *from, int size)
 {
-	return copy_from_user(to, from, size);
+	return copy_from_user_partial(to, from, size);
 }
 
 int singlestepping(void)
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index e03eeec55cfe..e7cb03ab26f1 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1512,7 +1512,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 	if (insn_get_effective_ip(regs, &ip))
 		return -EINVAL;
 
-	not_copied = copy_from_user(buf, (void __user *)ip, MAX_INSN_SIZE);
+	not_copied = copy_from_user_partial(buf, (void __user *)ip, MAX_INSN_SIZE);
 
 	return MAX_INSN_SIZE - not_copied;
 }
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 2934e170b0fe..e0fab7c1625b 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -40,7 +40,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	err = copy_from_user(&sc, from, sizeof(sc));
+	err = copy_from_user_partial(&sc, from, sizeof(sc));
 	if (err)
 		return err;
 
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e4488ad86a65..8ba9c57b489c 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1346,7 +1346,7 @@ binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
 					     buffer_offset, &pgoff);
 		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
 		kptr = kmap_local_page(page) + pgoff;
-		ret = copy_from_user(kptr, from, size);
+		ret = copy_from_user_partial(kptr, from, size);
 		kunmap_local(kptr);
 		if (ret)
 			return bytes - size + ret;
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index c09bbe04be6c..272fdc54fb81 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -2659,7 +2659,7 @@ static unsigned int comedi_buf_copy_to_user(struct comedi_subdevice *s,
 		unsigned int copy_amount = min(n, PAGE_SIZE - offset);
 		unsigned int uncopied;
 
-		uncopied = copy_to_user(dest, buf_page_list[page].virt_addr +
+		uncopied = copy_to_user_partial(dest, buf_page_list[page].virt_addr +
 					offset, copy_amount);
 		copy_amount -= uncopied;
 		n -= copy_amount;
@@ -2687,7 +2687,7 @@ static unsigned int comedi_buf_copy_from_user(struct comedi_subdevice *s,
 		unsigned int copy_amount = min(n, PAGE_SIZE - offset);
 		unsigned int uncopied;
 
-		uncopied = copy_from_user(buf_page_list[page].virt_addr +
+		uncopied = copy_from_user_partial(buf_page_list[page].virt_addr +
 					  offset, src, copy_amount);
 		copy_amount -= uncopied;
 		n -= copy_amount;
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0366c7cf3502..ac79bab6d6c3 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -751,7 +751,7 @@ int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
 	 * to addr in the mm.
 	 */
 	kthread_use_mm(mm);
-	left = copy_to_user((void __user *)addr + status_size, cr + status_size,
+	left = copy_to_user_partial((void __user *)addr + status_size, cr + status_size,
 			    len - status_size);
 	/*
 	 * Copy status only after the rest of completion record is copied
diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index d54d6a671326..43b280ceb955 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -133,7 +133,7 @@ copy_ucs2_to_user_len(efi_char16_t __user *dst, efi_char16_t *src, size_t len)
 	if (!src)
 		return 0;
 
-	return copy_to_user(dst, src, len);
+	return copy_to_user_partial(dst, src, len);
 }
 
 static long efi_runtime_get_variable(unsigned long arg)
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index bb4d3700c934..370ec75b20e6 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -332,7 +332,7 @@ static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
 		return rc;
 	}
 
-	rc = copy_to_user(buf, &val, len);
+	rc = copy_to_user_partial(buf, &val, len);
 	if (rc)
 		dev_dbg(dev, "copy to user failed:%d\n", rc);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 2409ac72b166..712605ec7ecc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1346,7 +1346,7 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
 
 	acrtc_state = to_dm_crtc_state(connector->base.state->crtc->state);
 
-	r = copy_from_user(data, buf, write_size);
+	r = copy_from_user_partial(data, buf, write_size);
 
 	write_size -= r;
 
diff --git a/drivers/gpu/drm/i915/gt/intel_sseu.c b/drivers/gpu/drm/i915/gt/intel_sseu.c
index 656a499b2706..3f5b450a914a 100644
--- a/drivers/gpu/drm/i915/gt/intel_sseu.c
+++ b/drivers/gpu/drm/i915/gt/intel_sseu.c
@@ -114,7 +114,7 @@ int intel_sseu_copy_eumask_to_user(void __user *to,
 		}
 	}
 
-	return copy_to_user(to, eu_mask, len);
+	return copy_to_user_partial(to, eu_mask, len);
 }
 
 /**
@@ -146,7 +146,7 @@ int intel_sseu_copy_ssmask_to_user(void __user *to,
 		}
 	}
 
-	return copy_to_user(to, ss_mask, len);
+	return copy_to_user_partial(to, ss_mask, len);
 }
 
 static void gen11_compute_sseu_info(struct sseu_dev_info *sseu,
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index a432daf8038a..c1c2e762498f 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -291,7 +291,7 @@ gtt_user_read(struct io_mapping *mapping,
 	io_mapping_unmap_atomic(vaddr);
 	if (unwritten) {
 		vaddr = io_mapping_map_wc(mapping, base, PAGE_SIZE);
-		unwritten = copy_to_user(user_data,
+		unwritten = copy_to_user_partial(user_data,
 					 (void __force *)vaddr + offset,
 					 length);
 		io_mapping_unmap(vaddr);
@@ -525,7 +525,7 @@ ggtt_write(struct io_mapping *mapping,
 	io_mapping_unmap_atomic(vaddr);
 	if (unwritten) {
 		vaddr = io_mapping_map_wc(mapping, base, PAGE_SIZE);
-		unwritten = copy_from_user((void __force *)vaddr + offset,
+		unwritten = copy_from_user_partial((void __force *)vaddr + offset,
 					   user_data, length);
 		io_mapping_unmap(vaddr);
 	}
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index a82cf74f39ad..9b97b71b44f1 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1457,7 +1457,7 @@ static unsigned long msc_win_to_user(void *data, void *src, size_t len)
 	struct msc_win_to_user_struct *u = data;
 	unsigned long ret;
 
-	ret = copy_to_user(u->buf + u->offset, src, len);
+	ret = copy_to_user_partial(u->buf + u->offset, src, len);
 	u->offset += len - ret;
 
 	return ret;
diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index beb18c34f20d..e1d99354dd29 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -1112,7 +1112,7 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 	while (c > 0) {
 		bytes = min_t(size_t, c, vmc_buffer->size);
 
-		bytes -= copy_from_user(buf, p, bytes);
+		bytes -= copy_from_user_partial(buf, p, bytes);
 		if (!bytes) {
 			ret = -EFAULT;
 			goto out;
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index b71ca1bf0a20..bd502edbc173 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -213,7 +213,7 @@ static int drv_cp_harray_to_user(void __user *user_buf_uva,
 
 	*user_buf_size = array_size * sizeof(*handles);
 	if (*user_buf_size)
-		*retval = copy_to_user(user_buf_uva,
+		*retval = copy_to_user_partial(user_buf_uva,
 				       vmci_handle_arr_get_handles
 				       (handle_array), *user_buf_size);
 
diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 5df508d8d60a..969c865ccbef 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -265,7 +265,7 @@ comp_read(struct file *filp, char __user *buf, size_t count, loff_t *offset)
 			count,
 			mbo->processed_length - c->mbo_offs);
 
-	not_copied = copy_to_user(buf,
+	not_copied = copy_to_user_partial(buf,
 				  mbo->virt_address + c->mbo_offs,
 				  to_copy);
 
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index ed4178155a5d..d474a008c73e 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2460,7 +2460,7 @@ static ssize_t ca8210_test_int_user_write(
 		return -EBADE;
 	}
 
-	ret = copy_from_user(command, in_buf, len);
+	ret = copy_from_user_partial(command, in_buf, len);
 	if (ret) {
 		dev_err(
 			&priv->spi->dev,
@@ -2548,7 +2548,7 @@ static ssize_t ca8210_test_int_user_read(
 	cmdlen = fifo_buffer[1];
 	bytes_not_copied = cmdlen + 2;
 
-	bytes_not_copied = copy_to_user(buf, fifo_buffer, bytes_not_copied);
+	bytes_not_copied = copy_to_user_partial(buf, fifo_buffer, bytes_not_copied);
 	if (bytes_not_copied > 0) {
 		dev_err(
 			&priv->spi->dev,
diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index b8cb736a7185..f2130248fb7f 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -659,7 +659,7 @@ static ssize_t wil_read_file_ioblob(struct file *file, char __user *user_buf,
 	wil_memcpy_fromio_32(buf, (const void __iomem *)
 			     wil_blob->blob.data + aligned_pos, aligned_count);
 
-	ret = copy_to_user(user_buf, buf + unaligned_bytes, count);
+	ret = copy_to_user_partial(user_buf, buf + unaligned_bytes, count);
 
 	wil_mem_access_unlock(wil);
 	wil_pm_runtime_put(wil);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index a05f60f9224b..66ddaa0d8e36 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3060,7 +3060,7 @@ static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
 	if (*size > buf_size_left)
 		*size = buf_size_left;
 
-	*size -= copy_to_user(user_buf, buf, *size);
+	*size -= copy_to_user_partial(user_buf, buf, *size);
 	*bytes_copied += *size;
 
 	if (buf_size_left == *size)
diff --git a/drivers/net/wireless/ti/wlcore/debugfs.c b/drivers/net/wireless/ti/wlcore/debugfs.c
index bbfd2725215b..d359baea5100 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.c
+++ b/drivers/net/wireless/ti/wlcore/debugfs.c
@@ -1088,7 +1088,7 @@ static ssize_t dev_mem_read(struct file *file,
 	mutex_unlock(&wl->mutex);
 
 	if (ret == 0) {
-		ret = copy_to_user(user_buf, buf, bytes);
+		ret = copy_to_user_partial(user_buf, buf, bytes);
 		if (ret < bytes) {
 			bytes -= ret;
 			*ppos += bytes;
diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index f8d8f607134a..5a2b150cda49 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -999,7 +999,7 @@ int ps3_lpm_copy_tb_to_user(unsigned long offset, void __user *buf,
 			return result == LV1_WRONG_STATE ? -EBUSY : -EINVAL;
 		}
 
-		result = copy_to_user(buf, lpm_priv->tb_cache, tmp);
+		result = copy_to_user_partial(buf, lpm_priv->tb_cache, tmp);
 
 		if (result) {
 			dev_dbg(sbd_core(), "%s:%u: 0x%llx bytes at 0x%p\n",
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 6ef8850a42df..61a5de90c354 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -185,7 +185,7 @@ static inline unsigned long z_copy_from_user(bool userspace,
 					     unsigned long n)
 {
 	if (likely(userspace))
-		return copy_from_user(to, from, n);
+		return copy_from_user_partial(to, from, n);
 	memcpy(to, (void __force *)from, n);
 	return 0;
 }
@@ -196,7 +196,7 @@ static inline unsigned long z_copy_to_user(bool userspace,
 					   unsigned long n)
 {
 	if (likely(userspace))
-		return copy_to_user(to, from, n);
+		return copy_to_user_partial(to, from, n);
 	memcpy((void __force *)to, from, n);
 	return 0;
 }
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 638221178384..5b42fabcf4c4 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -157,7 +157,7 @@ spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 	if (status > 0) {
 		unsigned long	missing;
 
-		missing = copy_to_user(buf, spidev->rx_buffer, status);
+		missing = copy_to_user_partial(buf, spidev->rx_buffer, status);
 		if (missing == status)
 			status = -EFAULT;
 		else
diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index fec369575d88..10a7aff375a9 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -1491,7 +1491,7 @@ int atomisp_gdc_cac_table(struct atomisp_sub_device *asd, int flag,
 		}
 
 		for (i = 0; i < IA_CSS_MORPH_TABLE_NUM_PLANES; i++) {
-			ret = copy_from_user(tab->coordinates_x[i],
+			ret = copy_from_user_partial(tab->coordinates_x[i],
 					     config->coordinates_x[i],
 					     config->height * config->width *
 					     sizeof(*config->coordinates_x[i]));
@@ -1502,7 +1502,7 @@ int atomisp_gdc_cac_table(struct atomisp_sub_device *asd, int flag,
 				atomisp_css_morph_table_free(tab);
 				return -EFAULT;
 			}
-			ret = copy_from_user(tab->coordinates_y[i],
+			ret = copy_from_user_partial(tab->coordinates_y[i],
 					     config->coordinates_y[i],
 					     config->height * config->width *
 					     sizeof(*config->coordinates_y[i]));
@@ -1709,7 +1709,7 @@ int atomisp_3a_stat(struct atomisp_sub_device *asd, int flag,
 	config->exp_id = s3a_buf->s3a_data->exp_id;
 	config->isp_config_id = s3a_buf->s3a_data->isp_config_id;
 
-	ret = copy_to_user(config->data, asd->params.s3a_user_stat->data,
+	ret = copy_to_user_partial(config->data, asd->params.s3a_user_stat->data,
 			   asd->params.s3a_output_bytes);
 	if (ret) {
 		dev_err(isp->dev, "copy to user failed: copied %lu bytes\n",
@@ -2031,7 +2031,7 @@ static unsigned int long copy_from_compatible(void *to, const void *from,
 	unsigned long n, bool from_user)
 {
 	if (from_user)
-		return copy_from_user(to, (void __user *)from, n);
+		return copy_from_user_partial(to, (void __user *)from, n);
 	else
 		memcpy(to, from, n);
 	return 0;
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 90c70d8d14e3..cdc274c0ff81 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -388,29 +388,29 @@ __weak int kernel_termios_to_user_termio(struct termio __user *termio,
 	v.c_lflag = termios->c_lflag;
 	v.c_line = termios->c_line;
 	memcpy(v.c_cc, termios->c_cc, NCC);
-	return copy_to_user(termio, &v, sizeof(struct termio));
+	return copy_to_user_partial(termio, &v, sizeof(struct termio));
 }
 
 #ifdef TCGETS2
 __weak int user_termios_to_kernel_termios(struct ktermios *k,
 						 struct termios2 __user *u)
 {
-	return copy_from_user(k, u, sizeof(struct termios2));
+	return copy_from_user_partial(k, u, sizeof(struct termios2));
 }
 __weak int kernel_termios_to_user_termios(struct termios2 __user *u,
 						 struct ktermios *k)
 {
-	return copy_to_user(u, k, sizeof(struct termios2));
+	return copy_to_user_partial(u, k, sizeof(struct termios2));
 }
 __weak int user_termios_to_kernel_termios_1(struct ktermios *k,
 						   struct termios __user *u)
 {
-	return copy_from_user(k, u, sizeof(struct termios));
+	return copy_from_user_partial(k, u, sizeof(struct termios));
 }
 __weak int kernel_termios_to_user_termios_1(struct termios __user *u,
 						   struct ktermios *k)
 {
-	return copy_to_user(u, k, sizeof(struct termios));
+	return copy_to_user_partial(u, k, sizeof(struct termios));
 }
 
 #else
@@ -418,12 +418,12 @@ __weak int kernel_termios_to_user_termios_1(struct termios __user *u,
 __weak int user_termios_to_kernel_termios(struct ktermios *k,
 						 struct termios __user *u)
 {
-	return copy_from_user(k, u, sizeof(struct termios));
+	return copy_from_user_partial(k, u, sizeof(struct termios));
 }
 __weak int kernel_termios_to_user_termios(struct termios __user *u,
 						 struct ktermios *k)
 {
-	return copy_to_user(u, k, sizeof(struct termios));
+	return copy_to_user_partial(u, k, sizeof(struct termios));
 }
 #endif /* TCGETS2 */
 
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 4d2d46c95fef..e54c708149c3 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -450,7 +450,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 */
 
 		console_unlock();
-		ret = copy_to_user(buf, con_buf + skip, this_round);
+		ret = copy_to_user_partial(buf, con_buf + skip, this_round);
 		console_lock();
 
 		if (ret) {
@@ -630,7 +630,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		 * in the write data from userspace safely.
 		 */
 		console_unlock();
-		ret = copy_from_user(con_buf, buf, this_round);
+		ret = copy_from_user_partial(con_buf, buf, this_round);
 		console_lock();
 
 		if (ret) {
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index c5a12a6760ea..f22dd3697a46 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -349,7 +349,7 @@ static ssize_t f_hidg_intout_read(struct file *file, char __user *buffer,
 	spin_unlock_irqrestore(&hidg->read_spinlock, flags);
 
 	/* copy to user outside spinlock */
-	count -= copy_to_user(buffer, req->buf + list->pos, count);
+	count -= copy_to_user_partial(buffer, req->buf + list->pos, count);
 	list->pos += count;
 
 	/*
@@ -410,7 +410,7 @@ static ssize_t f_hidg_ssreport_read(struct file *file, char __user *buffer,
 	spin_unlock_irqrestore(&hidg->read_spinlock, flags);
 
 	if (tmp_buf != NULL) {
-		count -= copy_to_user(buffer, tmp_buf, count);
+		count -= copy_to_user_partial(buffer, tmp_buf, count);
 		kfree(tmp_buf);
 	} else {
 		count = -ENOMEM;
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index e4f7828ae75d..4fbed987b639 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -525,7 +525,7 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		else
 			size = len;
 
-		size -= copy_to_user(buf, current_rx_buf, size);
+		size -= copy_to_user_partial(buf, current_rx_buf, size);
 		bytes_copied += size;
 		len -= size;
 		buf += size;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..ad74a891aa80 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3173,7 +3173,7 @@ static int vfio_iommu_type1_dma_rw_chunk(struct vfio_iommu *iommu,
 	vaddr = dma->vaddr + offset;
 
 	if (write) {
-		*copied = copy_to_user((void __user *)vaddr, data,
+		*copied = copy_to_user_partial((void __user *)vaddr, data,
 					 count) ? 0 : count;
 		if (*copied && iommu->dirty_page_tracking) {
 			unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
@@ -3186,7 +3186,7 @@ static int vfio_iommu_type1_dma_rw_chunk(struct vfio_iommu *iommu,
 				   (offset >> pgshift) + 1);
 		}
 	} else
-		*copied = copy_from_user(data, (void __user *)vaddr,
+		*copied = copy_from_user_partial(data, (void __user *)vaddr,
 					   count) ? 0 : count;
 	if (kthread)
 		kthread_unuse_mm(mm);
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 61db6932a9d2..b1db90dac1d1 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -150,7 +150,7 @@ static ssize_t xenbus_file_read(struct file *filp,
 	while (i < len) {
 		size_t sz = min_t(size_t, len - i, rb->len - rb->cons);
 
-		ret = copy_to_user(ubuf + i, &rb->msg[rb->cons], sz);
+		ret = copy_to_user_partial(ubuf + i, &rb->msg[rb->cons], sz);
 
 		i += sz - ret;
 		rb->cons += sz - ret;
diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..27afb73fef20 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4033,7 +4033,7 @@ static void *copy_mount_options(const void __user * data)
 	if (!copy)
 		return ERR_PTR(-ENOMEM);
 
-	left = copy_from_user(copy, data, PAGE_SIZE);
+	left = copy_from_user_partial(copy, data, PAGE_SIZE);
 
 	/*
 	 * Not all architectures have an exact copy_from_user(). Resort to
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5821e33df78f..97c0b391b98e 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -255,7 +255,7 @@ static ssize_t dlmfs_file_write(struct file *filp,
 	if (!count)
 		return 0;
 
-	bytes_left = copy_from_user(lvb_buf, buf, count);
+	bytes_left = copy_from_user_partial(lvb_buf, buf, count);
 	count -= bytes_left;
 	if (count)
 		user_dlm_write_lvb(inode, lvb_buf, count);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..49577662ae70 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -278,7 +278,7 @@ static ssize_t get_mm_proctitle(struct mm_struct *mm, char __user *buf,
 			len -= pos;
 			if (len > count)
 				len = count;
-			len -= copy_to_user(buf, page+pos, len);
+			len -= copy_to_user_partial(buf, page+pos, len);
 			if (!len)
 				len = -EFAULT;
 			ret = len;
@@ -359,7 +359,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 		got = access_remote_vm(mm, pos, page, size, FOLL_ANON);
 		if (got <= 0)
 			break;
-		got -= copy_to_user(buf, page, got);
+		got -= copy_to_user_partial(buf, page, got);
 		if (unlikely(!got)) {
 			if (!len)
 				len = -EFAULT;
diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
index f6e0795db484..e4444d0f0cfe 100644
--- a/include/linux/bpfptr.h
+++ b/include/linux/bpfptr.h
@@ -50,7 +50,7 @@ static inline int copy_from_bpfptr_offset(void *dst, bpfptr_t src,
 					  size_t offset, size_t size)
 {
 	if (!bpfptr_is_kernel(src))
-		return copy_from_user(dst, src.user + offset, size);
+		return copy_from_user_partial(dst, src.user + offset, size);
 	return copy_from_kernel_nofault(dst, src.kernel + offset, size);
 }
 
diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 3e6c8e9d67ae..52ddddfe728d 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -45,7 +45,7 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
 		size_t offset, size_t size)
 {
 	if (!sockptr_is_kernel(src))
-		return copy_from_user(dst, src.user + offset, size);
+		return copy_from_user_partial(dst, src.user + offset, size);
 	memcpy(dst, src.kernel + offset, size);
 	return 0;
 }
@@ -111,7 +111,7 @@ static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
 		const void *src, size_t size)
 {
 	if (!sockptr_is_kernel(dst))
-		return copy_to_user(dst.user + offset, src, size);
+		return copy_to_user_partial(dst.user + offset, src, size);
 	memcpy(dst.kernel + offset, src, size);
 	return 0;
 }
diff --git a/ipc/msg.c b/ipc/msg.c
index 62996b97f0ac..39848238219d 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -322,7 +322,7 @@ copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
 {
 	switch (version) {
 	case IPC_64:
-		return copy_to_user(buf, in, sizeof(*in));
+		return copy_to_user_partial(buf, in, sizeof(*in));
 	case IPC_OLD:
 	{
 		struct msqid_ds out;
@@ -355,7 +355,7 @@ copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
 		out.msg_lspid		= in->msg_lspid;
 		out.msg_lrpid		= in->msg_lrpid;
 
-		return copy_to_user(buf, &out, sizeof(out));
+		return copy_to_user_partial(buf, &out, sizeof(out));
 	}
 	default:
 		return -EINVAL;
@@ -712,7 +712,7 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 		v.msg_qbytes = in->msg_qbytes;
 		v.msg_lspid = in->msg_lspid;
 		v.msg_lrpid = in->msg_lrpid;
-		return copy_to_user(buf, &v, sizeof(v));
+		return copy_to_user_partial(buf, &v, sizeof(v));
 	} else {
 		struct compat_msqid_ds v;
 		memset(&v, 0, sizeof(v));
@@ -725,7 +725,7 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 		v.msg_qbytes = in->msg_qbytes;
 		v.msg_lspid = in->msg_lspid;
 		v.msg_lrpid = in->msg_lrpid;
-		return copy_to_user(buf, &v, sizeof(v));
+		return copy_to_user_partial(buf, &v, sizeof(v));
 	}
 }
 
diff --git a/ipc/sem.c b/ipc/sem.c
index 6cdf862b1f5c..3b56086ba07d 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1196,7 +1196,7 @@ static unsigned long copy_semid_to_user(void __user *buf, struct semid64_ds *in,
 {
 	switch (version) {
 	case IPC_64:
-		return copy_to_user(buf, in, sizeof(*in));
+		return copy_to_user_partial(buf, in, sizeof(*in));
 	case IPC_OLD:
 	    {
 		struct semid_ds out;
@@ -1209,7 +1209,7 @@ static unsigned long copy_semid_to_user(void __user *buf, struct semid64_ds *in,
 		out.sem_ctime	= in->sem_ctime;
 		out.sem_nsems	= in->sem_nsems;
 
-		return copy_to_user(buf, &out, sizeof(out));
+		return copy_to_user_partial(buf, &out, sizeof(out));
 	    }
 	default:
 		return -EINVAL;
@@ -1759,7 +1759,7 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 		v.sem_ctime	 = lower_32_bits(in->sem_ctime);
 		v.sem_ctime_high = upper_32_bits(in->sem_ctime);
 		v.sem_nsems = in->sem_nsems;
-		return copy_to_user(buf, &v, sizeof(v));
+		return copy_to_user_partial(buf, &v, sizeof(v));
 	} else {
 		struct compat_semid_ds v;
 		memset(&v, 0, sizeof(v));
@@ -1767,7 +1767,7 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 		v.sem_otime = in->sem_otime;
 		v.sem_ctime = in->sem_ctime;
 		v.sem_nsems = in->sem_nsems;
-		return copy_to_user(buf, &v, sizeof(v));
+		return copy_to_user_partial(buf, &v, sizeof(v));
 	}
 }
 
diff --git a/ipc/shm.c b/ipc/shm.c
index a95dae447707..1eb53c3df3b9 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -853,7 +853,7 @@ static inline unsigned long copy_shmid_to_user(void __user *buf, struct shmid64_
 {
 	switch (version) {
 	case IPC_64:
-		return copy_to_user(buf, in, sizeof(*in));
+		return copy_to_user_partial(buf, in, sizeof(*in));
 	case IPC_OLD:
 	    {
 		struct shmid_ds out;
@@ -868,7 +868,7 @@ static inline unsigned long copy_shmid_to_user(void __user *buf, struct shmid64_
 		out.shm_lpid	= in->shm_lpid;
 		out.shm_nattch	= in->shm_nattch;
 
-		return copy_to_user(buf, &out, sizeof(out));
+		return copy_to_user_partial(buf, &out, sizeof(out));
 	    }
 	default:
 		return -EINVAL;
@@ -905,7 +905,7 @@ static inline unsigned long copy_shminfo_to_user(void __user *buf, struct shminf
 {
 	switch (version) {
 	case IPC_64:
-		return copy_to_user(buf, in, sizeof(*in));
+		return copy_to_user_partial(buf, in, sizeof(*in));
 	case IPC_OLD:
 	    {
 		struct shminfo out;
@@ -920,7 +920,7 @@ static inline unsigned long copy_shminfo_to_user(void __user *buf, struct shminf
 		out.shmseg	= in->shmseg;
 		out.shmall	= in->shmall;
 
-		return copy_to_user(buf, &out, sizeof(out));
+		return copy_to_user_partial(buf, &out, sizeof(out));
 	    }
 	default:
 		return -EINVAL;
@@ -1359,7 +1359,7 @@ static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
 		info.shmmni = in->shmmni;
 		info.shmseg = in->shmseg;
 		info.shmall = in->shmall;
-		return copy_to_user(buf, &info, sizeof(info));
+		return copy_to_user_partial(buf, &info, sizeof(info));
 	} else {
 		struct shminfo info;
 		memset(&info, 0, sizeof(info));
@@ -1368,7 +1368,7 @@ static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
 		info.shmmni = in->shmmni;
 		info.shmseg = in->shmseg;
 		info.shmall = in->shmall;
-		return copy_to_user(buf, &info, sizeof(info));
+		return copy_to_user_partial(buf, &info, sizeof(info));
 	}
 }
 
@@ -1384,7 +1384,7 @@ static int put_compat_shm_info(struct shm_info *ip,
 	info.shm_swp = ip->shm_swp;
 	info.swap_attempts = ip->swap_attempts;
 	info.swap_successes = ip->swap_successes;
-	return copy_to_user(uip, &info, sizeof(info));
+	return copy_to_user_partial(uip, &info, sizeof(info));
 }
 
 static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
@@ -1404,7 +1404,7 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
 		v.shm_nattch = in->shm_nattch;
 		v.shm_cpid = in->shm_cpid;
 		v.shm_lpid = in->shm_lpid;
-		return copy_to_user(buf, &v, sizeof(v));
+		return copy_to_user_partial(buf, &v, sizeof(v));
 	} else {
 		struct compat_shmid_ds v;
 		memset(&v, 0, sizeof(v));
@@ -1417,7 +1417,7 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
 		v.shm_nattch = in->shm_nattch;
 		v.shm_cpid = in->shm_cpid;
 		v.shm_lpid = in->shm_lpid;
-		return copy_to_user(buf, &v, sizeof(v));
+		return copy_to_user_partial(buf, &v, sizeof(v));
 	}
 }
 
diff --git a/kernel/regset.c b/kernel/regset.c
index b2871fa68b2a..29c6d19c3465 100644
--- a/kernel/regset.c
+++ b/kernel/regset.c
@@ -70,7 +70,7 @@ int copy_regset_to_user(struct task_struct *target,
 
 	ret = regset_get_alloc(target, regset, size, &buf);
 	if (ret > 0)
-		ret = copy_to_user(data, buf, ret) ? -EFAULT : 0;
+		ret = copy_to_user_partial(data, buf, ret) ? -EFAULT : 0;
 	kvfree(buf);
 	return ret;
 }
diff --git a/kernel/sys.c b/kernel/sys.c
index 62e842055cc9..8e1ce8c26884 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1343,7 +1343,7 @@ static int override_release(char __user *release, size_t len)
 		v = LINUX_VERSION_PATCHLEVEL + 60;
 		copy = clamp_t(size_t, len, 1, sizeof(buf));
 		copy = scnprintf(buf, copy, "2.6.%u%s", v, rest);
-		ret = copy_to_user(release, buf, copy + 1);
+		ret = copy_to_user_partial(release, buf, copy + 1);
 	}
 	return ret;
 }
@@ -1567,7 +1567,7 @@ SYSCALL_DEFINE2(getrlimit, unsigned int, resource, struct rlimit __user *, rlim)
 
 	ret = do_prlimit(current, resource, NULL, &value);
 	if (!ret)
-		ret = copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;
+		ret = copy_to_user_partial(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;
 
 	return ret;
 }
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 2633f9cc336c..00c19a321aae 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -203,11 +203,11 @@ static unsigned long kfifo_copy_from_user(struct __kfifo *fifo,
 	}
 	l = min(len, size - off);
 
-	ret = copy_from_user(fifo->data + off, from, l);
+	ret = copy_from_user_partial(fifo->data + off, from, l);
 	if (unlikely(ret))
 		ret = DIV_ROUND_UP(ret + len - l, esize);
 	else {
-		ret = copy_from_user(fifo->data, from + l, len - l);
+		ret = copy_from_user_partial(fifo->data, from + l, len - l);
 		if (unlikely(ret))
 			ret = DIV_ROUND_UP(ret, esize);
 	}
@@ -263,11 +263,11 @@ static unsigned long kfifo_copy_to_user(struct __kfifo *fifo, void __user *to,
 	}
 	l = min(len, size - off);
 
-	ret = copy_to_user(to, fifo->data + off, l);
+	ret = copy_to_user_partial(to, fifo->data + off, l);
 	if (unlikely(ret))
 		ret = DIV_ROUND_UP(ret + len - l, esize);
 	else {
-		ret = copy_to_user(to + l, fifo->data, len - l);
+		ret = copy_to_user_partial(to + l, fifo->data, len - l);
 		if (unlikely(ret))
 			ret = DIV_ROUND_UP(ret, esize);
 	}
diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 32d06cbf6a31..a4d19fc1068a 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -2169,9 +2169,9 @@ static void copy_user_test_oob(struct kunit *test)
 	usermem = (char __user *)useraddr;
 
 	KUNIT_EXPECT_KASAN_FAIL(test,
-		unused = copy_from_user(kmem, usermem, size + 1));
+		unused = copy_from_user_partial(kmem, usermem, size + 1));
 	KUNIT_EXPECT_KASAN_FAIL_READ(test,
-		unused = copy_to_user(usermem, kmem, size + 1));
+		unused = copy_to_user_partial(usermem, kmem, size + 1));
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		unused = __copy_from_user(kmem, usermem, size + 1));
 	KUNIT_EXPECT_KASAN_FAIL_READ(test,
diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..5a2f7543a2da 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7529,7 +7529,7 @@ long copy_folio_from_user(struct folio *dst_folio,
 		kaddr = kmap_local_page(subpage);
 		if (!allow_pagefault)
 			pagefault_disable();
-		rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
+		rc = copy_from_user_partial(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
 		if (!allow_pagefault)
 			pagefault_enable();
 		kunmap_local(kaddr);
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index af8762b24039..7327c98b206a 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -471,7 +471,7 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
 		goto out;
 
 	val = test_bit(X25_Q_BIT_FLAG, &x25_sk(sk)->flags);
-	rc = copy_to_user(optval, &val, len) ? -EFAULT : 0;
+	rc = copy_to_user_partial(optval, &val, len) ? -EFAULT : 0;
 out:
 	return rc;
 }
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
index 01de4fbbcc84..710e07cd60ae 100644
--- a/rust/helpers/uaccess.c
+++ b/rust/helpers/uaccess.c
@@ -5,13 +5,13 @@
 __rust_helper unsigned long
 rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return copy_from_user(to, from, n);
+	return copy_from_user_partial(to, from, n);
 }
 
 __rust_helper unsigned long
 rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return copy_to_user(to, from, n);
+	return copy_to_user_partial(to, from, n);
 }
 
 #ifndef CONFIG_ARCH_WANTS_NOINLINE_COPY_USER
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 08e0556bf161..3941bf9666a9 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -739,10 +739,10 @@ static int copy_gctl_to_user(struct snd_emu10k1 *emu,
 
 	_dst = (struct snd_emu10k1_fx8010_control_gpr __user *)dst;
 	if (emu->support_tlv)
-		return copy_to_user(&_dst[idx], src, sizeof(*src));
+		return copy_to_user_partial(&_dst[idx], src, sizeof(*src));
 	
 	octl = (struct snd_emu10k1_fx8010_control_old_gpr __user *)dst;
-	return copy_to_user(&octl[idx], src, sizeof(*octl));
+	return copy_to_user_partial(&octl[idx], src, sizeof(*octl));
 }
 
 static int copy_ctl_elem_id(const struct emu10k1_ctl_elem_id *list, int i,
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 31cc2d91c8d2..d5842d8a8509 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4541,7 +4541,7 @@ static int snd_hdsp_capture_release(struct snd_pcm_substream *substream)
 static inline int copy_u32_le(void __user *dest, void __iomem *src)
 {
 	u32 val = readl(src);
-	return copy_to_user(dest, &val, 4);
+	return copy_to_user_partial(dest, &val, 4);
 }
 
 static inline int copy_u64_le(void __user *dest, void __iomem *src_low, void __iomem *src_high)
@@ -4551,7 +4551,7 @@ static inline int copy_u64_le(void __user *dest, void __iomem *src_low, void __i
 	rms_low = readl(src_low);
 	rms_high = readl(src_high);
 	rms = ((u64)rms_high << 32) | rms_low;
-	return copy_to_user(dest, &rms, 8);
+	return copy_to_user_partial(dest, &rms, 8);
 }
 
 static inline int copy_u48_le(void __user *dest, void __iomem *src_low, void __iomem *src_high)
@@ -4561,7 +4561,7 @@ static inline int copy_u48_le(void __user *dest, void __iomem *src_low, void __i
 	rms_low = readl(src_low) & 0xffffff00;
 	rms_high = readl(src_high) & 0xffffff00;
 	rms = ((u64)rms_high << 32) | rms_low;
-	return copy_to_user(dest, &rms, 8);
+	return copy_to_user_partial(dest, &rms, 8);
 }
 
 static int hdsp_9652_get_peak(struct hdsp *hdsp, struct hdsp_peak_rms __user *peak_rms)
diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
index 099119ad28b3..bc2871d3e18c 100644
--- a/sound/soc/intel/avs/probes.c
+++ b/sound/soc/intel/avs/probes.c
@@ -244,10 +244,10 @@ static int avs_probe_compr_copy(struct snd_soc_component *comp, struct snd_compr
 	n = rtd->buffer_size - offset;
 
 	if (count < n) {
-		ret = copy_to_user(buf, ptr, count);
+		ret = copy_to_user_partial(buf, ptr, count);
 	} else {
-		ret = copy_to_user(buf, ptr, n);
-		ret += copy_to_user(buf + n, rtd->dma_area, count - n);
+		ret = copy_to_user_partial(buf, ptr, n);
+		ret += copy_to_user_partial(buf + n, rtd->dma_area, count - n);
 	}
 
 	if (ret)
diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 93f2376585db..d54be8a188ec 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -324,10 +324,10 @@ static int sof_compr_copy_playback(struct snd_compr_runtime *rtd,
 	n = rtd->buffer_size - offset;
 
 	if (count < n) {
-		ret = copy_from_user(ptr, buf, count);
+		ret = copy_from_user_partial(ptr, buf, count);
 	} else {
-		ret = copy_from_user(ptr, buf, n);
-		ret += copy_from_user(rtd->dma_area, buf + n, count - n);
+		ret = copy_from_user_partial(ptr, buf, n);
+		ret += copy_from_user_partial(rtd->dma_area, buf + n, count - n);
 	}
 
 	return count - ret;
@@ -345,10 +345,10 @@ static int sof_compr_copy_capture(struct snd_compr_runtime *rtd,
 	n = rtd->buffer_size - offset;
 
 	if (count < n) {
-		ret = copy_to_user(buf, ptr, count);
+		ret = copy_to_user_partial(buf, ptr, count);
 	} else {
-		ret = copy_to_user(buf, ptr, n);
-		ret += copy_to_user(buf + n, rtd->dma_area, count - n);
+		ret = copy_to_user_partial(buf, ptr, n);
+		ret += copy_to_user_partial(buf + n, rtd->dma_area, count - n);
 	}
 
 	return count - ret;
diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index 124f55508159..4c5f4f016ff8 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -184,10 +184,10 @@ static int sof_probes_compr_copy(struct snd_soc_component *component,
 	n = rtd->buffer_size - offset;
 
 	if (count < n) {
-		ret = copy_to_user(buf, ptr, count);
+		ret = copy_to_user_partial(buf, ptr, count);
 	} else {
-		ret = copy_to_user(buf, ptr, n);
-		ret += copy_to_user(buf + n, rtd->dma_area, count - n);
+		ret = copy_to_user_partial(buf, ptr, n);
+		ret += copy_to_user_partial(buf + n, rtd->dma_area, count - n);
 	}
 
 	if (ret)
-- 
2.49.0


