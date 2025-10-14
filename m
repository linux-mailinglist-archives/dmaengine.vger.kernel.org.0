Return-Path: <dmaengine+bounces-6831-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1263BD78C1
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 08:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D20234F790
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B02E7F2F;
	Tue, 14 Oct 2025 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZFjxMD23"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD392233D85
	for <dmaengine@vger.kernel.org>; Tue, 14 Oct 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422425; cv=pass; b=trKdgWRRcn7pYKoQ+1Wks6EMqir0pBdIvVq14jROsgG24oUx2Fz0IGdysGil8sf4CYOm3IK1ScX+GVnUC1DTaYP4ZQsLuQd8tGX7AcAB8yE53+khpl3PKUCzeHH7WAUI9wbYrORk+QGmtMVwT5clU6n1NQMymSK/kDhFNdB69R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422425; c=relaxed/simple;
	bh=yFz4PdyqYJFhzQVEuFKOr6f/AIwY10aAgN3b8pVVr2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjSLcvoxIDr0JD2oC1g39+lmbo5HUKpPTd6TAFgI7WHTM61dh24Zlh8vL1HALgRPM2vaJlcTmnK2B9tyjKf1++b6xNxjTwFMb5JWhn8YOqhrrHrNfvfXhnudp8l8Qv1HQG3070su01sZYPSJNEdm4E3Fw6Dx4KT3D9b/FmSeYXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZFjxMD23; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=PpsJpdZ6guT9xK7H6Qj9swfceklHrTMmKM0p/QOrK04=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760422401;
 b=mnpN8ALgbboLcOjq9bRJmD+ucam5WYhZ106ItDiSmtXmONmX9WyMtpQ9/iWF9rcJjPn2K30e
 ZxJqhlpNWJkqVgYr+W6RcYOFcGZ0Z9v/IIg0os+D0zhDNBvgRSLcnYcEgNohJvVUbA8zFVO1sGZ
 4CQxjKjCy4AXXxxEumobKqUHnZt4uALteBrGoNPbIkKCJO1KgFW7+g5D7v3Mp96EOmFdXibk+V+
 Jw+Vuyyw5+xWtagKMHieHZLikoC8u5vIDq5RzOZC1cgSuxRQHBZ8zOMqVprpBT4rC/R+AhhiZA6
 tdAogamGg8pGZWpgJmFNblZIxePfAK6FqXztsyW3/7e3Q==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760422401;
 b=E0d3xPV1FIo+MRFG8GgpKOaClk6Jxv8mPYATgZjCQOswi6V80dCUYW9U8I3MwN6wdtF0zijJ
 6KPmDdIxCWfZrzNe55CY+04rYos9S9iIsTu64dEz68lbUb4+APs13UXq1chWf8UxG22O74oKiBD
 qnmvJVMkMDuELuSF283qWMNdp8IFRKESxsedCy2u+5QtOfiu5Gqibb2EbrCKeP8Ad8UYd/cnXra
 zGJIcTrliPMYKmvjNHbdN/nQeuKKd2iJoFDiVj4q+bQ0G3GZupSmP06hWhs7Wq6BV7ChbZ1VQ92
 2JSagacX6A9IZNdX/uv9VUkWZRMh7zf35jGvNekQdEmOQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Tue, 14 Oct 2025 08:13:20 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id C106CCC0E51;
	Tue, 14 Oct 2025 08:13:12 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: xilinx: xdma: Fix regmap init error handling
Date: Tue, 14 Oct 2025 08:13:08 +0200
Message-ID: <20251014061309.283468-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:dmaengine@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4cm3mn3JBlz1kP5x8
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:76f8f5f97ba878a3b36a039ba441326e
X-cloud-security:scantime:2.082
DKIM-Signature: a=rsa-sha256;
 bh=PpsJpdZ6guT9xK7H6Qj9swfceklHrTMmKM0p/QOrK04=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760422400; v=1;
 b=ZFjxMD23jjP1curKs7wu6nj25fjo95EYF5sFzMZ8FPQZGSpvVkycGvaObI3eJle9hrn/yCZ3
 3ygAP80DljskR+tIr7ShJ0JLYicKmF5eia9OKNirPk9a2Uk/hq46mOv1gTu5GRKbofCWRvALD/c
 Ut4fxQ+jXxVK5WRQmIYjR8XveTbDJ39+b1CTIFdEmLqPvdA+A6LSqV1Lc6V2lP3TEQ+t4GwyVw3
 Xq79eLbExDAv2curH0rlaRSmvgVG1qmkBOzawJTMQ8WdG0QqFpBeQf+HadbwrldpYSeyWh59R+N
 +FmQ/X4gcLfNImfN9+GE14sGPsrAv2VnTsq1UlUAEHfIw==

devm_regmap_init_mmio returns an ERR_PTR() upon error, not NULL.
Fix the error check and also fix the error message. Use the error code
from ERR_PTR() instead of the wrong value in ret.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/dma/xilinx/xdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 3d9e92bbc9bb0..c5fe69b98f61d 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1325,8 +1325,8 @@ static int xdma_probe(struct platform_device *pdev)
 
 	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
 					   &xdma_regmap_config);
-	if (!xdev->rmap) {
-		xdma_err(xdev, "config regmap failed: %d", ret);
+	if (IS_ERR(xdev->rmap)) {
+		xdma_err(xdev, "config regmap failed: %pe", xdev->rmap);
 		goto failed;
 	}
 	INIT_LIST_HEAD(&xdev->dma_dev.channels);
-- 
2.43.0


