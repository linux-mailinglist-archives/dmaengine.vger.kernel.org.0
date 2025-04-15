Return-Path: <dmaengine+bounces-4898-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B16A89D50
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607C33B694A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DD2951B4;
	Tue, 15 Apr 2025 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eq98GXZB"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A132957BE
	for <dmaengine@vger.kernel.org>; Tue, 15 Apr 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719219; cv=none; b=anuwZ8r9Gyo0gECegtbwuyFdlUfQKtSUo4YpLSMVvLqJTDekGJp4gADBmXUQ/pD9DqtJWidfqG1rkoACoKb+0Zx4tz45R4wUfF0n3JqpXngFA+wSNjBeb5lSal1Vpn8npDMVSpIxBiHrbClXdbc/d3eKwZgnXWXNoHP4lnGFJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719219; c=relaxed/simple;
	bh=9P0sq5lPWcAoBaIYk95sPswAjVLzbQdvYtr0glNmM6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/mUnfUWtI1utjD057kyNnfPzhJNZgRcKbUo5W4Aibm+93LluvNCzmBZelEKGDh2MEnG9EgSUKAcNYpgNw+ofG5HVIfWxZpjMmxwsGE5rX2xVeyQXniIHCEOgg1EaDrqVTEuG13kQGhpzMH6mxKn0UAzOnB97e5ooM6q33P88oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eq98GXZB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744719216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dD2W5Gk6xEruvgXgKSmq+TLa2o05RV4NaRvMwK0HBHw=;
	b=eq98GXZBmNSAsK8JtEK1zTjxplX1qJMcH9jYKDe9Lwx0gHIlA6bKVNjH+MyCB4CzseSeAL
	jlavEtuqETbN8TVmBUCOdKcSF+vRup4CUp20QEKER4oO4m6m0ZTYkQBWiktnbzdIfME9zX
	Vr1iUhSh6M04twuFhEphhurnC9S8hcY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-Al-Lw_ToPhy0FpojSTZAVw-1; Tue,
 15 Apr 2025 08:13:27 -0400
X-MC-Unique: Al-Lw_ToPhy0FpojSTZAVw-1
X-Mimecast-MFC-AGG-ID: Al-Lw_ToPhy0FpojSTZAVw_1744719206
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D78E119560BB;
	Tue, 15 Apr 2025 12:13:25 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.44.32.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6289180B486;
	Tue, 15 Apr 2025 12:13:23 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: nathan.lynch@amd.com,
	Basavaraj.Natikar@amd.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>
Subject: [PATCH v2] dmaengine: ptdma: Remove unused pointer dma_cmd_cache
Date: Tue, 15 Apr 2025 14:13:12 +0200
Message-ID: <20250415121312.870124-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The pointer 'struct kmem_cache *dma_cmd_cache' was introduced in commit
'b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA
resource")' but it was never used.

Changes since v1:
- Remove the 'err_cache' label and return -ENOMEM directly instead of
  assigning -ENOMEM to 'ret' and jumping to the label, since there
  are no unmanaged allocations to unwind. Based on suggestion from
  Nathan Lynch.
- Fix checkpatch.pl error: ERROR: Please use git commit description style
  'commit <12+ chars of sha1> ("<title line>")'

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
V1 -> V2: Addressed review comments and fix error detected by
checkpatch.pl.

 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 16 ++++------------
 drivers/dma/amd/ptdma/ptdma.h           |  1 -
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 3a8014fb9cb4..aefb91c29bb5 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -583,18 +583,14 @@ int pt_dmaengine_register(struct pt_device *pt)
 	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
 					 "%s-dmaengine-desc-cache",
 					 dev_name(pt->dev));
-	if (!desc_cache_name) {
-		ret = -ENOMEM;
-		goto err_cache;
-	}
+	if (!desc_cache_name)
+		return -ENOMEM;
 
 	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
 					       sizeof(struct pt_dma_desc), 0,
 					       SLAB_HWCACHE_ALIGN, NULL);
-	if (!pt->dma_desc_cache) {
-		ret = -ENOMEM;
-		goto err_cache;
-	}
+	if (!pt->dma_desc_cache)
+		return -ENOMEM;
 
 	dma_dev->dev = pt->dev;
 	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
@@ -648,9 +644,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 err_reg:
 	kmem_cache_destroy(pt->dma_desc_cache);
 
-err_cache:
-	kmem_cache_destroy(pt->dma_cmd_cache);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pt_dmaengine_register);
@@ -662,5 +655,4 @@ void pt_dmaengine_unregister(struct pt_device *pt)
 	dma_async_device_unregister(dma_dev);
 
 	kmem_cache_destroy(pt->dma_desc_cache);
-	kmem_cache_destroy(pt->dma_cmd_cache);
 }
diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
index 0a7939105e51..ef3f55632107 100644
--- a/drivers/dma/amd/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -254,7 +254,6 @@ struct pt_device {
 	/* Support for the DMA Engine capabilities */
 	struct dma_device dma_dev;
 	struct pt_dma_chan *pt_dma_chan;
-	struct kmem_cache *dma_cmd_cache;
 	struct kmem_cache *dma_desc_cache;
 
 	wait_queue_head_t lsb_queue;
-- 
2.49.0


