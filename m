Return-Path: <dmaengine+bounces-9748-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NwDBCLoymkkBQYAu9opvQ
	(envelope-from <dmaengine+bounces-9748-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 23:16:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A2361530
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 23:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EAFE302D0A0
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 21:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE73A1CEA;
	Mon, 30 Mar 2026 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVqPXLA3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FC397686
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905375; cv=none; b=HTz2x3YOwHmCj4AcDMLZwGc3CDivKSn0covUTSEcpZjm+gvpICy6lOpnmJNMPxAcmTSHkKc1CzKY0/rsuepcCPOlATKHRPVuHXSX8M+CNVCn/nssamMQOvN9MTaMwXSUDGCJu8d5cf9AeuYkBL1qdXkw5ZaMeXyq7jGOdWg+s4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905375; c=relaxed/simple;
	bh=0r/vyHKpOF0SAyTRzVOWBuBNrSAHVSAnFjY+aUU7feE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTdRs0JoO9dpYdPnNtePRCJSUYke21GIZcQ3slisovadPEEXqhy+n69MNfDqf2PLydieR3chMMMH+qS7N3yz7rSjVpEE9Uukp4rVYvHM4O/1ZLFhtwwtiwfDdsIocjTs0C/IYPFSRNuO1sMG2S2+dJxnlJU6ydbOKtCz0Xi8Ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVqPXLA3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82418b0178cso2408314b3a.1
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905373; x=1775510173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UW7odxZPYSWuCgnGtpRjdMtnRpvYwb8B9YLZ+r/hXWM=;
        b=qVqPXLA3yxBBmZ0hI8z3W/QxuMqN8LeHfE6Crf9oHi9Xn3ahHHV2UMvQy0VavnNX0P
         MqTJcYh/LXNPRGnfaj59nmw1eWa1GpIEgb6IVsB8bsswTU+3Rm/qgTYiOqj+WyTPf+AG
         b5D78XlPUh2mM9WMbB9pk8PqKmIuZ7/istJsU5413Z1atVULQIAmhL8xJfbStEH+kjlo
         Ba0RciEVCngd/rdrf/CKAS6AhExjqnQ/grncE9NfllHarOZJdhVSCoayUzv7mA7sLtt5
         tHGbLnn/4NgDIe3Y5yq+0qgKi2TaeOlmHdUGGkvjOXDsO/ZXxjNoL3wogmfkhK3GEbUM
         1hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905373; x=1775510173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW7odxZPYSWuCgnGtpRjdMtnRpvYwb8B9YLZ+r/hXWM=;
        b=W+KrOceQHCjnduAcXm8Q/XhbgZkR5IUoJwgQIUUzXxmdlpTK6FiV/DK4nO64eWn7Px
         MqngcQmtNimMFvEzVACZPY3HbPnXzyNzTIFJDu3/ZQc03+F6FRDA9ZnNp8f1BDuDkybU
         t4aISFV771j4KEH2/1wuIX7OFJeyE108hfj6iW7IIgQ0I0i63Xm78OZD1rD+EJaegpxq
         n8rt+5cSd/BOLML9klAXYw+60vc3xhVATzmw8FnJDYiSOcGqPImryNl37vmCb2ntop4p
         CFIj7ZvZWNrv4+OF7xbTxdVYcWpRoq7B0oEqTEDid+B9X3ORTkinzK9eVfqS6IxU7rQj
         7BsA==
X-Gm-Message-State: AOJu0YzDE6DgOHkT/3SO+2QlrBdgsxtD+75TnvmTkdgO0PglYhfpX8yk
	6AZuYwfqEga3tTS3Oq2HLhDddK1Gz5bHm99QFcrybtQuS4uhcjCMOYvza7t8TbVp
X-Gm-Gg: ATEYQzzbuyfO7wcxQHuKob6aBw45oPePHOLEXPPYWjdD/bVD5TqR5W1boQxBvSApSO3
	rFV5qOXMHo64D8A5ZV6krTEMCr7EzOLVmsA92B2QynvcZIK1W8Yn8qkl9RMgZb5vzdtrY5goWLF
	2+0UHtAU4Iem2nDTtZnlxkTiCsm9IRCcy+l2wjmJze/vZUBHjgM03CIClM7cn95ScFZqqqU2sUj
	3Gm8qNg351MrnPRT+UWwC5XfYrFlyt50/VSJFGHMTzkGBoCoaVvo9EMy02CGq7pMGVzekdXqAZ3
	rjeZJb2j5SrKP6z1SKNKoDNPazIUAQycQ4CDMo0Ikf+1ipMvmFx21K0CL3xC80tckNC2fGNwZfM
	/BE3WaUgJJ2f79GBEDfm1OPU7hlAJzS+hefv+fyaZydxjfPpWl6VhLT4u6dGqaZSVIbwUrB7Oqm
	Z7iBVpG1gX516wBTvIAYSK4ykAaVr8htMQudZV8fcOr/AwHCeH3oSsjJY=
X-Received: by 2002:a05:6a00:4146:b0:82c:9126:31f1 with SMTP id d2e1a72fcca58-82c95c2188bmr14066508b3a.14.1774905373173;
        Mon, 30 Mar 2026 14:16:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8466d89sm8661610b3a.22.2026.03.30.14.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:16:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: st_fdma: simplify allocation
Date: Mon, 30 Mar 2026 14:15:55 -0700
Message-ID: <20260330211555.13974-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9748-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C5A2361530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member to combine kzalloc and kcalloc to a single
allocation.

Add __counted_by for extra runtime analysis. Assign counting variable
after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/st_fdma.c | 27 ++++++++-------------------
 drivers/dma/st_fdma.h |  4 ++--
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index d9547017f3bd..3ec0d6731b8d 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -710,16 +710,6 @@ static const struct of_device_id st_fdma_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_fdma_match);
 
-static int st_fdma_parse_dt(struct platform_device *pdev,
-			const struct st_fdma_driverdata *drvdata,
-			struct st_fdma_dev *fdev)
-{
-	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf",
-		drvdata->name, drvdata->id);
-
-	return of_property_read_u32(pdev->dev.of_node, "dma-channels",
-				    &fdev->nr_channels);
-}
 #define FDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
@@ -742,27 +732,26 @@ static int st_fdma_probe(struct platform_device *pdev)
 	struct st_fdma_dev *fdev;
 	struct device_node *np = pdev->dev.of_node;
 	const struct st_fdma_driverdata *drvdata;
+	u32 nr_channels;
 	int ret, i;
 
 	drvdata = device_get_match_data(&pdev->dev);
 
-	fdev = devm_kzalloc(&pdev->dev, sizeof(*fdev), GFP_KERNEL);
-	if (!fdev)
-		return -ENOMEM;
-
-	ret = st_fdma_parse_dt(pdev, drvdata, fdev);
+	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels", &nr_channels);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to find platform data\n");
-		goto err;
+		return ret;
 	}
 
-	fdev->chans = devm_kcalloc(&pdev->dev, fdev->nr_channels,
-				   sizeof(struct st_fdma_chan), GFP_KERNEL);
-	if (!fdev->chans)
+	fdev = devm_kzalloc(&pdev->dev, struct_size(fdev, chans, nr_channels), GFP_KERNEL);
+	if (!fdev)
 		return -ENOMEM;
 
+	fdev->nr_channels = nr_channels;
 	fdev->dev = &pdev->dev;
 	fdev->drvdata = drvdata;
+	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf", drvdata->name, drvdata->id);
+
 	platform_set_drvdata(pdev, fdev);
 
 	fdev->irq = platform_get_irq(pdev, 0);
diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
index f1e746f7bc7d..27ded555879f 100644
--- a/drivers/dma/st_fdma.h
+++ b/drivers/dma/st_fdma.h
@@ -136,13 +136,13 @@ struct st_fdma_dev {
 
 	int irq;
 
-	struct st_fdma_chan *chans;
-
 	spinlock_t dreq_lock;
 	unsigned long dreq_mask;
 
 	u32 nr_channels;
 	char fw_name[FW_NAME_SIZE];
+
+	struct st_fdma_chan chans[] __counted_by(nr_channels);
 };
 
 /* Peripheral Registers*/
-- 
2.53.0


