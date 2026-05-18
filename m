Return-Path: <dmaengine+bounces-10499-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHm7KKKVCmqp3wQAu9opvQ
	(envelope-from <dmaengine+bounces-10499-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 06:29:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B1565A82
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 06:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC22430075EA
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 04:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D167381B15;
	Mon, 18 May 2026 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkOGzm+n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D4381AE2
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779078552; cv=none; b=VCJmZpCSdnPGGLeP6GrbT8mqgdnI01etTqX00fEqO/fBruAgRWpjCbrL4uUcxJmB85ScFfT3ksqBCu/9DZZuzLRMUjtu0ENekey45Kc+aHyPfhcOZWAprcx6aNoo6JTVmB5zLbWAfiD58+UdlQ0GtkDeGSa0JrK1eTaxZKaQEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779078552; c=relaxed/simple;
	bh=6HxV3gJYqoQZ4tEZWCIQqiP3pOhYL1Sk+mz0reSlPqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLSoIyd5TW+4Mln2RSNarVYTnfjsEwtE2mC3HphLF0l3PcszqPcllGKdb1wvs/EOsiBY+z3Kd7rJPj6BS2DbpDBWbhboBSB6R0gXHAVyx7gu5DYQQzAm59rEBSXHUwX8Wtmaa2o6yFYZGkvKR6a0LpFQ1a4ZOVLRKk+JdcCec/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkOGzm+n; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1329fc4bf77so4489046c88.1
        for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779078533; x=1779683333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XYjvAeufzhSKtiP6EuLqhrBIUXAQIq6Gj07n9zxqI8=;
        b=gkOGzm+nGnvlg2Q6tw72uv40gSG3WTN0o8tDtSEpxJAs9EEA6ZTmA5DAfPId8dY568
         doqvsYlBfv2d08W0ouAwBzqVa7cgqt23foOEULlC0amDf/b1izebwnaDOcEozfrV2RdN
         HhIEq6bxZ9IutUc/B+fJArtyJWKlXS2gR0Vzu6KXOcYY9am7dclqWKisslPfwHQR7FOc
         2uGE7R00iJrjK9rmlIX6W25dfvfhZUhZHf/NNDdYtn4EkMWwG1S540uea6dMaiYgQFyT
         XT2HnUH66lracFnk5ntPsrshuVB+mdD+1Q27Ngyo/MJPZ50LYc3C8kiNNnpcFxzxJqwk
         7Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779078533; x=1779683333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XYjvAeufzhSKtiP6EuLqhrBIUXAQIq6Gj07n9zxqI8=;
        b=LHW8eFjTJHLUQ3DtR/UfYhaNezCvnmDxzw2P3pKhpULSXG7ipBh3nmeM1uEVe/O/p7
         ittdBCPW2X8la4IfJKsIniiWb9T1cAMh9QOpsX/iJkGqC0X8EctD93FAxNfgQ6QGI6cm
         oAb1rbQGqoPuFEmA5h+MI6+jvu9cq+66oPDxgU5qx2Zo6r7MqcHMeT75CKv5z8nJ60ny
         GrDew5JhHC04dUbyb7ZTQh/PrH1xcoBpJh3aHDNixfxhpu68EyEHcENpOt6mK5d/ZpnJ
         biYzKx2o1uXVl/dnsgEA5UDv3QBl5xma2J/bB7h/IlJpJFUCX79RE604puS5iBj8kReC
         qsWw==
X-Forwarded-Encrypted: i=1; AFNElJ8lXGD6hWNlDbLqKL1x7EZXcCfD1qrOzDpRWnbxGtiWQfhnG+gxRQ9vWB2ojgvES8XGGbSVR+BHwR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LBzQKsoNT1mEmdXzeBKIumyxegkvMkLVGjXAkLOhLpVBWsZT
	V6lhvPntPfX7p7IkqW2VufQtrK95XYN8Cj/kbl5/YsqSACCrliGFYCd7
X-Gm-Gg: Acq92OEP0223VkQYWEuA0zF5lVnMyqNZpAOSgtC9bSGKPSaJGO7xVVS7lvIihj9jHtN
	RdKsnYZ34q4Myrw9wi2y9MYwcfm6aE3xfJGRjskJuz5R+mL0Ko1yktLYJI6TO8Fs/dx/7pMViUs
	DYtQCOmzEUs3XMryvxHB9cERZ4ikwn+i5sWtJGfNE9wEa6ipZcjIw36pmAqVOwA/PmHl1kvay0k
	S+CQCNr7Tq0jiW04he13/JQAVNfZ3dBhw7VSUptmC7VIXfN2EnmRmeECObPiBezdfbna3eqVZF8
	ZNeULkxyGz1VLicqIyebOOWF9SlLMlokDD8RfC+ja2HpXXujo7d+WOfqbQh70aANgAICBLLvz5t
	YdVbao61b2wN3WioSdF6Re0KR18k78xQb3paQWNVLhhVLqTs9/kjCaB3VJUzH5NH2NhaMizOKD6
	ylS3TH4R7bMXV4DJ45C+KENZ/gzjEDPLvMmVTAJUlJXmlU9B36o6g9NWzjiM9tHBXX6NNq0BvYi
	4vdEW6JSLVVsve3pwJG2EC4+NnoGD/hkJZOqYutvcXxnko+vb1ThryQV0NfnoCHVQ82xgOERm9X
	ksJ5tyY7uJOD+adxzE8PNrvx3XXv
X-Received: by 2002:a05:7301:2901:b0:2c0:e404:8b08 with SMTP id 5a478bee46e88-303986b4529mr5706979eec.29.1779078531266;
        Sun, 17 May 2026 21:28:51 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302946f2149sm12491985eec.11.2026.05.17.21.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 21:28:50 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-arch@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-csky@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Dave Penkler <dpenkler@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH] nios2: remove the architecture
Date: Sun, 17 May 2026 21:28:33 -0700
Message-ID: <20260518042833.272221-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B2B1565A82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,infradead.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[48];
	TAGGED_FROM(0.00)[bounces-10499-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The Nios II architecture is a soft-core architecture developed by
Altera (since acquired by Intel) and intended to run on their FPGAs.

Licenses for the architecture have not been available for purchase
since 2024 [1], and support for it has been removed from GCC 15 [2],
Buildroot [3], and QEMU [4].

Given all of these factors, it is time to remove Nios II support from
the kernel. The maintainer stated in 2024 that they were planning to do
so soon [5], but this did not come to pass.

Remove Nios II support from the kernel and move the former maintainer
to CREDITS. Thank you, Dinh Nguyen, for maintaining Nios II support!

References:
[1] https://docs.altera.com/v/u/docs/781327/is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip
[2] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=e876acab6cdd84bb2b32c98fc69fb0ba29c81153
[3] https://github.com/buildroot/buildroot/commit/6775ccc5a199d574ad70b5f79ec58cce97a07c6f
[4] https://github.com/qemu/qemu/commit/6c3014858c4c0024dd0560f08a6eda0f92f658d6
[5] https://sourceware.org/pipermail/newlib/2024/021083.html

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 CREDITS                                       |   4 +
 Documentation/.renames.txt                    |   3 -
 .../admin-guide/kernel-parameters.txt         |   4 +-
 Documentation/arch/index.rst                  |   1 -
 Documentation/arch/nios2/features.rst         |   3 -
 Documentation/arch/nios2/index.rst            |  12 -
 Documentation/arch/nios2/nios2.rst            |  24 -
 .../devicetree/bindings/nios2/nios2.txt       |  62 --
 .../bindings/timer/altr,timer-1.0.yaml        |  39 --
 Documentation/devicetree/usage-model.rst      |   5 +-
 .../features/core/cBPF-JIT/arch-support.txt   |   1 -
 .../features/core/eBPF-JIT/arch-support.txt   |   1 -
 .../core/generic-idle-thread/arch-support.txt |   1 -
 .../core/jump-labels/arch-support.txt         |   1 -
 .../core/mseal_sys_mappings/arch-support.txt  |   1 -
 .../core/thread-info-in-task/arch-support.txt |   1 -
 .../features/core/tracehook/arch-support.txt  |   1 -
 .../features/debug/KASAN/arch-support.txt     |   1 -
 .../debug/debug-vm-pgtable/arch-support.txt   |   1 -
 .../debug/gcov-profile-all/arch-support.txt   |   1 -
 .../features/debug/kcov/arch-support.txt      |   1 -
 .../features/debug/kgdb/arch-support.txt      |   1 -
 .../features/debug/kmemleak/arch-support.txt  |   1 -
 .../debug/kprobes-on-ftrace/arch-support.txt  |   1 -
 .../features/debug/kprobes/arch-support.txt   |   1 -
 .../debug/kretprobes/arch-support.txt         |   1 -
 .../features/debug/optprobes/arch-support.txt |   1 -
 .../debug/stackprotector/arch-support.txt     |   1 -
 .../features/debug/uprobes/arch-support.txt   |   1 -
 .../debug/user-ret-profiler/arch-support.txt  |   1 -
 .../io/dma-contiguous/arch-support.txt        |   1 -
 .../locking/cmpxchg-local/arch-support.txt    |   1 -
 .../features/locking/lockdep/arch-support.txt |   1 -
 .../locking/queued-rwlocks/arch-support.txt   |   1 -
 .../locking/queued-spinlocks/arch-support.txt |   1 -
 .../perf/kprobes-event/arch-support.txt       |   1 -
 .../features/perf/perf-regs/arch-support.txt  |   1 -
 .../perf/perf-stackdump/arch-support.txt      |   1 -
 .../membarrier-sync-core/arch-support.txt     |   1 -
 .../sched/numa-balancing/arch-support.txt     |   1 -
 .../seccomp/seccomp-filter/arch-support.txt   |   1 -
 .../time/arch-tick-broadcast/arch-support.txt |   1 -
 .../time/clockevents/arch-support.txt         |   1 -
 .../time/context-tracking/arch-support.txt    |   1 -
 .../time/irq-time-acct/arch-support.txt       |   1 -
 .../time/virt-cpuacct/arch-support.txt        |   1 -
 .../features/vm/ELF-ASLR/arch-support.txt     |   1 -
 .../features/vm/THP/arch-support.txt          |   1 -
 .../features/vm/TLB/arch-support.txt          |   1 -
 .../features/vm/huge-vmap/arch-support.txt    |   1 -
 .../features/vm/ioremap_prot/arch-support.txt |   1 -
 .../features/vm/pte_special/arch-support.txt  |   1 -
 Documentation/process/adding-syscalls.rst     |   1 -
 .../translations/zh_CN/arch/index.rst         |   1 -
 .../translations/zh_TW/arch/index.rst         |   1 -
 MAINTAINERS                                   |   6 -
 arch/nios2/Kbuild                             |   6 -
 arch/nios2/Kconfig                            | 182 ------
 arch/nios2/Kconfig.debug                      |  12 -
 arch/nios2/Makefile                           |  62 --
 arch/nios2/boot/.gitignore                    |   2 -
 arch/nios2/boot/Makefile                      |  32 -
 arch/nios2/boot/compressed/Makefile           |  19 -
 arch/nios2/boot/compressed/console.c          | 112 ----
 arch/nios2/boot/compressed/head.S             | 117 ----
 arch/nios2/boot/compressed/misc.c             | 174 ------
 arch/nios2/boot/compressed/vmlinux.lds.S      |  45 --
 arch/nios2/boot/compressed/vmlinux.scr        |  28 -
 arch/nios2/boot/dts/10m50_devboard.dts        | 237 -------
 arch/nios2/boot/dts/3c120_devboard.dts        | 153 -----
 arch/nios2/boot/dts/Makefile                  |   5 -
 arch/nios2/boot/install.sh                    |  32 -
 arch/nios2/configs/10m50_defconfig            |  75 ---
 arch/nios2/configs/3c120_defconfig            |  73 ---
 arch/nios2/include/asm/Kbuild                 |  10 -
 arch/nios2/include/asm/asm-macros.h           | 298 ---------
 arch/nios2/include/asm/asm-offsets.h          |   7 -
 arch/nios2/include/asm/cache.h                |  26 -
 arch/nios2/include/asm/cacheflush.h           |  61 --
 arch/nios2/include/asm/cachetype.h            |  10 -
 arch/nios2/include/asm/checksum.h             |  70 ---
 arch/nios2/include/asm/cpuinfo.h              |  46 --
 arch/nios2/include/asm/delay.h                |  21 -
 arch/nios2/include/asm/elf.h                  |  88 ---
 arch/nios2/include/asm/entry.h                | 121 ----
 arch/nios2/include/asm/io.h                   |  40 --
 arch/nios2/include/asm/irq.h                  |  14 -
 arch/nios2/include/asm/irqflags.h             |  59 --
 arch/nios2/include/asm/kgdb.h                 |  80 ---
 arch/nios2/include/asm/linkage.h              |  15 -
 arch/nios2/include/asm/mmu.h                  |  16 -
 arch/nios2/include/asm/mmu_context.h          |  55 --
 arch/nios2/include/asm/page.h                 |  96 ---
 arch/nios2/include/asm/pgalloc.h              |  34 -
 arch/nios2/include/asm/pgtable-bits.h         |  37 --
 arch/nios2/include/asm/pgtable.h              | 297 ---------
 arch/nios2/include/asm/processor.h            |  77 ---
 arch/nios2/include/asm/ptrace.h               |  82 ---
 arch/nios2/include/asm/registers.h            |  58 --
 arch/nios2/include/asm/setup.h                |  23 -
 arch/nios2/include/asm/shmparam.h             |  10 -
 arch/nios2/include/asm/string.h               |  24 -
 arch/nios2/include/asm/swab.h                 |  38 --
 arch/nios2/include/asm/switch_to.h            |  31 -
 arch/nios2/include/asm/syscall.h              |  82 ---
 arch/nios2/include/asm/syscalls.h             |  14 -
 arch/nios2/include/asm/thread_info.h          | 101 ---
 arch/nios2/include/asm/timex.h                |  15 -
 arch/nios2/include/asm/tlb.h                  |  24 -
 arch/nios2/include/asm/tlbflush.h             |  44 --
 arch/nios2/include/asm/traps.h                |  21 -
 arch/nios2/include/asm/uaccess.h              | 189 ------
 arch/nios2/include/asm/unistd.h               |  10 -
 arch/nios2/include/asm/vmalloc.h              |   4 -
 arch/nios2/include/uapi/asm/Kbuild            |   4 -
 arch/nios2/include/uapi/asm/byteorder.h       |  23 -
 arch/nios2/include/uapi/asm/elf.h             |  66 --
 arch/nios2/include/uapi/asm/ptrace.h          |  84 ---
 arch/nios2/include/uapi/asm/sigcontext.h      |  31 -
 arch/nios2/include/uapi/asm/signal.h          |  24 -
 arch/nios2/include/uapi/asm/unistd.h          |  19 -
 arch/nios2/kernel/.gitignore                  |   2 -
 arch/nios2/kernel/Makefile                    |  26 -
 arch/nios2/kernel/Makefile.syscalls           |   3 -
 arch/nios2/kernel/asm-offsets.c               |  75 ---
 arch/nios2/kernel/cpuinfo.c                   | 192 ------
 arch/nios2/kernel/entry.S                     | 574 -----------------
 arch/nios2/kernel/head.S                      | 165 -----
 arch/nios2/kernel/insnemu.S                   | 580 ------------------
 arch/nios2/kernel/irq.c                       |  80 ---
 arch/nios2/kernel/kgdb.c                      | 158 -----
 arch/nios2/kernel/misaligned.c                | 238 -------
 arch/nios2/kernel/module.c                    | 117 ----
 arch/nios2/kernel/nios2_ksyms.c               |  44 --
 arch/nios2/kernel/process.c                   | 268 --------
 arch/nios2/kernel/prom.c                      |  41 --
 arch/nios2/kernel/ptrace.c                    | 145 -----
 arch/nios2/kernel/setup.c                     | 208 -------
 arch/nios2/kernel/signal.c                    | 328 ----------
 arch/nios2/kernel/sys_nios2.c                 |  60 --
 arch/nios2/kernel/syscall_table.c             |  21 -
 arch/nios2/kernel/time.c                      | 359 -----------
 arch/nios2/kernel/traps.c                     | 196 ------
 arch/nios2/kernel/vmlinux.lds.S               |  64 --
 arch/nios2/lib/Makefile                       |   9 -
 arch/nios2/lib/delay.c                        |  40 --
 arch/nios2/lib/memcpy.c                       | 202 ------
 arch/nios2/lib/memmove.c                      |  80 ---
 arch/nios2/lib/memset.c                       |  79 ---
 arch/nios2/mm/Makefile                        |  15 -
 arch/nios2/mm/cacheflush.c                    | 281 ---------
 arch/nios2/mm/dma-mapping.c                   |  77 ---
 arch/nios2/mm/extable.c                       |  25 -
 arch/nios2/mm/fault.c                         | 264 --------
 arch/nios2/mm/init.c                          | 154 -----
 arch/nios2/mm/ioremap.c                       | 188 ------
 arch/nios2/mm/mmu_context.c                   | 116 ----
 arch/nios2/mm/pgtable.c                       |  74 ---
 arch/nios2/mm/tlb.c                           | 304 ---------
 arch/nios2/mm/uaccess.c                       | 130 ----
 arch/nios2/platform/Kconfig.platform          | 149 -----
 arch/nios2/platform/Makefile                  |   2 -
 arch/nios2/platform/platform.c                |  52 --
 drivers/dma/Kconfig                           |   2 +-
 drivers/gpib/common/iblib.c                   |   8 +-
 drivers/i2c/busses/Kconfig                    |   4 +-
 drivers/iio/adc/Kconfig                       |   2 +-
 drivers/iio/dac/Kconfig                       |   2 +-
 drivers/net/ethernet/davicom/Kconfig          |   2 +-
 drivers/net/ethernet/smsc/Kconfig             |   4 +-
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pwm/Kconfig                           |   2 +-
 include/linux/seqlock.h                       |   2 +-
 lib/tests/usercopy_kunit.c                    |   1 -
 mm/Kconfig                                    |   4 +-
 scripts/checkstack.pl                         |   3 -
 scripts/dtc/include-prefixes/nios2            |   1 -
 scripts/head-object-list.txt                  |   1 -
 scripts/syscall.tbl                           |   2 -
 tools/scripts/syscall.tbl                     |   2 -
 usr/include/Makefile                          |   6 +-
 181 files changed, 24 insertions(+), 10384 deletions(-)
 delete mode 100644 Documentation/arch/nios2/features.rst
 delete mode 100644 Documentation/arch/nios2/index.rst
 delete mode 100644 Documentation/arch/nios2/nios2.rst
 delete mode 100644 Documentation/devicetree/bindings/nios2/nios2.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml
 delete mode 100644 arch/nios2/Kbuild
 delete mode 100644 arch/nios2/Kconfig
 delete mode 100644 arch/nios2/Kconfig.debug
 delete mode 100644 arch/nios2/Makefile
 delete mode 100644 arch/nios2/boot/.gitignore
 delete mode 100644 arch/nios2/boot/Makefile
 delete mode 100644 arch/nios2/boot/compressed/Makefile
 delete mode 100644 arch/nios2/boot/compressed/console.c
 delete mode 100644 arch/nios2/boot/compressed/head.S
 delete mode 100644 arch/nios2/boot/compressed/misc.c
 delete mode 100644 arch/nios2/boot/compressed/vmlinux.lds.S
 delete mode 100644 arch/nios2/boot/compressed/vmlinux.scr
 delete mode 100644 arch/nios2/boot/dts/10m50_devboard.dts
 delete mode 100644 arch/nios2/boot/dts/3c120_devboard.dts
 delete mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100755 arch/nios2/boot/install.sh
 delete mode 100644 arch/nios2/configs/10m50_defconfig
 delete mode 100644 arch/nios2/configs/3c120_defconfig
 delete mode 100644 arch/nios2/include/asm/Kbuild
 delete mode 100644 arch/nios2/include/asm/asm-macros.h
 delete mode 100644 arch/nios2/include/asm/asm-offsets.h
 delete mode 100644 arch/nios2/include/asm/cache.h
 delete mode 100644 arch/nios2/include/asm/cacheflush.h
 delete mode 100644 arch/nios2/include/asm/cachetype.h
 delete mode 100644 arch/nios2/include/asm/checksum.h
 delete mode 100644 arch/nios2/include/asm/cpuinfo.h
 delete mode 100644 arch/nios2/include/asm/delay.h
 delete mode 100644 arch/nios2/include/asm/elf.h
 delete mode 100644 arch/nios2/include/asm/entry.h
 delete mode 100644 arch/nios2/include/asm/io.h
 delete mode 100644 arch/nios2/include/asm/irq.h
 delete mode 100644 arch/nios2/include/asm/irqflags.h
 delete mode 100644 arch/nios2/include/asm/kgdb.h
 delete mode 100644 arch/nios2/include/asm/linkage.h
 delete mode 100644 arch/nios2/include/asm/mmu.h
 delete mode 100644 arch/nios2/include/asm/mmu_context.h
 delete mode 100644 arch/nios2/include/asm/page.h
 delete mode 100644 arch/nios2/include/asm/pgalloc.h
 delete mode 100644 arch/nios2/include/asm/pgtable-bits.h
 delete mode 100644 arch/nios2/include/asm/pgtable.h
 delete mode 100644 arch/nios2/include/asm/processor.h
 delete mode 100644 arch/nios2/include/asm/ptrace.h
 delete mode 100644 arch/nios2/include/asm/registers.h
 delete mode 100644 arch/nios2/include/asm/setup.h
 delete mode 100644 arch/nios2/include/asm/shmparam.h
 delete mode 100644 arch/nios2/include/asm/string.h
 delete mode 100644 arch/nios2/include/asm/swab.h
 delete mode 100644 arch/nios2/include/asm/switch_to.h
 delete mode 100644 arch/nios2/include/asm/syscall.h
 delete mode 100644 arch/nios2/include/asm/syscalls.h
 delete mode 100644 arch/nios2/include/asm/thread_info.h
 delete mode 100644 arch/nios2/include/asm/timex.h
 delete mode 100644 arch/nios2/include/asm/tlb.h
 delete mode 100644 arch/nios2/include/asm/tlbflush.h
 delete mode 100644 arch/nios2/include/asm/traps.h
 delete mode 100644 arch/nios2/include/asm/uaccess.h
 delete mode 100644 arch/nios2/include/asm/unistd.h
 delete mode 100644 arch/nios2/include/asm/vmalloc.h
 delete mode 100644 arch/nios2/include/uapi/asm/Kbuild
 delete mode 100644 arch/nios2/include/uapi/asm/byteorder.h
 delete mode 100644 arch/nios2/include/uapi/asm/elf.h
 delete mode 100644 arch/nios2/include/uapi/asm/ptrace.h
 delete mode 100644 arch/nios2/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/nios2/include/uapi/asm/signal.h
 delete mode 100644 arch/nios2/include/uapi/asm/unistd.h
 delete mode 100644 arch/nios2/kernel/.gitignore
 delete mode 100644 arch/nios2/kernel/Makefile
 delete mode 100644 arch/nios2/kernel/Makefile.syscalls
 delete mode 100644 arch/nios2/kernel/asm-offsets.c
 delete mode 100644 arch/nios2/kernel/cpuinfo.c
 delete mode 100644 arch/nios2/kernel/entry.S
 delete mode 100644 arch/nios2/kernel/head.S
 delete mode 100644 arch/nios2/kernel/insnemu.S
 delete mode 100644 arch/nios2/kernel/irq.c
 delete mode 100644 arch/nios2/kernel/kgdb.c
 delete mode 100644 arch/nios2/kernel/misaligned.c
 delete mode 100644 arch/nios2/kernel/module.c
 delete mode 100644 arch/nios2/kernel/nios2_ksyms.c
 delete mode 100644 arch/nios2/kernel/process.c
 delete mode 100644 arch/nios2/kernel/prom.c
 delete mode 100644 arch/nios2/kernel/ptrace.c
 delete mode 100644 arch/nios2/kernel/setup.c
 delete mode 100644 arch/nios2/kernel/signal.c
 delete mode 100644 arch/nios2/kernel/sys_nios2.c
 delete mode 100644 arch/nios2/kernel/syscall_table.c
 delete mode 100644 arch/nios2/kernel/time.c
 delete mode 100644 arch/nios2/kernel/traps.c
 delete mode 100644 arch/nios2/kernel/vmlinux.lds.S
 delete mode 100644 arch/nios2/lib/Makefile
 delete mode 100644 arch/nios2/lib/delay.c
 delete mode 100644 arch/nios2/lib/memcpy.c
 delete mode 100644 arch/nios2/lib/memmove.c
 delete mode 100644 arch/nios2/lib/memset.c
 delete mode 100644 arch/nios2/mm/Makefile
 delete mode 100644 arch/nios2/mm/cacheflush.c
 delete mode 100644 arch/nios2/mm/dma-mapping.c
 delete mode 100644 arch/nios2/mm/extable.c
 delete mode 100644 arch/nios2/mm/fault.c
 delete mode 100644 arch/nios2/mm/init.c
 delete mode 100644 arch/nios2/mm/ioremap.c
 delete mode 100644 arch/nios2/mm/mmu_context.c
 delete mode 100644 arch/nios2/mm/pgtable.c
 delete mode 100644 arch/nios2/mm/tlb.c
 delete mode 100644 arch/nios2/mm/uaccess.c
 delete mode 100644 arch/nios2/platform/Kconfig.platform
 delete mode 100644 arch/nios2/platform/Makefile
 delete mode 100644 arch/nios2/platform/platform.c
 delete mode 120000 scripts/dtc/include-prefixes/nios2

diff --git a/CREDITS b/CREDITS
index 17962bdd6dbd..51c0bd411841 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3038,6 +3038,10 @@ S: Zum Schiersteiner Grund 2
 S: 55127 Mainz
 S: Germany
 
+N: Dinh Nguyen
+E: dinguyen@kernel.org
+D: Altera Nios II architecture support
+
 N: Gustavo Niemeyer
 E: niemeyer@conectiva.com
 W: https://moin.conectiva.com.br/GustavoNiemeyer
diff --git a/Documentation/.renames.txt b/Documentation/.renames.txt
index 43d44753ab93..a558303d99df 100644
--- a/Documentation/.renames.txt
+++ b/Documentation/.renames.txt
@@ -846,9 +846,6 @@ networking/skfp networking/device_drivers/fddi/skfp
 nfc/index driver-api/nfc/index
 nfc/nfc-hci driver-api/nfc/nfc-hci
 nfc/nfc-pn544 driver-api/nfc/nfc-pn544
-nios2/features arch/nios2/features
-nios2/index arch/nios2/index
-nios2/nios2 arch/nios2/nios2
 nvdimm/btt driver-api/nvdimm/btt
 nvdimm/index driver-api/nvdimm/index
 nvdimm/nvdimm driver-api/nvdimm/nvdimm
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..175c270bfa60 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8333,8 +8333,8 @@ Kernel parameters
 			It can also be used to decrease the size and leave more room
 			for directly mapped kernel RAM. Note that this parameter does
 			not exist on many other platforms (including arm64, alpha,
-			loongarch, arc, csky, hexagon, microblaze, mips, nios2, openrisc,
-			parisc, m64k, powerpc, riscv, sh, um, xtensa, s390, sparc).
+			loongarch, arc, csky, hexagon, microblaze, mips, openrisc,
+			parisc, m68k, powerpc, riscv, sh, um, xtensa, s390, sparc).
 
 	vmcp_cma=nn[MG]	[KNL,S390,EARLY]
 			Sets the memory size reserved for contiguous memory
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 3f9962e45c09..f8c48b1be786 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -15,7 +15,6 @@ implementation.
    loongarch/index
    m68k/index
    mips/index
-   nios2/index
    openrisc/index
    parisc/index
    powerpc/index
diff --git a/Documentation/arch/nios2/features.rst b/Documentation/arch/nios2/features.rst
deleted file mode 100644
index 89913810ccb5..000000000000
--- a/Documentation/arch/nios2/features.rst
+++ /dev/null
@@ -1,3 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-.. kernel-feat:: features nios2
diff --git a/Documentation/arch/nios2/index.rst b/Documentation/arch/nios2/index.rst
deleted file mode 100644
index 4468fe1a1037..000000000000
--- a/Documentation/arch/nios2/index.rst
+++ /dev/null
@@ -1,12 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-==============================
-Nios II Specific Documentation
-==============================
-
-.. toctree::
-   :maxdepth: 2
-   :numbered:
-
-   nios2
-   features
diff --git a/Documentation/arch/nios2/nios2.rst b/Documentation/arch/nios2/nios2.rst
deleted file mode 100644
index 43da3f7cee76..000000000000
--- a/Documentation/arch/nios2/nios2.rst
+++ /dev/null
@@ -1,24 +0,0 @@
-=================================
-Linux on the Nios II architecture
-=================================
-
-This is a port of Linux to Nios II (nios2) processor.
-
-In order to compile for Nios II, you need a version of GCC with support for the generic
-system call ABI. Please see this link for more information on how compiling and booting
-software for the Nios II platform:
-http://www.rocketboards.org/foswiki/Documentation/NiosIILinuxUserManual
-
-For reference, please see the following link:
-http://www.altera.com/literature/lit-nio2.jsp
-
-What is Nios II?
-================
-Nios II is a 32-bit embedded-processor architecture designed specifically for the
-Altera family of FPGAs. In order to support Linux, Nios II needs to be configured
-with MMU and hardware multiplier enabled.
-
-Nios II ABI
-===========
-Please refer to chapter "Application Binary Interface" in Nios II Processor Reference
-Handbook.
diff --git a/Documentation/devicetree/bindings/nios2/nios2.txt b/Documentation/devicetree/bindings/nios2/nios2.txt
deleted file mode 100644
index 3e9cabe667b3..000000000000
--- a/Documentation/devicetree/bindings/nios2/nios2.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-* Nios II Processor Binding
-
-This binding specifies what properties available in the device tree
-representation of a Nios II Processor Core.
-
-Users can use sopc2dts tool for generating device tree sources (dts) from a
-Qsys system. See more detail in: http://www.alterawiki.com/wiki/Sopc2dts
-
-Required properties:
-
-- compatible: Compatible property value should be "altr,nios2-1.0".
-- reg: Contains CPU index.
-- interrupt-controller: Specifies that the node is an interrupt controller
-- #interrupt-cells: Specifies the number of cells needed to encode an
-		interrupt source, should be 1.
-- clock-frequency: Contains the clock frequency for CPU, in Hz.
-- dcache-line-size: Contains data cache line size.
-- icache-line-size: Contains instruction line size.
-- dcache-size: Contains data cache size.
-- icache-size: Contains instruction cache size.
-- altr,pid-num-bits: Specifies the number of bits to use to represent the process
-		identifier (PID).
-- altr,tlb-num-ways: Specifies the number of set-associativity ways in the TLB.
-- altr,tlb-num-entries: Specifies the number of entries in the TLB.
-- altr,tlb-ptr-sz: Specifies size of TLB pointer.
-- altr,has-mul: Specifies CPU hardware multiply support, should be 1.
-- altr,has-mmu: Specifies CPU support MMU support, should be 1.
-- altr,has-initda: Specifies CPU support initda instruction, should be 1.
-- altr,reset-addr: Specifies CPU reset address
-- altr,fast-tlb-miss-addr: Specifies CPU fast TLB miss exception address
-- altr,exception-addr: Specifies CPU exception address
-
-Optional properties:
-- altr,has-div: Specifies CPU hardware divide support
-- altr,implementation: Nios II core implementation, this should be "fast";
-
-Example:
-
-cpu@0 {
-	device_type = "cpu";
-	compatible = "altr,nios2-1.0";
-	reg = <0>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-	clock-frequency = <125000000>;
-	dcache-line-size = <32>;
-	icache-line-size = <32>;
-	dcache-size = <32768>;
-	icache-size = <32768>;
-	altr,implementation = "fast";
-	altr,pid-num-bits = <8>;
-	altr,tlb-num-ways = <16>;
-	altr,tlb-num-entries = <128>;
-	altr,tlb-ptr-sz = <7>;
-	altr,has-div = <1>;
-	altr,has-mul = <1>;
-	altr,reset-addr = <0xc2800000>;
-	altr,fast-tlb-miss-addr = <0xc7fff400>;
-	altr,exception-addr = <0xd0000020>;
-	altr,has-initda = <1>;
-	altr,has-mmu = <1>;
-};
diff --git a/Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml b/Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml
deleted file mode 100644
index 576260c72d42..000000000000
--- a/Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml
+++ /dev/null
@@ -1,39 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/altr,timer-1.0.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Altera Timer
-
-maintainers:
-  - Dinh Nguyen <dinguyen@kernel.org>
-
-properties:
-  compatible:
-    const: altr,timer-1.0
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  clock-frequency:
-    description: Frequency of the clock that drives the counter, in Hz.
-
-required:
-  - compatible
-  - reg
-  - interrupts
-
-additionalProperties: false
-
-examples:
-  - |
-    timer@400000 {
-        compatible = "altr,timer-1.0";
-        reg = <0x00400000 0x00000020>;
-        interrupts = <11>;
-        clock-frequency = <125000000>;
-    };
diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
index c6146c96ac56..a82aab5810f8 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -66,9 +66,8 @@ a dtb could be wrapped up with the kernel image to support booting
 existing non-DT aware firmware.
 
 Some time later, FDT infrastructure was generalized to be usable by
-all architectures.  At the time of this writing, 6 mainlined
-architectures (arm, microblaze, mips, powerpc, sparc, and x86) and 1
-out of mainline (nios) have some level of DT support.
+all architectures.  At the time of this writing, most mainlined
+architectures have some level of DT support.
 
 2. Data Model
 -------------
diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index 937840080de7..9d76c6a826f4 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index 83f77f55fc87..37a663920016 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 425442e31fa2..fdc3e264963c 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 683de7c15058..2497f0aad2c0 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
index fa85381acc43..eb11f9d8a980 100644
--- a/Documentation/features/core/mseal_sys_mappings/arch-support.txt
+++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: |  N/A |
     |  microblaze: |  N/A |
     |        mips: | TODO |
-    |       nios2: |  N/A |
     |    openrisc: |  N/A |
     |      parisc: | TODO |
     |     powerpc: | TODO |
diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
index f3d744c76061..fa9b166db084 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index 4f36fcbfb6d5..afabfa76da15 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 39c6e78c0cbe..a6dcc12332bf 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 156687a7436d..2ee360bda501 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 63494bddc263..3a067fb43811 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/kcov/arch-support.txt b/Documentation/features/debug/kcov/arch-support.txt
index 4449e1f55cd8..0d2fde86e715 100644
--- a/Documentation/features/debug/kcov/arch-support.txt
+++ b/Documentation/features/debug/kcov/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index f287f16ce0ec..bfbafc2ee947 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nios2: |  ok  |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/kmemleak/arch-support.txt b/Documentation/features/debug/kmemleak/arch-support.txt
index f45149cfa313..e1b247b747cd 100644
--- a/Documentation/features/debug/kmemleak/arch-support.txt
+++ b/Documentation/features/debug/kmemleak/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index d937b7a03575..3bc6d0c3669f 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 1ea27aedd098..2478cb2985c7 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 022be42e64f9..bb975ade2af5 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 92f5d0f444fa..82cddb130d87 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 43e49c71612e..1eec4cf8e63e 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 0c698003ce9c..cac65a5fc069 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 3e431767581d..0a841e9f09c5 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 3c6ce35d704f..9c2d84276cb2 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 2c3a4b91f16d..804b0f5fefc0 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index b6b00469f7d0..b1c74adb4778 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index b286a5fff283..7ab426d9cf74 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index cf26042480e2..ea133c345f28 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 75c05d348c01..eab8632cea6d 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 4c9a5a012075..999cc5563d7e 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index dd362b5cb638..638940bbe45b 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 7425d2b994a3..a965a280b5c3 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -55,7 +55,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 984601c7c479..5fd38f3bffd9 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
-    |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: |  ..  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index 9336bdfc125c..e52a85d41a8e 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: |  ok  |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index ccba965e8d07..01ec09f90387 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index d6100b226de5..f97a5cc45406 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 891be9f61903..c1eba469af2f 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 3d10075a8a8a..cf86d6252e6c 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ..  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 21f11d47ef72..967bf5a220d5 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 57406c0d5353..2fe7dabfa576 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index b4a5ce16940d..739aaa464c88 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: |  ok  |
-    |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index d222bd3ee749..bff180936db5 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
-    |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
     |     powerpc: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 2d6de7b04538..1ea53402be8f 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index c0a2d8f56046..5de301a402b9 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 3f777f8b67d5..ec5cfb290e84 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -16,7 +16,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 91fc88681b1e..7a19c318f2b9 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -262,7 +262,6 @@ following architectures no longer requires modifications to
  - csky
  - hexagon
  - loongarch
- - nios2
  - openrisc
  - riscv
 
diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
index 71186d9df7c9..c265d3710975 100644
--- a/Documentation/translations/zh_CN/arch/index.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -19,7 +19,6 @@ TODOList:
 
 * arm/index
 * m68k/index
-* nios2/index
 * powerpc/index
 * s390/index
 * sh/index
diff --git a/Documentation/translations/zh_TW/arch/index.rst b/Documentation/translations/zh_TW/arch/index.rst
index 7c0490589465..4c5d2d2c08c3 100644
--- a/Documentation/translations/zh_TW/arch/index.rst
+++ b/Documentation/translations/zh_TW/arch/index.rst
@@ -18,7 +18,6 @@ TODOList:
 
 * arm/index
 * m68k/index
-* nios2/index
 * powerpc/index
 * s390/index
 * sh/index
diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d79275c6..b06f99a16c01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18939,12 +18939,6 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-nintendo*
 
-NIOS2 ARCHITECTURE
-M:	Dinh Nguyen <dinguyen@kernel.org>
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
-F:	arch/nios2/
-
 NITRO ENCLAVES (NE)
 M:	Alexandru Ciobotaru <alcioa@amazon.com>
 R:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
diff --git a/arch/nios2/Kbuild b/arch/nios2/Kbuild
deleted file mode 100644
index fa64c5954b20..000000000000
--- a/arch/nios2/Kbuild
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-obj-y += kernel/ mm/ platform/
-
-# for cleaning
-subdir- += boot
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
deleted file mode 100644
index 9c0e6eaeb005..000000000000
--- a/arch/nios2/Kconfig
+++ /dev/null
@@ -1,182 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config NIOS2
-	def_bool y
-	select ARCH_32BIT_OFF_T
-	select ARCH_HAS_CPU_CACHE_ALIASING
-	select ARCH_HAS_DMA_PREP_COHERENT
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_DMA_SET_UNCACHED
-	select ARCH_NO_SWAP
-	select COMMON_CLK
-	select TIMER_OF
-	select GENERIC_ATOMIC64
-	select GENERIC_CPU_DEVICES
-	select GENERIC_IRQ_PROBE
-	select GENERIC_IRQ_SHOW
-	select HAVE_ARCH_TRACEHOOK
-	select HAVE_ARCH_KGDB
-	select HAVE_PAGE_SIZE_4KB
-	select IRQ_DOMAIN
-	select LOCK_MM_AND_FIND_VMA
-	select MODULES_USE_ELF_RELA
-	select OF
-	select OF_EARLY_FLATTREE
-	select SOC_BUS
-	select SPARSE_IRQ
-	select USB_ARCH_HAS_HCD if USB_SUPPORT
-	select CPU_NO_EFFICIENT_FFS
-	select MMU_GATHER_NO_RANGE if MMU
-
-config GENERIC_CSUM
-	def_bool y
-
-config GENERIC_HWEIGHT
-	def_bool y
-
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
-config NO_IOPORT_MAP
-	def_bool y
-
-config FPU
-	def_bool n
-
-menu "Kernel features"
-
-source "kernel/Kconfig.hz"
-
-config ARCH_FORCE_MAX_ORDER
-	int "Order of maximal physically contiguous allocations"
-	default "10"
-	help
-	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
-	  defines the maximal power of two of number of pages that can be
-	  allocated as a single contiguous block. This option allows
-	  overriding the default setting when ability to allocate very
-	  large blocks of physically contiguous memory is required.
-
-	  Don't change if unsure.
-
-endmenu
-
-source "arch/nios2/platform/Kconfig.platform"
-
-menu "Processor type and features"
-
-config MMU
-	def_bool y
-
-config NR_CPUS
-	int
-	default "1"
-
-config NIOS2_ALIGNMENT_TRAP
-	bool "Catch alignment trap"
-	default y
-	help
-	  Nios II CPUs cannot fetch/store data which is not bus aligned,
-	  i.e., a 2 or 4 byte fetch must start at an address divisible by
-	  2 or 4. Any non-aligned load/store instructions will be trapped and
-	  emulated in software if you say Y here, which has a performance
-	  impact.
-
-comment "Boot options"
-
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-	default y
-
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	depends on CMDLINE_BOOL
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  other cases you can specify kernel args so that you don't have
-	  to set them up in board prom initialization routines.
-
-config CMDLINE_FORCE
-	bool "Force default kernel command string"
-	depends on CMDLINE_BOOL
-	help
-	  Set this to have arguments from the default kernel command string
-	  override those passed by the boot loader.
-
-config NIOS2_CMDLINE_IGNORE_DTB
-	bool "Ignore kernel command string from DTB"
-	depends on CMDLINE_BOOL
-	depends on !CMDLINE_FORCE
-	default y
-	help
-	  Set this to ignore the bootargs property from the devicetree's
-	  chosen node and fall back to CMDLINE if nothing is passed.
-
-config NIOS2_PASS_CMDLINE
-	bool "Passed kernel command line from u-boot"
-	help
-	  Use bootargs env variable from u-boot for kernel command line.
-	  will override "Default kernel command string".
-	  Say N if you are unsure.
-
-config NIOS2_BOOT_LINK_OFFSET
-	hex "Link address offset for booting"
-	default "0x00500000"
-	help
-	  This option allows you to set the link address offset of the zImage.
-	  This can be useful if you are on a board which has a small amount of
-	  memory.
-
-endmenu
-
-menu "Advanced setup"
-
-config ADVANCED_OPTIONS
-	bool "Prompt for advanced kernel configuration options"
-
-comment "Default settings for advanced configuration options are used"
-	depends on !ADVANCED_OPTIONS
-
-config NIOS2_KERNEL_MMU_REGION_BASE_BOOL
-	bool "Set custom kernel MMU region base address"
-	depends on ADVANCED_OPTIONS
-	help
-	  This option allows you to set the virtual address of the kernel MMU region.
-
-	  Say N here unless you know what you are doing.
-
-config NIOS2_KERNEL_MMU_REGION_BASE
-	hex "Virtual base address of the kernel MMU region " if NIOS2_KERNEL_MMU_REGION_BASE_BOOL
-	default "0x80000000"
-	help
-	  This option allows you to set the virtual base address of the kernel MMU region.
-
-config NIOS2_KERNEL_REGION_BASE_BOOL
-	bool "Set custom kernel region base address"
-	depends on ADVANCED_OPTIONS
-	help
-	  This option allows you to set the virtual address of the kernel region.
-
-	  Say N here unless you know what you are doing.
-
-config NIOS2_KERNEL_REGION_BASE
-	hex "Virtual base address of the kernel region " if NIOS2_KERNEL_REGION_BASE_BOOL
-	default "0xc0000000"
-
-config NIOS2_IO_REGION_BASE_BOOL
-	bool "Set custom I/O region base address"
-	depends on ADVANCED_OPTIONS
-	help
-	  This option allows you to set the virtual address of the I/O region.
-
-	  Say N here unless you know what you are doing.
-
-config NIOS2_IO_REGION_BASE
-	hex "Virtual base address of the I/O region" if NIOS2_IO_REGION_BASE_BOOL
-	default "0xe0000000"
-
-endmenu
diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
deleted file mode 100644
index ca1beb87f987..000000000000
--- a/arch/nios2/Kconfig.debug
+++ /dev/null
@@ -1,12 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-config EARLY_PRINTK
-	bool "Activate early kernel debugging"
-	default y
-	depends on TTY
-	select SERIAL_CORE_CONSOLE
-	help
-	  Enable early printk on console.
-	  This is useful for kernel debugging when your machine crashes very
-	  early before the console code is initialized.
-	  You should normally say N here, unless you want to debug such a crash.
diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
deleted file mode 100644
index f1ff4ce0f1a2..000000000000
--- a/arch/nios2/Makefile
+++ /dev/null
@@ -1,62 +0,0 @@
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 2013 Altera Corporation
-# Copyright (C) 1994, 95, 96, 2003 by Wind River Systems
-# Written by Fredrik Markstrom
-#
-# This file is included by the global makefile so that you can add your own
-# architecture-specific flags and dependencies.
-#
-# Nios2 port by Wind River Systems Inc trough:
-#   fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
-
-KBUILD_DEFCONFIG := 3c120_defconfig
-
-UTS_SYSNAME = Linux
-
-export MMU
-
-LIBGCC         := $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
-
-KBUILD_AFLAGS += -march=r$(CONFIG_NIOS2_ARCH_REVISION)
-
-KBUILD_CFLAGS += -pipe -D__linux__ -D__ELF__
-KBUILD_CFLAGS += -march=r$(CONFIG_NIOS2_ARCH_REVISION)
-KBUILD_CFLAGS += $(if $(CONFIG_NIOS2_HW_MUL_SUPPORT),-mhw-mul,-mno-hw-mul)
-KBUILD_CFLAGS += $(if $(CONFIG_NIOS2_HW_MULX_SUPPORT),-mhw-mulx,-mno-hw-mulx)
-KBUILD_CFLAGS += $(if $(CONFIG_NIOS2_HW_DIV_SUPPORT),-mhw-div,-mno-hw-div)
-KBUILD_CFLAGS += $(if $(CONFIG_NIOS2_BMX_SUPPORT),-mbmx,-mno-bmx)
-KBUILD_CFLAGS += $(if $(CONFIG_NIOS2_CDX_SUPPORT),-mcdx,-mno-cdx)
-KBUILD_CFLAGS += $(if $(CONFIG_NIOS2_FPU_SUPPORT),-mcustom-fpu-cfg=60-1,)
-
-KBUILD_CFLAGS += -fno-optimize-sibling-calls
-KBUILD_CFLAGS += -DUTS_SYSNAME=\"$(UTS_SYSNAME)\"
-KBUILD_CFLAGS += -fno-builtin
-KBUILD_CFLAGS += -G 0
-
-libs-y		+= arch/nios2/lib/ $(LIBGCC)
-
-INSTALL_PATH ?= /tftpboot
-nios2-boot := arch/$(ARCH)/boot
-BOOT_TARGETS = vmImage zImage
-PHONY += $(BOOT_TARGETS) install
-KBUILD_IMAGE := $(nios2-boot)/vmImage
-
-all: vmImage
-
-$(BOOT_TARGETS): vmlinux
-	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
-
-install:
-	$(call cmd,install)
-
-define archhelp
-  echo  '* vmImage         - Kernel-only image for U-Boot ($(KBUILD_IMAGE))'
-  echo  '  install         - Install kernel using'
-  echo  '                     (your) ~/bin/$(INSTALLKERNEL) or'
-  echo  '                     (distribution) /sbin/$(INSTALLKERNEL) or'
-  echo  '                     install to $$(INSTALL_PATH)'
-endef
diff --git a/arch/nios2/boot/.gitignore b/arch/nios2/boot/.gitignore
deleted file mode 100644
index ef37cac5bcc0..000000000000
--- a/arch/nios2/boot/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-vmImage
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
deleted file mode 100644
index 29c11a06b750..000000000000
--- a/arch/nios2/boot/Makefile
+++ /dev/null
@@ -1,32 +0,0 @@
-#
-# arch/nios2/boot/Makefile
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-
-UIMAGE_LOADADDR = $(shell $(NM) vmlinux | awk '$$NF == "_stext" {print $$1}')
-UIMAGE_ENTRYADDR = $(shell $(NM) vmlinux | awk '$$NF == "_start" {print $$1}')
-UIMAGE_COMPRESSION = gzip
-
-OBJCOPYFLAGS_vmlinux.bin := -O binary
-
-targets += vmlinux.bin vmlinux.gz vmImage
-
-$(obj)/vmlinux.bin: vmlinux FORCE
-	$(call if_changed,objcopy)
-
-$(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
-
-$(obj)/vmImage: $(obj)/vmlinux.gz FORCE
-	$(call if_changed,uimage)
-	@$(kecho) 'Kernel: $@ is ready'
-
-$(obj)/zImage: $(obj)/compressed/vmlinux FORCE
-	$(call if_changed,objcopy)
-	@$(kecho) 'Kernel: $@ is ready'
-
-$(obj)/compressed/vmlinux: $(obj)/vmlinux.gz FORCE
-	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
diff --git a/arch/nios2/boot/compressed/Makefile b/arch/nios2/boot/compressed/Makefile
deleted file mode 100644
index 791e4309250a..000000000000
--- a/arch/nios2/boot/compressed/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# create a compressed vmlinux image from the original vmlinux
-#
-
-targets		:= vmlinux head.o misc.o piggy.o vmlinux.lds
-asflags-y	:=
-
-OBJECTS = $(obj)/head.o $(obj)/misc.o
-
-LDFLAGS_vmlinux := -T
-
-$(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o FORCE
-	$(call if_changed,ld)
-
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-littlenios2 -T
-
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/../vmlinux.gz FORCE
-	$(call if_changed,ld)
diff --git a/arch/nios2/boot/compressed/console.c b/arch/nios2/boot/compressed/console.c
deleted file mode 100644
index 2cb2e7c9f0f4..000000000000
--- a/arch/nios2/boot/compressed/console.c
+++ /dev/null
@@ -1,112 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Copyright (C) 2008-2010 Thomas Chou <thomas@wytron.com.tw>
- */
-
-#include <linux/io.h>
-
-#if (defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE) && defined(JTAG_UART_BASE))\
-	|| (defined(CONFIG_SERIAL_ALTERA_UART_CONSOLE) && defined(UART0_BASE))
-static void *my_ioremap(unsigned long physaddr)
-{
-	return (void *)(physaddr | CONFIG_NIOS2_IO_REGION_BASE);
-}
-#endif
-
-#if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE) && defined(JTAG_UART_BASE)
-
-#define ALTERA_JTAGUART_SIZE				8
-#define ALTERA_JTAGUART_DATA_REG			0
-#define ALTERA_JTAGUART_CONTROL_REG			4
-#define ALTERA_JTAGUART_CONTROL_AC_MSK			(0x00000400)
-#define ALTERA_JTAGUART_CONTROL_WSPACE_MSK		(0xFFFF0000)
-static void *uartbase;
-
-#if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
-static void jtag_putc(int ch)
-{
-	if (readl(uartbase + ALTERA_JTAGUART_CONTROL_REG) &
-		ALTERA_JTAGUART_CONTROL_WSPACE_MSK)
-		writeb(ch, uartbase + ALTERA_JTAGUART_DATA_REG);
-}
-#else
-static void jtag_putc(int ch)
-{
-	while ((readl(uartbase + ALTERA_JTAGUART_CONTROL_REG) &
-		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) == 0)
-		;
-	writeb(ch, uartbase + ALTERA_JTAGUART_DATA_REG);
-}
-#endif
-
-static int putchar(int ch)
-{
-	jtag_putc(ch);
-	return ch;
-}
-
-static void console_init(void)
-{
-	uartbase = my_ioremap((unsigned long) JTAG_UART_BASE);
-	writel(ALTERA_JTAGUART_CONTROL_AC_MSK,
-		uartbase + ALTERA_JTAGUART_CONTROL_REG);
-}
-
-#elif defined(CONFIG_SERIAL_ALTERA_UART_CONSOLE) && defined(UART0_BASE)
-
-#define ALTERA_UART_SIZE		32
-#define ALTERA_UART_TXDATA_REG		4
-#define ALTERA_UART_STATUS_REG		8
-#define ALTERA_UART_DIVISOR_REG		16
-#define ALTERA_UART_STATUS_TRDY_MSK	(0x40)
-static unsigned uartbase;
-
-static void uart_putc(int ch)
-{
-	int i;
-
-	for (i = 0; (i < 0x10000); i++) {
-		if (readw(uartbase + ALTERA_UART_STATUS_REG) &
-			ALTERA_UART_STATUS_TRDY_MSK)
-			break;
-	}
-	writeb(ch, uartbase + ALTERA_UART_TXDATA_REG);
-}
-
-static int putchar(int ch)
-{
-	uart_putc(ch);
-	if (ch == '\n')
-		uart_putc('\r');
-	return ch;
-}
-
-static void console_init(void)
-{
-	unsigned int baud, baudclk;
-
-	uartbase = (unsigned long) my_ioremap((unsigned long) UART0_BASE);
-	baud = CONFIG_SERIAL_ALTERA_UART_BAUDRATE;
-	baudclk = UART0_FREQ / baud;
-	writew(baudclk, uartbase + ALTERA_UART_DIVISOR_REG);
-}
-
-#else
-
-static int putchar(int ch)
-{
-	return ch;
-}
-
-static void console_init(void)
-{
-}
-
-#endif
-
-static int puts(const char *s)
-{
-	while (*s)
-		putchar(*s++);
-	return 0;
-}
diff --git a/arch/nios2/boot/compressed/head.S b/arch/nios2/boot/compressed/head.S
deleted file mode 100644
index 15c6c48dd909..000000000000
--- a/arch/nios2/boot/compressed/head.S
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
- *
- * Based on arch/nios2/kernel/head.S
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- */
-
-/*
- *  This code can be loaded anywhere, eg FLASH ROM as reset vector,
- *  as long as output does not overlap it.
- */
-
-#include <linux/linkage.h>
-#include <asm/cache.h>
-
-	.text
-	.set noat
-ENTRY(_start)
-	wrctl	status, r0		/* disable interrupt */
-	/* invalidate all instruction cache */
-	movia	r1, NIOS2_ICACHE_SIZE
-	movui	r2, NIOS2_ICACHE_LINE_SIZE
-1:	initi	r1
-	sub	r1, r1, r2
-	bgt	r1, r0, 1b
-	/* invalidate all data cache */
-	movia	r1, NIOS2_DCACHE_SIZE
-	movui	r2, NIOS2_DCACHE_LINE_SIZE
-1:	initd	0(r1)
-	sub	r1, r1, r2
-	bgt	r1, r0, 1b
-
-	nextpc	r1			/* Find out where we are */
-chkadr:
-	movia	r2, chkadr
-	beq	r1, r2, finish_move	/* We are running in correct address,
-					   done */
-	/* move code, r1: src, r2: dest, r3: last dest */
-	addi	r1, r1, (_start - chkadr)	/* Source */
-	movia	r2, _start		/* Destination */
-	movia	r3, __bss_start		/* End of copy */
-1:	ldw	r8, 0(r1)		/* load a word from [r1] */
-	stw	r8, 0(r2)		/* stort a word to dest [r2] */
-	addi	r1, r1, 4		/* inc the src addr */
-	addi	r2, r2, 4		/* inc the dest addr */
-	blt	r2, r3, 1b
-	/* flush the data cache after moving */
-	movia	r1, NIOS2_DCACHE_SIZE
-	movui	r2, NIOS2_DCACHE_LINE_SIZE
-1:	flushd	0(r1)
-	sub	r1, r1, r2
-	bgt	r1, r0, 1b
-	movia	r1, finish_move
-	jmp	r1			/* jmp to linked address */
-
-finish_move:
-	/* zero out the .bss segment (uninitialized common data) */
-	movia	r2, __bss_start		/* presume nothing is between */
-	movia	r1, _end		/* the .bss and _end. */
-1: 	stb	r0, 0(r2)
-	addi	r2, r2, 1
-	bne	r1, r2, 1b
-	/*
-	 * set up the stack pointer, some where higher than _end.
-	 * The stack space must be greater than 32K for decompress.
-	 */
-	movia	sp, 0x10000
-	add	sp, sp, r1
-	/* save args passed from u-boot, maybe */
-	addi	sp, sp, -16
-	stw	r4, 0(sp)
-	stw	r5, 4(sp)
-	stw	r6, 8(sp)
-	stw	r7, 12(sp)
-	/* decompress the kernel */
-	call	decompress_kernel
-	/* pass saved args to kernel */
-	ldw	r4, 0(sp)
-	ldw	r5, 4(sp)
-	ldw	r6, 8(sp)
-	ldw	r7, 12(sp)
-
-	/* flush all data cache after decompressing */
-	movia	r1, NIOS2_DCACHE_SIZE
-	movui	r2, NIOS2_DCACHE_LINE_SIZE
-1:	flushd	0(r1)
-	sub	r1, r1, r2
-	bgt	r1, r0, 1b
-	/* flush all instruction cache */
-	movia	r1, NIOS2_ICACHE_SIZE
-	movui	r2, NIOS2_ICACHE_LINE_SIZE
-1:	flushi	r1
-	sub	r1, r1, r2
-	bgt	r1, r0, 1b
-	flushp
-	/* jump to start real kernel */
-	movia	r1, (CONFIG_NIOS2_MEM_BASE | CONFIG_NIOS2_KERNEL_REGION_BASE)
-	jmp	r1
-
-	.balign 512
-fake_headers_as_bzImage:
-	.short	0
-	.ascii	"HdrS"
-	.short	0x0202
-	.short	0
-	.short	0
-	.byte	0x00, 0x10
-	.short	0
-	.byte	0
-	.byte	1
-	.byte	0x00, 0x80
-	.long	0
-	.long	0
diff --git a/arch/nios2/boot/compressed/misc.c b/arch/nios2/boot/compressed/misc.c
deleted file mode 100644
index 42fc4bbe18bb..000000000000
--- a/arch/nios2/boot/compressed/misc.c
+++ /dev/null
@@ -1,174 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
- *
- * This is a collection of several routines from gzip-1.0.3
- * adapted for Linux.
- *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
- * Adapted for SH by Stuart Menefy, Aug 1999
- *
- * Modified to use standard LinuxSH BIOS by Greg Banks 7Jul2000
- *
- * Based on arch/sh/boot/compressed/misc.c
- */
-
-#include <linux/string.h>
-
-/*
- * gzip declarations
- */
-#define OF(args)  args
-#define STATIC static
-
-#undef memset
-#undef memcpy
-#define memzero(s, n)		memset((s), 0, (n))
-
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch *inbuf;		/* input buffer */
-static uch window[WSIZE];	/* Sliding window buffer */
-
-static unsigned insize;	/* valid bytes in inbuf */
-static unsigned inptr;	/* index of next byte to be processed in inbuf */
-static unsigned outcnt;	/* bytes in output buffer */
-
-/* gzip flag byte */
-#define ASCII_FLAG	0x01 /* bit 0 set: file probably ASCII text */
-#define CONTINUATION	0x02 /* bit 1 set: continuation of multi-part gzip
-				file */
-#define EXTRA_FIELD	0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME	0x08 /* bit 3 set: original file name present */
-#define COMMENT		0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED	0x20 /* bit 5 set: file is encrypted */
-#define RESERVED	0xC0 /* bit 6,7:   reserved */
-
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-#ifdef DEBUG
-#  define Assert(cond, msg) {if (!(cond)) error(msg); }
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ; }
-#  define Tracevv(x) {if (verbose > 1) fprintf x ; }
-#  define Tracec(c, x) {if (verbose && (c)) fprintf x ; }
-#  define Tracecv(c, x) {if (verbose > 1 && (c)) fprintf x ; }
-#else
-#  define Assert(cond, msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c, x)
-#  define Tracecv(c, x)
-#endif
-static int  fill_inbuf(void);
-static void flush_window(void);
-static void error(char *m);
-
-extern char input_data[];
-extern int input_len;
-
-static long bytes_out;
-static uch *output_data;
-static unsigned long output_ptr;
-
-#include "console.c"
-
-static void error(char *m);
-
-int puts(const char *);
-
-extern int _end;
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
-
-#define HEAP_SIZE			0x10000
-
-#include "../../../../lib/inflate.c"
-
-void *memset(void *s, int c, size_t n)
-{
-	int i;
-	char *ss = (char *)s;
-
-	for (i = 0; i < n; i++)
-		ss[i] = c;
-	return s;
-}
-
-void *memcpy(void *__dest, __const void *__src, size_t __n)
-{
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
-
-	for (i = 0; i < __n; i++)
-		d[i] = s[i];
-	return __dest;
-}
-
-/*
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-static int fill_inbuf(void)
-{
-	if (insize != 0)
-		error("ran out of input data");
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
-}
-
-/*
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
- * (Used for the decompressed data only.)
- */
-static void flush_window(void)
-{
-	ulg c = crc;	/* temporary variable */
-	unsigned n;
-	uch *in, *out, ch;
-
-	in = window;
-	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++) {
-		ch = *out++ = *in++;
-		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-	}
-	crc = c;
-	bytes_out += (ulg)outcnt;
-	output_ptr += (ulg)outcnt;
-	outcnt = 0;
-}
-
-static void error(char *x)
-{
-	puts("\nERROR\n");
-	puts(x);
-	puts("\n\n -- System halted");
-
-	while (1)	/* Halt */
-		;
-}
-
-void decompress_kernel(void)
-{
-	output_data = (void *) (CONFIG_NIOS2_MEM_BASE |
-				CONFIG_NIOS2_KERNEL_REGION_BASE);
-	output_ptr = 0;
-	free_mem_ptr = (unsigned long)&_end;
-	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
-
-	console_init();
-	makecrc();
-	puts("Uncompressing Linux... ");
-	gunzip();
-	puts("Ok, booting the kernel.\n");
-}
diff --git a/arch/nios2/boot/compressed/vmlinux.lds.S b/arch/nios2/boot/compressed/vmlinux.lds.S
deleted file mode 100644
index 9b02d0c97237..000000000000
--- a/arch/nios2/boot/compressed/vmlinux.lds.S
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
- */
-
-#include <asm-generic/vmlinux.lds.h>
-
-OUTPUT_FORMAT("elf32-littlenios2", "elf32-littlenios2", "elf32-littlenios2")
-
-OUTPUT_ARCH(nios)
-ENTRY(_start)	/* Defined in head.S */
-
-SECTIONS
-{
-	. = (CONFIG_NIOS2_MEM_BASE + CONFIG_NIOS2_BOOT_LINK_OFFSET) |	\
-		CONFIG_NIOS2_KERNEL_REGION_BASE;
-
-	_text = .;
-	.text : { *(.text) } = 0
-	.rodata : { *(.rodata) *(.rodata.*) }
-	_etext = .;
-
-	. = ALIGN(32 / 8);
-	.data : { *(.data) }
-	. = ALIGN(32 / 8);
-	_got = .;
-	.got : {
-		*(.got.plt)
-		*(.igot.plt)
-		*(.got)
-		*(.igot)
-	}
-	_egot = .;
-	_edata =  .;
-
-	. = ALIGN(32 / 8);
-	__bss_start = .;
-	.bss : { *(.bss) *(.sbss) }
-	. = ALIGN(32 / 8);
-	_ebss = .;
-	end = . ;
-	_end = . ;
-
-	got_len = (_egot - _got);
-}
diff --git a/arch/nios2/boot/compressed/vmlinux.scr b/arch/nios2/boot/compressed/vmlinux.scr
deleted file mode 100644
index 28c42f1d127e..000000000000
--- a/arch/nios2/boot/compressed/vmlinux.scr
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-SECTIONS
-{
-	.data : {
-		input_len = .;
-		LONG(input_data_end - input_data) input_data = .;
-		*(.data)
-		. = ALIGN(4);
-		input_data_end = .;
-	}
-}
diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
deleted file mode 100644
index 0e7e5b0dd685..000000000000
--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ /dev/null
@@ -1,237 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2015 Altera Corporation. All rights reserved.
- */
-
-/dts-v1/;
-
-/ {
-	model = "Altera NiosII Max10";
-	compatible = "altr,niosii-max10";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu: cpu@0 {
-			device_type = "cpu";
-			compatible = "altr,nios2-1.1";
-			reg = <0x00000000>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			altr,exception-addr = <0xc8000120>;
-			altr,fast-tlb-miss-addr = <0xc0000100>;
-			altr,has-div = <1>;
-			altr,has-initda = <1>;
-			altr,has-mmu = <1>;
-			altr,has-mul = <1>;
-			altr,implementation = "fast";
-			altr,pid-num-bits = <8>;
-			altr,reset-addr = <0xd4000000>;
-			altr,tlb-num-entries = <256>;
-			altr,tlb-num-ways = <16>;
-			altr,tlb-ptr-sz = <8>;
-			clock-frequency = <75000000>;
-			dcache-line-size = <32>;
-			dcache-size = <32768>;
-			icache-line-size = <32>;
-			icache-size = <32768>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x08000000 0x08000000>,
-			<0x00000000 0x00000400>;
-	};
-
-	sopc0: sopc@0 {
-		device_type = "soc";
-		ranges;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "altr,avalon", "simple-bus";
-		bus-frequency = <75000000>;
-
-		jtag_uart: serial@18001530 {
-			compatible = "altr,juart-1.0";
-			reg = <0x18001530 0x00000008>;
-			interrupt-parent = <&cpu>;
-			interrupts = <7>;
-		};
-
-		a_16550_uart_0: serial@18001600 {
-			compatible = "altr,16550-FIFO32", "ns16550a";
-			reg = <0x18001600 0x00000200>;
-			interrupt-parent = <&cpu>;
-			interrupts = <1>;
-			auto-flow-control = <1>;
-			clock-frequency = <50000000>;
-			fifo-size = <32>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			tx-threshold = <16>;
-		};
-
-		sysid: sysid@18001528 {
-			compatible = "altr,sysid-1.0";
-			reg = <0x18001528 0x00000008>;
-			id = <4207856382>;
-			timestamp = <1431309290>;
-		};
-
-		rgmii_0_eth_tse_0: ethernet@400 {
-			compatible = "altr,tse-msgdma-1.0", "altr,tse-1.0";
-			reg = <0x00000400 0x00000400>,
-				<0x00000820 0x00000020>,
-				<0x00000800 0x00000020>,
-				<0x000008c0 0x00000008>,
-				<0x00000840 0x00000020>,
-				<0x00000860 0x00000020>;
-			reg-names = "control_port", "rx_csr", "rx_desc", "rx_resp", "tx_csr", "tx_desc";
-			interrupt-parent = <&cpu>;
-			interrupts = <2 3>;
-			interrupt-names = "rx_irq", "tx_irq";
-			rx-fifo-depth = <8192>;
-			tx-fifo-depth = <8192>;
-			address-bits = <48>;
-			max-frame-size = <1500>;
-			local-mac-address = [00 00 00 00 00 00];
-			altr,has-supplementary-unicast;
-			altr,enable-sup-addr = <1>;
-			altr,has-hash-multicast-filter;
-			altr,enable-hash = <1>;
-			phy-mode = "rgmii-id";
-			phy-handle = <&phy0>;
-			rgmii_0_eth_tse_0_mdio: mdio {
-				compatible = "altr,tse-mdio";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				phy0: ethernet-phy@0 {
-					reg = <0>;
-					device_type = "ethernet-phy";
-				};
-			};
-		};
-
-		enet_pll: clock@0 {
-			compatible = "altr,pll-1.0";
-			#clock-cells = <1>;
-
-			enet_pll_c0: enet_pll_c0 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <125000000>;
-				clock-output-names = "enet_pll-c0";
-			};
-
-			enet_pll_c1: enet_pll_c1 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <25000000>;
-				clock-output-names = "enet_pll-c1";
-			};
-
-			enet_pll_c2: enet_pll_c2 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <2500000>;
-				clock-output-names = "enet_pll-c2";
-			};
-		};
-
-		sys_pll: clock@1 {
-			compatible = "altr,pll-1.0";
-			#clock-cells = <1>;
-
-			sys_pll_c0: sys_pll_c0 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <100000000>;
-				clock-output-names = "sys_pll-c0";
-			};
-
-			sys_pll_c1: sys_pll_c1 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <50000000>;
-				clock-output-names = "sys_pll-c1";
-			};
-
-			sys_pll_c2: sys_pll_c2 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <75000000>;
-				clock-output-names = "sys_pll-c2";
-			};
-		};
-
-		sys_clk_timer: timer@18001440 {
-			compatible = "altr,timer-1.0";
-			reg = <0x18001440 0x00000020>;
-			interrupt-parent = <&cpu>;
-			interrupts = <0>;
-			clock-frequency = <75000000>;
-		};
-
-		led_pio: gpio@180014d0 {
-			compatible = "altr,pio-1.0";
-			reg = <0x180014d0 0x00000010>;
-			altr,ngpio = <4>;
-			#gpio-cells = <2>;
-			gpio-controller;
-		};
-
-		button_pio: gpio@180014c0 {
-			compatible = "altr,pio-1.0";
-			reg = <0x180014c0 0x00000010>;
-			interrupt-parent = <&cpu>;
-			interrupts = <6>;
-			altr,ngpio = <3>;
-			altr,interrupt-type = <2>;
-			edge_type = <1>;
-			level_trigger = <0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-		};
-
-		sys_clk_timer_1: timer@880 {
-			compatible = "altr,timer-1.0";
-			reg = <0x00000880 0x00000020>;
-			interrupt-parent = <&cpu>;
-			interrupts = <5>;
-			clock-frequency = <75000000>;
-		};
-
-		fpga_leds: leds {
-			compatible = "gpio-leds";
-
-			led_fpga0: fpga0 {
-				label = "fpga_led0";
-				gpios = <&led_pio 0 1>;
-			};
-
-			led_fpga1: fpga1 {
-				label = "fpga_led1";
-				gpios = <&led_pio 1 1>;
-			};
-
-			led_fpga2: fpga2 {
-				label = "fpga_led2";
-				gpios = <&led_pio 2 1>;
-			};
-
-			led_fpga3: fpga3 {
-				label = "fpga_led3";
-				gpios = <&led_pio 3 1>;
-			};
-		};
-	};
-
-	chosen {
-		bootargs = "debug earlycon console=ttyS0,115200";
-		stdout-path = &a_16550_uart_0;
-	};
-};
diff --git a/arch/nios2/boot/dts/3c120_devboard.dts b/arch/nios2/boot/dts/3c120_devboard.dts
deleted file mode 100644
index 3ee316906379..000000000000
--- a/arch/nios2/boot/dts/3c120_devboard.dts
+++ /dev/null
@@ -1,153 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Copyright (C) 2013 Altera Corporation
- *
- * This file is generated by sopc2dts.
- */
-
-/dts-v1/;
-
-/ {
-	model = "altr,qsys_ghrd_3c120";
-	compatible = "altr,qsys_ghrd_3c120";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu: cpu@0 {
-			device_type = "cpu";
-			compatible = "altr,nios2-1.0";
-			reg = <0x00000000>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			clock-frequency = <125000000>;
-			dcache-line-size = <32>;
-			icache-line-size = <32>;
-			dcache-size = <32768>;
-			icache-size = <32768>;
-			altr,implementation = "fast";
-			altr,pid-num-bits = <8>;
-			altr,tlb-num-ways = <16>;
-			altr,tlb-num-entries = <128>;
-			altr,tlb-ptr-sz = <7>;
-			altr,has-div = <1>;
-			altr,has-mul = <1>;
-			altr,reset-addr = <0xc2800000>;
-			altr,fast-tlb-miss-addr = <0xc7fff400>;
-			altr,exception-addr = <0xd0000020>;
-			altr,has-initda = <1>;
-			altr,has-mmu = <1>;
-		};
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x10000000 0x08000000>,
-			<0x07fff400 0x00000400>;
-	};
-
-	sopc@0 {
-		device_type = "soc";
-		ranges;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "altr,avalon", "simple-bus";
-		bus-frequency = <125000000>;
-
-		pb_cpu_to_io: bridge@8000000 {
-			compatible = "simple-bus";
-			reg = <0x08000000 0x00800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x00002000 0x08002000 0x00002000>,
-				<0x00004000 0x08004000 0x00000400>,
-				<0x00004400 0x08004400 0x00000040>,
-				<0x00004800 0x08004800 0x00000040>,
-				<0x00004c80 0x08004c80 0x00000020>,
-				<0x00004d50 0x08004d50 0x00000008>,
-				<0x00008000 0x08008000 0x00000020>,
-				<0x00400000 0x08400000 0x00000020>;
-
-			timer_1ms: timer@400000 {
-				compatible = "altr,timer-1.0";
-				reg = <0x00400000 0x00000020>;
-				interrupt-parent = <&cpu>;
-				interrupts = <11>;
-				clock-frequency = <125000000>;
-			};
-
-			timer_0: timer@8000 {
-				compatible = "altr,timer-1.0";
-				reg = < 0x00008000 0x00000020 >;
-				interrupt-parent = < &cpu >;
-				interrupts = < 5 >;
-				clock-frequency = < 125000000 >;
-			};
-
-			jtag_uart: serial@4d50 {
-				compatible = "altr,juart-1.0";
-				reg = <0x00004d50 0x00000008>;
-				interrupt-parent = <&cpu>;
-				interrupts = <1>;
-			};
-
-			tse_mac: ethernet@4000 {
-				compatible = "altr,tse-1.0";
-				reg = <0x00004000 0x00000400>,
-					<0x00004400 0x00000040>,
-					<0x00004800 0x00000040>,
-					<0x00002000 0x00002000>;
-				reg-names = "control_port", "rx_csr", "tx_csr", "s1";
-				interrupt-parent = <&cpu>;
-				interrupts = <2 3>;
-				interrupt-names = "rx_irq", "tx_irq";
-				rx-fifo-depth = <8192>;
-				tx-fifo-depth = <8192>;
-				max-frame-size = <1500>;
-				local-mac-address = [ 00 00 00 00 00 00 ];
-				phy-mode = "rgmii-id";
-				phy-handle = <&phy0>;
-				tse_mac_mdio: mdio {
-					compatible = "altr,tse-mdio";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					phy0: ethernet-phy@18 {
-						reg = <18>;
-						device_type = "ethernet-phy";
-					};
-				};
-			};
-
-			uart: serial@4c80 {
-				compatible = "altr,uart-1.0";
-				reg = <0x00004c80 0x00000020>;
-				interrupt-parent = <&cpu>;
-				interrupts = <10>;
-				current-speed = <115200>;
-				clock-frequency = <62500000>;
-			};
-		};
-
-		cfi_flash_64m: flash@0 {
-			compatible = "cfi-flash";
-			reg = <0x00000000 0x04000000>;
-			bank-width = <2>;
-			device-width = <1>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@800000 {
-				reg = <0x00800000 0x01e00000>;
-				label = "JFFS2 Filesystem";
-			};
-		};
-	};
-
-	chosen {
-		bootargs = "debug earlycon console=ttyJ0,115200";
-		stdout-path = &jtag_uart;
-	};
-};
diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
deleted file mode 100644
index 1b8f41c4154f..000000000000
--- a/arch/nios2/boot/dts/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-dtb-y := $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
-
-dtb-$(CONFIG_OF_ALL_DTBS) += $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/nios2/boot/install.sh b/arch/nios2/boot/install.sh
deleted file mode 100755
index 1161f2bf59ec..000000000000
--- a/arch/nios2/boot/install.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for nios2 architecture
-#
-# Arguments:
-#   $1 - kernel version
-#   $2 - kernel image file
-#   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
-
-set -e
-
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
-fi
-
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
-fi
-
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
-
-sync
diff --git a/arch/nios2/configs/10m50_defconfig b/arch/nios2/configs/10m50_defconfig
deleted file mode 100644
index b7224f44d327..000000000000
--- a/arch/nios2/configs/10m50_defconfig
+++ /dev/null
@@ -1,75 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ_IDLE=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_ELF_CORE is not set
-# CONFIG_EPOLL is not set
-# CONFIG_SIGNALFD is not set
-# CONFIG_TIMERFD is not set
-# CONFIG_EVENTFD is not set
-# CONFIG_SHMEM is not set
-# CONFIG_AIO is not set
-CONFIG_EXPERT=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_NIOS2_MEM_BASE=0x8000000
-CONFIG_NIOS2_HW_MUL_SUPPORT=y
-CONFIG_NIOS2_HW_DIV_SUPPORT=y
-CONFIG_CUSTOM_CACHE_SETTINGS=y
-CONFIG_NIOS2_DCACHE_SIZE=0x8000
-CONFIG_NIOS2_ICACHE_SIZE=0x8000
-# CONFIG_NIOS2_CMDLINE_IGNORE_DTB is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_FW_LOADER is not set
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_NETDEVICES=y
-CONFIG_ALTERA_TSE=y
-CONFIG_MARVELL_PHY=y
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO_SERPORT is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_ALTERA_JTAGUART=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIOLIB=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_ALTERA=y
-# CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-# CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_ROOT_NFS=y
-CONFIG_SUNRPC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
diff --git a/arch/nios2/configs/3c120_defconfig b/arch/nios2/configs/3c120_defconfig
deleted file mode 100644
index 48fe353f8d2d..000000000000
--- a/arch/nios2/configs/3c120_defconfig
+++ /dev/null
@@ -1,73 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ_IDLE=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_ELF_CORE is not set
-# CONFIG_EPOLL is not set
-# CONFIG_SIGNALFD is not set
-# CONFIG_TIMERFD is not set
-# CONFIG_EVENTFD is not set
-# CONFIG_SHMEM is not set
-# CONFIG_AIO is not set
-CONFIG_EXPERT=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_NIOS2_MEM_BASE=0x10000000
-CONFIG_NIOS2_HW_MUL_SUPPORT=y
-CONFIG_NIOS2_HW_DIV_SUPPORT=y
-CONFIG_CUSTOM_CACHE_SETTINGS=y
-CONFIG_NIOS2_DCACHE_SIZE=0x8000
-CONFIG_NIOS2_ICACHE_SIZE=0x8000
-# CONFIG_NIOS2_CMDLINE_IGNORE_DTB is not set
-CONFIG_NIOS2_PASS_CMDLINE=y
-CONFIG_NIOS2_BOOT_LINK_OFFSET=0x00800000
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_FW_LOADER is not set
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_NETDEVICES=y
-CONFIG_ALTERA_TSE=y
-CONFIG_MARVELL_PHY=y
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO_SERPORT is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_ALTERA_JTAGUART=y
-CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
-CONFIG_SERIAL_ALTERA_UART=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-# CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_ROOT_NFS=y
-CONFIG_SUNRPC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
deleted file mode 100644
index 28004301c236..000000000000
--- a/arch/nios2/include/asm/Kbuild
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscall_table_32.h
-
-generic-y += cmpxchg.h
-generic-y += extable.h
-generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
-generic-y += spinlock.h
-generic-y += user.h
-generic-y += text-patching.h
diff --git a/arch/nios2/include/asm/asm-macros.h b/arch/nios2/include/asm/asm-macros.h
deleted file mode 100644
index 522e50a176b2..000000000000
--- a/arch/nios2/include/asm/asm-macros.h
+++ /dev/null
@@ -1,298 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Macro used to simplify coding multi-line assembler.
- * Some of the bit test macro can simplify down to one line
- * depending on the mask value.
- *
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * All rights reserved.
- */
-#ifndef _ASM_NIOS2_ASMMACROS_H
-#define _ASM_NIOS2_ASMMACROS_H
-/*
- * ANDs reg2 with mask and places the result in reg1.
- *
- * You cannnot use the same register for reg1 & reg2.
- */
-
-.macro ANDI32	reg1, reg2, mask
-.if \mask & 0xffff
-	.if \mask & 0xffff0000
-		movhi	\reg1, %hi(\mask)
-		movui	\reg1, %lo(\mask)
-		and	\reg1, \reg1, \reg2
-	.else
-		andi	\reg1, \reg2, %lo(\mask)
-	.endif
-.else
-	andhi	\reg1, \reg2, %hi(\mask)
-.endif
-.endm
-
-/*
- * ORs reg2 with mask and places the result in reg1.
- *
- * It is safe to use the same register for reg1 & reg2.
- */
-
-.macro ORI32	reg1, reg2, mask
-.if \mask & 0xffff
-	.if \mask & 0xffff0000
-		orhi	\reg1, \reg2, %hi(\mask)
-		ori	\reg1, \reg2, %lo(\mask)
-	.else
-		ori	\reg1, \reg2, %lo(\mask)
-	.endif
-.else
-	orhi	\reg1, \reg2, %hi(\mask)
-.endif
-.endm
-
-/*
- * XORs reg2 with mask and places the result in reg1.
- *
- * It is safe to use the same register for reg1 & reg2.
- */
-
-.macro XORI32	reg1, reg2, mask
-.if \mask & 0xffff
-	.if \mask & 0xffff0000
-		xorhi	\reg1, \reg2, %hi(\mask)
-		xori	\reg1, \reg1, %lo(\mask)
-	.else
-		xori	\reg1, \reg2, %lo(\mask)
-	.endif
-.else
-	xorhi	\reg1, \reg2, %hi(\mask)
-.endif
-.endm
-
-/*
- * This is a support macro for BTBZ & BTBNZ.  It checks
- * the bit to make sure it is valid 32 value.
- *
- * It is safe to use the same register for reg1 & reg2.
- */
-
-.macro BT	reg1, reg2, bit
-.if \bit > 31
-	.err
-.else
-	.if \bit < 16
-		andi	\reg1, \reg2, (1 << \bit)
-	.else
-		andhi	\reg1, \reg2, (1 << (\bit - 16))
-	.endif
-.endif
-.endm
-
-/*
- * Tests the bit in reg2 and branches to label if the
- * bit is zero.  The result of the bit test is stored in reg1.
- *
- * It is safe to use the same register for reg1 & reg2.
- */
-
-.macro BTBZ	reg1, reg2, bit, label
-	BT	\reg1, \reg2, \bit
-	beq	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bit in reg2 and branches to label if the
- * bit is non-zero.  The result of the bit test is stored in reg1.
- *
- * It is safe to use the same register for reg1 & reg2.
- */
-
-.macro BTBNZ	reg1, reg2, bit, label
-	BT	\reg1, \reg2, \bit
-	bne	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bit in reg2 and then compliments the bit in reg2.
- * The result of the bit test is stored in reg1.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTC	reg1, reg2, bit
-.if \bit > 31
-	.err
-.else
-	.if \bit < 16
-		andi	\reg1, \reg2, (1 << \bit)
-		xori	\reg2, \reg2, (1 << \bit)
-	.else
-		andhi	\reg1, \reg2, (1 << (\bit - 16))
-		xorhi	\reg2, \reg2, (1 << (\bit - 16))
-	.endif
-.endif
-.endm
-
-/*
- * Tests the bit in reg2 and then sets the bit in reg2.
- * The result of the bit test is stored in reg1.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTS	reg1, reg2, bit
-.if \bit > 31
-	.err
-.else
-	.if \bit < 16
-		andi	\reg1, \reg2, (1 << \bit)
-		ori	\reg2, \reg2, (1 << \bit)
-	.else
-		andhi	\reg1, \reg2, (1 << (\bit - 16))
-		orhi	\reg2, \reg2, (1 << (\bit - 16))
-	.endif
-.endif
-.endm
-
-/*
- * Tests the bit in reg2 and then resets the bit in reg2.
- * The result of the bit test is stored in reg1.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTR	reg1, reg2, bit
-.if \bit > 31
-	.err
-.else
-	.if \bit < 16
-		andi	\reg1, \reg2, (1 << \bit)
-		andi	\reg2, \reg2, %lo(~(1 << \bit))
-	.else
-		andhi	\reg1, \reg2, (1 << (\bit - 16))
-		andhi	\reg2, \reg2, %lo(~(1 << (\bit - 16)))
-	.endif
-.endif
-.endm
-
-/*
- * Tests the bit in reg2 and then compliments the bit in reg2.
- * The result of the bit test is stored in reg1.  If the
- * original bit was zero it branches to label.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTCBZ	reg1, reg2, bit, label
-	BTC	\reg1, \reg2, \bit
-	beq	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bit in reg2 and then compliments the bit in reg2.
- * The result of the bit test is stored in reg1.  If the
- * original bit was non-zero it branches to label.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTCBNZ	reg1, reg2, bit, label
-	BTC	\reg1, \reg2, \bit
-	bne	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bit in reg2 and then sets the bit in reg2.
- * The result of the bit test is stored in reg1.  If the
- * original bit was zero it branches to label.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTSBZ	reg1, reg2, bit, label
-	BTS	\reg1, \reg2, \bit
-	beq	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bit in reg2 and then sets the bit in reg2.
- * The result of the bit test is stored in reg1.  If the
- * original bit was non-zero it branches to label.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTSBNZ	reg1, reg2, bit, label
-	BTS	\reg1, \reg2, \bit
-	bne	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bit in reg2 and then resets the bit in reg2.
- * The result of the bit test is stored in reg1.  If the
- * original bit was zero it branches to label.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTRBZ	reg1, reg2, bit, label
-	BTR	\reg1, \reg2, \bit
-	bne	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bit in reg2 and then resets the bit in reg2.
- * The result of the bit test is stored in reg1.  If the
- * original bit was non-zero it branches to label.
- *
- * It is NOT safe to use the same register for reg1 & reg2.
- */
-
-.macro BTRBNZ	reg1, reg2, bit, label
-	BTR	\reg1, \reg2, \bit
-	bne	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bits in mask against reg2 stores the result in reg1.
- * If the all the bits in the mask are zero it branches to label.
- *
- * It is safe to use the same register for reg1 & reg2.
- */
-
-.macro TSTBZ	reg1, reg2, mask, label
-	ANDI32	\reg1, \reg2, \mask
-	beq	\reg1, r0, \label
-.endm
-
-/*
- * Tests the bits in mask against reg2 stores the result in reg1.
- * If the any of the bits in the mask are 1 it branches to label.
- *
- * It is safe to use the same register for reg1 & reg2.
- */
-
-.macro TSTBNZ	reg1, reg2, mask, label
-	ANDI32	\reg1, \reg2, \mask
-	bne	\reg1, r0, \label
-.endm
-
-/*
- * Pushes reg onto the stack.
- */
-
-.macro PUSH	reg
-	addi	sp, sp, -4
-	stw	\reg, 0(sp)
-.endm
-
-/*
- * Pops the top of the stack into reg.
- */
-
-.macro POP	reg
-	ldw	\reg, 0(sp)
-	addi	sp, sp, 4
-.endm
-
-
-#endif /* _ASM_NIOS2_ASMMACROS_H */
diff --git a/arch/nios2/include/asm/asm-offsets.h b/arch/nios2/include/asm/asm-offsets.h
deleted file mode 100644
index e51465213b53..000000000000
--- a/arch/nios2/include/asm/asm-offsets.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- *  Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
- */
-
-#include <generated/asm-offsets.h>
diff --git a/arch/nios2/include/asm/cache.h b/arch/nios2/include/asm/cache.h
deleted file mode 100644
index 43695f341f43..000000000000
--- a/arch/nios2/include/asm/cache.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * All rights reserved.
- */
-
-#ifndef _ASM_NIOS2_CACHE_H
-#define _ASM_NIOS2_CACHE_H
-
-#define NIOS2_DCACHE_SIZE	CONFIG_NIOS2_DCACHE_SIZE
-#define NIOS2_ICACHE_SIZE	CONFIG_NIOS2_ICACHE_SIZE
-#define NIOS2_DCACHE_LINE_SIZE	CONFIG_NIOS2_DCACHE_LINE_SIZE
-#define NIOS2_ICACHE_LINE_SHIFT	5
-#define NIOS2_ICACHE_LINE_SIZE	(1 << NIOS2_ICACHE_LINE_SHIFT)
-
-/* bytes per L1 cache line */
-#define L1_CACHE_SHIFT		NIOS2_ICACHE_LINE_SHIFT
-#define L1_CACHE_BYTES		NIOS2_ICACHE_LINE_SIZE
-
-#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
-
-#define __cacheline_aligned
-#define ____cacheline_aligned
-
-#endif
diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
deleted file mode 100644
index 81484a776b33..000000000000
--- a/arch/nios2/include/asm/cacheflush.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * Copyright (C) 2003 Microtronix Datacom Ltd.
- * Copyright (C) 2000-2002 Greg Ungerer <gerg@snapgear.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_CACHEFLUSH_H
-#define _ASM_NIOS2_CACHEFLUSH_H
-
-#include <linux/mm_types.h>
-
-/*
- * This flag is used to indicate that the page pointed to by a pte is clean
- * and does not require cleaning before returning it to the user.
- */
-#define PG_dcache_clean PG_arch_1
-
-struct mm_struct;
-
-extern void flush_cache_all(void);
-extern void flush_cache_mm(struct mm_struct *mm);
-extern void flush_cache_dup_mm(struct mm_struct *mm);
-extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end);
-extern void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
-	unsigned long pfn);
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
-#define flush_dcache_folio flush_dcache_folio
-
-extern void flush_icache_range(unsigned long start, unsigned long end);
-void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
-		unsigned int nr);
-#define flush_icache_pages flush_icache_pages
-
-#define flush_cache_vmap(start, end)		flush_dcache_range(start, end)
-#define flush_cache_vmap_early(start, end)	do { } while (0)
-#define flush_cache_vunmap(start, end)		flush_dcache_range(start, end)
-
-extern void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
-				unsigned long user_vaddr,
-				void *dst, void *src, int len);
-extern void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
-				unsigned long user_vaddr,
-				void *dst, void *src, int len);
-
-extern void flush_dcache_range(unsigned long start, unsigned long end);
-extern void invalidate_dcache_range(unsigned long start, unsigned long end);
-
-#define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
-#define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
-#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
-		xa_lock_irqsave(&mapping->i_pages, flags)
-#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
-		xa_unlock_irqrestore(&mapping->i_pages, flags)
-
-#endif /* _ASM_NIOS2_CACHEFLUSH_H */
diff --git a/arch/nios2/include/asm/cachetype.h b/arch/nios2/include/asm/cachetype.h
deleted file mode 100644
index eb9c416b8a1c..000000000000
--- a/arch/nios2/include/asm/cachetype.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_NIOS2_CACHETYPE_H
-#define __ASM_NIOS2_CACHETYPE_H
-
-#include <asm/page.h>
-#include <asm/cache.h>
-
-#define cpu_dcache_is_aliasing()	(NIOS2_DCACHE_SIZE > PAGE_SIZE)
-
-#endif
diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
deleted file mode 100644
index 69004e07a1ba..000000000000
--- a/arch/nios2/include/asm/checksum.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS_CHECKSUM_H
-#define _ASM_NIOS_CHECKSUM_H
-
-/* Take these from lib/checksum.c */
-extern __wsum csum_partial(const void *buff, int len, __wsum sum);
-extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
-extern __sum16 ip_compute_csum(const void *buff, int len);
-
-/*
- * Fold a partial checksum
- */
-static inline __sum16 csum_fold(__wsum sum)
-{
-	__asm__ __volatile__(
-		"add	%0, %1, %0\n"
-		"cmpltu	r8, %0, %1\n"
-		"srli	%0, %0, 16\n"
-		"add	%0, %0, r8\n"
-		"nor	%0, %0, %0\n"
-		: "=r" (sum)
-		: "r" (sum << 16), "0" (sum)
-		: "r8");
-	return (__force __sum16) sum;
-}
-
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-#define csum_tcpudp_nofold csum_tcpudp_nofold
-static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	__asm__ __volatile__(
-		"add	%0, %1, %0\n"
-		"cmpltu	r8, %0, %1\n"
-		"add	%0, %0, r8\n"	/* add carry */
-		"add	%0, %2, %0\n"
-		"cmpltu	r8, %0, %2\n"
-		"add	%0, %0, r8\n"	/* add carry */
-		"add	%0, %3, %0\n"
-		"cmpltu	r8, %0, %3\n"
-		"add	%0, %0, r8\n"	/* add carry */
-		: "=r" (sum), "=r" (saddr)
-		: "r" (daddr), "r" ((len + proto) << 8),
-		  "0" (sum),
-		  "1" (saddr)
-		: "r8");
-
-	return sum;
-}
-
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-
-#endif /* _ASM_NIOS_CHECKSUM_H */
diff --git a/arch/nios2/include/asm/cpuinfo.h b/arch/nios2/include/asm/cpuinfo.h
deleted file mode 100644
index 61349e003a14..000000000000
--- a/arch/nios2/include/asm/cpuinfo.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- */
-
-#ifndef _ASM_NIOS2_CPUINFO_H
-#define _ASM_NIOS2_CPUINFO_H
-
-#include <linux/types.h>
-
-struct cpuinfo {
-	/* Core CPU configuration */
-	char cpu_impl[12];
-	u32 cpu_clock_freq;
-	bool mmu;
-	bool has_div;
-	bool has_mul;
-	bool has_mulx;
-	bool has_bmx;
-	bool has_cdx;
-
-	/* CPU caches */
-	u32 icache_line_size;
-	u32 icache_size;
-	u32 dcache_line_size;
-	u32 dcache_size;
-
-	/* TLB */
-	u32 tlb_pid_num_bits;	/* number of bits used for the PID in TLBMISC */
-	u32 tlb_num_ways;
-	u32 tlb_num_ways_log2;
-	u32 tlb_num_entries;
-	u32 tlb_num_lines;
-	u32 tlb_ptr_sz;
-
-	/* Addresses */
-	u32 reset_addr;
-	u32 exception_addr;
-	u32 fast_tlb_miss_exc_addr;
-};
-
-extern struct cpuinfo cpuinfo;
-
-extern void setup_cpuinfo(void);
-
-#endif /* _ASM_NIOS2_CPUINFO_H */
diff --git a/arch/nios2/include/asm/delay.h b/arch/nios2/include/asm/delay.h
deleted file mode 100644
index 098e49bf3aa3..000000000000
--- a/arch/nios2/include/asm/delay.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) 2014 Altera Corporation
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_DELAY_H
-#define _ASM_NIOS2_DELAY_H
-
-#include <asm-generic/delay.h>
-
-/* Undefined functions to get compile-time errors */
-extern void __bad_udelay(void);
-extern void __bad_ndelay(void);
-
-extern unsigned long loops_per_jiffy;
-
-#endif /* _ASM_NIOS2_DELAY_H */
diff --git a/arch/nios2/include/asm/elf.h b/arch/nios2/include/asm/elf.h
deleted file mode 100644
index 984dd6de17c2..000000000000
--- a/arch/nios2/include/asm/elf.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- */
-
-#ifndef _ASM_NIOS2_ELF_H
-#define _ASM_NIOS2_ELF_H
-
-#include <uapi/asm/elf.h>
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) ((x)->e_machine == EM_ALTERA_NIOS2)
-
-#define ELF_PLAT_INIT(_r, load_addr)
-
-#define CORE_DUMP_USE_REGSET
-#define ELF_EXEC_PAGESIZE	4096
-
-/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-   use of this is to invoke "./ld.so someprog" to test out a new version of
-   the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-#define ELF_ET_DYN_BASE		0xD0000000UL
-
-/* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
-   now struct_user_regs, they are different) */
-
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES	1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp);
-#define ELF_CORE_COPY_REGS(pr_reg, regs)				\
-{ do {									\
-	/* Bleech. */							\
-	pr_reg[0]  = regs->r8;						\
-	pr_reg[1]  = regs->r9;						\
-	pr_reg[2]  = regs->r10;						\
-	pr_reg[3]  = regs->r11;						\
-	pr_reg[4]  = regs->r12;						\
-	pr_reg[5]  = regs->r13;						\
-	pr_reg[6]  = regs->r14;						\
-	pr_reg[7]  = regs->r15;						\
-	pr_reg[8]  = regs->r1;						\
-	pr_reg[9]  = regs->r2;						\
-	pr_reg[10] = regs->r3;						\
-	pr_reg[11] = regs->r4;						\
-	pr_reg[12] = regs->r5;						\
-	pr_reg[13] = regs->r6;						\
-	pr_reg[14] = regs->r7;						\
-	pr_reg[15] = regs->orig_r2;					\
-	pr_reg[16] = regs->ra;						\
-	pr_reg[17] = regs->fp;						\
-	pr_reg[18] = regs->sp;						\
-	pr_reg[19] = regs->gp;						\
-	pr_reg[20] = regs->estatus;					\
-	pr_reg[21] = regs->ea;						\
-	pr_reg[22] = regs->orig_r7;					\
-	{								\
-		struct switch_stack *sw = ((struct switch_stack *)regs) - 1; \
-		pr_reg[23] = sw->r16;					\
-		pr_reg[24] = sw->r17;					\
-		pr_reg[25] = sw->r18;					\
-		pr_reg[26] = sw->r19;					\
-		pr_reg[27] = sw->r20;					\
-		pr_reg[28] = sw->r21;					\
-		pr_reg[29] = sw->r22;					\
-		pr_reg[30] = sw->r23;					\
-		pr_reg[31] = sw->fp;					\
-		pr_reg[32] = sw->gp;					\
-		pr_reg[33] = sw->ra;					\
-	}								\
-} while (0); }
-
-/* This yields a mask that user programs can use to figure out what
-   instruction set this cpu supports.  */
-
-#define ELF_HWCAP	(0)
-
-/* This yields a string that ld.so will use to load implementation
-   specific libraries for optimization.  This is more specific in
-   intent than poking at uname or /proc/cpuinfo.  */
-
-#define ELF_PLATFORM  (NULL)
-
-#endif /* _ASM_NIOS2_ELF_H */
diff --git a/arch/nios2/include/asm/entry.h b/arch/nios2/include/asm/entry.h
deleted file mode 100644
index cb25ed56450a..000000000000
--- a/arch/nios2/include/asm/entry.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_ENTRY_H
-#define _ASM_NIOS2_ENTRY_H
-
-#ifdef __ASSEMBLER__
-
-#include <asm/processor.h>
-#include <asm/registers.h>
-#include <asm/asm-offsets.h>
-
-/*
- * Standard Nios2 interrupt entry and exit macros.
- * Must be called with interrupts disabled.
- */
-.macro SAVE_ALL
-	rdctl	r24, estatus
-	andi	r24, r24, ESTATUS_EU
-	beq	r24, r0, 1f /* In supervisor mode, already on kernel stack */
-
-	movia	r24, _current_thread	/* Switch to current kernel stack */
-	ldw	r24, 0(r24)		/* using the thread_info */
-	addi	r24, r24, THREAD_SIZE-PT_REGS_SIZE
-	stw	sp, PT_SP(r24)		/* Save user stack before changing */
-	mov	sp, r24
-	br	2f
-
-1 :	mov	r24, sp
-	addi	sp, sp, -PT_REGS_SIZE	/* Backup the kernel stack pointer */
-	stw	r24, PT_SP(sp)
-2 :	stw	r1, PT_R1(sp)
-	stw	r2, PT_R2(sp)
-	stw	r3, PT_R3(sp)
-	stw	r4, PT_R4(sp)
-	stw	r5, PT_R5(sp)
-	stw	r6, PT_R6(sp)
-	stw	r7, PT_R7(sp)
-	stw	r8, PT_R8(sp)
-	stw	r9, PT_R9(sp)
-	stw	r10, PT_R10(sp)
-	stw	r11, PT_R11(sp)
-	stw	r12, PT_R12(sp)
-	stw	r13, PT_R13(sp)
-	stw	r14, PT_R14(sp)
-	stw	r15, PT_R15(sp)
-	movi	r24, -1
-	stw	r24, PT_ORIG_R2(sp)
-	stw	r7, PT_ORIG_R7(sp)
-
-	stw	ra, PT_RA(sp)
-	stw	fp, PT_FP(sp)
-	stw	gp, PT_GP(sp)
-	rdctl	r24, estatus
-	stw	r24, PT_ESTATUS(sp)
-	stw	ea, PT_EA(sp)
-.endm
-
-.macro RESTORE_ALL
-	ldw	r1, PT_R1(sp)		/* Restore registers */
-	ldw	r2, PT_R2(sp)
-	ldw	r3, PT_R3(sp)
-	ldw	r4, PT_R4(sp)
-	ldw	r5, PT_R5(sp)
-	ldw	r6, PT_R6(sp)
-	ldw	r7, PT_R7(sp)
-	ldw	r8, PT_R8(sp)
-	ldw	r9, PT_R9(sp)
-	ldw	r10, PT_R10(sp)
-	ldw	r11, PT_R11(sp)
-	ldw	r12, PT_R12(sp)
-	ldw	r13, PT_R13(sp)
-	ldw	r14, PT_R14(sp)
-	ldw	r15, PT_R15(sp)
-	ldw	ra, PT_RA(sp)
-	ldw	fp, PT_FP(sp)
-	ldw	gp, PT_GP(sp)
-	ldw	r24, PT_ESTATUS(sp)
-	wrctl	estatus, r24
-	ldw	ea, PT_EA(sp)
-	ldw	sp, PT_SP(sp)		/* Restore sp last */
-.endm
-
-.macro	SAVE_SWITCH_STACK
-	addi	sp, sp, -SWITCH_STACK_SIZE
-	stw	r16, SW_R16(sp)
-	stw	r17, SW_R17(sp)
-	stw	r18, SW_R18(sp)
-	stw	r19, SW_R19(sp)
-	stw	r20, SW_R20(sp)
-	stw	r21, SW_R21(sp)
-	stw	r22, SW_R22(sp)
-	stw	r23, SW_R23(sp)
-	stw	fp, SW_FP(sp)
-	stw	gp, SW_GP(sp)
-	stw	ra, SW_RA(sp)
-.endm
-
-.macro	RESTORE_SWITCH_STACK
-	ldw	r16, SW_R16(sp)
-	ldw	r17, SW_R17(sp)
-	ldw	r18, SW_R18(sp)
-	ldw	r19, SW_R19(sp)
-	ldw	r20, SW_R20(sp)
-	ldw	r21, SW_R21(sp)
-	ldw	r22, SW_R22(sp)
-	ldw	r23, SW_R23(sp)
-	ldw	fp, SW_FP(sp)
-	ldw	gp, SW_GP(sp)
-	ldw	ra, SW_RA(sp)
-	addi	sp, sp, SWITCH_STACK_SIZE
-.endm
-
-#endif /* __ASSEMBLER__ */
-#endif /* _ASM_NIOS2_ENTRY_H */
diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
deleted file mode 100644
index 36e3550673b3..000000000000
--- a/arch/nios2/include/asm/io.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright (C) 2014 Altera Corporation
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_IO_H
-#define _ASM_NIOS2_IO_H
-
-#include <linux/types.h>
-#include <asm/pgtable-bits.h>
-
-/* PCI is not supported in nios2, set this to 0. */
-#define IO_SPACE_LIMIT 0
-
-#define readb_relaxed(addr)	readb(addr)
-#define readw_relaxed(addr)	readw(addr)
-#define readl_relaxed(addr)	readl(addr)
-
-#define writeb_relaxed(x, addr)	writeb(x, addr)
-#define writew_relaxed(x, addr)	writew(x, addr)
-#define writel_relaxed(x, addr)	writel(x, addr)
-
-void __iomem *ioremap(unsigned long physaddr, unsigned long size);
-void iounmap(void __iomem *addr);
-
-/* Macros used for converting between virtual and physical mappings. */
-#define phys_to_virt(vaddr)	\
-	((void *)((unsigned long)(vaddr) | CONFIG_NIOS2_KERNEL_REGION_BASE))
-/* Clear top 3 bits */
-#define virt_to_phys(vaddr)	\
-	((unsigned long)((unsigned long)(vaddr) & ~0xE0000000))
-
-#include <asm-generic/io.h>
-
-#endif /* _ASM_NIOS2_IO_H */
diff --git a/arch/nios2/include/asm/irq.h b/arch/nios2/include/asm/irq.h
deleted file mode 100644
index c52c94884e93..000000000000
--- a/arch/nios2/include/asm/irq.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- */
-
-#ifndef _ASM_NIOS2_IRQ_H
-#define _ASM_NIOS2_IRQ_H
-
-#define NIOS2_CPU_NR_IRQS	32
-
-#include <asm-generic/irq.h>
-
-#endif
diff --git a/arch/nios2/include/asm/irqflags.h b/arch/nios2/include/asm/irqflags.h
deleted file mode 100644
index 25acf27862f9..000000000000
--- a/arch/nios2/include/asm/irqflags.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2010 Thomas Chou <thomas@wytron.com.tw>
- */
-#ifndef _ASM_IRQFLAGS_H
-#define _ASM_IRQFLAGS_H
-
-#include <asm/registers.h>
-
-static inline unsigned long arch_local_save_flags(void)
-{
-	return RDCTL(CTL_FSTATUS);
-}
-
-/*
- * This will restore ALL status register flags, not only the interrupt
- * mask flag.
- */
-static inline void arch_local_irq_restore(unsigned long flags)
-{
-	WRCTL(CTL_FSTATUS, flags);
-}
-
-static inline void arch_local_irq_disable(void)
-{
-	unsigned long flags;
-
-	flags = arch_local_save_flags();
-	arch_local_irq_restore(flags & ~STATUS_PIE);
-}
-
-static inline void arch_local_irq_enable(void)
-{
-	unsigned long flags;
-
-	flags = arch_local_save_flags();
-	arch_local_irq_restore(flags | STATUS_PIE);
-}
-
-static inline int arch_irqs_disabled_flags(unsigned long flags)
-{
-	return (flags & STATUS_PIE) == 0;
-}
-
-static inline int arch_irqs_disabled(void)
-{
-	return arch_irqs_disabled_flags(arch_local_save_flags());
-}
-
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags;
-
-	flags = arch_local_save_flags();
-	arch_local_irq_restore(flags & ~STATUS_PIE);
-	return flags;
-}
-
-#endif /* _ASM_IRQFLAGS_H */
diff --git a/arch/nios2/include/asm/kgdb.h b/arch/nios2/include/asm/kgdb.h
deleted file mode 100644
index 1fe8a6b35ffb..000000000000
--- a/arch/nios2/include/asm/kgdb.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2015 Altera Corporation
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- *
- * Based on the code posted by Kazuyasu on the Altera Forum at:
- * http://www.alteraforum.com/forum/showpost.php?p=77003&postcount=20
- */
-
-#ifndef _ASM_NIOS2_KGDB_H
-#define _ASM_NIOS2_KGDB_H
-
-#define CACHE_FLUSH_IS_SAFE	1
-#define BUFMAX			2048
-
-enum regnames {
-	GDB_R0 = 0,
-	GDB_AT,
-	GDB_R2,
-	GDB_R3,
-	GDB_R4,
-	GDB_R5,
-	GDB_R6,
-	GDB_R7,
-	GDB_R8,
-	GDB_R9,
-	GDB_R10,
-	GDB_R11,
-	GDB_R12,
-	GDB_R13,
-	GDB_R14,
-	GDB_R15,
-	GDB_R16,
-	GDB_R17,
-	GDB_R18,
-	GDB_R19,
-	GDB_R20,
-	GDB_R21,
-	GDB_R22,
-	GDB_R23,
-	GDB_ET,
-	GDB_BT,
-	GDB_GP,
-	GDB_SP,
-	GDB_FP,
-	GDB_EA,
-	GDB_BA,
-	GDB_RA,
-	GDB_PC,
-	GDB_STATUS,
-	GDB_ESTATUS,
-	GDB_BSTATUS,
-	GDB_IENABLE,
-	GDB_IPENDING,
-	GDB_CPUID,
-	GDB_CTL6,
-	GDB_EXCEPTION,
-	GDB_PTEADDR,
-	GDB_TLBACC,
-	GDB_TLBMISC,
-	GDB_ECCINJ,
-	GDB_BADADDR,
-	GDB_CONFIG,
-	GDB_MPUBASE,
-	GDB_MPUACC,
-	/* do not change the last entry or anything below! */
-	GDB_NUMREGBYTES		/* number of registers */
-};
-
-#define GDB_SIZEOF_REG		sizeof(u32)
-#define DBG_MAX_REG_NUM	(49)
-#define NUMREGBYTES		(DBG_MAX_REG_NUM * sizeof(GDB_SIZEOF_REG))
-
-#define BREAK_INSTR_SIZE	4
-static inline void arch_kgdb_breakpoint(void)
-{
-	__asm__ __volatile__("trap 30\n");
-}
-
-#endif /* _ASM_NIOS2_KGDB_H */
diff --git a/arch/nios2/include/asm/linkage.h b/arch/nios2/include/asm/linkage.h
deleted file mode 100644
index 211302301a8a..000000000000
--- a/arch/nios2/include/asm/linkage.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
- *
- * All rights reserved.
- */
-
-#ifndef _ASM_NIOS2_LINKAGE_H
-#define _ASM_NIOS2_LINKAGE_H
-
-/* This file is required by include/linux/linkage.h */
-#define __ALIGN .align 4
-#define __ALIGN_STR ".align 4"
-
-#endif
diff --git a/arch/nios2/include/asm/mmu.h b/arch/nios2/include/asm/mmu.h
deleted file mode 100644
index d9c0b1010f26..000000000000
--- a/arch/nios2/include/asm/mmu.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_MMU_H
-#define _ASM_NIOS2_MMU_H
-
-/* Default "unsigned long" context */
-typedef unsigned long mm_context_t;
-
-#endif /* _ASM_NIOS2_MMU_H */
diff --git a/arch/nios2/include/asm/mmu_context.h b/arch/nios2/include/asm/mmu_context.h
deleted file mode 100644
index 4f99ed09b5a7..000000000000
--- a/arch/nios2/include/asm/mmu_context.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 1996, 1997, 1998, 1999 by Ralf Baechle
- * Copyright (C) 1999 Silicon Graphics, Inc.
- *
- * based on MIPS asm/mmu_context.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_MMU_CONTEXT_H
-#define _ASM_NIOS2_MMU_CONTEXT_H
-
-#include <linux/mm_types.h>
-
-#include <asm-generic/mm_hooks.h>
-
-extern void mmu_context_init(void);
-extern unsigned long get_pid_from_context(mm_context_t *ctx);
-
-/*
- * For the fast tlb miss handlers, we keep a pointer to the current pgd.
- * processor.
- */
-extern pgd_t *pgd_current;
-
-/*
- * Initialize the context related info for a new mm_struct instance.
- *
- * Set all new contexts to 0, that way the generation will never match
- * the currently running generation when this context is switched in.
- */
-#define init_new_context init_new_context
-static inline int init_new_context(struct task_struct *tsk,
-					struct mm_struct *mm)
-{
-	mm->context = 0;
-	return 0;
-}
-
-void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-		struct task_struct *tsk);
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-#define activate_mm activate_mm
-void activate_mm(struct mm_struct *prev, struct mm_struct *next);
-
-#include <asm-generic/mmu_context.h>
-
-#endif /* _ASM_NIOS2_MMU_CONTEXT_H */
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
deleted file mode 100644
index 71eb7c1b67d4..000000000000
--- a/arch/nios2/include/asm/page.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * MMU support based on asm/page.h from mips which is:
- *
- * Copyright (C) 1994 - 1999, 2000, 03 Ralf Baechle
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_PAGE_H
-#define _ASM_NIOS2_PAGE_H
-
-#include <linux/pfn.h>
-#include <linux/const.h>
-
-#include <vdso/page.h>
-
-/*
- * PAGE_OFFSET -- the first address of the first page of memory.
- */
-#define PAGE_OFFSET	\
-	(CONFIG_NIOS2_MEM_BASE + CONFIG_NIOS2_KERNEL_REGION_BASE)
-
-#ifndef __ASSEMBLER__
-
-/*
- * This gives the physical RAM offset.
- */
-#define PHYS_OFFSET		CONFIG_NIOS2_MEM_BASE
-
-/*
- * It's normally defined only for FLATMEM config but it's
- * used in our early mem init code for all memory models.
- * So always define it.
- */
-#define ARCH_PFN_OFFSET		PFN_UP(PHYS_OFFSET)
-
-#define clear_page(page)	memset((page), 0, PAGE_SIZE)
-#define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
-
-struct page;
-
-#define clear_user_page clear_user_page
-extern void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
-extern void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-				struct page *to);
-
-/*
- * These are used to make use of C type-checking.
- */
-typedef struct page *pgtable_t;
-typedef struct { unsigned long pte; } pte_t;
-typedef struct { unsigned long pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
-
-#define pte_val(x)	((x).pte)
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
-
-#define __pte(x)	((pte_t) { (x) })
-#define __pgd(x)	((pgd_t) { (x) })
-#define __pgprot(x)	((pgprot_t) { (x) })
-
-extern unsigned long memory_start;
-extern unsigned long memory_end;
-extern unsigned long memory_size;
-
-extern struct page *mem_map;
-
-# define __pa(x)		\
-	((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
-# define __va(x)		\
-	((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
-
-#define page_to_virt(page)	\
-	((void *)(((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
-
-# define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-
-# define virt_to_page(vaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(vaddr)))
-# define virt_addr_valid(vaddr)	pfn_valid(PFN_DOWN(virt_to_phys(vaddr)))
-
-# define VMA_DATA_DEFAULT_FLAGS	VMA_DATA_FLAGS_NON_EXEC
-
-#include <asm-generic/memory_model.h>
-
-#include <asm-generic/getorder.h>
-
-#endif /* !__ASSEMBLER__ */
-
-#endif /* _ASM_NIOS2_PAGE_H */
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
deleted file mode 100644
index db122b093a8b..000000000000
--- a/arch/nios2/include/asm/pgalloc.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994 - 2001, 2003 by Ralf Baechle
- * Copyright (C) 1999, 2000, 2001 Silicon Graphics, Inc.
- */
-
-#ifndef _ASM_NIOS2_PGALLOC_H
-#define _ASM_NIOS2_PGALLOC_H
-
-#include <linux/mm.h>
-
-#include <asm-generic/pgalloc.h>
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
-	pte_t *pte)
-{
-	set_pmd(pmd, __pmd((unsigned long)pte));
-}
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-	pgtable_t pte)
-{
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
-}
-
-extern pgd_t *pgd_alloc(struct mm_struct *mm);
-
-#define __pte_free_tlb(tlb, pte, addr)	\
-	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
-
-#endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/nios2/include/asm/pgtable-bits.h b/arch/nios2/include/asm/pgtable-bits.h
deleted file mode 100644
index 724f9b08b1d1..000000000000
--- a/arch/nios2/include/asm/pgtable-bits.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_PGTABLE_BITS_H
-#define _ASM_NIOS2_PGTABLE_BITS_H
-
-/*
- * These are actual hardware defined protection bits in the tlbacc register
- * which looks like this:
- *
- * 31 30 ... 26 25 24 23 22 21 20 19 18 ...  1  0
- * ignored........  C  R  W  X  G PFN............
- */
-#define _PAGE_GLOBAL	(1<<20)
-#define _PAGE_EXEC	(1<<21)
-#define _PAGE_WRITE	(1<<22)
-#define _PAGE_READ	(1<<23)
-#define _PAGE_CACHED	(1<<24)	/* C: data access cacheable */
-
-/*
- * Software defined bits. They are ignored by the hardware and always read back
- * as zero, but can be written as non-zero.
- */
-#define _PAGE_PRESENT	(1<<25)	/* PTE contains a translation */
-#define _PAGE_ACCESSED	(1<<26)	/* page referenced */
-#define _PAGE_DIRTY	(1<<27)	/* dirty page */
-
-/* We borrow bit 31 to store the exclusive marker in swap PTEs. */
-#define _PAGE_SWP_EXCLUSIVE	(1<<31)
-
-#endif /* _ASM_NIOS2_PGTABLE_BITS_H */
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
deleted file mode 100644
index d389aa9ca57c..000000000000
--- a/arch/nios2/include/asm/pgtable.h
+++ /dev/null
@@ -1,297 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *
- * Based on asm/pgtable-32.h from mips which is:
- *
- * Copyright (C) 1994, 95, 96, 97, 98, 99, 2000, 2003 Ralf Baechle
- * Copyright (C) 1999, 2000, 2001 Silicon Graphics, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_PGTABLE_H
-#define _ASM_NIOS2_PGTABLE_H
-
-#include <linux/io.h>
-#include <linux/bug.h>
-#include <asm/page.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
-#include <asm/pgtable-bits.h>
-#include <asm-generic/pgtable-nopmd.h>
-
-#define VMALLOC_START		CONFIG_NIOS2_KERNEL_MMU_REGION_BASE
-#define VMALLOC_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - SZ_32M - 1)
-
-#define MODULES_VADDR		(CONFIG_NIOS2_KERNEL_REGION_BASE - SZ_32M)
-#define MODULES_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - 1)
-
-struct mm_struct;
-
-/* Helper macro */
-#define MKP(x, w, r) __pgprot(_PAGE_PRESENT | _PAGE_CACHED |		\
-				((x) ? _PAGE_EXEC : 0) |		\
-				((r) ? _PAGE_READ : 0) |		\
-				((w) ? _PAGE_WRITE : 0))
-/*
- * These are the macros that generic kernel code needs
- * (to populate protection_map[])
- */
-
-/* Remove W bit on private pages for COW support */
-
-/* Shared pages can have exact HW mapping */
-
-/* Used all over the kernel */
-#define PAGE_KERNEL __pgprot(_PAGE_PRESENT | _PAGE_CACHED | _PAGE_READ | \
-			     _PAGE_WRITE | _PAGE_EXEC | _PAGE_GLOBAL)
-
-#define PAGE_SHARED __pgprot(_PAGE_PRESENT | _PAGE_CACHED | _PAGE_READ | \
-			     _PAGE_WRITE | _PAGE_ACCESSED)
-
-#define PAGE_COPY MKP(0, 0, 1)
-
-#define PTRS_PER_PGD	(PAGE_SIZE / sizeof(pgd_t))
-#define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
-
-#define USER_PTRS_PER_PGD	\
-	(CONFIG_NIOS2_KERNEL_MMU_REGION_BASE / PGDIR_SIZE)
-
-#define PGDIR_SHIFT	22
-#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern pte_t invalid_pte_table[PAGE_SIZE/sizeof(pte_t)];
-
-/*
- * (pmds are folded into puds so this doesn't get actually called,
- * but the define is needed for a generic inline function.)
- */
-static inline void set_pmd(pmd_t *pmdptr, pmd_t pmdval)
-{
-	*pmdptr = pmdval;
-}
-
-static inline int pte_write(pte_t pte)		\
-	{ return pte_val(pte) & _PAGE_WRITE; }
-static inline int pte_dirty(pte_t pte)		\
-	{ return pte_val(pte) & _PAGE_DIRTY; }
-static inline int pte_young(pte_t pte)		\
-	{ return pte_val(pte) & _PAGE_ACCESSED; }
-
-#define pgprot_noncached pgprot_noncached
-
-static inline pgprot_t pgprot_noncached(pgprot_t _prot)
-{
-	unsigned long prot = pgprot_val(_prot);
-
-	prot &= ~_PAGE_CACHED;
-
-	return __pgprot(prot);
-}
-
-static inline int pte_none(pte_t pte)
-{
-	return !(pte_val(pte) & ~(_PAGE_GLOBAL|0xf));
-}
-
-static inline int pte_present(pte_t pte)	\
-	{ return pte_val(pte) & _PAGE_PRESENT; }
-
-/*
- * The following only work if pte_present() is true.
- * Undefined behaviour if not..
- */
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	pte_val(pte) &= ~_PAGE_WRITE;
-	return pte;
-}
-
-static inline pte_t pte_mkclean(pte_t pte)
-{
-	pte_val(pte) &= ~_PAGE_DIRTY;
-	return pte;
-}
-
-static inline pte_t pte_mkold(pte_t pte)
-{
-	pte_val(pte) &= ~_PAGE_ACCESSED;
-	return pte;
-}
-
-static inline pte_t pte_mkwrite_novma(pte_t pte)
-{
-	pte_val(pte) |= _PAGE_WRITE;
-	return pte;
-}
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	pte_val(pte) |= _PAGE_DIRTY;
-	return pte;
-}
-
-static inline pte_t pte_mkyoung(pte_t pte)
-{
-	pte_val(pte) |= _PAGE_ACCESSED;
-	return pte;
-}
-
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-{
-	const unsigned long mask = _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC;
-
-	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
-	return pte;
-}
-
-static inline int pmd_present(pmd_t pmd)
-{
-	return (pmd_val(pmd) != (unsigned long) invalid_pte_table)
-			&& (pmd_val(pmd) != 0UL);
-}
-
-static inline void pmd_clear(pmd_t *pmdp)
-{
-	pmd_val(*pmdp) = (unsigned long) invalid_pte_table;
-}
-
-#define pte_pfn(pte)		(pte_val(pte) & 0xfffff)
-#define pfn_pte(pfn, prot)	(__pte(pfn | pgprot_val(prot)))
-#define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
-
-/*
- * Store a linux PTE into the linux page table.
- */
-static inline void set_pte(pte_t *ptep, pte_t pteval)
-{
-	*ptep = pteval;
-}
-
-#define PFN_PTE_SHIFT		0
-
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	unsigned long paddr = (unsigned long)page_to_virt(pte_page(pte));
-
-	flush_dcache_range(paddr, paddr + nr * PAGE_SIZE);
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += 1;
-	}
-}
-#define set_ptes set_ptes
-
-static inline int pmd_none(pmd_t pmd)
-{
-	return (pmd_val(pmd) ==
-		(unsigned long) invalid_pte_table) || (pmd_val(pmd) == 0UL);
-}
-
-#define pmd_bad(pmd)	(pmd_val(pmd) & ~PAGE_MASK)
-
-static inline void pte_clear(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep)
-{
-	pte_t null;
-
-	pte_val(null) = (addr >> PAGE_SHIFT) & 0xf;
-
-	set_pte(ptep, null);
-}
-
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define pmd_phys(pmd)		virt_to_phys((void *)pmd_val(pmd))
-#define pmd_pfn(pmd)		(pmd_phys(pmd) >> PAGE_SHIFT)
-#define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
-
-static inline unsigned long pmd_page_vaddr(pmd_t pmd)
-{
-	return pmd_val(pmd);
-}
-
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %08lx.\n", \
-		__FILE__, __LINE__, pte_val(e))
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", \
-		__FILE__, __LINE__, pgd_val(e))
-
-/*
- * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
- * are !pte_none() && !pte_present().
- *
- * Format of swap PTEs:
- *
- *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
- *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *   E < type -> 0 0 0 0 0 0 <-------------- offset --------------->
- *
- *   E is the exclusive marker that is not stored in swap entries.
- *
- * Note that the offset field is always non-zero if the swap type is 0, thus
- * !pte_none() is always true.
- */
-#define __swp_type(swp)		(((swp).val >> 26) & 0x1f)
-#define __swp_offset(swp)	((swp).val & 0xfffff)
-#define __swp_entry(type, off)	((swp_entry_t) { (((type) & 0x1f) << 26) \
-						 | ((off) & 0xfffff) })
-#define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-
-static inline bool pte_swp_exclusive(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
-}
-
-static inline pte_t pte_swp_mkexclusive(pte_t pte)
-{
-	pte_val(pte) |= _PAGE_SWP_EXCLUSIVE;
-	return pte;
-}
-
-static inline pte_t pte_swp_clear_exclusive(pte_t pte)
-{
-	pte_val(pte) &= ~_PAGE_SWP_EXCLUSIVE;
-	return pte;
-}
-
-extern void __init paging_init(void);
-extern void __init mmu_init(void);
-
-void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep, unsigned int nr);
-
-#define update_mmu_cache(vma, addr, ptep) \
-	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
-
-static inline int pte_same(pte_t pte_a, pte_t pte_b);
-
-#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-static inline int ptep_set_access_flags(struct vm_area_struct *vma,
-					unsigned long address, pte_t *ptep,
-					pte_t entry, int dirty)
-{
-	if (!pte_same(*ptep, entry))
-		set_ptes(vma->vm_mm, address, ptep, entry, 1);
-	/*
-	 * update_mmu_cache will unconditionally execute, handling both
-	 * the case that the PTE changed and the spurious fault case.
-	 */
-	return true;
-}
-
-#endif /* _ASM_NIOS2_PGTABLE_H */
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
deleted file mode 100644
index d9521c3c2df9..000000000000
--- a/arch/nios2/include/asm/processor.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd
- * Copyright (C) 2001 Ken Hill (khill@microtronix.com)
- *                    Vic Phillips (vic@microtronix.com)
- *
- * based on SPARC asm/processor_32.h which is:
- *
- * Copyright (C) 1994 David S. Miller
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_PROCESSOR_H
-#define _ASM_NIOS2_PROCESSOR_H
-
-#include <asm/ptrace.h>
-#include <asm/registers.h>
-#include <asm/page.h>
-
-#define NIOS2_FLAG_KTHREAD	0x00000001	/* task is a kernel thread */
-
-#define NIOS2_OP_NOP		0x1883a
-#define NIOS2_OP_BREAK		0x3da03a
-
-#ifdef __KERNEL__
-
-#define STACK_TOP	TASK_SIZE
-#define STACK_TOP_MAX	STACK_TOP
-
-#endif /* __KERNEL__ */
-
-/* Kuser helpers is mapped to this user space address */
-#define KUSER_BASE		0x1000
-#define KUSER_SIZE		(PAGE_SIZE)
-#ifndef __ASSEMBLER__
-
-# define TASK_SIZE		0x7FFF0000UL
-# define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
-
-/* The Nios processor specific thread struct. */
-struct thread_struct {
-	struct pt_regs *kregs;
-
-	/* Context switch saved kernel state. */
-	unsigned long ksp;
-	unsigned long kpsr;
-};
-
-# define INIT_THREAD {			\
-	.kregs	= NULL,			\
-	.ksp	= 0,			\
-	.kpsr	= 0,			\
-}
-
-extern void start_thread(struct pt_regs *regs, unsigned long pc,
-			unsigned long sp);
-
-struct task_struct;
-
-extern unsigned long __get_wchan(struct task_struct *p);
-
-#define task_pt_regs(p) \
-	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
-
-/* Used by procfs */
-#define KSTK_EIP(tsk)	((tsk)->thread.kregs->ea)
-#define KSTK_ESP(tsk)	((tsk)->thread.kregs->sp)
-
-#define cpu_relax()	barrier()
-
-#endif /* __ASSEMBLER__ */
-
-#endif /* _ASM_NIOS2_PROCESSOR_H */
diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptrace.h
deleted file mode 100644
index 96cbcd40c7ce..000000000000
--- a/arch/nios2/include/asm/ptrace.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * based on m68k asm/processor.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_PTRACE_H
-#define _ASM_NIOS2_PTRACE_H
-
-#include <uapi/asm/ptrace.h>
-
-/* This struct defines the way the registers are stored on the
-   stack during a system call.  */
-
-#ifndef __ASSEMBLER__
-struct pt_regs {
-	unsigned long  r8;	/* r8-r15 Caller-saved GP registers */
-	unsigned long  r9;
-	unsigned long  r10;
-	unsigned long  r11;
-	unsigned long  r12;
-	unsigned long  r13;
-	unsigned long  r14;
-	unsigned long  r15;
-	unsigned long  r1;	/* Assembler temporary */
-	unsigned long  r2;	/* Retval LS 32bits */
-	unsigned long  r3;	/* Retval MS 32bits */
-	unsigned long  r4;	/* r4-r7 Register arguments */
-	unsigned long  r5;
-	unsigned long  r6;
-	unsigned long  r7;
-	unsigned long  orig_r2;	/* Copy of r2 ?? */
-	unsigned long  ra;	/* Return address */
-	unsigned long  fp;	/* Frame pointer */
-	unsigned long  sp;	/* Stack pointer */
-	unsigned long  gp;	/* Global pointer */
-	unsigned long  estatus;
-	unsigned long  ea;	/* Exception return address (pc) */
-	unsigned long  orig_r7;
-};
-
-/*
- * This is the extended stack used by signal handlers and the context
- * switcher: it's pushed after the normal "struct pt_regs".
- */
-struct switch_stack {
-	unsigned long  r16;	/* r16-r23 Callee-saved GP registers */
-	unsigned long  r17;
-	unsigned long  r18;
-	unsigned long  r19;
-	unsigned long  r20;
-	unsigned long  r21;
-	unsigned long  r22;
-	unsigned long  r23;
-	unsigned long  fp;
-	unsigned long  gp;
-	unsigned long  ra;
-};
-
-#define user_mode(regs)	(((regs)->estatus & ESTATUS_EU))
-
-#define instruction_pointer(regs)	((regs)->ra)
-#define profile_pc(regs)		instruction_pointer(regs)
-#define user_stack_pointer(regs)	((regs)->sp)
-extern void show_regs(struct pt_regs *);
-
-#define current_pt_regs() \
-	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE)\
-		- 1)
-
-#define force_successful_syscall_return() (current_pt_regs()->orig_r2 = -1)
-
-int do_syscall_trace_enter(void);
-void do_syscall_trace_exit(void);
-#endif /* __ASSEMBLER__ */
-#endif /* _ASM_NIOS2_PTRACE_H */
diff --git a/arch/nios2/include/asm/registers.h b/arch/nios2/include/asm/registers.h
deleted file mode 100644
index 165dab26221f..000000000000
--- a/arch/nios2/include/asm/registers.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- */
-
-#ifndef _ASM_NIOS2_REGISTERS_H
-#define _ASM_NIOS2_REGISTERS_H
-
-#ifndef __ASSEMBLER__
-#include <asm/cpuinfo.h>
-#endif
-
-/* control register numbers */
-#define CTL_FSTATUS	0
-#define CTL_ESTATUS	1
-#define CTL_BSTATUS	2
-#define CTL_IENABLE	3
-#define CTL_IPENDING	4
-#define CTL_CPUID	5
-#define CTL_RSV1	6
-#define CTL_EXCEPTION	7
-#define CTL_PTEADDR	8
-#define CTL_TLBACC	9
-#define CTL_TLBMISC	10
-#define CTL_RSV2	11
-#define CTL_BADADDR	12
-#define CTL_CONFIG	13
-#define CTL_MPUBASE	14
-#define CTL_MPUACC	15
-
-/* access control registers using GCC builtins */
-#define RDCTL(r)	__builtin_rdctl(r)
-#define WRCTL(r, v)	__builtin_wrctl(r, v)
-
-/* status register bits */
-#define STATUS_PIE	(1 << 0)	/* processor interrupt enable */
-#define STATUS_U	(1 << 1)	/* user mode */
-#define STATUS_EH	(1 << 2)	/* Exception mode */
-
-/* estatus register bits */
-#define ESTATUS_EPIE	(1 << 0)	/* processor interrupt enable */
-#define ESTATUS_EU	(1 << 1)	/* user mode */
-#define ESTATUS_EH	(1 << 2)	/* Exception mode */
-
-/* tlbmisc register bits */
-#define TLBMISC_PID_SHIFT	4
-#ifndef __ASSEMBLER__
-#define TLBMISC_PID_MASK	((1UL << cpuinfo.tlb_pid_num_bits) - 1)
-#endif
-#define TLBMISC_WAY_MASK	0xf
-#define TLBMISC_WAY_SHIFT	20
-
-#define TLBMISC_PID	(TLBMISC_PID_MASK << TLBMISC_PID_SHIFT)	/* TLB PID */
-#define TLBMISC_WE	(1 << 18)	/* TLB write enable */
-#define TLBMISC_RD	(1 << 19)	/* TLB read */
-#define TLBMISC_WAY	(TLBMISC_WAY_MASK << TLBMISC_WAY_SHIFT) /* TLB way */
-
-#endif /* _ASM_NIOS2_REGISTERS_H */
diff --git a/arch/nios2/include/asm/setup.h b/arch/nios2/include/asm/setup.h
deleted file mode 100644
index 6d3f26a71cb5..000000000000
--- a/arch/nios2/include/asm/setup.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- */
-
-#ifndef _ASM_NIOS2_SETUP_H
-#define _ASM_NIOS2_SETUP_H
-
-#include <asm-generic/setup.h>
-
-#ifndef __ASSEMBLER__
-#ifdef __KERNEL__
-
-extern char exception_handler_hook[];
-extern char fast_handler[];
-extern char fast_handler_end[];
-
-extern void pagetable_init(void);
-
-#endif/* __KERNEL__ */
-#endif /* __ASSEMBLER__ */
-
-#endif /* _ASM_NIOS2_SETUP_H */
diff --git a/arch/nios2/include/asm/shmparam.h b/arch/nios2/include/asm/shmparam.h
deleted file mode 100644
index 4288844eed46..000000000000
--- a/arch/nios2/include/asm/shmparam.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright Altera Corporation (C) <2015>. All rights reserved
- */
-#ifndef _ASM_NIOS2_SHMPARAM_H
-#define _ASM_NIOS2_SHMPARAM_H
-
-#define	SHMLBA	CONFIG_NIOS2_DCACHE_SIZE
-
-#endif /* _ASM_NIOS2_SHMPARAM_H */
diff --git a/arch/nios2/include/asm/string.h b/arch/nios2/include/asm/string.h
deleted file mode 100644
index 14dd570d64f7..000000000000
--- a/arch/nios2/include/asm/string.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_STRING_H
-#define _ASM_NIOS2_STRING_H
-
-#ifdef __KERNEL__
-
-#define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_MEMCPY
-#define __HAVE_ARCH_MEMMOVE
-
-extern void *memset(void *s, int c, size_t count);
-extern void *memcpy(void *d, const void *s, size_t count);
-extern void *memmove(void *d, const void *s, size_t count);
-
-#endif /* __KERNEL__ */
-
-#endif /* _ASM_NIOS2_STRING_H */
diff --git a/arch/nios2/include/asm/swab.h b/arch/nios2/include/asm/swab.h
deleted file mode 100644
index 9750547a5f82..000000000000
--- a/arch/nios2/include/asm/swab.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2011 Pyramid Technical Consultants, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
- */
-
-#ifndef _ASM_NIOS2_SWAB_H
-#define _ASM_NIOS2_SWAB_H
-
-#include <linux/types.h>
-#include <asm-generic/swab.h>
-
-#ifdef CONFIG_NIOS2_CI_SWAB_SUPPORT
-#ifdef __GNUC__
-
-#define __nios2_swab(x)		\
-	__builtin_custom_ini(CONFIG_NIOS2_CI_SWAB_NO, (x))
-
-static inline __attribute__((const)) __u16 __arch_swab16(__u16 x)
-{
-	return (__u16) __nios2_swab(((__u32) x) << 16);
-}
-#define __arch_swab16 __arch_swab16
-
-static inline __attribute__((const)) __u32 __arch_swab32(__u32 x)
-{
-	return (__u32) __nios2_swab(x);
-}
-#define __arch_swab32 __arch_swab32
-
-#endif /* __GNUC__ */
-#endif /* CONFIG_NIOS2_CI_SWAB_SUPPORT */
-
-#endif /* _ASM_NIOS2_SWAB_H */
diff --git a/arch/nios2/include/asm/switch_to.h b/arch/nios2/include/asm/switch_to.h
deleted file mode 100644
index c47b3f4afbcd..000000000000
--- a/arch/nios2/include/asm/switch_to.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef _ASM_NIOS2_SWITCH_TO_H
-#define _ASM_NIOS2_SWITCH_TO_H
-
-/*
- * switch_to(n) should switch tasks to task ptr, first checking that
- * ptr isn't the current task, in which case it does nothing.  This
- * also clears the TS-flag if the task we switched to has used the
- * math co-processor latest.
- */
-#define switch_to(prev, next, last)			\
-{							\
-	void *_last;					\
-	__asm__ __volatile__ (				\
-		"mov	r4, %1\n"			\
-		"mov	r5, %2\n"			\
-		"call	resume\n"			\
-		"mov	%0,r4\n"			\
-		: "=r" (_last)				\
-		: "r" (prev), "r" (next)		\
-		: "r4", "r5", "r7", "r8", "ra");	\
-	(last) = _last;					\
-}
-
-#endif /* _ASM_NIOS2_SWITCH_TO_H */
diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
deleted file mode 100644
index 8e3eb1d689bb..000000000000
--- a/arch/nios2/include/asm/syscall.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright Altera Corporation (C) <2014>. All rights reserved
- */
-
-#ifndef __ASM_NIOS2_SYSCALL_H__
-#define __ASM_NIOS2_SYSCALL_H__
-
-#include <uapi/linux/audit.h>
-#include <linux/err.h>
-#include <linux/sched.h>
-
-static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
-{
-	return regs->r2;
-}
-
-static inline void syscall_set_nr(struct task_struct *task, struct pt_regs *regs, int nr)
-{
-	regs->r2 = nr;
-}
-
-static inline void syscall_rollback(struct task_struct *task,
-				struct pt_regs *regs)
-{
-	regs->r2 = regs->orig_r2;
-	regs->r7 = regs->orig_r7;
-}
-
-static inline long syscall_get_error(struct task_struct *task,
-				struct pt_regs *regs)
-{
-	return regs->r7 ? regs->r2 : 0;
-}
-
-static inline long syscall_get_return_value(struct task_struct *task,
-	struct pt_regs *regs)
-{
-	return regs->r2;
-}
-
-static inline void syscall_set_return_value(struct task_struct *task,
-	struct pt_regs *regs, int error, long val)
-{
-	if (error) {
-		/* error < 0, but nios2 uses > 0 return value */
-		regs->r2 = -error;
-		regs->r7 = 1;
-	} else {
-		regs->r2 = val;
-		regs->r7 = 0;
-	}
-}
-
-static inline void syscall_get_arguments(struct task_struct *task,
-	struct pt_regs *regs, unsigned long *args)
-{
-	*args++ = regs->r4;
-	*args++ = regs->r5;
-	*args++ = regs->r6;
-	*args++ = regs->r7;
-	*args++ = regs->r8;
-	*args   = regs->r9;
-}
-
-static inline void syscall_set_arguments(struct task_struct *task,
-	struct pt_regs *regs, const unsigned long *args)
-{
-	regs->r4 = *args++;
-	regs->r5 = *args++;
-	regs->r6 = *args++;
-	regs->r7 = *args++;
-	regs->r8 = *args++;
-	regs->r9 = *args;
-}
-
-static inline int syscall_get_arch(struct task_struct *task)
-{
-	return AUDIT_ARCH_NIOS2;
-}
-
-#endif
diff --git a/arch/nios2/include/asm/syscalls.h b/arch/nios2/include/asm/syscalls.h
deleted file mode 100644
index 0e214b0a0ac8..000000000000
--- a/arch/nios2/include/asm/syscalls.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright Altera Corporation (C) 2013. All rights reserved
- */
-#ifndef __ASM_NIOS2_SYSCALLS_H
-#define __ASM_NIOS2_SYSCALLS_H
-
-int sys_cacheflush(unsigned long addr, unsigned long len,
-				unsigned int op);
-asmlinkage long __sys_clone3(struct clone_args __user *uargs, size_t size);
-
-#include <asm-generic/syscalls.h>
-
-#endif /* __ASM_NIOS2_SYSCALLS_H */
diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
deleted file mode 100644
index 83df79286d62..000000000000
--- a/arch/nios2/include/asm/thread_info.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * NiosII low-level thread information
- *
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * Based on asm/thread_info_no.h from m68k which is:
- *
- * Copyright (C) 2002 David Howells <dhowells@redhat.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_THREAD_INFO_H
-#define _ASM_NIOS2_THREAD_INFO_H
-
-#ifdef __KERNEL__
-
-/*
- * Size of the kernel stack for each process.
- */
-#define THREAD_SIZE_ORDER	1
-#define THREAD_SIZE		8192 /* 2 * PAGE_SIZE */
-
-#ifndef __ASSEMBLER__
-
-/*
- * low level task data that entry.S needs immediate access to
- * - this struct should fit entirely inside of one cache line
- * - this struct shares the supervisor stack pages
- * - if the contents of this structure are changed, the assembly constants
- *   must also be changed
- */
-struct thread_info {
-	struct task_struct	*task;		/* main task structure */
-	unsigned long		flags;		/* low level flags */
-	__u32			cpu;		/* current CPU */
-	int			preempt_count;	/* 0 => preemptable,<0 => BUG */
-	struct pt_regs		*regs;
-};
-
-/*
- * macros/functions for gaining access to the thread information structure
- *
- * preempt_count needs to be 1 initially, until the scheduler is functional.
- */
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.task		= &tsk,			\
-	.flags		= 0,			\
-	.cpu		= 0,			\
-	.preempt_count	= INIT_PREEMPT_COUNT,	\
-}
-
-/* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
-{
-	register unsigned long sp asm("sp");
-
-	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
-}
-#endif /* !__ASSEMBLER__ */
-
-/*
- * thread information flags
- * - these are process state flags that various assembly files may need to
- *   access
- * - pending work-to-be-done flags are in LSW
- * - other flags in MSW
- */
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
-#define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_MEMDIE		4	/* is terminating due to OOM killer */
-#define TIF_SECCOMP		5	/* secure computing */
-#define TIF_SYSCALL_AUDIT	6	/* syscall auditing active */
-#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
-
-#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
-					   TIF_NEED_RESCHED */
-
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
-#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
-
-/* work to do on interrupt/exception return */
-#define _TIF_WORK_MASK		0x0000FFFE
-
-#endif /* __KERNEL__ */
-
-#endif /* _ASM_NIOS2_THREAD_INFO_H */
diff --git a/arch/nios2/include/asm/timex.h b/arch/nios2/include/asm/timex.h
deleted file mode 100644
index 40a1adc9bd03..000000000000
--- a/arch/nios2/include/asm/timex.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright Altera Corporation (C) 2014. All rights reserved.
- */
-
-#ifndef _ASM_NIOS2_TIMEX_H
-#define _ASM_NIOS2_TIMEX_H
-
-typedef unsigned long cycles_t;
-
-extern cycles_t get_cycles(void);
-#define get_cycles get_cycles
-
-#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
-
-#endif
diff --git a/arch/nios2/include/asm/tlb.h b/arch/nios2/include/asm/tlb.h
deleted file mode 100644
index f9f2e27e32dd..000000000000
--- a/arch/nios2/include/asm/tlb.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_TLB_H
-#define _ASM_NIOS2_TLB_H
-
-extern void set_mmu_pid(unsigned long pid);
-
-/*
- * NIOS32 does have flush_tlb_range(), but it lacks a limit and fallback to
- * full mm invalidation. So use flush_tlb_mm() for everything.
- */
-
-#include <linux/pagemap.h>
-#include <asm-generic/tlb.h>
-
-#endif /* _ASM_NIOS2_TLB_H */
diff --git a/arch/nios2/include/asm/tlbflush.h b/arch/nios2/include/asm/tlbflush.h
deleted file mode 100644
index 362d6da09d02..000000000000
--- a/arch/nios2/include/asm/tlbflush.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- */
-
-#ifndef _ASM_NIOS2_TLBFLUSH_H
-#define _ASM_NIOS2_TLBFLUSH_H
-
-struct mm_struct;
-
-/*
- * TLB flushing:
- *
- *  - flush_tlb_all() flushes all processes TLB entries
- *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
- *  - flush_tlb_page(vma, address) flushes a page
- *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
- *  - flush_tlb_kernel_page(address) flushes a kernel page
- *
- *  - reload_tlb_page(vma, address, pte) flushes the TLB for address like
- *    flush_tlb_page, then replaces it with a TLB for pte.
- */
-extern void flush_tlb_all(void);
-extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
-
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long address)
-{
-	flush_tlb_range(vma, address, address + PAGE_SIZE);
-}
-
-static inline void flush_tlb_kernel_page(unsigned long address)
-{
-	flush_tlb_kernel_range(address, address + PAGE_SIZE);
-}
-
-extern void reload_tlb_page(struct vm_area_struct *vma, unsigned long addr,
-			    pte_t pte);
-
-#endif /* _ASM_NIOS2_TLBFLUSH_H */
diff --git a/arch/nios2/include/asm/traps.h b/arch/nios2/include/asm/traps.h
deleted file mode 100644
index 133a3dedbc3e..000000000000
--- a/arch/nios2/include/asm/traps.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_TRAPS_H
-#define _ASM_NIOS2_TRAPS_H
-
-#define TRAP_ID_SYSCALL		0
-
-#ifndef __ASSEMBLER__
-void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr);
-void do_page_fault(struct pt_regs *regs, unsigned long cause,
-		   unsigned long address);
-#endif
-
-#endif /* _ASM_NIOS2_TRAPS_H */
diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
deleted file mode 100644
index 6ccc9a232c23..000000000000
--- a/arch/nios2/include/asm/uaccess.h
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- * User space memory access functions for Nios II
- *
- * Copyright (C) 2010-2011, Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009, Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_NIOS2_UACCESS_H
-#define _ASM_NIOS2_UACCESS_H
-
-#include <linux/string.h>
-
-#include <asm/page.h>
-
-#include <asm/extable.h>
-#include <asm-generic/access_ok.h>
-
-# define __EX_TABLE_SECTION	".section __ex_table,\"a\"\n"
-
-/*
- * Zero Userspace
- */
-
-static inline unsigned long __must_check __clear_user(void __user *to,
-						      unsigned long n)
-{
-	__asm__ __volatile__ (
-		"1:     stb     zero, 0(%1)\n"
-		"       addi    %0, %0, -1\n"
-		"       addi    %1, %1, 1\n"
-		"       bne     %0, zero, 1b\n"
-		"2:\n"
-		__EX_TABLE_SECTION
-		".word  1b, 2b\n"
-		".previous\n"
-		: "=r" (n), "=r" (to)
-		: "0" (n), "1" (to)
-	);
-
-	return n;
-}
-
-static inline unsigned long __must_check clear_user(void __user *to,
-						    unsigned long n)
-{
-	if (!access_ok(to, n))
-		return n;
-	return __clear_user(to, n);
-}
-
-extern unsigned long
-raw_copy_from_user(void *to, const void __user *from, unsigned long n);
-extern unsigned long
-raw_copy_to_user(void __user *to, const void *from, unsigned long n);
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
-extern long strncpy_from_user(char *__to, const char __user *__from,
-			      long __len);
-extern __must_check long strnlen_user(const char __user *s, long n);
-
-/* Optimized macros */
-#define __get_user_asm(val, insn, addr, err)				\
-{									\
-	unsigned long __gu_val;						\
-	__asm__ __volatile__(						\
-	"       movi    %0, %3\n"					\
-	"1:   " insn " %1, 0(%2)\n"					\
-	"       movi     %0, 0\n"					\
-	"2:\n"								\
-	"       .section __ex_table,\"a\"\n"				\
-	"       .word 1b, 2b\n"						\
-	"       .previous"						\
-	: "=&r" (err), "=r" (__gu_val)					\
-	: "r" (addr), "i" (-EFAULT));					\
-	val = (__force __typeof__(*(addr)))__gu_val;			\
-}
-
-extern void __get_user_unknown(void);
-
-#define __get_user_8(val, ptr, err) do {				\
-	u64 __val = 0;							\
-	err = 0;							\
-	if (raw_copy_from_user(&(__val), ptr, sizeof(val))) {		\
-		err = -EFAULT;						\
-	} else {							\
-		val = (typeof(val))(typeof((val) - (val)))__val;	\
-	}								\
-	} while (0)
-
-#define __get_user_common(val, size, ptr, err)				\
-do {									\
-	switch (size) {							\
-	case 1:								\
-		__get_user_asm(val, "ldbu", ptr, err);			\
-		break;							\
-	case 2:								\
-		__get_user_asm(val, "ldhu", ptr, err);			\
-		break;							\
-	case 4:								\
-		__get_user_asm(val, "ldw", ptr, err);			\
-		break;							\
-	case 8:								\
-		__get_user_8(val, ptr, err);				\
-		break;							\
-	default:							\
-		__get_user_unknown();					\
-		break;							\
-	}								\
-} while (0)
-
-#define __get_user(x, ptr)						\
-	({								\
-	long __gu_err = -EFAULT;					\
-	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
-	__get_user_common(x, sizeof(*(ptr)), __gu_ptr, __gu_err);	\
-	__gu_err;							\
-	})
-
-#define get_user(x, ptr)						\
-({									\
-	long __gu_err = -EFAULT;					\
-	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
-	if (access_ok( __gu_ptr, sizeof(*__gu_ptr)))	\
-		__get_user_common(x, sizeof(*__gu_ptr),			\
-			__gu_ptr, __gu_err);				\
-	__gu_err;							\
-})
-
-#define __put_user_asm(val, insn, ptr, err)				\
-{									\
-	__asm__ __volatile__(						\
-	"       movi    %0, %3\n"					\
-	"1:   " insn " %1, 0(%2)\n"					\
-	"       movi     %0, 0\n"					\
-	"2:\n"								\
-	"       .section __ex_table,\"a\"\n"				\
-	"       .word 1b, 2b\n"						\
-	"       .previous\n"						\
-	: "=&r" (err)							\
-	: "r" (val), "r" (ptr), "i" (-EFAULT));				\
-}
-
-#define __put_user_common(__pu_val, __pu_ptr)				\
-({									\
-	long __pu_err = -EFAULT;					\
-	switch (sizeof(*__pu_ptr)) {					\
-	case 1:								\
-		__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err);	\
-		break;							\
-	case 2:								\
-		__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err);	\
-		break;							\
-	case 4:								\
-		__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err);	\
-		break;							\
-	default:							\
-		/* XXX: This looks wrong... */				\
-		__pu_err = 0;						\
-		if (__copy_to_user(__pu_ptr, &(__pu_val),		\
-			sizeof(*__pu_ptr)))				\
-			__pu_err = -EFAULT;				\
-		break;							\
-	}								\
-	__pu_err;							\
-})
-
-#define __put_user(x, ptr)						\
-({									\
-	auto __pu_ptr = (ptr);						\
-	auto __pu_val = (typeof(*__pu_ptr))(x);				\
-	__put_user_common(__pu_val, __pu_ptr);				\
-})
-
-#define put_user(x, ptr)						\
-({									\
-	auto __pu_ptr = (ptr);						\
-	auto __pu_val = (typeof(*__pu_ptr))(x);				\
-	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
-		__put_user_common(__pu_val, __pu_ptr) :			\
-		-EFAULT;						\
-})
-
-#endif /* _ASM_NIOS2_UACCESS_H */
diff --git a/arch/nios2/include/asm/unistd.h b/arch/nios2/include/asm/unistd.h
deleted file mode 100644
index 213f6de3cf7b..000000000000
--- a/arch/nios2/include/asm/unistd.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_UNISTD_H
-#define __ASM_UNISTD_H
-
-#include <uapi/asm/unistd.h>
-
-#define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SET_GET_RLIMIT
-
-#endif
diff --git a/arch/nios2/include/asm/vmalloc.h b/arch/nios2/include/asm/vmalloc.h
deleted file mode 100644
index ec7a9260090b..000000000000
--- a/arch/nios2/include/asm/vmalloc.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef _ASM_NIOS2_VMALLOC_H
-#define _ASM_NIOS2_VMALLOC_H
-
-#endif /* _ASM_NIOS2_VMALLOC_H */
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
deleted file mode 100644
index 2501e82a1a0a..000000000000
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += unistd_32.h
-
-generic-y += ucontext.h
diff --git a/arch/nios2/include/uapi/asm/byteorder.h b/arch/nios2/include/uapi/asm/byteorder.h
deleted file mode 100644
index 639007a5544e..000000000000
--- a/arch/nios2/include/uapi/asm/byteorder.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-/*
- * Copyright (C) 2009   Thomas Chou <thomas@wytron.com.tw>
- * Copyright (C) 2004   Microtronix Datacom Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef _ASM_NIOS2_BYTEORDER_H
-#define _ASM_NIOS2_BYTEORDER_H
-
-#include <linux/byteorder/little_endian.h>
-
-#endif
diff --git a/arch/nios2/include/uapi/asm/elf.h b/arch/nios2/include/uapi/asm/elf.h
deleted file mode 100644
index ab0df71f81b2..000000000000
--- a/arch/nios2/include/uapi/asm/elf.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-
-#ifndef _UAPI_ASM_NIOS2_ELF_H
-#define _UAPI_ASM_NIOS2_ELF_H
-
-#include <linux/ptrace.h>
-
-/* Relocation types */
-#define R_NIOS2_NONE		0
-#define R_NIOS2_S16		1
-#define R_NIOS2_U16		2
-#define R_NIOS2_PCREL16		3
-#define R_NIOS2_CALL26		4
-#define R_NIOS2_IMM5		5
-#define R_NIOS2_CACHE_OPX	6
-#define R_NIOS2_IMM6		7
-#define R_NIOS2_IMM8		8
-#define R_NIOS2_HI16		9
-#define R_NIOS2_LO16		10
-#define R_NIOS2_HIADJ16		11
-#define R_NIOS2_BFD_RELOC_32	12
-#define R_NIOS2_BFD_RELOC_16	13
-#define R_NIOS2_BFD_RELOC_8	14
-#define R_NIOS2_GPREL		15
-#define R_NIOS2_GNU_VTINHERIT	16
-#define R_NIOS2_GNU_VTENTRY	17
-#define R_NIOS2_UJMP		18
-#define R_NIOS2_CJMP		19
-#define R_NIOS2_CALLR		20
-#define R_NIOS2_ALIGN		21
-/* Keep this the last entry.  */
-#define R_NIOS2_NUM		22
-
-typedef unsigned long elf_greg_t;
-
-#define ELF_NGREG		49
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-typedef unsigned long elf_fpregset_t;
-
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS	ELFCLASS32
-#define ELF_DATA	ELFDATA2LSB
-#define ELF_ARCH	EM_ALTERA_NIOS2
-
-#endif /* _UAPI_ASM_NIOS2_ELF_H */
diff --git a/arch/nios2/include/uapi/asm/ptrace.h b/arch/nios2/include/uapi/asm/ptrace.h
deleted file mode 100644
index 1298db9f0fc9..000000000000
--- a/arch/nios2/include/uapi/asm/ptrace.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * based on m68k asm/processor.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _UAPI_ASM_NIOS2_PTRACE_H
-#define _UAPI_ASM_NIOS2_PTRACE_H
-
-#ifndef __ASSEMBLER__
-
-#include <linux/types.h>
-
-/*
- * Register numbers used by 'ptrace' system call interface.
- */
-
-/* GP registers */
-#define PTR_R0		0
-#define PTR_R1		1
-#define PTR_R2		2
-#define PTR_R3		3
-#define PTR_R4		4
-#define PTR_R5		5
-#define PTR_R6		6
-#define PTR_R7		7
-#define PTR_R8		8
-#define PTR_R9		9
-#define PTR_R10		10
-#define PTR_R11		11
-#define PTR_R12		12
-#define PTR_R13		13
-#define PTR_R14		14
-#define PTR_R15		15
-#define PTR_R16		16
-#define PTR_R17		17
-#define PTR_R18		18
-#define PTR_R19		19
-#define PTR_R20		20
-#define PTR_R21		21
-#define PTR_R22		22
-#define PTR_R23		23
-#define PTR_R24		24
-#define PTR_R25		25
-#define PTR_GP		26
-#define PTR_SP		27
-#define PTR_FP		28
-#define PTR_EA		29
-#define PTR_BA		30
-#define PTR_RA		31
-/* Control registers */
-#define PTR_PC		32
-#define PTR_STATUS	33
-#define PTR_ESTATUS	34
-#define PTR_BSTATUS	35
-#define PTR_IENABLE	36
-#define PTR_IPENDING	37
-#define PTR_CPUID	38
-#define PTR_CTL6	39
-#define PTR_EXCEPTION	40
-#define PTR_PTEADDR	41
-#define PTR_TLBACC	42
-#define PTR_TLBMISC	43
-#define PTR_ECCINJ	44
-#define PTR_BADADDR	45
-#define PTR_CONFIG	46
-#define PTR_MPUBASE	47
-#define PTR_MPUACC	48
-
-#define NUM_PTRACE_REG (PTR_MPUACC + 1)
-
-/* User structures for general purpose registers.  */
-struct user_pt_regs {
-	__u32		regs[49];
-};
-
-#endif /* __ASSEMBLER__ */
-#endif /* _UAPI_ASM_NIOS2_PTRACE_H */
diff --git a/arch/nios2/include/uapi/asm/sigcontext.h b/arch/nios2/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 204ae3475b4e..000000000000
--- a/arch/nios2/include/uapi/asm/sigcontext.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-/*
- * Copyright (C) 2004, Microtronix Datacom Ltd.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- */
-
-#ifndef _UAPI__ASM_SIGCONTEXT_H
-#define _UAPI__ASM_SIGCONTEXT_H
-
-#include <linux/types.h>
-
-#define MCONTEXT_VERSION 2
-
-struct sigcontext {
-	int version;
-	unsigned long gregs[32];
-};
-
-#endif
diff --git a/arch/nios2/include/uapi/asm/signal.h b/arch/nios2/include/uapi/asm/signal.h
deleted file mode 100644
index b0d983068fa5..000000000000
--- a/arch/nios2/include/uapi/asm/signal.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright Altera Corporation (C) 2013. All rights reserved
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-#ifndef _ASM_NIOS2_SIGNAL_H
-#define _ASM_NIOS2_SIGNAL_H
-
-#define SA_RESTORER 0x04000000
-#include <asm-generic/signal.h>
-
-#endif /* _ASM_NIOS2_SIGNAL_H */
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
deleted file mode 100644
index 1f0e0f5538d9..000000000000
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2013 Altera Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-#include <asm/unistd_32.h>
diff --git a/arch/nios2/kernel/.gitignore b/arch/nios2/kernel/.gitignore
deleted file mode 100644
index bbb90f92d051..000000000000
--- a/arch/nios2/kernel/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-vmlinux.lds
diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
deleted file mode 100644
index 4dce965a7b73..000000000000
--- a/arch/nios2/kernel/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the nios2 linux kernel.
-#
-
-always-$(KBUILD_BUILTIN)	+= vmlinux.lds
-
-obj-y	+= head.o
-obj-y	+= cpuinfo.o
-obj-y	+= entry.o
-obj-y	+= insnemu.o
-obj-y	+= irq.o
-obj-y	+= nios2_ksyms.o
-obj-y	+= process.o
-obj-y	+= prom.o
-obj-y	+= ptrace.o
-obj-y	+= setup.o
-obj-y	+= signal.o
-obj-y	+= sys_nios2.o
-obj-y	+= syscall_table.o
-obj-y	+= time.o
-obj-y	+= traps.o
-
-obj-$(CONFIG_KGDB)			+= kgdb.o
-obj-$(CONFIG_MODULES)			+= module.o
-obj-$(CONFIG_NIOS2_ALIGNMENT_TRAP)	+= misaligned.o
diff --git a/arch/nios2/kernel/Makefile.syscalls b/arch/nios2/kernel/Makefile.syscalls
deleted file mode 100644
index 579a9daec272..000000000000
--- a/arch/nios2/kernel/Makefile.syscalls
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 += nios2 time32 stat64 renameat rlimit
diff --git a/arch/nios2/kernel/asm-offsets.c b/arch/nios2/kernel/asm-offsets.c
deleted file mode 100644
index 88190b503ce5..000000000000
--- a/arch/nios2/kernel/asm-offsets.c
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- */
-#define COMPILE_OFFSETS
-
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <linux/ptrace.h>
-#include <linux/hardirq.h>
-#include <linux/thread_info.h>
-#include <linux/kbuild.h>
-
-int main(void)
-{
-	/* struct task_struct */
-	OFFSET(TASK_THREAD, task_struct, thread);
-	BLANK();
-
-	/* struct thread_struct */
-	OFFSET(THREAD_KSP, thread_struct, ksp);
-	OFFSET(THREAD_KPSR, thread_struct, kpsr);
-	BLANK();
-
-	/* struct pt_regs */
-	OFFSET(PT_ORIG_R2, pt_regs, orig_r2);
-	OFFSET(PT_ORIG_R7, pt_regs, orig_r7);
-
-	OFFSET(PT_R1, pt_regs, r1);
-	OFFSET(PT_R2, pt_regs, r2);
-	OFFSET(PT_R3, pt_regs, r3);
-	OFFSET(PT_R4, pt_regs, r4);
-	OFFSET(PT_R5, pt_regs, r5);
-	OFFSET(PT_R6, pt_regs, r6);
-	OFFSET(PT_R7, pt_regs, r7);
-	OFFSET(PT_R8, pt_regs, r8);
-	OFFSET(PT_R9, pt_regs, r9);
-	OFFSET(PT_R10, pt_regs, r10);
-	OFFSET(PT_R11, pt_regs, r11);
-	OFFSET(PT_R12, pt_regs, r12);
-	OFFSET(PT_R13, pt_regs, r13);
-	OFFSET(PT_R14, pt_regs, r14);
-	OFFSET(PT_R15, pt_regs, r15);
-	OFFSET(PT_EA, pt_regs, ea);
-	OFFSET(PT_RA, pt_regs, ra);
-	OFFSET(PT_FP, pt_regs, fp);
-	OFFSET(PT_SP, pt_regs, sp);
-	OFFSET(PT_GP, pt_regs, gp);
-	OFFSET(PT_ESTATUS, pt_regs, estatus);
-	DEFINE(PT_REGS_SIZE, sizeof(struct pt_regs));
-	BLANK();
-
-	/* struct switch_stack */
-	OFFSET(SW_R16, switch_stack, r16);
-	OFFSET(SW_R17, switch_stack, r17);
-	OFFSET(SW_R18, switch_stack, r18);
-	OFFSET(SW_R19, switch_stack, r19);
-	OFFSET(SW_R20, switch_stack, r20);
-	OFFSET(SW_R21, switch_stack, r21);
-	OFFSET(SW_R22, switch_stack, r22);
-	OFFSET(SW_R23, switch_stack, r23);
-	OFFSET(SW_FP, switch_stack, fp);
-	OFFSET(SW_GP, switch_stack, gp);
-	OFFSET(SW_RA, switch_stack, ra);
-	DEFINE(SWITCH_STACK_SIZE, sizeof(struct switch_stack));
-	BLANK();
-
-	/* struct thread_info */
-	OFFSET(TI_FLAGS, thread_info, flags);
-	OFFSET(TI_PREEMPT_COUNT, thread_info, preempt_count);
-	BLANK();
-
-	return 0;
-}
diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
deleted file mode 100644
index 55882feb6249..000000000000
--- a/arch/nios2/kernel/cpuinfo.c
+++ /dev/null
@@ -1,192 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- *
- * Based on cpuinfo.c from microblaze
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/string.h>
-#include <linux/of.h>
-#include <asm/cpuinfo.h>
-
-struct cpuinfo cpuinfo;
-
-#define err_cpu(x) \
-	pr_err("ERROR: Nios II " x " different for kernel and DTS\n")
-
-static inline u32 fcpu(struct device_node *cpu, const char *n)
-{
-	u32 val = 0;
-
-	of_property_read_u32(cpu, n, &val);
-
-	return val;
-}
-
-void __init setup_cpuinfo(void)
-{
-	struct device_node *cpu;
-	const char *str;
-	int len;
-
-	cpu = of_get_cpu_node(0, NULL);
-	if (!cpu)
-		panic("%s: No CPU found in devicetree!\n", __func__);
-
-	if (!of_property_read_bool(cpu, "altr,has-initda"))
-		panic("initda instruction is unimplemented. Please update your "
-			"hardware system to have more than 4-byte line data "
-			"cache\n");
-
-	cpuinfo.cpu_clock_freq = fcpu(cpu, "clock-frequency");
-
-	str = of_get_property(cpu, "altr,implementation", &len);
-	strscpy(cpuinfo.cpu_impl, str ?: "<unknown>");
-
-	cpuinfo.has_div = of_property_read_bool(cpu, "altr,has-div");
-	cpuinfo.has_mul = of_property_read_bool(cpu, "altr,has-mul");
-	cpuinfo.has_mulx = of_property_read_bool(cpu, "altr,has-mulx");
-	cpuinfo.has_bmx = of_property_read_bool(cpu, "altr,has-bmx");
-	cpuinfo.has_cdx = of_property_read_bool(cpu, "altr,has-cdx");
-	cpuinfo.mmu = of_property_read_bool(cpu, "altr,has-mmu");
-
-	if (IS_ENABLED(CONFIG_NIOS2_HW_DIV_SUPPORT) && !cpuinfo.has_div)
-		err_cpu("DIV");
-
-	if (IS_ENABLED(CONFIG_NIOS2_HW_MUL_SUPPORT) && !cpuinfo.has_mul)
-		err_cpu("MUL");
-
-	if (IS_ENABLED(CONFIG_NIOS2_HW_MULX_SUPPORT) && !cpuinfo.has_mulx)
-		err_cpu("MULX");
-
-	if (IS_ENABLED(CONFIG_NIOS2_BMX_SUPPORT) && !cpuinfo.has_bmx)
-		err_cpu("BMX");
-
-	if (IS_ENABLED(CONFIG_NIOS2_CDX_SUPPORT) && !cpuinfo.has_cdx)
-		err_cpu("CDX");
-
-	cpuinfo.tlb_num_ways = fcpu(cpu, "altr,tlb-num-ways");
-	if (!cpuinfo.tlb_num_ways)
-		panic("altr,tlb-num-ways can't be 0. Please check your hardware "
-			"system\n");
-	cpuinfo.icache_line_size = fcpu(cpu, "icache-line-size");
-	cpuinfo.icache_size = fcpu(cpu, "icache-size");
-	if (CONFIG_NIOS2_ICACHE_SIZE != cpuinfo.icache_size)
-		pr_warn("Warning: icache size configuration mismatch "
-		"(0x%x vs 0x%x) of CONFIG_NIOS2_ICACHE_SIZE vs "
-		"device tree icache-size\n",
-		CONFIG_NIOS2_ICACHE_SIZE, cpuinfo.icache_size);
-
-	cpuinfo.dcache_line_size = fcpu(cpu, "dcache-line-size");
-	if (CONFIG_NIOS2_DCACHE_LINE_SIZE != cpuinfo.dcache_line_size)
-		pr_warn("Warning: dcache line size configuration mismatch "
-		"(0x%x vs 0x%x) of CONFIG_NIOS2_DCACHE_LINE_SIZE vs "
-		"device tree dcache-line-size\n",
-		CONFIG_NIOS2_DCACHE_LINE_SIZE, cpuinfo.dcache_line_size);
-	cpuinfo.dcache_size = fcpu(cpu, "dcache-size");
-	if (CONFIG_NIOS2_DCACHE_SIZE != cpuinfo.dcache_size)
-		pr_warn("Warning: dcache size configuration mismatch "
-			"(0x%x vs 0x%x) of CONFIG_NIOS2_DCACHE_SIZE vs "
-			"device tree dcache-size\n",
-			CONFIG_NIOS2_DCACHE_SIZE, cpuinfo.dcache_size);
-
-	cpuinfo.tlb_pid_num_bits = fcpu(cpu, "altr,pid-num-bits");
-	cpuinfo.tlb_num_ways_log2 = ilog2(cpuinfo.tlb_num_ways);
-	cpuinfo.tlb_num_entries = fcpu(cpu, "altr,tlb-num-entries");
-	cpuinfo.tlb_num_lines = cpuinfo.tlb_num_entries / cpuinfo.tlb_num_ways;
-	cpuinfo.tlb_ptr_sz = fcpu(cpu, "altr,tlb-ptr-sz");
-
-	cpuinfo.reset_addr = fcpu(cpu, "altr,reset-addr");
-	cpuinfo.exception_addr = fcpu(cpu, "altr,exception-addr");
-	cpuinfo.fast_tlb_miss_exc_addr = fcpu(cpu, "altr,fast-tlb-miss-addr");
-
-	of_node_put(cpu);
-}
-
-#ifdef CONFIG_PROC_FS
-
-/*
- * Get CPU information for use by the procfs.
- */
-static int show_cpuinfo(struct seq_file *m, void *v)
-{
-	const u32 clockfreq = cpuinfo.cpu_clock_freq;
-
-	seq_printf(m,
-		   "CPU:\t\tNios II/%s\n"
-		   "REV:\t\t%i\n"
-		   "MMU:\t\t%s\n"
-		   "FPU:\t\tnone\n"
-		   "Clocking:\t%u.%02u MHz\n"
-		   "BogoMips:\t%lu.%02lu\n"
-		   "Calibration:\t%lu loops\n",
-		   cpuinfo.cpu_impl,
-		   CONFIG_NIOS2_ARCH_REVISION,
-		   cpuinfo.mmu ? "present" : "none",
-		   clockfreq / 1000000, (clockfreq / 100000) % 10,
-		   (loops_per_jiffy * HZ) / 500000,
-		   ((loops_per_jiffy * HZ) / 5000) % 100,
-		   (loops_per_jiffy * HZ));
-
-	seq_printf(m,
-		   "HW:\n"
-		   " MUL:\t\t%s\n"
-		   " MULX:\t\t%s\n"
-		   " DIV:\t\t%s\n"
-		   " BMX:\t\t%s\n"
-		   " CDX:\t\t%s\n",
-		   str_yes_no(cpuinfo.has_mul),
-		   str_yes_no(cpuinfo.has_mulx),
-		   str_yes_no(cpuinfo.has_div),
-		   str_yes_no(cpuinfo.has_bmx),
-		   str_yes_no(cpuinfo.has_cdx));
-
-	seq_printf(m,
-		   "Icache:\t\t%ukB, line length: %u\n",
-		   cpuinfo.icache_size >> 10,
-		   cpuinfo.icache_line_size);
-
-	seq_printf(m,
-		   "Dcache:\t\t%ukB, line length: %u\n",
-		   cpuinfo.dcache_size >> 10,
-		   cpuinfo.dcache_line_size);
-
-	seq_printf(m,
-		   "TLB:\t\t%u ways, %u entries, %u PID bits\n",
-		   cpuinfo.tlb_num_ways,
-		   cpuinfo.tlb_num_entries,
-		   cpuinfo.tlb_pid_num_bits);
-
-	return 0;
-}
-
-static void *cpuinfo_start(struct seq_file *m, loff_t *pos)
-{
-	unsigned long i = *pos;
-
-	return i < num_possible_cpus() ? (void *) (i + 1) : NULL;
-}
-
-static void *cpuinfo_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	++*pos;
-	return cpuinfo_start(m, pos);
-}
-
-static void cpuinfo_stop(struct seq_file *m, void *v)
-{
-}
-
-const struct seq_operations cpuinfo_op = {
-	.start	= cpuinfo_start,
-	.next	= cpuinfo_next,
-	.stop	= cpuinfo_stop,
-	.show	= show_cpuinfo
-};
-
-#endif /* CONFIG_PROC_FS */
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
deleted file mode 100644
index dd40dfd908e5..000000000000
--- a/arch/nios2/kernel/entry.S
+++ /dev/null
@@ -1,574 +0,0 @@
-/*
- * linux/arch/nios2/kernel/entry.S
- *
- * Copyright (C) 2013-2014  Altera Corporation
- * Copyright (C) 2009, Wind River Systems Inc
- *
- * Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- *  Copyright (C) 1999-2002, Greg Ungerer (gerg@snapgear.com)
- *  Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>,
- *                      Kenneth Albanowski <kjahds@kjahds.com>,
- *  Copyright (C) 2000  Lineo Inc. (www.lineo.com)
- *  Copyright (C) 2004  Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Linux/m68k support by Hamish Macdonald
- *
- * 68060 fixes by Jesper Skov
- * ColdFire support by Greg Ungerer (gerg@snapgear.com)
- * 5307 fixes by David W. Miller
- * linux 2.4 support David McCullough <davidm@snapgear.com>
- */
-
-#include <linux/sys.h>
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/asm-macros.h>
-#include <asm/thread_info.h>
-#include <asm/errno.h>
-#include <asm/setup.h>
-#include <asm/entry.h>
-#include <asm/unistd.h>
-#include <asm/processor.h>
-
-.macro GET_THREAD_INFO reg
-.if THREAD_SIZE & 0xffff0000
-	andhi	\reg, sp, %hi(~(THREAD_SIZE-1))
-.else
-	addi	\reg, r0, %lo(~(THREAD_SIZE-1))
-	and	\reg, \reg, sp
-.endif
-.endm
-
-.macro	kuser_cmpxchg_check
-	/*
-	 * Make sure our user space atomic helper is restarted if it was
-	 * interrupted in a critical region.
-	 * ea-4 = address of interrupted insn (ea must be preserved).
-	 * sp = saved regs.
-	 * cmpxchg_ldw = first critical insn, cmpxchg_stw = last critical insn.
-	 * If ea <= cmpxchg_stw and ea > cmpxchg_ldw then saved EA is set to
-	 * cmpxchg_ldw + 4.
-	*/
-	/* et = cmpxchg_stw + 4 */
-	movui   et, (KUSER_BASE + 4 + (cmpxchg_stw - __kuser_helper_start))
-	bgtu	ea, et, 1f
-
-	subi	et, et, (cmpxchg_stw - cmpxchg_ldw) /* et = cmpxchg_ldw + 4 */
-	bltu	ea, et, 1f
-	stw	et, PT_EA(sp)	/* fix up EA */
-	mov	ea, et
-1:
-.endm
-
-.section .rodata
-.align 4
-exception_table:
-	.word unhandled_exception	/* 0 - Reset */
-	.word unhandled_exception	/* 1 - Processor-only Reset */
-	.word external_interrupt	/* 2 - Interrupt */
-	.word handle_trap		/* 3 - Trap Instruction */
-
-	.word instruction_trap		/* 4 - Unimplemented instruction */
-	.word handle_illegal		/* 5 - Illegal instruction */
-	.word handle_unaligned		/* 6 - Misaligned data access */
-	.word handle_unaligned		/* 7 - Misaligned destination address */
-
-	.word handle_diverror		/* 8 - Division error */
-	.word protection_exception_ba	/* 9 - Supervisor-only instr. address */
-	.word protection_exception_instr /* 10 - Supervisor only instruction */
-	.word protection_exception_ba	/* 11 - Supervisor only data address */
-
-	.word unhandled_exception	/* 12 - Double TLB miss (data) */
-	.word protection_exception_pte	/* 13 - TLB permission violation (x) */
-	.word protection_exception_pte	/* 14 - TLB permission violation (r) */
-	.word protection_exception_pte	/* 15 - TLB permission violation (w) */
-
-	.word unhandled_exception	/* 16 - MPU region violation */
-
-trap_table:
-	.word	handle_system_call	/* 0  */
-	.word	handle_trap_1		/* 1  */
-	.word	handle_trap_2		/* 2  */
-	.word	handle_trap_3		/* 3  */
-	.word	handle_trap_reserved	/* 4  */
-	.word	handle_trap_reserved	/* 5  */
-	.word	handle_trap_reserved	/* 6  */
-	.word	handle_trap_reserved	/* 7  */
-	.word	handle_trap_reserved	/* 8  */
-	.word	handle_trap_reserved	/* 9  */
-	.word	handle_trap_reserved	/* 10 */
-	.word	handle_trap_reserved	/* 11 */
-	.word	handle_trap_reserved	/* 12 */
-	.word	handle_trap_reserved	/* 13 */
-	.word	handle_trap_reserved	/* 14 */
-	.word	handle_trap_reserved	/* 15 */
-	.word	handle_trap_reserved	/* 16 */
-	.word	handle_trap_reserved	/* 17 */
-	.word	handle_trap_reserved	/* 18 */
-	.word	handle_trap_reserved	/* 19 */
-	.word	handle_trap_reserved	/* 20 */
-	.word	handle_trap_reserved	/* 21 */
-	.word	handle_trap_reserved	/* 22 */
-	.word	handle_trap_reserved	/* 23 */
-	.word	handle_trap_reserved	/* 24 */
-	.word	handle_trap_reserved	/* 25 */
-	.word	handle_trap_reserved	/* 26 */
-	.word	handle_trap_reserved	/* 27 */
-	.word	handle_trap_reserved	/* 28 */
-	.word	handle_trap_reserved	/* 29 */
-#ifdef CONFIG_KGDB
-	.word	handle_kgdb_breakpoint	/* 30 KGDB breakpoint */
-#else
-	.word	instruction_trap		/* 30 */
-#endif
-	.word	handle_breakpoint	/* 31 */
-
-.text
-.set noat
-.set nobreak
-
-ENTRY(inthandler)
-	SAVE_ALL
-
-	kuser_cmpxchg_check
-
-	/* Clear EH bit before we get a new excpetion in the kernel
-	 * and after we have saved it to the exception frame. This is done
-	 * whether it's trap, tlb-miss or interrupt. If we don't do this
-	 * estatus is not updated the next exception.
-	 */
-	rdctl	r24, status
-	movi	r9, %lo(~STATUS_EH)
-	and	r24, r24, r9
-	wrctl	status, r24
-
-	/* Read cause and vector and branch to the associated handler */
-	mov	r4, sp
-	rdctl	r5, exception
-	movia	r9, exception_table
-	add	r24, r9, r5
-	ldw	r24, 0(r24)
-	jmp	r24
-
-
-/***********************************************************************
- * Handle traps
- ***********************************************************************
- */
-ENTRY(handle_trap)
-	ldwio	r24, -4(ea)	/* instruction that caused the exception */
-	srli	r24, r24, 4
-	andi	r24, r24, 0x7c
-	movia	r9,trap_table
-	add	r24, r24, r9
-	ldw	r24, 0(r24)
-	jmp	r24
-
-
-/***********************************************************************
- * Handle system calls
- ***********************************************************************
- */
-ENTRY(handle_system_call)
-	/* Enable interrupts */
-	rdctl	r10, status
-	ori	r10, r10, STATUS_PIE
-	wrctl	status, r10
-
-	/* Reload registers destroyed by common code. */
-	ldw	r4, PT_R4(sp)
-	ldw	r5, PT_R5(sp)
-
-local_restart:
-	stw	r2, PT_ORIG_R2(sp)
-	/* Check that the requested system call is within limits */
-	movui	r1, __NR_syscalls
-	bgeu	r2, r1, ret_invsyscall
-	slli	r1, r2, 2
-	movhi	r11, %hiadj(sys_call_table)
-	add	r1, r1, r11
-	ldw	r1, %lo(sys_call_table)(r1)
-
-	/* Check if we are being traced */
-	GET_THREAD_INFO r11
-	ldw	r11,TI_FLAGS(r11)
-	BTBNZ   r11,r11,TIF_SYSCALL_TRACE,traced_system_call
-
-	/* Execute the system call */
-	callr	r1
-
-	/* If the syscall returns a negative result:
-	 *   Set r7 to 1 to indicate error,
-	 *   Negate r2 to get a positive error code
-	 * If the syscall returns zero or a positive value:
-	 *   Set r7 to 0.
-	 * The sigreturn system calls will skip the code below by
-	 * adding to register ra. To avoid destroying registers
-	 */
-translate_rc_and_ret:
-	movi	r1, 0
-	bge	r2, zero, 3f
-	ldw	r1, PT_ORIG_R2(sp)
-	addi	r1, r1, 1
-	beq	r1, zero, 3f
-	sub	r2, zero, r2
-	movi	r1, 1
-3:
-	stw	r2, PT_R2(sp)
-	stw	r1, PT_R7(sp)
-end_translate_rc_and_ret:
-
-ret_from_exception:
-	ldw	r1, PT_ESTATUS(sp)
-	/* if so, skip resched, signals */
-	TSTBNZ	r1, r1, ESTATUS_EU, Luser_return
-
-restore_all:
-	rdctl	r10, status			/* disable intrs */
-	andi	r10, r10, %lo(~STATUS_PIE)
-	wrctl	status, r10
-	RESTORE_ALL
-	eret
-
-	/* If the syscall number was invalid return ENOSYS */
-ret_invsyscall:
-	movi	r2, -ENOSYS
-	br	translate_rc_and_ret
-
-	/* This implements the same as above, except it calls
-	 * do_syscall_trace_enter and do_syscall_trace_exit before and after the
-	 * syscall in order for utilities like strace and gdb to work.
-	 */
-traced_system_call:
-	SAVE_SWITCH_STACK
-	call	do_syscall_trace_enter
-	RESTORE_SWITCH_STACK
-
-	/* Create system call register arguments. The 5th and 6th
-	   arguments on stack are already in place at the beginning
-	   of pt_regs. */
-	ldw	r2, PT_R2(sp)
-	ldw	r4, PT_R4(sp)
-	ldw	r5, PT_R5(sp)
-	ldw	r6, PT_R6(sp)
-	ldw	r7, PT_R7(sp)
-
-	/* Fetch the syscall function. */
-	movui	r1, __NR_syscalls
-	bgeu	r2, r1, traced_invsyscall
-	slli	r1, r2, 2
-	movhi	r11,%hiadj(sys_call_table)
-	add	r1, r1, r11
-	ldw	r1, %lo(sys_call_table)(r1)
-
-	callr	r1
-
-	/* If the syscall returns a negative result:
-	 *   Set r7 to 1 to indicate error,
-	 *   Negate r2 to get a positive error code
-	 * If the syscall returns zero or a positive value:
-	 *   Set r7 to 0.
-	 * The sigreturn system calls will skip the code below by
-	 * adding to register ra. To avoid destroying registers
-	 */
-translate_rc_and_ret2:
-	movi	r1, 0
-	bge	r2, zero, 4f
-	ldw	r1, PT_ORIG_R2(sp)
-	addi	r1, r1, 1
-	beq	r1, zero, 4f
-	sub	r2, zero, r2
-	movi	r1, 1
-4:
-	stw	r2, PT_R2(sp)
-	stw	r1, PT_R7(sp)
-end_translate_rc_and_ret2:
-	SAVE_SWITCH_STACK
-	call	do_syscall_trace_exit
-	RESTORE_SWITCH_STACK
-	br	ret_from_exception
-
-	/* If the syscall number was invalid return ENOSYS */
-traced_invsyscall:
-	movi	r2, -ENOSYS
-	br	translate_rc_and_ret2
-
-Luser_return:
-	GET_THREAD_INFO	r11			/* get thread_info pointer */
-	ldw	r10, TI_FLAGS(r11)		/* get thread_info->flags */
-	ANDI32	r11, r10, _TIF_WORK_MASK
-	beq	r11, r0, restore_all		/* Nothing to do */
-	BTBZ	r1, r10, TIF_NEED_RESCHED, Lsignal_return
-
-	/* Reschedule work */
-	call	schedule
-	br	ret_from_exception
-
-Lsignal_return:
-	ANDI32	r1, r10, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME
-	beq	r1, r0, restore_all
-	mov	r4, sp			/* pt_regs */
-	SAVE_SWITCH_STACK
-	call	do_notify_resume
-	beq	r2, r0, no_work_pending
-	RESTORE_SWITCH_STACK
-	/* prepare restart syscall here without leaving kernel */
-	ldw	r2, PT_R2(sp)	/* reload syscall number in r2 */
-	ldw 	r4, PT_R4(sp)	/* reload syscall arguments r4-r9 */
-	ldw 	r5, PT_R5(sp)
-	ldw 	r6, PT_R6(sp)
-	ldw 	r7, PT_R7(sp)
-	ldw 	r8, PT_R8(sp)
-	ldw 	r9, PT_R9(sp)
-	br	local_restart	/* restart syscall */
-
-no_work_pending:
-	RESTORE_SWITCH_STACK
-	br	ret_from_exception
-
-/***********************************************************************
- * Handle external interrupts.
- ***********************************************************************
- */
-/*
- * This is the generic interrupt handler (for all hardware interrupt
- * sources). It figures out the vector number and calls the appropriate
- * interrupt service routine directly.
- */
-external_interrupt:
-	rdctl	r12, ipending
-	rdctl	r9, ienable
-	and	r12, r12, r9
-	/* skip if no interrupt is pending */
-	beq	r12, r0, ret_from_interrupt
-
-	/*
-	 * Process an external hardware interrupt.
-	 */
-
-	addi	ea, ea, -4	/* re-issue the interrupted instruction */
-	stw	ea, PT_EA(sp)
-2:	movi	r4, %lo(-1)	/* Start from bit position 0,
-					highest priority */
-				/* This is the IRQ # for handler call */
-1:	andi	r10, r12, 1	/* Isolate bit we are interested in */
-	srli	r12, r12, 1	/* shift count is costly without hardware
-					multiplier */
-	addi	r4, r4, 1
-	beq	r10, r0, 1b
-	mov	r5, sp		/* Setup pt_regs pointer for handler call */
-	call	do_IRQ
-	rdctl	r12, ipending	/* check again if irq still pending */
-	rdctl	r9, ienable	/* Isolate possible interrupts */
-	and	r12, r12, r9
-	bne	r12, r0, 2b
-	/* br	ret_from_interrupt */ /* fall through to ret_from_interrupt */
-
-ENTRY(ret_from_interrupt)
-	ldw	r1, PT_ESTATUS(sp)	/* check if returning to kernel */
-	TSTBNZ	r1, r1, ESTATUS_EU, Luser_return
-
-#ifdef CONFIG_PREEMPTION
-	GET_THREAD_INFO	r1
-	ldw	r4, TI_PREEMPT_COUNT(r1)
-	bne	r4, r0, restore_all
-	ldw	r4, TI_FLAGS(r1)		/* ? Need resched set */
-	BTBZ	r10, r4, TIF_NEED_RESCHED, restore_all
-	ldw	r4, PT_ESTATUS(sp)	/* ? Interrupts off */
-	andi	r10, r4, ESTATUS_EPIE
-	beq	r10, r0, restore_all
-	call	preempt_schedule_irq
-#endif
-	br	restore_all
-
-/***********************************************************************
- * A few syscall wrappers
- ***********************************************************************
- */
-/*
- * int clone(unsigned long clone_flags, unsigned long newsp,
- *		int __user * parent_tidptr, int __user * child_tidptr,
- *		int tls_val)
- */
-ENTRY(sys_clone)
-	SAVE_SWITCH_STACK
-	subi    sp, sp, 4 /* make space for tls pointer */
-	stw     r8, 0(sp) /* pass tls pointer (r8) via stack (5th argument) */
-	call	nios2_clone
-	addi    sp, sp, 4
-	RESTORE_SWITCH_STACK
-	ret
-/* long syscall(SYS_clone3, struct clone_args *cl_args, size_t size); */
-ENTRY(__sys_clone3)
-	SAVE_SWITCH_STACK
-	call	sys_clone3
-	RESTORE_SWITCH_STACK
-	ret
-
-ENTRY(sys_rt_sigreturn)
-	SAVE_SWITCH_STACK
-	mov	r4, sp
-	call	do_rt_sigreturn
-	RESTORE_SWITCH_STACK
-	addi	ra, ra, (end_translate_rc_and_ret - translate_rc_and_ret)
-	ret
-
-/***********************************************************************
- * A few other wrappers and stubs
- ***********************************************************************
- */
-protection_exception_pte:
-	rdctl	r6, pteaddr
-	slli	r6, r6, 10
-	call	do_page_fault
-	br	ret_from_exception
-
-protection_exception_ba:
-	rdctl	r6, badaddr
-	call	do_page_fault
-	br	ret_from_exception
-
-protection_exception_instr:
-	call	handle_supervisor_instr
-	br	ret_from_exception
-
-handle_breakpoint:
-	call	breakpoint_c
-	br	ret_from_exception
-
-#ifdef CONFIG_NIOS2_ALIGNMENT_TRAP
-handle_unaligned:
-	SAVE_SWITCH_STACK
-	call	handle_unaligned_c
-	RESTORE_SWITCH_STACK
-	br	ret_from_exception
-#else
-handle_unaligned:
-	call	handle_unaligned_c
-	br	ret_from_exception
-#endif
-
-handle_illegal:
-	call	handle_illegal_c
-	br	ret_from_exception
-
-handle_diverror:
-	call	handle_diverror_c
-	br	ret_from_exception
-
-#ifdef CONFIG_KGDB
-handle_kgdb_breakpoint:
-	call	kgdb_breakpoint_c
-	br	ret_from_exception
-#endif
-
-handle_trap_1:
-	call	handle_trap_1_c
-	br	ret_from_exception
-
-handle_trap_2:
-	call	handle_trap_2_c
-	br	ret_from_exception
-
-handle_trap_3:
-handle_trap_reserved:
-	call	handle_trap_3_c
-	br	ret_from_exception
-
-/*
- * Beware - when entering resume, prev (the current task) is
- * in r4, next (the new task) is in r5, don't change these
- * registers.
- */
-ENTRY(resume)
-
-	rdctl	r7, status			/* save thread status reg */
-	stw	r7, TASK_THREAD + THREAD_KPSR(r4)
-
-	andi	r7, r7, %lo(~STATUS_PIE)	/* disable interrupts */
-	wrctl	status, r7
-
-	SAVE_SWITCH_STACK
-	stw	sp, TASK_THREAD + THREAD_KSP(r4)/* save kernel stack pointer */
-	ldw	sp, TASK_THREAD + THREAD_KSP(r5)/* restore new thread stack */
-	movia	r24, _current_thread		/* save thread */
-	GET_THREAD_INFO r1
-	stw	r1, 0(r24)
-	RESTORE_SWITCH_STACK
-
-	ldw	r7, TASK_THREAD + THREAD_KPSR(r5)/* restore thread status reg */
-	wrctl	status, r7
-	ret
-
-ENTRY(ret_from_fork)
-	call	schedule_tail
-	br	ret_from_exception
-
-ENTRY(ret_from_kernel_thread)
-	call	schedule_tail
-	mov	r4,r17	/* arg */
-	callr	r16	/* function */
-	br	ret_from_exception
-
-/*
- * Kernel user helpers.
- *
- * Each segment is 64-byte aligned and will be mapped to the <User space>.
- * New segments (if ever needed) must be added after the existing ones.
- * This mechanism should be used only for things that are really small and
- * justified, and not be abused freely.
- *
- */
-
- /* Filling pads with undefined instructions. */
-.macro	kuser_pad sym size
-	.if	((. - \sym) & 3)
-	.rept	(4 - (. - \sym) & 3)
-	.byte	0
-	.endr
-	.endif
-	.rept	((\size - (. - \sym)) / 4)
-	.word	0xdeadbeef
-	.endr
-.endm
-
-	.align	6
-	.globl	__kuser_helper_start
-__kuser_helper_start:
-
-__kuser_helper_version:				/* @ 0x1000 */
-	.word	((__kuser_helper_end - __kuser_helper_start) >> 6)
-
-__kuser_cmpxchg:				/* @ 0x1004 */
-	/*
-	 * r4 pointer to exchange variable
-	 * r5 old value
-	 * r6 new value
-	 */
-cmpxchg_ldw:
-	ldw	r2, 0(r4)			/* load current value */
-	sub	r2, r2, r5			/* compare with old value */
-	bne	r2, zero, cmpxchg_ret
-
-	/* We had a match, store the new value */
-cmpxchg_stw:
-	stw	r6, 0(r4)
-cmpxchg_ret:
-	ret
-
-	kuser_pad __kuser_cmpxchg, 64
-
-	.globl	__kuser_sigtramp
-__kuser_sigtramp:
-	movi	r2, __NR_rt_sigreturn
-	trap
-
-	kuser_pad __kuser_sigtramp, 64
-
-	.globl	__kuser_helper_end
-__kuser_helper_end:
diff --git a/arch/nios2/kernel/head.S b/arch/nios2/kernel/head.S
deleted file mode 100644
index 613212e1a63a..000000000000
--- a/arch/nios2/kernel/head.S
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright (C) 2009 Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- * Copyright (C) 2004 Microtronix Datacom Ltd
- * Copyright (C) 2001 Vic Phillips, Microtronix Datacom Ltd.
- *
- * Based on head.S for Altera's Excalibur development board with nios processor
- *
- * Based on the following from the Excalibur sdk distribution:
- *	NA_MemoryMap.s, NR_JumpToStart.s, NR_Setup.s, NR_CWPManager.s
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/init.h>
-#include <linux/linkage.h>
-#include <asm/thread_info.h>
-#include <asm/processor.h>
-#include <asm/cache.h>
-#include <asm/page.h>
-#include <asm/asm-offsets.h>
-#include <asm/asm-macros.h>
-
-/*
- * This global variable is used as an extension to the nios'
- * STATUS register to emulate a user/supervisor mode.
- */
-	.data
-	.align	2
-	.set noat
-
-	.global _current_thread
-_current_thread:
-	.long	0
-/*
- * Input(s): passed from u-boot
- *   r4 - Optional pointer to a board information structure.
- *   r5 - Optional pointer to the physical starting address of the init RAM
- *        disk.
- *   r6 - Optional pointer to the physical ending address of the init RAM
- *        disk.
- *   r7 - Optional pointer to the physical starting address of any kernel
- *        command-line parameters.
- */
-
-/*
- * First executable code - detected and jumped to by the ROM bootstrap
- * if the code resides in flash (looks for "Nios" at offset 0x0c from
- * the potential executable image).
- */
-	__HEAD
-ENTRY(_start)
-	wrctl	status, r0		/* Disable interrupts */
-
-	/* Initialize all cache lines within the instruction cache */
-	movia	r1, NIOS2_ICACHE_SIZE
-	movui	r2, NIOS2_ICACHE_LINE_SIZE
-
-icache_init:
-	initi	r1
-	sub	r1, r1, r2
-	bgt	r1, r0, icache_init
-	br	1f
-
-	/*
-	 * This is the default location for the exception handler. Code in jump
-	 * to our handler
-	 */
-ENTRY(exception_handler_hook)
-	movia	r24, inthandler
-	jmp	r24
-
-ENTRY(fast_handler)
-	nextpc et
-helper:
-	stw	r3, r3save - helper(et)
-
-	rdctl	r3 , pteaddr
-	srli	r3, r3, 12
-	slli	r3, r3, 2
-	movia	et, pgd_current
-
-	ldw	et, 0(et)
-	add	r3, et, r3
-	ldw	et, 0(r3)
-
-	rdctl	r3, pteaddr
-	andi	r3, r3, 0xfff
-	add	et, r3, et
-	ldw	et, 0(et)
-	wrctl	tlbacc, et
-	nextpc	et
-helper2:
-	ldw	r3, r3save - helper2(et)
-	subi	ea, ea, 4
-	eret
-r3save:
-	.word 0x0
-ENTRY(fast_handler_end)
-
-1:
-	/*
-	 * After the instruction cache is initialized, the data cache must
-	 * also be initialized.
-	 */
-	movia	r1, NIOS2_DCACHE_SIZE
-	movui	r2, NIOS2_DCACHE_LINE_SIZE
-
-dcache_init:
-	initd	0(r1)
-	sub	r1, r1, r2
-	bgt	r1, r0, dcache_init
-
-	nextpc	r1			/* Find out where we are */
-chkadr:
-	movia	r2, chkadr
-	beq	r1, r2,finish_move	/* We are running in RAM done */
-	addi	r1, r1,(_start - chkadr)	/* Source */
-	movia	r2, _start		/* Destination */
-	movia	r3, __bss_start		/* End of copy */
-
-loop_move:				/* r1: src, r2: dest, r3: last dest */
-	ldw	r8, 0(r1)		/* load a word from [r1] */
-	stw	r8, 0(r2)		/* store a word to dest [r2] */
-	flushd	0(r2)			/* Flush cache for safety */
-	addi 	r1, r1, 4		/* inc the src addr */
-	addi	r2, r2, 4		/* inc the dest addr */
-	blt	r2, r3, loop_move
-
-	movia	r1, finish_move		/* VMA(_start)->l1 */
-	jmp	r1			/* jmp to _start */
-
-finish_move:
-
-	/* Mask off all possible interrupts */
-	wrctl	ienable, r0
-
-	/* Clear .bss */
-	movia	r2, __bss_start
-	movia	r1, __bss_stop
-1:
-	stb	r0, 0(r2)
-	addi	r2, r2, 1
-	bne	r1, r2, 1b
-
-	movia	r1, init_thread_union	/* set stack at top of the task union */
-	addi	sp, r1, THREAD_SIZE
-	movia	r2, _current_thread	/* Remember current thread */
-	stw	r1, 0(r2)
-
-	movia	r1, nios2_boot_init	/* save args r4-r7 passed from u-boot */
-	callr	r1
-
-	movia	r1, start_kernel	/* call start_kernel as a subroutine */
-	callr	r1
-
-	/* If we return from start_kernel, break to the oci debugger and
-	 * buggered we are.
-	 */
-	break
-
-	/* End of startup code */
-.set at
diff --git a/arch/nios2/kernel/insnemu.S b/arch/nios2/kernel/insnemu.S
deleted file mode 100644
index a027cc68bbca..000000000000
--- a/arch/nios2/kernel/insnemu.S
+++ /dev/null
@@ -1,580 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2003-2013 Altera Corporation
- *  All rights reserved.
- */
-
-
-#include <linux/linkage.h>
-#include <asm/entry.h>
-
-.set noat
-.set nobreak
-
-/*
-* Explicitly allow the use of r1 (the assembler temporary register)
-* within this code. This register is normally reserved for the use of
-* the compiler.
-*/
-
-ENTRY(instruction_trap)
-	ldw	r1, PT_R1(sp)		// Restore registers
-	ldw	r2, PT_R2(sp)
-	ldw	r3, PT_R3(sp)
-	ldw	r4, PT_R4(sp)
-	ldw	r5, PT_R5(sp)
-	ldw	r6, PT_R6(sp)
-	ldw	r7, PT_R7(sp)
-	ldw	r8, PT_R8(sp)
-	ldw	r9, PT_R9(sp)
-	ldw	r10, PT_R10(sp)
-	ldw	r11, PT_R11(sp)
-	ldw	r12, PT_R12(sp)
-	ldw	r13, PT_R13(sp)
-	ldw	r14, PT_R14(sp)
-	ldw	r15, PT_R15(sp)
-	ldw	ra, PT_RA(sp)
-	ldw	fp, PT_FP(sp)
-	ldw	gp, PT_GP(sp)
-	ldw	et, PT_ESTATUS(sp)
-	wrctl	estatus, et
-	ldw	ea, PT_EA(sp)
-	ldw	et, PT_SP(sp)		/* backup sp in et */
-
-	addi	sp, sp, PT_REGS_SIZE
-
-	/* INSTRUCTION EMULATION
-	*  ---------------------
-	*
-	* Nios II processors generate exceptions for unimplemented instructions.
-	* The routines below emulate these instructions.  Depending on the
-	* processor core, the only instructions that might need to be emulated
-	* are div, divu, mul, muli, mulxss, mulxsu, and mulxuu.
-	*
-	* The emulations match the instructions, except for the following
-	* limitations:
-	*
-	* 1) The emulation routines do not emulate the use of the exception
-	*    temporary register (et) as a source operand because the exception
-	*    handler already has modified it.
-	*
-	* 2) The routines do not emulate the use of the stack pointer (sp) or
-	*    the exception return address register (ea) as a destination because
-	*    modifying these registers crashes the exception handler or the
-	*    interrupted routine.
-	*
-	* Detailed Design
-	* ---------------
-	*
-	* The emulation routines expect the contents of integer registers r0-r31
-	* to be on the stack at addresses sp, 4(sp), 8(sp), ... 124(sp).  The
-	* routines retrieve source operands from the stack and modify the
-	* destination register's value on the stack prior to the end of the
-	* exception handler.  Then all registers except the destination register
-	* are restored to their previous values.
-	*
-	* The instruction that causes the exception is found at address -4(ea).
-	* The instruction's OP and OPX fields identify the operation to be
-	* performed.
-	*
-	* One instruction, muli, is an I-type instruction that is identified by
-	* an OP field of 0x24.
-	*
-	* muli   AAAAA,BBBBB,IIIIIIIIIIIIIIII,-0x24-
-	*           27    22                6      0    <-- LSB of field
-	*
-	* The remaining emulated instructions are R-type and have an OP field
-	* of 0x3a.  Their OPX fields identify them.
-	*
-	* R-type AAAAA,BBBBB,CCCCC,XXXXXX,NNNNN,-0x3a-
-	*           27    22    17     11     6      0  <-- LSB of field
-	*
-	*
-	* Opcode Encoding.  muli is identified by its OP value.  Then OPX & 0x02
-	* is used to differentiate between the division opcodes and the
-	* remaining multiplication opcodes.
-	*
-	* Instruction   OP      OPX    OPX & 0x02
-	* -----------   ----    ----   ----------
-	* muli          0x24
-	* divu          0x3a    0x24         0
-	* div           0x3a    0x25         0
-	* mul           0x3a    0x27      != 0
-	* mulxuu        0x3a    0x07      != 0
-	* mulxsu        0x3a    0x17      != 0
-	* mulxss        0x3a    0x1f      != 0
-	*/
-
-
-	/*
-	* Save everything on the stack to make it easy for the emulation
-	* routines to retrieve the source register operands.
-	*/
-
-	addi sp, sp, -128
-	stw zero, 0(sp)	/* Save zero on stack to avoid special case for r0. */
-	stw r1, 4(sp)
-	stw r2,  8(sp)
-	stw r3, 12(sp)
-	stw r4, 16(sp)
-	stw r5, 20(sp)
-	stw r6, 24(sp)
-	stw r7, 28(sp)
-	stw r8, 32(sp)
-	stw r9, 36(sp)
-	stw r10, 40(sp)
-	stw r11, 44(sp)
-	stw r12, 48(sp)
-	stw r13, 52(sp)
-	stw r14, 56(sp)
-	stw r15, 60(sp)
-	stw r16, 64(sp)
-	stw r17, 68(sp)
-	stw r18, 72(sp)
-	stw r19, 76(sp)
-	stw r20, 80(sp)
-	stw r21, 84(sp)
-	stw r22, 88(sp)
-	stw r23, 92(sp)
-		/* Don't bother to save et.  It's already been changed. */
-	rdctl r5, estatus
-	stw r5,  100(sp)
-
-	stw gp, 104(sp)
-	stw et, 108(sp)	/* et contains previous sp value. */
-	stw fp, 112(sp)
-	stw ea, 116(sp)
-	stw ra, 120(sp)
-
-
-	/*
-	* Split the instruction into its fields.  We need 4*A, 4*B, and 4*C as
-	* offsets to the stack pointer for access to the stored register values.
-	*/
-	ldw r2,-4(ea)	/* r2 = AAAAA,BBBBB,IIIIIIIIIIIIIIII,PPPPPP */
-	roli r3, r2, 7	/* r3 = BBB,IIIIIIIIIIIIIIII,PPPPPP,AAAAA,BB */
-	roli r4, r3, 3	/* r4 = IIIIIIIIIIIIIIII,PPPPPP,AAAAA,BBBBB */
-	roli r5, r4, 2	/* r5 = IIIIIIIIIIIIII,PPPPPP,AAAAA,BBBBB,II */
-	srai r4, r4, 16	/* r4 = (sign-extended) IMM16 */
-	roli r6, r5, 5	/* r6 = XXXX,NNNNN,PPPPPP,AAAAA,BBBBB,CCCCC,XX */
-	andi r2, r2, 0x3f	/* r2 = 00000000000000000000000000,PPPPPP */
-	andi r3, r3, 0x7c	/* r3 = 0000000000000000000000000,AAAAA,00 */
-	andi r5, r5, 0x7c	/* r5 = 0000000000000000000000000,BBBBB,00 */
-	andi r6, r6, 0x7c	/* r6 = 0000000000000000000000000,CCCCC,00 */
-
-	/* Now
-	* r2 = OP
-	* r3 = 4*A
-	* r4 = IMM16 (sign extended)
-	* r5 = 4*B
-	* r6 = 4*C
-	*/
-
-	/*
-	* Get the operands.
-	*
-	* It is necessary to check for muli because it uses an I-type
-	* instruction format, while the other instructions are have an R-type
-	* format.
-	*
-	*  Prepare for either multiplication or division loop.
-	*  They both loop 32 times.
-	*/
-	movi r14, 32
-
-	add  r3, r3, sp		/* r3 = address of A-operand. */
-	ldw  r3, 0(r3)		/* r3 = A-operand. */
-	movi r7, 0x24		/* muli opcode (I-type instruction format) */
-	beq r2, r7, mul_immed /* muli doesn't use the B register as a source */
-
-	add  r5, r5, sp		/* r5 = address of B-operand. */
-	ldw  r5, 0(r5)		/* r5 = B-operand. */
-				/* r4 = SSSSSSSSSSSSSSSS,-----IMM16------ */
-				/* IMM16 not needed, align OPX portion */
-				/* r4 = SSSSSSSSSSSSSSSS,CCCCC,-OPX--,00000 */
-	srli r4, r4, 5		/* r4 = 00000,SSSSSSSSSSSSSSSS,CCCCC,-OPX-- */
-	andi r4, r4, 0x3f	/* r4 = 00000000000000000000000000,-OPX-- */
-
-	/* Now
-	* r2 = OP
-	* r3 = src1
-	* r5 = src2
-	* r4 = OPX (no longer can be muli)
-	* r6 = 4*C
-	*/
-
-
-	/*
-	*  Multiply or Divide?
-	*/
-	andi r7, r4, 0x02	/* For R-type multiply instructions,
-				   OPX & 0x02 != 0 */
-	bne r7, zero, multiply
-
-
-	/* DIVISION
-	*
-	* Divide an unsigned dividend by an unsigned divisor using
-	* a shift-and-subtract algorithm.  The example below shows
-	* 43 div 7 = 6 for 8-bit integers.  This classic algorithm uses a
-	* single register to store both the dividend and the quotient,
-	* allowing both values to be shifted with a single instruction.
-	*
-	*                               remainder dividend:quotient
-	*                               --------- -----------------
-	*   initialize                   00000000     00101011:
-	*   shift                        00000000     0101011:_
-	*   remainder >= divisor? no     00000000     0101011:0
-	*   shift                        00000000     101011:0_
-	*   remainder >= divisor? no     00000000     101011:00
-	*   shift                        00000001     01011:00_
-	*   remainder >= divisor? no     00000001     01011:000
-	*   shift                        00000010     1011:000_
-	*   remainder >= divisor? no     00000010     1011:0000
-	*   shift                        00000101     011:0000_
-	*   remainder >= divisor? no     00000101     011:00000
-	*   shift                        00001010     11:00000_
-	*   remainder >= divisor? yes    00001010     11:000001
-	*       remainder -= divisor   - 00000111
-	*                              ----------
-	*                                00000011     11:000001
-	*   shift                        00000111     1:000001_
-	*   remainder >= divisor? yes    00000111     1:0000011
-	*       remainder -= divisor   - 00000111
-	*                              ----------
-	*                                00000000     1:0000011
-	*   shift                        00000001     :0000011_
-	*   remainder >= divisor? no     00000001     :00000110
-	*
-	* The quotient is 00000110.
-	*/
-
-divide:
-	/*
-	*  Prepare for division by assuming the result
-	*  is unsigned, and storing its "sign" as 0.
-	*/
-	movi r17, 0
-
-
-	/* Which division opcode? */
-	xori r7, r4, 0x25		/* OPX of div */
-	bne r7, zero, unsigned_division
-
-
-	/*
-	*  OPX is div.  Determine and store the sign of the quotient.
-	*  Then take the absolute value of both operands.
-	*/
-	xor r17, r3, r5		/* MSB contains sign of quotient */
-	bge r3,zero,dividend_is_nonnegative
-	sub r3, zero, r3	/* -r3 */
-dividend_is_nonnegative:
-	bge r5, zero, divisor_is_nonnegative
-	sub r5, zero, r5	/* -r5 */
-divisor_is_nonnegative:
-
-
-unsigned_division:
-	/* Initialize the unsigned-division loop. */
-	movi r13, 0	/* remainder = 0 */
-
-	/* Now
-	* r3 = dividend : quotient
-	* r4 = 0x25 for div, 0x24 for divu
-	* r5 = divisor
-	* r13 = remainder
-	* r14 = loop counter (already initialized to 32)
-	* r17 = MSB contains sign of quotient
-	*/
-
-
-	/*
-	*   for (count = 32; count > 0; --count)
-	*   {
-	*/
-divide_loop:
-
-	/*
-	*       Division:
-	*
-	*       (remainder:dividend:quotient) <<= 1;
-	*/
-	slli r13, r13, 1
-	cmplt r7, r3, zero	/* r7 = MSB of r3 */
-	or r13, r13, r7
-	slli r3, r3, 1
-
-
-	/*
-	*       if (remainder >= divisor)
-	*       {
-	*           set LSB of quotient
-	*           remainder -= divisor;
-	*       }
-	*/
-	bltu r13, r5, div_skip
-	ori r3, r3, 1
-	sub r13, r13, r5
-div_skip:
-
-	/*
-	*   }
-	*/
-	subi r14, r14, 1
-	bne r14, zero, divide_loop
-
-
-	/* Now
-	* r3 = quotient
-	* r4 = 0x25 for div, 0x24 for divu
-	* r6 = 4*C
-	* r17 = MSB contains sign of quotient
-	*/
-
-
-	/*
-	*  Conditionally negate signed quotient.  If quotient is unsigned,
-	*  the sign already is initialized to 0.
-	*/
-	bge r17, zero, quotient_is_nonnegative
-	sub r3, zero, r3		/* -r3 */
-	quotient_is_nonnegative:
-
-
-	/*
-	*  Final quotient is in r3.
-	*/
-	add r6, r6, sp
-	stw r3, 0(r6)	/* write quotient to stack */
-	br restore_registers
-
-
-
-
-	/* MULTIPLICATION
-	*
-	* A "product" is the number that one gets by summing a "multiplicand"
-	* several times.  The "multiplier" specifies the number of copies of the
-	* multiplicand that are summed.
-	*
-	* Actual multiplication algorithms don't use repeated addition, however.
-	* Shift-and-add algorithms get the same answer as repeated addition, and
-	* they are faster.  To compute the lower half of a product (pppp below)
-	* one shifts the product left before adding in each of the partial
-	* products (a * mmmm) through (d * mmmm).
-	*
-	* To compute the upper half of a product (PPPP below), one adds in the
-	* partial products (d * mmmm) through (a * mmmm), each time following
-	* the add by a right shift of the product.
-	*
-	*     mmmm
-	*   * abcd
-	*   ------
-	*     ####  = d * mmmm
-	*    ####   = c * mmmm
-	*   ####    = b * mmmm
-	*  ####     = a * mmmm
-	* --------
-	* PPPPpppp
-	*
-	* The example above shows 4 partial products.  Computing actual Nios II
-	* products requires 32 partials.
-	*
-	* It is possible to compute the result of mulxsu from the result of
-	* mulxuu because the only difference between the results of these two
-	* opcodes is the value of the partial product associated with the sign
-	* bit of rA.
-	*
-	*   mulxsu = mulxuu - (rA < 0) ? rB : 0;
-	*
-	* It is possible to compute the result of mulxss from the result of
-	* mulxsu because the only difference between the results of these two
-	* opcodes is the value of the partial product associated with the sign
-	* bit of rB.
-	*
-	*   mulxss = mulxsu - (rB < 0) ? rA : 0;
-	*
-	*/
-
-mul_immed:
-	/* Opcode is muli.  Change it into mul for remainder of algorithm. */
-	mov r6, r5		/* Field B is dest register, not field C. */
-	mov r5, r4		/* Field IMM16 is src2, not field B. */
-	movi r4, 0x27		/* OPX of mul is 0x27 */
-
-multiply:
-	/* Initialize the multiplication loop. */
-	movi r9, 0	/* mul_product    = 0 */
-	movi r10, 0	/* mulxuu_product = 0 */
-	mov r11, r5	/* save original multiplier for mulxsu and mulxss */
-	mov r12, r5	/* mulxuu_multiplier (will be shifted) */
-	movi r16, 1	/* used to create "rori B,A,1" from "ror B,A,r16" */
-
-	/* Now
-	* r3 = multiplicand
-	* r5 = mul_multiplier
-	* r6 = 4 * dest_register (used later as offset to sp)
-	* r7 = temp
-	* r9 = mul_product
-	* r10 = mulxuu_product
-	* r11 = original multiplier
-	* r12 = mulxuu_multiplier
-	* r14 = loop counter (already initialized)
-	* r16 = 1
-	*/
-
-
-	/*
-	*   for (count = 32; count > 0; --count)
-	*   {
-	*/
-multiply_loop:
-
-	/*
-	*       mul_product <<= 1;
-	*       lsb = multiplier & 1;
-	*/
-	slli r9, r9, 1
-	andi r7, r12, 1
-
-	/*
-	*       if (lsb == 1)
-	*       {
-	*           mulxuu_product += multiplicand;
-	*       }
-	*/
-	beq r7, zero, mulx_skip
-	add r10, r10, r3
-	cmpltu r7, r10, r3 /* Save the carry from the MSB of mulxuu_product. */
-	ror r7, r7, r16	/* r7 = 0x80000000 on carry, or else 0x00000000 */
-mulx_skip:
-
-	/*
-	*       if (MSB of mul_multiplier == 1)
-	*       {
-	*           mul_product += multiplicand;
-	*       }
-	*/
-	bge r5, zero, mul_skip
-	add r9, r9, r3
-mul_skip:
-
-	/*
-	*       mulxuu_product >>= 1;           logical shift
-	*       mul_multiplier <<= 1;           done with MSB
-	*       mulx_multiplier >>= 1;          done with LSB
-	*/
-	srli r10, r10, 1
-	or r10, r10, r7		/* OR in the saved carry bit. */
-	slli r5, r5, 1
-	srli r12, r12, 1
-
-
-	/*
-	*   }
-	*/
-	subi r14, r14, 1
-	bne r14, zero, multiply_loop
-
-
-	/*
-	*  Multiply emulation loop done.
-	*/
-
-	/* Now
-	* r3 = multiplicand
-	* r4 = OPX
-	* r6 = 4 * dest_register (used later as offset to sp)
-	* r7 = temp
-	* r9 = mul_product
-	* r10 = mulxuu_product
-	* r11 = original multiplier
-	*/
-
-
-	/* Calculate address for result from 4 * dest_register */
-	add r6, r6, sp
-
-
-	/*
-	* Select/compute the result based on OPX.
-	*/
-
-
-	/* OPX == mul?  Then store. */
-	xori r7, r4, 0x27
-	beq r7, zero, store_product
-
-	/* It's one of the mulx.. opcodes.  Move over the result. */
-	mov r9, r10
-
-	/* OPX == mulxuu?  Then store. */
-	xori r7, r4, 0x07
-	beq r7, zero, store_product
-
-	/* Compute mulxsu
-	 *
-	 * mulxsu = mulxuu - (rA < 0) ? rB : 0;
-	 */
-	bge r3, zero, mulxsu_skip
-	sub r9, r9, r11
-mulxsu_skip:
-
-	/* OPX == mulxsu?  Then store. */
-	xori r7, r4, 0x17
-	beq r7, zero, store_product
-
-	/* Compute mulxss
-	 *
-	 * mulxss = mulxsu - (rB < 0) ? rA : 0;
-	 */
-	bge r11,zero,mulxss_skip
-	sub r9, r9, r3
-mulxss_skip:
-	/* At this point, assume that OPX is mulxss, so store*/
-
-
-store_product:
-	stw r9, 0(r6)
-
-
-restore_registers:
-			/* No need to restore r0. */
-	ldw r5, 100(sp)
-	wrctl estatus, r5
-
-	ldw r1, 4(sp)
-	ldw r2, 8(sp)
-	ldw r3, 12(sp)
-	ldw r4, 16(sp)
-	ldw r5, 20(sp)
-	ldw r6, 24(sp)
-	ldw r7, 28(sp)
-	ldw r8, 32(sp)
-	ldw r9, 36(sp)
-	ldw r10, 40(sp)
-	ldw r11, 44(sp)
-	ldw r12, 48(sp)
-	ldw r13, 52(sp)
-	ldw r14, 56(sp)
-	ldw r15, 60(sp)
-	ldw r16, 64(sp)
-	ldw r17, 68(sp)
-	ldw r18, 72(sp)
-	ldw r19, 76(sp)
-	ldw r20, 80(sp)
-	ldw r21, 84(sp)
-	ldw r22, 88(sp)
-	ldw r23, 92(sp)
-			/* Does not need to restore et */
-	ldw gp, 104(sp)
-
-	ldw fp, 112(sp)
-	ldw ea, 116(sp)
-	ldw ra, 120(sp)
-	ldw sp, 108(sp)	/* last restore sp */
-	eret
-
-.set at
-.set break
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
deleted file mode 100644
index 73568d8e21e0..000000000000
--- a/arch/nios2/kernel/irq.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2008 Thomas Chou <thomas@wytron.com.tw>
- *
- * based on irq.c from m68k which is:
- *
- * Copyright (C) 2007 Greg Ungerer <gerg@snapgear.com>
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irqdomain.h>
-#include <linux/of.h>
-
-static u32 ienable;
-
-asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
-{
-	struct pt_regs *oldregs = set_irq_regs(regs);
-
-	irq_enter();
-	generic_handle_domain_irq(NULL, hwirq);
-	irq_exit();
-
-	set_irq_regs(oldregs);
-}
-
-static void chip_unmask(struct irq_data *d)
-{
-	ienable |= (1 << d->hwirq);
-	WRCTL(CTL_IENABLE, ienable);
-}
-
-static void chip_mask(struct irq_data *d)
-{
-	ienable &= ~(1 << d->hwirq);
-	WRCTL(CTL_IENABLE, ienable);
-}
-
-static struct irq_chip m_irq_chip = {
-	.name		= "NIOS2-INTC",
-	.irq_unmask	= chip_unmask,
-	.irq_mask	= chip_mask,
-};
-
-static int irq_map(struct irq_domain *h, unsigned int virq,
-				irq_hw_number_t hw_irq_num)
-{
-	irq_set_chip_and_handler(virq, &m_irq_chip, handle_level_irq);
-
-	return 0;
-}
-
-static const struct irq_domain_ops irq_ops = {
-	.map	= irq_map,
-	.xlate	= irq_domain_xlate_onecell,
-};
-
-void __init init_IRQ(void)
-{
-	struct irq_domain *domain;
-	struct device_node *node;
-
-	node = of_find_compatible_node(NULL, NULL, "altr,nios2-1.0");
-	if (!node)
-		node = of_find_compatible_node(NULL, NULL, "altr,nios2-1.1");
-
-	BUG_ON(!node);
-
-	domain = irq_domain_create_linear(of_fwnode_handle(node),
-					  NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
-	BUG_ON(!domain);
-
-	irq_set_default_domain(domain);
-	of_node_put(node);
-	/* Load the initial ienable value */
-	ienable = RDCTL(CTL_IENABLE);
-}
diff --git a/arch/nios2/kernel/kgdb.c b/arch/nios2/kernel/kgdb.c
deleted file mode 100644
index d0963fcb11b7..000000000000
--- a/arch/nios2/kernel/kgdb.c
+++ /dev/null
@@ -1,158 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Nios2 KGDB support
- *
- * Copyright (C) 2015 Altera Corporation
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- *
- * Based on the code posted by Kazuyasu on the Altera Forum at:
- * http://www.alteraforum.com/forum/showpost.php?p=77003&postcount=20
- */
-#include <linux/ptrace.h>
-#include <linux/kgdb.h>
-#include <linux/kdebug.h>
-#include <linux/io.h>
-
-static int wait_for_remote_debugger;
-
-struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] =
-{
-	{ "zero", GDB_SIZEOF_REG, -1 },
-	{ "at", GDB_SIZEOF_REG, offsetof(struct pt_regs, r1) },
-	{ "r2", GDB_SIZEOF_REG, offsetof(struct pt_regs, r2) },
-	{ "r3", GDB_SIZEOF_REG, offsetof(struct pt_regs, r3) },
-	{ "r4", GDB_SIZEOF_REG, offsetof(struct pt_regs, r4) },
-	{ "r5", GDB_SIZEOF_REG, offsetof(struct pt_regs, r5) },
-	{ "r6", GDB_SIZEOF_REG, offsetof(struct pt_regs, r6) },
-	{ "r7", GDB_SIZEOF_REG, offsetof(struct pt_regs, r7) },
-	{ "r8", GDB_SIZEOF_REG, offsetof(struct pt_regs, r8) },
-	{ "r9", GDB_SIZEOF_REG, offsetof(struct pt_regs, r9) },
-	{ "r10", GDB_SIZEOF_REG, offsetof(struct pt_regs, r10) },
-	{ "r11", GDB_SIZEOF_REG, offsetof(struct pt_regs, r11) },
-	{ "r12", GDB_SIZEOF_REG, offsetof(struct pt_regs, r12) },
-	{ "r13", GDB_SIZEOF_REG, offsetof(struct pt_regs, r13) },
-	{ "r14", GDB_SIZEOF_REG, offsetof(struct pt_regs, r14) },
-	{ "r15", GDB_SIZEOF_REG, offsetof(struct pt_regs, r15) },
-	{ "r16", GDB_SIZEOF_REG, -1 },
-	{ "r17", GDB_SIZEOF_REG, -1 },
-	{ "r18", GDB_SIZEOF_REG, -1 },
-	{ "r19", GDB_SIZEOF_REG, -1 },
-	{ "r20", GDB_SIZEOF_REG, -1 },
-	{ "r21", GDB_SIZEOF_REG, -1 },
-	{ "r22", GDB_SIZEOF_REG, -1 },
-	{ "r23", GDB_SIZEOF_REG, -1 },
-	{ "et", GDB_SIZEOF_REG, -1 },
-	{ "bt", GDB_SIZEOF_REG, -1 },
-	{ "gp", GDB_SIZEOF_REG, offsetof(struct pt_regs, gp) },
-	{ "sp", GDB_SIZEOF_REG, offsetof(struct pt_regs, sp) },
-	{ "fp", GDB_SIZEOF_REG, offsetof(struct pt_regs, fp) },
-	{ "ea", GDB_SIZEOF_REG, -1 },
-	{ "ba", GDB_SIZEOF_REG, -1 },
-	{ "ra", GDB_SIZEOF_REG, offsetof(struct pt_regs, ra) },
-	{ "pc", GDB_SIZEOF_REG, offsetof(struct pt_regs, ea) },
-	{ "status", GDB_SIZEOF_REG, -1 },
-	{ "estatus", GDB_SIZEOF_REG, offsetof(struct pt_regs, estatus) },
-	{ "bstatus", GDB_SIZEOF_REG, -1 },
-	{ "ienable", GDB_SIZEOF_REG, -1 },
-	{ "ipending", GDB_SIZEOF_REG, -1},
-	{ "cpuid", GDB_SIZEOF_REG, -1 },
-	{ "ctl6", GDB_SIZEOF_REG, -1 },
-	{ "exception", GDB_SIZEOF_REG, -1 },
-	{ "pteaddr", GDB_SIZEOF_REG, -1 },
-	{ "tlbacc", GDB_SIZEOF_REG, -1 },
-	{ "tlbmisc", GDB_SIZEOF_REG, -1 },
-	{ "eccinj", GDB_SIZEOF_REG, -1 },
-	{ "badaddr", GDB_SIZEOF_REG, -1 },
-	{ "config", GDB_SIZEOF_REG, -1 },
-	{ "mpubase", GDB_SIZEOF_REG, -1 },
-	{ "mpuacc", GDB_SIZEOF_REG, -1 },
-};
-
-char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
-{
-	if (regno >= DBG_MAX_REG_NUM || regno < 0)
-		return NULL;
-
-	if (dbg_reg_def[regno].offset != -1)
-		memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
-		       dbg_reg_def[regno].size);
-	else
-		memset(mem, 0, dbg_reg_def[regno].size);
-
-	return dbg_reg_def[regno].name;
-}
-
-int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
-{
-	if (regno >= DBG_MAX_REG_NUM || regno < 0)
-		return -EINVAL;
-
-	if (dbg_reg_def[regno].offset != -1)
-		memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
-		       dbg_reg_def[regno].size);
-
-	return 0;
-}
-
-void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
-{
-	memset((char *)gdb_regs, 0, NUMREGBYTES);
-	gdb_regs[GDB_SP] = p->thread.kregs->sp;
-	gdb_regs[GDB_PC] = p->thread.kregs->ea;
-}
-
-void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
-{
-	regs->ea = pc;
-}
-
-int kgdb_arch_handle_exception(int vector, int signo, int err_code,
-				char *remcom_in_buffer, char *remcom_out_buffer,
-				struct pt_regs *regs)
-{
-	char *ptr;
-	unsigned long addr;
-
-	switch (remcom_in_buffer[0]) {
-	case 's':
-	case 'c':
-		/* handle the optional parameters */
-		ptr = &remcom_in_buffer[1];
-		if (kgdb_hex2long(&ptr, &addr))
-			regs->ea = addr;
-
-		return 0;
-	}
-
-	return -1; /* this means that we do not want to exit from the handler */
-}
-
-asmlinkage void kgdb_breakpoint_c(struct pt_regs *regs)
-{
-	/*
-	 * The breakpoint entry code has moved the PC on by 4 bytes, so we must
-	 * move it back.  This could be done on the host but we do it here
-	 */
-	if (!wait_for_remote_debugger)
-		regs->ea -= 4;
-	else	/* pass the first trap 30 code */
-		wait_for_remote_debugger = 0;
-
-	kgdb_handle_exception(30, SIGTRAP, 0, regs);
-}
-
-int kgdb_arch_init(void)
-{
-	wait_for_remote_debugger = 1;
-	return 0;
-}
-
-void kgdb_arch_exit(void)
-{
-	/* Nothing to do */
-}
-
-const struct kgdb_arch arch_kgdb_ops = {
-	/* Breakpoint instruction: trap 30 */
-	.gdb_bpt_instr = { 0xba, 0x6f, 0x3b, 0x00 },
-};
diff --git a/arch/nios2/kernel/misaligned.c b/arch/nios2/kernel/misaligned.c
deleted file mode 100644
index 2f2862eab3c6..000000000000
--- a/arch/nios2/kernel/misaligned.c
+++ /dev/null
@@ -1,238 +0,0 @@
-/*
- *  linux/arch/nios2/kernel/misaligned.c
- *
- *  basic emulation for mis-aligned accesses on the NIOS II cpu
- *  modelled after the version for arm in arm/alignment.c
- *
- *  Brad Parker <brad@heeltoe.com>
- *  Copyright (C) 2010 Ambient Corporation
- *  Copyright (c) 2010 Altera Corporation, San Jose, California, USA.
- *  Copyright (c) 2010 Arrow Electronics, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of
- * this archive for more details.
- */
-
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/proc_fs.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/uaccess.h>
-#include <linux/seq_file.h>
-
-#include <asm/traps.h>
-#include <linux/unaligned.h>
-
-/* instructions we emulate */
-#define INST_LDHU	0x0b
-#define INST_STH	0x0d
-#define INST_LDH	0x0f
-#define INST_STW	0x15
-#define INST_LDW	0x17
-
-static unsigned int ma_usermode;
-#define UM_WARN		0x01
-#define UM_FIXUP	0x02
-#define UM_SIGNAL	0x04
-#define KM_WARN		0x08
-
-/* see arch/nios2/include/asm/ptrace.h */
-static u8 sys_stack_frame_reg_offset[] = {
-	/* struct pt_regs */
-	8, 9, 10, 11, 12, 13, 14, 15, 1, 2, 3, 4, 5, 6, 7, 0,
-	/* struct switch_stack */
-	16, 17, 18, 19, 20, 21, 22, 23, 0, 0, 0, 0, 0, 0, 0, 0
-};
-
-static int reg_offsets[32];
-
-static inline u32 get_reg_val(struct pt_regs *fp, int reg)
-{
-	u8 *p = ((u8 *)fp) + reg_offsets[reg];
-	return *(u32 *)p;
-}
-
-static inline void put_reg_val(struct pt_regs *fp, int reg, u32 val)
-{
-	u8 *p = ((u8 *)fp) + reg_offsets[reg];
-	*(u32 *)p = val;
-}
-
-/*
- * (mis)alignment handler
- */
-asmlinkage void handle_unaligned_c(struct pt_regs *fp, int cause)
-{
-	u32 isn, addr, val;
-	int in_kernel;
-	u8 a, b, d0, d1, d2, d3;
-	s16 imm16;
-	unsigned int fault;
-
-	/* back up one instruction */
-	fp->ea -= 4;
-
-	if (fixup_exception(fp)) {
-		return;
-	}
-
-	in_kernel = !user_mode(fp);
-
-	isn = *(unsigned long *)(fp->ea);
-
-	fault = 0;
-
-	/* do fixup if in kernel or mode turned on */
-	if (in_kernel || (ma_usermode & UM_FIXUP)) {
-		/* decompose instruction */
-		a = (isn >> 27) & 0x1f;
-		b = (isn >> 22) & 0x1f;
-		imm16 = (isn >> 6) & 0xffff;
-		addr = get_reg_val(fp, a) + imm16;
-
-		/* do fixup to saved registers */
-		switch (isn & 0x3f) {
-		case INST_LDHU:
-			fault |= __get_user(d0, (u8 *)(addr+0));
-			fault |= __get_user(d1, (u8 *)(addr+1));
-			val = (d1 << 8) | d0;
-			put_reg_val(fp, b, val);
-			break;
-		case INST_STH:
-			val = get_reg_val(fp, b);
-			d1 = val >> 8;
-			d0 = val >> 0;
-			if (in_kernel) {
-				*(u8 *)(addr+0) = d0;
-				*(u8 *)(addr+1) = d1;
-			} else {
-				fault |= __put_user(d0, (u8 *)(addr+0));
-				fault |= __put_user(d1, (u8 *)(addr+1));
-			}
-			break;
-		case INST_LDH:
-			fault |= __get_user(d0, (u8 *)(addr+0));
-			fault |= __get_user(d1, (u8 *)(addr+1));
-			val = (short)((d1 << 8) | d0);
-			put_reg_val(fp, b, val);
-			break;
-		case INST_STW:
-			val = get_reg_val(fp, b);
-			d3 = val >> 24;
-			d2 = val >> 16;
-			d1 = val >> 8;
-			d0 = val >> 0;
-			if (in_kernel) {
-				*(u8 *)(addr+0) = d0;
-				*(u8 *)(addr+1) = d1;
-				*(u8 *)(addr+2) = d2;
-				*(u8 *)(addr+3) = d3;
-			} else {
-				fault |= __put_user(d0, (u8 *)(addr+0));
-				fault |= __put_user(d1, (u8 *)(addr+1));
-				fault |= __put_user(d2, (u8 *)(addr+2));
-				fault |= __put_user(d3, (u8 *)(addr+3));
-			}
-			break;
-		case INST_LDW:
-			fault |= __get_user(d0, (u8 *)(addr+0));
-			fault |= __get_user(d1, (u8 *)(addr+1));
-			fault |= __get_user(d2, (u8 *)(addr+2));
-			fault |= __get_user(d3, (u8 *)(addr+3));
-			val = (d3 << 24) | (d2 << 16) | (d1 << 8) | d0;
-			put_reg_val(fp, b, val);
-			break;
-		}
-	}
-
-	addr = RDCTL(CTL_BADADDR);
-	cause >>= 2;
-
-	if (fault) {
-		if (in_kernel) {
-			pr_err("fault during kernel misaligned fixup @ %#lx; addr 0x%08x; isn=0x%08x\n",
-				fp->ea, (unsigned int)addr,
-				(unsigned int)isn);
-		} else {
-			pr_err("fault during user misaligned fixup @ %#lx; isn=%08x addr=0x%08x sp=0x%08lx pid=%d\n",
-				fp->ea,
-				(unsigned int)isn, addr, fp->sp,
-				current->pid);
-
-			_exception(SIGSEGV, fp, SEGV_MAPERR, fp->ea);
-			return;
-		}
-	}
-
-	/*
-	 * kernel mode -
-	 *  note exception and skip bad instruction (return)
-	 */
-	if (in_kernel) {
-		fp->ea += 4;
-
-		if (ma_usermode & KM_WARN) {
-			pr_err("kernel unaligned access @ %#lx; BADADDR 0x%08x; cause=%d, isn=0x%08x\n",
-				fp->ea,
-				(unsigned int)addr, cause,
-				(unsigned int)isn);
-			/* show_regs(fp); */
-		}
-
-		return;
-	}
-
-	/*
-	 * user mode -
-	 *  possibly warn,
-	 *  possibly send SIGBUS signal to process
-	 */
-	if (ma_usermode & UM_WARN) {
-		pr_err("user unaligned access @ %#lx; isn=0x%08lx ea=0x%08lx ra=0x%08lx sp=0x%08lx\n",
-			(unsigned long)addr, (unsigned long)isn,
-			fp->ea, fp->ra, fp->sp);
-	}
-
-	if (ma_usermode & UM_SIGNAL)
-		_exception(SIGBUS, fp, BUS_ADRALN, fp->ea);
-	else
-		fp->ea += 4;	/* else advance */
-}
-
-static void __init misaligned_calc_reg_offsets(void)
-{
-	int i, r, offset;
-
-	/* pre-calc offsets of registers on sys call stack frame */
-	offset = 0;
-
-	/* struct pt_regs */
-	for (i = 0; i < 16; i++) {
-		r = sys_stack_frame_reg_offset[i];
-		reg_offsets[r] = offset;
-		offset += 4;
-	}
-
-	/* struct switch_stack */
-	offset = -sizeof(struct switch_stack);
-	for (i = 16; i < 32; i++) {
-		r = sys_stack_frame_reg_offset[i];
-		reg_offsets[r] = offset;
-		offset += 4;
-	}
-}
-
-
-static int __init misaligned_init(void)
-{
-	/* default mode - silent fix */
-	ma_usermode = UM_FIXUP | KM_WARN;
-
-	misaligned_calc_reg_offsets();
-
-	return 0;
-}
-
-fs_initcall(misaligned_init);
diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
deleted file mode 100644
index f4483243578d..000000000000
--- a/arch/nios2/kernel/module.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * Kernel module support for Nios II.
- *
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *   Written by Wentao Xu <xuwentao@microtronix.com>
- * Copyright (C) 2001, 2003 Rusty Russell
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- */
-
-#include <linux/moduleloader.h>
-#include <linux/elf.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-
-#include <asm/cacheflush.h>
-
-int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
-			unsigned int symindex, unsigned int relsec,
-			struct module *mod)
-{
-	unsigned int i;
-	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_addr;
-
-	pr_debug("Applying relocate section %u to %u\n", relsec,
-		 sechdrs[relsec].sh_info);
-
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
-		/* This is where to make the change */
-		uint32_t word;
-		uint32_t *loc
-			= ((void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			   + rela[i].r_offset);
-		/* This is the symbol it is referring to.  Note that all
-		   undefined symbols have been resolved.  */
-		Elf32_Sym *sym
-			= ((Elf32_Sym *)sechdrs[symindex].sh_addr
-				+ ELF32_R_SYM(rela[i].r_info));
-		uint32_t v = sym->st_value + rela[i].r_addend;
-
-		pr_debug("reltype %d 0x%x name:<%s>\n",
-			ELF32_R_TYPE(rela[i].r_info),
-			rela[i].r_offset, strtab + sym->st_name);
-
-		switch (ELF32_R_TYPE(rela[i].r_info)) {
-		case R_NIOS2_NONE:
-			break;
-		case R_NIOS2_BFD_RELOC_32:
-			*loc += v;
-			break;
-		case R_NIOS2_PCREL16:
-			v -= (uint32_t)loc + 4;
-			if ((int32_t)v > 0x7fff ||
-				(int32_t)v < -(int32_t)0x8000) {
-				pr_err("module %s: relocation overflow\n",
-					mod->name);
-				return -ENOEXEC;
-			}
-			word = *loc;
-			*loc = ((((word >> 22) << 16) | (v & 0xffff)) << 6) |
-				(word & 0x3f);
-			break;
-		case R_NIOS2_CALL26:
-			if (v & 3) {
-				pr_err("module %s: dangerous relocation\n",
-					mod->name);
-				return -ENOEXEC;
-			}
-			if ((v >> 28) != ((uint32_t)loc >> 28)) {
-				pr_err("module %s: relocation overflow\n",
-					mod->name);
-				return -ENOEXEC;
-			}
-			*loc = (*loc & 0x3f) | ((v >> 2) << 6);
-			break;
-		case R_NIOS2_HI16:
-			word = *loc;
-			*loc = ((((word >> 22) << 16) |
-				((v >> 16) & 0xffff)) << 6) | (word & 0x3f);
-			break;
-		case R_NIOS2_LO16:
-			word = *loc;
-			*loc = ((((word >> 22) << 16) | (v & 0xffff)) << 6) |
-					(word & 0x3f);
-			break;
-		case R_NIOS2_HIADJ16:
-			{
-				Elf32_Addr word2;
-
-				word = *loc;
-				word2 = ((v >> 16) + ((v >> 15) & 1)) & 0xffff;
-				*loc = ((((word >> 22) << 16) | word2) << 6) |
-						(word & 0x3f);
-			}
-			break;
-
-		default:
-			pr_err("module %s: Unknown reloc: %u\n",
-				mod->name, ELF32_R_TYPE(rela[i].r_info));
-			return -ENOEXEC;
-		}
-	}
-
-	return 0;
-}
-
-int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
-			struct module *me)
-{
-	flush_cache_all();
-	return 0;
-}
diff --git a/arch/nios2/kernel/nios2_ksyms.c b/arch/nios2/kernel/nios2_ksyms.c
deleted file mode 100644
index c40aa39e8658..000000000000
--- a/arch/nios2/kernel/nios2_ksyms.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
- */
-
-#include <linux/export.h>
-#include <linux/string.h>
-#include <linux/pgtable.h>
-
-#include <asm/cacheflush.h>
-
-/* string functions */
-
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-
-/* memory management */
-
-EXPORT_SYMBOL(flush_icache_range);
-
-/*
- * libgcc functions - functions that are used internally by the
- * compiler...  (prototypes are not correct though, but that
- * doesn't really matter since they're not versioned).
- */
-#define DECLARE_EXPORT(name)	extern void name(void); EXPORT_SYMBOL(name)
-
-DECLARE_EXPORT(__gcc_bcmp);
-DECLARE_EXPORT(__divsi3);
-DECLARE_EXPORT(__moddi3);
-DECLARE_EXPORT(__modsi3);
-DECLARE_EXPORT(__udivmoddi4);
-DECLARE_EXPORT(__udivsi3);
-DECLARE_EXPORT(__umoddi3);
-DECLARE_EXPORT(__umodsi3);
-DECLARE_EXPORT(__muldi3);
-DECLARE_EXPORT(__ucmpdi2);
-DECLARE_EXPORT(__lshrdi3);
-DECLARE_EXPORT(__ashldi3);
-DECLARE_EXPORT(__ashrdi3);
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
deleted file mode 100644
index 151404139085..000000000000
--- a/arch/nios2/kernel/process.c
+++ /dev/null
@@ -1,268 +0,0 @@
-/*
- * Architecture-dependent parts of process handling.
- *
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/sched/debug.h>
-#include <linux/sched/task.h>
-#include <linux/sched/task_stack.h>
-#include <linux/mm_types.h>
-#include <linux/tick.h>
-#include <linux/uaccess.h>
-
-#include <asm/unistd.h>
-#include <asm/traps.h>
-#include <asm/cpuinfo.h>
-
-asmlinkage void ret_from_fork(void);
-asmlinkage void ret_from_kernel_thread(void);
-
-void (*pm_power_off)(void) = NULL;
-EXPORT_SYMBOL(pm_power_off);
-
-void arch_cpu_idle(void)
-{
-}
-
-/*
- * The development boards have no way to pull a board reset. Just jump to the
- * cpu reset address and let the boot loader or the code in head.S take care of
- * resetting peripherals.
- */
-void machine_restart(char *__unused)
-{
-	pr_notice("Machine restart (%08x)...\n", cpuinfo.reset_addr);
-	local_irq_disable();
-	__asm__ __volatile__ (
-	"jmp	%0\n\t"
-	:
-	: "r" (cpuinfo.reset_addr)
-	: "r4");
-}
-
-void machine_halt(void)
-{
-	pr_notice("Machine halt...\n");
-	local_irq_disable();
-	for (;;)
-		;
-}
-
-/*
- * There is no way to power off the development boards. So just spin for now. If
- * we ever have a way of resetting a board using a GPIO we should add that here.
- */
-void machine_power_off(void)
-{
-	pr_notice("Machine power off...\n");
-	local_irq_disable();
-	for (;;)
-		;
-}
-
-void show_regs(struct pt_regs *regs)
-{
-	pr_notice("\n");
-	show_regs_print_info(KERN_DEFAULT);
-
-	pr_notice("r1: %08lx r2: %08lx r3: %08lx r4: %08lx\n",
-		regs->r1,  regs->r2,  regs->r3,  regs->r4);
-
-	pr_notice("r5: %08lx r6: %08lx r7: %08lx r8: %08lx\n",
-		regs->r5,  regs->r6,  regs->r7,  regs->r8);
-
-	pr_notice("r9: %08lx r10: %08lx r11: %08lx r12: %08lx\n",
-		regs->r9,  regs->r10, regs->r11, regs->r12);
-
-	pr_notice("r13: %08lx r14: %08lx r15: %08lx\n",
-		regs->r13, regs->r14, regs->r15);
-
-	pr_notice("ra: %08lx fp:  %08lx sp: %08lx gp: %08lx\n",
-		regs->ra,  regs->fp,  regs->sp,  regs->gp);
-
-	pr_notice("ea: %08lx estatus: %08lx\n",
-		regs->ea,  regs->estatus);
-}
-
-void flush_thread(void)
-{
-}
-
-int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
-{
-	u64 clone_flags = args->flags;
-	unsigned long usp = args->stack;
-	unsigned long tls = args->tls;
-	struct pt_regs *childregs = task_pt_regs(p);
-	struct pt_regs *regs;
-	struct switch_stack *stack;
-	struct switch_stack *childstack =
-		((struct switch_stack *)childregs) - 1;
-
-	if (unlikely(args->fn)) {
-		memset(childstack, 0,
-			sizeof(struct switch_stack) + sizeof(struct pt_regs));
-
-		childstack->r16 = (unsigned long) args->fn;
-		childstack->r17 = (unsigned long) args->fn_arg;
-		childstack->ra = (unsigned long) ret_from_kernel_thread;
-		childregs->estatus = STATUS_PIE;
-		childregs->sp = (unsigned long) childstack;
-
-		p->thread.ksp = (unsigned long) childstack;
-		p->thread.kregs = childregs;
-		return 0;
-	}
-
-	regs = current_pt_regs();
-	*childregs = *regs;
-	childregs->r2 = 0;	/* Set the return value for the child. */
-	childregs->r7 = 0;
-
-	stack = ((struct switch_stack *) regs) - 1;
-	*childstack = *stack;
-	childstack->ra = (unsigned long)ret_from_fork;
-	p->thread.kregs = childregs;
-	p->thread.ksp = (unsigned long) childstack;
-
-	if (usp)
-		childregs->sp = usp;
-
-	/* Initialize tls register. */
-	if (clone_flags & CLONE_SETTLS)
-		childstack->r23 = tls;
-
-	return 0;
-}
-
-/*
- *	Generic dumping code. Used for panic and debug.
- */
-void dump(struct pt_regs *fp)
-{
-	unsigned long	*sp;
-	unsigned char	*tp;
-	int		i;
-
-	pr_emerg("\nCURRENT PROCESS:\n\n");
-	pr_emerg("COMM=%s PID=%d\n", current->comm, current->pid);
-
-	if (current->mm) {
-		pr_emerg("TEXT=%08x-%08x DATA=%08x-%08x BSS=%08x-%08x\n",
-			(int) current->mm->start_code,
-			(int) current->mm->end_code,
-			(int) current->mm->start_data,
-			(int) current->mm->end_data,
-			(int) current->mm->end_data,
-			(int) current->mm->brk);
-		pr_emerg("USER-STACK=%08x  KERNEL-STACK=%08x\n\n",
-			(int) current->mm->start_stack,
-			(int)(((unsigned long) current) + THREAD_SIZE));
-	}
-
-	pr_emerg("PC: %08lx\n", fp->ea);
-	pr_emerg("SR: %08lx    SP: %08lx\n",
-		(long) fp->estatus, (long) fp);
-
-	pr_emerg("r1: %08lx    r2: %08lx    r3: %08lx\n",
-		fp->r1, fp->r2, fp->r3);
-
-	pr_emerg("r4: %08lx    r5: %08lx    r6: %08lx    r7: %08lx\n",
-		fp->r4, fp->r5, fp->r6, fp->r7);
-	pr_emerg("r8: %08lx    r9: %08lx    r10: %08lx    r11: %08lx\n",
-		fp->r8, fp->r9, fp->r10, fp->r11);
-	pr_emerg("r12: %08lx  r13: %08lx    r14: %08lx    r15: %08lx\n",
-		fp->r12, fp->r13, fp->r14, fp->r15);
-	pr_emerg("or2: %08lx   ra: %08lx     fp: %08lx    sp: %08lx\n",
-		fp->orig_r2, fp->ra, fp->fp, fp->sp);
-	pr_emerg("\nUSP: %08x   TRAPFRAME: %08x\n",
-		(unsigned int) fp->sp, (unsigned int) fp);
-
-	pr_emerg("\nCODE:");
-	tp = ((unsigned char *) fp->ea) - 0x20;
-	for (sp = (unsigned long *) tp, i = 0; (i < 0x40);  i += 4) {
-		if ((i % 0x10) == 0)
-			pr_emerg("\n%08x: ", (int) (tp + i));
-		pr_emerg("%08x ", (int) *sp++);
-	}
-	pr_emerg("\n");
-
-	pr_emerg("\nKERNEL STACK:");
-	tp = ((unsigned char *) fp) - 0x40;
-	for (sp = (unsigned long *) tp, i = 0; (i < 0xc0); i += 4) {
-		if ((i % 0x10) == 0)
-			pr_emerg("\n%08x: ", (int) (tp + i));
-		pr_emerg("%08x ", (int) *sp++);
-	}
-	pr_emerg("\n");
-	pr_emerg("\n");
-
-	pr_emerg("\nUSER STACK:");
-	tp = (unsigned char *) (fp->sp - 0x10);
-	for (sp = (unsigned long *) tp, i = 0; (i < 0x80); i += 4) {
-		if ((i % 0x10) == 0)
-			pr_emerg("\n%08x: ", (int) (tp + i));
-		pr_emerg("%08x ", (int) *sp++);
-	}
-	pr_emerg("\n\n");
-}
-
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long fp, pc;
-	unsigned long stack_page;
-	int count = 0;
-
-	stack_page = (unsigned long)p;
-	fp = ((struct switch_stack *)p->thread.ksp)->fp;	/* ;dgt2 */
-	do {
-		if (fp < stack_page+sizeof(struct task_struct) ||
-			fp >= 8184+stack_page)	/* ;dgt2;tmp */
-			return 0;
-		pc = ((unsigned long *)fp)[1];
-		if (!in_sched_functions(pc))
-			return pc;
-		fp = *(unsigned long *) fp;
-	} while (count++ < 16);		/* ;dgt2;tmp */
-	return 0;
-}
-
-/*
- * Do necessary setup to start up a newly executed thread.
- * Will startup in user mode (status_extension = 0).
- */
-void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
-{
-	memset((void *) regs, 0, sizeof(struct pt_regs));
-	regs->estatus = ESTATUS_EPIE | ESTATUS_EU;
-	regs->ea = pc;
-	regs->sp = sp;
-}
-
-asmlinkage int nios2_clone(unsigned long clone_flags, unsigned long newsp,
-			   int __user *parent_tidptr, int __user *child_tidptr,
-			   unsigned long tls)
-{
-	struct kernel_clone_args args = {
-		.flags		= (lower_32_bits(clone_flags) & ~CSIGNAL),
-		.pidfd		= parent_tidptr,
-		.child_tid	= child_tidptr,
-		.parent_tid	= parent_tidptr,
-		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
-		.stack		= newsp,
-		.tls		= tls,
-	};
-
-	return kernel_clone(&args);
-}
diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
deleted file mode 100644
index 4f8c14da6490..000000000000
--- a/arch/nios2/kernel/prom.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Device tree support
- *
- * Copyright (C) 2013, 2015 Altera Corporation
- * Copyright (C) 2010 Thomas Chou <thomas@wytron.com.tw>
- *
- * Based on MIPS support for CONFIG_OF device tree support
- *
- * Copyright (C) 2010 Cisco Systems Inc. <dediao@cisco.com>
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/memblock.h>
-#include <linux/of.h>
-#include <linux/of_fdt.h>
-#include <linux/io.h>
-
-#include <asm/sections.h>
-
-void __init early_init_devtree(void *params)
-{
-	__be32 __maybe_unused *dtb = (u32 *)__dtb_start;
-
-#if defined(CONFIG_NIOS2_DTB_AT_PHYS_ADDR)
-	if (be32_to_cpup((__be32 *)CONFIG_NIOS2_DTB_PHYS_ADDR) ==
-		 OF_DT_HEADER) {
-		params = (void *)CONFIG_NIOS2_DTB_PHYS_ADDR;
-		early_init_dt_scan(params, __pa(params));
-		return;
-	}
-#endif
-
-#ifdef CONFIG_BUILTIN_DTB
-	if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
-		params = (void *)__dtb_start;
-#endif
-
-	early_init_dt_scan(params, __pa(params));
-}
diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
deleted file mode 100644
index c88f5cabc0c1..000000000000
--- a/arch/nios2/kernel/ptrace.c
+++ /dev/null
@@ -1,145 +0,0 @@
-/*
- * Copyright (C) 2014 Altera Corporation
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- */
-
-#include <linux/elf.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/ptrace.h>
-#include <linux/regset.h>
-#include <linux/sched.h>
-#include <linux/sched/task_stack.h>
-#include <linux/uaccess.h>
-#include <linux/user.h>
-
-static int genregs_get(struct task_struct *target,
-		       const struct user_regset *regset,
-		       struct membuf to)
-{
-	const struct pt_regs *regs = task_pt_regs(target);
-	const struct switch_stack *sw = (struct switch_stack *)regs - 1;
-
-	membuf_zero(&to, 4); // R0
-	membuf_write(&to, &regs->r1, 7 * 4); // R1..R7
-	membuf_write(&to, &regs->r8, 8 * 4); // R8..R15
-	membuf_write(&to, sw, 8 * 4); // R16..R23
-	membuf_zero(&to, 2 * 4); /* et and bt */
-	membuf_store(&to, regs->gp);
-	membuf_store(&to, regs->sp);
-	membuf_store(&to, regs->fp);
-	membuf_store(&to, regs->ea);
-	membuf_zero(&to, 4); // PTR_BA
-	membuf_store(&to, regs->ra);
-	membuf_store(&to, regs->ea); /* use ea for PC */
-	return membuf_zero(&to, (NUM_PTRACE_REG - PTR_PC) * 4);
-}
-
-/*
- * Set the thread state from a regset passed in via ptrace
- */
-static int genregs_set(struct task_struct *target,
-		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       const void *kbuf, const void __user *ubuf)
-{
-	struct pt_regs *regs = task_pt_regs(target);
-	const struct switch_stack *sw = (struct switch_stack *)regs - 1;
-	int ret = 0;
-
-#define REG_IGNORE_RANGE(START, END)		\
-	if (!ret)					\
-		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, \
-			START * 4, (END * 4) + 4);
-
-#define REG_IN_ONE(PTR, LOC)	\
-	if (!ret)			\
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, \
-			(void *)(PTR), LOC * 4, (LOC * 4) + 4);
-
-#define REG_IN_RANGE(PTR, START, END)	\
-	if (!ret)				\
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, \
-			(void *)(PTR), START * 4, (END * 4) + 4);
-
-	REG_IGNORE_RANGE(PTR_R0, PTR_R0);
-	REG_IN_RANGE(&regs->r1, PTR_R1, PTR_R7);
-	REG_IN_RANGE(&regs->r8, PTR_R8, PTR_R15);
-	REG_IN_RANGE(sw, PTR_R16, PTR_R23);
-	REG_IGNORE_RANGE(PTR_R24, PTR_R25); /* et and bt */
-	REG_IN_ONE(&regs->gp, PTR_GP);
-	REG_IN_ONE(&regs->sp, PTR_SP);
-	REG_IN_ONE(&regs->fp, PTR_FP);
-	REG_IN_ONE(&regs->ea, PTR_EA);
-	REG_IGNORE_RANGE(PTR_BA, PTR_BA);
-	REG_IN_ONE(&regs->ra, PTR_RA);
-	REG_IN_ONE(&regs->ea, PTR_PC); /* use ea for PC */
-	if (!ret)
-		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-					  PTR_STATUS * 4, -1);
-
-	return ret;
-}
-
-/*
- * Define the register sets available on Nios2 under Linux
- */
-enum nios2_regset {
-	REGSET_GENERAL,
-};
-
-static const struct user_regset nios2_regsets[] = {
-	[REGSET_GENERAL] = {
-		USER_REGSET_NOTE_TYPE(PRSTATUS),
-		.n = NUM_PTRACE_REG,
-		.size = sizeof(unsigned long),
-		.align = sizeof(unsigned long),
-		.regset_get = genregs_get,
-		.set = genregs_set,
-	}
-};
-
-static const struct user_regset_view nios2_user_view = {
-	.name = "nios2",
-	.e_machine = ELF_ARCH,
-	.ei_osabi = ELF_OSABI,
-	.regsets = nios2_regsets,
-	.n = ARRAY_SIZE(nios2_regsets)
-};
-
-const struct user_regset_view *task_user_regset_view(struct task_struct *task)
-{
-	return &nios2_user_view;
-}
-
-void ptrace_disable(struct task_struct *child)
-{
-
-}
-
-long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
-		 unsigned long data)
-{
-	return ptrace_request(child, request, addr, data);
-}
-
-asmlinkage int do_syscall_trace_enter(void)
-{
-	int ret = 0;
-
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = ptrace_report_syscall_entry(task_pt_regs(current));
-
-	return ret;
-}
-
-asmlinkage void do_syscall_trace_exit(void)
-{
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ptrace_report_syscall_exit(task_pt_regs(current), 0);
-}
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
deleted file mode 100644
index f43f01c4ab93..000000000000
--- a/arch/nios2/kernel/setup.c
+++ /dev/null
@@ -1,208 +0,0 @@
-/*
- * Nios2-specific parts of system setup
- *
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- * Copyright (C) 2001 Vic Phillips <vic@microtronix.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/sched/task.h>
-#include <linux/console.h>
-#include <linux/memblock.h>
-#include <linux/initrd.h>
-#include <linux/of_fdt.h>
-
-#include <asm/mmu_context.h>
-#include <asm/sections.h>
-#include <asm/setup.h>
-#include <asm/cpuinfo.h>
-
-unsigned long memory_start;
-EXPORT_SYMBOL(memory_start);
-
-unsigned long memory_end;
-EXPORT_SYMBOL(memory_end);
-
-static struct pt_regs fake_regs = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-					0, 0, 0, 0, 0, 0,
-					0};
-
-/* Copy a short hook instruction sequence to the exception address */
-static inline void copy_exception_handler(unsigned int addr)
-{
-	unsigned int start = (unsigned int) exception_handler_hook;
-	volatile unsigned int tmp = 0;
-
-	if (start == addr) {
-		/* The CPU exception address already points to the handler. */
-		return;
-	}
-
-	__asm__ __volatile__ (
-		"ldw	%2,0(%0)\n"
-		"stw	%2,0(%1)\n"
-		"ldw	%2,4(%0)\n"
-		"stw	%2,4(%1)\n"
-		"ldw	%2,8(%0)\n"
-		"stw	%2,8(%1)\n"
-		"flushd	0(%1)\n"
-		"flushd	4(%1)\n"
-		"flushd	8(%1)\n"
-		"flushi %1\n"
-		"addi	%1,%1,4\n"
-		"flushi %1\n"
-		"addi	%1,%1,4\n"
-		"flushi %1\n"
-		"flushp\n"
-		: /* no output registers */
-		: "r" (start), "r" (addr), "r" (tmp)
-		: "memory"
-	);
-}
-
-/* Copy the fast TLB miss handler */
-static inline void copy_fast_tlb_miss_handler(unsigned int addr)
-{
-	unsigned int start = (unsigned int) fast_handler;
-	unsigned int end = (unsigned int) fast_handler_end;
-	volatile unsigned int tmp = 0;
-
-	__asm__ __volatile__ (
-		"1:\n"
-		"	ldw	%3,0(%0)\n"
-		"	stw	%3,0(%1)\n"
-		"	flushd	0(%1)\n"
-		"	flushi	%1\n"
-		"	flushp\n"
-		"	addi	%0,%0,4\n"
-		"	addi	%1,%1,4\n"
-		"	bne	%0,%2,1b\n"
-		: /* no output registers */
-		: "r" (start), "r" (addr), "r" (end), "r" (tmp)
-		: "memory"
-	);
-}
-
-/*
- * save args passed from u-boot, called from head.S
- *
- * @r4: NIOS magic
- * @r5: initrd start
- * @r6: initrd end or fdt
- * @r7: kernel command line
- */
-asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
-				       unsigned r7)
-{
-	unsigned dtb_passed = 0;
-	char cmdline_passed[COMMAND_LINE_SIZE] __maybe_unused = { 0, };
-
-#if defined(CONFIG_NIOS2_PASS_CMDLINE)
-	if (r4 == 0x534f494e) { /* r4 is magic NIOS */
-#if defined(CONFIG_BLK_DEV_INITRD)
-		if (r5) { /* initramfs */
-			initrd_start = r5;
-			initrd_end = r6;
-		}
-#endif /* CONFIG_BLK_DEV_INITRD */
-		dtb_passed = r6;
-
-		if (r7)
-			strscpy(cmdline_passed, (char *)r7, COMMAND_LINE_SIZE);
-	}
-#endif
-
-	early_init_devtree((void *)dtb_passed);
-
-#ifndef CONFIG_CMDLINE_FORCE
-	if (cmdline_passed[0])
-		strscpy(boot_command_line, cmdline_passed, COMMAND_LINE_SIZE);
-#ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
-	else
-		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif
-#endif
-
-	parse_early_param();
-}
-
-static void __init find_limits(unsigned long *min, unsigned long *max_low,
-			       unsigned long *max_high)
-{
-	*max_low = PFN_DOWN(memblock_get_current_limit());
-	*min = PFN_UP(memblock_start_of_DRAM());
-	*max_high = PFN_DOWN(memblock_end_of_DRAM());
-}
-
-static void __init adjust_lowmem_bounds(void)
-{
-	phys_addr_t block_start, block_end;
-	u64 i;
-	phys_addr_t memblock_limit = 0;
-
-	for_each_mem_range(i, &block_start, &block_end) {
-		if (block_end > memblock_limit)
-			memblock_limit = block_end;
-	}
-
-	memblock_set_current_limit(memblock_limit);
-}
-
-void __init setup_arch(char **cmdline_p)
-{
-	console_verbose();
-
-	memory_start = memblock_start_of_DRAM();
-	memory_end = memblock_end_of_DRAM();
-
-	pr_debug("%s: start=%lx, end=%lx\n", __func__, memory_start, memory_end);
-
-	setup_initial_init_mm(_stext, _etext, _edata, _end);
-	init_task.thread.kregs = &fake_regs;
-
-	/* Keep a copy of command line */
-	*cmdline_p = boot_command_line;
-
-	adjust_lowmem_bounds();
-	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
-
-	memblock_reserve(__pa_symbol(_stext), _end - _stext);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(virt_to_phys((void *)initrd_start),
-				initrd_end - initrd_start);
-	}
-#endif /* CONFIG_BLK_DEV_INITRD */
-
-	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
-
-	unflatten_and_copy_device_tree();
-
-	setup_cpuinfo();
-
-	copy_exception_handler(cpuinfo.exception_addr);
-
-	mmu_init();
-
-	copy_fast_tlb_miss_handler(cpuinfo.fast_tlb_miss_exc_addr);
-
-	/*
-	 * Initialize MMU context handling here because data from cpuinfo is
-	 * needed for this.
-	 */
-	mmu_context_init();
-
-	/*
-	 * get kmalloc into gear
-	 */
-	paging_init();
-}
diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
deleted file mode 100644
index a5b93a30c6eb..000000000000
--- a/arch/nios2/kernel/signal.c
+++ /dev/null
@@ -1,328 +0,0 @@
-/*
- * Copyright (C) 2013-2014 Altera Corporation
- * Copyright (C) 2011-2012 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd
- * Copyright (C) 1991, 1992 Linus Torvalds
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-
-#include <linux/signal.h>
-#include <linux/errno.h>
-#include <linux/ptrace.h>
-#include <linux/uaccess.h>
-#include <linux/unistd.h>
-#include <linux/personality.h>
-#include <linux/resume_user_mode.h>
-
-#include <asm/ucontext.h>
-#include <asm/cacheflush.h>
-
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
-/*
- * Do a signal return; undo the signal stack.
- *
- * Keep the return code on the stack quadword aligned!
- * That makes the cache flush below easier.
- */
-
-struct rt_sigframe {
-	struct siginfo info;
-	struct ucontext uc;
-};
-
-static inline int rt_restore_ucontext(struct pt_regs *regs,
-					struct switch_stack *sw,
-					struct ucontext __user *uc, int *pr2)
-{
-	int temp;
-	unsigned long __user *gregs = uc->uc_mcontext.gregs;
-	int err;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	err = __get_user(temp, &uc->uc_mcontext.version);
-	if (temp != MCONTEXT_VERSION)
-		goto badframe;
-	/* restore passed registers */
-	err |= __get_user(regs->r1, &gregs[0]);
-	err |= __get_user(regs->r2, &gregs[1]);
-	err |= __get_user(regs->r3, &gregs[2]);
-	err |= __get_user(regs->r4, &gregs[3]);
-	err |= __get_user(regs->r5, &gregs[4]);
-	err |= __get_user(regs->r6, &gregs[5]);
-	err |= __get_user(regs->r7, &gregs[6]);
-	err |= __get_user(regs->r8, &gregs[7]);
-	err |= __get_user(regs->r9, &gregs[8]);
-	err |= __get_user(regs->r10, &gregs[9]);
-	err |= __get_user(regs->r11, &gregs[10]);
-	err |= __get_user(regs->r12, &gregs[11]);
-	err |= __get_user(regs->r13, &gregs[12]);
-	err |= __get_user(regs->r14, &gregs[13]);
-	err |= __get_user(regs->r15, &gregs[14]);
-	err |= __get_user(sw->r16, &gregs[15]);
-	err |= __get_user(sw->r17, &gregs[16]);
-	err |= __get_user(sw->r18, &gregs[17]);
-	err |= __get_user(sw->r19, &gregs[18]);
-	err |= __get_user(sw->r20, &gregs[19]);
-	err |= __get_user(sw->r21, &gregs[20]);
-	err |= __get_user(sw->r22, &gregs[21]);
-	err |= __get_user(sw->r23, &gregs[22]);
-	/* gregs[23] is handled below */
-	err |= __get_user(sw->fp, &gregs[24]);  /* Verify, should this be
-							settable */
-	err |= __get_user(sw->gp, &gregs[25]);  /* Verify, should this be
-							settable */
-
-	err |= __get_user(temp, &gregs[26]);  /* Not really necessary no user
-							settable bits */
-	err |= __get_user(regs->ea, &gregs[27]);
-
-	err |= __get_user(regs->ra, &gregs[23]);
-	err |= __get_user(regs->sp, &gregs[28]);
-
-	regs->orig_r2 = -1;		/* disable syscall checks */
-
-	err |= restore_altstack(&uc->uc_stack);
-	if (err)
-		goto badframe;
-
-	*pr2 = regs->r2;
-	return err;
-
-badframe:
-	return 1;
-}
-
-asmlinkage int do_rt_sigreturn(struct switch_stack *sw)
-{
-	struct pt_regs *regs = (struct pt_regs *)(sw + 1);
-	/* Verify, can we follow the stack back */
-	struct rt_sigframe __user *frame;
-	sigset_t set;
-	int rval;
-
-	frame = (struct rt_sigframe __user *) regs->sp;
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (rt_restore_ucontext(regs, sw, &frame->uc, &rval))
-		goto badframe;
-
-	return rval;
-
-badframe:
-	force_sig(SIGSEGV);
-	return 0;
-}
-
-static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *regs)
-{
-	struct switch_stack *sw = (struct switch_stack *)regs - 1;
-	unsigned long __user *gregs = uc->uc_mcontext.gregs;
-	int err = 0;
-
-	err |= __put_user(MCONTEXT_VERSION, &uc->uc_mcontext.version);
-	err |= __put_user(regs->r1, &gregs[0]);
-	err |= __put_user(regs->r2, &gregs[1]);
-	err |= __put_user(regs->r3, &gregs[2]);
-	err |= __put_user(regs->r4, &gregs[3]);
-	err |= __put_user(regs->r5, &gregs[4]);
-	err |= __put_user(regs->r6, &gregs[5]);
-	err |= __put_user(regs->r7, &gregs[6]);
-	err |= __put_user(regs->r8, &gregs[7]);
-	err |= __put_user(regs->r9, &gregs[8]);
-	err |= __put_user(regs->r10, &gregs[9]);
-	err |= __put_user(regs->r11, &gregs[10]);
-	err |= __put_user(regs->r12, &gregs[11]);
-	err |= __put_user(regs->r13, &gregs[12]);
-	err |= __put_user(regs->r14, &gregs[13]);
-	err |= __put_user(regs->r15, &gregs[14]);
-	err |= __put_user(sw->r16, &gregs[15]);
-	err |= __put_user(sw->r17, &gregs[16]);
-	err |= __put_user(sw->r18, &gregs[17]);
-	err |= __put_user(sw->r19, &gregs[18]);
-	err |= __put_user(sw->r20, &gregs[19]);
-	err |= __put_user(sw->r21, &gregs[20]);
-	err |= __put_user(sw->r22, &gregs[21]);
-	err |= __put_user(sw->r23, &gregs[22]);
-	err |= __put_user(regs->ra, &gregs[23]);
-	err |= __put_user(sw->fp, &gregs[24]);
-	err |= __put_user(sw->gp, &gregs[25]);
-	err |= __put_user(regs->ea, &gregs[27]);
-	err |= __put_user(regs->sp, &gregs[28]);
-	return err;
-}
-
-static inline void __user *get_sigframe(struct ksignal *ksig,
-					struct pt_regs *regs,
-					size_t frame_size)
-{
-	unsigned long usp;
-
-	/* Default to using normal stack.  */
-	usp = regs->sp;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	usp = sigsp(usp, ksig);
-
-	/* Verify, is it 32 or 64 bit aligned */
-	return (void __user *)((usp - frame_size) & -8UL);
-}
-
-static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
-			  struct pt_regs *regs)
-{
-	struct rt_sigframe __user *frame;
-	int err = 0;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame));
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-
-	/* Create the ucontext.  */
-	err |= __put_user(0, &frame->uc.uc_flags);
-	err |= __put_user(0, &frame->uc.uc_link);
-	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
-	err |= rt_setup_ucontext(&frame->uc, regs);
-	err |= copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
-
-	if (err)
-		goto give_sigsegv;
-
-	/* Set up to return from userspace; jump to fixed address sigreturn
-	   trampoline on kuser page.  */
-	regs->ra = (unsigned long) (0x1044);
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long) frame;
-	regs->r4 = (unsigned long) ksig->sig;
-	regs->r5 = (unsigned long) &frame->info;
-	regs->r6 = (unsigned long) &frame->uc;
-	regs->ea = (unsigned long) ksig->ka.sa.sa_handler;
-	return 0;
-
-give_sigsegv:
-	force_sigsegv(ksig->sig);
-	return -EFAULT;
-}
-
-/*
- * OK, we're invoking a handler
- */
-static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
-{
-	int ret;
-	sigset_t *oldset = sigmask_to_save();
-
-	/* set up the stack frame */
-	ret = setup_rt_frame(ksig, oldset, regs);
-
-	signal_setup_done(ret, ksig, 0);
-}
-
-static int do_signal(struct pt_regs *regs)
-{
-	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
-	int restart = 0;
-	struct ksignal ksig;
-
-	current->thread.kregs = regs;
-
-	/*
-	 * If we were from a system call, check for system call restarting...
-	 */
-	if (regs->orig_r2 >= 0 && regs->r1) {
-		continue_addr = regs->ea;
-		restart_addr = continue_addr - 4;
-		retval = regs->r2;
-
-		/*
-		 * Prepare for system call restart. We do this here so that a
-		 * debugger will see the already changed PC.
-		 */
-		switch (retval) {
-		case ERESTART_RESTARTBLOCK:
-			restart = -2;
-			fallthrough;
-		case ERESTARTNOHAND:
-		case ERESTARTSYS:
-		case ERESTARTNOINTR:
-			restart++;
-			regs->r2 = regs->orig_r2;
-			regs->r7 = regs->orig_r7;
-			regs->ea = restart_addr;
-			break;
-		}
-		regs->orig_r2 = -1;
-	}
-
-	if (get_signal(&ksig)) {
-		/* handler */
-		if (unlikely(restart && regs->ea == restart_addr)) {
-			if (retval == ERESTARTNOHAND ||
-			    retval == ERESTART_RESTARTBLOCK ||
-			     (retval == ERESTARTSYS
-				&& !(ksig.ka.sa.sa_flags & SA_RESTART))) {
-				regs->r2 = EINTR;
-				regs->r7 = 1;
-				regs->ea = continue_addr;
-			}
-		}
-		handle_signal(&ksig, regs);
-		return 0;
-	}
-
-	/*
-	 * No handler present
-	 */
-	if (unlikely(restart) && regs->ea == restart_addr) {
-		regs->ea = continue_addr;
-		regs->r2 = __NR_restart_syscall;
-	}
-
-	/*
-	* If there's no signal to deliver, we just put the saved sigmask back.
-	*/
-	restore_saved_sigmask();
-
-	return restart;
-}
-
-asmlinkage int do_notify_resume(struct pt_regs *regs)
-{
-	/*
-	 * We want the common case to go fast, which is why we may in certain
-	 * cases get here from kernel mode. Just return without doing anything
-	 * if so.
-	 */
-	if (!user_mode(regs))
-		return 0;
-
-	if (test_thread_flag(TIF_SIGPENDING) ||
-	    test_thread_flag(TIF_NOTIFY_SIGNAL)) {
-		int restart = do_signal(regs);
-
-		if (unlikely(restart)) {
-			/*
-			 * Restart without handlers.
-			 * Deal with it without leaving
-			 * the kernel space.
-			 */
-			return restart;
-		}
-	} else if (test_thread_flag(TIF_NOTIFY_RESUME))
-		resume_user_mode_work(regs);
-
-	return 0;
-}
diff --git a/arch/nios2/kernel/sys_nios2.c b/arch/nios2/kernel/sys_nios2.c
deleted file mode 100644
index b1ca85699952..000000000000
--- a/arch/nios2/kernel/sys_nios2.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2011-2012 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/export.h>
-#include <linux/file.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/syscalls.h>
-
-#include <asm/cacheflush.h>
-#include <asm/traps.h>
-
-/* sys_cacheflush -- flush the processor cache. */
-asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
-				unsigned int op)
-{
-	struct vm_area_struct *vma;
-	struct mm_struct *mm = current->mm;
-
-	if (len == 0)
-		return 0;
-
-	/* We only support op 0 now, return error if op is non-zero.*/
-	if (op)
-		return -EINVAL;
-
-	/* Check for overflow */
-	if (addr + len < addr)
-		return -EFAULT;
-
-	if (mmap_read_lock_killable(mm))
-		return -EINTR;
-
-	/*
-	 * Verify that the specified address region actually belongs
-	 * to this process.
-	 */
-	vma = find_vma(mm, addr);
-	if (vma == NULL || addr < vma->vm_start || addr + len > vma->vm_end) {
-		mmap_read_unlock(mm);
-		return -EFAULT;
-	}
-
-	flush_cache_range(vma, addr, addr + len);
-
-	mmap_read_unlock(mm);
-	return 0;
-}
-
-asmlinkage int sys_getpagesize(void)
-{
-	return PAGE_SIZE;
-}
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
deleted file mode 100644
index c99818aac9e1..000000000000
--- a/arch/nios2/kernel/syscall_table.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright Altera Corporation (C) 2013. All rights reserved
- */
-
-#include <linux/syscalls.h>
-#include <linux/signal.h>
-#include <linux/unistd.h>
-
-#include <asm/syscalls.h>
-
-#define __SYSCALL(nr, call) [nr] = (call),
-#define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
-
-#define sys_mmap2 sys_mmap_pgoff
-#define sys_clone3 __sys_clone3
-
-void *sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls-1] = sys_ni_syscall,
-#include <asm/syscall_table_32.h>
-};
diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
deleted file mode 100644
index 54467d0085a1..000000000000
--- a/arch/nios2/kernel/time.c
+++ /dev/null
@@ -1,359 +0,0 @@
-/*
- * Copyright (C) 2013-2014 Altera Corporation
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/export.h>
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/delay.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#define ALTR_TIMER_COMPATIBLE		"altr,timer-1.0"
-
-#define ALTERA_TIMER_STATUS_REG	0
-#define ALTERA_TIMER_CONTROL_REG	4
-#define ALTERA_TIMER_PERIODL_REG	8
-#define ALTERA_TIMER_PERIODH_REG	12
-#define ALTERA_TIMER_SNAPL_REG		16
-#define ALTERA_TIMER_SNAPH_REG		20
-
-#define ALTERA_TIMER_CONTROL_ITO_MSK	(0x1)
-#define ALTERA_TIMER_CONTROL_CONT_MSK	(0x2)
-#define ALTERA_TIMER_CONTROL_START_MSK	(0x4)
-#define ALTERA_TIMER_CONTROL_STOP_MSK	(0x8)
-
-struct nios2_timer {
-	void __iomem *base;
-	unsigned long freq;
-};
-
-struct nios2_clockevent_dev {
-	struct nios2_timer timer;
-	struct clock_event_device ced;
-};
-
-struct nios2_clocksource {
-	struct nios2_timer timer;
-	struct clocksource cs;
-};
-
-static inline struct nios2_clockevent_dev *
-	to_nios2_clkevent(struct clock_event_device *evt)
-{
-	return container_of(evt, struct nios2_clockevent_dev, ced);
-}
-
-static inline struct nios2_clocksource *
-	to_nios2_clksource(struct clocksource *cs)
-{
-	return container_of(cs, struct nios2_clocksource, cs);
-}
-
-static u16 timer_readw(struct nios2_timer *timer, u32 offs)
-{
-	return readw(timer->base + offs);
-}
-
-static void timer_writew(struct nios2_timer *timer, u16 val, u32 offs)
-{
-	writew(val, timer->base + offs);
-}
-
-static inline unsigned long read_timersnapshot(struct nios2_timer *timer)
-{
-	unsigned long count;
-
-	timer_writew(timer, 0, ALTERA_TIMER_SNAPL_REG);
-	count = timer_readw(timer, ALTERA_TIMER_SNAPH_REG) << 16 |
-		timer_readw(timer, ALTERA_TIMER_SNAPL_REG);
-
-	return count;
-}
-
-static u64 nios2_timer_read(struct clocksource *cs)
-{
-	struct nios2_clocksource *nios2_cs = to_nios2_clksource(cs);
-	unsigned long flags;
-	u32 count;
-
-	local_irq_save(flags);
-	count = read_timersnapshot(&nios2_cs->timer);
-	local_irq_restore(flags);
-
-	/* Counter is counting down */
-	return ~count;
-}
-
-static struct nios2_clocksource nios2_cs = {
-	.cs = {
-		.name	= "nios2-clksrc",
-		.rating	= 250,
-		.read	= nios2_timer_read,
-		.mask	= CLOCKSOURCE_MASK(32),
-		.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-	},
-};
-
-cycles_t get_cycles(void)
-{
-	/* Only read timer if it has been initialized */
-	if (nios2_cs.timer.base)
-		return nios2_timer_read(&nios2_cs.cs);
-	return 0;
-}
-EXPORT_SYMBOL(get_cycles);
-
-static void nios2_timer_start(struct nios2_timer *timer)
-{
-	u16 ctrl;
-
-	ctrl = timer_readw(timer, ALTERA_TIMER_CONTROL_REG);
-	ctrl |= ALTERA_TIMER_CONTROL_START_MSK;
-	timer_writew(timer, ctrl, ALTERA_TIMER_CONTROL_REG);
-}
-
-static void nios2_timer_stop(struct nios2_timer *timer)
-{
-	u16 ctrl;
-
-	ctrl = timer_readw(timer, ALTERA_TIMER_CONTROL_REG);
-	ctrl |= ALTERA_TIMER_CONTROL_STOP_MSK;
-	timer_writew(timer, ctrl, ALTERA_TIMER_CONTROL_REG);
-}
-
-static void nios2_timer_config(struct nios2_timer *timer, unsigned long period,
-			       bool periodic)
-{
-	u16 ctrl;
-
-	/* The timer's actual period is one cycle greater than the value
-	 * stored in the period register. */
-	 period--;
-
-	ctrl = timer_readw(timer, ALTERA_TIMER_CONTROL_REG);
-	/* stop counter */
-	timer_writew(timer, ctrl | ALTERA_TIMER_CONTROL_STOP_MSK,
-		ALTERA_TIMER_CONTROL_REG);
-
-	/* write new count */
-	timer_writew(timer, period, ALTERA_TIMER_PERIODL_REG);
-	timer_writew(timer, period >> 16, ALTERA_TIMER_PERIODH_REG);
-
-	ctrl |= ALTERA_TIMER_CONTROL_START_MSK | ALTERA_TIMER_CONTROL_ITO_MSK;
-	if (periodic)
-		ctrl |= ALTERA_TIMER_CONTROL_CONT_MSK;
-	else
-		ctrl &= ~ALTERA_TIMER_CONTROL_CONT_MSK;
-	timer_writew(timer, ctrl, ALTERA_TIMER_CONTROL_REG);
-}
-
-static int nios2_timer_set_next_event(unsigned long delta,
-	struct clock_event_device *evt)
-{
-	struct nios2_clockevent_dev *nios2_ced = to_nios2_clkevent(evt);
-
-	nios2_timer_config(&nios2_ced->timer, delta, false);
-
-	return 0;
-}
-
-static int nios2_timer_shutdown(struct clock_event_device *evt)
-{
-	struct nios2_clockevent_dev *nios2_ced = to_nios2_clkevent(evt);
-	struct nios2_timer *timer = &nios2_ced->timer;
-
-	nios2_timer_stop(timer);
-	return 0;
-}
-
-static int nios2_timer_set_periodic(struct clock_event_device *evt)
-{
-	unsigned long period;
-	struct nios2_clockevent_dev *nios2_ced = to_nios2_clkevent(evt);
-	struct nios2_timer *timer = &nios2_ced->timer;
-
-	period = DIV_ROUND_UP(timer->freq, HZ);
-	nios2_timer_config(timer, period, true);
-	return 0;
-}
-
-static int nios2_timer_resume(struct clock_event_device *evt)
-{
-	struct nios2_clockevent_dev *nios2_ced = to_nios2_clkevent(evt);
-	struct nios2_timer *timer = &nios2_ced->timer;
-
-	nios2_timer_start(timer);
-	return 0;
-}
-
-irqreturn_t timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = (struct clock_event_device *) dev_id;
-	struct nios2_clockevent_dev *nios2_ced = to_nios2_clkevent(evt);
-
-	/* Clear the interrupt condition */
-	timer_writew(&nios2_ced->timer, 0, ALTERA_TIMER_STATUS_REG);
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static int __init nios2_timer_get_base_and_freq(struct device_node *np,
-				void __iomem **base, u32 *freq)
-{
-	*base = of_iomap(np, 0);
-	if (!*base) {
-		pr_crit("Unable to map reg for %pOFn\n", np);
-		return -ENXIO;
-	}
-
-	if (of_property_read_u32(np, "clock-frequency", freq)) {
-		pr_crit("Unable to get %pOFn clock frequency\n", np);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct nios2_clockevent_dev nios2_ce = {
-	.ced = {
-		.name = "nios2-clkevent",
-		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-		.rating = 250,
-		.shift = 32,
-		.set_next_event = nios2_timer_set_next_event,
-		.set_state_shutdown = nios2_timer_shutdown,
-		.set_state_periodic = nios2_timer_set_periodic,
-		.set_state_oneshot = nios2_timer_shutdown,
-		.tick_resume = nios2_timer_resume,
-	},
-};
-
-static __init int nios2_clockevent_init(struct device_node *timer)
-{
-	void __iomem *iobase;
-	u32 freq;
-	int irq, ret;
-
-	ret = nios2_timer_get_base_and_freq(timer, &iobase, &freq);
-	if (ret)
-		return ret;
-
-	irq = irq_of_parse_and_map(timer, 0);
-	if (!irq) {
-		pr_crit("Unable to parse timer irq\n");
-		return -EINVAL;
-	}
-
-	nios2_ce.timer.base = iobase;
-	nios2_ce.timer.freq = freq;
-
-	nios2_ce.ced.cpumask = cpumask_of(0);
-	nios2_ce.ced.irq = irq;
-
-	nios2_timer_stop(&nios2_ce.timer);
-	/* clear pending interrupt */
-	timer_writew(&nios2_ce.timer, 0, ALTERA_TIMER_STATUS_REG);
-
-	ret = request_irq(irq, timer_interrupt, IRQF_TIMER, timer->name,
-			  &nios2_ce.ced);
-	if (ret) {
-		pr_crit("Unable to setup timer irq\n");
-		return ret;
-	}
-
-	clockevents_config_and_register(&nios2_ce.ced, freq, 1, ULONG_MAX);
-
-	return 0;
-}
-
-static __init int nios2_clocksource_init(struct device_node *timer)
-{
-	unsigned int ctrl;
-	void __iomem *iobase;
-	u32 freq;
-	int ret;
-
-	ret = nios2_timer_get_base_and_freq(timer, &iobase, &freq);
-	if (ret)
-		return ret;
-
-	nios2_cs.timer.base = iobase;
-	nios2_cs.timer.freq = freq;
-
-	ret = clocksource_register_hz(&nios2_cs.cs, freq);
-	if (ret)
-		return ret;
-
-	timer_writew(&nios2_cs.timer, USHRT_MAX, ALTERA_TIMER_PERIODL_REG);
-	timer_writew(&nios2_cs.timer, USHRT_MAX, ALTERA_TIMER_PERIODH_REG);
-
-	/* interrupt disable + continuous + start */
-	ctrl = ALTERA_TIMER_CONTROL_CONT_MSK | ALTERA_TIMER_CONTROL_START_MSK;
-	timer_writew(&nios2_cs.timer, ctrl, ALTERA_TIMER_CONTROL_REG);
-
-	/* Calibrate the delay loop directly */
-	lpj_fine = freq / HZ;
-
-	return 0;
-}
-
-/*
- * The first timer instance will use as a clockevent. If there are two or
- * more instances, the second one gets used as clocksource and all
- * others are unused.
-*/
-static int __init nios2_time_init(struct device_node *timer)
-{
-	static int num_called;
-	int ret;
-
-	switch (num_called) {
-	case 0:
-		ret = nios2_clockevent_init(timer);
-		break;
-	case 1:
-		ret = nios2_clocksource_init(timer);
-		break;
-	default:
-		ret = 0;
-		break;
-	}
-
-	num_called++;
-
-	return ret;
-}
-
-void read_persistent_clock64(struct timespec64 *ts)
-{
-	ts->tv_sec = mktime64(2007, 1, 1, 0, 0, 0);
-	ts->tv_nsec = 0;
-}
-
-void __init time_init(void)
-{
-	struct device_node *np;
-	int count = 0;
-
-	for_each_compatible_node(np, NULL,  ALTR_TIMER_COMPATIBLE)
-		count++;
-
-	if (count < 2)
-		panic("%d timer is found, it needs 2 timers in system\n", count);
-
-	timer_probe();
-}
-
-TIMER_OF_DECLARE(nios2_timer, ALTR_TIMER_COMPATIBLE, nios2_time_init);
diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
deleted file mode 100644
index 85ac49d64cf7..000000000000
--- a/arch/nios2/kernel/traps.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Hardware exception handling
- *
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- * Copyright (C) 2001 Vic Phillips
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- */
-
-#include <linux/sched.h>
-#include <linux/sched/debug.h>
-#include <linux/kernel.h>
-#include <linux/signal.h>
-#include <linux/export.h>
-#include <linux/mm.h>
-#include <linux/ptrace.h>
-
-#include <asm/traps.h>
-#include <asm/sections.h>
-#include <linux/uaccess.h>
-
-static DEFINE_SPINLOCK(die_lock);
-
-static void _send_sig(int signo, int code, unsigned long addr)
-{
-	force_sig_fault(signo, code, (void __user *) addr);
-}
-
-void die(const char *str, struct pt_regs *regs, long err)
-{
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	pr_warn("Oops: %s, sig: %ld\n", str, err);
-	show_regs(regs);
-	spin_unlock_irq(&die_lock);
-	/*
-	 * make_task_dead() should take care of panic'ing from an interrupt
-	 * context so we don't handle it here
-	 */
-	make_task_dead(err);
-}
-
-void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr)
-{
-	if (!user_mode(regs))
-		die("Exception in kernel mode", regs, signo);
-
-	_send_sig(signo, code, addr);
-}
-
-/*
- * The show_stack() is external API which we do not use ourselves.
- */
-
-int kstack_depth_to_print = 48;
-
-void show_stack(struct task_struct *task, unsigned long *stack,
-		const char *loglvl)
-{
-	unsigned long *endstack, addr;
-	int i;
-
-	if (!stack) {
-		if (task)
-			stack = (unsigned long *)task->thread.ksp;
-		else
-			stack = (unsigned long *)&stack;
-	}
-
-	addr = (unsigned long) stack;
-	endstack = (unsigned long *) PAGE_ALIGN(addr);
-
-	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
-	for (i = 0; i < kstack_depth_to_print; i++) {
-		if (stack + 1 > endstack)
-			break;
-		if (i % 8 == 0)
-			printk("%s\n       ", loglvl);
-		printk("%s %08lx", loglvl, *stack++);
-	}
-
-	printk("%s\nCall Trace:", loglvl);
-	i = 0;
-	while (stack + 1 <= endstack) {
-		addr = *stack++;
-		/*
-		 * If the address is either in the text segment of the
-		 * kernel, or in the region which contains vmalloc'ed
-		 * memory, it *may* be the address of a calling
-		 * routine; if so, print it so that someone tracing
-		 * down the cause of the crash will be able to figure
-		 * out the call path that was taken.
-		 */
-		if (((addr >= (unsigned long) _stext) &&
-		     (addr <= (unsigned long) _etext))) {
-			if (i % 4 == 0)
-				pr_emerg("\n       ");
-			printk("%s [<%08lx>]", loglvl, addr);
-			i++;
-		}
-	}
-	printk("%s\n", loglvl);
-}
-
-/* Breakpoint handler */
-asmlinkage void breakpoint_c(struct pt_regs *fp)
-{
-	/*
-	 * The breakpoint entry code has moved the PC on by 4 bytes, so we must
-	 * move it back. This could be done on the host but we do it here
-	 * because monitor.S of JTAG gdbserver does it too.
-	 */
-	fp->ea -= 4;
-	_exception(SIGTRAP, fp, TRAP_BRKPT, fp->ea);
-}
-
-#ifndef CONFIG_NIOS2_ALIGNMENT_TRAP
-/* Alignment exception handler */
-asmlinkage void handle_unaligned_c(struct pt_regs *fp, int cause)
-{
-	unsigned long addr = RDCTL(CTL_BADADDR);
-
-	cause >>= 2;
-	fp->ea -= 4;
-
-	if (fixup_exception(fp))
-		return;
-
-	if (!user_mode(fp)) {
-		pr_alert("Unaligned access from kernel mode, this might be a hardware\n");
-		pr_alert("problem, dump registers and restart the instruction\n");
-		pr_alert("  BADADDR 0x%08lx\n", addr);
-		pr_alert("  cause   %d\n", cause);
-		pr_alert("  op-code 0x%08lx\n", *(unsigned long *)(fp->ea));
-		show_regs(fp);
-		return;
-	}
-
-	_exception(SIGBUS, fp, BUS_ADRALN, addr);
-}
-#endif /* CONFIG_NIOS2_ALIGNMENT_TRAP */
-
-/* Illegal instruction handler */
-asmlinkage void handle_illegal_c(struct pt_regs *fp)
-{
-	fp->ea -= 4;
-	_exception(SIGILL, fp, ILL_ILLOPC, fp->ea);
-}
-
-/* Supervisor instruction handler */
-asmlinkage void handle_supervisor_instr(struct pt_regs *fp)
-{
-	fp->ea -= 4;
-	_exception(SIGILL, fp, ILL_PRVOPC, fp->ea);
-}
-
-/* Division error handler */
-asmlinkage void handle_diverror_c(struct pt_regs *fp)
-{
-	fp->ea -= 4;
-	_exception(SIGFPE, fp, FPE_INTDIV, fp->ea);
-}
-
-/* Unhandled exception handler */
-asmlinkage void unhandled_exception(struct pt_regs *regs, int cause)
-{
-	unsigned long addr = RDCTL(CTL_BADADDR);
-
-	cause /= 4;
-
-	pr_emerg("Unhandled exception #%d in %s mode (badaddr=0x%08lx)\n",
-			cause, user_mode(regs) ? "user" : "kernel", addr);
-
-	regs->ea -= 4;
-	show_regs(regs);
-
-	pr_emerg("opcode: 0x%08lx\n", *(unsigned long *)(regs->ea));
-}
-
-asmlinkage void handle_trap_1_c(struct pt_regs *fp)
-{
-	_send_sig(SIGUSR1, 0, fp->ea);
-}
-
-asmlinkage void handle_trap_2_c(struct pt_regs *fp)
-{
-	_send_sig(SIGUSR2, 0, fp->ea);
-}
-
-asmlinkage void handle_trap_3_c(struct pt_regs *fp)
-{
-	_send_sig(SIGILL, ILL_ILLTRP, fp->ea);
-}
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
deleted file mode 100644
index 206f92445bfa..000000000000
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
- */
-#include <asm/page.h>
-#include <asm-generic/vmlinux.lds.h>
-#include <asm/cache.h>
-#include <asm/thread_info.h>
-
-OUTPUT_FORMAT("elf32-littlenios2", "elf32-littlenios2", "elf32-littlenios2")
-
-OUTPUT_ARCH(nios)
-ENTRY(_start)	/* Defined in head.S */
-
-jiffies = jiffies_64;
-
-SECTIONS
-{
-	. = CONFIG_NIOS2_MEM_BASE | CONFIG_NIOS2_KERNEL_REGION_BASE;
-
-	_text = .;
-	_stext = .;
-	HEAD_TEXT_SECTION
-	.text : {
-		TEXT_TEXT
-		SCHED_TEXT
-		LOCK_TEXT
-		IRQENTRY_TEXT
-		SOFTIRQENTRY_TEXT
-		KPROBES_TEXT
-	} =0
-	_etext = .;
-
-	.got : {
-		*(.got.plt)
-		*(.igot.plt)
-		*(.got)
-		*(.igot)
-	}
-
-	EXCEPTION_TABLE(L1_CACHE_BYTES)
-
-	. = ALIGN(PAGE_SIZE);
-	__init_begin = .;
-	INIT_TEXT_SECTION(PAGE_SIZE)
-	INIT_DATA_SECTION(PAGE_SIZE)
-	PERCPU_SECTION(L1_CACHE_BYTES)
-	__init_end = .;
-
-	_sdata = .;
-	RO_DATA(PAGE_SIZE)
-	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
-	_edata = .;
-
-	BSS_SECTION(0, 0, 0)
-	_end = .;
-
-	STABS_DEBUG
-	DWARF_DEBUG
-	MODINFO
-	ELF_DETAILS
-
-	DISCARDS
-}
diff --git a/arch/nios2/lib/Makefile b/arch/nios2/lib/Makefile
deleted file mode 100644
index 9d5bf1df520c..000000000000
--- a/arch/nios2/lib/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for Nios2-specific library files.
-#
-
-lib-y += delay.o
-lib-y += memcpy.o
-lib-y += memmove.o
-lib-y += memset.o
diff --git a/arch/nios2/lib/delay.c b/arch/nios2/lib/delay.c
deleted file mode 100644
index f1e39c7f7439..000000000000
--- a/arch/nios2/lib/delay.c
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright Altera Corporation (C) 2014. All rights reserved.
- */
-
-#include <linux/module.h>
-#include <asm/delay.h>
-#include <asm/param.h>
-#include <asm/processor.h>
-#include <asm/timex.h>
-
-void __delay(unsigned long cycles)
-{
-	cycles_t start = get_cycles();
-
-	while ((get_cycles() - start) < cycles)
-		cpu_relax();
-}
-EXPORT_SYMBOL(__delay);
-
-void __const_udelay(unsigned long xloops)
-{
-	u64 loops;
-
-	loops = (u64)xloops * loops_per_jiffy * HZ;
-
-	__delay(loops >> 32);
-}
-EXPORT_SYMBOL(__const_udelay);
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
-}
-EXPORT_SYMBOL(__ndelay);
diff --git a/arch/nios2/lib/memcpy.c b/arch/nios2/lib/memcpy.c
deleted file mode 100644
index 1715f5d28b11..000000000000
--- a/arch/nios2/lib/memcpy.c
+++ /dev/null
@@ -1,202 +0,0 @@
-/* Extracted from GLIBC memcpy.c and memcopy.h, which is:
-   Copyright (C) 1991, 1992, 1993, 1997, 2004 Free Software Foundation, Inc.
-   This file is part of the GNU C Library.
-   Contributed by Torbjorn Granlund (tege@sics.se).
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public
-   License as published by the Free Software Foundation; either
-   version 2.1 of the License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-
-   You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
-
-#include <linux/types.h>
-
-/* Type to use for aligned memory operations.
-   This should normally be the biggest type supported by a single load
-   and store.  */
-#define	op_t	unsigned long int
-#define OPSIZ	(sizeof(op_t))
-
-/* Optimal type for storing bytes in registers.  */
-#define	reg_char	char
-
-#define MERGE(w0, sh_1, w1, sh_2) (((w0) >> (sh_1)) | ((w1) << (sh_2)))
-
-/* Copy exactly NBYTES bytes from SRC_BP to DST_BP,
-   without any assumptions about alignment of the pointers.  */
-#define BYTE_COPY_FWD(dst_bp, src_bp, nbytes)				\
-do {									\
-	size_t __nbytes = (nbytes);					\
-	while (__nbytes > 0) {						\
-		unsigned char __x = ((unsigned char *) src_bp)[0];	\
-		src_bp += 1;						\
-		__nbytes -= 1;						\
-		((unsigned char *) dst_bp)[0] = __x;			\
-		dst_bp += 1;						\
-	}								\
-} while (0)
-
-/* Copy *up to* NBYTES bytes from SRC_BP to DST_BP, with
-   the assumption that DST_BP is aligned on an OPSIZ multiple.  If
-   not all bytes could be easily copied, store remaining number of bytes
-   in NBYTES_LEFT, otherwise store 0.  */
-/* extern void _wordcopy_fwd_aligned __P ((long int, long int, size_t)); */
-/* extern void _wordcopy_fwd_dest_aligned __P ((long int, long int, size_t)); */
-#define WORD_COPY_FWD(dst_bp, src_bp, nbytes_left, nbytes)		\
-do {									\
-	if (src_bp % OPSIZ == 0)					\
-		_wordcopy_fwd_aligned(dst_bp, src_bp, (nbytes) / OPSIZ);\
-	else								\
-		_wordcopy_fwd_dest_aligned(dst_bp, src_bp, (nbytes) / OPSIZ);\
-	src_bp += (nbytes) & -OPSIZ;					\
-	dst_bp += (nbytes) & -OPSIZ;					\
-	(nbytes_left) = (nbytes) % OPSIZ;				\
-} while (0)
-
-
-/* Threshold value for when to enter the unrolled loops.  */
-#define	OP_T_THRES	16
-
-/* _wordcopy_fwd_aligned -- Copy block beginning at SRCP to
-   block beginning at DSTP with LEN `op_t' words (not LEN bytes!).
-   Both SRCP and DSTP should be aligned for memory operations on `op_t's.  */
-/* stream-lined (read x8 + write x8) */
-static void _wordcopy_fwd_aligned(long int dstp, long int srcp, size_t len)
-{
-	while (len > 7) {
-		register op_t a0, a1, a2, a3, a4, a5, a6, a7;
-
-		a0 = ((op_t *) srcp)[0];
-		a1 = ((op_t *) srcp)[1];
-		a2 = ((op_t *) srcp)[2];
-		a3 = ((op_t *) srcp)[3];
-		a4 = ((op_t *) srcp)[4];
-		a5 = ((op_t *) srcp)[5];
-		a6 = ((op_t *) srcp)[6];
-		a7 = ((op_t *) srcp)[7];
-		((op_t *) dstp)[0] = a0;
-		((op_t *) dstp)[1] = a1;
-		((op_t *) dstp)[2] = a2;
-		((op_t *) dstp)[3] = a3;
-		((op_t *) dstp)[4] = a4;
-		((op_t *) dstp)[5] = a5;
-		((op_t *) dstp)[6] = a6;
-		((op_t *) dstp)[7] = a7;
-
-		srcp += 8 * OPSIZ;
-		dstp += 8 * OPSIZ;
-		len -= 8;
-	}
-	while (len > 0) {
-		*(op_t *)dstp = *(op_t *)srcp;
-
-		srcp += OPSIZ;
-		dstp += OPSIZ;
-		len -= 1;
-	}
-}
-
-/* _wordcopy_fwd_dest_aligned -- Copy block beginning at SRCP to
-   block beginning at DSTP with LEN `op_t' words (not LEN bytes!).
-   DSTP should be aligned for memory operations on `op_t's, but SRCP must
-   *not* be aligned.  */
-/* stream-lined (read x4 + write x4) */
-static void _wordcopy_fwd_dest_aligned(long int dstp, long int srcp,
-					size_t len)
-{
-	op_t ap;
-	int sh_1, sh_2;
-
-	/* Calculate how to shift a word read at the memory operation
-	aligned srcp to make it aligned for copy. */
-
-	sh_1 = 8 * (srcp % OPSIZ);
-	sh_2 = 8 * OPSIZ - sh_1;
-
-	/* Make SRCP aligned by rounding it down to the beginning of the `op_t'
-	it points in the middle of. */
-	srcp &= -OPSIZ;
-	ap = ((op_t *) srcp)[0];
-	srcp += OPSIZ;
-
-	while (len > 3) {
-		op_t a0, a1, a2, a3;
-
-		a0 = ((op_t *) srcp)[0];
-		a1 = ((op_t *) srcp)[1];
-		a2 = ((op_t *) srcp)[2];
-		a3 = ((op_t *) srcp)[3];
-		((op_t *) dstp)[0] = MERGE(ap, sh_1, a0, sh_2);
-		((op_t *) dstp)[1] = MERGE(a0, sh_1, a1, sh_2);
-		((op_t *) dstp)[2] = MERGE(a1, sh_1, a2, sh_2);
-		((op_t *) dstp)[3] = MERGE(a2, sh_1, a3, sh_2);
-
-		ap = a3;
-		srcp += 4 * OPSIZ;
-		dstp += 4 * OPSIZ;
-		len -= 4;
-	}
-	while (len > 0) {
-		register op_t a0;
-
-		a0 = ((op_t *) srcp)[0];
-		((op_t *) dstp)[0] = MERGE(ap, sh_1, a0, sh_2);
-
-		ap = a0;
-		srcp += OPSIZ;
-		dstp += OPSIZ;
-		len -= 1;
-	}
-}
-
-void *memcpy(void *dstpp, const void *srcpp, size_t len)
-{
-	unsigned long int dstp = (long int) dstpp;
-	unsigned long int srcp = (long int) srcpp;
-
-	/* Copy from the beginning to the end.  */
-
-	/* If there not too few bytes to copy, use word copy.  */
-	if (len >= OP_T_THRES) {
-		/* Copy just a few bytes to make DSTP aligned.  */
-		len -= (-dstp) % OPSIZ;
-		BYTE_COPY_FWD(dstp, srcp, (-dstp) % OPSIZ);
-
-		/* Copy whole pages from SRCP to DSTP by virtual address
-		   manipulation, as much as possible.  */
-
-		/* PAGE_COPY_FWD_MAYBE (dstp, srcp, len, len); */
-
-		/* Copy from SRCP to DSTP taking advantage of the known
-		   alignment of DSTP. Number of bytes remaining is put in the
-		   third argument, i.e. in LEN.  This number may vary from
-		   machine to machine. */
-
-		WORD_COPY_FWD(dstp, srcp, len, len);
-
-		/* Fall out and copy the tail. */
-	}
-
-	/* There are just a few bytes to copy.  Use byte memory operations. */
-	BYTE_COPY_FWD(dstp, srcp, len);
-
-	return dstpp;
-}
-
-void *memcpyb(void *dstpp, const void *srcpp, unsigned len)
-{
-	unsigned long int dstp = (long int) dstpp;
-	unsigned long int srcp = (long int) srcpp;
-
-	BYTE_COPY_FWD(dstp, srcp, len);
-
-	return dstpp;
-}
diff --git a/arch/nios2/lib/memmove.c b/arch/nios2/lib/memmove.c
deleted file mode 100644
index 866c021f278c..000000000000
--- a/arch/nios2/lib/memmove.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/types.h>
-#include <linux/string.h>
-
-void *memmove(void *d, const void *s, size_t count)
-{
-	unsigned long dst, src;
-
-	if (!count)
-		return d;
-
-	if (d < s) {
-		dst = (unsigned long) d;
-		src = (unsigned long) s;
-
-		if ((count < 8) || ((dst ^ src) & 3))
-			goto restup;
-
-		if (dst & 1) {
-			*(char *)dst++ = *(char *)src++;
-			count--;
-		}
-		if (dst & 2) {
-			*(short *)dst = *(short *)src;
-			src += 2;
-			dst += 2;
-			count -= 2;
-		}
-		while (count > 3) {
-			*(long *)dst = *(long *)src;
-			src += 4;
-			dst += 4;
-			count -= 4;
-		}
-restup:
-		while (count--)
-			*(char *)dst++ = *(char *)src++;
-	} else {
-		dst = (unsigned long) d + count;
-		src = (unsigned long) s + count;
-
-		if ((count < 8) || ((dst ^ src) & 3))
-			goto restdown;
-
-		if (dst & 1) {
-			src--;
-			dst--;
-			count--;
-			*(char *)dst = *(char *)src;
-		}
-		if (dst & 2) {
-			src -= 2;
-			dst -= 2;
-			count -= 2;
-			*(short *)dst = *(short *)src;
-		}
-		while (count > 3) {
-			src -= 4;
-			dst -= 4;
-			count -= 4;
-			*(long *)dst = *(long *)src;
-		}
-restdown:
-		while (count--) {
-			src--;
-			dst--;
-			*(char *)dst = *(char *)src;
-		}
-	}
-
-	return d;
-}
diff --git a/arch/nios2/lib/memset.c b/arch/nios2/lib/memset.c
deleted file mode 100644
index 2fcefe720283..000000000000
--- a/arch/nios2/lib/memset.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/types.h>
-#include <linux/string.h>
-
-void *memset(void *s, int c, size_t count)
-{
-	int destptr, charcnt, dwordcnt, fill8reg, wrkrega;
-
-	if (!count)
-		return s;
-
-	c &= 0xFF;
-
-	if (count <= 8) {
-		char *xs = (char *) s;
-
-		while (count--)
-			*xs++ = c;
-		return s;
-	}
-
-	__asm__ __volatile__ (
-		/* fill8 %3, %5 (c & 0xff) */
-		"	slli	%4, %5, 8\n"
-		"	or	%4, %4, %5\n"
-		"	slli    %3, %4, 16\n"
-		"	or	%3, %3, %4\n"
-		/* Word-align %0 (s) if necessary */
-		"	andi	%4, %0, 0x01\n"
-		"	beq	%4, zero, 1f\n"
-		"	addi	%1, %1, -1\n"
-		"	stb	%3, 0(%0)\n"
-		"	addi	%0, %0, 1\n"
-		"1:	mov	%2, %1\n"
-		/* Dword-align %0 (s) if necessary */
-		"	andi	%4, %0, 0x02\n"
-		"	beq	%4, zero, 2f\n"
-		"	addi	%1, %1, -2\n"
-		"	sth	%3, 0(%0)\n"
-		"	addi	%0, %0, 2\n"
-		"	mov	%2, %1\n"
-		/* %1 and %2 are how many more bytes to set */
-		"2:	srli	%2, %2, 2\n"
-		/* %2 is how many dwords to set */
-		"3:	stw	%3, 0(%0)\n"
-		"	addi	%0, %0, 4\n"
-		"	addi    %2, %2, -1\n"
-		"	bne	%2, zero, 3b\n"
-		/* store residual word and/or byte if necessary */
-		"	andi	%4, %1, 0x02\n"
-		"	beq	%4, zero, 4f\n"
-		"	sth	%3, 0(%0)\n"
-		"	addi	%0, %0, 2\n"
-		/* store residual byte if necessary */
-		"4:	andi	%4, %1, 0x01\n"
-		"	beq	%4, zero, 5f\n"
-		"	stb	%3, 0(%0)\n"
-		"5:\n"
-		: "=r" (destptr),	/* %0  Output */
-		  "=r" (charcnt),	/* %1  Output */
-		  "=r" (dwordcnt),	/* %2  Output */
-		  "=r" (fill8reg),	/* %3  Output */
-		  "=&r" (wrkrega)	/* %4  Output only */
-		: "r" (c),		/* %5  Input */
-		  "0" (s),		/* %0  Input/Output */
-		  "1" (count)		/* %1  Input/Output */
-		: "memory"		/* clobbered */
-	);
-
-	return s;
-}
diff --git a/arch/nios2/mm/Makefile b/arch/nios2/mm/Makefile
deleted file mode 100644
index 9d37fafd1dd1..000000000000
--- a/arch/nios2/mm/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the Nios2-specific parts of the memory manager.
-#
-
-obj-y	+= cacheflush.o
-obj-y	+= dma-mapping.o
-obj-y	+= extable.o
-obj-y	+= fault.o
-obj-y	+= init.o
-obj-y	+= ioremap.o
-obj-y	+= mmu_context.o
-obj-y	+= pgtable.o
-obj-y	+= tlb.o
-obj-y	+= uaccess.o
diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
deleted file mode 100644
index 8321182eb927..000000000000
--- a/arch/nios2/mm/cacheflush.c
+++ /dev/null
@@ -1,281 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2009, Wind River Systems Inc
- * Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- */
-
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/fs.h>
-#include <linux/pagemap.h>
-
-#include <asm/cacheflush.h>
-#include <asm/cpuinfo.h>
-
-static void __flush_dcache(unsigned long start, unsigned long end)
-{
-	unsigned long addr;
-
-	start &= ~(cpuinfo.dcache_line_size - 1);
-	end += (cpuinfo.dcache_line_size - 1);
-	end &= ~(cpuinfo.dcache_line_size - 1);
-
-	if (end > start + cpuinfo.dcache_size)
-		end = start + cpuinfo.dcache_size;
-
-	for (addr = start; addr < end; addr += cpuinfo.dcache_line_size) {
-		__asm__ __volatile__ ("   flushd 0(%0)\n"
-					: /* Outputs */
-					: /* Inputs  */ "r"(addr)
-					/* : No clobber */);
-	}
-}
-
-static void __invalidate_dcache(unsigned long start, unsigned long end)
-{
-	unsigned long addr;
-
-	start &= ~(cpuinfo.dcache_line_size - 1);
-	end += (cpuinfo.dcache_line_size - 1);
-	end &= ~(cpuinfo.dcache_line_size - 1);
-
-	for (addr = start; addr < end; addr += cpuinfo.dcache_line_size) {
-		__asm__ __volatile__ ("   initda 0(%0)\n"
-					: /* Outputs */
-					: /* Inputs  */ "r"(addr)
-					/* : No clobber */);
-	}
-}
-
-static void __flush_icache(unsigned long start, unsigned long end)
-{
-	unsigned long addr;
-
-	start &= ~(cpuinfo.icache_line_size - 1);
-	end += (cpuinfo.icache_line_size - 1);
-	end &= ~(cpuinfo.icache_line_size - 1);
-
-	if (end > start + cpuinfo.icache_size)
-		end = start + cpuinfo.icache_size;
-
-	for (addr = start; addr < end; addr += cpuinfo.icache_line_size) {
-		__asm__ __volatile__ ("   flushi %0\n"
-					: /* Outputs */
-					: /* Inputs  */ "r"(addr)
-					/* : No clobber */);
-	}
-	__asm__ __volatile(" flushp\n");
-}
-
-static void flush_aliases(struct address_space *mapping, struct folio *folio)
-{
-	struct mm_struct *mm = current->active_mm;
-	struct vm_area_struct *vma;
-	unsigned long flags;
-	pgoff_t pgoff;
-	unsigned long nr = folio_nr_pages(folio);
-
-	pgoff = folio->index;
-
-	flush_dcache_mmap_lock_irqsave(mapping, flags);
-	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff + nr - 1) {
-		unsigned long start;
-
-		if (vma->vm_mm != mm)
-			continue;
-		if (!(vma->vm_flags & VM_MAYSHARE))
-			continue;
-
-		start = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-		flush_cache_range(vma, start, start + nr * PAGE_SIZE);
-	}
-	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
-}
-
-void flush_cache_all(void)
-{
-	__flush_dcache(0, cpuinfo.dcache_size);
-	__flush_icache(0, cpuinfo.icache_size);
-}
-
-void flush_cache_mm(struct mm_struct *mm)
-{
-	flush_cache_all();
-}
-
-void flush_cache_dup_mm(struct mm_struct *mm)
-{
-	flush_cache_all();
-}
-
-void flush_icache_range(unsigned long start, unsigned long end)
-{
-	__flush_dcache(start, end);
-	__flush_icache(start, end);
-}
-
-void flush_dcache_range(unsigned long start, unsigned long end)
-{
-	__flush_dcache(start, end);
-	__flush_icache(start, end);
-}
-EXPORT_SYMBOL(flush_dcache_range);
-
-void invalidate_dcache_range(unsigned long start, unsigned long end)
-{
-	__invalidate_dcache(start, end);
-}
-EXPORT_SYMBOL(invalidate_dcache_range);
-
-void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end)
-{
-	__flush_dcache(start, end);
-	if (vma == NULL || (vma->vm_flags & VM_EXEC))
-		__flush_icache(start, end);
-}
-
-void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
-		unsigned int nr)
-{
-	unsigned long start = (unsigned long) page_address(page);
-	unsigned long end = start + nr * PAGE_SIZE;
-
-	__flush_dcache(start, end);
-	__flush_icache(start, end);
-}
-
-void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
-			unsigned long pfn)
-{
-	unsigned long start = vmaddr;
-	unsigned long end = start + PAGE_SIZE;
-
-	__flush_dcache(start, end);
-	if (vma->vm_flags & VM_EXEC)
-		__flush_icache(start, end);
-}
-
-static void __flush_dcache_folio(struct folio *folio)
-{
-	/*
-	 * Writeback any data associated with the kernel mapping of this
-	 * page.  This ensures that data in the physical page is mutually
-	 * coherent with the kernels mapping.
-	 */
-	unsigned long start = (unsigned long)folio_address(folio);
-
-	__flush_dcache(start, start + folio_size(folio));
-}
-
-void flush_dcache_folio(struct folio *folio)
-{
-	struct address_space *mapping;
-
-	/*
-	 * The zero page is never written to, so never has any dirty
-	 * cache lines, and therefore never needs to be flushed.
-	 */
-	if (is_zero_pfn(folio_pfn(folio)))
-		return;
-
-	mapping = folio_flush_mapping(folio);
-
-	/* Flush this page if there are aliases. */
-	if (mapping && !mapping_mapped(mapping)) {
-		clear_bit(PG_dcache_clean, &folio->flags.f);
-	} else {
-		__flush_dcache_folio(folio);
-		if (mapping) {
-			unsigned long start = (unsigned long)folio_address(folio);
-			flush_aliases(mapping, folio);
-			flush_icache_range(start, start + folio_size(folio));
-		}
-		set_bit(PG_dcache_clean, &folio->flags.f);
-	}
-}
-EXPORT_SYMBOL(flush_dcache_folio);
-
-void flush_dcache_page(struct page *page)
-{
-	flush_dcache_folio(page_folio(page));
-}
-EXPORT_SYMBOL(flush_dcache_page);
-
-void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep, unsigned int nr)
-{
-	pte_t pte = *ptep;
-	unsigned long pfn = pte_pfn(pte);
-	struct folio *folio;
-	struct address_space *mapping;
-
-	reload_tlb_page(vma, address, pte);
-
-	if (!pfn_valid(pfn))
-		return;
-
-	/*
-	* The zero page is never written to, so never has any dirty
-	* cache lines, and therefore never needs to be flushed.
-	*/
-	if (is_zero_pfn(pfn))
-		return;
-
-	folio = page_folio(pfn_to_page(pfn));
-	if (!test_and_set_bit(PG_dcache_clean, &folio->flags.f))
-		__flush_dcache_folio(folio);
-
-	mapping = folio_flush_mapping(folio);
-	if (mapping) {
-		flush_aliases(mapping, folio);
-		if (vma->vm_flags & VM_EXEC)
-			flush_icache_pages(vma, &folio->page,
-					folio_nr_pages(folio));
-	}
-}
-
-void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-		    struct page *to)
-{
-	__flush_dcache(vaddr, vaddr + PAGE_SIZE);
-	__flush_icache(vaddr, vaddr + PAGE_SIZE);
-	copy_page(vto, vfrom);
-	__flush_dcache((unsigned long)vto, (unsigned long)vto + PAGE_SIZE);
-	__flush_icache((unsigned long)vto, (unsigned long)vto + PAGE_SIZE);
-}
-
-void clear_user_page(void *addr, unsigned long vaddr, struct page *page)
-{
-	__flush_dcache(vaddr, vaddr + PAGE_SIZE);
-	__flush_icache(vaddr, vaddr + PAGE_SIZE);
-	clear_page(addr);
-	__flush_dcache((unsigned long)addr, (unsigned long)addr + PAGE_SIZE);
-	__flush_icache((unsigned long)addr, (unsigned long)addr + PAGE_SIZE);
-}
-
-void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
-			unsigned long user_vaddr,
-			void *dst, void *src, int len)
-{
-	flush_cache_page(vma, user_vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
-	__flush_dcache((unsigned long)src, (unsigned long)src + len);
-	if (vma->vm_flags & VM_EXEC)
-		__flush_icache((unsigned long)src, (unsigned long)src + len);
-}
-
-void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
-			unsigned long user_vaddr,
-			void *dst, void *src, int len)
-{
-	flush_cache_page(vma, user_vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
-	__flush_dcache((unsigned long)dst, (unsigned long)dst + len);
-	if (vma->vm_flags & VM_EXEC)
-		__flush_icache((unsigned long)dst, (unsigned long)dst + len);
-}
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
deleted file mode 100644
index fd887d5f3f9a..000000000000
--- a/arch/nios2/mm/dma-mapping.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *  Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- * Based on DMA code from MIPS.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/dma-mapping.h>
-#include <linux/io.h>
-#include <linux/cache.h>
-#include <asm/cacheflush.h>
-
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	void *vaddr = phys_to_virt(paddr);
-
-	switch (dir) {
-	case DMA_FROM_DEVICE:
-		invalidate_dcache_range((unsigned long)vaddr,
-			(unsigned long)(vaddr + size));
-		break;
-	case DMA_TO_DEVICE:
-		/*
-		 * We just need to flush the caches here , but Nios2 flush
-		 * instruction will do both writeback and invalidate.
-		 */
-	case DMA_BIDIRECTIONAL: /* flush and invalidate */
-		flush_dcache_range((unsigned long)vaddr,
-			(unsigned long)(vaddr + size));
-		break;
-	default:
-		BUG();
-	}
-}
-
-void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	void *vaddr = phys_to_virt(paddr);
-
-	switch (dir) {
-	case DMA_BIDIRECTIONAL:
-	case DMA_FROM_DEVICE:
-		invalidate_dcache_range((unsigned long)vaddr,
-			(unsigned long)(vaddr + size));
-		break;
-	case DMA_TO_DEVICE:
-		break;
-	default:
-		BUG();
-	}
-}
-
-void arch_dma_prep_coherent(struct page *page, size_t size)
-{
-	unsigned long start = (unsigned long)page_address(page);
-
-	flush_dcache_range(start, start + size);
-}
-
-void *arch_dma_set_uncached(void *ptr, size_t size)
-{
-	unsigned long addr = (unsigned long)ptr;
-
-	addr |= CONFIG_NIOS2_IO_REGION_BASE;
-
-	return (void *)ptr;
-}
diff --git a/arch/nios2/mm/extable.c b/arch/nios2/mm/extable.c
deleted file mode 100644
index 2574dba0407d..000000000000
--- a/arch/nios2/mm/extable.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (C) 2010, Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009, Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/extable.h>
-#include <linux/uaccess.h>
-
-int fixup_exception(struct pt_regs *regs)
-{
-	const struct exception_table_entry *fixup;
-
-	fixup = search_exception_tables(regs->ea);
-	if (fixup) {
-		regs->ea = fixup->fixup;
-		return 1;
-	}
-
-	return 0;
-}
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
deleted file mode 100644
index e3fa9c15181d..000000000000
--- a/arch/nios2/mm/fault.c
+++ /dev/null
@@ -1,264 +0,0 @@
-/*
- * Copyright (C) 2009 Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- * based on arch/mips/mm/fault.c which is:
- *
- * Copyright (C) 1995-2000 Ralf Baechle
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/sched/debug.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/mman.h>
-#include <linux/mm.h>
-#include <linux/extable.h>
-#include <linux/uaccess.h>
-#include <linux/perf_event.h>
-
-#include <asm/mmu_context.h>
-#include <asm/traps.h>
-
-#define EXC_SUPERV_INSN_ACCESS	9  /* Supervisor only instruction address */
-#define EXC_SUPERV_DATA_ACCESS	11 /* Supervisor only data address */
-#define EXC_X_PROTECTION_FAULT	13 /* TLB permission violation (x) */
-#define EXC_R_PROTECTION_FAULT	14 /* TLB permission violation (r) */
-#define EXC_W_PROTECTION_FAULT	15 /* TLB permission violation (w) */
-
-/*
- * This routine handles page faults.  It determines the address,
- * and the problem, and then passes it off to one of the appropriate
- * routines.
- */
-asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
-				unsigned long address)
-{
-	struct vm_area_struct *vma = NULL;
-	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
-	int code = SEGV_MAPERR;
-	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_DEFAULT;
-
-	cause >>= 2;
-
-	/* Restart the instruction */
-	regs->ea -= 4;
-
-	/*
-	 * We fault-in kernel-space virtual memory on-demand. The
-	 * 'reference' page table is init_mm.pgd.
-	 *
-	 * NOTE! We MUST NOT take any locks for this case. We may
-	 * be in an interrupt or a critical region, and should
-	 * only copy the information from the master page table,
-	 * nothing more.
-	 */
-	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END)) {
-		if (user_mode(regs))
-			goto bad_area_nosemaphore;
-		else
-			goto vmalloc_fault;
-	}
-
-	if (unlikely(address >= TASK_SIZE))
-		goto bad_area_nosemaphore;
-
-	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
-	 */
-	if (faulthandler_disabled() || !mm)
-		goto bad_area_nosemaphore;
-
-	if (user_mode(regs))
-		flags |= FAULT_FLAG_USER;
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
-retry:
-	vma = lock_mm_and_find_vma(mm, address, regs);
-	if (!vma)
-		goto bad_area_nosemaphore;
-/*
- * Ok, we have a good vm_area for this memory access, so
- * we can handle it..
- */
-	code = SEGV_ACCERR;
-
-	switch (cause) {
-	case EXC_SUPERV_INSN_ACCESS:
-		goto bad_area;
-	case EXC_SUPERV_DATA_ACCESS:
-		goto bad_area;
-	case EXC_X_PROTECTION_FAULT:
-		if (!(vma->vm_flags & VM_EXEC))
-			goto bad_area;
-		break;
-	case EXC_R_PROTECTION_FAULT:
-		if (!(vma->vm_flags & VM_READ))
-			goto bad_area;
-		break;
-	case EXC_W_PROTECTION_FAULT:
-		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;
-		flags = FAULT_FLAG_WRITE;
-		break;
-	}
-
-	/*
-	 * If for any reason at all we couldn't handle the fault,
-	 * make sure we exit gracefully rather than endlessly redo
-	 * the fault.
-	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
-
-	if (fault_signal_pending(fault, regs)) {
-		if (!user_mode(regs))
-			goto no_context;
-		return;
-	}
-
-	/* The fault is fully completed (including releasing mmap lock) */
-	if (fault & VM_FAULT_COMPLETED)
-		return;
-
-	if (unlikely(fault & VM_FAULT_ERROR)) {
-		if (fault & VM_FAULT_OOM)
-			goto out_of_memory;
-		else if (fault & VM_FAULT_SIGSEGV)
-			goto bad_area;
-		else if (fault & VM_FAULT_SIGBUS)
-			goto do_sigbus;
-		BUG();
-	}
-
-	if (fault & VM_FAULT_RETRY) {
-		flags |= FAULT_FLAG_TRIED;
-
-		/*
-		 * No need to mmap_read_unlock(mm) as we would
-		 * have already released it in __lock_page_or_retry
-		 * in mm/filemap.c.
-		 */
-
-		goto retry;
-	}
-
-	mmap_read_unlock(mm);
-	return;
-
-/*
- * Something tried to access memory that isn't in our memory map..
- * Fix it, but check if it's kernel or user first..
- */
-bad_area:
-	mmap_read_unlock(mm);
-
-bad_area_nosemaphore:
-	/* User mode accesses just cause a SIGSEGV */
-	if (user_mode(regs)) {
-		if (unhandled_signal(current, SIGSEGV) && printk_ratelimit()) {
-			pr_info("%s: unhandled page fault (%d) at 0x%08lx, "
-				"cause %ld\n", current->comm, SIGSEGV, address, cause);
-			show_regs(regs);
-		}
-		_exception(SIGSEGV, regs, code, address);
-		return;
-	}
-
-no_context:
-	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs))
-		return;
-
-	/*
-	 * Oops. The kernel tried to access some bad page. We'll have to
-	 * terminate things with extreme prejudice.
-	 */
-	bust_spinlocks(1);
-
-	pr_alert("Unable to handle kernel %s at virtual address %08lx",
-		address < PAGE_SIZE ? "NULL pointer dereference" :
-		"paging request", address);
-	pr_alert("ea = %08lx, ra = %08lx, cause = %ld\n", regs->ea, regs->ra,
-		cause);
-	panic("Oops");
-	return;
-
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
-out_of_memory:
-	mmap_read_unlock(mm);
-	if (!user_mode(regs))
-		goto no_context;
-	pagefault_out_of_memory();
-	return;
-
-do_sigbus:
-	mmap_read_unlock(mm);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!user_mode(regs))
-		goto no_context;
-
-	_exception(SIGBUS, regs, BUS_ADRERR, address);
-	return;
-
-vmalloc_fault:
-	{
-		/*
-		 * Synchronize this task's top level page-table
-		 * with the 'reference' page table.
-		 *
-		 * Do _not_ use "tsk" here. We might be inside
-		 * an interrupt in the middle of a task switch..
-		 */
-		int offset = pgd_index(address);
-		pgd_t *pgd, *pgd_k;
-		p4d_t *p4d, *p4d_k;
-		pud_t *pud, *pud_k;
-		pmd_t *pmd, *pmd_k;
-		pte_t *pte_k;
-
-		pgd = pgd_current + offset;
-		pgd_k = init_mm.pgd + offset;
-
-		if (!pgd_present(*pgd_k))
-			goto no_context;
-		set_pgd(pgd, *pgd_k);
-
-		p4d = p4d_offset(pgd, address);
-		p4d_k = p4d_offset(pgd_k, address);
-		if (!p4d_present(*p4d_k))
-			goto no_context;
-		pud = pud_offset(p4d, address);
-		pud_k = pud_offset(p4d_k, address);
-		if (!pud_present(*pud_k))
-			goto no_context;
-		pmd = pmd_offset(pud, address);
-		pmd_k = pmd_offset(pud_k, address);
-		if (!pmd_present(*pmd_k))
-			goto no_context;
-		set_pmd(pmd, *pmd_k);
-
-		pte_k = pte_offset_kernel(pmd_k, address);
-		if (!pte_present(*pte_k))
-			goto no_context;
-
-		flush_tlb_kernel_page(address);
-		return;
-	}
-}
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
deleted file mode 100644
index 6b22f1995c16..000000000000
--- a/arch/nios2/mm/init.c
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- * Copyright (C) 2004 Microtronix Datacom Ltd
- *
- * based on arch/m68k/mm/init.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/mman.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/memblock.h>
-#include <linux/slab.h>
-#include <linux/binfmts.h>
-#include <linux/execmem.h>
-
-#include <asm/setup.h>
-#include <asm/page.h>
-#include <asm/sections.h>
-#include <asm/tlb.h>
-#include <asm/mmu_context.h>
-#include <asm/cpuinfo.h>
-#include <asm/processor.h>
-
-pgd_t *pgd_current;
-
-void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
-{
-	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
-}
-
-/*
- * paging_init() continues the virtual memory environment setup which
- * was begun by the code in arch/head.S.
- * The parameters are pointers to where to stick the starting and ending
- * addresses of available kernel virtual memory.
- */
-void __init paging_init(void)
-{
-	pagetable_init();
-	pgd_current = swapper_pg_dir;
-
-	flush_dcache_range((unsigned long)empty_zero_page,
-			(unsigned long)empty_zero_page + PAGE_SIZE);
-}
-
-void __init mmu_init(void)
-{
-	flush_tlb_all();
-}
-
-pgd_t swapper_pg_dir[PTRS_PER_PGD] __aligned(PAGE_SIZE);
-pte_t invalid_pte_table[PTRS_PER_PTE] __aligned(PAGE_SIZE);
-static struct page *kuser_page[1];
-static struct vm_special_mapping vdso_mapping = {
-	.name = "[vdso]",
-	.pages = kuser_page,
-};
-
-static int alloc_kuser_page(void)
-{
-	extern char __kuser_helper_start[], __kuser_helper_end[];
-	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
-	unsigned long vpage;
-
-	vpage = get_zeroed_page(GFP_ATOMIC);
-	if (!vpage)
-		return -ENOMEM;
-
-	/* Copy kuser helpers */
-	memcpy((void *)vpage, __kuser_helper_start, kuser_sz);
-
-	flush_icache_range(vpage, vpage + KUSER_SIZE);
-	kuser_page[0] = virt_to_page(vpage);
-
-	return 0;
-}
-arch_initcall(alloc_kuser_page);
-
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-
-	mmap_write_lock(mm);
-
-	/* Map kuser helpers to user space address */
-	vma = _install_special_mapping(mm, KUSER_BASE, KUSER_SIZE,
-				      VM_READ | VM_EXEC | VM_MAYREAD |
-				      VM_MAYEXEC, &vdso_mapping);
-
-	mmap_write_unlock(mm);
-
-	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
-}
-
-const char *arch_vma_name(struct vm_area_struct *vma)
-{
-	return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
-}
-
-static const pgprot_t protection_map[16] = {
-	[VM_NONE]					= MKP(0, 0, 0),
-	[VM_READ]					= MKP(0, 0, 1),
-	[VM_WRITE]					= MKP(0, 0, 0),
-	[VM_WRITE | VM_READ]				= MKP(0, 0, 1),
-	[VM_EXEC]					= MKP(1, 0, 0),
-	[VM_EXEC | VM_READ]				= MKP(1, 0, 1),
-	[VM_EXEC | VM_WRITE]				= MKP(1, 0, 0),
-	[VM_EXEC | VM_WRITE | VM_READ]			= MKP(1, 0, 1),
-	[VM_SHARED]					= MKP(0, 0, 0),
-	[VM_SHARED | VM_READ]				= MKP(0, 0, 1),
-	[VM_SHARED | VM_WRITE]				= MKP(0, 1, 0),
-	[VM_SHARED | VM_WRITE | VM_READ]		= MKP(0, 1, 1),
-	[VM_SHARED | VM_EXEC]				= MKP(1, 0, 0),
-	[VM_SHARED | VM_EXEC | VM_READ]			= MKP(1, 0, 1),
-	[VM_SHARED | VM_EXEC | VM_WRITE]		= MKP(1, 1, 0),
-	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= MKP(1, 1, 1)
-};
-DECLARE_VM_GET_PAGE_PROT
-
-#ifdef CONFIG_EXECMEM
-static struct execmem_info execmem_info __ro_after_init;
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	execmem_info = (struct execmem_info){
-		.ranges = {
-			[EXECMEM_DEFAULT] = {
-				.start	= MODULES_VADDR,
-				.end	= MODULES_END,
-				.pgprot	= PAGE_KERNEL_EXEC,
-				.alignment = 1,
-			},
-		},
-	};
-
-	return &execmem_info;
-}
-#endif /* CONFIG_EXECMEM */
diff --git a/arch/nios2/mm/ioremap.c b/arch/nios2/mm/ioremap.c
deleted file mode 100644
index fe821efb9a99..000000000000
--- a/arch/nios2/mm/ioremap.c
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- * Copyright (C) 2004 Microtronix Datacom Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/io.h>
-
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
-static inline void remap_area_pte(pte_t *pte, unsigned long address,
-				unsigned long size, unsigned long phys_addr,
-				unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_READ
-				| _PAGE_WRITE | flags);
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-	pfn = PFN_DOWN(phys_addr);
-	do {
-		if (!pte_none(*pte)) {
-			pr_err("remap_area_pte: page already exists\n");
-			BUG();
-		}
-		set_pte(pte, pfn_pte(pfn, pgprot));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int remap_area_pmd(pmd_t *pmd, unsigned long address,
-				unsigned long size, unsigned long phys_addr,
-				unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
-	do {
-		pte_t *pte = pte_alloc_kernel(pmd, address);
-
-		if (!pte)
-			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr,
-			flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-				unsigned long size, unsigned long flags)
-{
-	int error;
-	pgd_t *dir;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		p4d_t *p4d;
-		pud_t *pud;
-		pmd_t *pmd;
-
-		error = -ENOMEM;
-		p4d = p4d_alloc(&init_mm, dir, address);
-		if (!p4d)
-			break;
-		pud = pud_alloc(&init_mm, p4d, address);
-		if (!pud)
-			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-			phys_addr + address, flags))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return error;
-}
-
-#define IS_MAPPABLE_UNCACHEABLE(addr) (addr < 0x20000000UL)
-
-/*
- * Map some physical address range into the kernel address space.
- */
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
-{
-	struct vm_struct *area;
-	unsigned long offset;
-	unsigned long last_addr;
-	void *addr;
-
-	/* Don't allow wraparound or zero size */
-	last_addr = phys_addr + size - 1;
-
-	if (!size || last_addr < phys_addr)
-		return NULL;
-
-	/* Don't allow anybody to remap normal RAM that we're using */
-	if (phys_addr > PHYS_OFFSET && phys_addr < virt_to_phys(high_memory)) {
-		char *t_addr, *t_end;
-		struct page *page;
-
-		t_addr = __va(phys_addr);
-		t_end = t_addr + (size - 1);
-		for (page = virt_to_page(t_addr);
-			page <= virt_to_page(t_end); page++)
-			if (!PageReserved(page))
-				return NULL;
-	}
-
-	/*
-	 * Map uncached objects in the low part of address space to
-	 * CONFIG_NIOS2_IO_REGION_BASE
-	 */
-	if (IS_MAPPABLE_UNCACHEABLE(phys_addr) &&
-	    IS_MAPPABLE_UNCACHEABLE(last_addr))
-		return (void __iomem *)(CONFIG_NIOS2_IO_REGION_BASE + phys_addr);
-
-	/* Mappings have to be page-aligned */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
-
-	/* Ok, go for it */
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, 0)) {
-		vunmap(addr);
-		return NULL;
-	}
-	return (void __iomem *) (offset + (char *)addr);
-}
-EXPORT_SYMBOL(ioremap);
-
-/*
- * iounmap unmaps nearly everything, so be careful
- * it doesn't free currently pointer/page tables anymore but it
- * wasn't used anyway and might be added later.
- */
-void iounmap(void __iomem *addr)
-{
-	struct vm_struct *p;
-
-	if ((unsigned long) addr > CONFIG_NIOS2_IO_REGION_BASE)
-		return;
-
-	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
-	if (!p)
-		pr_err("iounmap: bad address %p\n", addr);
-	kfree(p);
-}
-EXPORT_SYMBOL(iounmap);
diff --git a/arch/nios2/mm/mmu_context.c b/arch/nios2/mm/mmu_context.c
deleted file mode 100644
index 45d6b9c58d67..000000000000
--- a/arch/nios2/mm/mmu_context.c
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * MMU context handling.
- *
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/mm.h>
-
-#include <asm/cpuinfo.h>
-#include <asm/mmu_context.h>
-#include <asm/tlb.h>
-
-/* The pids position and mask in context */
-#define PID_SHIFT	0
-#define PID_BITS	(cpuinfo.tlb_pid_num_bits)
-#define PID_MASK	((1UL << PID_BITS) - 1)
-
-/* The versions position and mask in context */
-#define VERSION_BITS	(32 - PID_BITS)
-#define VERSION_SHIFT	(PID_SHIFT + PID_BITS)
-#define VERSION_MASK	((1UL << VERSION_BITS) - 1)
-
-/* Return the version part of a context */
-#define CTX_VERSION(c)	(((c) >> VERSION_SHIFT) & VERSION_MASK)
-
-/* Return the pid part of a context */
-#define CTX_PID(c)	(((c) >> PID_SHIFT) & PID_MASK)
-
-/* Value of the first context (version 1, pid 0) */
-#define FIRST_CTX	((1UL << VERSION_SHIFT) | (0 << PID_SHIFT))
-
-static mm_context_t next_mmu_context;
-
-/*
- * Initialize MMU context management stuff.
- */
-void __init mmu_context_init(void)
-{
-	/* We need to set this here because the value depends on runtime data
-	 * from cpuinfo */
-	next_mmu_context = FIRST_CTX;
-}
-
-/*
- * Set new context (pid), keep way
- */
-static void set_context(mm_context_t context)
-{
-	set_mmu_pid(CTX_PID(context));
-}
-
-static mm_context_t get_new_context(void)
-{
-	/* Return the next pid */
-	next_mmu_context += (1UL << PID_SHIFT);
-
-	/* If the pid field wraps around we increase the version and
-	 * flush the tlb */
-	if (unlikely(CTX_PID(next_mmu_context) == 0)) {
-		/* Version is incremented since the pid increment above
-		 * overflows info version */
-		flush_cache_all();
-		flush_tlb_all();
-	}
-
-	/* If the version wraps we start over with the first generation, we do
-	 * not need to flush the tlb here since it's always done above */
-	if (unlikely(CTX_VERSION(next_mmu_context) == 0))
-		next_mmu_context = FIRST_CTX;
-
-	return next_mmu_context;
-}
-
-void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-	       struct task_struct *tsk)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	/* If the process context we are swapping in has a different context
-	 * generation then we have it should get a new generation/pid */
-	if (unlikely(CTX_VERSION(next->context) !=
-		CTX_VERSION(next_mmu_context)))
-		next->context = get_new_context();
-
-	/* Save the current pgd so the fast tlb handler can find it */
-	pgd_current = next->pgd;
-
-	/* Set the current context */
-	set_context(next->context);
-
-	local_irq_restore(flags);
-}
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-void activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	next->context = get_new_context();
-	set_context(next->context);
-	pgd_current = next->pgd;
-}
-
-unsigned long get_pid_from_context(mm_context_t *context)
-{
-	return CTX_PID((*context));
-}
diff --git a/arch/nios2/mm/pgtable.c b/arch/nios2/mm/pgtable.c
deleted file mode 100644
index 6470ed378782..000000000000
--- a/arch/nios2/mm/pgtable.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Copyright (C) 2009 Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/mm.h>
-#include <linux/sched.h>
-
-#include <asm/cpuinfo.h>
-#include <asm/pgalloc.h>
-
-/* pteaddr:
- *   ptbase | vpn* | zero
- *   31-22  | 21-2 | 1-0
- *
- *   *vpn is preserved on double fault
- *
- * tlbacc:
- *   IG   |*flags| pfn
- *   31-25|24-20 | 19-0
- *
- *   *crwxg
- *
- * tlbmisc:
- *   resv  |way   |rd | we|pid |dbl|bad|perm|d
- *   31-24 |23-20 |19 | 20|17-4|3  |2  |1   |0
- *
- */
-
-/*
- * Initialize a new pgd / pmd table with invalid pointers.
- */
-static void pgd_init(pgd_t *pgd)
-{
-	unsigned long *p = (unsigned long *) pgd;
-	int i;
-
-	for (i = 0; i < USER_PTRS_PER_PGD; i += 8) {
-		p[i + 0] = (unsigned long) invalid_pte_table;
-		p[i + 1] = (unsigned long) invalid_pte_table;
-		p[i + 2] = (unsigned long) invalid_pte_table;
-		p[i + 3] = (unsigned long) invalid_pte_table;
-		p[i + 4] = (unsigned long) invalid_pte_table;
-		p[i + 5] = (unsigned long) invalid_pte_table;
-		p[i + 6] = (unsigned long) invalid_pte_table;
-		p[i + 7] = (unsigned long) invalid_pte_table;
-	}
-}
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *ret, *init;
-
-	ret = __pgd_alloc(mm, 0);
-	if (ret) {
-		init = pgd_offset(&init_mm, 0UL);
-		pgd_init(ret);
-		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-
-	return ret;
-}
-
-void __init pagetable_init(void)
-{
-	/* Initialize the entire pgd.  */
-	pgd_init(swapper_pg_dir);
-	pgd_init(swapper_pg_dir + USER_PTRS_PER_PGD);
-}
diff --git a/arch/nios2/mm/tlb.c b/arch/nios2/mm/tlb.c
deleted file mode 100644
index a9cbe20f9e79..000000000000
--- a/arch/nios2/mm/tlb.c
+++ /dev/null
@@ -1,304 +0,0 @@
-/*
- * Nios2 TLB handling
- *
- * Copyright (C) 2009, Wind River Systems Inc
- *   Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-
-#include <asm/tlb.h>
-#include <asm/mmu_context.h>
-#include <asm/cpuinfo.h>
-
-#define TLB_INDEX_MASK		\
-	((((1UL << (cpuinfo.tlb_ptr_sz - cpuinfo.tlb_num_ways_log2))) - 1) \
-		<< PAGE_SHIFT)
-
-static void get_misc_and_pid(unsigned long *misc, unsigned long *pid)
-{
-	*misc  = RDCTL(CTL_TLBMISC);
-	*misc &= (TLBMISC_PID | TLBMISC_WAY);
-	*pid  = *misc & TLBMISC_PID;
-}
-
-/*
- * This provides a PTEADDR value for addr that will cause a TLB miss
- * (fast TLB miss). TLB invalidation replaces entries with this value.
- */
-static unsigned long pteaddr_invalid(unsigned long addr)
-{
-	return ((addr | 0xC0000000UL) >> PAGE_SHIFT) << 2;
-}
-
-/*
- * This one is only used for pages with the global bit set so we don't care
- * much about the ASID.
- */
-static void replace_tlb_one_pid(unsigned long addr, unsigned long mmu_pid, unsigned long tlbacc)
-{
-	unsigned int way;
-	unsigned long org_misc, pid_misc;
-
-	/* remember pid/way until we return. */
-	get_misc_and_pid(&org_misc, &pid_misc);
-
-	WRCTL(CTL_PTEADDR, (addr >> PAGE_SHIFT) << 2);
-
-	for (way = 0; way < cpuinfo.tlb_num_ways; way++) {
-		unsigned long pteaddr;
-		unsigned long tlbmisc;
-		unsigned long pid;
-
-		tlbmisc = TLBMISC_RD | (way << TLBMISC_WAY_SHIFT);
-		WRCTL(CTL_TLBMISC, tlbmisc);
-
-		pteaddr = RDCTL(CTL_PTEADDR);
-		if (((pteaddr >> 2) & 0xfffff) != (addr >> PAGE_SHIFT))
-			continue;
-
-		tlbmisc = RDCTL(CTL_TLBMISC);
-		pid = (tlbmisc >> TLBMISC_PID_SHIFT) & TLBMISC_PID_MASK;
-		if (pid != mmu_pid)
-			continue;
-
-		tlbmisc = (mmu_pid << TLBMISC_PID_SHIFT) | TLBMISC_WE |
-			  (way << TLBMISC_WAY_SHIFT);
-		WRCTL(CTL_TLBMISC, tlbmisc);
-		if (tlbacc == 0)
-			WRCTL(CTL_PTEADDR, pteaddr_invalid(addr));
-		WRCTL(CTL_TLBACC, tlbacc);
-		/*
-		 * There should be only a single entry that maps a
-		 * particular {address,pid} so break after a match.
-		 */
-		break;
-	}
-
-	WRCTL(CTL_TLBMISC, org_misc);
-}
-
-static void flush_tlb_one_pid(unsigned long addr, unsigned long mmu_pid)
-{
-	pr_debug("Flush tlb-entry for vaddr=%#lx\n", addr);
-
-	replace_tlb_one_pid(addr, mmu_pid, 0);
-}
-
-static void reload_tlb_one_pid(unsigned long addr, unsigned long mmu_pid, pte_t pte)
-{
-	pr_debug("Reload tlb-entry for vaddr=%#lx\n", addr);
-
-	replace_tlb_one_pid(addr, mmu_pid, pte_val(pte));
-}
-
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end)
-{
-	unsigned long mmu_pid = get_pid_from_context(&vma->vm_mm->context);
-
-	while (start < end) {
-		flush_tlb_one_pid(start, mmu_pid);
-		start += PAGE_SIZE;
-	}
-}
-
-void reload_tlb_page(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
-{
-	unsigned long mmu_pid = get_pid_from_context(&vma->vm_mm->context);
-
-	reload_tlb_one_pid(addr, mmu_pid, pte);
-}
-
-/*
- * This one is only used for pages with the global bit set so we don't care
- * much about the ASID.
- */
-static void flush_tlb_one(unsigned long addr)
-{
-	unsigned int way;
-	unsigned long org_misc, pid_misc;
-
-	pr_debug("Flush tlb-entry for vaddr=%#lx\n", addr);
-
-	/* remember pid/way until we return. */
-	get_misc_and_pid(&org_misc, &pid_misc);
-
-	WRCTL(CTL_PTEADDR, (addr >> PAGE_SHIFT) << 2);
-
-	for (way = 0; way < cpuinfo.tlb_num_ways; way++) {
-		unsigned long pteaddr;
-		unsigned long tlbmisc;
-
-		tlbmisc = TLBMISC_RD | (way << TLBMISC_WAY_SHIFT);
-		WRCTL(CTL_TLBMISC, tlbmisc);
-
-		pteaddr = RDCTL(CTL_PTEADDR);
-		if (((pteaddr >> 2) & 0xfffff) != (addr >> PAGE_SHIFT))
-			continue;
-
-		tlbmisc = RDCTL(CTL_TLBMISC);
-		pr_debug("Flush entry by writing way=%dl pid=%ld\n",
-			 way, ((tlbmisc >> TLBMISC_PID_SHIFT) & TLBMISC_PID_MASK));
-
-		tlbmisc = TLBMISC_WE | (way << TLBMISC_WAY_SHIFT) | (tlbmisc & TLBMISC_PID);
-		WRCTL(CTL_TLBMISC, tlbmisc);
-		WRCTL(CTL_PTEADDR, pteaddr_invalid(addr));
-		WRCTL(CTL_TLBACC, 0);
-	}
-
-	WRCTL(CTL_TLBMISC, org_misc);
-}
-
-void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-	while (start < end) {
-		flush_tlb_one(start);
-		start += PAGE_SIZE;
-	}
-}
-
-void dump_tlb_line(unsigned long line)
-{
-	unsigned int way;
-	unsigned long org_misc;
-
-	pr_debug("dump tlb-entries for line=%#lx (addr %08lx)\n", line,
-		line << (PAGE_SHIFT + cpuinfo.tlb_num_ways_log2));
-
-	/* remember pid/way until we return */
-	org_misc = (RDCTL(CTL_TLBMISC) & (TLBMISC_PID | TLBMISC_WAY));
-
-	WRCTL(CTL_PTEADDR, line << 2);
-
-	for (way = 0; way < cpuinfo.tlb_num_ways; way++) {
-		unsigned long pteaddr;
-		unsigned long tlbmisc;
-		unsigned long tlbacc;
-
-		WRCTL(CTL_TLBMISC, TLBMISC_RD | (way << TLBMISC_WAY_SHIFT));
-		pteaddr = RDCTL(CTL_PTEADDR);
-		tlbmisc = RDCTL(CTL_TLBMISC);
-		tlbacc = RDCTL(CTL_TLBACC);
-
-		if ((tlbacc << PAGE_SHIFT) != 0) {
-			pr_debug("-- way:%02x vpn:0x%08lx phys:0x%08lx pid:0x%02lx flags:%c%c%c%c%c\n",
-				way,
-				(pteaddr << (PAGE_SHIFT-2)),
-				(tlbacc << PAGE_SHIFT),
-				((tlbmisc >> TLBMISC_PID_SHIFT) &
-				TLBMISC_PID_MASK),
-				(tlbacc & _PAGE_READ ? 'r' : '-'),
-				(tlbacc & _PAGE_WRITE ? 'w' : '-'),
-				(tlbacc & _PAGE_EXEC ? 'x' : '-'),
-				(tlbacc & _PAGE_GLOBAL ? 'g' : '-'),
-				(tlbacc & _PAGE_CACHED ? 'c' : '-'));
-		}
-	}
-
-	WRCTL(CTL_TLBMISC, org_misc);
-}
-
-void dump_tlb(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < cpuinfo.tlb_num_lines; i++)
-		dump_tlb_line(i);
-}
-
-void flush_tlb_pid(unsigned long mmu_pid)
-{
-	unsigned long addr = 0;
-	unsigned int line;
-	unsigned int way;
-	unsigned long org_misc, pid_misc;
-
-	/* remember pid/way until we return */
-	get_misc_and_pid(&org_misc, &pid_misc);
-
-	for (line = 0; line < cpuinfo.tlb_num_lines; line++) {
-		WRCTL(CTL_PTEADDR, pteaddr_invalid(addr));
-
-		for (way = 0; way < cpuinfo.tlb_num_ways; way++) {
-			unsigned long tlbmisc;
-			unsigned long pid;
-
-			tlbmisc = TLBMISC_RD | (way << TLBMISC_WAY_SHIFT);
-			WRCTL(CTL_TLBMISC, tlbmisc);
-			tlbmisc = RDCTL(CTL_TLBMISC);
-			pid = (tlbmisc >> TLBMISC_PID_SHIFT) & TLBMISC_PID_MASK;
-			if (pid != mmu_pid)
-				continue;
-
-			tlbmisc = TLBMISC_WE | (way << TLBMISC_WAY_SHIFT) |
-				  (pid << TLBMISC_PID_SHIFT);
-			WRCTL(CTL_TLBMISC, tlbmisc);
-			WRCTL(CTL_TLBACC, 0);
-		}
-
-		addr += PAGE_SIZE;
-	}
-
-	WRCTL(CTL_TLBMISC, org_misc);
-}
-
-/*
- * All entries common to a mm share an asid.  To effectively flush these
- * entries, we just bump the asid.
- */
-void flush_tlb_mm(struct mm_struct *mm)
-{
-	if (current->mm == mm) {
-		unsigned long mmu_pid = get_pid_from_context(&mm->context);
-		flush_tlb_pid(mmu_pid);
-	} else {
-		memset(&mm->context, 0, sizeof(mm_context_t));
-	}
-}
-
-void flush_tlb_all(void)
-{
-	unsigned long addr = 0;
-	unsigned int line;
-	unsigned int way;
-	unsigned long org_misc, pid_misc;
-
-	/* remember pid/way until we return */
-	get_misc_and_pid(&org_misc, &pid_misc);
-
-	/* Map each TLB entry to physcal address 0 with no-access and a
-	   bad ptbase */
-	for (line = 0; line < cpuinfo.tlb_num_lines; line++) {
-		WRCTL(CTL_PTEADDR, pteaddr_invalid(addr));
-		for (way = 0; way < cpuinfo.tlb_num_ways; way++) {
-			// Code such as replace_tlb_one_pid assumes that no duplicate entries exist
-			// for a single address across ways, so also use way as a dummy PID
-			WRCTL(CTL_TLBMISC, TLBMISC_WE | (way << TLBMISC_WAY_SHIFT) |
-					   (way << TLBMISC_PID_SHIFT));
-			WRCTL(CTL_TLBACC, 0);
-		}
-
-		addr += PAGE_SIZE;
-	}
-
-	/* restore pid/way */
-	WRCTL(CTL_TLBMISC, org_misc);
-}
-
-void set_mmu_pid(unsigned long pid)
-{
-	unsigned long tlbmisc;
-
-	tlbmisc = RDCTL(CTL_TLBMISC);
-	tlbmisc = (tlbmisc & TLBMISC_WAY);
-	tlbmisc |= (pid & TLBMISC_PID_MASK) << TLBMISC_PID_SHIFT;
-	WRCTL(CTL_TLBMISC, tlbmisc);
-}
diff --git a/arch/nios2/mm/uaccess.c b/arch/nios2/mm/uaccess.c
deleted file mode 100644
index 34f10af8ea40..000000000000
--- a/arch/nios2/mm/uaccess.c
+++ /dev/null
@@ -1,130 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2009, Wind River Systems Inc
- * Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
- */
-
-#include <linux/export.h>
-#include <linux/uaccess.h>
-
-asm(".global	raw_copy_from_user\n"
-	"   .type raw_copy_from_user, @function\n"
-	"raw_copy_from_user:\n"
-	"   movi  r2,7\n"
-	"   mov   r3,r4\n"
-	"   bge   r2,r6,1f\n"
-	"   xor   r2,r4,r5\n"
-	"   andi  r2,r2,3\n"
-	"   movi  r7,3\n"
-	"   beq   r2,zero,4f\n"
-	"1: addi  r6,r6,-1\n"
-	"   movi  r2,-1\n"
-	"   beq   r6,r2,3f\n"
-	"   mov   r7,r2\n"
-	"2: ldbu  r2,0(r5)\n"
-	"   addi  r6,r6,-1\n"
-	"   addi  r5,r5,1\n"
-	"   stb   r2,0(r3)\n"
-	"   addi  r3,r3,1\n"
-	"   bne   r6,r7,2b\n"
-	"3:\n"
-	"   addi  r2,r6,1\n"
-	"   ret\n"
-	"13:mov   r2,r6\n"
-	"   ret\n"
-	"4: andi  r2,r4,1\n"
-	"   cmpeq r2,r2,zero\n"
-	"   beq   r2,zero,7f\n"
-	"5: andi  r2,r3,2\n"
-	"   beq   r2,zero,6f\n"
-	"9: ldhu  r2,0(r5)\n"
-	"   addi  r6,r6,-2\n"
-	"   addi  r5,r5,2\n"
-	"   sth   r2,0(r3)\n"
-	"   addi  r3,r3,2\n"
-	"6: bge   r7,r6,1b\n"
-	"10:ldw   r2,0(r5)\n"
-	"   addi  r6,r6,-4\n"
-	"   addi  r5,r5,4\n"
-	"   stw   r2,0(r3)\n"
-	"   addi  r3,r3,4\n"
-	"   br    6b\n"
-	"7: ldbu  r2,0(r5)\n"
-	"   addi  r6,r6,-1\n"
-	"   addi  r5,r5,1\n"
-	"   addi  r3,r4,1\n"
-	"   stb   r2,0(r4)\n"
-	"   br    5b\n"
-	".section __ex_table,\"a\"\n"
-	".word 2b,3b\n"
-	".word 9b,13b\n"
-	".word 10b,13b\n"
-	".word 7b,13b\n"
-	".previous\n"
-	);
-EXPORT_SYMBOL(raw_copy_from_user);
-
-asm(
-	"   .global raw_copy_to_user\n"
-	"   .type raw_copy_to_user, @function\n"
-	"raw_copy_to_user:\n"
-	"   movi  r2,7\n"
-	"   mov   r3,r4\n"
-	"   bge   r2,r6,1f\n"
-	"   xor   r2,r4,r5\n"
-	"   andi  r2,r2,3\n"
-	"   movi  r7,3\n"
-	"   beq   r2,zero,4f\n"
-	/* Bail if we try to copy zero bytes  */
-	"1: addi  r6,r6,-1\n"
-	"   movi  r2,-1\n"
-	"   beq   r6,r2,3f\n"
-	/* Copy byte by byte for small copies and if src^dst != 0 */
-	"   mov   r7,r2\n"
-	"2: ldbu  r2,0(r5)\n"
-	"   addi  r5,r5,1\n"
-	"9: stb   r2,0(r3)\n"
-	"   addi  r6,r6,-1\n"
-	"   addi  r3,r3,1\n"
-	"   bne   r6,r7,2b\n"
-	"3: addi  r2,r6,1\n"
-	"   ret\n"
-	"13:mov   r2,r6\n"
-	"   ret\n"
-	/*  If 'to' is an odd address byte copy */
-	"4: andi  r2,r4,1\n"
-	"   cmpeq r2,r2,zero\n"
-	"   beq   r2,zero,7f\n"
-	/* If 'to' is not divideable by four copy halfwords */
-	"5: andi  r2,r3,2\n"
-	"   beq   r2,zero,6f\n"
-	"   ldhu  r2,0(r5)\n"
-	"   addi  r5,r5,2\n"
-	"10:sth   r2,0(r3)\n"
-	"   addi  r6,r6,-2\n"
-	"   addi  r3,r3,2\n"
-	/* Copy words */
-	"6: bge   r7,r6,1b\n"
-	"   ldw   r2,0(r5)\n"
-	"   addi  r5,r5,4\n"
-	"11:stw   r2,0(r3)\n"
-	"   addi  r6,r6,-4\n"
-	"   addi  r3,r3,4\n"
-	"   br    6b\n"
-	/* Copy remaining bytes */
-	"7: ldbu  r2,0(r5)\n"
-	"   addi  r5,r5,1\n"
-	"   addi  r3,r4,1\n"
-	"12: stb  r2,0(r4)\n"
-	"   addi  r6,r6,-1\n"
-	"   br    5b\n"
-	".section __ex_table,\"a\"\n"
-	".word 9b,3b\n"
-	".word 10b,13b\n"
-	".word 11b,13b\n"
-	".word 12b,13b\n"
-	".previous\n");
-EXPORT_SYMBOL(raw_copy_to_user);
diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
deleted file mode 100644
index c75cadd92388..000000000000
--- a/arch/nios2/platform/Kconfig.platform
+++ /dev/null
@@ -1,149 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menu "Platform options"
-
-comment "Memory settings"
-
-config NIOS2_MEM_BASE
-	hex "Memory base address"
-	default "0x00000000"
-	help
-	  This is the physical address of the memory that the kernel will run
-	  from. This address is used to link the kernel and setup initial memory
-	  management. You should take the raw memory address without any MMU
-	  or cache bits set.
-	  Please not that this address is used directly so you have to manually
-	  do address translation if it's connected to a bridge.
-
-comment "Device tree"
-
-config NIOS2_DTB_AT_PHYS_ADDR
-	bool "DTB at physical address"
-	help
-	  When enabled you can select a physical address to load the dtb from.
-	  Normally this address is passed by a bootloader such as u-boot but
-	  using this you can use a devicetree without a bootloader.
-	  This way you can store a devicetree in NOR flash or an onchip rom.
-	  Please note that this address is used directly so you have to manually
-	  do address translation if it's connected to a bridge. Also take into
-	  account that when using an MMU you'd have to ad 0xC0000000 to your
-	  address
-
-config NIOS2_DTB_PHYS_ADDR
-	hex "DTB Address"
-	depends on NIOS2_DTB_AT_PHYS_ADDR
-	default "0xC0000000"
-	help
-	  Physical address of a dtb blob.
-
-config BUILTIN_DTB
-	bool "Compile and link device tree into kernel image"
-	depends on !COMPILE_TEST
-	select GENERIC_BUILTIN_DTB
-	help
-	  This allows you to specify a dts (device tree source) file
-	  which will be compiled and linked into the kernel image.
-
-config BUILTIN_DTB_NAME
-	string "Built-in device tree name"
-	depends on BUILTIN_DTB
-	default ""
-	help
-	  Relative path to the device tree without suffix describing your
-	  system.
-
-comment "Nios II instructions"
-
-config NIOS2_ARCH_REVISION
-	int "Select Nios II architecture revision"
-	range 1 2
-	default 1
-	help
-	  Select between Nios II R1 and Nios II R2 . The architectures
-	  are binary incompatible. Default is R1 .
-
-config NIOS2_HW_MUL_SUPPORT
-	bool "Enable MUL instruction"
-	help
-	  Set to true if you configured the Nios II to include the MUL
-	  instruction.  This will enable the -mhw-mul compiler flag.
-
-config NIOS2_HW_MULX_SUPPORT
-	bool "Enable MULX instruction"
-	help
-	  Set to true if you configured the Nios II to include the MULX
-	  instruction.  Enables the -mhw-mulx compiler flag.
-
-config NIOS2_HW_DIV_SUPPORT
-	bool "Enable DIV instruction"
-	help
-	  Set to true if you configured the Nios II to include the DIV
-	  instruction.  Enables the -mhw-div compiler flag.
-
-config NIOS2_BMX_SUPPORT
-	bool "Enable BMX instructions"
-	depends on NIOS2_ARCH_REVISION = 2
-	help
-	  Set to true if you configured the Nios II R2 to include
-	  the BMX Bit Manipulation Extension instructions. Enables
-	  the -mbmx compiler flag.
-
-config NIOS2_CDX_SUPPORT
-	bool "Enable CDX instructions"
-	depends on NIOS2_ARCH_REVISION = 2
-	help
-	  Set to true if you configured the Nios II R2 to include
-	  the CDX Bit Manipulation Extension instructions. Enables
-	  the -mcdx compiler flag.
-
-config NIOS2_FPU_SUPPORT
-	bool "Custom floating point instr support"
-	help
-	  Enables the -mcustom-fpu-cfg=60-1 compiler flag.
-
-config NIOS2_CI_SWAB_SUPPORT
-	bool "Byteswap custom instruction"
-	help
-	  Use the byteswap (endian converter) Nios II custom instruction provided
-	  by Altera and which can be enabled in QSYS builder. This accelerates
-	  endian conversions in the kernel (e.g. ntohs).
-
-config NIOS2_CI_SWAB_NO
-	int "Byteswap custom instruction number" if NIOS2_CI_SWAB_SUPPORT
-	default 0
-	help
-	  Number of the instruction as configured in QSYS Builder.
-
-comment "Cache settings"
-
-config CUSTOM_CACHE_SETTINGS
-	bool "Custom cache settings"
-	help
-	  This option allows you to tweak the cache settings used during early
-	  boot (where the information from device tree is not yet available).
-	  There should be no reason to change these values. Linux will work
-	  perfectly fine, even if the Nios II is configured with smaller caches.
-
-	  Say N here unless you know what you are doing.
-
-config NIOS2_DCACHE_SIZE
-	hex "D-Cache size" if CUSTOM_CACHE_SETTINGS
-	range 0x200 0x10000
-	default "0x800"
-	help
-	  Maximum possible data cache size.
-
-config NIOS2_DCACHE_LINE_SIZE
-	hex "D-Cache line size" if CUSTOM_CACHE_SETTINGS
-	range 0x10 0x20
-	default "0x20"
-	help
-	  Minimum possible data cache line size.
-
-config NIOS2_ICACHE_SIZE
-	hex "I-Cache size" if CUSTOM_CACHE_SETTINGS
-	range 0x200 0x10000
-	default "0x1000"
-	help
-	  Maximum possible instruction cache size.
-
-endmenu
diff --git a/arch/nios2/platform/Makefile b/arch/nios2/platform/Makefile
deleted file mode 100644
index fb5bdb44c119..000000000000
--- a/arch/nios2/platform/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y += platform.o
diff --git a/arch/nios2/platform/platform.c b/arch/nios2/platform/platform.c
deleted file mode 100644
index 7948f063f55d..000000000000
--- a/arch/nios2/platform/platform.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright (C) 2013 Altera Corporation
- * Copyright (C) 2011 Thomas Chou
- * Copyright (C) 2011 Walter Goossens
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
- */
-
-#include <linux/init.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/sys_soc.h>
-#include <linux/io.h>
-#include <linux/clk-provider.h>
-
-static const struct of_device_id clk_match[] __initconst = {
-	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
-	{}
-};
-
-static int __init nios2_soc_device_init(void)
-{
-	struct soc_device *soc_dev;
-	struct soc_device_attribute *soc_dev_attr;
-	const char *machine;
-
-	soc_dev_attr = kzalloc_obj(*soc_dev_attr);
-	if (soc_dev_attr) {
-		machine = of_flat_dt_get_machine_name();
-		if (machine)
-			soc_dev_attr->machine = kasprintf(GFP_KERNEL, "%s",
-						machine);
-
-		soc_dev_attr->family = "Nios II";
-
-		soc_dev = soc_device_register(soc_dev_attr);
-		if (IS_ERR(soc_dev)) {
-			kfree(soc_dev_attr->machine);
-			kfree(soc_dev_attr);
-		}
-	}
-
-	of_clk_init(clk_match);
-
-	return 0;
-}
-
-device_initcall(nios2_soc_device_init);
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ae6a682c9f76..e9f3115c1b74 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -117,7 +117,7 @@ config AT_XDMAC
 
 config AXI_DMAC
 	tristate "Analog Devices AXI-DMAC DMA support"
-	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select REGMAP_MMIO
diff --git a/drivers/gpib/common/iblib.c b/drivers/gpib/common/iblib.c
index b672dd6aad25..7d9a4ab67b28 100644
--- a/drivers/gpib/common/iblib.c
+++ b/drivers/gpib/common/iblib.c
@@ -220,11 +220,7 @@ int ibonline(struct gpib_board *board)
 		board->interface->detach(board);
 		return retval;
 	}
-	/*
-	 * nios2nommu on 2.6.11 uclinux kernel has weird problems
-	 * with autospoll thread causing huge slowdowns
-	 */
-#ifndef CONFIG_NIOS2
+
 	board->autospoll_task = kthread_run(&autospoll_thread, board,
 					    "gpib%d_autospoll_kthread", board->minor);
 	if (IS_ERR(board->autospoll_task)) {
@@ -232,7 +228,7 @@ int ibonline(struct gpib_board *board)
 		board->interface->detach(board);
 		return PTR_ERR(board->autospoll_task);
 	}
-#endif
+
 	board->online = 1;
 	dev_dbg(board->gpib_dev, "board online\n");
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..a7d85f236018 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -396,11 +396,11 @@ comment "I2C system bus drivers (mostly embedded / system-on-chip)"
 
 config I2C_ALTERA
 	tristate "Altera Soft IP I2C"
-	depends on ARCH_INTEL_SOCFPGA || NIOS2 || COMPILE_TEST
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	depends on OF
 	help
 	  If you say yes to this option, support will be included for the
-	  Altera Soft IP I2C interfaces on SoCFPGA and Nios2 architectures.
+	  Altera Soft IP I2C interfaces on the SoCFPGA architecture.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-altera.
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..d7f9187d8e97 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -574,7 +574,7 @@ config ADE9000
 
 config ADI_AXI_ADC
 	tristate "Analog Devices Generic AXI ADC IP core driver"
-	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	select IIO_BUFFER_DMAENGINE
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b65415..ceaa6c056935 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -196,7 +196,7 @@ config AD9739A
 
 config ADI_AXI_DAC
 	tristate "Analog Devices Generic AXI DAC IP core driver"
-	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
 	select REGMAP_MMIO
diff --git a/drivers/net/ethernet/davicom/Kconfig b/drivers/net/ethernet/davicom/Kconfig
index 02e0caff98e3..c7bcf1babd37 100644
--- a/drivers/net/ethernet/davicom/Kconfig
+++ b/drivers/net/ethernet/davicom/Kconfig
@@ -18,7 +18,7 @@ if NET_VENDOR_DAVICOM
 
 config DM9000
 	tristate "DM9000 support"
-	depends on ARM || MIPS || COLDFIRE || NIOS2 || COMPILE_TEST
+	depends on ARM || MIPS || COLDFIRE || COMPILE_TEST
 	select CRC32
 	select MII
 	help
diff --git a/drivers/net/ethernet/smsc/Kconfig b/drivers/net/ethernet/smsc/Kconfig
index 66bca803b19c..36307f1cbdf8 100644
--- a/drivers/net/ethernet/smsc/Kconfig
+++ b/drivers/net/ethernet/smsc/Kconfig
@@ -7,7 +7,7 @@ config NET_VENDOR_SMSC
 	bool "SMC (SMSC)/Western Digital devices"
 	default y
 	depends on ARM || ARM64 || ATARI_ETHERNAT || COLDFIRE || \
-		   ISA || MAC || MIPS || NIOS2 || PCI || \
+		   ISA || MAC || MIPS || PCI || \
 		   PCMCIA || SUPERH || XTENSA || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
@@ -25,7 +25,7 @@ config SMC91X
 	select MII
 	depends on !OF || GPIOLIB
 	depends on ARM || ARM64 || ATARI_ETHERNAT || COLDFIRE || \
-		   MIPS || NIOS2 || SUPERH || XTENSA || COMPILE_TEST
+		   MIPS || SUPERH || XTENSA || COMPILE_TEST
 	help
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 2247709ef6d6..2cbffd08afbd 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -21,7 +21,7 @@ config PCI_AARDVARK
 
 config PCIE_ALTERA
 	tristate "Altera PCIe controller"
-	depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera
 	  FPGA.
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..d8145f369ec3 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -131,7 +131,7 @@ config PWM_ATMEL_TCB
 
 config PWM_AXI_PWMGEN
 	tristate "Analog Devices AXI PWM generator"
-	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  This enables support for the Analog Devices AXI PWM generator.
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5a40252b8334..edc8c96d91b6 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1261,7 +1261,7 @@ extern void __scoped_seqlock_invalid_target(void);
 
 #if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || defined(CONFIG_KASAN)
 /*
- * For some reason some GCC-8 architectures (nios2, alpha) have trouble
+ * For some reason some GCC-8 architectures (such as alpha) have trouble
  * determining that the ss_done state is impossible in __scoped_seqlock_next()
  * below.
  *
diff --git a/lib/tests/usercopy_kunit.c b/lib/tests/usercopy_kunit.c
index 80f8abe10968..f99b77ccc9be 100644
--- a/lib/tests/usercopy_kunit.c
+++ b/lib/tests/usercopy_kunit.c
@@ -25,7 +25,6 @@
 #if BITS_PER_LONG == 64 || (!(defined(CONFIG_ARM) && !defined(MMU)) && \
 			    !defined(CONFIG_M68K) &&		\
 			    !defined(CONFIG_MICROBLAZE) &&	\
-			    !defined(CONFIG_NIOS2) &&		\
 			    !defined(CONFIG_PPC32) &&		\
 			    !defined(CONFIG_SPARC32) &&		\
 			    !defined(CONFIG_SUPERH))
diff --git a/mm/Kconfig b/mm/Kconfig
index e8bf1e9e6ad9..ebbd66ab8d5d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -3,8 +3,8 @@
 menu "Memory Management options"
 
 #
-# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
-# add proper SWAP support to them, in which case this can be remove.
+# For some reason microblaze hard codes SWAP=n.  Hopefully we can
+# add proper SWAP support to it, in which case this can be removed.
 #
 config ARCH_NO_SWAP
 	bool
diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 14ce31f732ee..ac7adc3d1f95 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -78,9 +78,6 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 	} elsif ($arch eq 'mips') {
 		#88003254:       27bdffe0        addiu   sp,sp,-32
 		$re = qr/.*addiu.*sp,sp,-([0-9]{1,8})/o;
-	} elsif ($arch eq 'nios2') {
-		#25a8:	defffb04 	addi	sp,sp,-20
-		$re = qr/.*addi.*sp,sp,-([0-9]{1,8})/o;
 	} elsif ($arch eq 'openrisc') {
 		# c000043c:       9c 21 fe f0     l.addi r1,r1,-272
 		$re = qr/.*l\.addi.*r1,r1,-([0-9]{1,8})/o;
diff --git a/scripts/dtc/include-prefixes/nios2 b/scripts/dtc/include-prefixes/nios2
deleted file mode 120000
index 51772336d13f..000000000000
--- a/scripts/dtc/include-prefixes/nios2
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/nios2/boot/dts
\ No newline at end of file
diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index 7274dfc65af6..ec70284cf685 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -23,7 +23,6 @@ arch/m68k/coldfire/head.o
 arch/m68k/kernel/head.o
 arch/m68k/kernel/sun3-head.o
 arch/microblaze/kernel/head.o
-arch/nios2/kernel/head.o
 arch/parisc/kernel/head.o
 arch/powerpc/kernel/head_44x.o
 arch/powerpc/kernel/head_64.o
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..8dc16f111872 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -298,8 +298,6 @@
 244	csky	set_thread_area			sys_set_thread_area
 245	csky	cacheflush			sys_cacheflush
 
-244	nios2	cacheflush			sys_cacheflush
-
 244	or1k	or1k_atomic			sys_or1k_atomic
 
 258	riscv	riscv_hwprobe			sys_riscv_hwprobe
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index 7a42b32b6577..8dc16f111872 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -298,8 +298,6 @@
 244	csky	set_thread_area			sys_set_thread_area
 245	csky	cacheflush			sys_cacheflush
 
-244	nios2	cacheflush			sys_cacheflush
-
 244	or1k	or1k_atomic			sys_or1k_atomic
 
 258	riscv	riscv_hwprobe			sys_riscv_hwprobe
diff --git a/usr/include/Makefile b/usr/include/Makefile
index ee69dd9d970e..f4716b23db23 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -50,7 +50,7 @@ no-header-test += xen/privcmd.h
 
 # More headers are broken in some architectures
 
-ifneq ($(filter arc openrisc xtensa nios2, $(UAPI_ARCH)),)
+ifneq ($(filter arc openrisc xtensa, $(UAPI_ARCH)),)
 no-header-test += linux/bpf_perf_event.h
 endif
 
@@ -149,10 +149,6 @@ ifeq ($(UAPI_ARCH),hexagon)
 uses-libc += asm/sigcontext.h
 endif
 
-ifeq ($(UAPI_ARCH),nios2)
-uses-libc += asm/ptrace.h
-endif
-
 ifeq ($(UAPI_ARCH),s390)
 uses-libc += asm/chpid.h
 uses-libc += asm/chsc.h
-- 
2.43.0


