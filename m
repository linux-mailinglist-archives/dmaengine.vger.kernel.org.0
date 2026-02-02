Return-Path: <dmaengine+bounces-8654-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GQeKl46gGnj4wIAu9opvQ
	(envelope-from <dmaengine+bounces-8654-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 06:47:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93CC85E8
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 06:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 945D1300138F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 05:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE7279336;
	Mon,  2 Feb 2026 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1WKicp9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DA3595D
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770011220; cv=none; b=Ivl3a61FUNdzeC+Em1OifEY/TT+JoZgevUc/mu5KhqMx6jv7LNj5AAVuTnfGheXb7nG2gf3aetiZMXfur0Kpm+EeUg15LT9Z9Lg5JQis1lHdY0UWZHjOtXIhdEqqXyJZl4hYGfzQefEfyJou3OBFVXjp51hnfW+t5fpci3Orvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770011220; c=relaxed/simple;
	bh=t6rjF1INbcM31TXVdLYLgDvqaW6UlRzu0qLkdPRp53A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVfnOUpNmyQHu6YQLDWdhxRGvCSW9gSri/J6VPX7tfJ+Gd2nZZSNO2OQxyuwTuuTR41XN3uZB2/yCbE4+Vui6ts08Vi/ZdlXFv71eN4knI9X5b9Xd/XnuTpnUVxhfBjuaU3MiAr3ToK1EV7gVqjP9/ouR4xFvdWKLENc8xNmUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1WKicp9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a23f5915so26091825ad.2
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 21:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770011219; x=1770616019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qY7v+TdHqaotAUzPe0ROtzIAYmntHl2XBB55ktUIzuU=;
        b=j1WKicp9mBL7z2zCtnukQ4U3bvwoTxAfLVNZZhFYaHwByT95nF5dwRJ2ruZJcP5yYw
         IKmQPPr+dSA22Ss+9B/74//rm77JPi0rqFEZZsPXXfRERpeJIVVVmV8nCkc2t2OWvu9Y
         sCt7sMlVcg47AJ4bWphCHPVsX54v9KS8fEuzcU5ayJWX8Fbn1fCRkHc4WDcufkffMOb5
         4KG32tvUmrZB7oZFkL5wlRZn2DGMXYQczDkJ5WhClmkZ3Oc43cNWvdTh2Iz9ixD+0iX7
         z8BJlc9LUv7c7edk3beXZsYQDtZ2Lcfua3l3z2PpNALg60lU3S04w4Fw9SfEFFKmjAqW
         WREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770011219; x=1770616019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY7v+TdHqaotAUzPe0ROtzIAYmntHl2XBB55ktUIzuU=;
        b=dPdMIh6OrUZIQMOsWP3ObTJzCyJgQr3n3eLq4w/X42UAGbf/AwLk3iOtgWhpKR1zgQ
         8E408Q8aZiCMyXW1TclXd+1VYHNOqb4ZxQmXHc3hpCdXe4GqV2SnvbTvkFeE1HEFseg0
         rTDo2K7kivpsTzRBTOoFd8X6TkUFK0bg6l9gj444BcteUeat3TGU28L1a1KjxEDNZtPC
         MZKEHQ2jk6oBUgyNxufzOxgJg19YWXPKzdJeltRBM8nvxo8lq1TzWPs1a+a5DRMhLsAs
         Re43Ji/wlXAyQOBTHohDGYetsj8KaaG+QRytkgDsCcIby2SfpHf4pREfKZjDgGGrIlMx
         hY5w==
X-Forwarded-Encrypted: i=1; AJvYcCWv9hpCK2D83KugUJkPtF7P6F++DM7hRSrLPKRIO9GgrLY9+4qMZzrSAfhiM0Rk4U0Mlfu3G77wTHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLiMy0B1Pr357gePb7ivJdLzD7OhPBe8jx+MPYQN+1kGCqjOs
	vqnI0M3joY6sGq3RK+/4LV2DNRodsjJzKOLTkHvMQ4dnrqEju+uusQ32
X-Gm-Gg: AZuq6aLajZKEaMmDR64W3BVFLgi1GuOW2onhSzV+SnXP0d59XrNd4ffgRrFdWC/+W0t
	aZdfO5eqvlzLPG4D5iKCZeLY7dQD18i/XtpVh7s81PnaCeCPgRruUl4gRk9fk6x+W55IwaeYOAK
	y40zoOrJreQnD3p1CHHpK6HlLlqajKHTSUMEfGhpDgQVw5k9Lqxh6aKSL1Gngw1dC0R7HL2CnTo
	gNKReaRWkQnGi3QwjOJoS+0v3kPDFD7+ytFt8aDBr9M04/4jms4bsPjBTbmryBibsS7KsqWyHpp
	SNEK/AEzu0qmHKimsP1yLykMr87zhYZFxSB1GiNdAniFfJi25VEKmwmaWaVaVm6XjIqRntjHLdC
	CsPgShnZA7IvGyf/nbSijTIGfJMU8hGXFMrzBt15IvIk8AbMgR2yIYD6DFhtQOUuo7IMG7rkIZ1
	vHAgUO+zTjyAxTPf5Qm1mFdk82JmXQebe05DUV9secLJnV7g==
X-Received: by 2002:a17:903:41d2:b0:2a7:63e4:b1aa with SMTP id d9443c01a7336-2a8d991a634mr108277715ad.35.1770011218876;
        Sun, 01 Feb 2026 21:46:58 -0800 (PST)
Received: from localhost.localdomain ([171.88.165.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm136294705ad.79.2026.02.01.21.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 21:46:58 -0800 (PST)
From: Shi-Shenghui <ssh.mediatek@gmail.com>
X-Google-Original-From: Shi-Shenghui <brody.shi@m2semi.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brody.shi@m2semi.com,
	kevin.song@m2semi.com,
	qixiang.zhong@m2semi.com,
	tom.hu@m2semi.com,
	richard.yang@m2semi.com
Subject: [PATCH v4] dmaengine: dw-edma: fix MSI data programming for multi-IRQ case
Date: Mon,  2 Feb 2026 13:46:36 +0800
Message-ID: <20260202054636.1247-1-brody.shi@m2semi.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sshmediatek@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8654-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA93CC85E8
X-Rspamd-Action: no action

From: Shenghui Shi <brody.shi@m2semi.com>

When using MSI (not MSI-X) with multiple IRQs, the MSI data value
must be unique per vector to ensure correct interrupt delivery.
Currently, the driver fails to increment the MSI data per vector,
causing interrupts to be misrouted.

Fix this by caching the base MSI data and adjusting each vector's
data accordingly during IRQ setup.

Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")

Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..570127069ddd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -844,6 +844,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct device *dev = dw->chip->dev;
+	struct msi_desc *msi_desc;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
@@ -895,9 +896,14 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 					  &dw->irq[i]);
 			if (err)
 				goto err_irq_free;
-
-			if (irq_get_msi_desc(irq))
+			msi_desc = irq_get_msi_desc(irq);
+			if (msi_desc) {
+				bool is_msi;
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+				is_msi = msi_desc && !msi_desc->pci.msi_attrib.is_msix;
+				if (is_msi)
+					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
+			}
 		}
 
 		dw->nr_irqs = i;
-- 
2.49.0.windows.1


