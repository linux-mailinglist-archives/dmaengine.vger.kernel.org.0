Return-Path: <dmaengine+bounces-7801-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB84DCCAF32
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2052B301E991
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7B2F6586;
	Thu, 18 Dec 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aJmA9Bqo"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F725A354;
	Thu, 18 Dec 2025 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047211; cv=none; b=JywxWbMw/IHDpJocjbJc94KY7QPyzepPlREd6orduLurCWb3KpY3KHcgZpbVI0QgR7re5vkJlYt0KhVv12npn5S5bdwaWoiA7K8C3PqZ50OC3lZClWGDie/heAFzwKKvJqaspxJUGr+NdIti6DUdfcW0TJp6nbGDGMavsNx9mYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047211; c=relaxed/simple;
	bh=EHuzCXobNU2dCEe4gFQZ/GrmHkn2MkorXFYR9tLA8Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hWrPjF/GBvqc0yfM1DiSsIT7mExPocNDGuaWninsRIMiwLFHfbDQ63jC01pXXuy4RgntRr3YTUTJFxAcuihRkV/2CWWOVfCy6K+wR8f2+nL4LAvcLgA7xIo05h6BpNmoAJijrZpZeSb12rxK/yOJeWIYgQJITzackplLC6OZwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aJmA9Bqo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EABA1189;
	Thu, 18 Dec 2025 09:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1766047192;
	bh=EHuzCXobNU2dCEe4gFQZ/GrmHkn2MkorXFYR9tLA8Yg=;
	h=From:Date:Subject:To:Cc:From;
	b=aJmA9BqoU0YMiPdKz60u69oHCC2lNWZCEBSASPs9k97PYNcEN1CL5iWvKxbc930P7
	 ysGopEnPVVMUMMKhV681TCGw88Y9Ds3lOFXFOB8Eh4RiRl9sW6s1oghcXF08EJCbfM
	 J+gac9wqph6oQfiIysMr8XbVf1larFAQHmH12/eY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 18 Dec 2025 10:39:37 +0200
Subject: [PATCH] dmaengine: xilinx_dma: Add support for residue on direct
 AXIDMA S2MM
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-xilinx-dma-residue-fix-v1-1-7cd221d69d6b@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAMm9Q2kC/x2MwQqDMBAFfyXs2YUmqLX+ingQ87Yu2FQSKgHJv
 zd4nIGZixKiItFoLoo4Nek3VLCNoXVbwhusvjK5h+usswNn3TVk9p+FI5L6H1g0s/Ro5fUUQW+
 pxkdE1fd4mkv5A2UzCV5oAAAA
X-Change-ID: 20251218-xilinx-dma-residue-fix-f6e4f97ffe61
To: Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Vishal Sagar <vishal.sagar@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=EHuzCXobNU2dCEe4gFQZ/GrmHkn2MkorXFYR9tLA8Yg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpQ73bzaL/oeu2jD8Z/n8Udmk5x97gAdNptDVXD
 RDNn7Lemw6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaUO92wAKCRD6PaqMvJYe
 9XPND/9SjYmW1LxDy5xNWsmWjsiKvDq8aIddbhTo5rarW9dY4Ou9XLaMDmVFfUezUKKPxw2EdO/
 ei0DVapBwaVUrBG98JMrVjbOPiRXp/uIR4nGM7NrPI61sBqZEHKEPqH9Ef+ZfRvq+4qMV6Mgl/U
 c/Fsl8FNrhNftTSjN8mM0WxQqVolqFLKhpMIVg9MTt5EHJKiOPxr9WxseA5gdc6LZvLP6DYDOAv
 0qz9Th9zmYEW3qWdVoSi+16bg7LjagBkj2NU49qlykVT7Ze3buo1AE2hXwhnqthL2Rl0RtaLBfI
 1ZRGVpl2ZrDFvImGdYOmci9wcQMZ+DLk7Hsrpl+tR9SnmtGwHnDhiAu4kjEKgYBetvkG0sqRhMV
 lJiTEBJdAsPwUwAVW4Rk6znM/yJNBpPsXXWmYJuiGKgB85pSyjPyWarjavB2ikbGSIHUvZhkwi8
 2dhQH3nKnp91bw1v6yEQzEvK7YzpN8w02UzMsgN+Bv2JBN98SbZJouW9JHvfeS8+/RaIMgzNkVu
 eLHufCIf6+pNN/2o32AxeUxLSRytP20YUixmId8qUDph+ZmaqZAvueEnk1JqpM06K/6lfw2U9Q3
 uiBcvdfc6QSjMkUWMHfwYulTij7ab2s1Q9bQ+Qc3lf44EbZ5Be6RGY7CnqtqliTVQEuifY//uam
 n8MpdOcyNGEFVsA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

AXIDMA IP supports reporting the amount of bytes transferred on the S2MM
channel in direct mode (i.e. non-SG), but the driver does not. Thus the
driver always reports that all of the buffer was filled.

Add xilinx_dma_get_residue_axidma_direct_s2mm() which gets the residue
amount for direct AXIDMA for S2MM direction.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index fabff602065f..64b3fba4e44f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1021,6 +1021,24 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 	return residue;
 }
 
+static u32
+xilinx_dma_get_residue_axidma_direct_s2mm(struct xilinx_dma_chan *chan,
+					  struct xilinx_dma_tx_descriptor *desc)
+{
+	struct xilinx_axidma_tx_segment *seg;
+	struct xilinx_axidma_desc_hw *hw;
+	u32 finished_len;
+
+	finished_len = dma_ctrl_read(chan, XILINX_DMA_REG_BTT);
+
+	seg = list_first_entry(&desc->segments, struct xilinx_axidma_tx_segment,
+			       node);
+
+	hw = &seg->hw;
+
+	return hw->control - finished_len;
+}
+
 /**
  * xilinx_dma_chan_handle_cyclic - Cyclic dma callback
  * @chan: Driver specific dma channel
@@ -1732,6 +1750,9 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
 			desc->residue = xilinx_dma_get_residue(chan, desc);
+		else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA &&
+			 chan->direction == DMA_DEV_TO_MEM && !chan->has_sg)
+			desc->residue = xilinx_dma_get_residue_axidma_direct_s2mm(chan, desc);
 		else
 			desc->residue = 0;
 		desc->err = chan->err;

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20251218-xilinx-dma-residue-fix-f6e4f97ffe61

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


