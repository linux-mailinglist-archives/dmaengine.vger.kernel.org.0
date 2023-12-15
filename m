Return-Path: <dmaengine+bounces-542-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37B8148EC
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 14:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9563A2819FF
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C022D7A7;
	Fri, 15 Dec 2023 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="eMxqBcfM"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CE2D79D;
	Fri, 15 Dec 2023 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702646029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lpAu/d+BadtNM8H50tJnl00JvfI119f25JB4NGpdWMc=;
	b=eMxqBcfMP0DV0n+emq0JfrNQtly3RitIdhiUbi3fNOab3IS1rr2eZvlLQt+JaTiqwJCE89
	yVj29eXlvSH551gHhZGLqUV3ZOA6uENM3WKO8mzm6CcF5zL9KVadKw/nmVL/VPyG5P3d30
	fDSamI4ChwycsfSF0aSMbCC+ObqI9Z4=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/5] axi-dmac: Add support for scatter-gather
Date: Fri, 15 Dec 2023 14:13:08 +0100
Message-ID: <20231215131313.23840-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Hi Vinod,

V2 of my patchset which introduces scatter-gather transfers support to
the axi-dmac driver.

I updated patch [1/5] with your feedback. Patch [4/5] was updated as
well, so that cyclic transfers are restarted properly in the EOT. This
was a bug in my V1, but it was fixed here just for bisectability, as the
new patch [5/5] will improve cyclic transfers by linking the last
descriptor to the first one in a SG chain, which means that the EOT IRQ
only needs to call the callback associated with the cyclic transfer, and
the EOT IRQ can be masked if there is no callback associated with it.

Cheers,
-Paul

 drivers/dma/dma-axi-dmac.c | 280 +++++++++++++++++++++++++------------
 1 file changed, 191 insertions(+), 89 deletions(-)

-- 
2.42.0


