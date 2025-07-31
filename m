Return-Path: <dmaengine+bounces-5924-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6AB1751B
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 18:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E111C25A12
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0B23F27B;
	Thu, 31 Jul 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UJXuBUsp"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94323D284;
	Thu, 31 Jul 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980117; cv=none; b=QOv9f3JFjTOCpO5tKYfgiIr0yrOrD2Bpoig5PprqRxcAQvhlBKCGlV99P+8ccVyrWBRWnDX6LdlhN9IqadkZ5eMUzYfQGDD+5ihW1PaSzmOFfII+uwZRGlfpq0mQ2uQeB7THfEvrrr4JCU4yCzP7k7MSMw3tGV51kvq/eGjuHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980117; c=relaxed/simple;
	bh=7M9NRZGHjzTS5WyiKepVzjAZJvDbHOsyZQlkUDtQ8bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5Lky1dNMoCL7AYdUGdJxdDKbJD0mItW9MacnUISt7kqFCNsqc/7uzr7PxlevxD946+ZOde2EPvo7lGvdM66b/KIhx7ybpjhGk+lCi1OZVVujObzhAaWUHNmCJKqx/65Um/6Wv5XxU0cxZGHdaR0bQI/H6w6KVf9sDdg1pKEl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJXuBUsp; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AAC1442A5;
	Thu, 31 Jul 2025 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753980113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uvpXvEFRFfyA16JVJ522XbDcj8E6l4w5eLokJco14g=;
	b=UJXuBUspSnyQFhsFF7uBHYXFxKTZScgg7T56a5M76LqJTAYMUSrX71G4FrHaM5NfaVM+OZ
	l0RLJ58BLsRFw8RCaXTaKOtDGvocemf+TMCdPpyt56EGhoyFpJUhFMp4ezAjRwA1NCFz4O
	GwJ5qRHP4uZ2OKeIDlgu6pfxiAR56Asrf23ysLep954AVWLfWIIWEylQcQMD4Y9CzMt1Ac
	FSp7xsA/ue8etyiIux6akEn62FUtyhykSyivvcRWCNfE9+G1EFmG0CgofNcB3gL17Q+l6T
	MDP9hrtu/uLHgqpwcLYv4hHDAsg0rUt6T+zIKZ4y+qHNldQUI4xEMGzx4Ht9bw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 31 Jul 2025 18:41:30 +0200
Subject: [PATCH 2/3] dmaengine: ti: k3-udma: Ensure a minimum polling delay
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-ti-dma-timeout-v1-2-33321d2b7406@bootlin.com>
References: <20250731-ti-dma-timeout-v1-0-33321d2b7406@bootlin.com>
In-Reply-To: <20250731-ti-dma-timeout-v1-0-33321d2b7406@bootlin.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhihghhorhhiihdrshhtrhgrshhhkhhosehtihdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgri
 iiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrrdhujhhfrghluhhsihesthhirdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh

ktime_to_us() returns 0 if the time (ktime_t stores nanoseconds) is too
small, leading to a while loop without sleeps, kind of conflicting with
the initial aim of this function at observing a small delay and then
guessing the amount of time needed to finish draining the descriptor.

Make sure we always sleep for (abitrarily) at least 1us to reduce
pressure on the CPU, while not waiting too much either.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Cc: stable@vger.kernel.org # 5.7
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/ti/k3-udma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b2059baed1b2ffc81c10feca797c763e2a04a357..11232b306475edd5e1ed75d938bbf49ed9c2aabd 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1125,6 +1125,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 			if (residue_diff) {
 				delay = (time_diff / residue_diff) *
 					uc->tx_drain.residue;
+				if (delay < 1000)
+					delay = 1000;
 			} else {
 				delay = 100000;
 			}

-- 
2.50.1


