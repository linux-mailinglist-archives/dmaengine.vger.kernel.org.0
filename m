Return-Path: <dmaengine+bounces-8634-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JrS7HHrdfWmlUAIAu9opvQ
	(envelope-from <dmaengine+bounces-8634-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 11:46:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE402C1996
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 11:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180193009507
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFB25D216;
	Sat, 31 Jan 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NldHvJ58"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB9183CC3
	for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769856375; cv=none; b=FJvlYc32ratWTOIEku7wayK0AN3+9E1KSvgd43GEsuzBq02J8eVfff4CyolAcVFENRoT6uT9m81RebTGeJYOJm9/8CMeSgXAkIijztavKwjARZRu0uW/NNetV1TpplsR0WNBNQ549eYhGk1aSmw1ndJ8HeRHpGmSZNT8PtRhWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769856375; c=relaxed/simple;
	bh=T98KBQx+O4FqRMY1pKOKeiVHp8TIZyEBfIqX/9VJVJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gscc2MAIQfmTz4F5gmWNdHio4Crt9lg2e4IMctgesnOUhi57CI5c5bgtRZ2yNMzIBybYZEk7wQ6wOxMOKX2nKYyGS3pCAGhu5aIyRgsu1ueguIYOBMKm8nf92Qlf2G4L+y9plBYBOKyv89lUlHjMSSs0l1EbKmJf0c2zJJUXlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NldHvJ58; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82318b640beso1633867b3a.0
        for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 02:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769856373; x=1770461173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ix3R9g1r5Rr2teTx5y0KghKmMccHbs4w/Enqp50WhyM=;
        b=NldHvJ58K97/qVq4glBx8E0dB5+BeznrEB19sIbi+1eoNw3BvMHOG4tUEI3MkuKHGq
         T0gWru1fuc/ONcc+0L4+324+EsVRDQdabhb6humgdC7h8rdzY0L2bXLcALmH1YBiw15S
         jwPrP1q53F0bsoPsupsJrFkFNxYszbGl0FvRW/JXk4FBiH0Sc1VkRvZDuGtZF8Sm2vCH
         DDXtjAZtX96w7uhZawtoh6Tumzr/RHESUsjLAz8JNA4qsFerL+yLXhrVwbvLgKt4DFw5
         DYPrOP0PYucDR7xNKFiO0JgQwrcx84v5LKV9gHgoKbEb97sqdPPJTABvEf16Ky/dYSfv
         /iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769856373; x=1770461173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix3R9g1r5Rr2teTx5y0KghKmMccHbs4w/Enqp50WhyM=;
        b=aPqK1y8sWqXgY2pbM2PGDsO1O41+HaO8JdIAXhYhsz9+TUeiCQyHPAWaq6AeSTgpAI
         qQ+bFsFDk9bBPRBS+4+9dT66U09dj6QVsEj2H9OxdlF59NrDAXjfeuJsqfKlgYVBSBPp
         Ecjav1jsh9ZAnA7nEf28oDEEVXaHjIZyxhODHBu7+3njkJ/gIJw4FBwYALCWrfCoF+k/
         H4YjyS563iG12E7CiIxOwn8vUrQFAXpmILMx9ji/CwVNHRyR7ruQI64gtg4jUIpEI7YG
         7KT1ljBcZ6xSjMOBlaUqYLMxjji0yIpA06QZdOE58eRsJaCnQTdHoDRqGGK87Goj00yQ
         El4g==
X-Forwarded-Encrypted: i=1; AJvYcCUAnj68paQ1hwHaQShHt1vBh0blLETgMMyxkCiLOVt4lVFp1p4g+l6zqSfxDPBazQ7AuVBKIRwHU3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPa0RVIO4MC66fadySMudS7xHsHnmC915wp5cS5AMQzKQbnFyV
	c34rBDyDcNOrn16w63nb1ikgHWYgf0J3AEbKvx0SEgd8+z9uH+JZb++i
X-Gm-Gg: AZuq6aLfyC0UfEEzHYWRUKMUsxMzxEWyQM17FmcQ1n+d4eXRr92SvPbfUPYhDxfij6d
	L0vSSGCg2MwiLcsh7pNB1WEmCsboUaP4dOSSQ6sfnNqaGfmdy7tknZ5RoOWn0LZfDhU39D/DJbu
	nfsA+ujCr0EJjgFlhrjPMgWmyv5tJSmfDX6M6NnA01dtc5tJZ+35Dzb0cAWggT3MJe8P1gsPLVp
	1syFn+lcsHI0g6sGiPWgHveWfpkvxvPR+Lcc4ShXFsXa1GAqmXAZX+IUQDzjnYBAN1Y/5Q/6KIl
	XDha8Iz3+sn26dLO639mPCeYWHH+dhgRnb6NSYoU49KdWi3BQ4Y7aTpxo6/GNW+/s672TOb3d0w
	mOBO34wfOrZB90cCa8K1tiPuLLmbZ2dXZa6HzkLdrCqZc/PJ1TRPc8FeAAMvfy+O04FGcH0lzih
	Xmm5ND78ojcXdHJL6f8+GGKWXGVAMtpyc1P4k=
X-Received: by 2002:a05:6a00:a804:b0:823:c41:a019 with SMTP id d2e1a72fcca58-823aa440443mr5824615b3a.22.1769856373367;
        Sat, 31 Jan 2026 02:46:13 -0800 (PST)
Received: from localhost.localdomain ([171.88.165.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c21112sm10301462b3a.54.2026.01.31.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 02:46:12 -0800 (PST)
From: Shi-Shenghui <ssh.mediatek@gmail.com>
X-Google-Original-From: Shi-Shenghui <brody.shi@m2semi.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brody.shi@m2semi.com,
	kevin.song@m2semi.com,
	qixiang.zhong@m2semi.com,
	tom.hu@m2semi.com,
	richard.yang@m2semi.com
Subject: [PATCH v3] dmaengine: dw-edma: fix MSI data programming for multi-IRQ case
Date: Sat, 31 Jan 2026 18:45:50 +0800
Message-ID: <20260131104550.1088-1-brody.shi@m2semi.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sshmediatek@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8634-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE402C1996
X-Rspamd-Action: no action

From: Shenghui Shi <brody.shi@m2semi.com>

When using MSI (not MSI-X) with multiple IRQs, the MSI data value
must be unique per vector to ensure correct interrupt delivery.
Currently, the driver fails to increment the MSI data per vector,
causing interrupts to be misrouted.

Fix this by caching the base MSI data and adjusting each vector's
data accordingly during IRQ setup.

This issue was reproduced and tested on:
- Device: [20e0:2502] (rev 01)
- Kernel: 6.8.0-90-generic

Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")

Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..2b2a59fec053 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -844,11 +844,13 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct device *dev = dw->chip->dev;
+	struct msi_desc *msi_desc;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
 	u32 ch_cnt;
 	int irq;
+	bool is_msix = false;
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
@@ -895,9 +897,13 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 					  &dw->irq[i]);
 			if (err)
 				goto err_irq_free;
-
-			if (irq_get_msi_desc(irq))
+			msi_desc = irq_get_msi_desc(irq);
+			if (msi_desc) {
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+				is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
+				if (!is_msix && i > 0)
+					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
+			}
 		}
 
 		dw->nr_irqs = i;
-- 
2.49.0.windows.1


