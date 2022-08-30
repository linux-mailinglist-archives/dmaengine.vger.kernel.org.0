Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8395A5F7B
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiH3Jcx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiH3Jc2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 05:32:28 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE00DF4E6
        for <dmaengine@vger.kernel.org>; Tue, 30 Aug 2022 02:32:16 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A0BD63F12C
        for <dmaengine@vger.kernel.org>; Tue, 30 Aug 2022 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661851933;
        bh=Fq9Qj2I6Q4wEeIF7BMuG23ODRUy0T0fqLeGWPb/D12A=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=b+HrUebVWQ80JJDWlio5pT1y9Ff9C8sD87PKGNEEIWQ7PBi85yJNzFS1TGV6OzwU8
         n3hByzAE7lhg93gP3Ul6xbURe1WdHDvccRVfkPYdyeaprMuWcv+io9jAhcE0DWQqBF
         oFkoTBGi0ZVwGcGU6iHbjDTXppVNm/Ydb+8L0cyiqgSlAsjvNPNJj/ncIAFyVuLi3r
         GqV/E4ECnPFb+Kc2g920+t71aUzfZh+ATV4l8p7ZplUuhVeH/HZNvkER+rmWCJwjOa
         kvW02a9KJoihepAsGo1G8iW2dBACeRVEeIYUd3KudT1wc3gAdwAYiUowEOusVxgtmT
         oNyG2Qg3xX2kQ==
Received: by mail-pg1-f197.google.com with SMTP id r74-20020a632b4d000000b0041bc393913eso5342090pgr.10
        for <dmaengine@vger.kernel.org>; Tue, 30 Aug 2022 02:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=Fq9Qj2I6Q4wEeIF7BMuG23ODRUy0T0fqLeGWPb/D12A=;
        b=hhigFMr4PlzWOpVSueKkjdHmdoEAYxBxi8S7KnHZzxFFUyx0uPiNz4bRVX8J+DxYAE
         mtl4I5JxzCe4YdC4++Hnoi5XMryjXKf0g91hmXCEWbaVkwe62p7PKrD7xW6cUAEBisYK
         L0tPyP8t225kVUefTq3GIeMaQrOR+i1GGaAJVKrz7VR9nCg0TD3jYdtgHP3nwezgCR5l
         UnkIdErJ+HlZAbKOGJdTva/oAeGem6MzxEJ9NGspGk/lAg2nHQIVH9zV48lcFiAAbp3w
         I4qFG8vpGpap/CQoQx6Vqg7LRa4t/UM5KYzYnoUFiKfh0lqppRWwFNf4/XvWiyaTzliU
         DN+Q==
X-Gm-Message-State: ACgBeo2d2gFrFbNIwGg3Q0ASIEqX8TIXGOcE2Er+zQYD7DrRKZPkNH/L
        Q8b5dFO3YQU9Eaxz+4NYm1Q1gBTjKcJwYQZnzGZvb2XB7q7UdxEI28OtcVBVd1wF4cRclQ92bgL
        Lbg8bS3mzAag9QiGmsSPI+Sgr47tB20mcTAamGA==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:56c3:54ac with SMTP id pc10-20020a17090b3b8a00b001f556c354acmr23274729pjb.2.1661851932316;
        Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5hx669oD60wW9i25ZVdcENxqvxMPQWvOLTezF0zSAk3cXNR5nnSCtfnCL97BDlQQBTqsU2PQ==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:56c3:54ac with SMTP id pc10-20020a17090b3b8a00b001f556c354acmr23274705pjb.2.1661851931978;
        Tue, 30 Aug 2022 02:32:11 -0700 (PDT)
Received: from canonical.com (2001-b011-3815-3671-090c-7c62-b076-d6cb.dynamic-ip6.hinet.net. [2001:b011:3815:3671:90c:7c62:b076:d6cb])
        by smtp.gmail.com with ESMTPSA id w3-20020a63d743000000b00422c003cf78sm1170293pgi.82.2022.08.30.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:10 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: Fix client_count is countered one more incorrectly.
Date:   Tue, 30 Aug 2022 17:32:07 +0800
Message-Id: <20220830093207.951704-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the passed client_count is 0,
it would be incremented by balance_ref_count first
then increment one more.
This would cause client_count to 2.

cat /sys/class/dma/dma0chan*/in_use
2
2
2

Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/dma/dmaengine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..78f8a9f3ad825 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
 	/* The channel is already in use, update client count */
 	if (chan->client_count) {
 		__module_get(owner);
-		goto out;
+		chan->client_count++;
+		return 0;
 	}
 
 	if (!try_module_get(owner))
@@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
 			goto err_out;
 	}
 
+	chan->client_count++;
+
 	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
 		balance_ref_count(chan);
 
-out:
-	chan->client_count++;
 	return 0;
 
 err_out:
-- 
2.25.1

