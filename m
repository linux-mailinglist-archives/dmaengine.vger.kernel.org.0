Return-Path: <dmaengine+bounces-1556-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F77E88DB8A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B0B1C2693F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654224F1F6;
	Wed, 27 Mar 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="khhjnn3B";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LLnlVQQJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B093DABF0;
	Wed, 27 Mar 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536584; cv=none; b=FrKJeEfr9ikZWE0BzJpqB4M508P2PeWqROSyug++O2bYei8wx21K/8keoAWNuO5o2TcaY3o2CDeeExNYiblYN1aSEkC57gCZdD7lti+DwrQuzla4seMk/MhGBUiCapmO7TifNIRBYdDTyzw4BaEfCkVEiPLhJW26MTA1HDf9DSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536584; c=relaxed/simple;
	bh=CQySag7xm2muRwM/T32TWtIU0dCJiXAtitG8wW/6ZwE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Fd9Yix07RIa+o8o11b2GDx/+p5QW3JNyx0foDXipjTcyTbNb+pKvddCpklhyWzCfWZGiQEHC56LlII5d8CMh6lTtEfO1up6DUhgYStFGVvKWJfD6+6e4oBPQNxevT/PFPKjKpnpWUgvhqUUoKVWDjsSbG0R0NmDTFXYnfDMQV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=khhjnn3B; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LLnlVQQJ; arc=none smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R7StDo012814;
	Wed, 27 Mar 2024 03:49:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id; s=pfptdkimsnps; bh=xwEnEgNmd
	ia2OaQNO3Qw1uAkOGxJ+2PH6QxnIB8iPco=; b=khhjnn3BniMVNhfpzV8VdqAnw
	zcGGic5fvRagVYAs9CRoBkkL8wxXYiKBOwIZIy6LWTVqUNPlBE5SyFmnl9zoaArQ
	DY/bR+RnZtI/MUaUX6hEdIWtXw6GAlRf04pwAGXCPrF63t0hpssdewzPSgzo1utH
	EaPF8LNDmJZIAugT8/1xg5KGm8SquJ6HKift2hWns4hydh5yT7vEerBjvQexlKIp
	ccaCXb0NLaswUmRHZ/z0VOUdpAn1aeIdNLGrE54Gn6l5rsvwQQbD49Dx42SHGlfb
	D7SEINWt3DJMuIP+OIdeY5DeMfKJL8OOGof6IIkX3Ju81FdKvQJEPUSxjXjLw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3x3b6e5a8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1711536574; bh=CQySag7xm2muRwM/T32TWtIU0dCJiXAtitG8wW/6ZwE=;
	h=From:To:Cc:Subject:Date:From;
	b=LLnlVQQJvhMNkzAdTotUz6l2eI5rE9TgL5y4v2DV45SjjoDxq3ePpoI29CWDxmp23
	 OrUcp/l3M8Hk+0slQJ/5ej9slyPGjSmrDUhgxzPX+9ErPAQqAqdsP0Ccp83SKwYOo7
	 MA9Ndr/s/BTEx3cASc+QVwgvABi5i5qIw2pk3I3TFieNW052F1+K41sJGCnJpKEelt
	 LmUZD6Cvh+aXyLmpnNSFEen0KJEGv87n4ImpX8V9c+BMS4EYBvRFSrLCRYQBOKHni/
	 qXMZYHJc6hYxkL0vrPwRj5Ps0E4O8ooPlCsnh6/ZyRXGnTnzYbKbmqS7qU94ISmrKo
	 7HgxEJARfSCKQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E3BE340467;
	Wed, 27 Mar 2024 10:49:33 +0000 (UTC)
Received: from us01odcvde44181.internal.synopsys.com (us01odcvde44181.internal.synopsys.com [10.192.159.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id 9547AA008A;
	Wed, 27 Mar 2024 10:49:33 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org
Cc: Joao.Pinto@synopsys.com, Martin.McKenny@synopsys.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Avoid hw_desc array overrun in dw-axi-dmac
Date: Wed, 27 Mar 2024 10:49:24 +0000
Message-Id: <1711536564-12919-1-git-send-email-jpinto@synopsys.com>
X-Mailer: git-send-email 2.6.3
X-Proofpoint-GUID: KGZr8mQD7piZvRf0pyeCg_q8imALXnQg
X-Proofpoint-ORIG-GUID: KGZr8mQD7piZvRf0pyeCg_q8imALXnQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403270074
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


