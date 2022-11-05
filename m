Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9361D851
	for <lists+dmaengine@lfdr.de>; Sat,  5 Nov 2022 08:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKEHSs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Nov 2022 03:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEHSr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Nov 2022 03:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5110021A2;
        Sat,  5 Nov 2022 00:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D58BF609EB;
        Sat,  5 Nov 2022 07:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73411C433D7;
        Sat,  5 Nov 2022 07:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667632725;
        bh=jsb1lFeFER8A25qLYzfQv5p0MbZRvDWc2iO1rPeQNL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cslm9r/V5fu/IL7hWHjlwm9/Xc2HyzC02VI8gxE2+JkmIZLMW1ZwlnTKs0GXlwFMQ
         MNmLE0BaG5yoSQpc3vf3JTDZatphWUnUNdZzlmxB872yRT+NW3UqvR9F2hQIFbDP/3
         J4nwaC+s6pClUhOWzED2kt4kKMSLfnWNc1fM6HU/rGpAlUdUWSdJ3I2gAC0PeWILWm
         0rqSODq2Nfpt0OK2eBSXRVd1u2R6JdAo3R5auT0VKkx0kH4IHLsmI/5vhZz6xtxumH
         yBa8J6snRbJrNUO+jzpcG94e7y1lGZIT6g/U2xErFYhWU7DCmJ18b8gVXJlxdAKE6z
         brNKLMbSAlxHQ==
Date:   Sat, 5 Nov 2022 12:48:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Koba Ko <koba.ko@canonical.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Hai <haijie1@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V2] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <Y2YOUV0Ym+7DsWQb@matsya>
References: <20220930173652.1251349-1-koba.ko@canonical.com>
 <20221102180726.fuwwk2npsse56ius@cantor>
 <Y2USwbAzuaCKTGdX@matsya>
 <20221104153644.sz35cvgbhudr6ad7@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104153644.sz35cvgbhudr6ad7@cantor>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-11-22, 08:36, Jerry Snitselaar wrote:
> On Fri, Nov 04, 2022 at 06:55:21PM +0530, Vinod Koul wrote:
> > On 02-11-22, 11:07, Jerry Snitselaar wrote:
> > > Hi Vinod,
> > > 
> > > Thoughts on this patch?
> > > 
> > > Maybe changing the summary to "dmaengine: Fix double increment of client_count in dma_chan_get()"
> > > would be clearer?
> > 
> > Yes that would be better
> > 
> > > 
> > > On Sat, Oct 01, 2022 at 01:36:52AM +0800, Koba Ko wrote:
> > > > If the passed client_count is 0,
> > > > it would be incremented by balance_ref_count first
> > > > then increment one more.
> > > > This would cause client_count to 2.
> > > >
> > > > cat /sys/class/dma/dma0chan*/in_use
> > > > 2
> > > > 2
> > > > 2
> > > 
> > > Would this be better?
> > > 
> > >     The first time dma_chan_get() is called for a channel the channel
> > >     client_count is incorrectly incremented twice for public channels,
> > >     first in balance_ref_count(), and again prior to returning. This
> > >     results in an incorrect client count which will lead to the
> > >     channel resources not being freed when they should be. A simple
> > >     test of repeated module load and unload of async_tx on a Dell
> > >     Power Edge R7425 also shows this resulting in a kref underflow
> > >     warning.
> > 
> > Agree, also if you have the underflow warning handy, do add it to the
> > log
> > 
> 
> I don't know if Canonical saw that in their testing, but that was how our
> QE initially found the issue.
> 
> [  124.329662] async_tx: api initialized (async)
> [  129.000627] async_tx: api initialized (async)
> [  130.047839] ------------[ cut here ]------------
> [  130.052472] refcount_t: underflow; use-after-free.
> [  130.057279] WARNING: CPU: 3 PID: 19364 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
> [  130.065811] Modules linked in: async_tx(-) rfkill intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd ipmi_ssif kvm_amd dcdbas kvm mgag200 drm_shmem_helper acpi_ipmi irqbypass drm_kms_helper ipmi_si syscopyarea sysfillrect rapl pcspkr ipmi_devintf sysimgblt fb_sys_fops k10temp i2c_piix4 ipmi_msghandler acpi_power_meter acpi_cpufreq vfat fat drm fuse xfs libcrc32c sd_mod t10_pi sg ahci crct10dif_pclmul libahci crc32_pclmul crc32c_intel ghash_clmulni_intel igb megaraid_sas i40e libata i2c_algo_bit ccp sp5100_tco dca dm_mirror dm_region_hash dm_log dm_mod [last unloaded: async_tx]
> [  130.117361] CPU: 3 PID: 19364 Comm: modprobe Kdump: loaded Not tainted 5.14.0-185.el9.x86_64 #1
> [  130.126091] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.18.0 01/17/2022
> [  130.133806] RIP: 0010:refcount_warn_saturate+0xba/0x110
> [  130.139041] Code: 01 01 e8 6d bd 55 00 0f 0b e9 72 9d 8a 00 80 3d 26 18 9c 01 00 75 85 48 c7 c7 f8 a3 03 9d c6 05 16 18 9c 01 01 e8 4a bd 55 00 <0f> 0b e9 4f 9d 8a 00 80 3d 01 18 9c 01 00 0f 85 5e ff ff ff 48 c7
> [  130.157807] RSP: 0018:ffffbf98898afe68 EFLAGS: 00010286
> [  130.163036] RAX: 0000000000000000 RBX: ffff9da06028e598 RCX: 0000000000000000
> [  130.170172] RDX: ffff9daf9de26480 RSI: ffff9daf9de198a0 RDI: ffff9daf9de198a0
> [  130.177316] RBP: ffff9da7cddf3970 R08: 0000000000000000 R09: 00000000ffff7fff
> [  130.184459] R10: ffffbf98898afd00 R11: ffffffff9d9e8c28 R12: ffff9da7cddf1970
> [  130.191596] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  130.198739] FS:  00007f646435c740(0000) GS:ffff9daf9de00000(0000) knlGS:0000000000000000
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
> [  130.258830] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89 01 48
> [  130.277591] RSP: 002b:00007fff22f972c8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  130.285164] RAX: ffffffffffffffda RBX: 000055b6786edd40 RCX: 00007f6463a3f5ab
> [  130.292303] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b6786edda8
> [  130.299443] RBP: 000055b6786edd40 R08: 0000000000000000 R09: 0000000000000000
> [  130.306584] R10: 00007f6463b9eac0 R11: 0000000000000206 R12: 000055b6786edda8
> [  130.313731] R13: 0000000000000000 R14: 000055b6786edda8 R15: 00007fff22f995f8
> [  130.320875]  </TASK>
> [  130.323081] ---[ end trace eff7156d56b5cf25 ]---

This is good, give more details and should be added to log in next
iteration

-- 
~Vinod
