Return-Path: <dmaengine+bounces-4287-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B1CA2864A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E83162519
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046822A4ED;
	Wed,  5 Feb 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gdSdf5Uo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073C22A4E8
	for <dmaengine@vger.kernel.org>; Wed,  5 Feb 2025 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746908; cv=none; b=aDC8Iknq6DErOBJzaqiDVoms5jgbys+kSTbh876OB50LxuSszWRNxvpyNwVc/90TAyYDtrgiiaiwgHJnkVQXag73NHnwqvpQ4qlOyMEYOoXDelzEAy/eamnlCdGQRKGQNMU4cPaPWC6Dv7IZVkFbdQVPvfWoC4k39L1GhsecsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746908; c=relaxed/simple;
	bh=+HTs+0+wmjplmTlF1MsIF+Gs8Lm+3JvuR67gIzEXMyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TOGxeAdNhRf2IVZWNnbPnm1dSWp5WKU3Hnm1eqtaqzDWW905lG7zEHOZlOd/5YT3cCFJV5Uql8YZhWbWOry2A1ZgQ81usRU6P5+5ihdzVhRDOvUqndvoG516UI6ak2jlWdqKJXTh6mMZYKvXKA18XYR2a8kg7sVY/SFK+C2UeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=gdSdf5Uo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738746900; x=1739351700; i=wahrenst@gmx.net;
	bh=2A918m5WblqdxZRwWXCpCtnsbfQzvD3ezaQRiGQ0OZk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gdSdf5UoAex+CJyqTA1htr1kIKSUec38Yru9csOJ3LEjgWqXI2Q+TgZLnNBQBScV
	 T6XNP3rSXzWobECz0/jaBzfKRaUXm28TPhq18I6CF2IWta0B9TdhD+zaodsF7SVYx
	 DaTh/OlhG8ngGbBNtrtLgjwLPk2w40n7HDAgcJIjRQgmMIOWzb9LM9Wl/fTclTeKa
	 WmfaRWxbJF0eE6BxwlPVYebRbZ9c+NAEGXwpNeHA4Mz2dwpiK8Y6ac8pcrPN4uA8E
	 ptp9DRYx+OIU3xLyI/Mn9+uf7mRQdx+EkotsF8XPIJH0ZWeJLnmh42MPCXVqKjsMA
	 QoxNFs94/Zw1BEtlZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1teTRQ06bk-0043G3; Wed, 05
 Feb 2025 10:15:00 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] dmaengine: fsl-edma: Add missing newlines to log messages
Date: Wed,  5 Feb 2025 10:14:55 +0100
Message-Id: <20250205091455.4593-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xy0ceuF3uei+bfXg4V8RdPMeoKjKXB/vEhBig3rLeh5f5WZs7pJ
 I3pMEPo7WKAQFPtbImKgdeTjBTcClaVakXlohXKRPaDFRML7/JgR5PNsW6u43GJRjDFAzG+
 xwnBDyJFSG9Yu8hR9+Zm4x5nIjgegoiu73uduzGp3ULZTxsqzlSCjlJ4Q6rJyuQ8YnS2Yf1
 UMRDCuNTSrYjwS5fs6QRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wk+OwyKKNM0=;MKX+Q8tjGBKVKymSD6Rdq+e+m3D
 IPVdPN+hPILXt4m3LqGwmlmifbMB5+TkqBWq7mzqpx+bxY57f0SCXg5nWtTT0EVnZ1UAM/p3z
 Wq3d//gU0c8Lwl/NGPqbJ3KEJAzWeRdfbxpbXLnlzqoLaqDUrkfw2YePotjHecmHnghbp7Vqv
 P3K670/0NkCuRXL9BNHBf+ycBBLvI1PLxuUHuaa7XCOjx3rd8yV7iscqCC+nSpG/6dXrOUE4c
 o55YhtR6mmql1rZsWHf9KGQWs+i39UvpIIEJzdNTjVuoVJGRplj0cgVcV2O7NpvT3BBPMFt6H
 j/ZcS469YZhmTbQmG40/vTW8CsXJaN0r+wodbT/ta+TA+2Uqgho4yJ84r1vOv9d7eTINocoXG
 iK6z3zMcgrVYfgNtfFRBkvDnN6L7NCssbcynDrLvql6buUbl6czLpyy4PZNHm4l9jyzZTPHPh
 Euy8jfFbVcqN4qmd8zUoRq7xwGa3YW8B9p/gXr1uiPPEEHi2UCsO80tmeusc0WSuX+RlUI2Uw
 vl0OcSLMyIi4cfZdtQSOHnxTwSEtfm9LAxZPOl0xxHMOzwZ9Yy5el2VusOr3vLzJvb99/4uwd
 hSIGVzeqtdzOFbQdrnZcR6tWlk/JaSLPmkSp9BgEyN/SoRxUYmMVMsHorZSJ5NNxRV4AbYorT
 yV8ifbeU/2Swku+WlCJHy/6nu1F8EYnpm4wYXVN9q6CiLwYMfKmWkPM/2fGOT/mrrTfGXBRFQ
 /cuNu3LnyeWmEpjH6hsGPfhO+A4IhgGBbEDkWc2h3AMPrPaZtHOhiFo6KeNIaTTUM5hKnLf6q
 acG0qLJZnNob2z+PA8vgXK5CBsyma66Oby0UtYWYgKOrhFCMZjhZcTJWmT4MR2JTo3MploIoW
 83eF4loKy8McdXa/14/ynbwU52eGQiNRtSU7Im+4hZwRPDshJTDcZ1dRtzS7h/Oh8xKpeZC/r
 TwQ7D0sghAflnOHr83OeHovESUe/T0KowlA8NlQmiWVilDYpt7RgwelndT8cPvxA65VCvNS4U
 38+IWsz7WSKk72EN5pXp4R3BfUiCvLLHmthnNofHm/q+BSOO171hrXVANOqQ+Hsp2lbh8BYZn
 dIo42lSypPSj2Tqk6xIHTXBORk9gisgLa9apNM3wCaPqFv61bjK1DAr/ZjUeysYSD7fN/BO9p
 tKTechWZ/GGwevi4c/Q/nrEvSQd34j2pY62HsjUKZPYsj8kxLNGuw963neAH+NJllqWkjaIBk
 5WdiC1JVAazJXJrJpL6+TFG26Gw3SqOcdP2P4tKNUTKbRUtXqXoKvhfzabA/VOGiL1kCob7PY
 kgjwx8GFQweKnmWnydS2XM1JtLvft6V+24vhgU4+6Zmvb4=

Not all log messages have a newline at the end. So fix it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/dma/fsl-edma-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f989b6c9c0a9..760c9e3e374c 100644
=2D-- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -164,7 +164,7 @@ static bool fsl_edma_srcid_in_use(struct fsl_edma_engi=
ne *fsl_edma, u32 srcid)
 		fsl_chan =3D &fsl_edma->chans[i];

 		if (fsl_chan->srcid && srcid =3D=3D fsl_chan->srcid) {
-			dev_err(&fsl_chan->pdev->dev, "The srcid is in use, can't use!");
+			dev_err(&fsl_chan->pdev->dev, "The srcid is in use, can't use!\n");
 			return true;
 		}
 	}
@@ -822,7 +822,7 @@ static int fsl_edma_suspend_late(struct device *dev)
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(fsl_chan->status =3D=3D DMA_IN_PROGRESS)) {
-			dev_warn(dev, "WARN: There is non-idle channel.");
+			dev_warn(dev, "WARN: There is non-idle channel.\n");
 			fsl_edma_disable_request(fsl_chan);
 			fsl_edma_chan_mux(fsl_chan, 0, false);
 		}
=2D-
2.34.1


