Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A200553401
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiFUNvf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 09:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiFUNve (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 09:51:34 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 06:51:33 PDT
Received: from smtp71.ord1c.emailsrvr.com (smtp71.ord1c.emailsrvr.com [108.166.43.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38327661
        for <dmaengine@vger.kernel.org>; Tue, 21 Jun 2022 06:51:33 -0700 (PDT)
X-Auth-ID: markh@compro.net
Received: by smtp9.relay.ord1c.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id 18997201D6;
        Tue, 21 Jun 2022 09:43:19 -0400 (EDT)
Message-ID: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
Date:   Tue, 21 Jun 2022 09:43:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Mark Hounschell <markh@compro.net>
Subject: [BUG] dma-mapping: remove CONFIG_DMA_REMAP
Reply-To: markh@compro.net
To:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Language: en-US
Organization: Compro Computer Svcs.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 8581c692-229f-467c-b166-6ab7a3e01d43-1-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

commit f5ff79fddf0efecca538046b5cc20fb3ded2ec4f
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Feb 26 16:40:21 2022 +0100

     dma-mapping: remove CONFIG_DMA_REMAP

causes user land applications doing DMA to and from a pci card to cause 
kernel Oops below. I have 2 different types of pci cards that use the 
kernel dma_alloc_coherent to get DMA memory this fails on.

2022-06-07T14:01:34.109721-04:00 harley kernel: [ 1570.232238][ T4301] 
prmdiag: Corrupted page table at address 7fb71872a000
2022-06-07T14:01:34.109732-04:00 harley kernel: [ 1570.232247][ T4301] 
PGD 212e99067 P4D 212e99067 PUD 18bf6b067 PMD 1e373f067 PTE 80001fa406411235
2022-06-07T14:01:34.109733-04:00 harley kernel: [ 1570.232252][ T4301] 
Bad pagetable: 000d [#1] PREEMPT SMP NOPTI
2022-06-07T14:01:34.109734-04:00 harley kernel: [ 1570.232256][ T4301] 
CPU: 7 PID: 4301 Comm: prmdiag Tainted: G        WC O      5.18.1 #3
2022-06-07T14:01:34.109736-04:00 harley kernel: [ 1570.232260][ T4301] 
Hardware name: BIOSTAR Group B550GTA/B550GTA, BIOS 5.17 12/03/2021
2022-06-07T14:01:34.109736-04:00 harley kernel: [ 1570.232262][ T4301] 
RIP: 0033:0x7fb717180e8f
2022-06-07T14:01:34.109737-04:00 harley kernel: [ 1570.232267][ T4301] 
Code: 16 c0 c5 fe 7f 07 c5 fe 7f 4f 20 c5 fe 7f 54 17 e0 c5 fe 7f 5c 17 
c0 c5 f8 77 c3 48 39 f7 0f 87 ab 00 00 00 0f 84 e2 fe ff ff <c5> fe 6f 
26 c5 fe 6f 6c 16 e0 c5 fe 6f 74 16 c0 c5 fe 6f 7c 16 a0
2022-06-07T14:01:34.109746-04:00 harley kernel: [ 1570.232272][ T4301] 
RSP: 002b:00007ffd3ae7a328 EFLAGS: 00010283
2022-06-07T14:01:34.109746-04:00 harley kernel: [ 1570.232275][ T4301] 
RAX: 00007fb70f3ff010 RBX: 00000000fabe65e4 RCX: 00007fb71872a000
2022-06-07T14:01:34.109747-04:00 harley kernel: [ 1570.232278][ T4301] 
RDX: 0000000000100000 RSI: 00007fb71872a000 RDI: 00007fb70f3ff010
2022-06-07T14:01:34.109748-04:00 harley kernel: [ 1570.232281][ T4301] 
RBP: 00007ffd3ae7a360 R08: 00000000000000fe R09: 00000000000000fd
2022-06-07T14:01:34.109749-04:00 harley kernel: [ 1570.232283][ T4301] 
R10: 00000000000000ff R11: 0000000000000246 R12: 00007fb717cec210
2022-06-07T14:01:34.109749-04:00 harley kernel: [ 1570.232286][ T4301] 
R13: 00007ffd3ae7adf0 R14: 0000000000ab8b80 R15: 0000000000abe798
2022-06-07T14:01:34.109750-04:00 harley kernel: [ 1570.232289][ T4301] 
FS:  00007fb718831780 GS:  0000000000000000
2022-06-07T14:01:34.109751-04:00 harley kernel: [ 1570.232291][ T4301] 
Modules linked in: eprm(O) af_packet iscsi_ibft iscsi_boot_sysfs rfkill 
dmi_sysfs intel_rapl_msr intel_rapl_common ppdev kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel joydev aesni_intel 
crypto_simd cryptd wmi_bmof pcspkr sp5100_tco k10temp perle_serial(O) 
dgap(C) r8169 i2c_piix4 ccp realtek mdio_devres 3c59x synclink_gt 
parport_pc libphy hdlc parport mii thermal gpio_amdpt gpio_generic 
tiny_power_button fuse configfs snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio hid_generic usbhid nouveau video 
drm_ttm_helper ttm i2c_algo_bit mxm_wmi drm_dp_helper drm_kms_helper 
syscopyarea sysfillrect sysimgblt fb_sys_fops crc32c_intel drm serio_raw 
aic7xxx scsi_transport_spi xhci_pci sr_mod xhci_pci_renesas cdrom 
xhci_hcd usbcore usb_common wmi pinctrl_amd button snd_hda_intel 
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hwdep snd_hda_core 
snd_pcm snd_timer snd soundcore sg dm_multipath dm_mod scsi_dh_rdac 
scsi_dh_emc scsi_dh_alua msr
2022-06-07T14:01:34.109751-04:00 harley kernel: [ 1570.232347][ T4301] 
---[ end trace 0000000000000000 ]---
2022-06-07T14:01:34.109752-04:00 harley kernel: [ 1570.232350][ T4301] 
RIP: 0033:0x7fb717180e8f
2022-06-07T14:01:34.109753-04:00 harley kernel: [ 1570.232352][ T4301] 
RSP: 002b:00007ffd3ae7a328 EFLAGS: 00010283
2022-06-07T14:01:34.109753-04:00 harley kernel: [ 1570.232355][ T4301] 
RAX: 00007fb70f3ff010 RBX: 00000000fabe65e4 RCX: 00007fb71872a000
2022-06-07T14:01:34.109754-04:00 harley kernel: [ 1570.232357][ T4301] 
RDX: 0000000000100000 RSI: 00007fb71872a000 RDI: 00007fb70f3ff010
2022-06-07T14:01:34.109755-04:00 harley kernel: [ 1570.232360][ T4301] 
RBP: 00007ffd3ae7a360 R08: 00000000000000fe R09: 00000000000000fd
2022-06-07T14:01:34.109756-04:00 harley kernel: [ 1570.232362][ T4301] 
R10: 00000000000000ff R11: 0000000000000246 R12: 00007fb717cec210
2022-06-07T14:01:34.109756-04:00 harley kernel: [ 1570.232365][ T4301] 
R13: 00007ffd3ae7adf0 R14: 0000000000ab8b80 R15: 0000000000abe798
2022-06-07T14:01:34.109757-04:00 harley kernel: [ 1570.232367][ T4301] 
FS:  00007fb718831780(0000) GS:ffff96d87ebc0000(0000) knlGS:0000000000000000
2022-06-07T14:01:34.109757-04:00 harley kernel: [ 1570.232370][ T4301] 
CS:  0033 DS: 0000 ES: 0000 CR0: 0000000080050033
2022-06-07T14:01:34.109758-04:00 harley kernel: [ 1570.232373][ T4301] 
CR2: 00007fb71872a000 CR3: 00000001e36e2000 CR4: 0000000000350ee0

Revert that commit and all works like normal. This commit breaks user land.

Regards
Mark
