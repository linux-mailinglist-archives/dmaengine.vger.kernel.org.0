Return-Path: <dmaengine+bounces-5675-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE28AECE71
	for <lists+dmaengine@lfdr.de>; Sun, 29 Jun 2025 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944917A7816
	for <lists+dmaengine@lfdr.de>; Sun, 29 Jun 2025 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D522CBE6;
	Sun, 29 Jun 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="AtOxdF1r"
X-Original-To: dmaengine@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D329128819;
	Sun, 29 Jun 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751212935; cv=none; b=T8lZzVytUQ8i3FfIGkf1kgjP3U0E7m1lHbBAoNgpycYpo6/mX6f405f7Nc2cEszxzR+XPN7o11wfRI+A0cO51pGyOYt+NScrmUVOKlAh+rXJ/GzRr5EdQrbcAdnEbKV4N+rUYqb7URSE/dnCTx0jhWpEKch02kKpyY6Q2Bn/O2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751212935; c=relaxed/simple;
	bh=Q3NZ/Hs7IXDXg0EZbN/RJ1y/NoUVJyPO4WAfgzm7ugM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DnjOr8+ztntjEd3AjNBvpj38WjrwGMFp2uV3+Ly82+l8yjd0XasXuIpVu9VxmbH3DLzZ9UqVyw2mDCdVQCLBqKZ0m759aS0NdrKzxBp1hdfZ7Cse/MsxMfix7ZvGHFPqyNVaTj2uEtbqWHmb6mxs5enEKLmWLX88Uk7tOyRwh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=AtOxdF1r; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751212621;
	bh=rjiuaExuqilvnnkZXH6U2UQzWHA6Kj+xZY3GhDa4HWo=;
	h=From:To:Cc:Subject:Date;
	b=AtOxdF1rMf6IV6PPOX9e9467H+kuLtikVPrPuVWxHq2EE/riab9QlUWIxQPd4Jmax
	 0VV1xHYLM0xFsSsOmJWDqo/zuk8+b+U7GmEAWQw4GtUVdag2IpDPjjrdbwWo9d3V84
	 169KnJHH1KtkNyJ2m2QoDVo7A2IODr0Vk0jGbers=
Received: from KernelDevBox.byted.org ([115.190.40.13])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id E3A3683E; Sun, 29 Jun 2025 23:56:58 +0800
X-QQ-mid: xmsmtpt1751212618takwe3j1s
Message-ID: <tencent_71CC9630D88A8792C2396A8844DCCD5C6D06@qq.com>
X-QQ-XMAILINFO: Ne9q9v6AFM79dBrz8kR5U6Cz4mmV6e8rVzM5Nas1C5p3krQFksLLqJ7NCq3wzR
	 SD478DuZr9QUTEpgNk5QYaW310myImXSTEG7iuf0iOpG7ZIRtFTNx2cqR6dTIHIQtiw9zbU0E6Ms
	 Nhldmz6oEuKIvF0DsWyHwnPjc8vTEbr+VeU76laRaR2pbLf6HhQQafrQUocy+9W9NAqaszFaRqt0
	 vw+m/fdesEXcX5uVAN62IQZK/8Hep3cxtLjqadJBW6fuCIxs76wYD4mLlvdBLqCvK74dWk6rzoRZ
	 SN50i32+NYOFTZDZrzvbMUi5Tdlzovq24G0lCRw3K59mmcCt8fLm9hr/vxCPAgy7LBIjhsbyfs/u
	 DFOg8mJEo+iqzmrAgJBXsrkZeVbVqOxVnWo/z+0gP7XYwM4lisekoBnttLI7Pda6wmxeYONvzdsQ
	 zqWwmPuYKJUN1hRCcLKE+ah6J8LBsWzvjyQ3ZcSGGSvGb/0Od/7ZOREejtiHk2qRSDbKJ835EMdw
	 tYhRvTJunw62a4bwhBv5bXlvcArXPyuj9GtvD2Fa8/BSlXWcvIPeZCES86Y5fwtWldQSw7rzUq5S
	 EFhZMoLnMuZ4Hx791XpqejacNeotd6ncF1fvvDVRb3F+L77WGLKbZgF+y72P6roTJjY9UlUg+3gm
	 3bYfABds0ySybQdv6Kq4ZcwcqBFO19foz92WAt/FV7y1GMaKCnFoNwBMBgkJj4znwDUZljtSpvqV
	 lpTFJyZejeddaLIm2fkYYnWSLfjywwlqNIUeaO3HdjY6hXfbkHT2r7nCgaskuaaGMLCTj6l+uJnz
	 HOEcXPZvvKNajdEga8SF9D1tHGaJoaDZDVuEdZHXqoUK01H6mdq6DAejKLTimTufF4dOSe0MCHxx
	 U1yccSGBZDQ15g0iDALu5U6hyZP640OEuhYIEAZc9KDfwkwYvGOjNfsszGpFEafPwAoxrpqoUOWp
	 3AxXsqCwWHG4mxxWmwFfeAJTeNsTOaoSnB6uBDRUMSTS58pHP8GFSGInPCnxLAMqM7GTMXuMNmOc
	 klBCEnqtHsUkO7jRsN
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: vkoul@kernel.org
Cc: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robin.murphy@arm.com,
	ulf.hansson@linaro.org,
	kuninori.morimoto.gx@renesas.com,
	u.kleine-koenig@baylibre.com,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] dmaengine: rcar-dmac: Fix PM usage counter imbalance
Date: Sun, 29 Jun 2025 23:56:57 +0800
X-OQ-MSGID: <20250629155657.2074439-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync will increment pm usage counter
even it failed. Forgetting to putting operation will
result in reference leak here. We fix it by replacing
it with pm_runtime_resume_and_get to keep usage counter
balanced.

Fixes: 87244fe5abdf ("dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 0c45ce8c74aa..c1ce3b0ae74d 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1068,7 +1068,7 @@ static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
 	if (ret < 0)
 		return -ENOMEM;
 
-	return pm_runtime_get_sync(chan->device->dev);
+	return pm_runtime_resume_and_get(chan->device->dev);
 }
 
 static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
-- 
2.39.5


