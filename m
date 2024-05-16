Return-Path: <dmaengine+bounces-2045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE78C7950
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DA11C218AC
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2014D2A6;
	Thu, 16 May 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iLZCy361"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212914B978;
	Thu, 16 May 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873143; cv=none; b=Xg/c92+xgVEvRlIWMWUjva5vPT5YUlXauE/dbfLlLu+HLLr0rk4F+hc8g4NlJNvE1Hp9ogyJ5PqBRgmMqJrTgTZU1QqspLBGn9GT6xS/6OWfpr7qcb6KRYR19YqCThj2+r1H5OE2CRNbJOgkVkuLcz9DbMZy/BTyyvlO+6dhy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873143; c=relaxed/simple;
	bh=hGfVsKnlF73YWywbUI29LsVh2p3CnwhJ6+xsLn/WQJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDMUUpC8dFyRSaHflAJMIutj2pUfirwYtuj84luy5RLBXp3Z6JpL8uqWuDHgHY4duojiL8HZZcKCLJzAng8KIH1dJpvRoYweWiPDPkJ33dXdvKSaZfVUjFysC8lFQLcyG3DO56dQWmeAXfjfgfaj5zR0V0z48RRBM2VY8ZC/AhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iLZCy361; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=BGzWo7GIA9rEqXu1Fx5xZhMo333Nfcva4FL3jI9t5eI=; b=iLZCy361KXsnchbc
	7WryquTQIuFE7JMtoJ2EBNL1yrT84k2GYumom+ehF1q7/3EL1ZMiH/Lsn/FrO6PztVdtgU2H8R6NC
	RblmdRvy5s52LkXxHuAvppQsNYwSgCWafmU6y/grvl4N6OWKMQjBtpbVFkHDmVcdpa6RggaLacxSF
	tCT5O5h1SbFtw7T174VPjb/2wcfPbrYICd62vbhKXCvu3SM5kFO3W9xwbh8YBVMttQ2WaUi5LsDcj
	+PzKTHMabkQ46+c0BxYwvOS19RypImpWS81MvqX6yLpYf2zC5UcvV1LDmo8YsVsLVjptt6OSArA8f
	SPQqzUcsbzQKzojGdg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s7czC-001Fsj-1a;
	Thu, 16 May 2024 15:25:38 +0000
From: linux@treblig.org
To: Frank.li@nxp.com,
	vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Date: Thu, 16 May 2024 16:25:37 +0100
Message-ID: <20240516152537.262354-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Remove unused struct 'reg_info'

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


