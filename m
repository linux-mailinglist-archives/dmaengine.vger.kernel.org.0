Return-Path: <dmaengine+bounces-979-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC884D3AF
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 22:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C28F1F279E1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 21:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E412BF16;
	Wed,  7 Feb 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg15/r68"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F812BF03;
	Wed,  7 Feb 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340911; cv=none; b=ob2Zcv75FmxDrKWXPXeoLiucj3SjdHbNcE84IMfQFF5OkydEXtcF5U09UUTa7ocufrumhiLz0Xu+Qf5MnfFfiaknxMfLTFFgYpBAoLwXlnVucO8Dz7CC4Q+XulpoYOMKfdLcKU05w7XiFOFxNLhdzNBcCSkrKQNl5ojqGUORBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340911; c=relaxed/simple;
	bh=aJvmUaiggQ0iLWKRJiHo0hkfMIltzOhZKXRJXPUm/mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBkd6ApyHeu8NdE6+CCLhXPXvhZUwZSAutjp7A9BkDLnMATz7Fmv7rb7U0ymKIOVuUIpS5ChIxD88/oSOAAayW+Qw/fL8MNH1Io9rFBaQEPCUygTvkDCSya7Rw8xH3vhISeEgL/n+7ARrxgGSS5P3hAt1i33sPmpq1QYe+jV0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg15/r68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1542EC433F1;
	Wed,  7 Feb 2024 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340911;
	bh=aJvmUaiggQ0iLWKRJiHo0hkfMIltzOhZKXRJXPUm/mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qg15/r68OpRa3br74eJtFHKOKdCknG2I+q6JiQl5cl3u82paDwaInY67r0495QtYl
	 7PHdGGE8JDeTLEN3ZMTmSWenlqiaX7lwXdH1dGy7cvgcwYMtk3TU2GgAMvhIP8NZ4h
	 KKeWxVDdCQ6rpfcclAbbx6UqveNFfn/+j4VV2k1l3knM2tpqx04VwSk2J00Hw4/ujf
	 XSt28WMjON1m5aKKi0ZkxXTjcCjtjHI06spz5uoE1fD+koPEXd1lR50jnVmrtfB5Cv
	 3fGFrFUJdJ/PmYcxJbAKwpbvC/BRSFdmuHkohw9D6n4UVaxt/YRHDNOWidOj5dBQl0
	 0/4moJK/0PAJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.ujfalusi@gmail.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 05/44] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Wed,  7 Feb 2024 16:20:32 -0500
Message-ID: <20240207212142.1399-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index f1f920861fa9..5f8d2e93ff3f 100644
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


