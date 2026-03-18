Return-Path: <dmaengine+bounces-9514-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pOW+Ivcvu2m0gQIAu9opvQ
	(envelope-from <dmaengine+bounces-9514-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 00:06:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D759F2C3B8A
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 00:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65BB6303660D
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D92F60A7;
	Wed, 18 Mar 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0gYWQl6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0321FF4D
	for <dmaengine@vger.kernel.org>; Wed, 18 Mar 2026 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875188; cv=none; b=gUJmPnuMUylpBI/fFwpNG+0lJ6ROLLOIOjdU8wape5SlOqWlJhFl+t8/+aDQ7VuMT5xXHEx9z2/ODDHmrpx4Z8MblyXiNrLSdMEBIkT8iiGWULUjvdWbEFB0/QmThxfaRIDrQftAicocVJDdAe2ffpK3QTmkc9gpih8FWXTXPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875188; c=relaxed/simple;
	bh=WkDwWR97uPMYr198IbrL+66YAHoGZpqK3oLNIHB2518=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLJ6QzpHBdwB0hjC7BCMFwzVvdMwmwC5vB3T9JyUXmbNACYNFwJ/Ee2uiyST0C5mtmuCVUAc3Q9H8sXMtV5vay0CgO/twX5ZmTUZv5vfRP8CWTFQTI5trmIKCleSSIrpqF9k9mvqQRSA9eJKiOsoA7aodXY/F4ElKWxso7rkCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0gYWQl6; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e8c7f5082so41811d50.0
        for <dmaengine@vger.kernel.org>; Wed, 18 Mar 2026 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773875186; x=1774479986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pka3MFbB++QP8Jn1PcZH7W5IZI1eMirz9wRTwsjleEg=;
        b=Q0gYWQl60KkVSDw4+euR7P5czFfdjUXUFOuouGZJbarO9HKIcKDT/eDzqd5p53nbBS
         vFxrpgmKmzAgdZuKcLZHE2mbI06bDj2OeTaSLM+ztucODzO0x3h5G21PRVth6kiOUoqf
         4trB0vcZ0VkNKEYTKNaLyTUjHsRHna4QiWolB69agYdNexcmY6JEJyg0vmBCDZ9TxX5F
         l5uAW1P2wrcoPE2tWv2iEQbOcMcQDvtH9yu22u+oD2ZJ8SoQ2kJ3PZuHVD8SG0GAYBKu
         1ij3LuZ9wC3C2C39am0Ri9OJuwKS3JzMsvaRamin/9A62Oat3B0gHH22udCvx7aV5zOk
         DvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875186; x=1774479986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pka3MFbB++QP8Jn1PcZH7W5IZI1eMirz9wRTwsjleEg=;
        b=gx9gvOpa/EPH1CCORn2KPrUVc7/ROnadOwBXO68p14Y5tuyLraZzSSOTh4jO4AM6wA
         djU9PcSq64yj7qqBan4CphaJLJqpjbt2njVpJy8vvjJJrNmm720PuXFRElQn8mwlNhO6
         Ukq0YkMs1Tf1CEYZKqIjFyJz2cH2bJ0gP/vL9UMIUbKXreHfVouP4KYsv/l5mjV6kQq1
         90NmRRUwY/0FPMofzwx1eW6bu96xPOOOIucnC2dIcLjDGGMooCnP3U4bqRD2Gb13HLEy
         sEQolMlVjXgQkvuKsOCGixADs47w87BR1BdThH5rFCmahYabe7Ok22KV1qm2Hs6zzNGO
         qYMg==
X-Forwarded-Encrypted: i=1; AJvYcCXKthPhHtncrgiBlTar+mxDZPxfH6rmlNe3f0bmOo/Ew6OcvJMSOrGUYf4eRZkAihedry3HIdweUUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSphm4PQvz70pnUydsjxIY74gLP7Kpwc1FAhzIAgMIBhhv6jLx
	Jb2S1kwVZps7eJWsK9ye0erR7QvXUWZmN5SWq1rIOXkJDXvITTBhg9+1
X-Gm-Gg: ATEYQzwiXBCWH7EbiFoJuvYMzKV62VBf1yfsU9IWyCrz1mxIZ8PDTzR4u8I7aE/QwSE
	fKX5ZKO1WHaDvB2Ix7BYeXiMCE324SBGDws1scD3acQfUo6svuLNemK+Bj4ZU7/tEXu8fesRN+f
	dE/G6xdqDvDTUMSlH5y6nmH8Z0CK9q/+BHGA2S88zw0k4pbhNcUw6JK4UdmColMH8rhyiq0KYSY
	3m91hhlnXlVBBe/ZapA5a4i7wLem9Db9L/+Daya3w8WwsoMzBMTDmMaNTlt9FXvngCvLR85DTTx
	clnGnaeCs7eFNICMjygcJSIDrm95k07kBZpFRl98M5t4V0uA0qsUqzzKbCFYbLGNwHDgCwMDTpH
	05az38qnzVhT3jT3uMGgT76cMaeJHyXQ4p3NiZBTm+XOGv6+Ag7jofskJYCgtzrNxggFLshbYWW
	PxCAgYbxZGnzx3XUdMARx9/V1/gN9ckZwImtanoWCm/LwyMr8m9a0kvkvD680IPAD2QsHowCEWR
	TYFE9TewxAsVVrkwvrFtKpm
X-Received: by 2002:a53:b74f:0:b0:64c:a0eb:c4b5 with SMTP id 956f58d0204a3-64e9157c04dmr4140506d50.52.1773875185723;
        Wed, 18 Mar 2026 16:06:25 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91bba0c9sm2481644d50.13.2026.03.18.16.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 16:06:25 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] dmaengine: loongson: Fix signedness bug
Date: Wed, 18 Mar 2026 18:06:23 -0500
Message-ID: <20260318230623.1084926-1-ethantidmore06@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9514-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.924];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D759F2C3B8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function platform_get_irq() returns negative error codes and
lchan->irq is an unsigned integer, so the check (lchan->irq < 0) is
always impossible.

Make the return value of platform_get_irq() be assigned to ret, check
for error, and then assign lchan->irq to ret.

Detected by Smatch:
drivers/dma/loongson/loongson2-apb-cmc-dma.c:677 loongson2_cmc_dma_probe() warn:
unsigned 'lchan->irq' is never less than zero.

Fixes: 1c0028e725f15 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/dma/loongson/loongson2-apb-cmc-dma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 1c9a542edc85..2a702de8063c 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -673,9 +673,11 @@ static int loongson2_cmc_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < nr_chans; i++) {
 		lchan = &lddev->chan[i];
 
-		lchan->irq = platform_get_irq(pdev, i);
-		if (lchan->irq < 0)
-			return lchan->irq;
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return ret;
+
+		lchan->irq = ret;
 
 		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
 				       dev_name(chan2dev(lchan)), lchan);
-- 
2.53.0


