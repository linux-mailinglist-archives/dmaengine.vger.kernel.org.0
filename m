Return-Path: <dmaengine+bounces-9680-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBd4DIOMxWlc+wQAu9opvQ
	(envelope-from <dmaengine+bounces-9680-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 20:44:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56033B10E
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 20:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEC53043D19
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAB3A5437;
	Thu, 26 Mar 2026 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TwHu0EZ1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5439FCAD
	for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553758; cv=none; b=l0zG1Dg1j6O0y5JGRlXGokxcu8Qtc5CqGxckHlcpUgVkO8w6V23l1SmwZvbQG7cM8juJvpiQ5OhjoC3L70uzNzzfRcahQyZagKxZRgS4VbAnXb95a2mraB4rSmG+mQp2DsivZ6UPsa+JZ5HOSLa8pQAFeQbrHbx7ZlVvSqZ7NSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553758; c=relaxed/simple;
	bh=nZrcXZJDJdRBC+lHC1IgScYqeV6+oG4P5SuNiKNdU+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkPMkjAB13r4GREV+dVLbYtF/7gECz3xb2FmrpR/9JjcugD+5IT2NlqyfizosKsBYt9KMvOUHYX3tud4ZtKvwR8013YHhJk10JnweLB1B34P2j+xpQ3djuoKhegH+AIpRKb7eITKdag7wj4GLXOzYnfLJNkNr8xCARE24UJWNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TwHu0EZ1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b6d9c981so861203f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774553754; x=1775158554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p41Lx57tnZ476sTVP+oFeMhnz39TyHhAq6c0xIgcxwk=;
        b=TwHu0EZ1Qdh/3m+HrQDxCmleX76y/Crzj9JCRv91MzdMljTt4XgLbQXpKLLFfYIvFV
         DRTjArIOG9v4h+KXiptCe34EoOB052q3QkF+AZ1cqj1QU7W9IHVwhcLd9EuuKb0BsbyH
         3GuqvPkwXfS3HD9dLb5v5hLWv3X/Sk9z0Z/G+uX0rfxMs/SBPGqemPKrpnEdgr36cxgA
         cvcex8ZvO8SfisPAhutAvvFQ/bxW9ByOwxcHwdV0S9EBqkET9Df+6cObFnJ03e62iOc5
         8OEow8HIujv0Z6nVNmKgdMkuIgwUVqzqdpmYcgV1iRsA/kaR5Sw/OLs59MfV2Cr0DaNt
         +L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774553754; x=1775158554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p41Lx57tnZ476sTVP+oFeMhnz39TyHhAq6c0xIgcxwk=;
        b=rBzNBnBHC4gy5bWYQfa1huwf5/aRFmTMw8qWBWJ8+FR/5DD+0VHaZt1OvaQX5QoDvW
         vW8liwSIQCh/icqUE3cPSj3us5tVGnZclTp7UPRrYSFeWTTobPkqIseDu/gwOCJeP2pP
         K7x28/7aURzHB0cPjVTTHTMUFL6GcWxONwoOsys8V2h3zZ99Ln5bbDiLe734hBRh6UKh
         ZhTxSSy6q5vgm/82mcTdLDJzarGBggwLkNJSq3FZy2P7UUyRLWzHSA8TKLneUACL6Vij
         njwpLpbeQllq+OGXqYK8qKIphaW6xMoPhkrIiUGgVWcaeIRkQbD/707/ayQFjB3Slkmx
         bjZw==
X-Forwarded-Encrypted: i=1; AJvYcCXoxKorFHpnJPqMOb1iuSr9A20jnZyebU+D8VWrK3XcPFU2YTq0sFGyrkLoEez4dqJ39ITUL+VVbJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/klp/F3op8dTZBV6hoWs5B5sMHgKmgyNwoeU+6YjAVQFOKE5
	jFaq22unaHabzoWqSP6eqOD0YB/pMJCrUrCAkDVOH0IMZ3E0aOEqS+1zrAfhChVJWF4=
X-Gm-Gg: ATEYQzx/8lbOdCa/B/1Ib3FF6qgDC5n3+ySVAb2Z1gMiqp0/d9J3ubtx8w90Ga8jdYd
	dIbe++oEQAubR7tw9Bm2mt8ylLe5zZ4ShAxuVsKN265K6paKbrLX2GSU4K7+sk3t/D6p5rZmKJ3
	sq0wjivE/TtQ9UJDH3W8Ut6BkT1gCxb3PQoWrYV7emnAHttPQvPixsluESctrEyj2r0FEmF7+Kc
	qnDPidE0VNAUm+ZEw9PJDYS5V9W/0zV6AheQezaJ1efr9bQW2jgwENkWEmL3J62TO2CcyxZ9Q2b
	ZJ97jBdOlihPsdD4OFHIj6oQ0MTmGb0hzerLYXc6/4IE0NPqN+tuLakXhyYxUu0F4Y3H+g5DhVa
	iM1YuJifZRWKVwnybpNLGNNMCzfK0LVaXAly54eyC2zwC6tJsvE1y65k/XLQ4hJlL0YvTJI1rrv
	0NjIDPh6yl/RbyS0gKk84XUBgA9iJB7hiuzd2i8KZy273C72gheNa6
X-Received: by 2002:a05:6000:2101:b0:43b:3c53:283d with SMTP id ffacd0b85a97d-43b97a5301emr3348932f8f.21.1774553753875;
        Thu, 26 Mar 2026 12:35:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df6d4sm9608520f8f.25.2026.03.26.12.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:35:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
To: ludovic.desroches@microchip.com,
	vkoul@kernel.org,
	Frank.Li@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: at_hdmac: Drop unnecessary parentheses
Date: Thu, 26 Mar 2026 21:35:14 +0200
Message-ID: <20260326193514.2377083-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-9680-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,tuxon.dev:email,tuxon.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC56033B10E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Drop unnecessary parentheses.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/dma/at_hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 9c8c0fea8003..060c3c868af4 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -816,7 +816,7 @@ static void atdma_handle_chan_done(struct at_dma_chan *atchan, u32 pending,
 		} else {
 			vchan_cookie_complete(&desc->vd);
 			atchan->desc = NULL;
-			if (!(atc_chan_is_enabled(atchan)))
+			if (!atc_chan_is_enabled(atchan))
 				atc_dostart(atchan);
 		}
 	}
-- 
2.43.0


