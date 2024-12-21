Return-Path: <dmaengine+bounces-4052-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442E9FA0F0
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59D1167D02
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464B1F239D;
	Sat, 21 Dec 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ddhqqG75"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F951BF37;
	Sat, 21 Dec 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734790606; cv=none; b=fZRkrOv/9UVlr1Lw6FGFjVfnEPb/YhLypeLEKGtmfKsC9dUbNOst82fFoV0PKaIntOmuCnuDOFcBN4fyPONwxFCzxQk1NtVa4AbJujySmEckXfENLmnaqxLypOzsN2SbNHQ5yjsoF0t9dx0VShBccGMeUB+zFJRnYdyRI2nU5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734790606; c=relaxed/simple;
	bh=XDVePT0/V4cifDxVRU85sJOWz3M//1TZZSGlfbbvSGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhH5pcTknKmKIGeOIwdDavbItT5E7Gdxwunuq0Q741CbU4cc9jrs0yE6wj9tvPd/U2Aj9KiGR+wGQ50xc/QKp9nzB+0AUW+ZZsmQSUNLOTUqTmHmshDOOaABg1927ryioIDZCYODLRxcXW0rus31XhQ1lGGMuHHds4OV1o9cTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ddhqqG75; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=bOVHqRWBDVWFBrWBYmBz1NWs/KAwmM7nObbTp8toJog=; b=ddhqqG75JwKpkAGQ
	xSKdMl5W0ckVfqufLbRng7BFJE0W0QIKFLA+A50xlEzadpknkm0t+iE3IovcWPJ3ZxQGMDcZYhq53
	pmkzG03va4NCMKCh7NUAB4sTGQZDzd+J9U+h+RCwSgXKsT/9GuqTA0s1gEkhImRQkZjNyvcpda7x8
	lMeGzvgIdMuUpaTJaAxykQflVOwp60jHR6sgu8OXLQf7ktg6n13bYriEVIppUN3jDF6nPMZUGPcu1
	yazCAQfRNp1iR7IxHoJrEB7dSaVZxC2SyXo9czZQR3BFUMUesWrS36FSmufcg/GU1UGCl2T4hew7u
	bO+gVQWWixBNdCjQzw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP0HV-006g8m-1R;
	Sat, 21 Dec 2024 14:16:37 +0000
From: linux@treblig.org
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] dmaengine: idxd: Remove unused idxd_(un)register_bus_type
Date: Sat, 21 Dec 2024 14:16:35 +0000
Message-ID: <20241221141635.69412-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

idxd_register_bus_type() and idxd_unregister_bus_type() have been unused
since 2021's
commit d9e5481fca74 ("dmaengine: dsa: move dsa_bus_type out of idxd driver
to standalone")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/dma/idxd/idxd.h  |  2 --
 drivers/dma/idxd/sysfs.c | 10 ----------
 2 files changed, 12 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d84e21daa991..ff33ebf08ee7 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -725,8 +725,6 @@ static inline void idxd_desc_complete(struct idxd_desc *desc,
 				   &desc->txd, &status);
 }
 
-int idxd_register_bus_type(void);
-void idxd_unregister_bus_type(void);
 int idxd_register_devices(struct idxd_device *idxd);
 void idxd_unregister_devices(struct idxd_device *idxd);
 void idxd_wqs_quiesce(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index f706eae0e76b..6af493f6ba77 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1979,13 +1979,3 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 		device_unregister(group_confdev(group));
 	}
 }
-
-int idxd_register_bus_type(void)
-{
-	return bus_register(&dsa_bus_type);
-}
-
-void idxd_unregister_bus_type(void)
-{
-	bus_unregister(&dsa_bus_type);
-}
-- 
2.47.1


