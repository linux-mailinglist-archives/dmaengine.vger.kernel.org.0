Return-Path: <dmaengine+bounces-2047-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F848C797D
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C97EB23A55
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3E14EC5D;
	Thu, 16 May 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="scNo1JGy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85114EC4E;
	Thu, 16 May 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873311; cv=none; b=shyhvhniSQaCh36yQzgGa7g1I3vU1LILglXApuaazeUCezVZ+8PFEuefmjDs75mJT46mFv3ljqELrqNLmsXr1ZZi+P8MZzCYcvWB8F5UiGVy4Q3pnSWC94gJdW1avISvtjo1IKRoOWlRcn/BURc3ApWmlNfR/bR3hw496UGnSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873311; c=relaxed/simple;
	bh=di1GZRJLmgBpATPCxd4yVj2JjcaSezHD7UMbOSdnZj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7388xHf9pqNT4i8DrrwWkXLwdmzAqgVFf2D55aoXMiE5f3HVXjIODyNCNQroh3oFj22o3ahwIYbVom/7UQe0VR4UgcMrOieMY8qfihAFPiafL1MiLn9o1XVuw0pvgwsnIYpnit/XY0he9mFPzmAicWVtrnM/XeFS7HRF/5lPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=scNo1JGy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=neA8hCPvqCeAZcLeUFpcSPDPx6S6NaNegbTs/4vmMac=; b=scNo1JGyBHM+6Urx
	2qDE2MVqgRWPqEAzgLFYIVSMZLFp0qROKw6Y3nrmwTJN0RPehi/zGTDvmILTHY+7Jltp0yEo9TbqK
	UeM/oROQ9R8KFRanNwrCV3QdWn3Zgu14+2d6wXgsuniDoeE/DbQ3z0JjOTCsrq7fMR39+VanzQ5s2
	SkZGdl0IIn4takHuVlXZHYGCZ+DRDgSkaDapFtAwlNLn0BbBorf1OhjEBRhqZlhYKWG3HYZcsmG8z
	KxXqNozZpPsaPmIW3rT5zzbl/AJP8MmfDCZKdvHjVLCfvDGhIh9Wc2++QNSE2RzBshtWMXXp4euc+
	E/AhVlmxOogTwKeSxw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s7d1t-001Fxa-3A;
	Thu, 16 May 2024 15:28:26 +0000
From: linux@treblig.org
To: Frank.li@nxp.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] dmaengine: moxart-dma: remove unused struct 'moxart_filter_data'
Date: Thu, 16 May 2024 16:28:25 +0100
Message-ID: <20240516152825.262578-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Remove unused struct 'moxart_filter_data'

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/dma/moxart-dma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index c48d68cbff92..66dc6d31b603 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -148,11 +148,6 @@ struct moxart_dmadev {
 	unsigned int			irq;
 };
 
-struct moxart_filter_data {
-	struct moxart_dmadev		*mdc;
-	struct of_phandle_args		*dma_spec;
-};
-
 static const unsigned int es_bytes[] = {
 	[MOXART_DMA_DATA_TYPE_S8] = 1,
 	[MOXART_DMA_DATA_TYPE_S16] = 2,
-- 
2.45.0


