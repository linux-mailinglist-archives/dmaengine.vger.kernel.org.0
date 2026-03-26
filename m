Return-Path: <dmaengine+bounces-9674-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIwlATs6xWn/8AQAu9opvQ
	(envelope-from <dmaengine+bounces-9674-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 14:52:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C425E3364FD
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A04BE3042B65
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549D2EDD70;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r06Smy0l"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F882BEC27;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532251; cv=none; b=enhrB/MBntJRLDcHyTdzo/Keplxywg0AnRHVFXqF3xZcZXSl0WrRzTG4RcZ67HSt9c8Hx0Y/Ahhx8uhviS6wPoJe1Gx4BQRA575f5rTPKJy9+jcjDuqGgcMiIEyAtW7v3/0+jacmsEuDDY8C+qAgk4NubtN3lzFOQAJizlIVxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532251; c=relaxed/simple;
	bh=csxxfuxXyFqO8HSnCmquBiGzNzo25bMe5Y2fqsAa6RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHDN7M882UdmqqcbgFxIGULCjVEsZgW8kCwHFlhje7F0XpvXrW86HcdnoKfgru7fqwj0jmUcYgKB5AEoa7RZN9lginhErHVOa7HksRtNNC67E/mPqHV4a5PJ1KZdd0R6mZ/yHPSqFH017dEW2L+XW7ZDF09svwV5TLbdBDkI6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r06Smy0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16ED1C19423;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532251;
	bh=csxxfuxXyFqO8HSnCmquBiGzNzo25bMe5Y2fqsAa6RY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r06Smy0ljxs1ytPf70XnpvTZ9HVKP6NsuDl+4jcscmX4PeSGYc9qILLsx4nQPfSgE
	 tVgyQOJo3Act2x6rfeW1h41xmBpuaQ18+GnRWId8Ncqu23Gdz18ZTOBLkCaKti87SH
	 6p8M5c4y0+B5t8RIg8ePz9/kZwfHlEy0VtQQK7Hw6kOW3gUJKZtbk6YRi6TLj6XrVv
	 wLWU77N4EJZiomQM86KXqMWXvHWWwof4ab7tb2PRe2XUXxTyI5w2cAA+Gt90PKQ5Nu
	 jq6mRrm35jfExT60JNSnpMMMA88oImeSSFEQXqBu7GzNbjykzNEebL1J7EZk41tbjr
	 Lx/pZUTNLcccw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0724210A62D5;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 26 Mar 2026 13:37:35 +0000
Subject: [PATCH 1/2] dmaengine: dma-axi-dmac: Defer freeing DMA descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-dma-dmac-handle-vunmap-v1-1-be3e46ffaf69@analog.com>
References: <20260326-dma-dmac-handle-vunmap-v1-0-be3e46ffaf69@analog.com>
In-Reply-To: <20260326-dma-dmac-handle-vunmap-v1-0-be3e46ffaf69@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Eliza Balas <eliza.balas@analog.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774532297; l=3532;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ArkyMHkLTrvJR+/V/Q2CkIHL6iheUix3HHIOIkA3Mpw=;
 b=RUyqB7WtWiRAvwOa3jT05D/5y5137Gb3P0NL5ENxEpMuzze+6+r/4BdTFbRQ2ND6M5rR1LsQW
 6SyB6L1uTAZClrXYQ3skmlzDtaGx+bm3L/kEHqqSOQlVQLqsn1nsyvx
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9674-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: C425E3364FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eliza Balas <eliza.balas@analog.com>

This IP core can be used in architectures (like Microblaze) where DMA
descriptors are allocated with vmalloc(). Hence, given that freeing the
descriptors happen in softirq context, vunmpap() will BUG().

To solve the above, we setup a work item during allocation of the
descriptors and schedule in softirq context. Hence, the actual freeing
happens in threaded context.

Signed-off-by: Eliza Balas <eliza.balas@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 48 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 45c2c8e4bc45..df2668064ea2 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -133,6 +133,8 @@ struct axi_dmac_desc {
 	struct virt_dma_desc vdesc;
 	struct axi_dmac_chan *chan;
 
+	struct work_struct sched_work;
+
 	bool cyclic;
 	bool cyclic_eot;
 	bool have_partial_xfer;
@@ -650,6 +652,26 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
+static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
+{
+	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
+	struct device *dev = dmac->dma_dev.dev;
+	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
+	dma_addr_t hw_phys = desc->sg[0].hw_phys;
+
+	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
+			  hw, hw_phys);
+	kfree(desc);
+}
+
+static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
+{
+	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
+						  sched_work);
+
+	axi_dmac_free_desc(desc);
+}
+
 static struct axi_dmac_desc *
 axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 {
@@ -687,21 +709,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 	/* The last hardware descriptor will trigger an interrupt */
 	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
 
+	/*
+	 * We need to setup a work item because this IP can be used on archs
+	 * that rely on vmalloced memory for descriptors. And given that freeing
+	 * the descriptors happens in softirq context, vunmpap() will BUG().
+	 * Hence, setup the worker so that we can queue it and free the
+	 * descriptor in threaded context.
+	 */
+	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
+
 	return desc;
 }
 
-static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
-{
-	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
-	struct device *dev = dmac->dma_dev.dev;
-	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
-	dma_addr_t hw_phys = desc->sg[0].hw_phys;
-
-	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
-			  hw, hw_phys);
-	kfree(desc);
-}
-
 static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	enum dma_transfer_direction direction, dma_addr_t addr,
 	unsigned int num_periods, unsigned int period_len,
@@ -942,7 +961,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
 
 static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
 {
-	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
+	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
+
+	/* See the comment in axi_dmac_alloc_desc() for the why! */
+	schedule_work(&desc->sched_work);
 }
 
 static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)

-- 
2.53.0



