Return-Path: <dmaengine+bounces-7051-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E006C2E921
	for <lists+dmaengine@lfdr.de>; Tue, 04 Nov 2025 01:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD87134C3A3
	for <lists+dmaengine@lfdr.de>; Tue,  4 Nov 2025 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD65D8F0;
	Tue,  4 Nov 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C18q6xfM"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE529405;
	Tue,  4 Nov 2025 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215606; cv=none; b=W8sHKtI4rTLkDdIig1w4pyaup0bnq7HbabBhtb32b/JGnSvBCo+pR6n9jgrd7qZrZBs+wOSs/LuH04FLcV3nA3Sw1WAHW+fPFSyuB9oNwGclcJeYB1Kn6ZNaOPjvMNjtW7hAozLgK6WBjgv961op/3zxS3YVZDVFgD+2RuYrNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215606; c=relaxed/simple;
	bh=jQnwNYvNZfxrOldBcIBkcbxYnUzIgmI999p3q3jS52I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwRJmVu9mb0sR43tFHmnKBJt47h9RravKRcyNbmzS7YXhMXUfxoFwk/scPxxJkDiM8HbWD+zGlRpba85EvEGo+XN/dZ+3Jp9s96iQRvqVis2GfthvCAT3VzAjrg8P2uNizu9YXfXptqbnaaCbyzOB1kNVO5fnlJqbZdCuEh8b6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C18q6xfM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jDMq68dxdxwO9VnU+wTiU39fko+A9829mDe4Pkx2XGw=; b=C18q6xfMESE3v8GOYybl9Gvxw7
	CyqjqorcPkrCZzUbdQVow58u/40RSv/nFmaeo05TSv1yXkxJqZJCtU5Ol9fzkUl451AuBCPIuXhN2
	akfolhhZdXsTrfaKybK+iRMnZVu+qvb+YO4RX43t0eVDSTYzSr2E5yUJipGp56QFq6E45v2eTQ3LP
	ShdNaLHHz8rO2bNjW2xH7lMwdFTfKo+xpuPVRhII+VeeSDKM+DgjFCakBG/wsXwchIfT9vwvD/j5d
	5auQhHJLyBUFlC4gXgQpQCgvGpAFnMbyUDlSZc5VkG1rrHa83BwWEVG6xRnJytRCtHOUa4i19dKgJ
	7SBcqzBg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4mH-0000000Aq0y-3yNL;
	Tue, 04 Nov 2025 00:20:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH] dmaengine: shdma: correct most kernel-doc issues in shdma-base.h
Date: Mon,  3 Nov 2025 16:20:01 -0800
Message-ID: <20251104002001.445297-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc comments in include/linux/shdma-base.h to avoid
most warnings:

- prefix an enum name with "enum"
- prefix enum values with '@'
- prefix struct member names with '@'

shdma-base.h:28: warning: cannot understand function prototype:
 'enum shdma_pm_state '
Warning: shdma-base.h:103 struct member 'desc_completed' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'halt_channel' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'channel_busy' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'slave_addr' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'desc_setup' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'set_slave' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'setup_xfer' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'start_xfer' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'embedded_desc' not described
 in 'shdma_ops'
Warning: shdma-base.h:103 struct member 'chan_irq' not described
 in 'shdma_ops'

This one is not fixed: from 4f46f8ac80416:
Warning: shdma-base.h:103 struct member 'get_partial' not described
 in 'shdma_ops'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 include/linux/shdma-base.h |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- linux-next-20251103.orig/include/linux/shdma-base.h
+++ linux-next-20251103/include/linux/shdma-base.h
@@ -19,11 +19,11 @@
 #include <linux/types.h>
 
 /**
- * shdma_pm_state - DMA channel PM state
- * SHDMA_PM_ESTABLISHED:	either idle or during data transfer
- * SHDMA_PM_BUSY:		during the transfer preparation, when we have to
+ * enum shdma_pm_state - DMA channel PM state
+ * @SHDMA_PM_ESTABLISHED:	either idle or during data transfer
+ * @SHDMA_PM_BUSY:		during the transfer preparation, when we have to
  *				drop the lock temporarily
- * SHDMA_PM_PENDING:	transfers pending
+ * @SHDMA_PM_PENDING:	transfers pending
  */
 enum shdma_pm_state {
 	SHDMA_PM_ESTABLISHED,
@@ -74,18 +74,18 @@ struct shdma_chan {
 
 /**
  * struct shdma_ops - simple DMA driver operations
- * desc_completed:	return true, if this is the descriptor, that just has
+ * @desc_completed:	return true, if this is the descriptor, that just has
  *			completed (atomic)
- * halt_channel:	stop DMA channel operation (atomic)
- * channel_busy:	return true, if the channel is busy (atomic)
- * slave_addr:		return slave DMA address
- * desc_setup:		set up the hardware specific descriptor portion (atomic)
- * set_slave:		bind channel to a slave
- * setup_xfer:		configure channel hardware for operation (atomic)
- * start_xfer:		start the DMA transfer (atomic)
- * embedded_desc:	return Nth struct shdma_desc pointer from the
+ * @halt_channel:	stop DMA channel operation (atomic)
+ * @channel_busy:	return true, if the channel is busy (atomic)
+ * @slave_addr:		return slave DMA address
+ * @desc_setup:		set up the hardware specific descriptor portion (atomic)
+ * @set_slave:		bind channel to a slave
+ * @setup_xfer:		configure channel hardware for operation (atomic)
+ * @start_xfer:		start the DMA transfer (atomic)
+ * @embedded_desc:	return Nth struct shdma_desc pointer from the
  *			descriptor array
- * chan_irq:		process channel IRQ, return true if a transfer has
+ * @chan_irq:		process channel IRQ, return true if a transfer has
  *			completed (atomic)
  */
 struct shdma_ops {

