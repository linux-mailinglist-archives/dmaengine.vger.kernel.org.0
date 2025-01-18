Return-Path: <dmaengine+bounces-4154-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9FA15DC1
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8024E7A27C7
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AE919D8A8;
	Sat, 18 Jan 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Q8WTaNd9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67718FDC2;
	Sat, 18 Jan 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215485; cv=none; b=unREKZa2cUOsa5rF7aI9r3lNxnMK5ovGSfAvJJC1B7nF3BS6Xl/vSiVVMbswIbWElXXGw6xQfh+ku6iOnQbRzoifvpJzHtLGbIw+wdJ3ZX68dl5jyXfGYluN04OBdRTgnherx51yYuPh3/h1xJWsWqXznxQ2wG6SSUpzfV3sJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215485; c=relaxed/simple;
	bh=R5a5YYjvbT3FLrTzU848q8G3+Avt1t/uTKvt8dKZ/Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOe73bmqZtXsXh7ShQxGfpygnVOO5llQTDKlEl5Ps8o295Ss7SHGt5K3tLIB0limu0pezGe7o3Yr8vmTfoA2PciNGfQ9du+GqAIv4a0A1EEfD0ZTTQdHNVAoa5KBuhGNfcatnRBmPpObiEqfrImcC5DO1g4fMFeKfWtyQKNZCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Q8WTaNd9; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ZB6MtxSpjzpxCZB6XtMt6o; Sat, 18 Jan 2025 16:51:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737215481;
	bh=Y2PuTFcztnweCTbiTYGMA0jecL5NxU2/H9dx67Jv4Sc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Q8WTaNd9dfLy5Y5HwRBdsBfVeFj3Jj+MUq3iWEgcPqNY6RD5l8mB8p77O2Bu/vjRt
	 IKgxvVGm8k1m4f4wXfB+kUvjAKAo4XhkVSaeD5NjsJzzzTN1WAtrCg22OsfH+/uXaC
	 3sMfC+rNs15sXcAVmbKyod20YKxSbbvZlUvK04BV+8DyEaxp7a2/LNHe2I+5m8nCXm
	 2q5uuCIxRSH1Vigu/JJBTkn2Ni65yCYNiVdEcdaIPCltxOFlb4KfYgJEYcgHQMOGw5
	 U+QMTwu0znubSkjRjyFfIco65A9LSF1IgAmOwRlGfa5zcJkq1TQX5bqB5PUsB4lHk1
	 qDfkDKMmzXY2Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Jan 2025 16:51:21 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dmaengine@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: ptdma: Remove some dead code in pt_pci_remove()
Date: Sat, 18 Jan 2025 16:51:03 +0100
Message-ID: <aa06e8316eb36342ba36e01bf74ab469415b80e5.1737215423.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ae19d76a10773d6ebee0e08cef49786eb20fd052.1737215423.git.christophe.jaillet@wanadoo.fr>
References: <ae19d76a10773d6ebee0e08cef49786eb20fd052.1737215423.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'pt' can't be NULL when pt_pci_remove() is called. So remove a useless
test and save a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/dma/amd/ptdma/ptdma-pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/ptdma-pci.c
index b25b6f7618c3..25ad61265565 100644
--- a/drivers/dma/amd/ptdma/ptdma-pci.c
+++ b/drivers/dma/amd/ptdma/ptdma-pci.c
@@ -209,9 +209,6 @@ static void pt_pci_remove(struct pci_dev *pdev)
 	struct device *dev = &pdev->dev;
 	struct pt_device *pt = dev_get_drvdata(dev);
 
-	if (!pt)
-		return;
-
 	if (pt->dev_vdata)
 		pt_core_destroy(pt);
 
-- 
2.48.1


