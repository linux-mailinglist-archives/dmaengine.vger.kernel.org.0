Return-Path: <dmaengine+bounces-4877-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D414A8668A
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 21:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB52C4C4A47
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E6727C17D;
	Fri, 11 Apr 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEfUH6kg"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1227F4F0
	for <dmaengine@vger.kernel.org>; Fri, 11 Apr 2025 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400533; cv=none; b=C4GsUwoVoVixYywDH/XMRs5jKpxvssz3xJ/Z3KJmw4mK7rQLrV8a82n5P/uN0dEmu9M4gSmH9E9pKaIP9o/HGdZ5w8SWtkyj/tSXhbqyPXKhXgY0dNEA2WNy+M6XBGUuhmdhLLzJC+2cjJ+PqJsZEu+ciRYHalMitLjscWf9PDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400533; c=relaxed/simple;
	bh=9VHCoHoVoLcUpfjgEu8Wrefh1WZa5Op1+fVbKLqDOG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbgfY0GGJq1Q15XLijUR7vx1zJ67EnpVdwionIrmwlUO0oBb0oDbXd+NWSFufnPHXPTPE4aQKHhrG6XenJFIQFVtvibxIgS840JzXkZd5AyRB0leP0VBRzynNfuMfGhBrHdhtGZ2DkpSuoKZmnw5Tl1/H5aG+CPMqpC5RhvPxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEfUH6kg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744400529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LBkVzQwulEIbqT31Hy7Xt/vzUO6eBHgkgZI1AJ82t+A=;
	b=hEfUH6kga4TA7j94hskuG42CUwo4o5p2OEFw3aMEhs5yX8u7ldqAtcesC0UBwy83ZQJ4cU
	43SSbZYQJNGtdZLsp73WEtDLkJOXo0jpMZKFZ4+BT5S/y9BZJiO2Kv/yBMMESlXhLVzSp3
	JB6KIJE/ktnqu8l3qiGdoT7z0MDe9NY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-Tg5MRvypMWGTYMgb5FHtwg-1; Fri,
 11 Apr 2025 15:42:05 -0400
X-MC-Unique: Tg5MRvypMWGTYMgb5FHtwg-1
X-Mimecast-MFC-AGG-ID: Tg5MRvypMWGTYMgb5FHtwg_1744400524
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FD661955EE5;
	Fri, 11 Apr 2025 19:42:04 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.22.65.78])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E4273001D15;
	Fri, 11 Apr 2025 19:42:01 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: Basavaraj.Natikar@amd.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jsnitsel@redhat.com,
	ddutile@redhat.com,
	Eder Zulian <ezulian@redhat.com>
Subject: [PATCH RFC 0/1] ptdma: Add SLAB_TYPESAFE_BY_RCU to DMA descriptor slab
Date: Fri, 11 Apr 2025 21:41:47 +0200
Message-ID: <20250411194148.247361-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello everyone,

during tests we noticed "BUG: KASAN: slab-use-after-free in
pt_cmd_callback".

The bug is reproducible on Linus' tree commit 38fec10eb60d ("Linux 6.14").

The bug can be prevented by adding the SLAB_TYPESAFE_BY_RCU flag to the
kmem_cache_create() call when creating the lookaside cache for the DMA
descriptors. However, at the moment I don't fully understand if that is an
acceptable (and/or necessary) solution. Therefore, I would very much
appreciate your comments and help.

A simple reproducer consists in using the dmatest module for testing the
PTDMA driver as follows.

  #!/bin/bash

  for t in $(seq 1 10); do
      echo "dmatest: 1 channel, 1 thread, iteration: ${t}" > /dev/kmsg
      modprobe dmatest
  
      echo 3000 > /sys/module/dmatest/parameters/timeout
      echo 500 > /sys/module/dmatest/parameters/iterations
      echo 0 > /sys/module/dmatest/parameters/dmatest
      echo 1 > /sys/module/dmatest/parameters/threads_per_chan
      echo dma0chan0 > /sys/module/dmatest/parameters/channel
  
      echo 1 > /sys/module/dmatest/parameters/run
      cat /sys/module/dmatest/parameters/wait
      modprobe -r dmatest
  done

KASAN may report salb-use-after-free already in the first iteration of the
reproducer script above.

In the extract below the problem was observed at iteration 399 of dmatest
during the first iteration of the reproducer script.

[ 1037.797292] ptdma 0000:02:00.2: vchan ffff8881fe444428: txd ffff8881f937a440[190]: submitted
[ 1037.797340] dmatest: dma0chan0-copy0: verifying source buffer...
[ 1037.797375] dmatest: dma0chan0-copy0: verifying dest buffer...
[ 1037.797410] dmatest: dma0chan0-copy0: result #399: 'test passed' with src_off=0xa46 dst_off=0xe06 len=0x24d8 (0)
[ 1037.797492] ptdma 0000:02:00.2: vchan ffff8881fe444428: txd ffff8881f9379440[191]: submitted
[ 1037.797984] ==================================================================
[ 1037.805207] BUG: KASAN: slab-use-after-free in pt_cmd_callback (drivers/dma/amd/ptdma/ptdma-dmaengine.c:183 drivers/dma/amd/ptdma/ptdma-dmaengine.c:272) ptdma 
[ 1037.812782] Write of size 4 at addr ffff8881f9379538 by task dma0chan0-copy0/6481

[ 1037.821765] Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS 2.17.4 10/04/2024
[ 1037.821768] Call Trace:
[ 1037.821770]  <TASK>
[ 1037.821772] dump_stack_lvl (lib/dump_stack.c:123) 
[ 1037.821779] print_address_description.constprop.0 (mm/kasan/report.c:409) 
[ 1037.821786] ? pt_cmd_callback (drivers/dma/amd/ptdma/ptdma-dmaengine.c:183 drivers/dma/amd/ptdma/ptdma-dmaengine.c:272) ptdma 
[ 1037.821791] print_report (mm/kasan/report.c:522) 
[ 1037.821795] ? pt_cmd_callback (drivers/dma/amd/ptdma/ptdma-dmaengine.c:183 drivers/dma/amd/ptdma/ptdma-dmaengine.c:272) ptdma 
[ 1037.821799] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 1037.821803] kasan_report (mm/kasan/report.c:636) 
[ 1037.821808] ? pt_cmd_callback (drivers/dma/amd/ptdma/ptdma-dmaengine.c:183 drivers/dma/amd/ptdma/ptdma-dmaengine.c:272) ptdma 
[ 1037.821815] pt_cmd_callback (drivers/dma/amd/ptdma/ptdma-dmaengine.c:183 drivers/dma/amd/ptdma/ptdma-dmaengine.c:272) ptdma 
[ 1037.821822] ? __pfx_pt_cmd_callback (drivers/dma/amd/ptdma/ptdma-dmaengine.c:249) ptdma 
[ 1037.821826] ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 1037.821831] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4470) 
[ 1037.821835] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 1037.821839] ? pt_issue_pending (drivers/dma/amd/ptdma/ptdma-dmaengine.c:386) ptdma 
[ 1037.821846] dmatest_func (./include/linux/dmaengine.h:1459 drivers/dma/dmatest.c:842) dmatest 
[ 1037.821862] ? __pfx___lock_acquired (kernel/locking/lockdep.c:6064) 
[ 1037.821868] ? __pfx_dmatest_func (drivers/dma/dmatest.c:575) dmatest 
[ 1037.821873] ? __pfx_do_raw_spin_trylock (kernel/locking/spinlock_debug.c:122) 
[ 1037.821879] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
[ 1037.821885] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:291) 
[ 1037.821889] ? __pfx_dmatest_func (drivers/dma/dmatest.c:575) dmatest 
[ 1037.821895] kthread (kernel/kthread.c:464) 
[ 1037.821898] ? __pfx_do_raw_spin_trylock (kernel/locking/spinlock_debug.c:122) 
[ 1037.821902] ? __pfx_kthread (kernel/kthread.c:413) 
[ 1037.821906] ? __pfx_kthread (kernel/kthread.c:413) 
[ 1037.821910] ret_from_fork (arch/x86/kernel/process.c:148) 
[ 1037.821915] ? __pfx_kthread (kernel/kthread.c:413) 
[ 1037.821918] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[ 1037.821928]  </TASK>

[ 1037.970456] Allocated by task 6481:
[ 1037.973948] kasan_save_stack (mm/kasan/common.c:48) 
[ 1037.977789] kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 1037.981626] __kasan_slab_alloc (mm/kasan/common.c:348) 
[ 1037.985639] kmem_cache_alloc_noprof (mm/slub.c:4115 mm/slub.c:4164 mm/slub.c:4171) 
[ 1037.990260] pt_alloc_dma_desc (drivers/dma/amd/ptdma/ptdma-dmaengine.c:285) ptdma 
[ 1037.994964] pt_prep_dma_memcpy (drivers/dma/amd/ptdma/ptdma-dmaengine.c:313 drivers/dma/amd/ptdma/ptdma-dmaengine.c:346) ptdma 
[ 1037.999757] dmatest_func (drivers/dma/dmatest.c:794) dmatest 
[ 1038.004463] kthread (kernel/kthread.c:464) 
[ 1038.007696] ret_from_fork (arch/x86/kernel/process.c:148) 
[ 1038.011275] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 

[ 1038.016701] Freed by task 0:
[ 1038.019586] kasan_save_stack (mm/kasan/common.c:48) 
[ 1038.023428] kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 1038.027265] kasan_save_free_info (mm/kasan/generic.c:579) 
[ 1038.031451] __kasan_slab_free (mm/kasan/common.c:271) 
[ 1038.035378] kmem_cache_free (mm/slub.c:4609 mm/slub.c:4711) 
[ 1038.039304] pt_handle_active_desc (drivers/dma/amd/ptdma/../../virt-dma.h:127 drivers/dma/amd/ptdma/ptdma-dmaengine.c:241) ptdma 
[ 1038.044444] pt_cmd_callback (drivers/dma/amd/ptdma/ptdma-dmaengine.c:266) ptdma 
[ 1038.048976] pt_core_irq_handler (drivers/dma/amd/ptdma/ptdma.h:337 drivers/dma/amd/ptdma/ptdma-dev.c:172) ptdma 
[ 1038.053768] __handle_irq_event_percpu (kernel/irq/handle.c:158) 
[ 1038.058562] handle_irq_event (kernel/irq/handle.c:195 kernel/irq/handle.c:210) 
[ 1038.062489] handle_edge_irq (kernel/irq/chip.c:833) 
[ 1038.066413] __common_interrupt (./include/linux/irqdesc.h:173 arch/x86/kernel/irq.c:249 arch/x86/kernel/irq.c:261 arch/x86/kernel/irq.c:287) 
[ 1038.070514] common_interrupt (arch/x86/kernel/irq.c:280 (discriminator 14)) 
[ 1038.074352] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:578) 

[ 1038.080038] The buggy address belongs to the object at ffff8881f9379440
which belongs to the cache 0000:02:00.2-dmaengine-desc-cache of size 320
[ 1038.094450] The buggy address is located 248 bytes inside of
freed 320-byte region [ffff8881f9379440, ffff8881f9379580)

[ 1038.108196] The buggy address belongs to the physical page:
[ 1038.113770] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881f9378640 pfn:0x1f9378
[ 1038.123069] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 1038.130720] flags: 0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
[ 1038.138634] page_type: f5(slab)
[ 1038.141782] raw: 0017ffffc0000240 ffff888178175540 ffff8881ff162390 ffff8881ff162390
[ 1038.149520] raw: ffff8881f9378640 0000000000200010 00000000f5000000 0000000000000000
[ 1038.157262] head: 0017ffffc0000240 ffff888178175540 ffff8881ff162390 ffff8881ff162390
[ 1038.165086] head: ffff8881f9378640 0000000000200010 00000000f5000000 0000000000000000
[ 1038.172911] head: 0017ffffc0000002 ffffea0007e4de01 ffffffffffffffff 0000000000000000
[ 1038.180737] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
[ 1038.188564] page dumped because: kasan: bad access detected
[ 1038.194137] page_owner tracks the page as allocated
[ 1038.199016] page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 6481, tgid 6481 (dma0chan0-copy0), ts 1037794454738, free_ts 94134554579
[ 1038.216723] post_alloc_hook (mm/page_alloc.c:1554) 
[ 1038.220561] get_page_from_freelist (mm/page_alloc.c:1561 mm/page_alloc.c:3477) 
[ 1038.225182] __alloc_frozen_pages_noprof (mm/page_alloc.c:4740) 
[ 1038.230146] alloc_pages_mpol (mm/mempolicy.c:2272) 
[ 1038.234159] allocate_slab (mm/slub.c:2423 mm/slub.c:2587) 
[ 1038.237911] ___slab_alloc (mm/slub.c:3827 (discriminator 3)) 
[ 1038.241752] __slab_alloc.constprop.0 (mm/slub.c:3916) 
[ 1038.246284] kmem_cache_alloc_noprof (mm/slub.c:3991 mm/slub.c:4152 mm/slub.c:4171) 
[ 1038.250903] pt_alloc_dma_desc (drivers/dma/amd/ptdma/ptdma-dmaengine.c:285) ptdma 
[ 1038.255611] pt_prep_dma_memcpy (drivers/dma/amd/ptdma/ptdma-dmaengine.c:313 drivers/dma/amd/ptdma/ptdma-dmaengine.c:346) ptdma 
[ 1038.260403] dmatest_func (drivers/dma/dmatest.c:794) dmatest 
[ 1038.265108] kthread (kernel/kthread.c:464) 
[ 1038.268343] ret_from_fork (arch/x86/kernel/process.c:148) 
[ 1038.271919] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[ 1038.275845] page last free pid 0 tgid 0 stack trace:
[ 1038.280812] free_frozen_pages (./include/linux/page_owner.h:25 mm/page_alloc.c:1127 mm/page_alloc.c:2660) 
[ 1038.284997] rcu_do_batch (kernel/rcu/tree.c:2546) 
[ 1038.288750] rcu_core (kernel/rcu/tree.c:2804) 
[ 1038.292069] handle_softirqs (kernel/softirq.c:561) 
[ 1038.295997] __irq_exit_rcu (kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662) 
[ 1038.299839] irq_exit_rcu (kernel/softirq.c:680) 
[ 1038.303253] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049) 
[ 1038.308052] asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:578) 

[ 1038.314692] Memory state around the buggy address:
[ 1038.319484]  ffff8881f9379400: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[ 1038.326706]  ffff8881f9379480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1038.333925] >ffff8881f9379500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1038.341142]                                         ^
[ 1038.346199]  ffff8881f9379580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1038.353426]  ffff8881f9379600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[ 1038.360652] ==================================================================
[ 1038.368003] Disabling lock debugging due to kernel taint
[ 1038.373470] dmatest: dma0chan0-copy0: verifying source buffer...
[ 1038.373570] dmatest: dma0chan0-copy0: verifying dest buffer...
[ 1038.373637] dmatest: dma0chan0-copy0: result #400: 'test passed' with src_off=0xf24 dst_off=0xaf0 len=0x1934 (0)

Many thanks for your time and help!

Eder

P.S., if SLAB_TYPESAFE_BY_RCU prevents the change of type for objects
allocated from a lookaside cache but the memory may be reallocated to a
completetly different object of the same type, wouldn't that allow for a
possible data leakage?


Eder Zulian (1):
  dmaengine: ptdma: use SLAB_TYPESAFE_BY_RCU for the DMA descriptor slab

 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.49.0


