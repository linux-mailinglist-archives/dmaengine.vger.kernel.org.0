Return-Path: <dmaengine+bounces-12528-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DmqFD83IVmq0BAEAu9opvQ
	(envelope-from <dmaengine+bounces-12528-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F1E7597BC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="e33aPU/G";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12528-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12528-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14F6310B62C
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2B2DB78C;
	Tue, 14 Jul 2026 23:39:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72641D640
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 23:39:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072344; cv=none; b=NfB5ujipIDfygXqfGaxMBT8EZpjbvgnrH+8hJbsL3ytLAnunolvfljdU3sTDU2+N92eJ1wpRlXKYzZ+5OHBv3rFxFSWAnYOsesj72/OOF/VmXyq+JuK8fCoCWtRMHf3k4EIJKz5XSo57JTlgwUJBAv0uvUB4sJLio1LGnQ+9ga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072344; c=relaxed/simple;
	bh=scac1LoCOoZlclfHOjh/NGC+6kM4IpG7zrAGD+2FOuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad85SyP93G22jXSsSuw1qckpnqQRwOMeRu3ITXkwHaF1Gj8uswnDC+M4a4u2nykhQJSr0nf8awsICNH1Ao3spRFuFXWuQZf4DyykyF99O2km/ovJZP+HE94rUT3Gh8Xrpzqmx3Tre6v4kZKB1s2CmMwluTcT/rIqNoGIiKVWGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e33aPU/G; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38175907a56so84924a91.0
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784072343; x=1784677143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=klA6vgVRqJZz6oksZGdOEYmB++Nc+N5JXap4nZREOdE=;
        b=e33aPU/G96AiXGbxBMiOeMSSZloOnt87/CvxmI5dD1B680+Zc6GcCUcgONmB6gMepK
         BJEOgT3FmXHz+kOGD4PkgPkMZoJ4q1NX+CJ+z/iKe1UOJjwgu5tQJlZajgZPkY6yhy+u
         dAgIfmVcW07CO/3T5AdkTD7OKWSteA7P/9x09I//lnhsV3O2sGcbV4FH87vHWo0fadv0
         o+q5U2EAIO4lyboKiTdLJ5mPH7ZfM46riE7JEVTJ5ERKOvGqhCwn6edCnuO63Pfxm0v7
         cVIHXp52SrSrRHBsCSwa5VJXMDlYdJ0aOjRU833aRHzMascY86tLqrR8oG5SIl5icuXs
         u1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072343; x=1784677143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=klA6vgVRqJZz6oksZGdOEYmB++Nc+N5JXap4nZREOdE=;
        b=lpVHHGJAQnDlWVaXDCb18mpTh2sXq3nT3OM2YOAI/XSXun+fW+Zd3MJ9uEPv4s7wnr
         OTdETgYIJ/HEksEjh9z2QZs2O/X+YNGsMAs05kQJimsjQwPNuYJJeILwZlJrSaDIq8ar
         DlX5YlruMk7y2RMeeJV3bVG5QwpTlm384i3GVLJd44v+W7mORk2lb/n2shfUPkleRtCg
         zaroaC7NOxlRDX43y6ToG1yt2g/igP8kLU1gyBDyHfiYM3n03rSHiZF/LbdCk53sKcaB
         BAr3gfAz4su67GNQ9hUQpXta33ogEfD2t62z/f6EE6xtbGJSSgQy5fFNhksR413XuIiI
         8xBA==
X-Gm-Message-State: AOJu0Yx8KI7AlUA/3dxZq+JfUcfgQ3fs4dRf0x88D+bqZ7jMgaur0kgA
	KzyLtLmm3QYI127jSEYIx0YUBWhVXz8Nam5Zrpzr4VDSUmJ7h1FQNZyYwBu94g==
X-Gm-Gg: AfdE7cmZ126Hd/euw4U8l27V2Ou684yZG0Kd4x5TcpoRMyaivxoTQgB/2yFjVc1K6ql
	NZDoTYTj81AS2bQYG1M9aRElBVSRLZUGhIjZdhmoDML88q89VE25obJ8DE5lH6b5c0OGgRRufri
	K+5aSzj4qDk4+dmX5VAgTmEdm/XZnlxC26RVWqT0xjKm+PT9yf7F/6UHoXTlroZPZila65x9WjV
	wk1b2boJNMK0VTb35ZDxKI63EJKCDpm8Ea8L4WKPATatiYKf3iD5SMRlXXaofbKKzMoqa/wXVwN
	GQu/+7SZI5o7UHImqC0ferJ//GdFJVM4EH9LEUIjuBVLpdqXl/23NuCQ3P1DZcNw2LPcpSyRdli
	a/WXsbNYGcBC5cvokoL23zuez1e9Ou8/raFrHYeDTWhZdbtyTmPW9lDlIwGEuEGVkBYxoYi7afx
	hxGebfTpqg1WVnINTR8hV3hcUG1DfAqh6I2bUUt493/ljUeBAXK2QSrzaM81bldxq84ECOYCU7x
	Jwu24e/sySEhulwjpGb6awzOF0nQm/ecJw6I9+vIYawrynf77Wz4rTYUCSLO5hNWQ==
X-Received: by 2002:a17:90b:2548:b0:36b:4d63:4a93 with SMTP id 98e67ed59e1d1-38d15364030mr19810776a91.13.1784072342552;
        Tue, 14 Jul 2026 16:39:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm72317509eec.20.2026.07.14.16.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:39:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] dma: fsl_raid: use devm_platform_ioremap_resource
Date: Tue, 14 Jul 2026 16:38:55 -0700
Message-ID: <20260714233855.870797-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714233855.870797-1-rosenp@gmail.com>
References: <20260714233855.870797-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12528-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5F1E7597BC

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequence with devm_platform_ioremap_resource(), which fetches the
resource, requests the region and maps it in one call. Switch the error
check to IS_ERR()/PTR_ERR() and drop the now-unused struct resource
pointer.

The raideng node has a single reg region (0x320000, 0x10000); the
job-queue/ring children are separate OF devices probed independently, so
the region reservation added by devm_ioremap_resource() is exclusive and
does not introduce overlap failures.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsl_raid.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 47ebdf274331..aadb3dcb1b03 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -747,24 +747,20 @@ static int fsl_re_probe(struct platform_device *ofdev)
 	u32 off;
 	u8 ridx = 0;
 	struct dma_device *dma_dev;
-	struct resource *res;
 	struct fsl_re_ctrl __iomem *re_regs;
 	int rc;
 	struct device *dev = &ofdev->dev;
 
+	/* IOMAP the entire RAID Engine region */
+	re_regs = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(re_regs))
+		return PTR_ERR(re_regs);
+
 	re_priv = devm_kzalloc(dev, sizeof(*re_priv), GFP_KERNEL);
 	if (!re_priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	/* IOMAP the entire RAID Engine region */
-	re_priv->re_regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!re_priv->re_regs)
-		return -EBUSY;
-	re_regs = re_priv->re_regs;
+	re_priv->re_regs = re_regs;
 
 	/* Program the RE mode */
 	out_be32(&re_regs->global_config, FSL_RE_NON_DPAA_MODE);
-- 
2.55.0


