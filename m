Return-Path: <dmaengine+bounces-5923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFAB1751D
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA23A5163
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D623D2BD;
	Thu, 31 Jul 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hWxjMaSt"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684723BCEB;
	Thu, 31 Jul 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980116; cv=none; b=oz8kkfOuuvzMphJa9ag2IhhvncETnmqNRRZN8k422XwJkxnsZLtk8htcIhNr4nLYK/Vusq4yJ3hKC78NVQIOCj+m6vD6/h/zYCeNmLUnnLFs34ttl1G1SpBOwvyFY8zpdg53+EQgoBhRiBw5mxeG6fn8ow4Zon3B9LgEl7424nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980116; c=relaxed/simple;
	bh=w/BwWoXSSGEoqYGfrP6elklpqv0jLdw5bZ4EtYdBvbY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DTpZTtg++qSuctS7lyZMKvHCs9QQm+DctC20ZgrAQCEYkEeRt/9+ddAMliBYrWE84ZtORDLnvGg22Ty8vw48odbqHjKjtJaRZ0b8p2xguWfcFFU9xk3Jmm+AaUP7Ri+CFKESSIcfhtGkVlFAaK4SVGocYijddafzqJTaEvK0/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hWxjMaSt; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 284C1442A6;
	Thu, 31 Jul 2025 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753980112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kkEwjf1aQ4fiXjUuxQRxFV9YyAmLujK4b3TTjpYJE0k=;
	b=hWxjMaStZzIp2hNMNa7W3UiSnXwlS7JKXbH2IE+kSdPJCrNuTMwfV26foDFEJteJnV4M7Z
	2Yy40QUiK5A6MxEhNHMUvc+RyQ/u+85aSkKwMJ55Guj/+QnaBq+FTxeGEmIofl53x5T7KX
	E1EixdzLMskPsnEBlCFQ342CVcUYCCUH0gqEhw2Gw1yDtDfKXUD0iSKoNiUQ/X3MYVOyyX
	6LrP10TNlZWdmxQQQiA4JzKePJ8nM+QdnK43w+ecVxcHskPYrQfBTqwzoYBdfw7Mv3xnV8
	RxYzYPB3PDyam4cnPEP00MNCh95LdqolbfJ5fDlPh5ueWtA/58liioeGj3AJ2w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/3] dmaengine: ti: k3-udma: Fix/improve the completion
 helper
Date: Thu, 31 Jul 2025 18:41:28 +0200
Message-Id: <20250731-ti-dma-timeout-v1-0-33321d2b7406@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALici2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc2ND3ZJM3ZTcRCCVm5pfWqJrmGxmYmFmkWSalJimBNRUUJSallkBNjA
 6trYWAD3LUB5gAAAA
X-Change-ID: 20250731-ti-dma-timeout-1c64868b5baf
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelfeejlefgieehueejteffjefhteelffdtgfduteehhfdtjeeiueeikeegkedvgfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhihghhorhhiihdrshhtrhgrshhhkhhosehtihdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiio
 hhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrrdhujhhfrghluhhsihesthhirdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh

While working on a BeaglePlay with the UART controller and making it use
DMA, I figured the DMA controller completion helper was clearly
misbehaving.

On one side, with slow devices like a UART controller, the helper uses
an unusual polling delay of 1s.

On the other side, the helper can also perform 0us sleeps which means
the driver does not sleep at all in some situations and keeps the CPU
busy waiting.

Finally, while I was digging into these issues, it felt like the helper
was a bit too complex and could be simplified, which is what I did in
patch 3. I initially worked on v6.7.x which did not had the spinlocks, I
hope I didn't got them wrong.

I also tested this with v6.17-rc7.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (3):
      dmaengine: ti: k3-udma: Reduce completion polling delay
      dmaengine: ti: k3-udma: Ensure a minimum polling delay
      dmaengine: ti: k3-udma: Simplify the completion worker

 drivers/dma/ti/k3-udma.c | 85 ++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)
---
base-commit: b59220b9fa2c3da4295d71913146cd64b869fcf9
change-id: 20250731-ti-dma-timeout-1c64868b5baf

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


