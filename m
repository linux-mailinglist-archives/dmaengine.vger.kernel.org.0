Return-Path: <dmaengine+bounces-2073-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE178C8EA5
	for <lists+dmaengine@lfdr.de>; Sat, 18 May 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDD51C20FAC
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DCE21373;
	Fri, 17 May 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hef0ccMk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D61E532;
	Fri, 17 May 2024 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989231; cv=none; b=sy9XMG/fAk8II9WLzcNeCBnrc1Hq58l2jVFen0W8WUwbzESir8K56UzJ0K/znbRKdId1N+bCHT+NqFG2y/30+2xw86krHMon/G2jCmD5RFKMKI9B+h8N/OJUFgL1Gv9meBjH6hYKNqePvJ3TBVld9Dk+C6eM0DKzJq4/mqfWUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989231; c=relaxed/simple;
	bh=EbcGsu68PZs6YMorBBHXrC/XlmobCJFUtr4UkFQIzos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYPUuQafJsmnboUfsZA5m6cCJ7fv9fWc/7uUww+Z0GS6JyvbBoFtOWtOVm0tBSSgoZGo/sjVBoLxmAlCgvh/qn61eG46U7MhgosQLnSgHv2pEbZLjePQkyRP2b3CmCLz/ztyo+NszcfSrmupm24qa4dExRJ1dQYVC3fzO7zL0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hef0ccMk; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=3qNCRDcZrDXDBZ9tebFpsjEJNO21Uv60Te8I/i8hwtI=; b=hef0ccMkT7huQjPO
	MXs1ZI9s5ZuddWNiK6oQqB83EZMxhSpD/JqhRxG9wknFHacehU6CCnFYSdxgX6NBa4MghsINHA/nq
	LxDf1vXnEu5ujXdp2uwKx+wVGAjlY9BueLFl2PERQyvAaedWkiGVp6AbnXltKWIPCE/CdePOCdb9d
	KfZvEUNZBmg8H2/IecbKiRkhlWMyjXZF2QUU/EzF9GFiX8k7F8khVCkPP/I/Vuxtyb6bwH2afqnRq
	HHS1q1Yq7O1gRCQKIMAI1TowBTCOQ7Qob2kQu9Jjv361JB4L9uiXSqXb/Fv9mZy9vsEMa0ph4qWcH
	TFTZLRx5Lb9RQ7l/XA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s87BZ-001TwE-1w;
	Fri, 17 May 2024 23:40:26 +0000
From: linux@treblig.org
To: bryan.odonoghue@linaro.org,
	Frank.li@nxp.com,
	vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v3] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Date: Sat, 18 May 2024 00:40:24 +0100
Message-ID: <20240517234024.231477-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'reg_info' was never used since it's initial
commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
2.45.1


