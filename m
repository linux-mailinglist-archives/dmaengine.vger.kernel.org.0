Return-Path: <dmaengine+bounces-7012-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83340C0F89F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6091D4044BE
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC0309F00;
	Mon, 27 Oct 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="j3/igAVf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB12367B3
	for <dmaengine@vger.kernel.org>; Mon, 27 Oct 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584773; cv=none; b=ZEDml/Lvnuq1lQDiIny0gW27hyuykj15Q8JdokYal/QtFn1o+EBW2uR7VF/MO5hAoK6JcNUGtFJpbpMdmtjpAR6aaalFWNeJUUYUxgt6p/UcK8sTZqPhWcKveJPszqv3JAcRnQWJMZnE2PO5M8gRVEh2F1bHwZFE+BJVDUcxIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584773; c=relaxed/simple;
	bh=nvCAp05Igm7u0/Jh7K5xcdgVgCPrkc1/1y1nMxQsRA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdBTzLiNwqi8/6zbxlqca4qwzeISjB8+kuWCq8K5M+OYwF7TwC/6V/DzUyH0Q2Gqv8ZOVxOZ10TStZgw96PF08aPzog2Mmaajey5IzU3tzVpJ6dInnBgkhkZ9jK+bSc4zCP7BV9ah5Obw3fy7Qt1Mnksj09IOtrW1WdI+t1Tq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=j3/igAVf; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id EDD7F4400D8;
	Mon, 27 Oct 2025 19:04:45 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1761584686;
	bh=nvCAp05Igm7u0/Jh7K5xcdgVgCPrkc1/1y1nMxQsRA8=;
	h=From:To:Cc:Subject:Date:From;
	b=j3/igAVfzTUHQhXHM5rDJhciOvEcuY1G7is1ivppZZLk92+OC4bY/T6ByAP0J9dPp
	 A1fpCYr41Wy8iWeWBvOLbj05+8ANEjnfMcdLRsFCPdWTZAURQjaUWehAqQ0wWe7fy+
	 lZVWZUJ7BVqdlxybi/t3pw0BhgdhHS/QJvU0xOtFDgoAO+txfa6iLKTYM6cNfaQLKJ
	 rAPsVLr3+8pT4AMtOLx5Br+7jVor+BXZ5agTgMyA315Y+Y6vcqQWd0d5fSpKhw0IXn
	 fksgo2cg5RKraEr4WbRLImKSsniArVzyVqarOrd3H+O29dZnhwWgGZt6HQLTiwpvP5
	 lJU62qJTwXlrw==
From: Baruch Siach <baruch@tkos.co.il>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] dmaengine: dw-axi-dmac: fix CFG2 priority field location
Date: Mon, 27 Oct 2025 19:06:05 +0200
Message-ID: <82c6c90cc17f164485705424c2cb02e30b2a0023.1761584765.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DesignWare AXI DMAC Databook documents the CH_PRIOR field of the
CHx_CFG2 at bits 51:47, that is, offset 15+32. Fix the corresponding
macro definition.

Fixes: 824351668a41 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..facdfb453ffc 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -326,7 +326,7 @@ enum {
 #define CH_CFG2_H_TT_FC_POS		0
 #define CH_CFG2_H_HS_SEL_SRC_POS	3
 #define CH_CFG2_H_HS_SEL_DST_POS	4
-#define CH_CFG2_H_PRIORITY_POS		20
+#define CH_CFG2_H_PRIORITY_POS		15
 
 /**
  * DW AXI DMA channel interrupts
-- 
2.51.0


