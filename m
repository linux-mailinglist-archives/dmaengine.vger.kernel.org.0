Return-Path: <dmaengine+bounces-11348-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aL9TH1BsKGqKEAMAu9opvQ
	(envelope-from <dmaengine+bounces-11348-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:41:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E1663D54
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:41:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BkabDSnA;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11348-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11348-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0FE730599D1
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994363749E7;
	Tue,  9 Jun 2026 19:31:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496EE346E67
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 19:31:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033462; cv=none; b=XY+DsJliF8ElBFfUwXgH5O1SorEIw2dW0bynItuNRyhbZhoHmMJ8bCgtkIAvA0R6uV9FexCCZtAyApeKmNxl0U1EWwewxOicN+LABCsiYrXy3PYbwsBlfca7qLmAYUxuoStkyMrsjt+Uwhde94guapubZt0oZUGfUFz/FUxUzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033462; c=relaxed/simple;
	bh=YMk4eEZzQfMEEjnXMg4ElEtC/CscaEPHqozNlwYI0AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0pP4C+q92olX4RgQSIyeTC/4DVbygeIASLIjcbzwzOt5diaNoKk0KokImgOCwSTeNl77tiWDY+ToGXc6LU4L7LvSweOQdUKF+1NZ2Bp1Vg3VhHxWWU8kum6xrAgUOocmx6ZUfYfrW0YtkCGKVDzjTC2iw0CUxTK5wgnsk6XmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkabDSnA; arc=none smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e2fc11088dso54139387b3.2
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033459; x=1781638259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ah8w3Udia5Uf8f7IAKPt49JbdNJKDfUC4gBLeS1QUbg=;
        b=BkabDSnAHHyUk5mprBjsZr+2834BMQCtTxr2PvjNYUVIFZFvo1pFQ82hXNwpq+gYer
         Elhxt7dMZ2P9kLxhwheH1yXXykdaamKVdnt0oA7VTqZ5/+dIP0frTKavd4w+/LJuPYhT
         bfgn7eAkfhrCGnDEllTe60Dyej0o4jCZtcRjbG6rMtqRZDg7oM/p5h5Jmbb03I6vSvIc
         WWw0M/HMVir6I9RfMUJxuoMhXU099WgPOb82jPQRVM72JHd4MvhCxL3mvp+PO8TRKFr6
         sDRcTGOVJf+HrkHgLPvhNWPnN3qwqKbu+Ctv2qzB5U9htQAre//Txz/C/BYkA1KPn9Z8
         QOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033459; x=1781638259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah8w3Udia5Uf8f7IAKPt49JbdNJKDfUC4gBLeS1QUbg=;
        b=oCoTGwaTgHEz3COsCv1PzFy/dlvFUEgEff+qLlfa9/IkKe6d8hhu2eHQkaGSjLRwKn
         7j3l2bDWZ3EfFfUvqIlQzmkT0lOoTFPBeaxIVSyXUCHt0wQ1lTpQEsrCJnpQWiJLbYzt
         gsX9tUntD4ba4kdnNwG1JCVXPao2puEvqyoSNmQ+lnZqCoh/qO8XXSpMrXGpAMrqVBqY
         /j2sWrcpngRU6HraNOSYl4iw135VaMkHwc2f6rljZ9C44RFDxzp40W8JWvRYAxf7FTQg
         ze1HEXu4m1kPAMOr9cZBmKK1YFz+pioc1GXpzHK+FXM3E9lNq0jo4i0Z8DbatlO5KDVl
         lMjw==
X-Gm-Message-State: AOJu0YwdbZTJ7A6eb3r06OlmgeHSX1qnl6jXMFkCR1UlfgnHbGkYA8Z+
	LLoRgf5gc+zHsk8A6eNTPiQCDhn1nROeuZKtDCzteTQmeTzMczsN4hDuMWujzgno
X-Gm-Gg: Acq92OFJGdGzsLqIvgd4tWaWEK4CNQU66DgHmMRUndD+dky7BueK7ClvdfN0jYJzWGw
	Lkq9U5wYMtwW5JGuBB5Myiac1q5KbV2tH+X7ZeIT899+PziHUrXCmQmSeLnvhu50fBWZc7hP2vo
	CAAyP9xhtnsZD3TVAVoSQx5JmoBui42v2SfonXQ20crzNqAwAWC/FvqS+l7ZcxAmsPy6dTaQ9R9
	GItyN/I6fuSTBbfjSP/gPe8DH++RKgDrsOo4d2JebVq2iph2BaRvhw74fEzpI8mobcTf63COcOi
	TrnrugXD+mt4KTDvfFnM0t6z/GZJmPllXUYQa56srYZ2t89nYvZuDzXUBDWkMn9cur9lghOK1C5
	yXmLtgf3cIx9LMOcjWrlqvrt1dRkZIOjffNAF7Sh9qb15jiM9CmUCbevAVsGT2OmNXPP2g1WO+y
	Liq2rXezZsM5gZ2+kiKW3gE8uzBtNh8zmZV8jvZAG3jqH+Id/YDy9M97nhC+V5ILT5XRsx1rDL9
	dW7yMf+cjmp0fwCq+/x8VBHBNkD2z1HrLkELxwetLuG8i6k6cJ7pU+d
X-Received: by 2002:a05:690c:c508:b0:7d1:c256:b5a8 with SMTP id 00721157ae682-7ed0cee7e6fmr196251467b3.40.1781033459087;
        Tue, 09 Jun 2026 12:30:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a97729sm102970987b3.36.2026.06.09.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:30:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] dmaengine: st_fdma: simplify allocation by using flexible array
Date: Tue,  9 Jun 2026 12:30:40 -0700
Message-ID: <20260609193040.4504-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11348-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:patrice.chotard@foss.st.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE6E1663D54

Use a flexible array member to combine kzalloc and kcalloc to a single
allocation.

Add __counted_by for extra runtime analysis. Assign counting variable
after allocation before any array accesses.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 v2: Update subject
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
2.54.0


