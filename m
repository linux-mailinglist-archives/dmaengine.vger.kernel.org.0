Return-Path: <dmaengine+bounces-3997-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC899F4024
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 02:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A769E1886528
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7FF9FE;
	Tue, 17 Dec 2024 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="K7vlNsYq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED44A3E
	for <dmaengine@vger.kernel.org>; Tue, 17 Dec 2024 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399738; cv=none; b=SH15VdmN6/kRDybRRXgSlE+SKHmO3A6qejGC2n8l7NNme+8dWh3HAdByG3NwuOtGUqsFl230acfznrSGWu+U1B9buvU7/DczKGloohwWUzlu8AEDK93QKngAGEnJYeHQm4dSebwe2VOS7fsI53P+sJAciLJXpr9mi8bxQnuUhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399738; c=relaxed/simple;
	bh=+RMK97pkibjxeGKNxS9uInT8DNmOih72azs6TkyMQvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5h5WnW5zgQtl/5UBC/PHcvIy6VlBCYzPqSKjnybkuEvOSVjCSDvb7AZa8Kpau8cSYV/ayuNmmlbwUXbhBpGmIeBvpIpQYiG6tMKMmmAt/atTdAyZG4Cw51A99PbIuIQyMuxxdTckUa8XxjLeQpvAbdt9ztA390BpMiYuMO36bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=K7vlNsYq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725dac69699so4086379b3a.0
        for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 17:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734399735; x=1735004535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cysaRI62Xvh1TCOgEg3Oh+qKNjvQ33Ew3Va4OL3l78I=;
        b=K7vlNsYqbNQDVEQor929WMNTdtCMHDNb/2S+zD8ItewuA1VqjT39A8Mkb3YB0Dejlm
         xoF8L+CgEhCZBBxpFyk6BUgfT9qbyM292Ua146c5bdDISYNySOG/eyniqTgusg24K3rM
         5YN0yzeWzqCaIRcMOkYZs5nQkHOKomCiPgl2WMmqoAlZr9PBCpP5Uc1bGutZAkFpZ6WN
         60iWROLEFkJqaFFVEib8fJZ8lF5cS6S66JxBBFiKVyH/o+1XNgI/3yvFy7XAlop5UWG4
         HJqBZAy3Cy6v6DtNwSJ6Egjn9otb24+J9Mxfz2/uQfxGraU3ysux+p8NF/OV/Qy3ZqNN
         pgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734399735; x=1735004535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cysaRI62Xvh1TCOgEg3Oh+qKNjvQ33Ew3Va4OL3l78I=;
        b=JfjJS5WHEpm4DRR6u6fed6MARyvlUFXJhv1H6BBfSJ4hZNawOzefBPYnMgR8dxbiJb
         RjgMOQuZoGt2Ssrh9LXa/WPCQIU8Np1o0/YtiWe8UToEOgXMU9DFTSXSXIzw6uiYKuvW
         78fiwzmqCWmadhMvPieIg0FV3DCfps2B2mIFbLrco/YjDEFcsSZT/DgnHZfq071SA9zF
         OVI69zPrlL4dhx2j0KrEIit9Tym5BuOS864QU+Nwogu6nlOHM1DLCWh/RWcguggbvtqz
         2mNuV2LYWTAa+AgdffR93aw7Y/ikOVxdQmzVv7zKkDzHzPbWGuf4y4guNupdq6DeqsTw
         kXyQ==
X-Gm-Message-State: AOJu0YxmrZjoUfkCubTmhTFy/kAoRZ1K2kcnAMD+Uyj3lLVeq14xwTQE
	SMkNbghS2Wal2M2/ZIGCXvm+kU5sjOaS3sjOxZ2Uqw5bxC9eCQ9I1SaNh1wEV6mWkPJ2mJSxrqK
	/7CX3yw==
X-Gm-Gg: ASbGncvozHH2TPziRhxeERKs/KeszM4PRrHG4FyjoQSzW/67GaAElF19uniRN2lKe9y
	ArcFFlRoxynXuMmGiEJEZkSuk9kJsyVexnJw8LUzMdK/SH7VMiWEhB7Q2ixWhuyJc1JVGjLT3C0
	fZDjnh8CWoEAYTgTgzqSLy+CeSzApKRHf5phU8ORnLw+Wrndo3s/t/Q+o9PKdhWTSqnlOWdL2Th
	1Hhu65w41qqaOSzdt1vl37Kft/3bvc1YRFZGFmlpCQQnA3NljJ3o3cDVd8IXQYKZDzO+BOKsVhL
	o7YL1goMe+aU+kQToOrANkbVrIHoFoQeklk3XEORN8I=
X-Google-Smtp-Source: AGHT+IEjyn3zm7zW6W5f9/t7ysiV/MZb/QxXDkJIwaRv2bI2NoqHZUHpAX5PX16J8qmwhp2BrOMHtg==
X-Received: by 2002:a05:6a00:b46:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-7290c2700efmr21092289b3a.22.1734399734696;
        Mon, 16 Dec 2024 17:42:14 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78992sm5422032b3a.111.2024.12.16.17.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 17:42:14 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] dmaengine: bcm-sba-raid: fix a device reference leak
Date: Tue, 17 Dec 2024 10:42:09 +0900
Message-Id: <20241217014209.1664228-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBA RAID driver leaks a device reference as it does not release the
reference obtained by of_find_device_by_node(). Add a put_device() call
in the error path of the .probe() and in the .remove() to fix this.

This bug was detected by an experimental static analysis tool that I am
developing.

Fixes: 743e1c8ffe4e ("dmaengine: Add Broadcom SBA RAID driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/dma/bcm-sba-raid.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 7f0e76439ce5..e3b34a90df02 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1699,7 +1699,7 @@ static int sba_probe(struct platform_device *pdev)
 	/* Prealloc channel resource */
 	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
-		goto fail_free_mchan;
+		goto fail_put_mbox_pdev;
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
@@ -1729,6 +1729,8 @@ static int sba_probe(struct platform_device *pdev)
 fail_free_resources:
 	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
+fail_put_mbox_pdev:
+	put_device(sba->mbox_dev);
 fail_free_mchan:
 	mbox_free_channel(sba->mchan);
 	return ret;
@@ -1744,6 +1746,8 @@ static void sba_remove(struct platform_device *pdev)
 
 	sba_freeup_channel_resources(sba);
 
+	put_device(sba->mbox_dev);
+
 	mbox_free_channel(sba->mchan);
 }
 
-- 
2.34.1


