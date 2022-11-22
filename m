Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31DF634305
	for <lists+dmaengine@lfdr.de>; Tue, 22 Nov 2022 18:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKVRyK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Nov 2022 12:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiKVRxf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Nov 2022 12:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEFE8A146
        for <dmaengine@vger.kernel.org>; Tue, 22 Nov 2022 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669139242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUC0tREVUS1cM30PkPjVP+UgZd2rZto8hzH91Wqlnyw=;
        b=Va+uNC5lAPaVZ2wUKQ5UhawMEZXoY5pxCAqlBZS6ip8MsuOfAHPXnSzGPDzvmBHMndC7WH
        h+zsPBNf0ycdn7TdaFAdcHN+/YcHxRTGdblaXmQNqKryid4Lcw/I770sS0a6aZ3nSFWrWx
        Cxs3YZKPjPXZJd5bBMuD+8zOJZ9bPNc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-iqwGyXjEP76BJjj1vcC0aA-1; Tue, 22 Nov 2022 12:47:16 -0500
X-MC-Unique: iqwGyXjEP76BJjj1vcC0aA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A62E185A79C;
        Tue, 22 Nov 2022 17:47:16 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.32.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37E0A2024CBE;
        Tue, 22 Nov 2022 17:47:14 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     koba.ko@canonical.com
Cc:     Vinod Koul <vkoul@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jie Hai <haijie1@huawei.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V2] dmaengine: Fix client_count is countered one more incorrectly.
Date:   Tue, 22 Nov 2022 13:46:49 -0400
Message-Id: <20221122174649.157811-1-jsavitz@redhat.com>
In-Reply-To: CAJB-X+Wi8sgU6=0iynTCgDzjXetVSjv_599p5ur7NAw9jBB=+g@mail.gmail.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> I would like to send v3.
> Because the comments provided by Jerry are more detail, i would like
> replace the original with his comments.
> 
> Here's draft,
> 
> dmaengine: Fix double increment of client_count in dma_chan_get()
> 
> The first time dma_chan_get() is called for a channel the channel
> client_count is incorrectly incremented twice for public channels,
> first in balance_ref_count(), and again prior to returning. This
> results in an incorrect client count which will lead to the
> channel resources not being freed when they should be. A simple
> test of repeated module load and unload of async_tx on a Dell
> Power Edge R7425 also shows this resulting in a kref underflow
> warning.
> 
> [  124.329662] async_tx: api initialized (async)
> [  129.000627] async_tx: api initialized (async)
> [  130.047839] ------------[ cut here ]------------
> [  130.052472] refcount_t: underflow; use-after-free.
> [  130.057279] WARNING: CPU: 3 PID: 19364 at lib/refcount.c:28
> refcount_warn_saturate+0xba/0x110
> [  130.065811] Modules linked in: async_tx(-) rfkill intel_rapl_msr
> intel_rapl_common amd64_edac edac_mce_amd ipmi_ssif kvm_amd dcdbas kvm
> mgag200 drm_shmem_helper acpi_ipmi irqbypass drm_kms_helper ipmi_si
> syscopyarea sysfillrect rapl pcspkr ipmi_devintf sysimgblt fb_sys_fops
> k10temp i2c_piix4 ipmi_msghandler acpi_power_meter acpi_cpufreq vfat
> fat drm fuse xfs libcrc32c sd_mod t10_pi sg ahci crct10dif_pclmul
> libahci crc32_pclmul crc32c_intel ghash_clmulni_intel igb megaraid_sas
> i40e libata i2c_algo_bit ccp sp5100_tco dca dm_mirror dm_region_hash
> dm_log dm_mod [last unloaded: async_tx]
> [  130.117361] CPU: 3 PID: 19364 Comm: modprobe Kdump: loaded Not
> tainted 5.14.0-185.el9.x86_64 #1
> [  130.126091] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS
> 1.18.0 01/17/2022
> [  130.133806] RIP: 0010:refcount_warn_saturate+0xba/0x110
> [  130.139041] Code: 01 01 e8 6d bd 55 00 0f 0b e9 72 9d 8a 00 80 3d
> 26 18 9c 01 00 75 85 48 c7 c7 f8 a3 03 9d c6 05 16 18 9c 01 01 e8 4a
> bd 55 00 <0f> 0b e9 4f 9d 8a 00 80 3d 01 18 9c 01 00 0f 85 5e ff ff ff
> 48 c7
> [  130.157807] RSP: 0018:ffffbf98898afe68 EFLAGS: 00010286
> [  130.163036] RAX: 0000000000000000 RBX: ffff9da06028e598 RCX: 0000000000000000
> [  130.170172] RDX: ffff9daf9de26480 RSI: ffff9daf9de198a0 RDI: ffff9daf9de198a0
> [  130.177316] RBP: ffff9da7cddf3970 R08: 0000000000000000 R09: 00000000ffff7fff
> [  130.184459] R10: ffffbf98898afd00 R11: ffffffff9d9e8c28 R12: ffff9da7cddf1970
> [  130.191596] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  130.198739] FS:  00007f646435c740(0000) GS:ffff9daf9de00000(0000)
> knlGS:0000000000000000
> [  130.206832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  130.212586] CR2: 00007f6463b214f0 CR3: 00000008ab98c000 CR4: 00000000003506e0
> [  130.219729] Call Trace:
> [  130.222192]  <TASK>
> [  130.224305]  dma_chan_put+0x10d/0x110
> [  130.227988]  dmaengine_put+0x7a/0xa0
> [  130.231575]  __do_sys_delete_module.constprop.0+0x178/0x280
> [  130.237157]  ? syscall_trace_enter.constprop.0+0x145/0x1d0
> [  130.242652]  do_syscall_64+0x5c/0x90
> [  130.246240]  ? exc_page_fault+0x62/0x150
> [  130.250178]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  130.255243] RIP: 0033:0x7f6463a3f5ab
> [  130.258830] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48
> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89
> 01 48
> [  130.277591] RSP: 002b:00007fff22f972c8 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [  130.285164] RAX: ffffffffffffffda RBX: 000055b6786edd40 RCX: 00007f6463a3f5ab
> [  130.292303] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b6786edda8
> [  130.299443] RBP: 000055b6786edd40 R08: 0000000000000000 R09: 0000000000000000
> [  130.306584] R10: 00007f6463b9eac0 R11: 0000000000000206 R12: 000055b6786edda8
> [  130.313731] R13: 0000000000000000 R14: 000055b6786edda8 R15: 00007fff22f995f8
> [  130.320875]  </TASK>
> [  130.323081] ---[ end trace eff7156d56b5cf25 ]---
> 
> cat /sys/class/dma/dma0chan*/in_use would get the wrong result.
> 2
> 2
> 2

Looks good to me.

