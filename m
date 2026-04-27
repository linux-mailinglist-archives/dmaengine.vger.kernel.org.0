Return-Path: <dmaengine+bounces-10138-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LogDg6a72npDAEAu9opvQ
	(envelope-from <dmaengine+bounces-10138-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:17:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F56476F3B
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26525300A606
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F931159C;
	Mon, 27 Apr 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2+LLE02"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460E29405;
	Mon, 27 Apr 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310219; cv=none; b=lnKg7BoxsEj+KpDcf/oALBrXT1ccTPBpkTI3ECVX2s5+j9fNGEdNiRPFZQ8HHDtmvwK+7jcFnrgXz6RbeU/6P/VLAj5z8DPYqKu0fs6R/6tWQQ0otKZOoYGLjzORJyOu7yinHhzzi5Rz3N/XoPqxUmBTM7+3NcZDBN5Fa5hGw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310219; c=relaxed/simple;
	bh=Gdo90UdOw5JDNcbBc6CTpgqBoS99tJWdzzhKt47HDkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCWJwhkgyQIPBwW36YBLsUTxKenVr8c/dnY28kBLLI5w/jdSgmUcTrI8h7IRMX6fYYCmnIiH5daNsx88sS8N05ODBVdWNquhCzzZoTW7kiY+fqoobv6Du/Xc5AYtVrf7QCsNShxs3Cx0dwSSwP+bsgcv8u6JdQAck3yTm/GilNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2+LLE02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FE1C2BCB4;
	Mon, 27 Apr 2026 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310218;
	bh=Gdo90UdOw5JDNcbBc6CTpgqBoS99tJWdzzhKt47HDkg=;
	h=From:To:Cc:Subject:Date:From;
	b=U2+LLE02v2RJdGrHn64GqYJdP4+hDdO9CRQcGon9U+fg19LBxhX5PBepS5h9HJCqe
	 szqGGe/Sn0Ja8ufrVfKBRayklpg7ZNqhD3AjlJFyhWTD2cy+E9nyVtxoXvU6RVePwS
	 nC/EKNFwPrGycTqEuaSwxvd9NLoS3iznsIjTk0KPgTVc+veLovfoR+uQQZvkXu6BEL
	 XY5HSP+s8CkmcaZnZCCWlv0qtPkuKqPRoos+3EvmYxD3lbF+eVbofOW/u0ribOc9N6
	 46gB4iCE7qS4DHXiu+LbPED9AO2rWWkmtG0xffEU92OaQJ+vWiy9PumgjbDE3AiKLE
	 isfjlgjrnrghg==
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
Subject: [RFC PATCH v1 0/9] uaccess: Convert small fixed size copy_{to/from}_user() to scoped user access
Date: Mon, 27 Apr 2026 19:13:41 +0200
Message-ID: <cover.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7253; i=chleroy@kernel.org; h=from:subject:message-id; bh=Gdo90UdOw5JDNcbBc6CTpgqBoS99tJWdzzhKt47HDkg=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxkaMinl/6P42P3bc0Qj3v7nk1G4YbGg/rEse+BPv 7e7BNgWdJSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJRDExMmwV0vIK89sWnHjX Y4WN3O+gaTyvmP0m2koKTvi9YNORsocM/wPkn2xoM0q8N63lWvLNy/m/speGuG7LLGiQ1I6bVSB dxgQA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89F56476F3B
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
	TAGGED_FROM(0.00)[bounces-10138-lists,dmaengine=lfdr.de];
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

A lot of copy_from_user() and copy_to_user() perform copies of small
fixed size pieces of data between kernel and userspace, and don't
care about partial copies.

copy_from_user() and copy_to_user() are big functions optimised for
copying large amount of data, with cache management, etc ... This is
often overkill for small copies that could just be inlined instead.

What makes things a bit more tricky is that those copy functions
are designed to handle partial copies in case of page fault. But among
the 6000 callers of those functions, only 2% really care about the
quantity of no-copied data that those functions return. All other ones
fails as soon as the returned value is not 0, returning -EACCESS.

So first step in this series is to introduce variants called
copy_from_user_partial() and copy_to_user_partial() which will be
called by the 2% users that care about the partial copy, then the
original copy_from_user() and copy_to_user() are changed to return
-EFAULT when the copy fails.

Then the second step is to implement copy of small fixed-size data
with scoped user access instead of calling the arch specific heavy
user copy functions.

Patch 5, can be split in different patches for each archicture or
subsystem, but let's get a first feedback and agree on the principle.

Christophe Leroy (CS GROUP) (9):
  uaccess: Split check_zeroed_user() out of usercopy.c
  uaccess: Convert INLINE_COPY_{TO/FROM}_USER to kconfig and reduce
    ifdefery
  x86/umip: Be stricter in fixup_umip_exception()
  uaccess: Introduce copy_{to/from}_user_partial()
  uaccess: Switch to copy_{to/from}_user_partial() when relevant
  uaccess: Change copy_{to/from}_user to return -EFAULT
  x86: Add unsafe_copy_from_user()
  arm64: Add unsafe_copy_from_user()
  uaccess: Convert small fixed size copy_{to/from}_user() to scoped user
    access

 arch/alpha/Kconfig                            |   1 +
 arch/alpha/kernel/osf_sys.c                   |   4 +-
 arch/alpha/kernel/termios.c                   |   2 +-
 arch/arc/include/asm/uaccess.h                |   3 -
 arch/arc/kernel/disasm.c                      |   2 +-
 arch/arm/include/asm/uaccess.h                |   2 -
 arch/arm64/include/asm/gcs.h                  |   2 +-
 arch/arm64/include/asm/uaccess.h              |  30 +++--
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/csky/Kconfig                             |   1 +
 arch/hexagon/include/asm/uaccess.h            |   3 -
 arch/loongarch/include/asm/uaccess.h          |   3 -
 arch/m68k/include/asm/uaccess.h               |   3 -
 arch/microblaze/include/asm/uaccess.h         |   2 -
 arch/mips/include/asm/uaccess.h               |   3 -
 arch/mips/kernel/rtlx.c                       |   8 +-
 arch/mips/kernel/vpe.c                        |   2 +-
 arch/nios2/include/asm/uaccess.h              |   2 -
 arch/openrisc/include/asm/uaccess.h           |   2 -
 arch/parisc/include/asm/uaccess.h             |   3 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |   4 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c        |   4 +-
 arch/powerpc/kvm/book3s_hv.c                  |   2 +-
 arch/riscv/Kconfig                            |   1 +
 arch/riscv/kernel/signal.c                    |   2 +-
 arch/s390/include/asm/idals.h                 |   8 +-
 arch/s390/include/asm/uaccess.h               |   3 -
 arch/sh/include/asm/uaccess.h                 |   2 -
 arch/sparc/include/asm/uaccess_32.h           |   3 -
 arch/sparc/include/asm/uaccess_64.h           |   2 -
 arch/sparc/kernel/termios.c                   |   2 +-
 arch/um/include/asm/uaccess.h                 |   3 -
 arch/um/kernel/process.c                      |   2 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/uaccess.h                |  29 ++++-
 arch/x86/kernel/umip.c                        |   2 +-
 arch/x86/lib/insn-eval.c                      |   2 +-
 arch/x86/um/signal.c                          |   2 +-
 arch/xtensa/include/asm/uaccess.h             |   2 -
 drivers/android/binder_alloc.c                |   2 +-
 drivers/comedi/comedi_fops.c                  |   4 +-
 drivers/dma/idxd/cdev.c                       |   2 +-
 drivers/firmware/efi/test/efi_test.c          |   2 +-
 drivers/fsi/fsi-scom.c                        |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 drivers/gpu/drm/i915/gt/intel_sseu.c          |   4 +-
 drivers/gpu/drm/i915/i915_gem.c               |   4 +-
 drivers/hwtracing/intel_th/msu.c              |   2 +-
 drivers/misc/ibmvmc.c                         |   2 +-
 drivers/misc/vmw_vmci/vmci_host.c             |   2 +-
 drivers/most/most_cdev.c                      |   2 +-
 drivers/net/ieee802154/ca8210.c               |   4 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    |   2 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |   2 +-
 drivers/net/wireless/ti/wlcore/debugfs.c      |   2 +-
 drivers/ps3/ps3-lpm.c                         |   2 +-
 drivers/s390/crypto/zcrypt_api.h              |   4 +-
 drivers/spi/spidev.c                          |   2 +-
 .../staging/media/atomisp/pci/atomisp_cmd.c   |   8 +-
 drivers/tty/tty_ioctl.c                       |  14 +--
 drivers/tty/vt/vc_screen.c                    |   4 +-
 drivers/usb/gadget/function/f_hid.c           |   4 +-
 drivers/usb/gadget/function/f_printer.c       |   2 +-
 drivers/vfio/vfio_iommu_type1.c               |   4 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c      |   2 +-
 fs/namespace.c                                |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                        |   2 +-
 fs/proc/base.c                                |   4 +-
 include/asm-generic/uaccess.h                 |   2 -
 include/linux/bpfptr.h                        |   2 +-
 include/linux/sockptr.h                       |   4 +-
 include/linux/uaccess.h                       | 107 ++++++++++++++----
 ipc/msg.c                                     |   8 +-
 ipc/sem.c                                     |   8 +-
 ipc/shm.c                                     |  18 +--
 kernel/regset.c                               |   2 +-
 kernel/sys.c                                  |   4 +-
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   4 +-
 lib/kfifo.c                                   |   8 +-
 lib/{usercopy.c => usercheck.c}               |  22 ----
 lib/usercopy.c                                |  66 -----------
 mm/kasan/kasan_test_c.c                       |   4 +-
 mm/memory.c                                   |   2 +-
 net/x25/af_x25.c                              |   2 +-
 rust/helpers/uaccess.c                        |   6 +-
 sound/pci/emu10k1/emufx.c                     |   4 +-
 sound/pci/rme9652/hdsp.c                      |   6 +-
 sound/soc/intel/avs/probes.c                  |   6 +-
 sound/soc/sof/compress.c                      |  12 +-
 sound/soc/sof/sof-client-probes.c             |   6 +-
 92 files changed, 269 insertions(+), 288 deletions(-)
 copy lib/{usercopy.c => usercheck.c} (73%)

-- 
2.49.0


