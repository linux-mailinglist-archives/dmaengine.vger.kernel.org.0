Return-Path: <dmaengine+bounces-2030-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF488C5100
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 13:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FBA1C21461
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658412D76D;
	Tue, 14 May 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmsVY3wk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E512D768;
	Tue, 14 May 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683956; cv=none; b=OX/E9O2C2PLl2vgWgeWuHAnsGCgnF2AsMc/pe7qOV2e6u804K+NcWlzNcO/iOLeYlrvEjH+NXF6Zp7wCmDFgehGzWJpXRABiBIFmQhDzPL7t/6V2QQvPlbgo0d/r+e8GWCMp3PrhMer8PlN7Lq7YR4A5vUSKNAI3XvqRDE/Pj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683956; c=relaxed/simple;
	bh=Dr4sOwYTy/59o6ynFc5uhkbyztOrsuv0t61iNFKQ0ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H+1Yv15cbytsEfvF5loXzhXQoRemEYyjRUp3Ou8td3kP5xlb7WiC/Tk+2C7bFasw3uxxyWh9PQg4wFgmpuQoq/DXZIsvCYXqZB45X4pThm6CTUFOBrZZ8WKysE8f/NnVlRanaEV69gkWY/FUj5WbC7HlZtSWfSFDDSrpssXbaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmsVY3wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E840EC32781;
	Tue, 14 May 2024 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715683956;
	bh=Dr4sOwYTy/59o6ynFc5uhkbyztOrsuv0t61iNFKQ0ms=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LmsVY3wkFQIarUuLP7aViQL2sZRZJ+gWDSqHLStydxjuRmjKVSnXqFTNlJgrDdwq+
	 f2pmdEQ9nfwME4M/vdWDRGAFE/WLmt8ee7r23DASOFpBhPN62FaitsMRtxIb0sgg+e
	 ZDKkWleeFEf9htlCaoK0Y2m1hwffB5be+Keq1OPMqrfLmhKVqdPUaYHz3vFkXThDCW
	 h3l2tTINo7A8F5A+7qZ1W0yZICpjLsj8dj1q52hFqu3Y47Q6rMIDEjs3dpVBBL5WnS
	 ItGXCaZyHhRtZVUaC0jLKbgLuTAoUx+ijGpY4S34e19ShZJdluDQwzOauOD37QHscB
	 dmGm9C9Cd977w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE6C04FFE;
	Tue, 14 May 2024 10:52:35 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Tue, 14 May 2024 13:52:31 +0300
Subject: [PATCH] dmaengine: ioatdma: Fix missing kmem_cache_destroy()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-ioatdma_fixes-v1-1-2776a0913254@yadro.com>
X-B4-Tracking: v=1; b=H4sIAG5CQ2YC/x3LQQqFMAxF0a1Ixr/QSlVwKyKfaFPNwCqJiCDu3
 erwvse5QEmYFNriAqGDldeUw/0KGGdMExkOuaG0pbeV84ZX3MOC/8gnqWl8baOPoQmVg2wGVDK
 DYBrnVy2oO8l7bEKfyGvX3/cDq+M74HgAAAA=
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715683955; l=1016;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=TaDiVeYpCG0Gog6sHS4e83pIRXeaMHb4I90wYknNlpQ=;
 b=2r0fesdFAuB2thndx9sfMJ/dbUYz2qmIAG5YWpn7va1Sqt0J9PosnpdcOcSnHUcazw8ZCkLneKSV
 snq0jwzMA6Mfwz5uixHXRX80bber7nP+aQ7AEIMOT+zsQrPpAqfB
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

Fix missing kmem_cache_destroy() for ioat_sed_cache in
ioat_exit_module().

Noticed via:

```
modprobe ioatdma
rmmod ioatdma
modprobe ioatdma
debugfs: Directory 'ioat_sed_ent' with parent 'slab' already present!
```

Fixes: c0f28ce66ecf ("dmaengine: ioatdma: move all the init routines")
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 drivers/dma/ioat/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 9c364e92cb82..61329c279040 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1445,6 +1445,7 @@ module_init(ioat_init_module);
 static void __exit ioat_exit_module(void)
 {
 	pci_unregister_driver(&ioat_pci_driver);
+	kmem_cache_destroy(ioat_sed_cache);
 	kmem_cache_destroy(ioat_cache);
 }
 module_exit(ioat_exit_module);

---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240514-ioatdma_fixes-7460f4fd7d51

Best regards,
-- 
Nikita Shubin <n.shubin@yadro.com>



