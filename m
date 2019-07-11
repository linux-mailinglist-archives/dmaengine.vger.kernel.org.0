Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76A655E5
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2019 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfGKLrJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jul 2019 07:47:09 -0400
Received: from mail.tintel.eu ([54.36.12.13]:37610 "EHLO mail.tintel.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfGKLrJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 11 Jul 2019 07:47:09 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 07:46:57 EDT
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id BF4FD42341B3;
        Thu, 11 Jul 2019 13:40:53 +0200 (CEST)
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CkthbVVWLqcO; Thu, 11 Jul 2019 13:40:49 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id A29A942341A2;
        Thu, 11 Jul 2019 13:40:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu A29A942341A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
        s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1562845248;
        bh=NVrY+Zg4mYJb8Dm0rbDQdCIPsHDmpLL5utp9DlVyN7Y=;
        h=From:To:Message-ID:Date:MIME-Version;
        b=YJNB/++5Z2a7cYCaRMQGx6m+uMJuMUAJ2VviTtBWh0BeAQBs0lzoxcRbYjCmMqrhK
         eSR7i+s4VT8zRdh7YFNSYFSwxZDuNvJq7xoaqeFQ5IImpfs31ZCVO/XamTorXD0VKs
         JihzEQaLMfdCoQpsu4PHLWgBHB8+Dwae2TBFfLXQ=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id rfHVZ3-iEQdl; Thu, 11 Jul 2019 13:40:48 +0200 (CEST)
Received: from sylvester.nomad.adlevio.net (unknown [212.3.228.181])
        (Authenticated sender: stijn@tintel.eu)
        by mail.tintel.eu (Postfix) with ESMTPSA id C55BF423414D;
        Thu, 11 Jul 2019 13:40:47 +0200 (CEST)
From:   Stijn Tintel <stijn@linux-ipv6.be>
Subject: [BUG] linux-5.2.0: various messages and traces related to dw-dma /
 sst-acpi
To:     Viresh Kumar <vireshk@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <e4162892-6544-1759-337a-68f4945276b6@linux-ipv6.be>
Date:   Thu, 11 Jul 2019 13:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

When booting 5.2.0 on my Dell XPS13 9343, I'm seeing various messages=20
and traces related to the DesignWare DMA Controller / Intel SST loader.=20
They seem to differ across different boots:

Boot #1:

jul 08 17:40:05 sylvesterg kernel: sst-acpi INT3438:00: DesignWare DMA=20
Controller, 8 channels
jul 08 17:40:05 sylvesterg kernel: sst-acpi INT3438:00: DMAR: 32bit DMA=20
uses non-identity mapping
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Not tainted 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
000000000000030d R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26a6384e20 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae944fc ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
0000000000000345 R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26a6384e20 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae944fd ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
000000000000037d R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa176010 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae944fe ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
00000000000003b5 R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa176010 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae944ff ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
00000000000003ed R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007fbfb014b681 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94500 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
0000000000000425 R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007fbfb014b681 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94501 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
000000000000045d R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa326ba0 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94502 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
0000000000000495 R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa326ba0 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94503 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
00000000000004cd R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa2fa6e0 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94504 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
0000000000000505 R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa2fa6e0 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94505 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
000000000000053d R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa3e3e88 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94506 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0000:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
0000000000000575 R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26aa3e3e88 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94507 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: list_add corruption. prev->next=20
should be next (ffff8881b4a5c0a8), but was 0000000000000000.=20
(prev=3Dffff8881b682b020).
jul 08 17:40:05 sylvesterg kernel: WARNING: CPU: 3 PID: 1920 at=20
lib/list_debug.c:28 __list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP: 0010:__list_add_valid+0x5f/0x80
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c2 4c 89 e6 48 c7 c7 08=20
b5 08 82 e8 23 92 c1 ff 0f 0b 31 c0 eb e0 48 89 c1 48 89 de 48 c7 c7 58=20
b5 08 82 e8 0b 92 c1 ff <0f> 0b 31 c0 eb c8 48 89 d9 4c 89 e2 48 89 ee=20
48 c7 c7 a8 b5 08 82
jul 08 17:40:05 sylvesterg kernel: RSP: 0018:ffffc900008678a8 EFLAGS:=20
00010086
jul 08 17:40:05 sylvesterg kernel: RAX: 0000000000000000 RBX:=20
ffff8881b4a5c0a8 RCX: 0000000000000006
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000007 RSI:=20
0000000000000096 RDI: ffff888217396510
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b682b020 R08:=20
00000000000005ad R09: 0000000000000084
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881b682b020 R14:=20
ffff8881b4a5c088 R15: ffff8881b682b020
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26a8b43058 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dwc_tx_submit+0x6c/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x6d/0x80=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94508 ]---
jul 08 17:40:05 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 17:40:05 sylvesterg kernel: ------------[ cut here ]------------
jul 08 17:40:05 sylvesterg kernel: kernel BUG at drivers/dma/dw/core.c:10=
26!
jul 08 17:40:05 sylvesterg kernel: invalid opcode: 0000 [#1] SMP PTI
jul 08 17:40:05 sylvesterg kernel: CPU: 3 PID: 1920 Comm: systemd-udevd=20
Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-gentoo #1
jul 08 17:40:05 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 17:40:05 sylvesterg kernel: RIP:=20
0010:dwc_free_chan_resources+0xe3/0xf0
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c6 4c 89 e7 e8 4c 0d 41=20
00 0f b6 43 60 f7 d0 20 85 81 01 00 00 74 05 5b 5d 41 5c c3 5b 48 89 ef=20
5d 41 5c e9 3d fe ff ff <0f> 0b 0f 0b 0f 0b 0f 1f 80 00 00 00 00 0f 1f=20
44 00 00 53 48 89 fb
jul 08 17:40:05 sylvesterg kernel: RSP: 0018:ffffc900008679b8 EFLAGS:=20
00010287
jul 08 17:40:05 sylvesterg kernel: RAX: ffff8881b682b020 RBX:=20
ffff8881b4a5c018 RCX: 0000000000000003
jul 08 17:40:05 sylvesterg kernel: RDX: ffff8881b4a5c098 RSI:=20
0000000000000001 RDI: ffff8881b4a5c018
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b716bc18 R08:=20
ffff888216003380 R09: ffff8881bda953c0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b5786298
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881bdab0018 R14:=20
ffffffffa0cad6ad R15: ffff8881bdab0018
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26a8b43058 CR3:=20
00000001bf67c004 CR4: 00000000003606e0
jul 08 17:40:05 sylvesterg kernel: Call Trace:
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dma_chan_put+0x6d/0xa0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 dma_release_channel+0x25/0x70
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_fw_new+0xd0/0x180=20
[snd_soc_sst_firmware]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 17:40:05 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 17:40:05 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 17:40:05 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 17:40:05 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 17:40:05 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 17:40:05 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 17:40:05 sylvesterg kernel: RIP: 0033:0x7fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 17:40:05 sylvesterg kernel: RSP: 002b:00007fffcaa7a608 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 17:40:05 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
00005649adc19800 RCX: 00007fbfb00cec89
jul 08 17:40:05 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fbfb0a29b8d RDI: 0000000000000011
jul 08 17:40:05 sylvesterg kernel: RBP: 00007fbfb0a29b8d R08:=20
0000000000000000 R09: 00005649adbfb1f0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 17:40:05 sylvesterg kernel: R13: 00005649adc30170 R14:=20
0000000000020000 R15: 00005649adc19800
jul 08 17:40:05 sylvesterg kernel: Modules linked in: mei_hdcp iTCO_wdt=20
wmi_bmof dell_wmi snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal=20
intel_powerclamp dell_laptop ledtrig_audio kvm_intel dell_smbios=20
crct10dif_pclmul joydev mousedev crc32_pclmul crc32c_intel=20
ghash_clmulni_intel dell_wmi_descriptor dcdbas btusb btintel aesni_intel=20
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf efi_pstore=20
hid_multitouch efivars arc4 bluetooth iwlmvm ecdh_generic mac80211 ecc=20
snd_hda_codec_hdmi intel_pch_thermal iwlwifi i2c_i801 snd_hda_intel=20
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 snd_hda_codec cfg80211=20
nf_tables_set rtsx_pci snd_hwdep mei_me processor_thermal_device=20
intel_soc_dts_iosf nf_tables lpc_ich mei rfkill nfnetlink mfd_core=20
snd_hda_core wmi battery int3403_thermal snd_soc_rt286 snd_soc_rl6347a=20
snd_soc_core ac97_bus snd_pcm snd_timer snd i2c_hid soundcore tpm_crb(+)=20
tpm_tis tpm_tis_core snd_soc_sst_acpi snd_soc_acpi_intel_match tpm=20
snd_soc_acpi
jul 08 17:40:05 sylvesterg kernel:=C2=A0 int3402_thermal rng_core intel_h=
id=20
int3400_thermal i2c_designware_platform i2c_designware_core=20
acpi_thermal_rel int340x_thermal_zone evdev ac acpi_pad lz4 lz4_compress=20
sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd auth_rpcgss=20
nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic iscsi_tcp=20
libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan ip6_udp_tunnel=20
udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc fscache ext4=20
mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log hid_sony=20
hid_microsoft ff_memless hid_logitech hid_gyration hid_generic usbhid=20
usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm irqbypass xhci_pci=20
xhci_hcd usbcore usb_common sparse_keymap
jul 08 17:40:05 sylvesterg kernel: ---[ end trace 2b0e8ca86ae94509 ]---
jul 08 17:40:05 sylvesterg kernel: RIP:=20
0010:dwc_free_chan_resources+0xe3/0xf0
jul 08 17:40:05 sylvesterg kernel: Code: 48 89 c6 4c 89 e7 e8 4c 0d 41=20
00 0f b6 43 60 f7 d0 20 85 81 01 00 00 74 05 5b 5d 41 5c c3 5b 48 89 ef=20
5d 41 5c e9 3d fe ff ff <0f> 0b 0f 0b 0f 0b 0f 1f 80 00 00 00 00 0f 1f=20
44 00 00 53 48 89 fb
jul 08 17:40:05 sylvesterg kernel: RSP: 0018:ffffc900008679b8 EFLAGS:=20
00010287
jul 08 17:40:05 sylvesterg kernel: RAX: ffff8881b682b020 RBX:=20
ffff8881b4a5c018 RCX: 0000000000000003
jul 08 17:40:05 sylvesterg kernel: RDX: ffff8881b4a5c098 RSI:=20
0000000000000001 RDI: ffff8881b4a5c018
jul 08 17:40:05 sylvesterg kernel: RBP: ffff8881b716bc18 R08:=20
ffff888216003380 R09: ffff8881bda953c0
jul 08 17:40:05 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: ffff8881b5786298
jul 08 17:40:05 sylvesterg kernel: R13: ffff8881bdab0018 R14:=20
ffffffffa0cad6ad R15: ffff8881bdab0018
jul 08 17:40:05 sylvesterg kernel: FS:=C2=A0 00007fbfb1283840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 17:40:05 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 17:40:05 sylvesterg kernel: CR2: 00007f26a8b43058 CR3:=20
00000001bf67c004 CR4: 00000000003606e0


Boot #2:

jul 08 19:37:04 sylvesterg kernel: sst-acpi INT3438:00: DesignWare DMA=20
Controller, 8 channels
jul 08 19:37:04 sylvesterg kernel: sst-acpi INT3438:00: DMAR: 32bit DMA=20
uses non-identity mapping
jul 08 19:37:04 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 19:37:04 sylvesterg kernel: BUG: unable to handle page fault for=20
address: 00000ffeffffffe8
jul 08 19:37:04 sylvesterg kernel: #PF: supervisor read access in kernel=20
mode
jul 08 19:37:04 sylvesterg kernel: #PF: error_code(0x0000) - not-present=20
page
jul 08 19:37:04 sylvesterg kernel: PGD 0 P4D 0
jul 08 19:37:04 sylvesterg kernel: Oops: 0000 [#1] SMP PTI
jul 08 19:37:04 sylvesterg kernel: CPU: 3 PID: 1894 Comm: systemd-udevd=20
Not tainted 5.2.0-gentoo #1
jul 08 19:37:04 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 19:37:04 sylvesterg kernel: RIP:=20
0010:dwc_scan_descriptors+0x1a9/0x400
jul 08 19:37:04 sylvesterg kernel: Code: 8d 70 e0 48 39 c7 75 22 e9 73=20
01 00 00 2b 96 88 00 00 00 89 95 98 00 00 00 48 8b 46 20 48 8d 70 e0 48=20
39 c7 0f 84 56 01 00 00 <8b> 40 e8 49 39 c4 75 db 48 8b 03 48 8b 53 58=20
48 89 0c 24 8b 72 1c
jul 08 19:37:04 sylvesterg kernel: RSP: 0018:ffffc9000042b848 EFLAGS:=20
00010086
jul 08 19:37:04 sylvesterg kernel: RAX: 00000fff00000000 RBX:=20
ffff8881b99fd018 RCX: 0000000000000286
jul 08 19:37:04 sylvesterg kernel: RDX: 00000000465e33e9 RSI:=20
00000ffeffffffe0 RDI: ffff8881b99fd0b8
jul 08 19:37:04 sylvesterg kernel: RBP: ffff8881b99fd088 R08:=20
ffff8881b99fd098 R09: 0000000000a2090c
jul 08 19:37:04 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: 0000000000a2090c
jul 08 19:37:04 sylvesterg kernel: R13: ffff8881b99fd088 R14:=20
ffff8881c1da9000 R15: ffff8881b9a1cc18
jul 08 19:37:04 sylvesterg kernel: FS:=C2=A0 00007f671bb82840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 19:37:04 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 19:37:04 sylvesterg kernel: CR2: 00000ffeffffffe8 CR3:=20
00000001c4168001 CR4: 00000000003606e0
jul 08 19:37:04 sylvesterg kernel: Call Trace:
jul 08 19:37:04 sylvesterg kernel:=C2=A0 ? dwc_desc_get+0x64/0xa0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 dwc_tx_status+0x5f/0x180
jul 08 19:37:04 sylvesterg kernel:=C2=A0 dma_sync_wait+0x83/0xc0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x75/0x80=20
[snd_soc_sst_firmware]
jul 08 19:37:04 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 19:37:04 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 19:37:04 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 19:37:04 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 19:37:04 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 19:37:04 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 19:37:04 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 19:37:04 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 19:37:04 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 19:37:04 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 19:37:04 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 19:37:04 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 19:37:04 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 19:37:04 sylvesterg kernel: RIP: 0033:0x7f671a9cdc89
jul 08 19:37:04 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 19:37:04 sylvesterg kernel: RSP: 002b:00007ffc43d00c38 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 19:37:04 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
0000563f7b47f2c0 RCX: 00007f671a9cdc89
jul 08 19:37:04 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007f671b328b8d RDI: 0000000000000011
jul 08 19:37:04 sylvesterg kernel: RBP: 00007f671b328b8d R08:=20
0000000000000000 R09: 0000563f7b4402f0
jul 08 19:37:04 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 19:37:04 sylvesterg kernel: R13: 0000563f7b45c4b0 R14:=20
0000000000020000 R15: 0000563f7b47f2c0
jul 08 19:37:04 sylvesterg kernel: Modules linked in: wmi_bmof=20
snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp snd_soc_sst_ipc=20
snd_soc_sst_firmware dell_laptop ledtrig_audio dell_smbios=20
x86_pkg_temp_thermal intel_powerclamp dell_wmi_descriptor kvm_intel=20
dcdbas crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel=20
aesni_intel crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf=20
efi_pstore efivars mousedev joydev arc4 iwlmvm mac80211 nft_ct=20
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 hid_multitouch iwlwifi=20
nf_tables_set i2c_i801 intel_pch_thermal snd_hda_codec_hdmi btusb=20
nf_tables btintel nfnetlink snd_hda_intel cfg80211 bluetooth lpc_ich=20
ecdh_generic mei_me rtsx_pci mei mfd_core rfkill snd_hda_codec snd_hwdep=20
ecc processor_thermal_device intel_soc_dts_iosf snd_hda_core wmi battery=20
int3403_thermal snd_soc_rt286 snd_soc_rl6347a snd_soc_core ac97_bus=20
snd_pcm snd_timer i2c_hid snd soundcore tpm_crb(+) tpm_tis tpm_tis_core=20
i2c_designware_platform snd_soc_sst_acpi i2c_designware_core=20
snd_soc_acpi_intel_match
jul 08 19:37:04 sylvesterg kernel:=C2=A0 snd_soc_acpi int3402_thermal=20
int340x_thermal_zone tpm int3400_thermal intel_hid acpi_thermal_rel=20
rng_core ac acpi_pad evdev lz4 lz4_compress sch_fq_codel zram zsmalloc=20
coretemp nfsd hwmon msr auth_rpcgss nfs_acl cpuid efivarfs=20
algif_skcipher aes_x86_64 sha512_generic iscsi_tcp libiscsi_tcp libiscsi=20
scsi_transport_iscsi bonding vxlan ip6_udp_tunnel udp_tunnel macvlan=20
fuse overlay nfs lockd grace sunrpc fscache ext4 mbcache jbd2=20
dm_snapshot dm_mirror dm_region_hash dm_log hid_sony hid_microsoft=20
ff_memless hid_logitech hid_gyration hid_generic usbhid usb_storage=20
ehci_pci ehci_hcd sr_mod cdrom sg kvm xhci_pci irqbypass xhci_hcd=20
usbcore usb_common sparse_keymap
jul 08 19:37:04 sylvesterg kernel: CR2: 00000ffeffffffe8
jul 08 19:37:04 sylvesterg kernel: ---[ end trace 9a1e9555f6173e23 ]---
jul 08 19:37:04 sylvesterg kernel: RIP:=20
0010:dwc_scan_descriptors+0x1a9/0x400
jul 08 19:37:04 sylvesterg kernel: Code: 8d 70 e0 48 39 c7 75 22 e9 73=20
01 00 00 2b 96 88 00 00 00 89 95 98 00 00 00 48 8b 46 20 48 8d 70 e0 48=20
39 c7 0f 84 56 01 00 00 <8b> 40 e8 49 39 c4 75 db 48 8b 03 48 8b 53 58=20
48 89 0c 24 8b 72 1c
jul 08 19:37:04 sylvesterg kernel: RSP: 0018:ffffc9000042b848 EFLAGS:=20
00010086
jul 08 19:37:04 sylvesterg kernel: RAX: 00000fff00000000 RBX:=20
ffff8881b99fd018 RCX: 0000000000000286
jul 08 19:37:04 sylvesterg kernel: RDX: 00000000465e33e9 RSI:=20
00000ffeffffffe0 RDI: ffff8881b99fd0b8
jul 08 19:37:04 sylvesterg kernel: RBP: ffff8881b99fd088 R08:=20
ffff8881b99fd098 R09: 0000000000a2090c
jul 08 19:37:04 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: 0000000000a2090c
jul 08 19:37:04 sylvesterg kernel: R13: ffff8881b99fd088 R14:=20
ffff8881c1da9000 R15: ffff8881b9a1cc18
jul 08 19:37:04 sylvesterg kernel: FS:=C2=A0 00007f671bb82840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 19:37:04 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 19:37:04 sylvesterg kernel: CR2: 00000ffeffffffe8 CR3:=20
00000001c4168001 CR4: 00000000003606e0


Boot #3:

jul 08 20:02:56 sylvesterg kernel: sst-acpi INT3438:00: DesignWare DMA=20
Controller, 8 channels
jul 08 20:02:56 sylvesterg kernel: sst-acpi INT3438:00: DMAR: 32bit DMA=20
uses non-identity mapping
jul 08 20:02:56 sylvesterg kernel: iTCO_wdt: Intel TCO WatchDog Timer=20
Driver v1.11
jul 08 20:02:56 sylvesterg kernel: iTCO_wdt: Found a Wildcat Point_LP=20
TCO device (Version=3D2, TCOBASE=3D0x1860)
jul 08 20:02:56 sylvesterg kernel: iTCO_wdt: initialized. heartbeat=3D30=20
sec (nowayout=3D0)
jul 08 20:02:56 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 20:02:56 sylvesterg kernel: BUG: unable to handle page fault for=20
address: 00000ffeffffffe8
jul 08 20:02:56 sylvesterg kernel: #PF: supervisor read access in kernel=20
mode
jul 08 20:02:56 sylvesterg kernel: #PF: error_code(0x0000) - not-present=20
page
jul 08 20:02:56 sylvesterg kernel: PGD 0 P4D 0
jul 08 20:02:56 sylvesterg kernel: Oops: 0000 [#1] SMP PTI
jul 08 20:02:56 sylvesterg kernel: CPU: 3 PID: 1886 Comm: systemd-udevd=20
Not tainted 5.2.0-gentoo #1
jul 08 20:02:56 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 20:02:56 sylvesterg kernel: RIP:=20
0010:dwc_scan_descriptors+0x1a9/0x400
jul 08 20:02:56 sylvesterg kernel: Code: 8d 70 e0 48 39 c7 75 22 e9 73=20
01 00 00 2b 96 88 00 00 00 89 95 98 00 00 00 48 8b 46 20 48 8d 70 e0 48=20
39 c7 0f 84 56 01 00 00 <8b> 40 e8 49 39 c4 75 db 48 8b 03 48 8b 53 58=20
48 89 0c 24 8b 72 1c
jul 08 20:02:56 sylvesterg kernel: RSP: 0018:ffffc9000053f848 EFLAGS:=20
00010086
jul 08 20:02:56 sylvesterg kernel: RAX: 00000fff00000000 RBX:=20
ffff8882116a1018 RCX: 0000000000000286
jul 08 20:02:56 sylvesterg kernel: RDX: 00000000462c9de9 RSI:=20
00000ffeffffffe0 RDI: ffff8882116a10b8
jul 08 20:02:56 sylvesterg kernel: RBP: ffff8882116a1088 R08:=20
ffff8882116a1098 R09: 0000000000a2090c
jul 08 20:02:56 sylvesterg kernel: R10: 0000000000000aa6 R11:=20
0000000000000000 R12: 0000000000a2090c
jul 08 20:02:56 sylvesterg kernel: R13: ffff8882116a1088 R14:=20
ffff8881b8e44000 R15: ffff8881b9d36218
jul 08 20:02:56 sylvesterg kernel: FS:=C2=A0 00007fee9a543840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 20:02:56 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 20:02:56 sylvesterg kernel: CR2: 00000ffeffffffe8 CR3:=20
00000002139f4002 CR4: 00000000003606e0
jul 08 20:02:56 sylvesterg kernel: Call Trace:
jul 08 20:02:56 sylvesterg kernel:=C2=A0 ? dwc_desc_get+0x64/0xa0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 dwc_tx_status+0x5f/0x180
jul 08 20:02:56 sylvesterg kernel:=C2=A0 dma_sync_wait+0x83/0xc0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x75/0x80=20
[snd_soc_sst_firmware]
jul 08 20:02:56 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 20:02:56 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 20:02:56 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 20:02:56 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 20:02:56 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 20:02:56 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 20:02:56 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 20:02:56 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 20:02:56 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 20:02:56 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 20:02:56 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 20:02:56 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 20:02:56 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 20:02:56 sylvesterg kernel: RIP: 0033:0x7fee9938ec89
jul 08 20:02:56 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 20:02:56 sylvesterg kernel: RSP: 002b:00007ffdf63901e8 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 20:02:56 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
0000564ac4ac15f0 RCX: 00007fee9938ec89
jul 08 20:02:56 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007fee99ce9b8d RDI: 0000000000000011
jul 08 20:02:56 sylvesterg kernel: RBP: 00007fee99ce9b8d R08:=20
0000000000000000 R09: 0000564ac4acee10
jul 08 20:02:56 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 20:02:56 sylvesterg kernel: R13: 0000564ac4af1c30 R14:=20
0000000000020000 R15: 0000564ac4ac15f0
jul 08 20:02:56 sylvesterg kernel: Modules linked in: iTCO_wdt dell_wmi=20
wmi_bmof snd_soc_sst_haswell_pcm(+) snd_soc_sst_dsp snd_soc_sst_ipc=20
snd_soc_sst_firmware x86_pkg_temp_thermal intel_powerclamp dell_laptop=20
kvm_intel ledtrig_audio dell_smbios dell_wmi_descriptor dcdbas=20
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel=20
aesni_intel crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf=20
mousedev joydev arc4 efi_pstore efivars snd_soc_rt286 snd_soc_rl6347a=20
nft_ct nf_conntrack intel_pch_thermal iwlmvm snd_hda_codec_hdmi mac80211=20
snd_hda_intel i2c_i801 nf_defrag_ipv6 hid_multitouch nf_defrag_ipv4=20
iwlwifi nf_tables_set btusb btintel nf_tables nfnetlink snd_soc_core=20
snd_hda_codec bluetooth snd_hwdep mei_me lpc_ich rtsx_pci cfg80211=20
snd_hda_core ac97_bus ecdh_generic mfd_core snd_pcm mei rfkill ecc=20
snd_timer processor_thermal_device intel_soc_dts_iosf snd soundcore=20
i2c_hid wmi tpm_crb(+) tpm_tis tpm_tis_core int3403_thermal battery tpm=20
int3402_thermal rng_core int340x_thermal_zone snd_soc_sst_acpi
jul 08 20:02:56 sylvesterg kernel:=C2=A0 snd_soc_acpi_intel_match=20
snd_soc_acpi i2c_designware_platform i2c_designware_core lz4=20
lz4_compress int3400_thermal intel_hid acpi_thermal_rel acpi_pad ac=20
evdev sch_fq_codel zram zsmalloc coretemp hwmon msr cpuid nfsd=20
auth_rpcgss nfs_acl efivarfs algif_skcipher aes_x86_64 sha512_generic=20
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi bonding vxlan=20
ip6_udp_tunnel udp_tunnel macvlan fuse overlay nfs lockd grace sunrpc=20
fscache ext4 mbcache jbd2 dm_snapshot dm_mirror dm_region_hash dm_log=20
hid_sony hid_microsoft ff_memless hid_logitech hid_gyration hid_generic=20
usbhid usb_storage ehci_pci ehci_hcd sr_mod cdrom sg kvm xhci_pci=20
irqbypass xhci_hcd usbcore usb_common sparse_keymap
jul 08 20:02:56 sylvesterg kernel: CR2: 00000ffeffffffe8
jul 08 20:02:56 sylvesterg kernel: ---[ end trace f9f2a4f40d7d353e ]---
jul 08 20:02:56 sylvesterg kernel: RIP:=20
0010:dwc_scan_descriptors+0x1a9/0x400
jul 08 20:02:56 sylvesterg kernel: Code: 8d 70 e0 48 39 c7 75 22 e9 73=20
01 00 00 2b 96 88 00 00 00 89 95 98 00 00 00 48 8b 46 20 48 8d 70 e0 48=20
39 c7 0f 84 56 01 00 00 <8b> 40 e8 49 39 c4 75 db 48 8b 03 48 8b 53 58=20
48 89 0c 24 8b 72 1c
jul 08 20:02:56 sylvesterg kernel: RSP: 0018:ffffc9000053f848 EFLAGS:=20
00010086
jul 08 20:02:56 sylvesterg kernel: RAX: 00000fff00000000 RBX:=20
ffff8882116a1018 RCX: 0000000000000286
jul 08 20:02:56 sylvesterg kernel: RDX: 00000000462c9de9 RSI:=20
00000ffeffffffe0 RDI: ffff8882116a10b8
jul 08 20:02:56 sylvesterg kernel: RBP: ffff8882116a1088 R08:=20
ffff8882116a1098 R09: 0000000000a2090c
jul 08 20:02:56 sylvesterg kernel: R10: 0000000000000aa6 R11:=20
0000000000000000 R12: 0000000000a2090c
jul 08 20:02:56 sylvesterg kernel: R13: ffff8882116a1088 R14:=20
ffff8881b8e44000 R15: ffff8881b9d36218
jul 08 20:02:56 sylvesterg kernel: FS:=C2=A0 00007fee9a543840(0000)=20
GS:ffff888217380000(0000) knlGS:0000000000000000
jul 08 20:02:56 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 20:02:56 sylvesterg kernel: CR2: 00000ffeffffffe8 CR3:=20
00000002139f4002 CR4: 00000000003606e0


Boot #4:

jul 08 20:20:23 sylvesterg kernel: sst-acpi INT3438:00: DesignWare DMA=20
Controller, 8 channels
jul 08 20:20:23 sylvesterg kernel: sst-acpi INT3438:00: DMAR: 32bit DMA=20
uses non-identity mapping
jul 08 20:20:23 sylvesterg kernel: dma dma1chan0: BUG: All descriptors=20
done, but channel not idle!
jul 08 20:20:23 sylvesterg kernel: BUG: unable to handle page fault for=20
address: 00000ffeffffffe8
jul 08 20:20:23 sylvesterg kernel: #PF: supervisor read access in kernel=20
mode
jul 08 20:20:23 sylvesterg kernel: #PF: error_code(0x0000) - not-present=20
page
jul 08 20:20:23 sylvesterg kernel: PGD 0 P4D 0
jul 08 20:20:23 sylvesterg kernel: Oops: 0000 [#1] SMP PTI
jul 08 20:20:23 sylvesterg kernel: CPU: 0 PID: 1914 Comm: systemd-udevd=20
Not tainted 5.2.0-gentoo #1
jul 08 20:20:23 sylvesterg kernel: Hardware name: Dell Inc. XPS 13=20
9343/0310JH, BIOS A15 01/23/2018
jul 08 20:20:23 sylvesterg kernel: RIP:=20
0010:dwc_scan_descriptors+0x1a9/0x400
jul 08 20:20:23 sylvesterg kernel: Code: 8d 70 e0 48 39 c7 75 22 e9 73=20
01 00 00 2b 96 88 00 00 00 89 95 98 00 00 00 48 8b 46 20 48 8d 70 e0 48=20
39 c7 0f 84 56 01 00 00 <8b> 40 e8 49 39 c4 75 db 48 8b 03 48 8b 53 58=20
48 89 0c 24 8b 72 1c
jul 08 20:20:23 sylvesterg kernel: RSP: 0018:ffffc9000085f848 EFLAGS:=20
00010086
jul 08 20:20:23 sylvesterg kernel: RAX: 00000fff00000000 RBX:=20
ffff8881bc10c818 RCX: 0000000000000286
jul 08 20:20:23 sylvesterg kernel: RDX: 00000000eebf3fe9 RSI:=20
00000ffeffffffe0 RDI: ffff8881bc10c8b8
jul 08 20:20:23 sylvesterg kernel: RBP: ffff8881bc10c888 R08:=20
ffff8881bc10c898 R09: 0000000000a2090c
jul 08 20:20:23 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: 0000000000a2090c
jul 08 20:20:23 sylvesterg kernel: R13: ffff8881bc10c888 R14:=20
ffff8881bdcef000 R15: ffff88821140c018
jul 08 20:20:23 sylvesterg kernel: FS:=C2=A0 00007f0e329c6840(0000)=20
GS:ffff888217200000(0000) knlGS:0000000000000000
jul 08 20:20:23 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 20:20:23 sylvesterg kernel: CR2: 00000ffeffffffe8 CR3:=20
00000001c4078002 CR4: 00000000003606f0
jul 08 20:20:23 sylvesterg kernel: Call Trace:
jul 08 20:20:23 sylvesterg kernel:=C2=A0 ? dwc_desc_get+0x64/0xa0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 dwc_tx_status+0x5f/0x180
jul 08 20:20:23 sylvesterg kernel:=C2=A0 dma_sync_wait+0x83/0xc0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 sst_dsp_dma_copy+0x75/0x80=20
[snd_soc_sst_firmware]
jul 08 20:20:23 sylvesterg kernel: sst_module_alloc_blocks+0xac/0x170=20
[snd_soc_sst_firmware]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 hsw_parse_fw_image+0x148/0x220=20
[snd_soc_sst_haswell_pcm]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 sst_fw_new+0xa9/0x180=20
[snd_soc_sst_firmware]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 sst_hsw_module_load+0x76/0x100=20
[snd_soc_sst_haswell_pcm]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 sst_hsw_dsp_init+0x1c3/0x390=20
[snd_soc_sst_haswell_pcm]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 hsw_pcm_dev_probe+0x49/0xc0=20
[snd_soc_sst_haswell_pcm]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 platform_drv_probe+0x38/0x80
jul 08 20:20:23 sylvesterg kernel:=C2=A0 really_probe+0xed/0x290
jul 08 20:20:23 sylvesterg kernel:=C2=A0 driver_probe_device+0x50/0xc0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 device_driver_attach+0x4f/0x60
jul 08 20:20:23 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 20:20:23 sylvesterg kernel:=C2=A0 __driver_attach+0x51/0xb0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 ? device_driver_attach+0x60/0x60
jul 08 20:20:23 sylvesterg kernel:=C2=A0 bus_for_each_dev+0x93/0xe0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 bus_add_driver+0x1a6/0x1c0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 driver_register+0x6b/0xb0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 ?=20
trace_event_define_fields_hsw_device_config_req+0xab/0xab=20
[snd_soc_sst_haswell_pcm]
jul 08 20:20:23 sylvesterg kernel:=C2=A0 do_one_initcall+0x5b/0x1f4
jul 08 20:20:23 sylvesterg kernel:=C2=A0 do_init_module+0x5a/0x220
jul 08 20:20:23 sylvesterg kernel:=C2=A0 load_module+0x1fad/0x2180
jul 08 20:20:23 sylvesterg kernel:=C2=A0 ? __do_sys_finit_module+0xd2/0xf=
0
jul 08 20:20:23 sylvesterg kernel: __do_sys_finit_module+0xd2/0xf0
jul 08 20:20:23 sylvesterg kernel:=C2=A0 do_syscall_64+0x5f/0x1b0
jul 08 20:20:23 sylvesterg kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
jul 08 20:20:23 sylvesterg kernel: RIP: 0033:0x7f0e31811c89
jul 08 20:20:23 sylvesterg kernel: Code: 00 00 00 75 05 48 83 c4 18 c3=20
e8 a2 8d 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89=20
c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 71 2c=20
00 f7 d8 64 89 01 48
jul 08 20:20:23 sylvesterg kernel: RSP: 002b:00007ffd11175c88 EFLAGS:=20
00000246 ORIG_RAX: 0000000000000139
jul 08 20:20:23 sylvesterg kernel: RAX: ffffffffffffffda RBX:=20
000055db4a9ba960 RCX: 00007f0e31811c89
jul 08 20:20:23 sylvesterg kernel: RDX: 0000000000000000 RSI:=20
00007f0e3216cb8d RDI: 0000000000000011
jul 08 20:20:23 sylvesterg kernel: RBP: 00007f0e3216cb8d R08:=20
0000000000000000 R09: 000055db4a976fa0
jul 08 20:20:23 sylvesterg kernel: R10: 0000000000000011 R11:=20
0000000000000246 R12: 0000000000000000
jul 08 20:20:23 sylvesterg kernel: R13: 000055db4a9a0a90 R14:=20
0000000000020000 R15: 000055db4a9ba960
jul 08 20:20:23 sylvesterg kernel: Modules linked in:=20
snd_soc_sst_haswell_pcm(+) dell_wmi wmi_bmof snd_soc_sst_dsp=20
snd_soc_sst_ipc snd_soc_sst_firmware x86_pkg_temp_thermal joydev arc4=20
mousedev intel_powerclamp hid_multitouch iwlmvm kvm_intel mac80211=20
crct10dif_pclmul crc32_pclmul dell_laptop crc32c_intel ledtrig_audio=20
ghash_clmulni_intel snd_hda_codec_hdmi iwlwifi dell_smbios snd_hda_intel=20
nft_ct nf_conntrack mei_me nf_defrag_ipv6 nf_defrag_ipv4 efi_pstore=20
dell_wmi_descriptor dcdbas nf_tables_set efivars intel_pch_thermal btusb=20
i2c_i801 aesni_intel crypto_simd cryptd glue_helper intel_cstate=20
intel_rapl_perf btintel bluetooth cfg80211 nf_tables snd_hda_codec=20
lpc_ich ecdh_generic ecc nfnetlink mei rfkill rtsx_pci mfd_core=20
processor_thermal_device intel_soc_dts_iosf snd_hwdep snd_hda_core=20
snd_soc_rt286 snd_soc_rl6347a wmi snd_soc_core ac97_bus battery snd_pcm=20
i2c_hid int3403_thermal snd_timer snd soundcore snd_soc_sst_acpi=20
tpm_crb(+) snd_soc_acpi_intel_match snd_soc_acpi tpm_tis tpm_tis_core=20
int3400_thermal
jul 08 20:20:23 sylvesterg kernel:=C2=A0 int3402_thermal acpi_thermal_rel=
=20
int340x_thermal_zone evdev ac acpi_pad i2c_designware_platform=20
i2c_designware_core tpm intel_hid rng_core lz4 lz4_compress sch_fq_codel=20
zram zsmalloc coretemp hwmon msr nfsd auth_rpcgss nfs_acl cpuid efivarfs=20
algif_skcipher aes_x86_64 sha512_generic iscsi_tcp libiscsi_tcp libiscsi=20
scsi_transport_iscsi bonding vxlan ip6_udp_tunnel udp_tunnel macvlan=20
fuse overlay nfs lockd grace sunrpc fscache ext4 mbcache jbd2=20
dm_snapshot dm_mirror dm_region_hash dm_log hid_sony hid_microsoft=20
ff_memless hid_logitech hid_gyration hid_generic usbhid usb_storage=20
ehci_pci ehci_hcd sr_mod cdrom sg xhci_pci kvm irqbypass xhci_hcd=20
usbcore usb_common sparse_keymap
jul 08 20:20:23 sylvesterg kernel: CR2: 00000ffeffffffe8
jul 08 20:20:23 sylvesterg kernel: ---[ end trace 0c373117ce9a75c6 ]---
jul 08 20:20:23 sylvesterg kernel: RIP:=20
0010:dwc_scan_descriptors+0x1a9/0x400
jul 08 20:20:23 sylvesterg kernel: Code: 8d 70 e0 48 39 c7 75 22 e9 73=20
01 00 00 2b 96 88 00 00 00 89 95 98 00 00 00 48 8b 46 20 48 8d 70 e0 48=20
39 c7 0f 84 56 01 00 00 <8b> 40 e8 49 39 c4 75 db 48 8b 03 48 8b 53 58=20
48 89 0c 24 8b 72 1c
jul 08 20:20:23 sylvesterg kernel: RSP: 0018:ffffc9000085f848 EFLAGS:=20
00010086
jul 08 20:20:23 sylvesterg kernel: RAX: 00000fff00000000 RBX:=20
ffff8881bc10c818 RCX: 0000000000000286
jul 08 20:20:23 sylvesterg kernel: RDX: 00000000eebf3fe9 RSI:=20
00000ffeffffffe0 RDI: ffff8881bc10c8b8
jul 08 20:20:23 sylvesterg kernel: RBP: ffff8881bc10c888 R08:=20
ffff8881bc10c898 R09: 0000000000a2090c
jul 08 20:20:23 sylvesterg kernel: R10: 0000000000000000 R11:=20
0000000000000030 R12: 0000000000a2090c
jul 08 20:20:23 sylvesterg kernel: R13: ffff8881bc10c888 R14:=20
ffff8881bdcef000 R15: ffff88821140c018
jul 08 20:20:23 sylvesterg kernel: FS:=C2=A0 00007f0e329c6840(0000)=20
GS:ffff888217200000(0000) knlGS:0000000000000000
jul 08 20:20:23 sylvesterg kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
jul 08 20:20:23 sylvesterg kernel: CR2: 00000ffeffffffe8 CR3:=20
00000001c4078002 CR4: 00000000003606f0

Boot #5:

jul 08 20:48:57 sylvesterg kernel: sst-acpi INT3438:00: DesignWare DMA=20
Controller, 8 channels
jul 08 20:48:57 sylvesterg kernel: sst-acpi INT3438:00: DMAR: 32bit DMA=20
uses non-identity mapping
jul 08 20:48:58 sylvesterg kernel: bpfilter: Loaded bpfilter_umh pid 2122
jul 08 20:48:59 sylvesterg kernel: Bluetooth: hci0: Waiting for firmware=20
download to complete
jul 08 20:48:59 sylvesterg kernel: Bluetooth: hci0: Firmware loaded in=20
1802308 usecs
jul 08 20:48:59 sylvesterg kernel: Bluetooth: hci0: Waiting for device=20
to boot
jul 08 20:48:59 sylvesterg kernel: Bluetooth: hci0: Device booted in=20
11692 usecs
jul 08 20:48:59 sylvesterg kernel: Bluetooth: hci0: Found Intel DDC=20
parameters: intel/ibt-12-16.ddc
jul 08 20:48:59 sylvesterg kernel: Bluetooth: hci0: Applying Intel DDC=20
parameters completed
jul 08 20:49:02 sylvesterg kernel: sst-acpi INT3438:00: dma_sync_wait:=20
timeout!
jul 08 20:49:02 sylvesterg kernel: Bluetooth: BNEP (Ethernet Emulation)=20
ver 1.3
jul 08 20:49:02 sylvesterg kernel: Bluetooth: BNEP filters: protocol=20
multicast
jul 08 20:49:02 sylvesterg kernel: Bluetooth: BNEP socket layer initializ=
ed
jul 08 20:49:07 sylvesterg kernel: sst-acpi INT3438:00: dma_sync_wait:=20
timeout!
jul 08 20:49:12 sylvesterg kernel: sst-acpi INT3438:00: dma_sync_wait:=20
timeout!
jul 08 20:49:17 sylvesterg kernel: sst-acpi INT3438:00: dma_sync_wait:=20
timeout!


As my system behaved very unstable, I decided to boot back into 5.1.15=20
at this point, which does not show any of these traces or=20
"dma_sync_wait: timeout!" or "All descriptors done, but channel not=20
idle!" messages.

Stijn

