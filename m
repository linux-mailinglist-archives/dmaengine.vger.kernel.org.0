Return-Path: <dmaengine+bounces-749-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115658323BA
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 04:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AB51F22495
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 03:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4AA17F0;
	Fri, 19 Jan 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="14wJi4M3"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFD17C8;
	Fri, 19 Jan 2024 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634916; cv=none; b=aPJxZ/TChQY8gphtx/aiVB9hWjylBEo4Mr9uQbAN5R0KE9ELlC5AgodeGmLj3NuUyXi6z5NxmiaSuM5V2nW2GknY+OW3Qj0m/mH1j7ge0uOw5oXJvBxLWdE6Z4m0HYGDvfNsJ/4sMLHrWo7zON1RO8jQlKWDfghK89K0mGHRnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634916; c=relaxed/simple;
	bh=o8JLmxh+Zr5TaLn6Kzhv6UDBjqJmpcfHtG5SQN1RAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9S5vyyUBZEY6HQJkUz24gnSJntmreQgK83tCtdOEI46qdQSHTfqSAR9wG4DRwgZZeOUO47C5qdo1oUbQRR7DRMKGi/loZF6/d3zHP6jWhk6nbLspt8eDrQUqWGlE2QDlFzUgYaAC678/UwaOoVCedhC9C1m2+GxyEQzD/Hf56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=14wJi4M3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=X3NLNdLhXmJpMojSe3BucQdZ/YZ6y6J1AZJ8BEjYwEE=; b=14wJi4M3V2g74XHQ+IqIWMBH/k
	PLC1onSgVMFsNgvKBW3NK5gQtOrJy+fjoEKaM17Dza4hr9DvTGxivb3QMbyB17NSTnJzZMLiSbe2w
	dHQri4tcA4e0Bsk49Fl+vAq1kqflofEfWSYU+D1FOEV779Rtl4SlhrYng//kJQ033lgiR8QGNZH8K
	HHbY4uNkNE4QnIWUQWD/Pl93mAzZbOwTH9FiknwP9jwqXZiZBPDGa0N7HgV+b4KInvzAZeaW2OckT
	Av4MJ617mLBVQBErVfK3hLVxayBKoaNKAmShSQlLDMU3X0Cy7PWqHaFouKShvzSuxWXwkIZZqiBk1
	PHwpHjog==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQfYX-004Oal-1v;
	Fri, 19 Jan 2024 03:28:33 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: imx-sdma: fix Excess kernel-doc warnings
Date: Thu, 18 Jan 2024 19:28:32 -0800
Message-ID: <20240119032832.4051-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warnings of "Excess struct member" by removing those lines.
They are extraneous.

imx-sdma.c:467: warning: Excess struct member 'context_loaded' description in 'sdma_channel'
imx-sdma.c:467: warning: Excess struct member 'bd_pool' description in 'sdma_channel'
imx-sdma.c:500: warning: Excess struct member 'script_addrs' description in 'sdma_firmware_header'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/dma/imx-sdma.c |    4 ----
 1 file changed, 4 deletions(-)

diff -- a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -421,9 +421,7 @@ struct sdma_desc {
  * @shp_addr:		value for gReg[6]
  * @per_addr:		value for gReg[2]
  * @status:		status of dma channel
- * @context_loaded:	ensure context is only loaded once
  * @data:		specific sdma interface structure
- * @bd_pool:		dma_pool for bd
  * @terminate_worker:	used to call back into terminate work function
  * @terminated:		terminated list
  * @is_ram_script:	flag for script in ram
@@ -486,8 +484,6 @@ struct sdma_channel {
  * @num_script_addrs:	Number of script addresses in this image
  * @ram_code_start:	offset of SDMA ram image in this firmware image
  * @ram_code_size:	size of SDMA ram image
- * @script_addrs:	Stores the start address of the SDMA scripts
- *			(in SDMA memory space)
  */
 struct sdma_firmware_header {
 	u32	magic;

