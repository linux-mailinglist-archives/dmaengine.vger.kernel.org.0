Return-Path: <dmaengine+bounces-8571-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLkgMALEemk3+QEAu9opvQ
	(envelope-from <dmaengine+bounces-8571-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 03:20:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB60AB159
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 03:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A7B43006998
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94639355059;
	Thu, 29 Jan 2026 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER3+iZvw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B9270EDF
	for <dmaengine@vger.kernel.org>; Thu, 29 Jan 2026 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653246; cv=none; b=bEK253+9XECAHc1JalyALIgq7KwCveniMb5KZ/AbMayACBLd9KMEMdKbPXNfJ1e56bCXZr9oejKcaycl/+d8AZDftTWLlWC+9ndU/+13PMq9tw1uOlmncV83gNMIXdFU4Ny/6vjaag3OUc3R06PtkEyv9g+P2uj1lGxouz5POHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653246; c=relaxed/simple;
	bh=akAGpYF6DuML8vHXHbpzbebgSAUmle/Ix9jc+NKGTWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDKaZ+fuA/OjBfofG3XBRiqIWZe1LAeUeniWdt6zv9ZYpV4Qyz4PnkX3uxQiQiMIWuP0XZYYqDktTlgSgKz5J4oaaar6k130RxEgT0T5NzPO0XfEegDMuR/oUdXGu1QavsEpOrd3GV7HDFrw9UCNFucbL3CUq9VbSjODG1B15e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER3+iZvw; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c648bc954c6so168822a12.2
        for <dmaengine@vger.kernel.org>; Wed, 28 Jan 2026 18:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769653243; x=1770258043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwOZDjfjI031eii7fM+m/4XsJAh9ZPIgylxLjcb6rlw=;
        b=ER3+iZvw8r0cmXYBRITnpOanF/jr0xPQm8+bmMGE5Nx9jycIUqIay6o0f7D01DsDNF
         Arw6dLuYg23WsWjFeIGl1iIKzc6YQhcd3ziTnOCC12/l5hlMlj2ePIpUQRCAKPBSmLo8
         sgMOb8dbEWotk97XCDy2TnSXnh8n7ITzEqkU73opHIU7Q1VEjwIBPTDk5CEg97i29NQb
         mt86o0TwPaau92ysw02M9OHTATp/uMcyBDVlbqn/KSmkWvK3NWuSIwTILrUfUxINfjHq
         RjiupUlxGODodk5vN/rkvN5IyLZytd2dCkaZh0r6Ij5QHn01b1UPqlqu8A3kxIgOcy4b
         uutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653243; x=1770258043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwOZDjfjI031eii7fM+m/4XsJAh9ZPIgylxLjcb6rlw=;
        b=bzNy6yPxV+Czd5r6ZDjmZ6mPSPbFmmJ2q7WpsPfIyZqVpgsSCKKT/IIg+FE8Bj1bid
         gUbt9bcHOebIrq27WG+z7EuIuQ3RzzPzAqiYAM8219LBSZJ2Uj04qTA2gHvVD5g5U/58
         p5rs91AEl61i20nJatMeTfY2naE1Y4+PnNPN/oDIbQiGUvo2Ac9P55dJyWGvdqZ7SShl
         qGGaXJiSMdaGfkOYvnfobIxVN863Q8Y+wZF8H1oC3wxYbyBfGWIRag6cuDzGBDBTnTWT
         DQsj/1PTkqkIR7brZ6XCQOXwNJZN2TC4LtOFpJb3f/L/6WOSPnQOtNd8CPgrDIXYhsiL
         scjw==
X-Forwarded-Encrypted: i=1; AJvYcCWVN05UB0qLJ5vZ+p6T4/YDQ8DRPNnldHT76PLrf+t8a4notaD8E6BcXfnHsDLkXQ9GuVE0EWTJFAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEMocGNZSOgNGuyjJg/30A27werYCHL+o79iDh7GRtcCKi0Fc
	onhWx1gamkLD2OvTJgjElFrZqYDgFM5Y57P1OJspeJYyzDhyf5aDSHAi
X-Gm-Gg: AZuq6aKN6fr+XoRnQgg9AiKQpkST/hMBvrE3iadlJ8UK4x3Sbt/uk20fnxRV7cuokry
	zCmHegc1i6eC0A0Ux+tbD2pxJNKip9V5kOvgFsfV3T1aRlASEVoToC9Z4AOtAuyFZx+0qpiaUXG
	23qZyotBMvU6VHF8rHrofuxoE1u1H1PWlhVWE9jnnPpvqIISXoY0SXgYkuwmcHRzbE94pIr/XYR
	GNuhG1c7wkNEniPCL52R88zBfEfv+0rtEfM0mpeJ5jfrpYpEcnENMjInXhfZyiDRUH0c0C2aJ3A
	njG35zRO5jQhZ/JTSN0CjU9OgiHnoqWSXA1UxKX2Z7ksiUtipah65nfMnjekLP8hwFiEPFVF8Z7
	Zwi8NWS/SanrB/4AZ+Om73srluxjk6kAlCNAaS1m77HlFo93+5zwY9WhzWvCRVRK99AtYyz6dTX
	J4ImvaIAX5mukTzPRARpPOZMki9v7IR8YG2e8=
X-Received: by 2002:a05:6a21:6b0d:b0:364:14f3:22a7 with SMTP id adf61e73a8af0-38ec640647amr5947445637.42.1769653243506;
        Wed, 28 Jan 2026 18:20:43 -0800 (PST)
Received: from localhost.localdomain ([183.223.93.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642aaecd19sm3346809a12.29.2026.01.28.18.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:20:42 -0800 (PST)
From: Shenghui Shi <ssh.mediatek@gmail.com>
X-Google-Original-From: Shenghui Shi <brody.shi@m2semi.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shenghui Shi <brody.shi@m2semi.com>
Subject: [PATCH v2] dmaengine: dw-edma: fix MSI data programming for multi-IRQ case
Date: Thu, 29 Jan 2026 10:20:24 +0800
Message-ID: <20260129022024.3995-1-brody.shi@m2semi.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8571-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshmediatek@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EEB60AB159
X-Rspamd-Action: no action

When using MSI (not MSI-X) with multiple IRQs, the MSI data value
must be unique per vector to ensure correct interrupt delivery.
Currently, the driver fails to increment the MSI data per vector,
causing interrupts to be misrouted.

Fix this by caching the base MSI data and adjusting each vector's
data accordingly during IRQ setup.

This issue was reproduced and tested on:
- Device: [20e0:2502] (rev 01)
- Kernel: 6.8.0-90-generic

Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")

Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa..516770388 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -844,11 +844,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct device *dev = dw->chip->dev;
+	struct msi_desc *msi_desc;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
 	u32 ch_cnt;
 	int irq;
+	u16 msi_base_data = 0;
+	bool msi_base_valid = false;
+	bool is_msix = false;
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
@@ -869,8 +873,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			return err;
 		}
 
-		if (irq_get_msi_desc(irq))
+		if (irq_get_msi_desc(irq)) {
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
+			msi_desc = irq_get_msi_desc(irq);
+			is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
+			if (!is_msix) {
+				msi_base_data = dw->irq[0].msi.data;
+				msi_base_valid = true;
+			}
+		}
 
 		dw->nr_irqs = 1;
 	} else {
@@ -896,8 +907,18 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			if (err)
 				goto err_irq_free;
 
-			if (irq_get_msi_desc(irq))
+			if (irq_get_msi_desc(irq)) {
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+				msi_desc = irq_get_msi_desc(irq);
+				is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
+				if (!is_msix) {
+					if (!msi_base_valid) {
+						msi_base_data = dw->irq[i].msi.data;
+						msi_base_valid = true;
+					}
+					dw->irq[i].msi.data = (u16)(msi_base_data + i);
+				}
+			}
 		}
 
 		dw->nr_irqs = i;
-- 
2.49.0.windows.1


