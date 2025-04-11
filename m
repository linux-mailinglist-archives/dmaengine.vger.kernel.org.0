Return-Path: <dmaengine+bounces-4876-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B7A863D6
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31543B5AEB
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F821D5AA;
	Fri, 11 Apr 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYiiclFo"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE721CC5C
	for <dmaengine@vger.kernel.org>; Fri, 11 Apr 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390505; cv=none; b=R6pAJBW6kMXJbsKm/H1YKLDvheXGySkSB0fKM/UMTeWZbttgwnXSgylYVp7et1tVsfmOwHFqb6hODktKy3BAIMqzWo0NkBI66GJeHtzeszwx99bLp825ZSmLmfJctWbSgyPvUvKwYkQNSX6D2uhn6IRBo6e00GaAo4/I2p7XbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390505; c=relaxed/simple;
	bh=eQUbKB5MlOrjoSK4E9qLGEKlAJfBrbmh04JyjJb8mTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmSYTAflYmJy1hJGKF2wc8OfgR+9ygkziTkS5ZH0z9kMuwJud7gTXCcg7dwtCIO05+CH/Q5oi3z2s6NjK5cE9koqTmurM1A4WWYlCoKMvKot7xpGrF/8mOWsQ0i9N6yML8YTLxIsQXjLA09YpcXv6PtSVC6wuqbnKb0ggjt1KVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYiiclFo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744390503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KBcgGdLhrEqsLmtx1ScSEvmWJKw+htq0uliyA+SEq3w=;
	b=PYiiclFoGEHfvblEJJJ0LCNC3uvN3qwN+bGigGTyWuJqQJPB/AJdD3gPU/3jiXl7PKdmF/
	XN/8p2l+IOaZfguuOmIn6W4FICYmCxl5oXvXYIwUviu+Wr8rnVDItLG/sbN7iUp7uo2BIT
	DOLv3SR2eXMK7aYiI3lbWOlk2QfWOxY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-3xMtwCtPNjumNzDnoeQkHQ-1; Fri,
 11 Apr 2025 12:54:57 -0400
X-MC-Unique: 3xMtwCtPNjumNzDnoeQkHQ-1
X-Mimecast-MFC-AGG-ID: 3xMtwCtPNjumNzDnoeQkHQ_1744390497
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB57D1956087;
	Fri, 11 Apr 2025 16:54:56 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.44.32.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2DDF180175D;
	Fri, 11 Apr 2025 16:54:54 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: Basavaraj.Natikar@amd.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>
Subject: [PATCH] dmaengine: ptdma: Remove dead code from pt_dmaengine_register()
Date: Fri, 11 Apr 2025 18:54:51 +0200
Message-ID: <20250411165451.240830-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

devm_kasprintf() is used to allocate and format a string and the
returned pointer is assigned to 'cmd_cache_name'. However, the variable
'cmd_cache_name' is not effectively used.

Remove the dead code.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 715ac3ae067b..3a8014fb9cb4 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -565,7 +565,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 	struct ae4_device *ae4 = NULL;
 	struct pt_dma_chan *chan;
 	char *desc_cache_name;
-	char *cmd_cache_name;
 	int ret, i;
 
 	if (pt->ver == AE4_DMA_VERSION)
@@ -581,12 +580,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 	if (!pt->pt_dma_chan)
 		return -ENOMEM;
 
-	cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
-					"%s-dmaengine-cmd-cache",
-					dev_name(pt->dev));
-	if (!cmd_cache_name)
-		return -ENOMEM;
-
 	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
 					 "%s-dmaengine-desc-cache",
 					 dev_name(pt->dev));
-- 
2.49.0


