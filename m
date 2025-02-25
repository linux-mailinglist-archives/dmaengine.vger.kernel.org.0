Return-Path: <dmaengine+bounces-4578-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E901EA4461F
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2025 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F7019E02CD
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2025 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C41957E2;
	Tue, 25 Feb 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv7/xn9D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF10194A67;
	Tue, 25 Feb 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501199; cv=none; b=OTQiKAfTWZjhYAVC/UDQMC90108HemNQhoXC4pzrLpNYLaSLKDx/roWroazpmCamVfmk+Ca4MYd2Fq7xOrPwV2N7aiMjXEOtB7EuNpRv07ypWstg5H7lGqFCRH0RT3BCAXIFfMfmeu2GN+5MYyyipp/YYrtStmuXnH9M+kCPuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501199; c=relaxed/simple;
	bh=aYWTeKS4C8DLhFYGvYE3i02fM/iize/Xhoo0GCJLff8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=De5jmaxT6D34TT1ie7bJMgs7/9Eg3rJXjSo0SeAZtWMXyvnF1y8CpsKmbfpRG2IQ0pwc/AiVTjDm1kVcgQcK5Cz994GcET7Uo3Tf/KOeAgrH6LIkD/JcErpsMM9bij1DZv7+/hzWvdTohFJweyUpcBqzxFJWEBdJaAUez7KfynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv7/xn9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CB9C4CEDD;
	Tue, 25 Feb 2025 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501199;
	bh=aYWTeKS4C8DLhFYGvYE3i02fM/iize/Xhoo0GCJLff8=;
	h=From:To:Cc:Subject:Date:From;
	b=rv7/xn9DqgV8j4NurcaCUFJVw32nsY6ja6tOyfKYf/xskC33nBEP8mG9xmANVFfo/
	 l/HI7kBMjQ2H50udyP0ZRnW/jQ265qozJJbw6VZMuUQv4+M1HePI73nDZmP/ZQr/wI
	 DKjnks+jhTwRkXz/azATFiugcELvjHuPoe4b4L6l+PEb4KA71HHvjItoGELl3gD9zd
	 NOLhbr6vZegM59Tnn3+oPA8hZGFEe8C73mg6r5G9Q1ayS8G4aZbAQg0H+3am966R7I
	 uwU2puqzzt0btYx1v/udxGIfLEaq/U6DPMt730hOlHItC/DATE7MmdAF9LrzU9mBdS
	 F6TIU3m/vfnEA==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: img-mdc: remove incorrect of_match_ptr annotation
Date: Tue, 25 Feb 2025 17:33:12 +0100
Message-Id: <20250225163315.4168033-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning about of_ftpm_tee_ids being unused when
CONFIG_OF is disabled:

    drivers/dma/img-mdc-dma.c:863:34: error: unused variable 'mdc_dma_of_match' [-Werror,-Wunused-const-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/img-mdc-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index 4127c1bdcca7..fd55bcd060ab 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -1073,7 +1073,7 @@ static struct platform_driver mdc_dma_driver = {
 	.driver = {
 		.name = "img-mdc-dma",
 		.pm = &img_mdc_pm_ops,
-		.of_match_table = of_match_ptr(mdc_dma_of_match),
+		.of_match_table = mdc_dma_of_match,
 	},
 	.probe = mdc_dma_probe,
 	.remove = mdc_dma_remove,
-- 
2.39.5


