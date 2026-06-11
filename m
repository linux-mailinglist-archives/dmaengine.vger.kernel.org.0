Return-Path: <dmaengine+bounces-11478-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id izFyOSUkK2rL3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11478-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:09:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C23675610
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:09:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QsvyQuVF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11478-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11478-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C923335327
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8023803DA;
	Thu, 11 Jun 2026 21:07:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561FF36C0CA
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212069; cv=none; b=RjIKyqTr387ta/m9DqXzISFM4A2Aa9GQo/0H4svC6kp+JFthYZzyJzpz+QBoYzdn6hsWZevlB7Qasg61yRhZohY3BnWhYWpx7VXGsgkySzD+jePy2Tpjs/qSGwLfkyY/I03a1IbaPap/UYbSYrMv/mdYXjnWLeRoeRfbWGYoUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212069; c=relaxed/simple;
	bh=2X1JrFMQp01an9/RJ7l+lKYWT1eLonp7fIj1AAy9osw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAc+kvmdlQK7TVM3D/ZRQ+GDp7urpgA2Ec/jQ1LT0ZzbruMo5aYZyNBV9hIWs7SEFVia8bYM2VK7q2HzRyy8i4Zm/ZsCQIDYGwkR5A3RR7RNjP8aF6XUpU8adrvYU5WGYa++jqyOhPkFRVafda699/NNZi1utX3Rtrg1ptrqN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsvyQuVF; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c132ac5ec2so3119355ad.1
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212067; x=1781816867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPXmf4vJCxY/GXQznJICMIjctSkGmBgR6J23ifVCHco=;
        b=QsvyQuVFPS8m7a9dUFxSDL4s3qnSZDJw4WRCjRPm7LbhLMsFUuyncuCN5DV9ccHp0C
         K5YClyW9wkh1jnkjcgcgZ0UqM/CZWEbfQCICxr/EztxCOVS5GVG9OoRGy/GN3C9qoiLb
         MmbegjO4cVNX3HphUyDWRiTfhJDey8N4w39NBqnRS2maK1ncYylad5CCn4o5KD7igj55
         ymxft3sQHpmgEqDHxulaQH35pYiP2Sfqb9GcwOhccZ3H8KEA5E+ucD202XOoqbA7jICw
         vv2PSm92ao2Xrt0V1VhJ3pVsGBSkXDEsLyNrItes3nBNwcUoRQv6Slx6W3+xvGP6vOgF
         5Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212067; x=1781816867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPXmf4vJCxY/GXQznJICMIjctSkGmBgR6J23ifVCHco=;
        b=Ku69q0YgKY5L8iIJHzqxv601HM21IfDjBZcBKwc7gTwVTmkZ7uxQug7do4GVoxHmsB
         OV2UpqUcu5RBPWUkOi2tayw/4oBvM3YSLsaJKc3uARQwcQcHd+Yc5D8n+j2dnEs+Znm0
         cq80wPwOSGuR1sV/5rxYFUfVWAIfu+rrE6SujYYQZDEo7wSxwYFkHQ/+vsCh3+1PFWPk
         d8wBIm3WACqx1cytDfyAP0HA6wxCTPBiQeFRUe+nO6/Gs5DUPhP7ltf7/sOupQVDtFF1
         NXRcu66pY9HXtnHCP7UPaPo67GdsQCNzOKzueoptvgs5hdt2+Mm7tUftlpmJvRdlfcg7
         pGcg==
X-Gm-Message-State: AOJu0Yx2O72R47Ic56O0SBrh2FdQEdPB1pr1ftDgZqplzgmPUdIE92MH
	ABH84qZnlED824RAPjYIzDyYHH5pSvZOr03tVbFxFqKaOSGy6tFYw8xTJ7mcIg==
X-Gm-Gg: Acq92OEkuR4iVMRYp9C+2rGQiDGIDr9dL7n5f2+z/0sTTptnMRL0oA8PTinfNEgEFsd
	6Ion2e6SzK1bmHQZdzhFhFJXIb+G98+9so1982UMdjsQVywkLXvkh2LzqRpOr1kj/cC1L0T850t
	zmfN08tUnFHhREW7a0O0RGg4qVdfQR8npNYxswskwq4PXUMPURbXOTZn4H7HovpgHgrdy9ZjwFL
	O+tqwPM+UEVQHBoxMKXXtFexBipC/Xx9N/Ju2gWkyhpANVPc3gyINk2BxS+wURkaxrCXgzh7y8s
	fsbWCxHHz4ef1Y7L726m/DIAG+NN9NhO+Dj/G7dMcU83wGZFkWxzabPL5jNfsjdHyLSCNtobEBf
	4vaMRzJntH8TjZcg0lP8SMOANKdY/cpKvsdvxbGKI9808XoUFRtrWzl9g10KtCqrBpwHdG2j7JG
	+MrJH63aDdrnsDKlTUJo04ANiiFkY+y8eqeayKvSocRLNHXf7pTM78/pk2V8GZfmpVR37tgJnH6
	wMi+9RQ/Bk9pY9SRA6PIZxXQ2pFiT4zYbI37xE9uLQZQw==
X-Received: by 2002:a17:902:f54f:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2c411980d5emr1090465ad.20.1781212066645;
        Thu, 11 Jun 2026 14:07:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 5/9] dmaengine: mv_xor: use devm_clk_get_optional_enabled
Date: Thu, 11 Jun 2026 14:07:17 -0700
Message-ID: <20260611210721.81979-6-rosenp@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11478-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomas.petazzoni@free-electrons.com,m:gregory.clement@bootlin.com,m:mw@semihalf.com,m:robh@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 41C23675610

Replace clk_get() + clk_prepare_enable() + clk_put() with
devm_clk_get_optional_enabled(). This eliminates the need for manual clock
cleanup in the probe error path.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 44a7d4f7fb0d..d9403172ef59 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1383,12 +1383,9 @@ static int mv_xor_probe(struct platform_device *pdev)
 			mv_xor_conf_mbus_windows(xordev, dram);
 	}
 
-	/* Not all platforms can gate the clock, so it is not
-	 * an error if the clock does not exists.
-	 */
-	xordev->clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(xordev->clk))
-		clk_prepare_enable(xordev->clk);
+	xordev->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	if (IS_ERR(xordev->clk))
+		return PTR_ERR(xordev->clk);
 
 	/*
 	 * We don't want to have more than one channel per CPU in
@@ -1477,11 +1474,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 				irq_dispose_mapping(xordev->channels[i]->irq);
 		}
 
-	if (!IS_ERR(xordev->clk)) {
-		clk_disable_unprepare(xordev->clk);
-		clk_put(xordev->clk);
-	}
-
 	return ret;
 }
 
-- 
2.54.0


