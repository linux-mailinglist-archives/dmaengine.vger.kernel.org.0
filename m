Return-Path: <dmaengine+bounces-11128-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hOkLOvGaH2rkngAAu9opvQ
	(envelope-from <dmaengine+bounces-11128-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:09:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237D633C6E
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=azF5JePy;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11128-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11128-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 875283058310
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158673D811E;
	Wed,  3 Jun 2026 03:08:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD93074A1
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:08:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456096; cv=none; b=AaLhbqfLq2IEXkZ4XEfcRPyko4TMZoMY6irT57AG5bjjI0Xy6tVaWq/CsRtHjKSEqaN2mVaw0DmYtiHC0FC1dCoNaEzUln1gDnY3bHy1B/gAD3HZ7ZUPJUXh2O8gKnzxkhPzEspnssizRLRcnNjektBMtUNls/i28inSYX7F4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456096; c=relaxed/simple;
	bh=hx410UHSdlgBtjJ9H09sx+B50T4kbh0WwKJI7BtUBdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6Zjwsu8LxleMNCiarJSFrlVOEq/WISNbgFZuP0VNYRLNnKjsD0k4aqPN9y0ZqaDml0fbCzMGDazFmmCodSs83WhuznLAAhxhv6t4wPmJQ07CkNPDJLTaGYAX4IxbAkW5G86TTVkWfp6SsJxqAOgM100IeVBS0hKoTf2pYE5lmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azF5JePy; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso2774752a91.0
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 20:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456094; x=1781060894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=azF5JePy36swlzNpOYVtVm0tRqu65aVSrAxaDuv++2SJRW6lcmoMtsKFfJY9paWn1N
         as3oKKtfsDuU1EP1XIjvz3tZ68XlBaEt5dwwMOl8IJf8ft3MLe2GU7kA50gTr+/3R0a3
         yP1K9OQyLkLOFJ+axFvRSE1A0ijgv08zz9TudzsXfkxMWq7DwP4mKexTxr/hQUHh8dqt
         pIC+2765WHMe19xpvQYUvRAAjPxHbFqg7xWTn7/jlk0KuswZly/Poq9zE8svC7za2vw/
         dvDwAZ4YhQrlEf0kM8Zq4cCOqk1joih0RKCyGTk/3hh9rDITGWtSzFhSpdMSZ69duZ55
         1z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456094; x=1781060894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=ISQ6R/mNrjesRWp4fPBkqaaTyTHRyWfl68tUZZbbRVN2Zs6TUAkx0KkbA/nr6UWi9G
         BVC9brOkn1R+AOG7pyBVs/LtunMEuMHRzJvejijXeJmEumJd6rXMSiA7Opvir9Ees8yq
         0779VfV7Q5SU42gIJWwTXBZwNCIYJC/ykRx0jD4YLa6UPHp4jMHXhd1NwcSTIUUeeMsr
         r6MGE0BRIhj6xNY7DZAvPZeHt8E4GGopKMytyUJuR2nFJt0ZnjE6p5vk+o66RsRkBKIH
         AsrEKa/ns3dGMZi91DRpZKD6eaUWUf6/lN12uCgA391+hGzcZolwA5Scc9EUmuVWV/hR
         fYIg==
X-Gm-Message-State: AOJu0YwYpH3Bh8F7Tkd/vMutlyhbTYNGJG1br4ShJ0nYdJPz7yllRIGT
	ENIesWgrDfPpessG5NDL3OySMBHqcrFECVXZ2U7f9nybAgpK94wxx9Ib5mRG8V2L
X-Gm-Gg: Acq92OFx1ysdDFW6jv+KvMv3hQQtwBOeWLG3KySKnM/JkrOnvWM+5i/XasQPIGx6K2n
	rXqtudGUvA3BwONcLQ6JE0cdJ+zUmxyR07XsEGezbfpc7kdPFERLkyp0qIh8lW8odhu9JfT5gOW
	szwCw+P3jVEPcTEJjaJ9reX8D1L3ksGKSCpJK/Zk4kC9Uqh4LH1QNiTuAffuFciwtcINFHr/n6P
	2y7IxaENMRfplHd4dnanMHj9ZpKTLHYIbcrcSBD5LvgMCb5SHVVk/9xvBuVx9Wyh5wW6BZru0Cf
	AixlUcAwhlOcQmfymRUYJ/9uPYOQ6oMORoNWBO6yqyh359PkbzA3Wn4gubeJYmMVqzA7LD+2qel
	ghl1D36UOB+FLNl2+xyLyGwHL2xSJ/nU0cwYrv1sRdIa1XG86Yi1wjk6DjtgaDfLpYOxtraxfBs
	MwaPdZ4ix9C95fMpz6joaBHVCfNGg1HnKCyAnP6F8KLXeQVflRCx141yjj+gpFhlGS9nlAqWzAF
	yey/ASTNA5ucbPokccTsr02qXvdXTlLEbjnrEpsrEfWCw==
X-Received: by 2002:a17:90b:384a:b0:36d:66d4:270d with SMTP id 98e67ed59e1d1-36e32b3bc5bmr1473910a91.20.1780456094147;
        Tue, 02 Jun 2026 20:08:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 1/8] dmaengine: ti: omap-dma: fix missing return in probe error path
Date: Tue,  2 Jun 2026 20:07:47 -0700
Message-ID: <20260603030754.288757-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,atomide.com,arm.linux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11128-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:vulab@iscas.ac.cn,m:tony@atomide.com,m:rmk+kernel@arm.linux.org.uk,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,m:rmk@arm.linux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5237D633C6E

If of_dma_controller_register() fails, the error path omits the return
statement, causing probe to continue (and eventually succeed) despite
the DMA controller not being registered. Add the missing return rc;.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..0f6dd6b0a301 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
+			return rc;
 		}
 	}
 
-- 
2.54.0


