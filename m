Return-Path: <dmaengine+bounces-3784-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC69D7B81
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 07:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587861627CD
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 06:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271C1426C;
	Mon, 25 Nov 2024 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gY3k5qBX"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED1126C10;
	Mon, 25 Nov 2024 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732515314; cv=none; b=kGdUazgRLBTyutVKizsQJ90hHD9NwH8+u1cy0i6OCeAeZhhs1+Lem9jwBzu0eZ7MUXMhTTuROyU+wmYkf9hxhmwtXx9IfrzCNQMUChcmuH6LxXSF0zNwHpjY5x9FZT2z7LSCMrmV9cr7FEhV8mv/gTkO9ygOYXqwEKoVeVJtsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732515314; c=relaxed/simple;
	bh=xZT8uDzQLD3WGPDstYmAFf1K/W/AMWG40gxcaYJlKJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggT9iMJgAJFph018mkPcT7A8tKaZ0GVhak+yJdysq/10inYtZLYQgNJ9+0DbzkDYEQrfqyKq2cq0a+OPDM8U7DyQnQJ8mGYUVT4smANTq7va/6ERo2w+OSYljYBpXLbvkI9HR6K+03dn0ylGPPC34cdcDJIA1MJfLjSaaZNeaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gY3k5qBX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bp25c6I4zGTEwI7csgchTtystGBN5Cj90/+RDTD+rwg=; b=gY3k5qBXsRh8GM5k24qJPu1eK5
	qF1WQUMBvm8d+B8+V8nLQtVGAhovpS3zQtp3jXCxsrjwklmRYxQOfNigD9pIWG2/Fq/P7+VKvtknt
	l2Sl8GNpyNNa0SxRrzhdeUkkzZo6x7T0Bc42yga7XekDgW0irrgQR03Vm1/rarh6EJeQEJwiomOcp
	de8aVibnA74N3KmM6XIp6zGo6CaJ8unBebKLVqfLs/3hq7VZdSfZEgPh2PDWwdD8/GmOYlJopK6XS
	+ow/Q89QaiYzO58k3OrRvJZ9Y+l5N2WVwD5RtnWNpDo8oi0TC2mnAdgfF3E+FcEaR+i+mMh7dpYEh
	H6NNJf9Q==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSNL-000000079Xv-334B;
	Mon, 25 Nov 2024 06:15:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Nuno Sa <nuno.sa@analog.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH] linux/dmaengine.h: fix a few kernel-doc warnings
Date: Sun, 24 Nov 2024 22:15:08 -0800
Message-ID: <20241125061508.165099-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment block for "Interleaved Transfer Request" should not begin
with "/**" since it is not in kernel-doc format.

Fix doc name for enum sum_check_flags.

Fix all (4) missing struct member warnings.

Use "Warning:" for one "Note:" in enum dma_desc_metadata_mode since
scripts/kernel-doc does not allow more than one Note:
per function or identifier description.

This leaves around 49 kernel-doc warnings like:
  include/linux/dmaengine.h:43: warning: Enum value 'DMA_OUT_OF_ORDER' not described in enum 'dma_status'

and another scripts/kernel-doc problem with it not being able to parse
some typedefs.

Fixes: b14dab792dee ("DMAEngine: Define interleaved transfer request api"), Jassi Brar
Fixes: ad283ea4a3ce ("async_tx: add sum check flags")
Fixes: 272420214d26 ("dmaengine: Add DMA_CTRL_REUSE")
Fixes: f067025bc676 ("dmaengine: add support to provide error result from a DMA transation")
Fixes: d38a8c622a1b ("dmaengine: prepare for generic 'unmap' data")
Fixes: 5878853fc938 ("dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Nuno Sa <nuno.sa@analog.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 include/linux/dmaengine.h |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- linux-next-20241122.orig/include/linux/dmaengine.h
+++ linux-next-20241122/include/linux/dmaengine.h
@@ -84,7 +84,7 @@ enum dma_transfer_direction {
 	DMA_TRANS_NONE,
 };
 
-/**
+/*
  * Interleaved Transfer Request
  * ----------------------------
  * A chunk is collection of contiguous bytes to be transferred.
@@ -223,7 +223,7 @@ enum sum_check_bits {
 };
 
 /**
- * enum pq_check_flags - result of async_{xor,pq}_zero_sum operations
+ * enum sum_check_flags - result of async_{xor,pq}_zero_sum operations
  * @SUM_CHECK_P_RESULT - 1 if xor zero sum error, 0 otherwise
  * @SUM_CHECK_Q_RESULT - 1 if reed-solomon zero sum error, 0 otherwise
  */
@@ -286,7 +286,7 @@ typedef struct { DECLARE_BITMAP(bits, DM
  *	pointer to the engine's metadata area
  *   4. Read out the metadata from the pointer
  *
- * Note: the two mode is not compatible and clients must use one mode for a
+ * Warning: the two modes are not compatible and clients must use one mode for a
  * descriptor.
  */
 enum dma_desc_metadata_mode {
@@ -594,9 +594,13 @@ struct dma_descriptor_metadata_ops {
  * @phys: physical address of the descriptor
  * @chan: target channel for this operation
  * @tx_submit: accept the descriptor, assign ordered cookie and mark the
+ * @desc_free: driver's callback function to free a resusable descriptor
+ *	after completion
  * descriptor pending. To be pushed on .issue_pending() call
  * @callback: routine to call after this operation is complete
+ * @callback_result: error result from a DMA transaction
  * @callback_param: general parameter to pass to the callback routine
+ * @unmap: hook for generic DMA unmap data
  * @desc_metadata_mode: core managed metadata mode to protect mixed use of
  *	DESC_METADATA_CLIENT or DESC_METADATA_ENGINE. Otherwise
  *	DESC_METADATA_NONE
@@ -827,6 +831,9 @@ struct dma_filter {
  * @device_prep_dma_memset: prepares a memset operation
  * @device_prep_dma_memset_sg: prepares a memset operation over a scatter list
  * @device_prep_dma_interrupt: prepares an end of chain interrupt operation
+ * @device_prep_peripheral_dma_vec: prepares a scatter-gather DMA transfer,
+ *	where the address and size of each segment is located in one entry of
+ *	the dma_vec array.
  * @device_prep_slave_sg: prepares a slave dma operation
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will

