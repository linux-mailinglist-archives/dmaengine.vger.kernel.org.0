Return-Path: <dmaengine+bounces-1809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B8C89FDAB
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA9D281EB2
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C917F38C;
	Wed, 10 Apr 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq+SPgKM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483B17F38B;
	Wed, 10 Apr 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768609; cv=none; b=bx3aKPd7Ul1j4h1Bz2/BeUFtdQeBE+DYpp7z1z0r3pHMloUmEK4alwdvdwJQWQQ39L1SK6iCwslZ4pt2DjiXNhpi3t7LzFkD/Bjbi78+QlshC17neHxB97ag6uJ9KFjD1vlyfxQnNuvj7MWt8qGOcP/R2RRyZyAMk/m/adkvytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768609; c=relaxed/simple;
	bh=FiRA/vXhDO0Yg70Ugqf0/Tw8tnULt1mP1tGOaO9ccD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzJcTEPt05MrZQh4ZHyzK7B2pMCigqW1WvAdHA8LzeycPujSAKRhvtg+u1vyMimYevjguMz0DQbFWYgNyWZfubGMxaqFnXwJhtM4rtoQGFZW3vj5dAXC2pFJ0HRDpPGoWjxdcdqOERDdyEuxL+i6n5vyxDOT05tAODiC9zN+6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq+SPgKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE4EC433C7;
	Wed, 10 Apr 2024 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768609;
	bh=FiRA/vXhDO0Yg70Ugqf0/Tw8tnULt1mP1tGOaO9ccD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tq+SPgKMT/Zk1F6cnminApHrZYG6gcr/DCYJILj7bCiqELE5ymIbKPSAJZWy0UE+Z
	 Y8N9DbO0vSuCncTBlg2jCBe3m1BLM0gqom0fhDLsEkbcGZeRZJ1ZF1kt2tkhNdsEku
	 SllCJaSXyv4DMEYoFdcZCsxcuN62pFYTdgYEZ04sYGB2a4F+SOWjWQVDBeG23T+7GP
	 AN9ToNJFFVR2NMzrg/Q/4lEUNrQjEp8Y9P744BO5PEs0PdNHm07pbbZ2V//OqWg6Yv
	 dnOl1EHW+YD/BILXZsrX63kbwycDgVAuXXIg4zQD0l57Q52O2P5iEnHqVv5b87EW+x
	 rpeSsYrcSbgVQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] dmaengine: xilinx: xdma: fix module autoloading
Date: Wed, 10 Apr 2024 19:03:17 +0200
Message-Id: <20240410170317.248715-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410170317.248715-1-krzk@kernel.org>
References: <20240410170317.248715-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/xilinx/xdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 170017ff2aad..36e3f84a31fc 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1295,6 +1295,7 @@ static const struct platform_device_id xdma_id_table[] = {
 	{ "xdma", 0},
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, xdma_id_table);
 
 static struct platform_driver xdma_driver = {
 	.driver		= {
-- 
2.34.1


