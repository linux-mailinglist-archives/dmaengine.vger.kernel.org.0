Return-Path: <dmaengine+bounces-853-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739CD840B4E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A491F23F74
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8F156985;
	Mon, 29 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k5GrHF+/"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5E156960;
	Mon, 29 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545571; cv=none; b=h7aECX0kOWG6dvsHMGxPLypHfbswFU3uOZvTyrJWknO1p5FvUFfs5JNrwVuJDym+uldO8Jv0bmNTyfM+ZR+Xobityl/7hWZRbxh0ic+Lt7PkTI+tbyiq+dSFc7qReOVj1xAuFYd2+nBmrdF930OuEpfKRJOyJJFmX9CF3ilRf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545571; c=relaxed/simple;
	bh=QRCYGQMJR35x7Hogymwk07ORHyYx6BkNlkL42bEP7sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8oFzBBOLqi3wZTHNd4i8Vi4uzE54YsTbBRiRYJGUNcZ2hhAa3W4634EgqhWem5xxuW4AuHs8uyGeK4D9E9HqKut48tNslifdqBrUNHuXmoeBfuSHxzPQzQe3qicBtzD8B0c599hzF31i7N2xl1CXZr2MXw7Cyy/3NJa6/3J0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k5GrHF+/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 182D8E0010;
	Mon, 29 Jan 2024 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706545567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cl2LjMo9y4kvfDVQJV3DM0tMK1TINYKcgigqy6Qohec=;
	b=k5GrHF+/cE2YcEU+sP/ZTqdhcWth22NgGjZKNYsBFnWS/VdP0SRYxEmA0wDLWXAVPK2Cve
	br/QlNjk3a09/RA2WAjt2vrxplIjdT51/24S1d0MfNKe6h1pcm/zI1xIDeccSAyOSihSht
	7zycuWtRCJ+vGt9A4uUAVQKBQboajZRqgEi0ix1BCX+/uCAKMsOwJIdFE91izfxoG99Aow
	IoXb6QxhNjgQE+uWehybms87oNF9UbyaKRLc/ITeSY2M/beZCQGNFddZIYntp/y00rb/fH
	SyZ80LWWLklTzYLdA4brhu48wFtND9xw9WUhcpHVC8/ctblqHNzDCB/PELotiQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 29 Jan 2024 17:25:59 +0100
Subject: [PATCH v7 3/6] dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN
 typo fix
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-b4-feature_hdma_mainline-v7-3-8e8c1acb7a46@bootlin.com>
References: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
In-Reply-To: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Cai Huoqing <cai.huoqing@linux.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Split the patch in two to differ bug fix and simple harmless typo.

Changes in v6:
- Mention the typo in the subject.
---
 drivers/dma/dw-edma/dw-hdma-v0-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index a974abdf8aaf..eab5fd7177e5 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -15,7 +15,7 @@
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
-#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
+#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
 #define HDMA_V0_ABORT_INT_MASK			BIT(2)
 #define HDMA_V0_STOP_INT_MASK			BIT(0)
 #define HDMA_V0_LINKLIST_EN			BIT(0)

-- 
2.25.1


