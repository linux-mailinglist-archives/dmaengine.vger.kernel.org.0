Return-Path: <dmaengine+bounces-11282-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OfDmGStRJmoZUwIAu9opvQ
	(envelope-from <dmaengine+bounces-11282-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:20:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1739A652C9C
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PGUrH9nz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11282-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11282-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D61353027350
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 05:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442937998B;
	Mon,  8 Jun 2026 05:18:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B531371D19
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 05:18:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895931; cv=none; b=uGmLyjzQs3Ji4jeJX+hzIn0TnrISqaVpEHEjotpRz1g7wpoUzeGwbolV6B+iHD+22EguWzXH1MMnj2HsoAEAlQS973AQcde7J6QCQH7jSzQ76MGG9nCywaxbjCCf12pmDlps/N68SZIAWwhT8VZmrx9gfwPvVS6WNU/yfyqlJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895931; c=relaxed/simple;
	bh=2vhkmPNIW4/KCYWvHjq2mGkNcmFCQZQd8d0hnhmyVHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jl2m1v+awx5aieFrudbBzFsfJTbv5hp6D39G3ynaNpTe1BwkMZkgdwGc4lZLKjrRy3DsWJe7bcmwgrfMvDkb6jGJj99RC5GHGEeVSsH9wgTMvGlHyokjCHfo/SZ3XWjzrcE6LgVHQQwNDQvJ/7AUHQbO4AgvaVGeudAAby9F170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGUrH9nz; arc=none smtp.client-ip=209.85.167.175
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4864a5c83f1so2516013b6e.0
        for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895928; x=1781500728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41O9k0y5eFiUd6+1CLxq2KiJxjSqZ/KgLg6URVebdXU=;
        b=PGUrH9nzBx9vqyC6InwLRB1zkzZTjl3yzVioz4gQ3ZNIUWJrHvGPT7ZWsTDa+6hzMt
         tdnqxYenUai4ozzW7RNhKzZeOKTzsyFoRw7pBKv5UDaQDe31p0ZXw7UxJEZmCiCGxKcM
         6Ki9sg0vBfsp+AEVxURdXz9z42UrOt1aS9FDp8tJ0nEp03oz1PsQ+FHf6JMrSiJMVX8s
         zSymjQ1FXiH2QY73l3W2sJD5cU3eNk9Yf5OoS6DKohbCWAJsFFnMvD+3xD35YHv66QPk
         yEHpyxw+JJ9SqE/agmWtAjaUQYeI3dkNO+2IjY0E+8SZg/gVkKpG0EGHoSn0WMz6H/4X
         urTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895928; x=1781500728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41O9k0y5eFiUd6+1CLxq2KiJxjSqZ/KgLg6URVebdXU=;
        b=BRL3qXanWMEeLor3HJDUR3IZCdoDVIRdaM9sFm9tpJ9ppOT2rWNtVQMFtypGrQfdHR
         gpP70UlBOFGDFDXA6sRxeOLJaHDtzhNzUYwlocykZzRzL76rhbyggxrmm8tLFiP4Epld
         IRf0VFYlwqmmqYk75IgzjUYc/FkIH55RsG8m6qOiTkfsr/K+rXES7ovcAnbptYEPXQew
         JueYBSFZbiYvWuQNZ9sPgB4bAAGSoKnRHI+4iqDKq+yi1mAL02yfG9u3V9Nq9UBQHKsg
         P1bO/oghvPoxYrsQndrQvmPVrmxWFRUZrDqoS/F3Gg2Xyk9dNGnO3WrdoESjr1+0I2PU
         XdpA==
X-Gm-Message-State: AOJu0Yw8vDIPxGAgKnnsWbnicx5gZ+5TEblDa+IYdrNnWgDGMJZVAzT4
	SeNmEomSovLpvpywfqzp9KaEqU9lF8oPlIPoo0KOFYrUsmfosm12sqfS0aifHGeh
X-Gm-Gg: Acq92OEPM0QVz/XxwQHlxfqAqit9cESDmDwi+nm2ZqyZbRASTHhijRFc2ZaNmK53qlg
	y5witVkiW7Hq5avIvlaK1gLBoSHHHCE/HtEsxkGXPehmtigNBjqjGf5S1BHdGLw6/CPFNh9gLIg
	qhdpP9JYA4zgCLC51kPBlrAdmV/KxDzZbgQ8RHbhi3bSMsPyHl49WMv7Ks/T7fNxmr+YQkb+oAF
	rZ6/WJlyOD8LIZ4ZYUeKd9Tx3T6O6U+qlYgYV5nHigAJo/rn4SfFKUyD6uofGtqlHgTWDYU5BRP
	U0el0MUw5XhwJbewzAGziclFcUtVfaV5ButC5Ps3WeoFB04kvLIA8G34S14/LT0+bnaZLUCy3KW
	8FYQc90cMP+vkwREKTJ0+BhI6MdaGiTM0w06zzQlmOlyQWXO+DkV1V3xzST3knOK4Qpopz8Vont
	6HhoY2k/vzdxYM6j5wGgrwzY9ItGESKo0WYqbIFtc+3mh9vOhbI+LoBfD4hvzPLZpGmIy9G52lZ
	/Ng42kx1pdJnDDSocAmOr+IDsuf2npyXkGFeU0cmqMrhw==
X-Received: by 2002:a05:6808:148c:b0:486:39db:ebf4 with SMTP id 5614622812f47-4868dc042fbmr8070721b6e.8.1780895928388;
        Sun, 07 Jun 2026 22:18:48 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e75b2017sm10838024a34.8.2026.06.07.22.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:18:46 -0700 (PDT)
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
Subject: [PATCHv2] dmaengine: st_fdma: simplify allocation
Date: Sun,  7 Jun 2026 22:18:29 -0700
Message-ID: <20260608051829.7390-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11282-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1739A652C9C

Use a flexible array member to combine kzalloc and kcalloc to a single
allocation.

Add __counted_by for extra runtime analysis. Assign counting variable
after allocation before any array accesses.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: update description.
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


