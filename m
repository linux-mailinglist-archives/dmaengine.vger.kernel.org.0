Return-Path: <dmaengine+bounces-9900-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA31Ju5/1GlLugcAu9opvQ
	(envelope-from <dmaengine+bounces-9900-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:54:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9013A9870
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA868301455D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF589374E60;
	Tue,  7 Apr 2026 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2qoyiHI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90E37475B
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533985; cv=none; b=Cx2+KDJFzNsDMMyooSDRIx+k7XuQ2WXCjVOkpfsvxyGo8l8dgDym69vDxpSuWbNASaAq96+8TddMnCopQQ66MkIBdQQSrRhUHN1xbZAmNaI+t2DXEwgopIQgM35DxjdeNLbzLdyuCDU6ZQZKGwmQVH2ef5T0vDl1qXijD2c2p8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533985; c=relaxed/simple;
	bh=gHdTJdwFXcktiwaupC6SMba8fQcp8/lMF+/wdHy+usg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIckU2QA7GCi0qAizx0hTt9Ro72Ju2yfnF43aSwKeqKXzehnknX9X6+0+gHZzL7i+uQQb1jzXlRRSwhNpu8TQ9t7Estkm7iiQe+sGDEOfcfQmkWFwR9o1mGxMaxaU3GIOjW7GsGicZqoEvGBwfjZcm+Uu2lrQPFEKWCpmBtkPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2qoyiHI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfd122d78fso735316585a.3
        for <dmaengine@vger.kernel.org>; Mon, 06 Apr 2026 20:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775533983; x=1776138783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDfQrtcskVZQcNoknVEFBQSDkXrKKb6vxWG+McjI4is=;
        b=L2qoyiHIYqfzf2SzQqzW98h7y82lHYX47noRYCwmEsZdow8jQGjbkYTYNGt0fTrNmI
         yKASXHCOldUUiWg2qsf5GDul+rQ44ReRq+p7k+jlXx3qr5pDxd1gF6UxRgSf8xYZm/Wc
         UbZ9J+SyYDtGMfJojykKmhdwsf1WEm/9Iq+B3CuTc0JrG4aBSycumL0WuY9PRjcJRr05
         OtdpVVZiVsKUjecRg/tsnvdPhz+gF6s2lFJBjC3VpH45UaakdqLoZL9BVSnduqSt2yHK
         w8lHJ1Q7yZMma0xbxu0EDQNEy18chwoU72DtsiVRTeG23gTIW3Z93SJpdb/Fx1c0EwBf
         /OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533983; x=1776138783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDfQrtcskVZQcNoknVEFBQSDkXrKKb6vxWG+McjI4is=;
        b=WikK8ofi6HPWNAEDqIEXRoq/p+9RmJvhw+JKeuIfQN8KVUVoCmLupKYk9DXDS/jloC
         vruPA2cy2CMq5hVAcrWAETq1XAk6aiDe5viOcppf8DyjAtSsnTD7VHhih/RZB3vyw7O6
         k9ovRmW6yrZ+SZAV+rIOEfEbJNsw7R3CIny6N+t8VmMEbss/nYSzjUkYfVgEIBMN62qr
         sBH56WaebmcTAexarlT4t32PecxszO8e0Bb0bzNbxoj0QFO4XXv5VE3vRF1/PsKRdhDk
         GXCLOWAwS7Ku7AGVQzX0LvVvdcQ609Pynat49W7+I+F6CsL9k97aL/zcL8r+P3/XAaLk
         kkIQ==
X-Gm-Message-State: AOJu0YwziH1STsvfTcd9/udC2t7QAm1PKs1pWaN/ylfBH7qN8XbVGu6d
	xTZ5KwizT4uRCjqIHKhb0fh96rftLcAj0++1AqfAze0ooDUvIEVq1u0nMv4+Mw==
X-Gm-Gg: AeBDieujR/qbi4iWS563VHrjo06qiijB2hQd1i2uW01yCx1SxQuzbKqez/EqHzvvN/H
	sOvDWXiotDLyQG7IgDfIIs9FzcB/1epuFAAwoNpRczN2aRronwTcMlLy3x2hKQEa0o9D5t9YY6c
	B7Xes0WYPZT4jlbA3pLRJ496WjYG+TMyaKFkDhJeJgiqX2R9JjTrZB+drjW6NaLBOXVQIBJJRo8
	52NTN2Gcm5ylH4U6zJ0bv6k/n9JRgbXDrBMTalRpaFk4eEOL4H4k89r3k8AfPkiYEcD2whOWyJ/
	SXg5a4J4U/rcNHxmWxEWP6a2nrqtr5Zuskg2tfz7OnbUPDK9CxlT0DsyTx3lIpS9ec4F5SwcgbV
	sPYmq1akZUtXRI5SniEmOJllGzL803pNkWHThRxFs0XdeOp2/IW2JVcvaraOM2QhTuSjrc+f6nG
	S2yl4YJZ5r1Tzko4T1YmLuXMTZuHLmgxWszwa2L00H2XzkE2Pei0QCyJU=
X-Received: by 2002:a05:620a:448f:b0:8cd:8fc7:831f with SMTP id af79cd13be357-8d41e439993mr2272818185a.56.1775533983558;
        Mon, 06 Apr 2026 20:53:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392ce8sm1376320885a.7.2026.04.06.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:53:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: mv_xor_v2: simplify allocation
Date: Mon,  6 Apr 2026 20:52:45 -0700
Message-ID: <20260407035245.99145-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9900-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E9013A9870
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member to create a single allocation of sw_desq and
xor_dev.

Move mv_xor_v2_sw_desc definition above as flexible array members
require a full definition compared to pointers.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor_v2.c | 43 ++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index cad4d4fb51ac..4c4d627ef991 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -132,6 +132,20 @@ struct mv_xor_v2_descriptor {
 	u32 reserved[MV_XOR_V2_DESC_RESERVED_SIZE];
 };
 
+/**
+ * struct mv_xor_v2_sw_desc - implements a xor SW descriptor
+ * @idx: descriptor index
+ * @async_tx: support for the async_tx api
+ * @hw_desc: associated HW descriptor
+ * @free_list: node of the free SW descriprots list
+*/
+struct mv_xor_v2_sw_desc {
+	int idx;
+	struct dma_async_tx_descriptor async_tx;
+	struct mv_xor_v2_descriptor hw_desc;
+	struct list_head free_list;
+};
+
 /**
  * struct mv_xor_v2_device - implements a xor device
  * @lock: lock for the engine
@@ -164,25 +178,11 @@ struct mv_xor_v2_device {
 	struct dma_chan	dmachan;
 	dma_addr_t hw_desq;
 	struct mv_xor_v2_descriptor *hw_desq_virt;
-	struct mv_xor_v2_sw_desc *sw_desq;
 	int desc_size;
 	unsigned int npendings;
 	unsigned int hw_queue_idx;
 	unsigned int irq;
-};
-
-/**
- * struct mv_xor_v2_sw_desc - implements a xor SW descriptor
- * @idx: descriptor index
- * @async_tx: support for the async_tx api
- * @hw_desc: associated HW descriptor
- * @free_list: node of the free SW descriprots list
-*/
-struct mv_xor_v2_sw_desc {
-	int idx;
-	struct dma_async_tx_descriptor async_tx;
-	struct mv_xor_v2_descriptor hw_desc;
-	struct list_head free_list;
+	struct mv_xor_v2_sw_desc sw_desq[];
 };
 
 /*
@@ -716,12 +716,12 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	struct mv_xor_v2_device *xor_dev;
 	int i, ret = 0;
 	struct dma_device *dma_dev;
-	struct mv_xor_v2_sw_desc *sw_desc;
 
 	BUILD_BUG_ON(sizeof(struct mv_xor_v2_descriptor) !=
 		     MV_XOR_V2_EXT_DESC_SIZE);
 
-	xor_dev = devm_kzalloc(&pdev->dev, sizeof(*xor_dev), GFP_KERNEL);
+	xor_dev = devm_kzalloc(&pdev->dev, struct_size(xor_dev, sw_desq,
+				MV_XOR_V2_DESC_NUM), GFP_KERNEL);
 	if (!xor_dev)
 		return -ENOMEM;
 
@@ -780,15 +780,6 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 		goto free_msi_irqs;
 	}
 
-	/* alloc memory for the SW descriptors */
-	xor_dev->sw_desq = devm_kcalloc(&pdev->dev,
-					MV_XOR_V2_DESC_NUM, sizeof(*sw_desc),
-					GFP_KERNEL);
-	if (!xor_dev->sw_desq) {
-		ret = -ENOMEM;
-		goto free_hw_desq;
-	}
-
 	spin_lock_init(&xor_dev->lock);
 
 	/* init the free SW descriptors list */
-- 
2.53.0


