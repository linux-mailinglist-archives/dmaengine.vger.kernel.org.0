Return-Path: <dmaengine+bounces-5021-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DBA9AC61
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 13:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CDA1B667BD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180422489A;
	Thu, 24 Apr 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JR1HDn9G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33101225A20
	for <dmaengine@vger.kernel.org>; Thu, 24 Apr 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495333; cv=none; b=svrAobvlxWvT758U46AsRL4LP+OWOldkgOzxZNDGT2ZLoDgZ+25YivqPK/MR6UdZ1pf0f9f2tQtLaI9egCGcM0ODimavbiJnvUgkAb0p83zNJjQt+j0+oLIc3xqAkFYZgz3Kuk97fGbJH33jJoOKMzdk9kUtG95dhspc65oodps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495333; c=relaxed/simple;
	bh=hLk8B885yjx7fuSvoTeaR5hpp353sG7sSlOLWVu/Oro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ef18wzByNMh1Wj0T1vGaedcr3tpAbDENyJ7YSR1ToJk4s865SiGWjKSGP++gmjP9Ww/OTu+/L1rL3xlA2knil0M3Wj1cJVhcSfyzV6Xi3RAtMjsr3PNIdhdjYMs5wts0usBd//jEJ/IGzs+4k2SLZAwS4lVM5b8mN6AYeeDyFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JR1HDn9G; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745495313; x=1746100113; i=wahrenst@gmx.net;
	bh=hutk4RUyOyPo6YZkclFLVE+p5t8Cn/N1Q0b+EB4iz6k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JR1HDn9GJANMv27lLqa0WWP3EFrWL0T5iwIUdjgqRtJI3kNpPejwNw/CGQrGyPg2
	 u8l1oAKfk+t7ao/8cJ8K6Yw4eHevGckDxLeHV0tYB7IK3aqe20J1L0PKIJ7GEbwhr
	 L6E3ssLtrxIk0UlYGxrz9NWfAlz/h380dfLdm5HRGitp4LWMhe1suCppa654G2zqC
	 KR8+AM4h1Pc+3/YymKQZNZUYlm7AabZ/ZLrYxvivrNyve9KIHwwKisujwxnKWuRDH
	 BgXON+BP+xCua7wEJX4cal9P5udL5ApljA0+w3Y+tVXyd5Vw83Tvty8llQecMRf3v
	 JmdkIw5+eNUz3JAqvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1v19HV38Fk-00wypZ; Thu, 24
 Apr 2025 13:48:33 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Frank Li <Frank.Li@nxp.com>,
	Joy Zou <joy.zou@nxp.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC] dmaengine: fsl-edma: Fix return code for unhandled interrupts
Date: Thu, 24 Apr 2025 13:48:29 +0200
Message-Id: <20250424114829.9055-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FAyuvXCFAvR2VD5P+D6D4tYGbj2GzXT90o/v43SSsSJzPqpdXUV
 Waqj5QX75GJle1FN35esWPnCLWpKsAAqjRsUh8dpk0w8mSrS6JrSW0YryFHWH9FOMQEPIvh
 yPop1Pc3ejZyQGhYAUStY0igVtfyX6F8G5c4wNukS+rWj0XLRhKgnJB8zXvDUzsH00T6Xgz
 A/GdiYc6fLCBtroWdk9ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hJDQupgkjFk=;g52Ofk9lNmoOU2BinfTRp/DdNZb
 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
 poT0TlqB1J/ztfisbxlTb8=

For fsl,imx93-edma4 two DMA channels share the same interrupt.
So in case fsl_edma3_tx_handler is called for the "wrong"
channel, the return code must be IRQ_NONE. This signalize that
the interrupt wasn't handled.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--

Hi,
this issue was found on a custom i.MX93 board. This patch has been
tested on the same platform.

 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 756d67325db5..66bfa28d984e 100644
=2D-- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -57,7 +57,7 @@ static irqreturn_t fsl_edma3_tx_handler(int irq, void *d=
ev_id)
=20
 	intr =3D edma_readl_chreg(fsl_chan, ch_int);
 	if (!intr)
-		return IRQ_HANDLED;
+		return IRQ_NONE;
=20
 	edma_writel_chreg(fsl_chan, 1, ch_int);
=20
=2D-=20
2.34.1


