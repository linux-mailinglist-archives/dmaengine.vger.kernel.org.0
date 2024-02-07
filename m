Return-Path: <dmaengine+bounces-980-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC284D42C
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9637E1C21809
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 21:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23912EBF1;
	Wed,  7 Feb 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo2V0+ds"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1014460F;
	Wed,  7 Feb 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341026; cv=none; b=dq2/3vWTUPz9HajNd4KxBrsvZSpgwi1k6SMlU6tnDvFzYb6AB3YeIbuFbBggYu14zmW0PMKlHvz1ARO+YgVsxQTzS8GCeF777kbcpLqDHswPtDpQpeeSToziHaGCeBlH/esl0SVEgvNwxrVBo0gNBln+qCZcxLnyyvIOICBZXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341026; c=relaxed/simple;
	bh=0YpCKTLThLkhX4Tktw9pXYZ9gVRBvU3mBo6LJe4QwEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAScUSZPW+70eC0YJO9qGhrgHw0pX8qYhXHqBgdhW7ds2anyQ4aXPhqw7+rePiiCnvgnyWxblesikd9djpOumoILqLfKqLyCce5mZ1DCyNkAs3Y+SjIDPDZzP9919txGcrmWFeSVajNV+eFZ1zZ72NCjixSa5rtzZ1dKxRoCJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo2V0+ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB80C433F1;
	Wed,  7 Feb 2024 21:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341026;
	bh=0YpCKTLThLkhX4Tktw9pXYZ9gVRBvU3mBo6LJe4QwEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo2V0+dsVvAAnlwUzuNggOyAVAac5YUon7+xndKjql9sweDzThVFs/T/V6c+jKPvZ
	 R0bylp6QJnRv01oaGozkp9IJ5c+e7znMIhhmpRkQJ8I/BC7Ajv04qobBUL2V9KEMSe
	 1oPzPE2RiMGWudqqgM2x374n+dN0ufOaNXgnsWD+8As85/DyjjEvpHRKcJOPm3aJrU
	 gY/agjrfZ4NGrrazG6HhxGvLOPU1KeEfgTp/gMdcuWxw0swgoVc4uDkG2ItLjECxHI
	 Hrn4W3yPsdbvBgqmBK4qlq8CgY7G2MSsVxOxl2QwOs/Iv6VdKDlJaLnJWVKHvZ/86G
	 xfxQ+sz8WmZ/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.ujfalusi@gmail.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/38] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Wed,  7 Feb 2024 16:22:51 -0500
Message-ID: <20240207212337.2351-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369 ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118031929.192192-1-chentao@kylinos.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/edma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 33d6d931b33b..155c409d2b43 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2404,6 +2404,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
@@ -2420,6 +2425,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
-- 
2.43.0


