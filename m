Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD1413B22
	for <lists+dmaengine@lfdr.de>; Tue, 21 Sep 2021 22:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhIUUR2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Sep 2021 16:17:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:15881 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhIUUR2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Sep 2021 16:17:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="220261838"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="220261838"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 13:15:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="613141832"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 13:15:59 -0700
Subject: [PATCH] dmanegine: idxd: fix resource free ordering on driver removal
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Ziye Yang <ziye.yang@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 21 Sep 2021 13:15:58 -0700
Message-ID: <163225535868.4152687.9318737776682088722.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fault triggers on ioread32() when pci driver unbind is envoked. The
placement of idxd sub-driver removal causes the probing of the device mmio
region after the mmio mapping being torn down. The driver needs the
sub-drivers to be unbound but not release the idxd context until all
shutdown activities has been done. Move the sub-driver unregistering up
before the remove() calls shutdown(). But take a device ref on the
idxd->conf_dev so that the memory does not get freed in ->release(). When
all cleanup activities has been done, release the ref to allow the idxd
memory to be freed.

[57159.542766] RIP: 0010:ioread32+0x27/0x60
[57159.547097] Code: 00 66 90 48 81 ff ff ff 03 00 77 1e 48 81 ff 00 00 01 00 76 05 0f
 b7 d7 ed c3 8b 15 03 50 41 01 b8 ff ff ff ff 85 d2 75 04 c3 <8b> 07 c3 55 83 ea 01 48
 89 fe 48 c7 c7 00 70 5f 82 48 89 e5 48 83
[57159.566647] RSP: 0018:ffffc900011abb60 EFLAGS: 00010292
[57159.572295] RAX: ffffc900011e0000 RBX: ffff888107d39800 RCX: 0000000000000000
[57159.579842] RDX: 0000000000000000 RSI: ffffffff82b1e448 RDI: ffffc900011e0090
[57159.587421] RBP: ffffc900011abb88 R08: 0000000000000000 R09: 0000000000000001
[57159.594972] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881019840d0
[57159.602533] R13: ffff8881097e9000 R14: ffffffffa08542a0 R15: 00000000000003a8
[57159.610093] FS:  00007f991e0a8740(0000) GS:ffff888459900000(0000) knlGS:00000000000
00000
[57159.618614] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[57159.624814] CR2: ffffc900011e0090 CR3: 000000010862a002 CR4: 00000000003706e0
[57159.632397] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[57159.639973] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[57159.647601] Call Trace:
[57159.650502]  ? idxd_device_disable+0x41/0x110 [idxd]
[57159.655948]  idxd_device_drv_remove+0x2b/0x80 [idxd]
[57159.661374]  idxd_config_bus_remove+0x16/0x20
[57159.666191]  __device_release_driver+0x163/0x240
[57159.671320]  device_release_driver+0x2b/0x40
[57159.676052]  bus_remove_device+0xf5/0x160
[57159.680524]  device_del+0x19c/0x400
[57159.684440]  device_unregister+0x18/0x60
[57159.688792]  idxd_remove+0x140/0x1c0 [idxd]
[57159.693406]  pci_device_remove+0x3e/0xb0
[57159.697758]  __device_release_driver+0x163/0x240
[57159.702788]  device_driver_detach+0x43/0xb0
[57159.707424]  unbind_store+0x11e/0x130
[57159.711537]  drv_attr_store+0x24/0x30
[57159.715646]  sysfs_kf_write+0x4b/0x60
[57159.719710]  kernfs_fop_write_iter+0x153/0x1e0
[57159.724563]  new_sync_write+0x120/0x1b0
[57159.728812]  vfs_write+0x23e/0x350
[57159.732624]  ksys_write+0x70/0xf0
[57159.736335]  __x64_sys_write+0x1a/0x20
[57159.740492]  do_syscall_64+0x3b/0x90
[57159.744465]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[57159.749908] RIP: 0033:0x7f991e19c387
[57159.753898] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e
 fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51
 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[57159.773564] RSP: 002b:00007ffc2ce2d6a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[57159.781550] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f991e19c387
[57159.789133] RDX: 000000000000000c RSI: 000055ee2630e140 RDI: 0000000000000001
[57159.796695] RBP: 000055ee2630e140 R08: 0000000000000000 R09: 00007f991e2324e0
[57159.804246] R10: 00007f991e2323e0 R11: 0000000000000246 R12: 000000000000000c
[57159.811800] R13: 00007f991e26f520 R14: 000000000000000c R15: 00007f991e26f700
[57159.819373] Modules linked in: idxd bridge stp llc bnep sunrpc nls_iso8859_1 intel_
rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_code
c_realtek iTCO_wdt 8250_dw snd_hda_codec_generic kvm_intel ledtrig_audio iTCO_vendor_s
upport snd_hda_intel snd_intel_dspcfg ppdev kvm snd_hda_codec intel_wmi_thunderbolt sn
d_hwdep irqbypass iwlwifi btusb snd_hda_core rapl btrtl intel_cstate snd_seq btbcm snd
_seq_device btintel snd_pcm cfg80211 bluetooth pcspkr psmouse input_leds snd_timer int
el_lpss_pci mei_me intel_lpss snd ecdh_generic ecc mei ucsi_acpi i2c_i801 idma64 i2c_s
mbus virt_dma soundcore typec_ucsi typec wmi parport_pc parport video mac_hid acpi_pad
 sch_fq_codel drm ip_tables x_tables crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
 usbkbd hid_generic usbmouse aesni_intel usbhid crypto_simd cryptd e1000e hid serio_ra
w ahci libahci pinctrl_sunrisepoint fuse msr autofs4 [last unloaded: idxd]
[57159.904082] CR2: ffffc900011e0090
[57159.907877] ---[ end trace b4e32f49ce9176a4 ]---

Fixes: 49c4959f04b5 ("dmaengine: idxd: fix sequence for pci driver remove() and shutdown()")
Reported-by: Ziye Yang <ziye.yang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index eb09bc591c31..7bf03f371ce1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -797,11 +797,19 @@ static void idxd_remove(struct pci_dev *pdev)
 	int msixcnt = pci_msix_vec_count(pdev);
 	int i;
 
-	dev_dbg(&pdev->dev, "%s called\n", __func__);
+	idxd_unregister_devices(idxd);
+	/*
+	 * When ->release() is called for the idxd->conf_dev, it frees all the memory related
+	 * to the idxd context. The driver still needs those bits in order to do the rest of
+	 * the cleanup. However, we do need to unbound the idxd sub-driver. So take a ref
+	 * on the device here to hold off the freeing while allowing the idxd sub-driver
+	 * to unbind.
+	 */
+	get_device(idxd_confdev(idxd));
+	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	idxd_unregister_devices(idxd);
 
 	for (i = 0; i < msixcnt; i++) {
 		irq_entry = &idxd->irq_entries[i];
@@ -815,7 +823,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-	device_unregister(idxd_confdev(idxd));
+	put_device(idxd_confdev(idxd));
 }
 
 static struct pci_driver idxd_pci_driver = {


