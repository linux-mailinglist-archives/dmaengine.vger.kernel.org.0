Return-Path: <dmaengine+bounces-7011-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAE0C0EFDC
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46A5634EBC6
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611E330FF2B;
	Mon, 27 Oct 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="ckYcNptf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E930E820
	for <dmaengine@vger.kernel.org>; Mon, 27 Oct 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579312; cv=none; b=NQods2CxQpiAKOqXUk01khRa2FcdZ7XAemQsUeonG54LV6rC6E/jH4DKz9+ASB2KrWOOBi2bXCNgUiJ+QU0L0uBfuBC05/1MY17/anFagyooq0bONKNkFUuzohy4kx9aQTsHGU2OZ1ha3TnG7ZZ2PMNfgUCgzMhG07b7+cu2JUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579312; c=relaxed/simple;
	bh=HAH+bZftgRekdRpjHFPSJmh9yCiO5wblxmXyRfc24ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tcNZVZtDpsWt08jA7EXH0u991n/RThe1NYd4GLLeVO8POHZUkT9nbdsdcmH9t5qzFDfJu8VFq9m2/eLLNfqSlznr48Sx9zlB/a0mwtXirF54pb6dALeFF9h1r1Al94ubZMECqPoGkhmMmdCLr39OoTEvJqa1SwoFMelHUsatwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=ckYcNptf; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 93134440EEA;
	Mon, 27 Oct 2025 17:25:00 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1761578700;
	bh=HAH+bZftgRekdRpjHFPSJmh9yCiO5wblxmXyRfc24ME=;
	h=From:To:Cc:Subject:Date:From;
	b=ckYcNptf+NA4zuTDRu+K4TBjZQorFLDUSSFvdtWTwlyauoIPow0nTl4/daYHZXKw8
	 7CNuNmG862vQZ3aC3zO8qgKq2YOt2UaN6QBizkIBcEwpb6BEdnv3fkfs4qlrtuU/hT
	 ebv/EVenlb0inrRHAj0hn5yN57ju9wehaRJG80U9yJoHeQn4P9sTl7kIV2uWDyFt6r
	 ufCie0ldM1MpNQdj3X1+UwzSHwnnSRT1re6O1GH3zfGI7K+h6niAG2+ievwYstWeZx
	 8iVES4g3mKBo6HXliUYsqfSomD8cYPGXUNeOOvoo+6mru278T/scGcN0PrO57pUpmW
	 YfqrUI+FH25pw==
From: Baruch Siach <baruch@tkos.co.il>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] dmaengine: dw-axi-dmac: fix AxLEN fields value
Date: Mon, 27 Oct 2025 17:26:16 +0200
Message-ID: <a25516090c8b7fd9ac00b5cc570ce6af4d3f5371.1761578776.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of ARLEN / AWLEN fields in the CHx_CFG register is set in
terms of AXI burst length, which is the number of beats minus one. AxLEN
fields size is 8 bits, so their max value is 255, while
snps,axi-max-burst-len max value is 256.

Restore adjust of device-tree provided value as it used to be before
commit c454d16a7d5a ("dmaengine: dw-axi-dmac: Burst length settings").

Fixes: c454d16a7d5a ("dmaengine: dw-axi-dmac: Burst length settings")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..9aa79e9b49ca 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1437,7 +1437,7 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 			return -EINVAL;
 
 		chip->dw->hdata->restrict_axi_burst_len = true;
-		chip->dw->hdata->axi_rw_burst_len = tmp;
+		chip->dw->hdata->axi_rw_burst_len = tmp - 1;
 	}
 
 	return 0;
@@ -1550,7 +1550,7 @@ static int dw_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
 
 	/* DMA capabilities */
-	dw->dma.max_burst = hdata->axi_rw_burst_len;
+	dw->dma.max_burst = hdata->axi_rw_burst_len + 1;
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
-- 
2.51.0


