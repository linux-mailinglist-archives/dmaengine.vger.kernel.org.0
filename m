Return-Path: <dmaengine+bounces-982-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B584D4D5
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 22:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7811C23532
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD416CEB3;
	Wed,  7 Feb 2024 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HccgynSs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345016CEA8;
	Wed,  7 Feb 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341179; cv=none; b=L/Hde++YDUQldNhO7yxgri432z5nND05TFFpdu0KkvAh64++kFQMmQgx2FFP6ttwFJn7j71C6neRi0eqtjap28ctaOPFYpS2BLgZhPem4om1a4/97pLNEsmClqdNlxT2nww0YdYNyMltzyQDYWqspkHvxIqOkwths2O2CoGKcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341179; c=relaxed/simple;
	bh=9m1jj0JfmvljBoVsanyPCb70uqWdNvxZtOaXmyRb2l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yoau8/0H5NJalYcCCRaOSu4bWLPkwj8JxQwXTPNtFIR1lzT2EJxXbMKxPeySxCv6k7QsZDejBC2inuwYeLTasr7L2NZpTmgT4yXmpwWwceKX5hewPC3Ba1EIl6obzSt+ipcEjL5OwpMoI03p9vhPGNDVwPprC/WfLTBhsSUVCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HccgynSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C5C433F1;
	Wed,  7 Feb 2024 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341178;
	bh=9m1jj0JfmvljBoVsanyPCb70uqWdNvxZtOaXmyRb2l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HccgynSsX5IseWwfBoVCdJtv6kB1xfbeRtxr/0bbO9MSSm+SewfExoKPKXCO9/7Ff
	 e3bJ3O0NhWsIdHj0rdIsy0BtCqPtdIZKS2zJfwSVSH9aIHksN+WqtvjLWg38ILI/J9
	 7ys4SUj1/hmZo4xakuIHGJQ3Ajkc3ck44IJT1GT3eZKFyl95vVfpjGSdPtLY13lv1W
	 MleNsloRCP6DJems5+q8vM1bzINaEB8WzGxcJSj7fDrevak3xEYBOew2hQRt2SPetW
	 PuBi85fgZJbYlf4cKXqekHxNwCJ5rgkKUNyTJT8+PZ92/iuK6/3cuc6Pmoa+2XlcMK
	 +TClaraVOg3Ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.ujfalusi@gmail.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/23] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Wed,  7 Feb 2024 16:25:45 -0500
Message-ID: <20240207212611.3793-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index a1adc8d91fd8..69292d4a0c44 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2462,6 +2462,11 @@ static int edma_probe(struct platform_device *pdev)
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
@@ -2478,6 +2483,11 @@ static int edma_probe(struct platform_device *pdev)
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


