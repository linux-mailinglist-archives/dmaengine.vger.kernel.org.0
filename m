Return-Path: <dmaengine+bounces-4530-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D6DA3BC1C
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 11:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C03B50B4
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E081CD210;
	Wed, 19 Feb 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aoCVcZl4"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104461D5142;
	Wed, 19 Feb 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962477; cv=none; b=uvYYDlDsg0yfbtKphb3MGOYyyJUuhcLmOaf2Y1F6iSgQKTKMx7Cn2d5/mABiw7mQ4097584AdPxXGmyPgk0Jsceq32hQpbjQhiF3zbti+P7v57O/fT51wSMa8W+aQLEWPAMH2B4x8PLQV+nk4QwRrnjgd3mfbsVvMuqzm+rLErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962477; c=relaxed/simple;
	bh=m/u7M39ivXqj7Jq/6rCvAE8BnBXopuT7Jjr+JcepCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CakeWGZOmqm99CYRT0XP8l0+j2Ydhwf55BJR/KyrGWjVRxBmMbaRKPx3uZSL4urAnbUuMsJlfx054YMf+Pkl17cVK7MTR0jjtJ74MspKMCQ/VhURdo5u3L5uYdWVVnqnGIQsFYALWKrIuo3qwBMZEeo8y8tVU+13qhtKbidOIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aoCVcZl4; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739962472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T8J1PsZyRoDRpxk/eEDn0T9wcQpmCgYNz2QyDJPcKSk=;
	b=aoCVcZl4tLAtyFgZik2vObLbD3lbrZLRWwhY4SRIHlULmHmwyJ2jQTXJpHPgIU74AmJaHE
	hskmABiUhh1vc7CeuqHF66VypJDTbccn35zwp/xtHCU7b1/vLTVl/d8RbQkFf/ta5BZWFx
	YwEA/iyaP4d19h4IdVclPAtfZCcEIP0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vinod Koul <vkoul@kernel.org>,
	Yan Zhen <yanzhen@vivo.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] dmaengine: Fix typo in comment
Date: Wed, 19 Feb 2025 11:54:17 +0100
Message-ID: <20250219105419.2025-2-thorsten.blum@linux.dev>
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


