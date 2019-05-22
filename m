Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5F26FAE
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfEVTYD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 15:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfEVTYC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 15:24:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B201621473;
        Wed, 22 May 2019 19:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553041;
        bh=rAcvKwp2UduGNAUik+s6lh38sOxMN6Y08aQsqhokFCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFBkApFgALB2EhYughhFO2BCMJl3zTGC3JxEjHcwhWsHsxEUrzDflN3NCZ+mUuI3/
         NKXQF+E/8N9xU4QVDEU8aVZ7FaKo0d+HgCisPgssVD2T3oTtlIXtYLOO31J6ZcAM+3
         YEQlp80vOLfSf3Npi0CzZrH0l3rj4QCERrN3vicY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameer Pujar <spujar@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 016/317] dmaengine: tegra210-dma: free dma controller in remove()
Date:   Wed, 22 May 2019 15:18:37 -0400
Message-Id: <20190522192338.23715-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sameer Pujar <spujar@nvidia.com>

[ Upstream commit f030e419501cb95e961e9ed35c493b5d46a04eca ]

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
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/tegra210-adma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b26256f23d67f..08b10274284a8 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -786,6 +786,7 @@ static int tegra_adma_remove(struct platform_device *pdev)
 	struct tegra_adma *tdma = platform_get_drvdata(pdev);
 	int i;
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 
 	for (i = 0; i < tdma->nr_channels; ++i)
-- 
2.20.1

