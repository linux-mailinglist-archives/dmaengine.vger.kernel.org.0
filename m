Return-Path: <dmaengine+bounces-8655-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGjNIAY8gGmD5AIAu9opvQ
	(envelope-from <dmaengine+bounces-8655-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 06:54:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA9C8617
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 06:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 854BA3001187
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FEA245008;
	Mon,  2 Feb 2026 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU2yG3B/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B121FF21
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770011646; cv=none; b=Cs9DqoXrTU3gxYLlLNpmcNXD2hIZeEueKGKTeK0vAvn7/NoCpc1SB51/wsYOjEcqMIoMXn0sQZB6+v4AdEBWiUpEuTFRlkGE9Rwl37jGdvR1ZAb54ACjdyx4pc2ASOwl4nxi+ssYzGU8JxekaMXaaZmI4ywIM/+4B+jpW4vFhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770011646; c=relaxed/simple;
	bh=wOG+XZyfJ1ECBp3bdpMqJuYFU9m98cCaqUKQHSPHqOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVMxLiI6Ly6exAyB1z4V90kCMoqqDpYHEj/jh39KhRcL8mV/Ibkm/17sGajiqXh9/D3birQkQuSKpvw3EOMvcw5HbAvggss8Fa74fshUOvpx//DvgOkspXprC7oFhJ1qRGFwnSw5u29YtgHc3cCS2rIS9uJo0vFBALlxs9ZG38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU2yG3B/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a09757004cso33075205ad.3
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 21:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770011644; x=1770616444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5teP0ad/u/RJjO/iZ2u1LHked4QjrPKeg2T8iSxlEY=;
        b=dU2yG3B/wkuak7c7wy14/m0o2moTTYQ5dE69CRrXPTVQV3POp/1QzaNncTxdwTNcpw
         DZbvBrnDZz9a+sZhRhIAYU1Wcz6jdkS1ukPcmluZ/ete6f3N5YA9FnyGTL1SKqk6spxP
         thAel5XpmWDuMhFyw6cOVN8/ctae3FuHdaPEUKqLEaDL1UJJ3XiZ88Ztk3gtGcz5G9AH
         5ZkWggWZnIwwtOq1OUrAQHCxIHNKqkm8S5JLYJlT89dg1SZUt2zUoQ5+K5TJVUDxtV7l
         GRFwgO7D2M3rODvYQKQ9sUmUj4MnNTwOD5U4C+DVaShgnoK2mTrKJpkRjoBK3XS38q48
         yGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770011644; x=1770616444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5teP0ad/u/RJjO/iZ2u1LHked4QjrPKeg2T8iSxlEY=;
        b=GzS1OdRDceKVMXD+803mrlyhl4Rj+QZAZRa3di5lW/x8AFG94T+EQZoYu+2xx+qutj
         4Lg4lQYTq6gDcHqgrh7PBCHxAx4GR61qB7UTdQd7I6dgXdqD0FkKUG20zVpYoXwWlqen
         XUFr+DWicLAuVx/K4Fqv1JMlbkxAq2YjkIDEVxxu0qSFG6cya8gCb7G/O0BDZec7ivhL
         Y8egvT4NZvCLpuH21hUhdBjmTookKJoHhY4LVyoTA1qFSxjLm7qoKJe+bTCVlojJ6rSU
         6Ssy2bVwDt083ZxFcvpAKQ2k7Ar2RmN7QOKysz1enK9CNcXhOwYOtMKYUK2KmFbim+HW
         w3qw==
X-Forwarded-Encrypted: i=1; AJvYcCVk7Xg4VaCbOqo5kb7uFIY2efMH6/y42tHrrUlYpK2blzAtYGlWnvD/oubjz9OxbRC5rsuV8da9PFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdwvYE3qKb5F2/MFZNsFnOVKLFfttrzTmINGEQCG0BqyuAeo6
	2DbfNqeceNWzZu0wYmUfRQ40KCKBYQ9tPdPuDbbqoPI0pbtTVhfWJ9Ni
X-Gm-Gg: AZuq6aLgTJr96AhpbjziMZ8QiNby4aQCatdEtdRtw1EPy7UGewlhEFeZ7HMypMqJ6nh
	5sD37/qe96wgNSCJeOktxt1oj5XtDn9MAvLN3qHe5EGa0NdXYloTDWb8In80X8DKyyejtPCnhnZ
	MbcxpGr6tsHjAgdowHEaycWuyN/oOnP1VIg+xkmkh1MpMXQkbX3k1OAcGEkSbvi4FJOpzah5xmH
	sPez09nnWB3MtMzEsGVzLW+HEpYKj1FaW+X1vTh3bvFXem1+sg6m5qpyCKywKo7HPXaIaIzEMlX
	YCw5yGC2iAd5PnUEaz0ryo8A6kx9oRUqQWQ6nAoEMr9hTx/taOrlomi3kK+iM+LZvYwFQv785Nm
	N2DqBtN+q7his4Wn45SyTb7L/pqCFH3vbCdgbDdMq44SFAFyFUNfG+HtH/0mhPkltiPJc9RQe92
	tPVCs5eBzHo6AM5aemSjiaHIMzzBkQ8Q==
X-Received: by 2002:a17:903:8c6:b0:2a7:a6b1:4f8d with SMTP id d9443c01a7336-2a8d9931d2emr119297595ad.40.1770011644538;
        Sun, 01 Feb 2026 21:54:04 -0800 (PST)
Received: from localhost.localdomain ([171.88.165.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd7654dasm108066645ad.81.2026.02.01.21.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 21:54:04 -0800 (PST)
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
Subject: [PATCH v5] dmaengine: dw-edma: fix MSI data programming for multi-IRQ case
Date: Mon,  2 Feb 2026 13:53:44 +0800
Message-ID: <20260202055344.1395-1-brody.shi@m2semi.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sshmediatek@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8655-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95FA9C8617
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
 drivers/dma/dw-edma/dw-edma-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..dccc686b7a3e 100644
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
@@ -895,9 +896,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 					  &dw->irq[i]);
 			if (err)
 				goto err_irq_free;
+			msi_desc = irq_get_msi_desc(irq);
+			if (msi_desc) {
+				bool is_msi;
 
-			if (irq_get_msi_desc(irq))
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+				is_msi = msi_desc && !msi_desc->pci.msi_attrib.is_msix;
+				if (is_msi)
+					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
+			}
 		}
 
 		dw->nr_irqs = i;
-- 
2.49.0.windows.1


