Return-Path: <dmaengine+bounces-738-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022508311B3
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 04:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BCAB2244F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 03:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0D53BE;
	Thu, 18 Jan 2024 03:19:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624D5395;
	Thu, 18 Jan 2024 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705547984; cv=none; b=dMd7E6DasczxpgMci7Y+gyFqSQGO7Xt/3sBkDgUv0MlFwOjxuoAkBYhtkGXkck8nHY3zzdsjcldqfU74MHayN+jrojlIHGQUDgve9zv4c/1/SqAhuAMyovKBmUzfVUKPp9a/240pb4iSMlXJlh7ygQxK0pSuv8LHlhaOMVbejdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705547984; c=relaxed/simple;
	bh=CoGvzEWgsxwu3UrwcqmHbOPzRseiLOEg/obwf3keBrY=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=eu1ybStLB5aN47L+rtLf8r1S/OKdV17M8dhDGzmGr8kd5G9+LXXJE1wmqY2ni3vw42aPg+ECa0CbAs5t9kciAeY4Z3JeKeN3k6lG4F4gzl1j51d1ZZtKO5HKmVzP/4H8IEeh18X/60g2XsaZ1TwC9AYUiazCNFsSUUzgbxMIaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f85114de2f7f4de78e595bf92527fc4d-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e38ac366-c8a4-4215-88da-3343b4ffb5f2,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.35,REQID:e38ac366-c8a4-4215-88da-3343b4ffb5f2,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:5d391d7,CLOUDID:456f4a2f-1ab8-4133-9780-81938111c800,B
	ulkID:240118111934Z45MBBSN,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f85114de2f7f4de78e595bf92527fc4d-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 476209112; Thu, 18 Jan 2024 11:19:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 788FEE000EB9;
	Thu, 18 Jan 2024 11:19:32 +0800 (CST)
X-ns-mid: postfix-65A898C4-298668660
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8869DE000EB9;
	Thu, 18 Jan 2024 11:19:31 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Thu, 18 Jan 2024 11:19:29 +0800
Message-Id: <20240118031929.192192-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/dma/ti/edma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index f1f920861fa9..5f8d2e93ff3f 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2404,6 +2404,11 @@ static int edma_probe(struct platform_device *pdev=
)
 	if (irq > 0) {
 		irq_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret =3D -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret =3D devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
@@ -2420,6 +2425,11 @@ static int edma_probe(struct platform_device *pdev=
)
 	if (irq > 0) {
 		irq_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret =3D -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret =3D devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
--=20
2.39.2


