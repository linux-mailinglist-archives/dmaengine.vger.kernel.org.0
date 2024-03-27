Return-Path: <dmaengine+bounces-1552-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C58F88DACE
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7F71C26ABA
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121746B98;
	Wed, 27 Mar 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l6Q7GSZi"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2B38395;
	Wed, 27 Mar 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533554; cv=none; b=dCeZCkLYxY/MFd7StugoYtIHe/lE+Iy8UBVgc/hrUaosNxVfVUES9tAq1nTBD2wKv2TATKF7Vaa+jxKZLDjJcz3fxTPIRuPMhNinhX5jXFtriegl0OVBwB2YEMxdTE+r3Pl/+SGRlGihqjmIcU0ZtJo6pN1cuDWX6adb86rCGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533554; c=relaxed/simple;
	bh=0tN/2/cS6x19N/2l/Wo09eS8tiwkR/o9XaPpyzxE/c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEHVdS7vbALoaPqEIDZ9LVcdDnwALJXnAHnlUng5+lPISAQPh/warA2RBtlMrBV0DxU9J+/uV9UJVyuluDHtS48CzWzzAp4GGn+whyM5mGSNiSCi/Nf0Wx7hGJWEknGO61e0lD7oA4GCGj9XTpc6EgS/EGtZzVfNNxfDdhex/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l6Q7GSZi; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9FA8D2000B;
	Wed, 27 Mar 2024 09:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711533550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4g70CEkuUSM1WtA7B5LTii3U2wOnA2Oz3/OdBqqrL5M=;
	b=l6Q7GSZiup/bbdE0wbavpZwfrd7xGJe9vle11q+vc9vXfvzMn7zM7/E8Qi8rNtlJxsEseu
	+VYfMMEbl3/frfCX/kadadS63dTaDWCG3apw/cqxoRK9mhysQVEUQ3J53i5J/tLGs3Ng0Y
	chiv8YVfl2eTJcNer159ITHbdVxl5n4N3MDeUPXs8q4XhnnBIQQvw0myelrbls/ZBXCfBh
	ts2NcDIMR29k4DYkup5BGbN9603EedrzU1u8aVjxA3VG9jw1/Tk8gMESGY+TUwcFL+6Lr6
	qHLSPOC5g5/D4wnitDS5gGqJPNuhvshy6th0BvB3YN9p8Pk4xq8mUKzPiKnXCA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 27 Mar 2024 10:58:48 +0100
Subject: [PATCH 1/3] dmaengine: xilinx: xdma: Fix wrong offsets in the
 buffers addresses in dma descriptor
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-digigram-xdma-fixes-v1-1-45f4a52c0283@bootlin.com>
References: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
In-Reply-To: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Jan Kuliga <jankul@alatek.krakow.pl>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Uzr2bK6DiI1V4GZAhaVT5cYNAM7G0VnbzgyNu2t/W38=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA+3s0JG0WdUbsy7i8QDPfbhTO08tGTlQ8yyvl92x
 mhKGN06JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPt7AAKCRAgrS7GWxAs4g4LEA
 CggITrUpwzuuj5zMdD6jmZdbJKYNK+s2pg7X1fhI0UGcqV0xoraveSkRKutOQyLWZq+Ed84ipqZdjP
 MXlUapOFmdBj8saXaitR1COGB8uI47gmjB2taQAcQkS8Cxc9d6ws50ThDSYIPvbyt8SHYgJCOsKZVk
 PLgohKVXHgzWTOv4OB0nsjvy57uzt6R1atpK7Rs4jaQZ6MCzI1EwJa1Mvz+sihPcDuWch3jPnlleEM
 TkF1BFRS8Gz/rSORI13d6lAHRZTqg7Spz9uCSGwtV7malBOrjU0hpqh/sbG0GvjTSshVTDHWXfc16O
 n0YqzRd8tlbBxBc+IY+Cv/ibaeq3cX9jthdMcUREkeiQe+P4pX9ScFLLssIUHX//0wFxBbvpkRo0U4
 8+VMRtWIqJA8lRHGN7DoAC3hMc0H++vybnbWVJILCCsJ93/Dg1gri6aJKWib2d5ynhhNi0MWO4EeqI
 LU4deXn7+m1HaH/SrPFQafgW74OCmhlIU5FEY3hAaLc8Sq+paZ1wIHyj4aOOfW+pD+bmOz456/8VX9
 kOR0xk9lOpV184m9twPtMeZMoC6UiWY3kAOb2eLxz0dSO2Pm1YuDcMLibOYqayi1bEzLete3blPbyY
 OO6W6kL2GB7PsPH/jiXQEUjx5xDuBgZa3u7MY9xy+00z5GS7SVAtExS/wdQw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Miquel Raynal <miquel.raynal@bootlin.com>

The addition of interleaved transfers slightly changed the way
addresses inside DMA descriptors are derived, breaking cyclic
transfers.

Fixes: 3e184e64c2e5 ("dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA transfers")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 170017ff2aad..b9788aa8f6b7 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -704,7 +704,7 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t address,
 	desc_num = 0;
 	for (i = 0; i < periods; i++) {
 		desc_num += xdma_fill_descs(sw_desc, *src, *dst, period_size, desc_num);
-		addr += i * period_size;
+		addr += period_size;
 	}
 
 	tx_desc = vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);

-- 
2.43.0


