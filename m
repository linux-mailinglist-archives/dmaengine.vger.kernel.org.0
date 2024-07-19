Return-Path: <dmaengine+bounces-2720-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E3937697
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jul 2024 12:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B511F22230
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jul 2024 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4A38286F;
	Fri, 19 Jul 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYw1wIAO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421457E0E8;
	Fri, 19 Jul 2024 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384606; cv=none; b=c+8xEe31z+5yexKH+a1gix9BUBKkGCES/3fGnmOoENmzmhFkkkf6UH7Y6MeqNrOzZDRzmJA924NhxIDWERzoQgalY0PbK1WyYPTfcq/dVVCTo/zn6owNWBQ5dKwU+PUe6uScHTiXta+z04gGuOuT5x8lX9yLfCrwQS2BWuIPw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384606; c=relaxed/simple;
	bh=X3Y0SXikaGimQjrn+Q73ANiF++7CpWCqYLupVn6VVT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SII7rvJYUm9cXhyJmhtBrbcCnYRL5fbBaLhmziTy/gdfrxvew8fsKvPWnyO1TDZPMK4Kc/krtWtlH2Rz4JBO9+u27DlRwUDskceIElwlCGgV397DbIQm4Rp72e3n3TwUb62s9hGUm3/uAcf7lZoKK5OuVUImJr7QYk3Nve7FbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYw1wIAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD0EC32782;
	Fri, 19 Jul 2024 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721384603;
	bh=X3Y0SXikaGimQjrn+Q73ANiF++7CpWCqYLupVn6VVT4=;
	h=From:To:Cc:Subject:Date:From;
	b=eYw1wIAO5R/6/5i/KLOmLn3ntcn853suxbFQcCc0V2pPii8cQLTakyojUgabJtfFs
	 f/3A0xxEGulxgKDSCaOvKMOEaCuQtyCxsy3Qs3wdph4KtCcvjs1N7xEBvUuyKLesIL
	 JFLHJCCiA/dey61CbGnKiaKKIYCfPzDoOSsO2a71KQ8lLOJfpJIwiNgCeAirOYbSXM
	 NKRnj/79NUO5K6llLldI+W5/GRsD8ypFS3Co8VffzfPygFwdpkUMlGsOZHrE8mZaY+
	 Wd145Jx5tIsUHL4eOb9SLAJ9YXGEy144RHRSWH4BdTep0lz0Vi0OKvO9wvP6gViZqP
	 DdtH/Ycw+4p+w==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: avoid non-constant format string
Date: Fri, 19 Jul 2024 12:23:12 +0200
Message-Id: <20240719102319.546622-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using an arbitrary string as a printf-style format can be a security
problem if that string contains % characters, as the optionalal
-Wformat-security flag points out:

drivers/dma/dmaengine.c: In function '__dma_async_device_channel_register':
drivers/dma/dmaengine.c:1073:17: error: format not a string literal and no format arguments [-Werror=format-security]
 1073 |                 dev_set_name(&chan->dev->device, name);
      |                 ^~~~~~~~~~~~

Change this newly added instance to use "%s" as the format instead to
pass the actual name.

Fixes: 10b8e0fd3f72 ("dmaengine: add channel device name to channel registration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c380a4dda77a..c1357d7f3dc6 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1070,7 +1070,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	if (!name)
 		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
-		dev_set_name(&chan->dev->device, name);
+		dev_set_name(&chan->dev->device, "%s", name);
 	rc = device_register(&chan->dev->device);
 	if (rc)
 		goto err_out_ida;
-- 
2.39.2


