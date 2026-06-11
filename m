Return-Path: <dmaengine+bounces-11483-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NGK9K5gkK2ra3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11483-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:11:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3AF67563A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:11:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LFLR/tOg";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11483-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11483-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD1E341AD91
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44768384CFD;
	Thu, 11 Jun 2026 21:07:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DC3839A0
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212075; cv=none; b=oYoSlUE5cdST62Fy05YuWtB1FMUx0H9llFot7UE/4xPMwRCV4Tf70T3adPg50BOcd2YWAF2OXMe8W2PDoY0MdkvBSKPSZHSLCmyFbmWUJ2+ydsKQPtXgIxOQK8IjbYFee2m3bSdhuCVnQrwO7P7CuruM1SZUGjYQV/0aYWnvdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212075; c=relaxed/simple;
	bh=SnXi41m/PJ/XgXZREgW9Hgvxn/Sg1ZuvA6UCUp8vS8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9ha/f8wqnTvMFEq+Hprqojdxxnbil9QySHvtFarrc6u5ehXAG0gD+wV71AK84KW9if1EVpk6LR47ycakGmZXYCFwrPB5oslUQp2Xe7KIJxAyO5Wm/Du0wigZPTk7jlawkv1sA0t0S7Tuf3bn4dtSTe70XmvFC/6/59gdj9T8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFLR/tOg; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf125989f2so2541035ad.3
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212073; x=1781816873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmerwbqBQn/j0PTKrCM8zAfuII8rL165LbPN0XVzvqw=;
        b=LFLR/tOg+/Fd9sqfJ/Er2RQnDOEiciazkc4aWi1Ph80OYxM4uNBCunxZ3QXvwleZIP
         PFI7RmTr0/xmJk8FyBp/uO5VJtNmTpBmszRR+aR/WkXXh7hRGE5ARAgS1s55ZeRIq3C7
         jxu9BOCWeTUmZpIxtkxYHTsvdEO7s0s3AipQWoniNDgul/CDXsjHP1mZ31NoUj05gVCt
         mH3HEqaTKfBS7EjOvnwUgDaAS1T1PVxhVr/3zN5lc4tQuEqyw6CVNEIhXa01Lbfh7r0f
         5TXCOi7e6e7wQkp09JpANBveBtHRfSZWVUL66cVRDlk6BrJPihqwice5V3YOIjuB66nB
         CHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212073; x=1781816873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmerwbqBQn/j0PTKrCM8zAfuII8rL165LbPN0XVzvqw=;
        b=UZNe1hj83vWtbo87jl2dBbYSLwY8LaUJRs/CSWlHO2Tfo20tL4m8TJ98WdpS5VOoXZ
         7vy3e3Qm5v1aMeWf9Bi/Ks0o9VCyJ3F0U+FaeRk7M2FO22tl82VyN9DGbzuU+MNwamh/
         r5VHdna6MGl/CvoERtvbt/2rgq3ITXzZxU70oOSqdTJ/gbyiLWdvEb5ytfKr4iuOApbK
         d44CQYEx+2l8uiu1xOZkqYoXM1p/3GljyLml7cxstjbGfMBJnDWEbPAjUqrLqlEly4sb
         3u138qA0S29m7IXCkzTLi0yUJCDKmNF/Ri+Bg1H/JAV944q78imtcb2KPjmOpL0VKukG
         aFqw==
X-Gm-Message-State: AOJu0Yy/iRE+4v5NYyv62pq6NjEkuks14xg/LjmbebU+xf5htcdhqmxA
	NiEgUSV0ON2Qf609OXS4n+UZ2xw08hM/qO0AcVuJEXUFjcWYJViIsiwxPDQUpg==
X-Gm-Gg: Acq92OFjVRlJi0k/57sKwWPyVXpo+JD5t/iTn0GWgLHMXFW/o0RDmhs7EYvNWGRFITF
	QAAyKqa6EHWuE2TKT6A84GF0lijXCXIV7AcfZDRmm8E1ZupgMUzi8HlwJb4eM8ZaGTLeoVC/KXh
	2MRxo7W46CXuodtMxqujT/rqBW2slhClEX4EH/qADVKq/NhHR4HSKAPpdkc6uX6GGUFF6jin2Wq
	rgziSvP1L0TKy4gZ0tKQpAeybYiNfXtPSrWcdaBHHKi9cI+nCMlsTypN9GZnsoTqNKeFnp9sEoB
	W/ZJfCNoIOaVXdigthRJrNq5zl2I8WsxgJ4Qp2DiJxgdZNasurHm/KWSBWxGsaisetg5wsWWv1J
	8dbX/MOMUlBWR/aFZ5GCoJaBWNcMuUzTYnXnFNLTkHA5rJMMtD3ST1M8paj9w6MFddxBtsaUOBB
	7avDPak6X11V5aauWj10cv/FoIaE8y4QOcC0msIhrTEyRA9ZCvkW88v70rE99sF+BIlsGNeUHDN
	Z42Zz1GTAQbeo+P6tFWe96e20/t5SxdD68W2BWff7IrkA==
X-Received: by 2002:a17:903:8c4:b0:2c2:5446:30eb with SMTP id d9443c01a7336-2c411b7e5a4mr975565ad.11.1781212073087;
        Thu, 11 Jun 2026 14:07:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 9/9] dmaengine: mv_xor: add missing platform remove function
Date: Thu, 11 Jun 2026 14:07:21 -0700
Message-ID: <20260611210721.81979-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611210721.81979-1-rosenp@gmail.com>
References: <20260611210721.81979-1-rosenp@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,vger.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11483-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomas.petazzoni@free-electrons.com,m:gregory.clement@bootlin.com,m:mw@semihalf.com,m:robh@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F3AF67563A

The driver was missing a remove callback, so channels, DMA
devices, and IRQs were never cleaned up on driver unbind.
Implement mv_xor_remove to undo probe, patterned after the
existing error path.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 255df2dd9c71..85cb77022144 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1446,8 +1446,19 @@ static int mv_xor_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void mv_xor_remove(struct platform_device *pdev)
+{
+	struct mv_xor_device *xordev = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
+		if (xordev->channels[i])
+			mv_xor_channel_remove(xordev->channels[i]);
+}
+
 static struct platform_driver mv_xor_driver = {
 	.probe		= mv_xor_probe,
+	.remove		= mv_xor_remove,
 	.suspend        = mv_xor_suspend,
 	.resume         = mv_xor_resume,
 	.driver		= {
-- 
2.54.0


