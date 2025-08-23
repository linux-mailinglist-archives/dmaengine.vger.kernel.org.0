Return-Path: <dmaengine+bounces-6162-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E8B329FB
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A61EA024D5
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7D2E92C0;
	Sat, 23 Aug 2025 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+Ji7du8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3E1E5B95;
	Sat, 23 Aug 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964654; cv=none; b=HYZnWZdHiuv5KarkWmCWSA7wRVaI2IqM/UzVJNqwwppW9BCG4+XZxG1vCctEkEkNT2A5EqM3V/ioUgyza0+r84feTlqD+K1pBp7+eqyUXBSTb9YzgRbFCxEOM17J8reSPdraRxGtTlpDpkGcLA+PlHVYqqF6DaVjRY3DwXE22+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964654; c=relaxed/simple;
	bh=E48rlK5pCrVw6V8uNmmSVbPCOsKOLgsmZrs0oelkBrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM6hMbpNdZ+zNC4SdHl9H9vDlg3Bu0EEcFld7lvcGFvsGVnBtKaXefMxRIeWUDk9LI9uuu/1bvWqIp9tQ4U1ABHpEuoDrc9qVSL0pSgDVAKbw0enZBbLJTjV3wEehRBOQnfkfov+RDZS3YF9MxgqHzWzrTqSlfWkv6VSiIUT3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+Ji7du8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32563C4CEF4;
	Sat, 23 Aug 2025 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964653;
	bh=E48rlK5pCrVw6V8uNmmSVbPCOsKOLgsmZrs0oelkBrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+Ji7du8ydO9/dwQfjyld222hzFjdhjYrIvtRdRNvFPZFHGdxsk5LcRWCE49ic4Vg
	 ObIuK1wHAB2PClhbQreZrtNPQn8788uz5RmBzfuNfPzDoNvQDhAUS8xu/20ZQqdx6A
	 HyOihXrEniYo1JgARPz0OPRETDZWTWAnMsA1BvnyzpWoJ2PIROsU6YtCuWSxEu5cct
	 NPsp0xgLNluknacqGbr88rDYSE/nnaBHwvAOQw1BmyJvnyei6J0sKr1gbpSkxGgyz0
	 wnvU+2m6s+GOwsU/+KStUvm8RwOTi26kyHuxaBdOtSYjhcmtf7GAPPozK8X/H5qGdO
	 +mdCQiDgDoJyA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] dmaengine: dma350: Fix CH_CTRL_USESRCTRIGIN definition
Date: Sat, 23 Aug 2025 23:39:56 +0800
Message-ID: <20250823154009.25992-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the arm-dma350 TRM, The CH_CTRL_USESRCTRIGIN is BIT(25).

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 9efe2ca7d5ec..bf3962f00650 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -58,7 +58,7 @@
 
 #define CH_CTRL			0x0c
 #define CH_CTRL_USEDESTRIGIN	BIT(26)
-#define CH_CTRL_USESRCTRIGIN	BIT(26)
+#define CH_CTRL_USESRCTRIGIN	BIT(25)
 #define CH_CTRL_DONETYPE	GENMASK(23, 21)
 #define CH_CTRL_REGRELOADTYPE	GENMASK(20, 18)
 #define CH_CTRL_XTYPE		GENMASK(11, 9)
-- 
2.50.0


