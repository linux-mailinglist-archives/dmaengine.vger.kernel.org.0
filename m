Return-Path: <dmaengine+bounces-7044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5916C285FB
	for <lists+dmaengine@lfdr.de>; Sat, 01 Nov 2025 20:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514563AAD69
	for <lists+dmaengine@lfdr.de>; Sat,  1 Nov 2025 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30720231856;
	Sat,  1 Nov 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmhL4ukw"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2B19E968;
	Sat,  1 Nov 2025 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024528; cv=none; b=Rci87vTqJsl7sw06B1ea5MLQR32iX8LTkq+qhCIBUfsIVxbA2ZBYLFtO0/2eci7AQTluhOYzkCiMufcX2ohmXmQbuYnSJv8ALR+DbTTV4ghsQweiOocUIb0P7Zue1/nAEJXcB1T9lt+HmvYco5CQJMwCJg65p+yZVnLaeIndAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024528; c=relaxed/simple;
	bh=s/AqBrEen82BZTUt+zB9upJzobIHtkqVuoA2vuL0q2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEDOCy6kmxKP+9baK8bI4qNYOEoTy5uHvPAoEgOJwFYzZfDUTZhVpzCV4b/7rUNQ25lx1WIGcuhcg8cxbfSzi4qnLKRJal8L5RiKbBoDCy3XsS5clT9NHIQ9y0CDw7O6tTpoLnxjO5baGKTuzKjrw9sBcZh3QN4c0BPujHeYsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RmhL4ukw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tNGV47VDfbMJ51xZMzm7j+Z/u6TJ+M3By0xD4ZK0YuM=; b=RmhL4ukwFjhLrKiImQToohbkx/
	OcdhG6LzM62hRqwb3r/7XHZrNeJ3kDGQt60rJrSxYz12k+DhKptD03idKMc3KYfYa6Rrd7WAyMJQx
	PquWF6PZDEzb98pV2rDhVBgOZ1m6Do5byL8Q/I/86jlnUWODXf6KKYPawZRkA2lXs8T+8xF8t9mUP
	1a3Y8tW27Snn3+7asA5wGyRxZTpOOVVmb7/49cJYs73/wIO+4Kcu2ZmCmNHUcoF9NNxwkXXzb548O
	Vn8iZEhigKeAihevdKaPkEziYJD0tHqV8FTSu5Ycxxq7GfrOrKbLV56fRhKx4nxbZF9AGoF3QJJKk
	yXGnFs6A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFH4O-000000082TU-2yph;
	Sat, 01 Nov 2025 19:15:25 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: dw_edma: correct kernel-doc warnings in <linux/dma/edma.h>
Date: Sat,  1 Nov 2025 12:15:24 -0700
Message-ID: <20251101191524.1991135-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct enum name in its kernel-doc heading.
Add ending ':' to struct member names.
Drop the @id: kernel-doc entry since there is no struct member named 'id'.

edma.h:46: warning: expecting prototype for struct dw_edma_core_ops.
 Prototype was for struct dw_edma_plat_ops instead
Warning: edma.h:101 struct member 'ops' not described in 'dw_edma_chip'
Warning: edma.h:101 struct member 'flags' not described in 'dw_edma_chip'
Warning: edma.h:101 struct member 'reg_base' not described
 in 'dw_edma_chip'
Warning: edma.h:101 struct member 'll_wr_cnt' not described
 in 'dw_edma_chip'
Warning: edma.h:101 struct member 'll_rd_cnt' not described
 in 'dw_edma_chip'
Warning: edma.h:101 struct member 'll_region_wr' not described
 in 'dw_edma_chip'
Warning: edma.h:101 struct member 'll_region_rd' not described
 in 'dw_edma_chip'
Warning: edma.h:101 struct member 'dt_region_wr' not described
 in 'dw_edma_chip'
Warning: edma.h:101 struct member 'dt_region_rd' not described
 in 'dw_edma_chip'
Warning: edma.h:101 struct member 'mf' not described in 'dw_edma_chip'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 include/linux/dma/edma.h |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- linux-next-20251031.orig/include/linux/dma/edma.h
+++ linux-next-20251031/include/linux/dma/edma.h
@@ -27,7 +27,7 @@ struct dw_edma_region {
 };
 
 /**
- * struct dw_edma_core_ops - platform-specific eDMA methods
+ * struct dw_edma_plat_ops - platform-specific eDMA methods
  * @irq_vector:		Get IRQ number of the passed eDMA channel. Note the
  *			method accepts the channel id in the end-to-end
  *			numbering with the eDMA write channels being placed
@@ -63,19 +63,17 @@ enum dw_edma_chip_flags {
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
- * @id:			 instance ID
  * @nr_irqs:		 total number of DMA IRQs
- * @ops			 DMA channel to IRQ number mapping
- * @flags		 dw_edma_chip_flags
- * @reg_base		 DMA register base address
- * @ll_wr_cnt		 DMA write link list count
- * @ll_rd_cnt		 DMA read link list count
- * @rg_region		 DMA register region
- * @ll_region_wr	 DMA descriptor link list memory for write channel
- * @ll_region_rd	 DMA descriptor link list memory for read channel
- * @dt_region_wr	 DMA data memory for write channel
- * @dt_region_rd	 DMA data memory for read channel
- * @mf			 DMA register map format
+ * @ops:		 DMA channel to IRQ number mapping
+ * @flags:		 dw_edma_chip_flags
+ * @reg_base:		 DMA register base address
+ * @ll_wr_cnt:		 DMA write link list count
+ * @ll_rd_cnt:		 DMA read link list count
+ * @ll_region_wr:	 DMA descriptor link list memory for write channel
+ * @ll_region_rd:	 DMA descriptor link list memory for read channel
+ * @dt_region_wr:	 DMA data memory for write channel
+ * @dt_region_rd:	 DMA data memory for read channel
+ * @mf:			 DMA register map format
  * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {

