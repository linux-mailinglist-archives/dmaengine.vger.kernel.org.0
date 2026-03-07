Return-Path: <dmaengine+bounces-9315-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCqlKPGaq2kLewEAu9opvQ
	(envelope-from <dmaengine+bounces-9315-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 04:26:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108C229E56
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 04:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A62230A646D
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2026 03:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AA730DD00;
	Sat,  7 Mar 2026 03:25:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D80A30FC34;
	Sat,  7 Mar 2026 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853950; cv=none; b=E54Zlian1beMkj05quVFsfDqW0sBsY6UMWROBbAkI7ET/UqlNSDgm+y6eJQrNbEXk60asVQHq6nD9K9/mlGxCPQJrM95/6n674HJxTIe/Tiby0DX9SH0Mu5XL7x2Ca0GCrzDaDxqAKpgtyFKokXMg6BALT0m3FR+1hVTX/3eD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853950; c=relaxed/simple;
	bh=TCsPH4Gdw7qML4MzziVbvIQ4Nxmgn6A6FoTmPCuon1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxe5l12rFk/9kW/rdTeRZooJDle12W6+1TaoCXacE6HHKQdxJR2vx1zsFYxLnXnlS6/lohNw4atMz9qPy9dpZAgjZ7UFk0yqcW/mJdYJEcSbg9BoSrR0PrvffLQjn2rI3VGStkl+f9wKSpj80J8hLDpuwfNxyMxlOYaOfhx77Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8Dx88C6mqtpMWcYAA--.13620S3;
	Sat, 07 Mar 2026 11:25:46 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJDxD8O4mqtpK+BPAA--.21629S2;
	Sat, 07 Mar 2026 11:25:45 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 4/6] dmaengine: loongson: loongson2-apb: Simplify locking with guard() and scoped_guard()
Date: Sat,  7 Mar 2026 11:25:35 +0800
Message-ID: <fb59bb25e5c4fcb84d9aa7b351285fa8d02ea8cb.1772853681.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772853681.git.zhoubinbin@loongson.cn>
References: <cover.1772853681.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxD8O4mqtpK+BPAA--.21629S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgETCGmqbKIYXQAAsQ
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1kur1DKw47Zry5Cw4rJFc_yoWrCr18pF
	WUGFZ3Kr4UJ3s8WFn8Gws5WF4UAFsxKFy7WrWUG39rtwn8JrnFkw1fJ3s0vF4DXF97uF9a
	qa90q34fAF15CwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU
X-Rspamd-Queue-Id: 5108C229E56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9315-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,loongson.cn,nxp.com];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.864];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loongson.cn:mid,loongson.cn:email]
X-Rspamd-Action: no action

Use guard() and scoped_guard() infrastructure instead of explicitly
acquiring and releasing spinlocks to simplify the code and ensure that
all locks are released properly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/dma/loongson/loongson2-apb-dma.c | 62 +++++++++++-------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index adddfafc2f1c..aceb069e71fc 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -461,12 +461,11 @@ static int ls2x_dma_slave_config(struct dma_chan *chan,
 static void ls2x_dma_issue_pending(struct dma_chan *chan)
 {
 	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
-	unsigned long flags;
 
-	spin_lock_irqsave(&lchan->vchan.lock, flags);
+	guard(spinlock_irqsave)(&lchan->vchan.lock);
+
 	if (vchan_issue_pending(&lchan->vchan) && !lchan->desc)
 		ls2x_dma_start_transfer(lchan);
-	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
 }
 
 /*
@@ -478,19 +477,18 @@ static void ls2x_dma_issue_pending(struct dma_chan *chan)
 static int ls2x_dma_terminate_all(struct dma_chan *chan)
 {
 	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
-	unsigned long flags;
 	LIST_HEAD(head);
 
-	spin_lock_irqsave(&lchan->vchan.lock, flags);
-	/* Setting stop cmd */
-	ls2x_dma_write_cmd(lchan, LDMA_STOP);
-	if (lchan->desc) {
-		vchan_terminate_vdesc(&lchan->desc->vdesc);
-		lchan->desc = NULL;
-	}
+	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
+		/* Setting stop cmd */
+		ls2x_dma_write_cmd(lchan, LDMA_STOP);
+		if (lchan->desc) {
+			vchan_terminate_vdesc(&lchan->desc->vdesc);
+			lchan->desc = NULL;
+		}
 
-	vchan_get_all_descriptors(&lchan->vchan, &head);
-	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
+		vchan_get_all_descriptors(&lchan->vchan, &head);
+	}
 
 	vchan_dma_desc_free_list(&lchan->vchan, &head);
 	return 0;
@@ -511,14 +509,13 @@ static void ls2x_dma_synchronize(struct dma_chan *chan)
 static int ls2x_dma_pause(struct dma_chan *chan)
 {
 	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
-	unsigned long flags;
 
-	spin_lock_irqsave(&lchan->vchan.lock, flags);
+	guard(spinlock_irqsave)(&lchan->vchan.lock);
+
 	if (lchan->desc && lchan->desc->status == DMA_IN_PROGRESS) {
 		ls2x_dma_write_cmd(lchan, LDMA_STOP);
 		lchan->desc->status = DMA_PAUSED;
 	}
-	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
 
 	return 0;
 }
@@ -526,14 +523,13 @@ static int ls2x_dma_pause(struct dma_chan *chan)
 static int ls2x_dma_resume(struct dma_chan *chan)
 {
 	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
-	unsigned long flags;
 
-	spin_lock_irqsave(&lchan->vchan.lock, flags);
+	guard(spinlock_irqsave)(&lchan->vchan.lock);
+
 	if (lchan->desc && lchan->desc->status == DMA_PAUSED) {
 		lchan->desc->status = DMA_IN_PROGRESS;
 		ls2x_dma_write_cmd(lchan, LDMA_START);
 	}
-	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
 
 	return 0;
 }
@@ -550,22 +546,22 @@ static irqreturn_t ls2x_dma_isr(int irq, void *dev_id)
 	struct ls2x_dma_chan *lchan = dev_id;
 	struct ls2x_dma_desc *desc;
 
-	spin_lock(&lchan->vchan.lock);
-	desc = lchan->desc;
-	if (desc) {
-		if (desc->cyclic) {
-			vchan_cyclic_callback(&desc->vdesc);
-		} else {
-			desc->status = DMA_COMPLETE;
-			vchan_cookie_complete(&desc->vdesc);
-			ls2x_dma_start_transfer(lchan);
+	scoped_guard(spinlock, &lchan->vchan.lock) {
+		desc = lchan->desc;
+		if (desc) {
+			if (desc->cyclic) {
+				vchan_cyclic_callback(&desc->vdesc);
+			} else {
+				desc->status = DMA_COMPLETE;
+				vchan_cookie_complete(&desc->vdesc);
+				ls2x_dma_start_transfer(lchan);
+			}
+
+			/* ls2x_dma_start_transfer() updates lchan->desc */
+			if (!lchan->desc)
+				ls2x_dma_write_cmd(lchan, LDMA_STOP);
 		}
-
-		/* ls2x_dma_start_transfer() updates lchan->desc */
-		if (!lchan->desc)
-			ls2x_dma_write_cmd(lchan, LDMA_STOP);
 	}
-	spin_unlock(&lchan->vchan.lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.52.0


