Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDB63E817
	for <lists+dmaengine@lfdr.de>; Thu,  1 Dec 2022 04:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiLADBC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 22:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLADBB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 22:01:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478DE7B4F6
        for <dmaengine@vger.kernel.org>; Wed, 30 Nov 2022 19:01:00 -0800 (PST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D2EE83F32E
        for <dmaengine@vger.kernel.org>; Thu,  1 Dec 2022 03:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669863657;
        bh=KBEEiz1TwZZ9uiWteaos76O1CPVzORDpb4GxX5fxihg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=JD1uVAIfn53tavL45PndwHV1zKJLU3qD2mycucPdmBncrpdilSydNo+Ni4/eHB7CZ
         j736dSidk3SHxv6rD5RUVebsh/gMMlnznRemnMj3uWXQT50fOzy6Qr8dqzWzwXC24l
         fHz19Iwfm6qr+xpfxahN7TqQUheaJqTAad2v7J/lFCoYrTjKpOtaHW4xoY6ySPFiZX
         cdiLvliUX8DYCSAM2zDIOkpCQ3BkxAQDNOa3Ap1KiAbCHBcwz4i4EkPq4DPW2LI/T/
         7RqRyci2z4ZYIrbxWARW/+VxJwZv2aPfqdx8kgUOM2+mISVGDd7stlULktz0MHYd9S
         WJja/tmfOc3AA==
Received: by mail-pj1-f71.google.com with SMTP id pi2-20020a17090b1e4200b0021834843687so4424157pjb.0
        for <dmaengine@vger.kernel.org>; Wed, 30 Nov 2022 19:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBEEiz1TwZZ9uiWteaos76O1CPVzORDpb4GxX5fxihg=;
        b=rQ8bfU4g+Sdmn93z/E7Embr8oQNF1C13NOrxPxj4ZkV23dqr6X2KE8pcStrouoC35V
         Fvz/19fRWhdEUo8iYYgKswIxIKwWtwAlyRYgShxwXqX+0qsVtKRtY69sjQcK4glvC0bI
         qZpM7dqKRmQq7VIgoaIUB56CBchPQxyNCJ56MPK5GHPNyNuItKu5IyIlBwTVByb4spKB
         piIDF4I4OqAM4p69a+uGIc8v4rbYEP79rYagJUZcM4t1Z9VS7IRP0Q2VyrXmoWL3GTKJ
         eSqlwW0YhmhgG/5dv5SFzqsUJ75hxZBe4OEPNLu8/GtCE+3CTX7eqBHeuiwyTdXtFN0B
         JYqQ==
X-Gm-Message-State: ANoB5pngx7e9w8zyyz+361DMphd/d5oi7KrHboRBECAxpbZJa/S9ezKX
        H7mztPRnp84ErrmqhOt2dHG7zIUnliwPfv5wepzX7pHxDEiq6n/S9Lsqv/nKAVKEiZUUy/HziJ7
        zRkI20v/CK9JM/UkoML94+i89pOcXmwJaENS3Bg==
X-Received: by 2002:a17:90b:3608:b0:219:6b1b:63d8 with SMTP id ml8-20020a17090b360800b002196b1b63d8mr4653610pjb.143.1669863653226;
        Wed, 30 Nov 2022 19:00:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5MbvCRZ/jl/yEErQVESS5W/MxdmKCHh4VnDUAEnypUj3sRGH1q8jjQVz/3/1Le8Lb8B4CjIQ==
X-Received: by 2002:a17:90b:3608:b0:219:6b1b:63d8 with SMTP id ml8-20020a17090b360800b002196b1b63d8mr4653570pjb.143.1669863652813;
        Wed, 30 Nov 2022 19:00:52 -0800 (PST)
Received: from canonical.com (2001-b011-300b-b863-5ce4-cae4-1ba7-6f5b.dynamic-ip6.hinet.net. [2001:b011:300b:b863:5ce4:cae4:1ba7:6f5b])
        by smtp.gmail.com with ESMTPSA id q19-20020aa79613000000b00562a526cd2esm2078337pfg.55.2022.11.30.19.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 19:00:52 -0800 (PST)
From:   Koba Ko <koba.ko@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jie Hai <haijie1@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH V3] dmaengine: Fix double increment of client_count in dma_chan_get()
Date:   Thu,  1 Dec 2022 11:00:50 +0800
Message-Id: <20221201030050.978595-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The first time dma_chan_get() is called for a channel the channel
client_count is incorrectly incremented twice for public channels,
first in balance_ref_count(), and again prior to returning. This
results in an incorrect client count which will lead to the
channel resources not being freed when they should be. A simple
 test of repeated module load and unload of async_tx on a Dell
 Power Edge R7425 also shows this resulting in a kref underflow
 warning.

[  124.329662] async_tx: api initialized (async)
[  129.000627] async_tx: api initialized (async)
[  130.047839] ------------[ cut here ]------------
[  130.052472] refcount_t: underflow; use-after-free.
[  130.057279] WARNING: CPU: 3 PID: 19364 at lib/refcount.c:28
refcount_warn_saturate+0xba/0x110
[  130.065811] Modules linked in: async_tx(-) rfkill intel_rapl_msr
intel_rapl_common amd64_edac edac_mce_amd ipmi_ssif kvm_amd dcdbas kvm
mgag200 drm_shmem_helper acpi_ipmi irqbypass drm_kms_helper ipmi_si
syscopyarea sysfillrect rapl pcspkr ipmi_devintf sysimgblt fb_sys_fops
k10temp i2c_piix4 ipmi_msghandler acpi_power_meter acpi_cpufreq vfat
fat drm fuse xfs libcrc32c sd_mod t10_pi sg ahci crct10dif_pclmul
libahci crc32_pclmul crc32c_intel ghash_clmulni_intel igb megaraid_sas
i40e libata i2c_algo_bit ccp sp5100_tco dca dm_mirror dm_region_hash
dm_log dm_mod [last unloaded: async_tx]
[  130.117361] CPU: 3 PID: 19364 Comm: modprobe Kdump: loaded Not
tainted 5.14.0-185.el9.x86_64 #1
[  130.126091] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS
1.18.0 01/17/2022
[  130.133806] RIP: 0010:refcount_warn_saturate+0xba/0x110
[  130.139041] Code: 01 01 e8 6d bd 55 00 0f 0b e9 72 9d 8a 00 80 3d
26 18 9c 01 00 75 85 48 c7 c7 f8 a3 03 9d c6 05 16 18 9c 01 01 e8 4a
bd 55 00 <0f> 0b e9 4f 9d 8a 00 80 3d 01 18 9c 01 00 0f 85 5e ff ff ff
48 c7
[  130.157807] RSP: 0018:ffffbf98898afe68 EFLAGS: 00010286
[  130.163036] RAX: 0000000000000000 RBX: ffff9da06028e598 RCX: 0000000000000000
[  130.170172] RDX: ffff9daf9de26480 RSI: ffff9daf9de198a0 RDI: ffff9daf9de198a0
[  130.177316] RBP: ffff9da7cddf3970 R08: 0000000000000000 R09: 00000000ffff7fff
[  130.184459] R10: ffffbf98898afd00 R11: ffffffff9d9e8c28 R12: ffff9da7cddf1970
[  130.191596] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  130.198739] FS:  00007f646435c740(0000) GS:ffff9daf9de00000(0000)
knlGS:0000000000000000
[  130.206832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  130.212586] CR2: 00007f6463b214f0 CR3: 00000008ab98c000 CR4: 00000000003506e0
[  130.219729] Call Trace:
[  130.222192]  <TASK>
[  130.224305]  dma_chan_put+0x10d/0x110
[  130.227988]  dmaengine_put+0x7a/0xa0
[  130.231575]  __do_sys_delete_module.constprop.0+0x178/0x280
[  130.237157]  ? syscall_trace_enter.constprop.0+0x145/0x1d0
[  130.242652]  do_syscall_64+0x5c/0x90
[  130.246240]  ? exc_page_fault+0x62/0x150
[  130.250178]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  130.255243] RIP: 0033:0x7f6463a3f5ab
[  130.258830] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89
01 48
[  130.277591] RSP: 002b:00007fff22f972c8 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  130.285164] RAX: ffffffffffffffda RBX: 000055b6786edd40 RCX: 00007f6463a3f5ab
[  130.292303] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b6786edda8
[  130.299443] RBP: 000055b6786edd40 R08: 0000000000000000 R09: 0000000000000000
[  130.306584] R10: 00007f6463b9eac0 R11: 0000000000000206 R12: 000055b6786edda8
[  130.313731] R13: 0000000000000000 R14: 000055b6786edda8 R15: 00007fff22f995f8
[  130.320875]  </TASK>
[  130.323081] ---[ end trace eff7156d56b5cf25 ]---

cat /sys/class/dma/dma0chan*/in_use would get the wrong result.
2
2
2

Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
Signed-off-by: Koba Ko <koba.ko@canonical.com>
Reviewed-by: Jie Hai <haijie1@huawei.com>
Test-by: Jie Hai <haijie1@huawei.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---
V2: Remove [3/3] on subject.
V3: Refine title and comments as per suggestions.
Ref: https://patchwork.kernel.org/project/linux-dmaengine/patch/20220930173652.1251349-1-koba.ko@canonical.com/
---
 drivers/dma/dmaengine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..78f8a9f3ad825 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
 	/* The channel is already in use, update client count */
 	if (chan->client_count) {
 		__module_get(owner);
-		goto out;
+		chan->client_count++;
+		return 0;
 	}
 
 	if (!try_module_get(owner))
@@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
 			goto err_out;
 	}
 
+	chan->client_count++;
+
 	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
 		balance_ref_count(chan);
 
-out:
-	chan->client_count++;
 	return 0;
 
 err_out:
-- 
2.25.1

