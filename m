Return-Path: <dmaengine+bounces-7950-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F8CDDFFC
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 642A8300E01A
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7678F4F;
	Thu, 25 Dec 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LK/mkqoL";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LK/mkqoL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A73207
	for <dmaengine@vger.kernel.org>; Thu, 25 Dec 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766684339; cv=none; b=kcioquiBoPx1f0J8wu4uoeBrghDyHiYIjnjwiavvd1jl09oiJZzsj60Ax2uS+0KkXLfgJeiVWwMV3h6OIEqUvXZsPKwt5rRiDMKqvzRVuvoNhAEkPrnVG4d7+FW/JY6kuFmw108YoRMEZcGf4W0kJbYjaR0MemyZ1mNhImkrnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766684339; c=relaxed/simple;
	bh=R5cnfIy7oQzAkNbx7v2TCrT31U73/fYq70zXG8jOVrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fv5eHn2Q84mIZvp0ClM4IIVGvEx+HLpR8hWzO83aVLl4RV0bgSE1y1MfryMU9oLXPssK0LDzRGtlk5+RUXvtLN/s86QSwA8tWJ1jU17euFyHgyjso3RBSIhy2ybjQtTow84jAHtk4T79DB4cJnQ0H5qvzA6FVkzTErZZyW/3nGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LK/mkqoL; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LK/mkqoL; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766684329; bh=R5cnfIy7oQzAkNbx7v2TCrT31U73/fYq70zXG8jOVrY=;
	h=From:To:Cc:Subject:Date:From;
	b=LK/mkqoL9Fa8jB4m3VE/xddEk+9uE5lRQeBrmGZkxxYAyeX3cfR07ofeRSuVyk2aZ
	 r6axc8Gyf1QdI1VMHLjAoTLjB3Qt2IF27oPoS6OqBg6kus73oNJs9KEJ3eHMWVLbiU
	 MG3Ca25l4UKpPHLLl0cI7WqEnA0BwCazzzT9uWsDdDeP6JTo0hiIytWntB+tuUP3Nf
	 DLHlUVNxOVf0987v8LqmYEQewinFsOMupAzreokmdk00tu0guJtqlcJx1ko/ei+ChL
	 gpFbI6Ke8J2QS5vRU8TgvoWwayIIv5WnX/jBtzslkGJgQpEWFvSE8Bn4XR6rOGLOKF
	 t8FlTrLRSSTBQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id A3B283E8C62;
	Thu, 25 Dec 2025 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766684329; bh=R5cnfIy7oQzAkNbx7v2TCrT31U73/fYq70zXG8jOVrY=;
	h=From:To:Cc:Subject:Date:From;
	b=LK/mkqoL9Fa8jB4m3VE/xddEk+9uE5lRQeBrmGZkxxYAyeX3cfR07ofeRSuVyk2aZ
	 r6axc8Gyf1QdI1VMHLjAoTLjB3Qt2IF27oPoS6OqBg6kus73oNJs9KEJ3eHMWVLbiU
	 MG3Ca25l4UKpPHLLl0cI7WqEnA0BwCazzzT9uWsDdDeP6JTo0hiIytWntB+tuUP3Nf
	 DLHlUVNxOVf0987v8LqmYEQewinFsOMupAzreokmdk00tu0guJtqlcJx1ko/ei+ChL
	 gpFbI6Ke8J2QS5vRU8TgvoWwayIIv5WnX/jBtzslkGJgQpEWFvSE8Bn4XR6rOGLOKF
	 t8FlTrLRSSTBQ==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 4460C3E8B7A;
	Thu, 25 Dec 2025 17:38:48 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: pl08x: Fix comment stating the difference between PL080 and PL081
Date: Thu, 25 Dec 2025 19:38:47 +0200
Message-ID: <20251225173847.1395928-1-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251225_173849_685473_E3AB1E76 
X-CRM114-Status: GOOD (  10.05  )

Fix a trivial typo in the comment, otherwise it takes an effort to
understand what it actually means to say.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/dma/amba-pl08x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 38cdbca59485..e42e9130aaad 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2978,7 +2978,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-/* PL080 has 8 channels and the PL080 have just 2 */
+/* PL080 has 8 channels and the PL081 have just 2 */
 static struct vendor_data vendor_pl080 = {
 	.config_offset = PL080_CH_CONFIG,
 	.channels = 8,
-- 
2.43.0


