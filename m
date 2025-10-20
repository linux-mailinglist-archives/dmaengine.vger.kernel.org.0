Return-Path: <dmaengine+bounces-6886-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F1BF2985
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F25CF342DEF
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF619F115;
	Mon, 20 Oct 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8OVx+yA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAF1D6187
	for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979868; cv=none; b=F7T2mSMquLx8qfnhJYOgeSeVgrDGzrFYqTgNhfsSvKjVYK/jI8796qQy57BTLt7rKsKbWcmKIrSzI3EycR4k8sqJYRF1y+9BxXnKH5zbCLmFzskWkHkmatAv1F9NCmmLFCVMEkFMWcV2o55OwFcXbzyBEgS6QzRlM+Mc69rRLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979868; c=relaxed/simple;
	bh=XhOlz3kAPdUF9bGBRZ6c+cMdoaaBjrW9asgz0NHPSdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khTNgZcpkpyDxnKKLDUIzNVRuAQURx7pwJz5CXXXBlxDEHLnM2D4Oy5X8+3Zb8h9DgrBRpYTLzsk4wRuuxPkpMG28aj83UGyNMUB45D9/Ipk3dL1gw4Ho7JKnVFl4VjnUbFA8xweadbRNay1v/R6OIvFLZo7mKCIOCnL7Tn2VSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8OVx+yA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26e68904f0eso45705925ad.0
        for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979866; x=1761584666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WppCDBBiFkCvhQW1KO9eTwckbkeMfZO3ylMtK0PiG6g=;
        b=G8OVx+yAI+LqWhpefmn+gOMLS2zZ2kUfgNUC4nNTSGFoK1Is1fjMLO7NwWi8kl07GG
         s3FFQRN4ooLJ984Ce7HspZcRk60nH6fQ+MntK0FlJGca2udNwXqnD65iUIof5eohkMw0
         DDx6BsNxIe31ZIouJE8EkzsxYpPmgLhbCyc8tqPksSZRLlHwqDDzTopaitXBkPvjpTAN
         WNGphD9DOsupxb0oIs2U/i6YV9Srk8UfzvzukWz8Sp7eXMuSQ4YlnNo9fneaFEo4kJ+E
         pBJvizHXagrO5SgAmGhBDq6F8dfvSTONzbG3+wAfHy5xNUKQaCiJPN69BLY3a2ILgEs+
         z8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979866; x=1761584666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WppCDBBiFkCvhQW1KO9eTwckbkeMfZO3ylMtK0PiG6g=;
        b=Ggl1QEyFPDqR35ZmhtNmTJ/nHc1rai3MYAVcZFzKP2NrIOcmHRe1bk8NnwUeli7Dfb
         yFfZb5haA14giA/qN4q8DdkyT7/y88B6muhzylDvgy+sehNJPEXLpmrqA6fud5TMtSnH
         +JZAr3fVKMKorxhb251D6brtDknuzC9FFvxU+7Iwx3xEpMMSaDWz7Ng1tA5RvwWSEbQq
         HLCAvnD74GzJGoCgIbdmntkFcJ1QzoLJ4Abx8W7DlfI620ZDCg+Hwsqcm16J3TL3X0hc
         c4ydBsBNWIDEG3YqFi1v85H1xo695VcXJQTr7roQmOp1VCv/4mc0OY+S8OSbgw9PV/rL
         ygFA==
X-Gm-Message-State: AOJu0YySpMSoLF8cXwhVq1wnxtLNoH3UUPm0naLRgYyiozfPznFmqA5S
	M3NrQRs8gJ1fWVbDnFKbsIz3s9UFkj0f+eIsrqASbSeFWDjvgn5z5Kkp
X-Gm-Gg: ASbGncvFey0EKkFcMU3BImNETMHa0fCsBpjN4kkDdjUhZ1ILRRQC46d68wpZNZcuG2b
	WM6CNFLJc4I58QMgKlcNErddwOvdXf9xmNW/nr0kqcETY2gYKSGYOgNtu5RGuRvmix4sr+fumoc
	d2EwztVL9KUMe+WXonF3ihvp3dPM2oHRnTXwFtqk+ZAlv7WGHtlBJuhboN06Oj0y7rRdg0DJ4h7
	o2BNHt2PyQ3ONchnCJgEte21+LPGvKkh5dIfYU2yBgUiYZWSvy6fp9FpZYBWtc9ypJEjDGcKJzM
	yIJTxus5mQekGPiQQHCQjuA6Q2HEYpBoJznuJ/g+l78pbri76f3U4FbLgZXcLgWi4pth2Nn93oR
	NIkQiFoE+qADMB6gFbi0VXobO/dyUzNjK3ZBDWXE5LRzHMXrDJTTCqbCDhUWTgrNm+75or+M/6F
	/hWsBjld00s+uV
X-Google-Smtp-Source: AGHT+IFKlxr0ZVQCyE839sOznv/uVVZ8Plq2Fm/8Jbv6NaXL62Z7entHqYnJ1t0Nk/AWzx3U3+ulLQ==
X-Received: by 2002:a17:902:dad0:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-290ca12180emr179889945ad.37.1760979865873;
        Mon, 20 Oct 2025 10:04:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcccsm84887255ad.78.2025.10.20.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:04:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dmaengine@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Yi Sun <yi.sun@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12] dmaengine: Add missing cleanup on module unload
Date: Mon, 20 Oct 2025 10:04:22 -0700
Message-ID: <20251020170422.2630360-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream commit b7cb9a034305 ("dmaengine: idxd: Fix refcount underflow
on module unload") fixes a refcount underflow by replacing the call to
idxd_cleanup() in the remove function with direct cleanup calls. That works
fine upstream. However, upstream removed support for IOMMU_DEV_FEAT_IOPF,
which is still supported in v6.12.y. The backport of commit b7cb9a034305
into v6.12.y misses the call to disable it. This results in a warning
backtrace when unloading and reloading the module.

WARNING: CPU: 0 PID: 665849 at drivers/pci/ats.c:337 pci_reset_pri+0x4c/0x60
...
RIP: 0010:pci_reset_pri+0xa7/0x130

Add the missing cleanup call to fix the problem.

Fixes: ce81905bec91 ("dmaengine: idxd: Fix refcount underflow on module unload")
Cc: Yi Sun <yi.sun@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
The problem fixed with this patch only affects v6.12.y.

 drivers/dma/idxd/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 74a83203181d..e55136bb525e 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -923,6 +923,8 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_cleanup_interrupts(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
+	if (device_user_pasid_enabled(idxd))
+		idxd_disable_sva(idxd->pdev);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
 	pci_disable_device(pdev);
-- 
2.45.2


