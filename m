Return-Path: <dmaengine+bounces-8527-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BdoIS5veGmjpwEAu9opvQ
	(envelope-from <dmaengine+bounces-8527-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 08:54:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299AE90D98
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 08:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84D91300B458
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A037285CBC;
	Tue, 27 Jan 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="XU0uhBkJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EF2848A8
	for <dmaengine@vger.kernel.org>; Tue, 27 Jan 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500458; cv=none; b=U4XGjPkv3xD2/eVMEj3GQwY/PWgh2Jc6He5PK4tEze+MoKbel6cB9vsPG1U0T85f7zncZngzTLEkKs6XimA9NG74I0CA4C6/KKtwV2G9dWOHMxX4uHsZKYZXNF2zwevZZez2nYbiZVW5UhevJ9nTouEVXV2ZEwSN+EPggCoohwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500458; c=relaxed/simple;
	bh=IDj2ME1e/uh0EgNsFknFveieSdaJ1+0AC0j413GLNDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsiadCltbGAtzl3yZcA708IRoqcPtFhiaggyzHAG/P0p0ZOlZvfb3UYIVJCuH6dlun8YEjOllOAA/h6QdFaDY28nnd7tedyBOWGBnQxpInjHHgYzxJ0FuWqTwqOt9gGwvm45s2MGySlKZJrEH49Y3NwFZy+jO5XzNo8HjpgvPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=XU0uhBkJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b834e3d64so6583376e87.2
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 23:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1769500455; x=1770105255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/TOyUI3EBD5eIFhAEg5gbtYZU0ZFmEHg7GNAgWzwgE=;
        b=XU0uhBkJzHGqIRZyFlrhhQcdztsht6LD/jPRdOvgvBv4jBDvdDx5ms4Vkk5MA/6m2S
         C+fzchbpkrn50tagtA2H5XG9F4cEdPrgwSvgtbRy7rwtpGT/xrVZ0MDzXcpgfgu7C0u/
         rSJlYZHPY7cZ/SGhI7u2GcgBwaReRQYoVh2L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500455; x=1770105255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/TOyUI3EBD5eIFhAEg5gbtYZU0ZFmEHg7GNAgWzwgE=;
        b=fxNkveIvJY0zqRkl9H9OY0thBEOhqaN1C+Q1q8s8NokRxUMX4ypeSuCj4ie55rAd2s
         oVkGfSLdRttdh2IsZBx5TenBysVF4G9eINYpzjDJAMJd5IAFvCNHr7lCc1EDfqzsNpFV
         Z1jjKcMVdTMe0kYyyhJiiXYL5n8gvpdjoBAiNnJn5HVSBIHGwAHlf+XuThXtLYWaX9/R
         EstM4UT0AGVg/LKKOrbc6e/ekuapaLTsVrLyct67nKC0H658jTwHr2uZf/8pOHEw6d5m
         ik+W+5a5T3rZvwLZcuLXnfS5lQ8d1/HILF3qGf3IZMtPxd4F0wLHHaQyq8Jah6XXN7N5
         bgyg==
X-Gm-Message-State: AOJu0YzdQE44fvLa4GuhA7iAf9FhdwednI6fZ6cDOmNVObDxm7DrJ9Oh
	ekBwoqZ6RAjL1hPtpS2M8OWQp5kIrYSMlV9Zp0u9O+U2sPpUEdM9L0hoImAg6MLc079YBZtZi5v
	GCmy7
X-Gm-Gg: AZuq6aLzF8vQVhAq54S6k8plpXfT3tTOQFTGJU+4Gtntl1Hb+BERFbE+GBeUIR9krgi
	5QuTwNKXCkmMozyR7n80m/G7t3ztBxTx2Y3oqX8U4bV0MtEtBrjPsbM/+rogsOCN1SwLa3JlgDI
	ilGSiE1cPA3Y0m6WK8AwUBmlbtkPvaqoXHS9WdoHixNej2TFY69D4koU+AmF+DqVoS77OnnBH/S
	gt1JLTfu43kWjzJ8OuZPqmPJRuIC0FSbGoTPePe2ZIbI6XiyfElgkIL0x/YdS8EPhWz+k1bwb55
	kSQyw9Ts+uDW1yMVhFuFmJLvqiiGlYUZKhuY+6OuOF8+T/Qb24vqz5p7mwWXkV/6lUqKP7mMxwE
	AnHjCa9OYVUuDOQSicLjEfuAFWUnsUkQwWJPnCwJ1IiD5v2VSqTd09t7y9E3Q15Hm45Ta41sCM4
	LmoWvWTbQOpXURaR6ACSx/wFWHev5k0uBxMq/3QSWGrXnOUAt4KGoer0gYG0asMiQhxpqGPlfxN
	nAU3YrwoJGHZF3oCieaUED/vFOuChUDecPR8JCg0RAHUV3WY88/0nSpbiVKV/s31RjvniLFdMf+
	9NYfPjfIiHngADzy4ugSu0cqMcULlr5gO/4cC7dniZ4vDYTgDAALEGJpx7arlI2e/Fc=
X-Received: by 2002:a05:6512:2311:b0:59c:bdd8:9d7e with SMTP id 2adb3069b0e04-59e040334admr396059e87.45.1769500455344;
        Mon, 26 Jan 2026 23:54:15 -0800 (PST)
Received: from m5compiler07.. ([141.112.46.27])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48df6d3sm3266771e87.1.2026.01.26.23.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:54:14 -0800 (PST)
From: Daniel J Blueman <daniel@quora.org>
To: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Daniel J Blueman <daniel@quora.org>,
	Scott Hamilton <scott.hamilton@eviden.com>,
	stable@vger.kernel.org
Subject: [PATCH] idxd: Fix Intel Data Streaming Accelerator double-free on error path
Date: Tue, 27 Jan 2026 07:52:07 +0000
Message-ID: <20260127075210.3584849-1-daniel@quora.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quora.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8527-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[quora.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 299AE90D98
X-Rspamd-Action: no action

During IDXD driver probe unwind from an earlier resource allocation
failure, multiple use-after-free codepaths are taken leading to attempted
double-free of ID allocator entries and memory allocations, eg:

ida_free called for id=64 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x1af/0x1f4, CPU#900: kworker/900:1/11863
...
Call Trace:
<TASK>
? ida_destroy+0x258/0x258
idxd_pci_probe_alloc+0x342e/0x348c
? multi_u64_to_bmap+0xc9/0xc9
? queued_read_unlock+0x1e/0x1e
? __schedule+0x2e43/0x2ee6
? idxd_reset_done+0x12ca/0x12ca
idxd_pci_probe+0x15/0x17
...

Fix this by releasing these allocations only after use and once.

Validated on 8 socket and 16 socket (XNC node controller) Intel Saphire
Rapids XCC systems with no KASAN, Kmemleak or lockdep reports.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
Cc: stable@vger.kernel.org

---
 drivers/dma/idxd/init.c  | 21 +--------------------
 drivers/dma/idxd/sysfs.c |  1 -
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2acc34b3daff..5d2b869df745 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -167,13 +167,9 @@ static void idxd_clean_wqs(struct idxd_device *idxd)
 		wq = idxd->wqs[i];
 		if (idxd->hw.wq_cap.op_config)
 			bitmap_free(wq->opcap_bmap);
-		kfree(wq->wqcfg);
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
-		kfree(wq);
 	}
-	bitmap_free(idxd->wq_enable_map);
-	kfree(idxd->wqs);
 }
 
 static int idxd_setup_wqs(struct idxd_device *idxd)
@@ -277,9 +273,7 @@ static void idxd_clean_engines(struct idxd_device *idxd)
 		engine = idxd->engines[i];
 		conf_dev = engine_confdev(engine);
 		put_device(conf_dev);
-		kfree(engine);
 	}
-	kfree(idxd->engines);
 }
 
 static int idxd_setup_engines(struct idxd_device *idxd)
@@ -341,9 +335,7 @@ static void idxd_clean_groups(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_groups; i++) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
-		kfree(group);
 	}
-	kfree(idxd->groups);
 }
 
 static int idxd_setup_groups(struct idxd_device *idxd)
@@ -590,17 +582,6 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
 }
 
-static void idxd_free(struct idxd_device *idxd)
-{
-	if (!idxd)
-		return;
-
-	put_device(idxd_confdev(idxd));
-	bitmap_free(idxd->opcap_bmap);
-	ida_free(&idxd_ida, idxd->id);
-	kfree(idxd);
-}
-
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
@@ -1239,7 +1220,7 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
-	idxd_free(idxd);
+	put_device(idxd_confdev(idxd));
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 9f0701021af0..819f2024ba0b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1818,7 +1818,6 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->engines);
 	kfree(idxd->evl);
 	kmem_cache_destroy(idxd->evl_cache);
-	ida_free(&idxd_ida, idxd->id);
 	bitmap_free(idxd->opcap_bmap);
 	kfree(idxd);
 }
-- 
2.43.0


