Return-Path: <dmaengine+bounces-4429-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE27A32516
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB4B16185B
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D320A5EE;
	Wed, 12 Feb 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QmhQdlNx"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119C2046A6
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360082; cv=none; b=jZKNXykIeonzxtUIQQKWTLMKCKOb/Gg9KXNwfx1M0DiNNzhJTNg9i9DuxnLe3WBIHZxtqamHXXc1BiL4LSGLVRtzY1Twrs7IkbPGjsheUekJcdIdVzIvY5TlKBpC8zckSUYAPephMY/6hfgDO1nom0KFDY3wnmpxtkWiAHOZrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360082; c=relaxed/simple;
	bh=m/u7M39ivXqj7Jq/6rCvAE8BnBXopuT7Jjr+JcepCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwI9yOJwfeKLHEBbSQE3DHFagM6tbeRmYc9wAIbb3Qz4oGLO1mLr96jPp0vp8CKT9om7b2rpE/j+LPk8QuzcAYeTFjSwbu9oF6oXYBIrVvjMLq3ahRcGkIv4fJANY64fUYexSp+OYofbs0L3LhCFexbxJLs0PbFtTKy+YY2oa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QmhQdlNx; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739360078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T8J1PsZyRoDRpxk/eEDn0T9wcQpmCgYNz2QyDJPcKSk=;
	b=QmhQdlNxoJ2lE8L2kDoIMsn7gmsxsvGX2CLrg9xdu7pHbtpGR4DLq4lvNyDOEQ+zjOqJtA
	7jOpSd16NoMG4hvf9q46ga4aFVBzCMkDqf80ThWOrVDRWr4P0UTwSQEcwEb6OwXSPdOjmw
	eiDadk7p7IZXEOpWvFLw0GtGfdWzja0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vinod Koul <vkoul@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: Fix typo in comment
Date: Wed, 12 Feb 2025 12:34:10 +0100
Message-ID: <20250212113414.45357-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/consumer/consume/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/dma/sh/shdma-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index fdd41e1c2263..6b4fce453c85 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -725,7 +725,7 @@ static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 	slave_addr = ops->slave_addr(schan);
 
 	/*
-	 * Allocate the sg list dynamically as it would consumer too much stack
+	 * Allocate the sg list dynamically as it would consume too much stack
 	 * space.
 	 */
 	sgl = kmalloc_array(sg_len, sizeof(*sgl), GFP_KERNEL);
-- 
2.48.1


