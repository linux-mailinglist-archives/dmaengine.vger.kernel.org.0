Return-Path: <dmaengine+bounces-4858-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9DEA80C97
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AF47B9D74
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8D1632DF;
	Tue,  8 Apr 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu61d3Kr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06723EADC;
	Tue,  8 Apr 2025 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119478; cv=none; b=f0ncnrTmJGNXDXWuFJxP4m8ptWaKc9iYBN30SeoETyWCjYk5v2bVmzfOUy6W2nYDFPFokdCqhVGHsncqgSRGyHPvLHgX38x0FdhLWEJ/Dc/n9kB8LC3GH8LTaJz5fPsVRly284K2H1e3Mfxoo1GaVvTErUsDdLbpjYMkoLOhQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119478; c=relaxed/simple;
	bh=q6GEDyRHkNPIgFW4WBIasci/+rbm4z9Zl+yd1IMxtFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ce0cTTcX6haB58p5SzBYLqLZxfVinCIZuY2fbGFqC9c5UXA9ZRYmZHO3yLNpQk9EZ/lPpzj/vAfq7iuy79891s+1QMPChen+oHoHtSyhlzIX/rnlAbJ3anXcog+eRHr//ZpOGbfuwAmC1JmU6n+l7RzmRHhBmAcqsTwiP1Tviyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu61d3Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73394C4CEEA;
	Tue,  8 Apr 2025 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119477;
	bh=q6GEDyRHkNPIgFW4WBIasci/+rbm4z9Zl+yd1IMxtFY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Pu61d3Kr76fi1/vQIg4L9kX+LD+rasBuMKgyf/ze7gCwA0HjCgsvhGuFi9N29v68s
	 wBJcJ33CStFa+ZJJGn72SOgslV/RVP6Dtkt6k2ifO+L4MP6lueD/NqlR/VQN+nfoTc
	 5m6DWRejuaOF+K+LOBARcydjnpQOorQD6hVC13AYP4tWM7GXSNVCeChRbu1mt4LX/g
	 AqRk3INcSJu488c9uEiKT8FVjyCp06sZOmGDqvT8FnyxGkY2occcD+6RoowA818+3y
	 3TGePvI+cZa0v4uCHbe5tteG5VJsXaWXdypOf0JyFGELUI0XFHKGovJpmTXyE5YfGG
	 8shruhAsbpwJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC58C369A2;
	Tue,  8 Apr 2025 13:37:57 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 08 Apr 2025 08:37:49 -0500
Subject: [PATCH] dmaengine: dmatest: Don't forcibly terminate channel in
 polled mode
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-dmaengine-dmatest-poll-mode-fix-v1-1-754a446a5363@amd.com>
X-B4-Tracking: v=1; b=H4sIAKwm9WcC/x2NQQqDMBBFryKzdmBMrbZepXSh5qsDmkgiRRDvb
 uzuvbf4/6CIoIjUZAcF/DSqd0mKPKN+at0IVpucjJinlPJgu7RwozrctCFuvPp55sVb8KA7V3X
 RibH9W14lpZU1IOX/w+d7nhdJi4UBcQAAAA==
X-Change-ID: 20250403-dmaengine-dmatest-poll-mode-fix-671b02dc9084
To: Vinod Koul <vkoul@kernel.org>
Cc: =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744119476; l=1736;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=dERQxgU+2fAzNEP2+EuhPk8lfIVEWf/LdcDgr/XAkxk=;
 b=fgHl1Z3V5ne92fMnkK6WX/NUlvhrY7ftyp1iGj55T2Rey1pSPm6P7YYnXu/z/lCXzmywZO2Q/
 Za25lHutFt2BfoJWCHb5RC+THaLBzNM4f4ygDpL7fmAfPa5EliGOvRP
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Invoking dmaengine_terminate_sync() against the channel after each
submitted descriptor is strange. It's benign when the test is
single-threaded, but disruptive when multiple threads are submitting
descriptors to the channel concurrently:

  # cd /sys/module/dmatest/parameters/
  # echo 1 > polled
  # echo 2 > threads_per_chan
  # echo dma0chan0 > channel
  # echo 1 > run
...
  dmatest: Added 2 threads using dma0chan0
  dmatest: Started 2 threads using dma0chan0
  xilinx-zynqmp-dma ffa80000.dma: dma_sync_wait: timeout!
  xilinx-zynqmp-dma ffa80000.dma: dma_sync_wait: timeout!
  dmatest: dma0chan0-copy0: result #3: 'test timed out' with
    src_off=0x487 dst_off=0xf8 len=0x171b (0)
  dmatest: dma0chan0-copy1: result #6: 'test timed out' with
    src_off=0x227d dst_off=0xf99 len=0xf7a (0)

Remove the call to dmaengine_terminate_sync() from the main thread
loop.

Fixes: fb9816f9d05f ("dmaengine: dmatest: Add support for completion polling")
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/dmatest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index d891dfca358e209c9a5c2d8b49e3e539130e53e8..4e109c45fe0c5a7e8f337efe6e00e0616977f770 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -835,7 +835,6 @@ static int dmatest_func(void *data)
 
 		if (params->polled) {
 			status = dma_sync_wait(chan, cookie);
-			dmaengine_terminate_sync(chan);
 			if (status == DMA_COMPLETE)
 				done->done = true;
 		} else {

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250403-dmaengine-dmatest-poll-mode-fix-671b02dc9084

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



