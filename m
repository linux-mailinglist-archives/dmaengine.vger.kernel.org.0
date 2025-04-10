Return-Path: <dmaengine+bounces-4868-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0FA84156
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28711B684F3
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9F21B9C7;
	Thu, 10 Apr 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbsuFixN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F4204698;
	Thu, 10 Apr 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282978; cv=none; b=fp8GsXKuiMpa2Wud6qLmMT9I/rit+rOBrXaD/mGuP3Udq2b9N8KaUvIiOQs+fSfoL58I0R5Og8H4vIM5vjjmYUOyt4Mau51FNQU0SgjtVY1MYXj/GYDjqmiJXX4hvYCnKdGTGQz8hHJ/aj9pGVAarRElhTOm85+oN5oEzmMcnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282978; c=relaxed/simple;
	bh=UA3DSo1t0OoUhTnRebLiPKD5Mi59RzdGtxeZEI6WkZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1yULAXabD9zl3fwBJA9tXGTkfYZSqINqGJz/eO1GDV9Mpu6+H99oGuYQdK4qpcasTvdIIPvgyikZeOIvPWLJb+ClnSd/e09UNW21h5/1vRctT4dLfz9MRzCOp0fpS9+MR8eeyNiSR+e4RUtHx74llW1KPd9CkVQMF7Psb13O8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbsuFixN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227cf12df27so5333975ad.0;
        Thu, 10 Apr 2025 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744282975; x=1744887775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8//Q+ZwGqeGDbai/09eGtdmF0g+HDkosJAckzGqILE=;
        b=dbsuFixNNYJG2nD2b141HZFxKlY4kYEtOtqg4u8AlFJFtbwaKIQQ27O8/p44wjAWvd
         3pjmDuXjLHpe5HJ3ABbAsS/2dD63iFhr86KUO7ouKSWop64I1TeWvOqQp1Wn7dyeCp+f
         7o8M4vZmMEDRkXWCBh79REFg6SdpuUVL8a52nvOuJehMooGblp8+Vww7YJEmToEx7Qlb
         /jHyEIPQ1AKrlcSlL3sxr8CwnaDEkEYJglhX1b8t2JDjluiOgoemyEONEkwkyo7eqKE4
         y/peABIX9J8BBq0o3Ktpv7rSPwQP84C1q8l2CPqYyZFBDdUN0botbZwH8/c/NMaF90Yf
         cCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744282975; x=1744887775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8//Q+ZwGqeGDbai/09eGtdmF0g+HDkosJAckzGqILE=;
        b=ePB58XzqbsEhqyMLabtqBHo9ZJK5KNN5UAQFKvP2MtRetdi3hmkpTfOKeilPwIyj6V
         LKeOmuiFEBg4eWkKabKKwNFFqG7gBC89KSIT3YQpHpRoE3o7R8LqyovLzhjZaSkYDHiy
         n9He7yO2fRxmIGwRahAYFQLFgrT9sWfBb//QvoaKAl8aHPi6R8dPowWlKxUs+5XiwGK1
         O3rNLbb7hkrRaIgBBHy91JzdnT5kKcO+Ba2cFgaOL/3cbsIkjWLQioxxtk2eGWvG/C9s
         Wg7LrJNan5P+m7+RT9JWW7uMogArMDq37NB5Lz5LwR65EhaHpwjXEY5G2M+XYF/QR5KQ
         cqig==
X-Forwarded-Encrypted: i=1; AJvYcCXZiIQ5/KTj39zjcg/5JTIIp8I52X4Y6gzgfOls/eTDaINCbkUSnAY78Wu39bqZWCnZOp8UHRhoMww7RFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrkUSrBR7BLsHddHt1UGNuyP2s7aGhNqv2BWAufivNvod6yJD
	zScT2zRRZbjW7xA625YdMvGYxOa5sZInImSl0eXLH0ikNsHylm2Vj8n+JpkI
X-Gm-Gg: ASbGncveDBMcSvuflpFYuaajRKc3G3vU7XnaIJx9pXaw8t1faVNXttXWQgP7JK7u006
	+Kvz9lMcAViPFUIBkqtfwxUYhRyuqT7AZ/mp2bOCklt1Uw09fCvAPz/RQ3Qh0tPlja/z9aIfLKr
	YPgjrIFPW7ncqjy7gwOmrgPWT33/gQTXofI+Es2ZFATXrjPpu9wQ0dlGl7AQ+OQiAKSAZdlHn7P
	DtkgOUlYeiptx0KzdDlTvM4TK9eYwX0LPglGO5of30oUfhTPy7v4McSngX+Tt5Nj7c0vMorROKV
	re8OkcO43QxWjQuILsRJ0q2ok3W86O/X4Lk4OzAQYVH6x5GNKXNb2+1kQ2kDrAQA3pjKZ6l5WA=
	=
X-Google-Smtp-Source: AGHT+IGQVX1ZDwzDAhrKBcKIcXXaW38B3BULFX+faGVidZeMEJOUVtVfROvzvWQFL7k/PH7bKu6iIQ==
X-Received: by 2002:a17:903:1ab0:b0:224:3610:bef4 with SMTP id d9443c01a7336-22b7f9221a9mr38526515ad.25.1744282974589;
        Thu, 10 Apr 2025 04:02:54 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:204:a537:5da0:ac0c:6934:f07])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62bb1sm27672835ad.33.2025.04.10.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:02:54 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] dma: idxd: cdev: Fix uninitialized use of sva in idxd_cdev_open
Date: Thu, 10 Apr 2025 16:32:16 +0530
Message-Id: <20250410110216.21592-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected issue:
drivers/dma/idxd/cdev.c:321 idxd_cdev_open() error:
uninitialized symbol 'sva'.

'sva' pointer may be used uninitialized in error handling paths.
Specifically, if PASID support is enabled and iommu_sva_bind_device()
returns an error, the code jumps to the cleanup label and attempts to
call iommu_sva_unbind_device(sva) without ensuring that sva was
successfully assigned. This triggers a Smatch warning about an
uninitialized symbol.

Initialize sva to NULL at declaration and add a check using
IS_ERR_OR_NULL() before unbinding the device. This ensures the
function does not use an invalid or uninitialized pointer during
cleanup.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/dma/idxd/cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff94ee892339..7bd031a60894 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -222,7 +222,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_wq *wq;
 	struct device *dev, *fdev;
 	int rc = 0;
-	struct iommu_sva *sva;
+	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
 
@@ -317,7 +317,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
 failed_get_pasid:
-	if (device_user_pasid_enabled(idxd))
+	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
 		iommu_sva_unbind_device(sva);
 failed:
 	mutex_unlock(&wq->wq_lock);
-- 
2.34.1


