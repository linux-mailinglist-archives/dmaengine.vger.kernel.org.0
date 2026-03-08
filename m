Return-Path: <dmaengine+bounces-9320-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tLK1HzjzrWkK+AEAu9opvQ
	(envelope-from <dmaengine+bounces-9320-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 08 Mar 2026 23:07:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C279B232606
	for <lists+dmaengine@lfdr.de>; Sun, 08 Mar 2026 23:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0EAC3011BC7
	for <lists+dmaengine@lfdr.de>; Sun,  8 Mar 2026 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F017993;
	Sun,  8 Mar 2026 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0Ftu1/e"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171371B425C
	for <dmaengine@vger.kernel.org>; Sun,  8 Mar 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773007668; cv=none; b=H3mRzN36BEVlHQemRrG3KXId86NDkhFLudCukw5MfAtEsmP9wlszZUpeelIFQyfYVl1u2/GpaxAqxBM8zcTfW47TnlXzVqXwfcfl254cV86zA+suNGuy3YtILxw/m8RpDVRlHsZ+He8vll2xOX57eFHEEM4ExYAf33bduUdV6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773007668; c=relaxed/simple;
	bh=eil+iPpwgIw3LaL+spkCjgN0S+e4SPX8IkdqBz91dFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7DL8WyQtFDbTw8lJgx4ibonj2XyNjMufOQeobOda4LCwoMS3ONPhSQ8yMtGBkhRGUoX2yccX8456svZ/uRG58L4GNHvHuJBeRyvAtRqkzRhvBh4lmnuLW9Ua+gq4rmh8aJ6lh8RE8/5e39S/zJtwkhUhwKQL2iTvQghWTuqrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0Ftu1/e; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-798374d0f44so156863037b3.0
        for <dmaengine@vger.kernel.org>; Sun, 08 Mar 2026 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773007666; x=1773612466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ftcpbjh6p3nPyd9FYgD5ANvcMgJCdJh9w2K7lp47ksM=;
        b=j0Ftu1/eSn4j0SDzo9lWLIcAmQXzSozDPFnMN1ZjVOfTGWJ+TTMTSQWnSUKNKChUWL
         tnn0NlJ8WfaYOgShzE+l20cYYAK3FUhbtjWME2Os9R9/1B+rZCZWJY9MxHNClD4Q1vpg
         ejrLKRphLlWRWdEbtUD+Va7AvsVYuPzKu2N9YXQm5k3RF6dp6/AP+OvBTlRbLvAzBHlR
         Jx+L36Z1AL6QZtd//Zszs8CGI4YI8JLGk/N03SLhnk7j16HgmHHTNknBnNPz7XDtu55a
         rsyjp0Hlno2SSQSoX1RMPkSbrlKaxshdjsGki76756/8uyJD59yHi+FQoAJjgW39kCyE
         dU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773007666; x=1773612466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ftcpbjh6p3nPyd9FYgD5ANvcMgJCdJh9w2K7lp47ksM=;
        b=CtFDkR0rQjtZAlpkYj1PhWu3ve0erxZhYkgeVdhI0mMT7fv8PCgMhHdLXoekL2x4dH
         pvBhXxPybzuYP+j8DH4icvVUXUpNypIJWntyj1X0BL5t8eOQjKWBPj2/2OyTXConXv+p
         niZ3ts/57mNXVmogzhB+OdAIL0ehilSrpAtKUHiyoYB9eNg45Wfg1LsT4JZXz/65pmKi
         YE4DDXK6YcziVO8PiKkpu2Yz6W8J77g1z2siNlzab3rZLhxFm4nuHLDNOskxwdYOAEfX
         FJLqzW4jMdNsq05M+DVLUFAFC2SKo65lE9XZmMi/aiGZD6cVDSUglBwOffr8EAQyaCbW
         QoLQ==
X-Gm-Message-State: AOJu0Ywgd0jQAIJUKQeFPN7FCT8NBqoxYSm0yAZVlbI0jlt9AGVrSBDb
	2cCigZbepCIVEJ3p2Y18D0YP/O3NRQd9gLay9NH87hVFSu+QBjj81z9OptVUU8DibV0=
X-Gm-Gg: ATEYQzwMKIHNV7VHMzt72H2PrJbR7WWCAUkhibRyFo/piOgyobb0JBEBltbwQkAg7Y3
	VjVzP5eDriZNsjxxz1dng6YLaAPcPaE4dxtFx0bmMiAj2XHtlmvrchZI0ZER1AFCRJeM+4IWPII
	OJoxH32GkU0E7t/EenNm4FB4Jdafc//TtQGoYFOYKTPWy0aoP3N7gtIJ5KdejMjPWaUn5vh4Uo/
	6a47BXX0M7n/4mNGf/i3VUg7zaThHLCgP1kMDTL7JTxz1ggSmvAkNHYjan7q9YtGUksMnxASHjT
	gsiFbJtGfKc0pPiba2yWpg81j0ZuRD8aa+DLkNlcMXgpZtm7tM1VF0VDh8xaFn7dTpgl99Bdqid
	yBlg5pesmaHOrdz3FVGASnnOMbbAjeaYTJytqn/qWBiqiiChJkqOgSQqTF/AD9ATJCguCbh1Rvw
	cfdXTxt0EMI2zr8sh3SDYtddwGg506vo8pf8x9VYQnict+6YfLAdhC1A==
X-Received: by 2002:a05:690c:ed3:b0:796:3f8a:9607 with SMTP id 00721157ae682-798d1f07dbfmr126573077b3.30.1773007665815;
        Sun, 08 Mar 2026 15:07:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee8ac51sm36771577b3.49.2026.03.08.15.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 15:07:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] maengine: xilinx: use kzalloc_flex
Date: Sun,  8 Mar 2026 15:07:26 -0700
Message-ID: <20260308220726.45270-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C279B232606
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9320-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Changing descs to a flexible array member allows one fewer allocation.

Aadded __counted_by for extra runtime analysis.

Changed error path to a simple kfree. descs in all paths are not
allocated. No reason to call xdma_free_desc. A single kfree is enough.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/xilinx/xdma.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index d02a4dac2291..14fbc7200a6d 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -80,7 +80,6 @@ struct xdma_chan {
  * @vdesc: Virtual DMA descriptor
  * @chan: DMA channel pointer
  * @dir: Transferring direction of the request
- * @desc_blocks: Hardware descriptor blocks
  * @dblk_num: Number of hardware descriptor blocks
  * @desc_num: Number of hardware descriptors
  * @completed_desc_num: Completed hardware descriptors
@@ -90,12 +89,12 @@ struct xdma_chan {
  * @period_size: Size of a period in bytes in cyclic transfers
  * @frames_left: Number of frames left in interleaved DMA transfer
  * @error: tx error flag
+ * @desc_blocks: Hardware descriptor blocks
  */
 struct xdma_desc {
 	struct virt_dma_desc		vdesc;
 	struct xdma_chan		*chan;
 	enum dma_transfer_direction	dir;
-	struct xdma_desc_block		*desc_blocks;
 	u32				dblk_num;
 	u32				desc_num;
 	u32				completed_desc_num;
@@ -105,6 +104,7 @@ struct xdma_desc {
 	u32				period_size;
 	u32				frames_left;
 	bool				error;
+	struct xdma_desc_block		desc_blocks[] __counted_by(dblk_num);
 };
 
 #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
@@ -254,7 +254,6 @@ static void xdma_free_desc(struct virt_dma_desc *vdesc)
 			      sw_desc->desc_blocks[i].virt_addr,
 			      sw_desc->desc_blocks[i].dma_addr);
 	}
-	kfree(sw_desc->desc_blocks);
 	kfree(sw_desc);
 }
 
@@ -275,26 +274,22 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
 	void *addr;
 	int i, j;
 
-	sw_desc = kzalloc_obj(*sw_desc, GFP_NOWAIT);
+	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
+	sw_desc = kzalloc_flex(*sw_desc, desc_blocks, dblk_num, GFP_NOWAIT);
 	if (!sw_desc)
 		return NULL;
 
+	sw_desc->dblk_num = dblk_num;
 	sw_desc->chan = chan;
 	sw_desc->desc_num = desc_num;
 	sw_desc->cyclic = cyclic;
 	sw_desc->error = false;
-	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
-	sw_desc->desc_blocks = kzalloc_objs(*sw_desc->desc_blocks, dblk_num,
-					    GFP_NOWAIT);
-	if (!sw_desc->desc_blocks)
-		goto failed;
 
 	if (cyclic)
 		control = XDMA_DESC_CONTROL_CYCLIC;
 	else
 		control = XDMA_DESC_CONTROL(1, 0);
 
-	sw_desc->dblk_num = dblk_num;
 	for (i = 0; i < sw_desc->dblk_num; i++) {
 		addr = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT, &dma_addr);
 		if (!addr)
@@ -314,7 +309,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
 	return sw_desc;
 
 failed:
-	xdma_free_desc(&sw_desc->vdesc);
+	kfree(desc);
 	return NULL;
 }
 
-- 
2.53.0


