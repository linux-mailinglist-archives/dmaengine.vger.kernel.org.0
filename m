Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8565BC0E
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjACITs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 03:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbjACITq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 03:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94861DF7B
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 00:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672733939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFAbBCJeww11W0L1auwTuI53DEHjJAchS/0bFQT4L0M=;
        b=KhQLr4QyC9TxyzWCSYOJzdJaliPmBnPehwpJ0S6aYPoI1Ma7Z2BcY5LOd1I4T8wNTNpppr
        Fq8h9RcG2ljMI6vO0nBykw7esxIAK5p+tF+PW0nrjosxU3rjhC/AhEu+opm38WDWAtoBg8
        C7cmBSn8oqVoUMybhBxXydVwLxlugDo=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-112-g6R_IRDIMGydvjWzGzRNIg-1; Tue, 03 Jan 2023 03:18:58 -0500
X-MC-Unique: g6R_IRDIMGydvjWzGzRNIg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-144870e8fe8so13054854fac.13
        for <dmaengine@vger.kernel.org>; Tue, 03 Jan 2023 00:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFAbBCJeww11W0L1auwTuI53DEHjJAchS/0bFQT4L0M=;
        b=br+NPmekEu2ybZBO2CZpB5+bWV5e3YWeE7if/amjdXPdXP7ms+t5/7Acyv7/JTtqoJ
         p7ibIaadXyPHae6ahZCfHjOxUjNT2JIyDkSn9dWovoPVPY5uQSjo/6ye+B5UhihehX37
         MvKpMkuaKpLp5JxE7xqvQxIjzH2GpDfXGDwEZmgbLDTc+M0ea3850RBpkawYMePdORfi
         gxoI4dKCKI2CimL/gXgMw98O39Qd/79M4DZlILFUsuqRDbiGeXFfCR3mfPYBD4Fsc0IM
         I85D508sa3r4v9VcVLPhuQJc8IFqQISP+5tPg72rcRGa+D1HKqi9530yQV1Sk+MEtd4D
         RJBA==
X-Gm-Message-State: AFqh2kqRWjBHVmIj5DD7fVXmo34kcITrxvqN2C7w/fXkoYQ67GQ9uc0j
        mtJC57yvbJHT91LRWvzeVGuV3VmbahtVR94DsafPXXRzjUysIw3QJmzu9HYL9lw/XkPlkTtRbUC
        syGC3ybJOzyfvkT7+z6633pZlJ1QDnLwIxfSK
X-Received: by 2002:a05:6808:1308:b0:35a:9331:8cbb with SMTP id y8-20020a056808130800b0035a93318cbbmr3082768oiv.201.1672733937142;
        Tue, 03 Jan 2023 00:18:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXshsVTw3XWKQfO7iYXsrZfi+bMC8r+qmFqrOOA2ZwLot7LV7UbzqH4Ef7T8uvkDuBhK7y9LABVYrbRa84T6gtA=
X-Received: by 2002:a05:6808:1308:b0:35a:9331:8cbb with SMTP id
 y8-20020a056808130800b0035a93318cbbmr3082763oiv.201.1672733936867; Tue, 03
 Jan 2023 00:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20221201030050.978595-1-koba.ko@canonical.com>
In-Reply-To: <20221201030050.978595-1-koba.ko@canonical.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 3 Jan 2023 10:18:40 +0200
Message-ID: <CAL1p7m7FrQsysFq67NkZ_v1hRg8NuyHgyicBm5dp10VxMN98Aw@mail.gmail.com>
Subject: Re: [PATCH V3] dmaengine: Fix double increment of client_count in dma_chan_get()
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jie Hai <haijie1@huawei.com>, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod, are there any issues with this patch? It looks good to me.

Best,
Joel Savitz

On Thu, Dec 1, 2022 at 5:01 AM Koba Ko <koba.ko@canonical.com> wrote:
>
> The first time dma_chan_get() is called for a channel the channel
> client_count is incorrectly incremented twice for public channels,
> first in balance_ref_count(), and again prior to returning. This
> results in an incorrect client count which will lead to the
> channel resources not being freed when they should be. A simple
>  test of repeated module load and unload of async_tx on a Dell
>  Power Edge R7425 also shows this resulting in a kref underflow
>  warning.
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
>
> Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> Reviewed-by: Jie Hai <haijie1@huawei.com>
> Test-by: Jie Hai <haijie1@huawei.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
> ---
> V2: Remove [3/3] on subject.
> V3: Refine title and comments as per suggestions.
> Ref: https://patchwork.kernel.org/project/linux-dmaengine/patch/20220930173652.1251349-1-koba.ko@canonical.com/
> ---
>  drivers/dma/dmaengine.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2cfa8458b51be..78f8a9f3ad825 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
>         /* The channel is already in use, update client count */
>         if (chan->client_count) {
>                 __module_get(owner);
> -               goto out;
> +               chan->client_count++;
> +               return 0;
>         }
>
>         if (!try_module_get(owner))
> @@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
>                         goto err_out;
>         }
>
> +       chan->client_count++;
> +
>         if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
>                 balance_ref_count(chan);
>
> -out:
> -       chan->client_count++;
>         return 0;
>
>  err_out:
> --
> 2.25.1
>

