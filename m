Return-Path: <dmaengine+bounces-981-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD4184D48A
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 22:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BEE28BDDF
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76E155A2A;
	Wed,  7 Feb 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgMHosK0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D7134733;
	Wed,  7 Feb 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341114; cv=none; b=SYRaeKwWQTj5pPHHVg9YnIva02gdu3WPxKrkh/cDym+j0HdH8v+ZymJkrlhBgW4b1HkPeoE8niPMfuPLBhQWJsdAgTgT1uCHmFhAEEwoV/0221jFAoEz4qvfuk0LBaTu+A9RISs3XXj+IhnHBoAs0KxPD4My+8jJngqaF9daAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341114; c=relaxed/simple;
	bh=V4Lg6xrNmlNhjHnA/yCZhnLZAwsdRt9jwA5DGpWdH3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILnooEeZbM1Ph9lSD2+77UE9F8zp5yaIRF7fSAGUOwYIL4XvnHe2SNJLyQvsQNZz8l7ktUkpx8Her3XBvrbfHOug3A6UGtkdMzSmrqNDKz2jGx32aDdF4eZ+O/aQcPpdf7xrscgofYFbJjUhJfUQjX1RmZnO7ixaav3j0ztT3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgMHosK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E765EC433F1;
	Wed,  7 Feb 2024 21:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341113;
	bh=V4Lg6xrNmlNhjHnA/yCZhnLZAwsdRt9jwA5DGpWdH3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgMHosK01PZ5khEHxuIXahHbJN5eFAaPQ2llh4eyB8maIrsVYj9yACKshRlqj0c7L
	 rl0+jDhVj9IHyq0hq3tGOuOwYqWVVhNgfsBDkIrf/i0Y+Vjqlt737/3iMzxPv7DM6l
	 TmkZqJ4j8++29LkKv2XfINGL2bDFK861ZppJ+ESLoQy6FB7lzOsJ/TM/nUaouu8xnp
	 XX+L/Bzf1+m2d/v3/PGbBHtscsimzj2GLn1J+y5AdD/YvYfHHlez8vTWZXGHmuhlb3
	 qUUNt1HvsbqyWmmxeL2dcv3U1Wo8+Hm5k84SDESXiKfWO5cTYwy1IkSapo5km8/cz9
	 KUssRXHrLPlkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.ujfalusi@gmail.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/29] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Wed,  7 Feb 2024 16:24:30 -0500
Message-ID: <20240207212505.3169-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 7ec6e5d728b0..9212ac9f978f 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2413,6 +2413,11 @@ static int edma_probe(struct platform_device *pdev)
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
@@ -2429,6 +2434,11 @@ static int edma_probe(struct platform_device *pdev)
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


