Return-Path: <dmaengine+bounces-3154-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0F976A0D
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435B31F24672
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278B1AB6C3;
	Thu, 12 Sep 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8DtkmgN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA91A7AF0;
	Thu, 12 Sep 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146622; cv=none; b=VJ5eFE6i8st2jCZx4TMi/chOhsbGGamIKm4K+SgcIzhdzsfQVGNFEZ/FIR/djM6zppuisUGCklPhOgqhvq7FhTuwysgw8LsygPz7wsaj/yjlzlasejMUSUTA71YZOujBH7iVWTKgv92RraZ+n0RtmpDl3GZ21XtKNfwT6sN0t0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146622; c=relaxed/simple;
	bh=YQGtkVY1orJH2WVfTKflWZP/90r9WvrbC+Ne4huJ70E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B6qeqlSLNWJwhMKEo2sRNKd8cCA4h/u22B+QZce6oKkBwmkpUSnPIBISRA2cwzaDOmZ9Hr79Tj4JTpNXKdjTUeh8y+LJ+v+FH+MEuQPUQ9jWxsbWk3Q7jTbmcPQWoA94A5LpCRW3MDbnNEh5tn0kmMG9/pvCu6onqom3al57mjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8DtkmgN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374cacf18b1so690802f8f.2;
        Thu, 12 Sep 2024 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726146619; x=1726751419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8JQOeJOkNWzk5hF7kdBbJfmcbjNOYJyTlSnkrngbv8=;
        b=F8DtkmgNQgKKtvue38o+D9aRzbcq1WPyMabKhC3vUQY7R+S//HHUDFCXLZDUOLXCi6
         MJ4OdEjezLvGK9Du/FHyPenijmKV13jEEzyQpRmuF0jnkUn8H9GbyTG54yVvAkf2t45v
         vtWYTxyt+7oprRf40X7Qu5z+oPxfBHkljvGz7wHlovzo/LgwCnNLW0LASTOVMJHD8GS5
         8L48Ophk9bIPEDvNBCSmTdrvrFODQ7OJ2s4mVnYruOAlpfvjB1nS4Y9ihoZVWwJQ7GlI
         W1t5wWIHS05bsm08UTNGxAuKZjJOEMkbsh3KlYdy9hlM2R/Z+lZn7iKiPs57iJkotp0j
         5Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726146619; x=1726751419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8JQOeJOkNWzk5hF7kdBbJfmcbjNOYJyTlSnkrngbv8=;
        b=LURuF7ogyyp6EbOhWvY88//CwCCmlLO5z53VNPkFPjLfMpZYrqD1Uv5eTfZ48GONwL
         mWc522W21ju5mUE4+usojvTJR7kaXkVWWjvvFtEzdimuYgLCxPJQ7P/efEXakVQGbQqc
         50rVxHc2FbEvy6TvbdQ9+XSxedp736C2QWE7vcPjfhP5BpOCyUX4dWKdWq2IwpV0cz6F
         tntgEJFnmqWuazz1a/F/vRDiXTEym3WuLB5RI03Yg2nh8PA/wrAUGpUmfbSBCf6ZzY5T
         /9CbgPQtj/6LKn0CvKbbH5Nd9XTUJ82CbljFdAEwilz+qA6bzrVvPiBQCtWqKj3/zRug
         HAEg==
X-Forwarded-Encrypted: i=1; AJvYcCUFl6qg2HhHZ96WJ32+j4uGEjrCmEq+5ThycKBsLn0E3ljBX2qnNxuskOffJf8iDw3Cd0wqabCw4fcIxlDm@vger.kernel.org, AJvYcCWQtKWWysABGa4aSATGbTYOIbnh0ebwulPun3izQ2HzLhttsTNwlqrsR+E0+2Ze6qveGsVbhS7gPdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpn6/NpaRzZjQBA9j42J22tSVUCselS5Kbmuwb11WIazv35dbw
	vfwIjz+JMb9ndGy1BmV/6ZNArYHwOreLhZGHCFL22UNOUxlFQZ0y
X-Google-Smtp-Source: AGHT+IGctPJ+ZKxq4ZLB6qdJLoKPvcS3oXjmyhA8DvW7ar/5awAjITqMWam/yxTvaCY3cBuBCuYUKA==
X-Received: by 2002:a5d:6443:0:b0:374:bf97:ba10 with SMTP id ffacd0b85a97d-378c2d047e6mr1551574f8f.25.1726146618581;
        Thu, 12 Sep 2024 06:10:18 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a067sm14346787f8f.13.2024.09.12.06.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:10:18 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: amd: qdma: make read-only arrays h2c_types and c2h_types static const
Date: Thu, 12 Sep 2024 14:10:17 +0100
Message-Id: <20240912131017.588141-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only arrays h2c_types and c2h_types on the
stack at run time, instead make them static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/amd/qdma/qdma.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/amd/qdma/qdma.c b/drivers/dma/amd/qdma/qdma.c
index b0a1f3ad851b..17a876df9fb3 100644
--- a/drivers/dma/amd/qdma/qdma.c
+++ b/drivers/dma/amd/qdma/qdma.c
@@ -283,16 +283,20 @@ static int qdma_check_queue_status(struct qdma_device *qdev,
 
 static int qdma_clear_queue_context(const struct qdma_queue *queue)
 {
-	enum qdma_ctxt_type h2c_types[] = { QDMA_CTXT_DESC_SW_H2C,
-					    QDMA_CTXT_DESC_HW_H2C,
-					    QDMA_CTXT_DESC_CR_H2C,
-					    QDMA_CTXT_PFTCH, };
-	enum qdma_ctxt_type c2h_types[] = { QDMA_CTXT_DESC_SW_C2H,
-					    QDMA_CTXT_DESC_HW_C2H,
-					    QDMA_CTXT_DESC_CR_C2H,
-					    QDMA_CTXT_PFTCH, };
+	static const enum qdma_ctxt_type h2c_types[] = {
+		QDMA_CTXT_DESC_SW_H2C,
+		QDMA_CTXT_DESC_HW_H2C,
+		QDMA_CTXT_DESC_CR_H2C,
+		QDMA_CTXT_PFTCH,
+	};
+	static const enum qdma_ctxt_type c2h_types[] = {
+		QDMA_CTXT_DESC_SW_C2H,
+		QDMA_CTXT_DESC_HW_C2H,
+		QDMA_CTXT_DESC_CR_C2H,
+		QDMA_CTXT_PFTCH,
+	};
 	struct qdma_device *qdev = queue->qdev;
-	enum qdma_ctxt_type *type;
+	const enum qdma_ctxt_type *type;
 	int ret, num, i;
 
 	if (queue->dir == DMA_MEM_TO_DEV) {
-- 
2.39.2


