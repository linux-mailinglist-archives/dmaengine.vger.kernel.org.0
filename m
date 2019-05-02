Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371FC11980
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEBM4A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 08:56:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17139 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEBM4A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 08:56:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccae8da0000>; Thu, 02 May 2019 05:55:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 05:55:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 May 2019 05:55:58 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:55:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 2 May 2019 12:55:57 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ccae8da0000>; Thu, 02 May 2019 05:55:57 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 5/6] dmaengine: tegra210-dma: free dma controller in remove()
Date:   Thu, 2 May 2019 18:25:16 +0530
Message-ID: <1556801717-31507-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
References: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556801754; bh=P4zIL626HO9TKcEIuZdJBsckmL2U2jxasfFus+sRTz0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=IJWij8F6RNzkDfig0BuP36yi/vzaMNSb5ZlxjSqPrLWR3nD51BSGNnjyvC8cwX4UM
         KOeoBrCIms4RYWbKVNCr5347vda4WhOJBY779mMaJcU21Hy/LQY4yxcgHqsD68QPQT
         U6RqQhXiurdAteP80sw8mqsWppGha2bcrVlYyhbszNZq5F/e/P67TQzLAmJ7IMhfhh
         yYs47mvM4QKSvWoZpKgyVBzDdhUzoFwrg4+kFzx/4Tm7Ib189IQnmhrCDS6CJd3ITU
         k+4fLT79ADReOS/cVxZ0QeOCcv/jVGsrIYGr9Pk3Mm7hIhTPaU1v98hbNHWVgakn0e
         3u81uOs/faBtA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Following kernel panic is seen during DMA driver unload->load sequence
==========================================================================
Unable to handle kernel paging request at virtual address ffffff8001198880
Internal error: Oops: 86000007 [#1] PREEMPT SMP
CPU: 0 PID: 5907 Comm: HwBinder:4123_1 Tainted: G C 4.9.128-tegra-g065839f
Hardware name: galen (DT)
task: ffffffc3590d1a80 task.stack: ffffffc3d0678000
PC is at 0xffffff8001198880
LR is at of_dma_request_slave_channel+0xd8/0x1f8
pc : [<ffffff8001198880>] lr : [<ffffff8008746f30>] pstate: 60400045
sp : ffffffc3d067b710
x29: ffffffc3d067b710 x28: 000000000000002f
x27: ffffff800949e000 x26: ffffff800949e750
x25: ffffff800949e000 x24: ffffffbefe817d84
x23: ffffff8009f77cb0 x22: 0000000000000028
x21: ffffffc3ffda49c8 x20: 0000000000000029
x19: 0000000000000001 x18: ffffffffffffffff
x17: 0000000000000000 x16: ffffff80082b66a0
x15: ffffff8009e78250 x14: 000000000000000a
x13: 0000000000000038 x12: 0101010101010101
x11: 0000000000000030 x10: 0101010101010101
x9 : fffffffffffffffc x8 : 7f7f7f7f7f7f7f7f
x7 : 62ff726b6b64622c x6 : 0000000000008064
x5 : 6400000000000000 x4 : ffffffbefe817c44
x3 : ffffffc3ffda3e08 x2 : ffffff8001198880
x1 : ffffffc3d48323c0 x0 : ffffffc3d067b788

Process HwBinder:4123_1 (pid: 5907, stack limit = 0xffffffc3d0678028)
Call trace:
[<ffffff8001198880>] 0xffffff8001198880
[<ffffff80087459f8>] dma_request_chan+0x50/0x1f0
[<ffffff8008745bc0>] dma_request_slave_channel+0x28/0x40
[<ffffff8001552c44>] tegra_alt_pcm_open+0x114/0x170
[<ffffff8008d65fa4>] soc_pcm_open+0x10c/0x878
[<ffffff8008d18618>] snd_pcm_open_substream+0xc0/0x170
[<ffffff8008d1878c>] snd_pcm_open+0xc4/0x240
[<ffffff8008d189e0>] snd_pcm_playback_open+0x58/0x80
[<ffffff8008cfc6d4>] snd_open+0xb4/0x178
[<ffffff8008250628>] chrdev_open+0xb8/0x1d0
[<ffffff8008246fdc>] do_dentry_open+0x214/0x318
[<ffffff80082485d0>] vfs_open+0x58/0x88
[<ffffff800825bce0>] do_last+0x450/0xde0
[<ffffff800825c718>] path_openat+0xa8/0x368
[<ffffff800825dd84>] do_filp_open+0x8c/0x110
[<ffffff8008248a74>] do_sys_open+0x164/0x220
[<ffffff80082b66dc>] compat_SyS_openat+0x3c/0x50
[<ffffff8008083040>] el0_svc_naked+0x34/0x38
---[ end trace 67e6d544e65b5145 ]---
Kernel panic - not syncing: Fatal exception
==========================================================================

In device probe(), of_dma_controller_register() registers DMA controller.
But when driver is removed, this is not freed. During driver reload this
results in data abort and kernel panic. Add of_dma_controller_free() in
driver remove path to fix the issue.

Fixes: f46b195799b5 ("dmaengine: tegra-adma: Add support for Tegra210 ADMA")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index f26c458..953669d 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -888,6 +888,7 @@ static int tegra_adma_remove(struct platform_device *pdev)
 	struct tegra_adma *tdma = platform_get_drvdata(pdev);
 	int i;
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 
 	for (i = 0; i < tdma->nr_channels; ++i)
-- 
2.7.4

