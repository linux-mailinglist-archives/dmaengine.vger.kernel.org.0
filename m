Return-Path: <dmaengine+bounces-11356-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OSsJHOSEKGrJFgMAu9opvQ
	(envelope-from <dmaengine+bounces-11356-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 23:25:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D206643B9
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 23:25:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UxnCHWk1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11356-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11356-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D58300EA9B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 21:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E083B19C1;
	Tue,  9 Jun 2026 21:25:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192837268F
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 21:25:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040351; cv=none; b=d+0EtrnrlGDd9WIXDSlsvlbJpCqtvgJ07QHm77tCMKGSmNyPQF0HRkjimgrG3eePrkUWGSehglAMu5eLdNiwjIKYEXELnUfa4c24hGSKQhHRJz2XdRkObjvXo5FUbxGmnVXO/UMKJ5MYp77CjCScz4QFQvZyeS3mwSYVABWOY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040351; c=relaxed/simple;
	bh=H3CAB1l00Dn9uJQyEA/EKAUW41tGS19mLJg8EXntY7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVUldWRIcPS65q7smZ6SJIOKG10waf6MnsBYeV+strCKNVp6qXSAUoDsjDgFJ68LxCanMOJD7df+udhtUMyrafBc09IBlsU8wFysvY7Wzu326zzg1S1s0w3blmFyqYNy49DXDkg67HDDCeC/m61jdP69CGM9BssUBNjzIcijSvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxnCHWk1; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8422871b42dso3629996b3a.3
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781040349; x=1781645149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3MxpUJ9A/oFnIxzY0zUawQ1/Q0lFFBXb9u2LiPcWeA=;
        b=UxnCHWk15UnA4ecFSyRrvLK2fcs3yKxsilkcWin1Pqt5Py3I3K3JTiN7yGHaowjxOW
         IYvaS5i/JLhmHWzC/o0/OTx1uijalpQ/vOFS3kK3DCcbad+oRCvEN6slTYkDI24+Lpmt
         Ej/iyoHrmD8ORi8KNovYDMNihzwpO7OotZi788LqK4ZlrWMCaYpbgW75dd2V/QS91InP
         RA9EEfrwat1Ap7ASNV2hCfS4iwcxLbJlrcOs6EDMZx3xPDk0ItWIbOHlSuyRzmzFn0Yt
         QeBHVjOijM3Q+kZzaMUQ77NDm5aSaeLH6SNc+LdwwmiudiI6Sj5VgOK6WbXALvwEcBSn
         sMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040349; x=1781645149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3MxpUJ9A/oFnIxzY0zUawQ1/Q0lFFBXb9u2LiPcWeA=;
        b=QtlaQxIRvm5689yMn8yGKSP/1rnrXSuDorte5KhRYsk/9pKJEQAEQ7Q2e5to8VPw9S
         KdOaPdKOpOBhAZ6KtdARm+9lO0X2DA/UzFXDqlQvjh5K2z6bo2DTKqbsWd7+TER3kSHu
         B0ycmExWj9+ldj+7ZB1KsBUlYxgP6E4Xp6O8LR7AzCPY/da7xk3FYCQnWqpCzRGuxK+J
         jDsInQTEjzcgA3u3fMIF1RudqKhfB/bsIgvUWqnNN7betKHbzTaZTQKGdxjMZHdEbbYk
         LWhM+oqNUHt0GtAgTvs0r3GxXD9KgDkpkxaD2sAXC81DHZQLFgdLH7mHmc1mO/9uDOyt
         pnyw==
X-Gm-Message-State: AOJu0Yw9xzjVX7O819KP7VSoFdOofRS6N5YIrc/jO37qoyTUt4r36OwF
	7EZr3XrA+NLbVuyNWQCe0WvbT6xmviUTPzpz9C/JXzQkSHyURWbnNHYG+qErqjqf
X-Gm-Gg: Acq92OGcs5T7+u0/ZsdAGqP1kf3xk2MfCZEDTP7DP20ArGuTRvgksrpWmQl+1vAEZb1
	TGYYjZ2RoyV6kzdYWR6EPnsvf3DenkvjH1ifbER+MQDTh0Xza+zPyhTAMiQr3F34QFR7MCPY7hK
	FA7ocMOpGWE/5aQokLq2/0B9GAFTiNrLvW9/VcgCo/XFh0R+ugrWumy7ZUEcCodj7D2QNorAzWw
	zrNCJLQhNQSwtDhJ8a3qFTJyBpDNiB3a4lc2/X5idiwlQ9+VkhzdDQkuUSfufoMdSSFLJyFzQNg
	1+tnoQgYds4TohmGvr/fb7pILGwT0Cabdknhq4voGRAg9Imc/CZ1SLdlgrD9PnkK9yAp5XXhNYp
	1DSKleiET3LxLGo/06ZZBrl79VGkpAHWv6mAZ17+XiWK+2Tl8WT1Bq3IkEj7F75m+mkAq3Hhu4C
	ep/JZ5OmscsW1uXRPBrgaxRhBxcD4gwCsZYYhDLKJkOYBBYmIvkp6AtLlVVOdjS0Uq1jevKniOn
	c/8t56Vx6xIyYGMNFKLu5LG6SPArtvvrEvPpyZsvkfY2w==
X-Received: by 2002:a05:6a00:4c0a:b0:842:65f8:bb3a with SMTP id d2e1a72fcca58-842b0d61a33mr22235351b3a.19.1781040349597;
        Tue, 09 Jun 2026 14:25:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428237430esm20591050b3a.21.2026.06.09.14.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:25:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4] dmaengine: tegra210-adma: use platform to ioremap
Date: Tue,  9 Jun 2026 14:25:31 -0700
Message-ID: <20260609212531.22044-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11356-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:ldewangan@nvidia.com,m:jonathanh@nvidia.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8D206643B9

Simpler to call devm_platform_ioremap_resource() as it returns multiple
error messages for whichever part fails.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: rebase and reword commit message
 v3: change subject
 v2: reword commit message
 drivers/dma/tegra210-adma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index ceaee1e33e68..21a381d022cf 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -1087,15 +1087,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		}
 	} else {
 		/* If no 'page' property found, then reg DT binding would be legacy */
-		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (res_base) {
-			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
-			if (IS_ERR(tdma->base_addr))
-				return PTR_ERR(tdma->base_addr);
-		} else {
-			return dev_err_probe(&pdev->dev, -ENODEV,
-					     "failed to get memory resource\n");
-		}
+		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(tdma->base_addr))
+			return PTR_ERR(tdma->base_addr);

 		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
 	}
--
2.54.0


