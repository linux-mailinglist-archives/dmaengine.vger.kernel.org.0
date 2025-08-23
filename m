Return-Path: <dmaengine+bounces-6165-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF2B32A03
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF608A06C4F
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA762EA165;
	Sat, 23 Aug 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P57F5fo0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3C2C21E5;
	Sat, 23 Aug 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964664; cv=none; b=mpd+dnXERovzDC4bSE+6wsr3QjX3UbmBJPpBhlvm4XEdn9MjZdPdEcFMp/Q63NtYidtTW4ogi53hav5Et5lR1DfwLuUxan+oN67vgfBjJi1dzPlgTzKd0NvTe5l6sgC5P3UPn5KVeC4u/QSf0dKukeu8NRSH+PlZ1RTloQTBwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964664; c=relaxed/simple;
	bh=36rUEQ/nyOji+fp5dS6bVayQxIrp+bVWGLzl//eyA4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfPknkSaeCQvaeP5RgSCpSDttwX0alBivOfLinqz6VN+qrvtvihBHyw8ci6gtQ6ltgzQKndaS2aRGSKFl3P80jU5rCsKg/9tYXYt1iKRq4CWgP9clly/8wjj++SaUkh9qsz4nqfCf7gfJ7q3vH7wrlLkqfeAwdCEtc0C381i49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P57F5fo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBA9C116B1;
	Sat, 23 Aug 2025 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964663;
	bh=36rUEQ/nyOji+fp5dS6bVayQxIrp+bVWGLzl//eyA4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P57F5fo0GhLEE06FSqPzmciqCyucHWjCLkal9nX7/kDyGhjbaW5xM/QAmUmmfULJx
	 WufekpRvXthRkhgHHcYgMWgFTLunzBjmJq9/CKP8aSOPcjwy3M7HJgi40AgUERhv8b
	 ilKq9JIR8C0lpHadn+0omYKy/Wn243gANPuQO+lq1gqy0u9EKMYB4vsygF4er96VDT
	 6Ud3x4BzabV+R6EWH1i9ZLpZtOcO9TaFC99KvAec7Wuz/UEuhabxDKkn7VW5y4B8pq
	 XQ68+BKnzjkldGrv+qXbHAIe9hKh606ZVqE7jmnVbgyhSbjSDMiHQaG9splpYN0Icl
	 EdpMd4Ht7OZDg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] dmaengine: dma350: Check dma_cookie_status() ret code and txstate
Date: Sat, 23 Aug 2025 23:39:59 +0800
Message-ID: <20250823154009.25992-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dma_cookie_status() returns DMA_COMPLETE, we can return immediately.

From another side, the txstate is an optional parameter used to get a
struct with auxilary transfer status information. When not provided
the call to device_tx_status() should return the status of the dma
cookie. Return the status of dma cookie when the txstate optional
parameter is not provided.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 96350d15ed85..17af9bb2a18f 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -377,6 +377,8 @@ static enum dma_status d350_tx_status(struct dma_chan *chan, dma_cookie_t cookie
 	u32 residue = 0;
 
 	status = dma_cookie_status(chan, cookie, state);
+	if (status == DMA_COMPLETE || !state)
+		return status;
 
 	spin_lock_irqsave(&dch->vc.lock, flags);
 	if (cookie == dch->cookie) {
-- 
2.50.0


