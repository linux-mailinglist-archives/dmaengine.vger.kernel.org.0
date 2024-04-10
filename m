Return-Path: <dmaengine+bounces-1808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE089FDA9
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 19:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304181F218BA
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2717F369;
	Wed, 10 Apr 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE7Y9hg2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803017B51F;
	Wed, 10 Apr 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768605; cv=none; b=X3F6ro1GR7tJQaXgs6he9ANJcd9rb+/S5xz9MGwunyNcaCJLHfQ7iUUH0c/WjJgCJQkQCDQ8KPsXsuHMAlKw0dGvYZn2oK2zN+pmONUapo2SyjvUlXwo3o/nnFX2f8rC3bbFs9bW10/BrHz5to1dvyiSajlAwTAaxgbY5UlpRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768605; c=relaxed/simple;
	bh=zHNGk5M5w9BnN3lIY62vdcsFlgOeYRgg3MnWGX+WdB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UZrabfpSIytr68NUQyKfsqrYX1K6RB8awR1rWyjqlMEYj6ipsDlRY9SUShKDZnkuU+HRSjaTUboNN1MIm36AoVkZV86r0x4PmGTHC2JI6rIpsKu3OQ+nsRThk/7wNoYiFhTkVzpzk33txQI+nlXo97MdYB4N5Or9u5wtypTm718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE7Y9hg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E86C433C7;
	Wed, 10 Apr 2024 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768605;
	bh=zHNGk5M5w9BnN3lIY62vdcsFlgOeYRgg3MnWGX+WdB4=;
	h=From:To:Cc:Subject:Date:From;
	b=jE7Y9hg27DjE+C2YQ1zX/HWJv2YS18bvwHHUIwyu0VFtrmH6HCZnvpL3jqLrSAlbh
	 /LZOw0spv1Owkbvpl193OZVeckZtnlYLjSQe+O3vuX8Ew4PW0EEpp9Y88aAMuhOpbx
	 zepb6onsaDi3VjzKF7Wf7iai8qk++6i0zuFCydFB8+FlpZouxoovapgkMt7nA75qTv
	 EyxBnrByBoD72EgVpXSxxrNbfW/ZqCfsw3XHQtV8pQ9A0xBlTiUVnUITxOjcy/pSxu
	 yNnJO7VwrS29qhpSJ7C36K3zMkF95vo+InKxOiicqKvBmRvsI+2Y6EqRwSA/CZgEs8
	 DPqBDVY7nG64w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] dmaengine: ti: k3-udma: fix module autoloading
Date: Wed, 10 Apr 2024 19:03:16 +0200
Message-Id: <20240410170317.248715-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6400d06588a2..d7259caa0200 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4405,6 +4405,7 @@ static const struct of_device_id udma_of_match[] = {
 	},
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, udma_of_match);
 
 static struct udma_soc_data am654_soc_data = {
 	.oes = {
-- 
2.34.1


