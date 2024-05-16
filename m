Return-Path: <dmaengine+bounces-2040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0488C77B9
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 15:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6021F241EA
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3541494B5;
	Thu, 16 May 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ErYzkHah"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1D147C61;
	Thu, 16 May 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866341; cv=none; b=TbsmXi/JzAQG8fnNEwkintUBbLC/bBBKblwLdj9gM5SHw1CA3UMiJN6ZUoS/Zf2cRz+req5YcafLkWHmgMd3+jdS2wcbe2nA6lEQ/jkYaYWX0adza2igknZyrNJRzf4zIBLtNulj8Xgl3cMRShDYsrl6TXACj7kUN5R+g1ahD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866341; c=relaxed/simple;
	bh=01IuugKFs1TO1EARsfz7nuAdLwUwvEP2HFszcaFyaxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZJz/b1wT80qs9CRMRJyLmrpo5AcBwoF9o327Kb63sA/0XegJ9dvIFKZSjllaU8OHKUnWg7WOdfvG+83rzvr4YNSzY0lCg8mYVS/Ow+Do4Q+djjMo9chn9Zu2tXoOeJLoOXro6nCHDup2qzF4IIHh8b9MhJ9IRNDgx8RkqkAh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ErYzkHah; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=6mSknBO9EubKC8J70dPwtKc2fEkRwPKRV5vVexHKp1M=; b=ErYzkHahAgKKML1C
	6W1/D/j4WDc9NXKqTnYoWLJAxzesQcVW/1T41cdgAj2qI9/iQQfFBTUqm1IqaPEV9QT3NhqlISMGk
	8Ura7+ryN81MiqR6Zk6SkJPib+twJYxItVw9AGeaS2aVJJ+aATYaHFL1t/N2vwnpNgnb99qw13gTP
	I/qLkdEK8a6tTdhsjFLz19pH/k03koQ/QwLtXtHmWSyPYjEujceA5b1ES6bSBRq02YqVORTmbaFEv
	/SS4+88TnKw5uqcvrRNfKlO37p2z7rLOX7nJkyl1kduyElgFp2uxKG1E12z3Tt0Nx2sNExKqqCmMI
	3y4gWnSkDe+gO7fPyg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s7bDR-001El0-0C;
	Thu, 16 May 2024 13:32:13 +0000
From: linux@treblig.org
To: vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] dmaengine: qcom: gpi: remove unused struct 'gpi_desc'
Date: Thu, 16 May 2024 14:32:11 +0100
Message-ID: <20240516133211.251205-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'gpi_desc' seems like it was never used.
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/dma/qcom/gpi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 1c93864e0e4d..639ab304db9b 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -476,12 +476,6 @@ struct gpi_dev {
 	struct gpii *gpiis;
 };
 
-struct reg_info {
-	char *name;
-	u32 offset;
-	u32 val;
-};
-
 struct gchan {
 	struct virt_dma_chan vc;
 	u32 chid;
-- 
2.45.0


