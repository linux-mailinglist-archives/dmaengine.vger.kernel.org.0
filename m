Return-Path: <dmaengine+bounces-9701-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEAQKddDx2mSUwUAu9opvQ
	(envelope-from <dmaengine+bounces-9701-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:58:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D6334D1DF
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 767A8305B33A
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 02:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A895362124;
	Sat, 28 Mar 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrbUkVoj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FC361673
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774666642; cv=none; b=AQqZxwcqV32QwtoZVPinyhY3Jaj7owqbDB87+WMgKhL9kggBZnZBSn2W9O9ieiKUrC69hErLr8AXYhh34Kn1SmAgjjEzNO3Pc8FJCf6KIJWkGl3mkKagoFMAULyqc4ytccnhDMQbCqR/jKi/QQ9ADYvUvdSj7Clv69Tz+HzQfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774666642; c=relaxed/simple;
	bh=lEmMFStHFCwVsgKZXQzMzKO0rGosEiMRtW2Qypi90Ag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPU975aYJ2GFLKvH7bN8c8tqjvU5iIC23cMTRgWAZ8rOfQeiRXjKY0Im+0hF3V8Ms0tw33+PMTGDXV0JFuHqrU8r4wdQcInjtquBXpOG2HiQokKKj/YHkUaupdbkzIKE6JGP/l0z2PbfaABb8tGpzzxVCoP/KPU4sTGfc9+yc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrbUkVoj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad9a9be502so17070075ad.0
        for <dmaengine@vger.kernel.org>; Fri, 27 Mar 2026 19:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774666641; x=1775271441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtEVRFr5TjD+uQz9TD2YL6Kg9T6ihv6Kbhn0QKz5XCo=;
        b=OrbUkVojuN/vZerXObOZsIzZeNdbSCll5PBLUGWAPYXF9Npy4lT9VZboMZA/gAvbSt
         Jj6qKVqPzZwJBRfn4IXx4noCPm79qk1iDTu1vRiQ3SBMd0AF2KoaiIu9bePdmmXWx/Z/
         p7l/VzEN1bI1iL9b1Nis5HRdjfFO6bvNFN5DlDtUvaBcpxiWd4ETznNYgqKutlK2ulaw
         4danyljAJD8CZQ9VEgnhIV5obcn+A/GFfaoQyDgzHOs7WfCTQABk1Scv3+iMcrWHzUf3
         fI8+mBwXu74gikCYzEUQc3r4OKWiJF0LlZo2qIZ7gDlwZBADPXSPAdHKUf/ZMGRRa+7d
         kKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774666641; x=1775271441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EtEVRFr5TjD+uQz9TD2YL6Kg9T6ihv6Kbhn0QKz5XCo=;
        b=j6G95z1IDJM2gg30o8dn31eYA3/3z6lUZeDHnzHYLBiy1g2rnxMImv2lAdr9ig/Sbc
         bm1e1+lt/Lx+ur+/2gbtmVLNkgkduv+d8fTUPdunTcj5YC+u5dLLr/QH1/zopxri2sp1
         1ruK9+CzmYwFt1p03AVL0Hf9vefjaO0TOYtBIH603Q1vmDTipanzO+o3BjzDbia50g0s
         nD/QRy+FsZ9TpkfEVK/XExv/WqbrxyN9+t52Szn3GCteTpHJUOVvKD9Ln0b+kU24vvsT
         XU7TMbJmrhnwW8i0QQvxg5L6Gvm6HXJ8oi/aBFYbK1IvWL1d8/bnffjgPxdO/EITTeWn
         w6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5c6fanp0jWt5ATo6EBi2MpQb5Hb6Z/wjht7bzHr9JSrJtkc3SnLekBUVB9W2sI0dkq5yEdKAQkTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PKfFG9Y+FrUcbrp4VniTywlmmMCfDjExcO3iJ48ZBHAu7e7w
	lNR2+RHnkdMxU2ryyml19APOAGFV9rhPSeVPsAWRLCZqSlzMXUTQkXoK
X-Gm-Gg: ATEYQzw0jAIAbFWhk0TNc27zoKzBL+wwNMy3tunegvK6iAeoqEZYJ0ZQU2GXRMTeTP8
	GKfiP0JZOA305DvLcC09diY48J+Gozadz7d40xVfb1Tco1lp909ROTcB9FctvlT8Hc9NrqGjT4k
	MyuMzP1rkPw5fWwvJdwwyHQaas9PbXQx5U8dCH68nsgSRm8PZflrUNLw4kCBTt75N1xik8EbnvS
	e5Xuom0+FYrMm+eNNcgqQMAoVhyIu5WLh2ltYOZFVHOj/pExvMAsffGt381bXadIyUSAh1Dvc5w
	9IMKO+XPYfmGr3IxetCJsx6ljcPWK16QyDC44/swFY9+2eYRZA9Do4jkVvTwL6IMO2ad7P9Grg1
	IUSY/ZwKB5o5x8gDyxnDCjsFtzOg7p/e+Yk8LS39GvCo+3x0tQhW3NcaN5h0z0Bbj+u2bNA0RJn
	ChwdcMsW+ANkEdz/wcBNOcwm4FL8NDs4B+6EGdepXELPqUKvk=
X-Received: by 2002:a17:903:19ee:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b0cdc2badbmr50907315ad.17.1774666640587;
        Fri, 27 Mar 2026 19:57:20 -0700 (PDT)
Received: from localhost.localdomain ([60.49.20.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb50sm7194835ad.56.2026.03.27.19.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 19:57:20 -0700 (PDT)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH 3/3] dmaengine: dw-axi-dmac: use logical NOT for NULL check on of_channels
Date: Sat, 28 Mar 2026 10:56:57 +0800
Message-ID: <20260328025706.52722-4-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328025706.52722-1-karom.9560@gmail.com>
References: <20260328025706.52722-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9701-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[metafoo.de,kernel.org,vger.kernel.org,web.de,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48D6334D1DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

    checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac.c:

      CHECK: Comparison to NULL could be written "!of_channels"

    Refactor the check for 'of_channels' to use the more idiomatic
    '!of_channels' instead of an explicit comparison to NULL.

Fixes: 06b6e88c7ecf ("dmaengine: axi-dmac: wrap entire dt parse in a function")
Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dma-axi-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 49e59a534e22..1fb387e9338c 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1056,7 +1056,7 @@ static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
 
 	struct device_node *of_channels __free(device_node) = of_get_child_by_name(dev->of_node,
 										   "adi,channels");
-	if (of_channels == NULL)
+	if (!of_channels)
 		return -ENODEV;
 
 	for_each_child_of_node_scoped(of_channels, of_chan) {
-- 
2.43.0


