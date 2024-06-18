Return-Path: <dmaengine+bounces-2405-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F71890C8F3
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 13:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59731F2114B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 11:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D415A842;
	Tue, 18 Jun 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wHf87l8D"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ABC213150;
	Tue, 18 Jun 2024 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705051; cv=none; b=OvqJl5U3citl+AGgjucB4y8QO2U2kkQ7QF6sZXctqeGWWaTpZ6dlwphdtTJg50s3RwoD1yvrK7uDoPT/gqkRmHxkgV2Ajt3tykq5ZiFEYdiFqsby5/sh1disyQhsPoNoisK4//avKCG3kOoCMYuhHyViNr+PFtVz9/oJcpsxZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705051; c=relaxed/simple;
	bh=4YWN/YA/fD0SVX0eMRc79+uuIR6l1+MR5ellTf12TE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwdGqB0oBDudP9490CCL0ojXpLe1jui2YtXScIEYXemDOgTYfnrxnzXmxBd363RZNYnLhV/FlUWYojtSNQ+obMw9NaXDLhpcFKIUdQR51NK6PlQU9/qLIfFCaj/B6HVtAGT6ECDKSYO+LMTuyAfJiV45aekhj8+4gQeMNP0W+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=wHf87l8D; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718704996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIM0GDO9g+IJWoYHCyOFMTR0l0Da82ekI+tXGdDJpIg=;
	b=wHf87l8DPAV70EZjYC8biQyHxlXF1vIhWYunjyGa5fvT6+MCurDgTaZcip+0s43fJjdzZW
	w7kgVS5hLfM5RfdMqbbZy+nQXfq/cSqfCfG2IkBqS4oo4iksBnsbTs9cDEOoZmoFst5RSb
	s8EQj/md8ldNQ14nRFCStXYxQ4BLVjU=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 7/7] Documentation: dmaengine: Document new dma_vec API
Date: Tue, 18 Jun 2024 12:03:02 +0200
Message-ID: <20240618100302.72886-8-paul@crapouillou.net>
In-Reply-To: <20240618100302.72886-1-paul@crapouillou.net>
References: <20240618100302.72886-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the dmaengine_prep_peripheral_dma_vec() API function, the
device_prep_peripheral_dma_vec() backend function, and the dma_vec
struct.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v11: New patch
---
 Documentation/driver-api/dmaengine/client.rst   |  9 +++++++++
 Documentation/driver-api/dmaengine/provider.rst | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index ecf139f73da4..d491e385d61a 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -80,6 +80,10 @@ The details of these operations are:
 
   - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
 
+  - peripheral_dma_vec: DMA an array of scatter gather buffers from/to a
+    peripheral. Similar to slave_sg, but uses an array of dma_vec
+    structures instead of a scatterlist.
+
   - dma_cyclic: Perform a cyclic DMA operation from/to a peripheral till the
     operation is explicitly stopped.
 
@@ -102,6 +106,11 @@ The details of these operations are:
 		unsigned int sg_len, enum dma_data_direction direction,
 		unsigned long flags);
 
+     struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
+		struct dma_chan *chan, const struct dma_vec *vecs,
+		size_t nents, enum dma_data_direction direction,
+		unsigned long flags);
+
      struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_data_direction direction);
diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index ceac2a300e32..3085f8b460fa 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -433,6 +433,12 @@ supported.
     - residue: Provides the residue bytes of the transfer for those that
       support residue.
 
+- ``device_prep_peripheral_dma_vec``
+
+  - Similar to ``device_prep_slave_sg``, but it takes a pointer to a
+    array of ``dma_vec`` structures, which (in the long run) will replace
+    scatterlists.
+
 - ``device_issue_pending``
 
   - Takes the first transaction descriptor in the pending queue,
@@ -544,6 +550,10 @@ dma_cookie_t
 - Not really relevant any more since the introduction of ``virt-dma``
   that abstracts it away.
 
+dma_vec
+
+- A small structure that contains a DMA address and length.
+
 DMA_CTRL_ACK
 
 - If clear, the descriptor cannot be reused by provider until the
-- 
2.43.0


