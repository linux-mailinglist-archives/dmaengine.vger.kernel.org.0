Return-Path: <dmaengine+bounces-1452-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A5D881496
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE691F23643
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863B4F1E5;
	Wed, 20 Mar 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ic/l4w7/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h3dLUlY7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621931EB44;
	Wed, 20 Mar 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948550; cv=none; b=iEK65opwh1zhLTSIn91gfPKjIKht/D+X34e1h4fyVjcfBWl1FfvERcbKAmv94HHvlxH0CRZOBROC3Vu42os8C9rMbLb0uxWq9A5BmLnvePK4ewFcTwU+ehoj9mPwxLk/A8aLBDao/FjAP0qFR1dz3vadpU2jA3739cue794M5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948550; c=relaxed/simple;
	bh=CQySag7xm2muRwM/T32TWtIU0dCJiXAtitG8wW/6ZwE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jMvjhQ4vDGNNWFWRYmDTB0Kk//PUaAuekA9Y6xt6pEpsba5ewcMO2BSNoDO9xmzNCGhoGYthPhtteqPc2O+uPE/VWvWD+amgX9RjdYJNeOWrx4GXFuggES+ayXtIpTM7en3Oz8s56E8A+Hz/QEmaHzQ5LyHkeJeL/7XtgholmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ic/l4w7/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=h3dLUlY7; arc=none smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KDXNiA029987;
	Wed, 20 Mar 2024 08:28:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id; s=pfptdkimsnps; bh=xwEnEgNmd
	ia2OaQNO3Qw1uAkOGxJ+2PH6QxnIB8iPco=; b=Ic/l4w7/SyaR+OMNoJiKy7VRL
	8rwzvopHqbHVF0Hk0X8jDNUlcCmvGTureqVtqSj5eQYLfJPjFxyEeYVuS3PbPR10
	0cJzpvaSe3vLgpOTVnUCSKwR1VMHgm9hHYC/vMSqzvypFQvF3d3aeLddpXQJvxR0
	LiLXmHoBkpF6TS7Goc8WIZgYTHqZa5NJP9/lHqktm6/h+gfloQGFsmCBGL6h9QUw
	DuwtIF/A0RCWwCpXmTTrbX3F0huBCwBTKCYR18oDuXcsrW5REGXbYfJ2vhvQMH2T
	CAEcdbxrd3KBvhaMLn5s9Z+zRqoWaGSxE8twcsOsaiu8BdTw6uFZEH2puscmg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3wwa2d2tsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1710948538; bh=CQySag7xm2muRwM/T32TWtIU0dCJiXAtitG8wW/6ZwE=;
	h=From:To:Cc:Subject:Date:From;
	b=h3dLUlY7pY/W5eXBsu8su9hnYtorjoWAAG8ABb7MA/B6f2fX/whLLAYGQoCzV7DeO
	 hQvaEVyK9P/VcO3VA5Uq0nQ3IEPt4s2wEtDAY5gpe2embjNgOBfawXtyIZA4PS414c
	 4zuNwi1SO6fOSE89V5qsSeaj0zAWKaD3yYUfXJiGvTA97i4ZAJf4GvkwtIZBB6vCKw
	 XxHNGnVuts1QbpxJOZqS9WxdB4IAkvH6xQBGDWzxJx8zKpIaUIBaLtseKneAsphZfC
	 K8VK+OHUx0WJfhCmlcEKWUD9B4u+1gGOQfn8v1mULzSaxBriOJchNczRe+B1S+Ea9W
	 douD72xHNfQwQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8031F401D4;
	Wed, 20 Mar 2024 15:28:58 +0000 (UTC)
Received: from us01odcvde44181.internal.synopsys.com (us01odcvde44181.internal.synopsys.com [10.192.159.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id 258AEA00CD;
	Wed, 20 Mar 2024 15:28:58 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org
Cc: Joao.Pinto@synopsys.com, Martin.McKenny@synopsys.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Avoid hw_desc array overrun in dw-axi-dmac
Date: Wed, 20 Mar 2024 15:28:45 +0000
Message-Id: <1710948525-45471-1-git-send-email-jpinto@synopsys.com>
X-Mailer: git-send-email 2.6.3
X-Proofpoint-ORIG-GUID: hYAtkIeHxNylq951z4uwgP0XupkakxBa
X-Proofpoint-GUID: hYAtkIeHxNylq951z4uwgP0XupkakxBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200123
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

I have a use case where nr_buffers = 3 and in which each descriptor is composed by 3
segments, resulting in the DMA channel descs_allocated to be 9. Since axi_desc_put()
handles the hw_desc considering the descs_allocated, this scenario would result in a
kernel panic (hw_desc array will be overrun).

To fix this, the proposal is to add a new member to the axi_dma_desc structure,
where we keep the number of allocated hw_descs (axi_desc_alloc()) and use it in
axi_desc_put() to handle the hw_desc array correctly.

Additionally I propose to remove the axi_chan_start_first_queued() call after completing
the transfer, since it was identified that unbalance can occur (started descriptors can
be interrupted and transfer ignored due to DMA channel not being enabled).

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 7 ++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 1 +
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a86a81f..b39f37a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -302,6 +302,7 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 		kfree(desc);
 		return NULL;
 	}
+	desc->nr_hw_descs = num;
 
 	return desc;
 }
@@ -328,7 +329,7 @@ static struct axi_dma_lli *axi_desc_get(struct axi_dma_chan *chan,
 static void axi_desc_put(struct axi_dma_desc *desc)
 {
 	struct axi_dma_chan *chan = desc->chan;
-	int count = atomic_read(&chan->descs_allocated);
+	int count = desc->nr_hw_descs;
 	struct axi_dma_hw_desc *hw_desc;
 	int descs_put;
 
@@ -1139,9 +1139,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
-
-		/* Submit queued descriptors after processing the completed ones */
-		axi_chan_start_first_queued(chan);
 	}
 
 out:
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 454904d..ac571b4 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -104,6 +104,7 @@ struct axi_dma_desc {
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
+	u32				nr_hw_descs;
 };
 
 struct axi_dma_chan_config {
-- 
1.8.3.1


