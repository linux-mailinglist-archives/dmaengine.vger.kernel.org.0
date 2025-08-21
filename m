Return-Path: <dmaengine+bounces-6104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF1BB308EF
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 00:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7F47A401C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB22EA72B;
	Thu, 21 Aug 2025 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX3T/mcE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548C28466C;
	Thu, 21 Aug 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814186; cv=none; b=ocEDgkys5HvDN/+wTYKfb+3j2TIAmFrHz5j/eZvYy5pB0H29A2st2wWV1XQafrWRj4oqF/SveJRhmKjDpbxKMLCQKqfhJ1P4ns5uIPk7ftB2a1m25JyucUGIPh83k2MfVicYIzENuIXdllhJeSsaRjOGQBIOXp9nEbMnhsPH6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814186; c=relaxed/simple;
	bh=HbrzIow6ro5F8biuzHHI59aFAdttm39yiOQJ9djR9aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIjHIVzN6475XYk/IRxRumj5Ovhv2a15LCHWWevprzfeeS0oel5x4fpyjSkNaUxyQ25Ncdb6alvFqeZ/yQUTtY0aWBTjTyjWTp6QpbgvClfczoup42f5kkJNG0o6hhpgCUvgP0WR+QwNrMI8+vW/VXNVR7Z8hG9CROZSV6D26tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX3T/mcE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b476c67c5easo1042648a12.0;
        Thu, 21 Aug 2025 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755814185; x=1756418985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++SJ5jRH+WreHKVhkZdUv3bQcfYuCui1mzziW/uI5PI=;
        b=kX3T/mcEGAtVrxGHPHnE78N5qdG9GWPF3Eh4ueDjGergcBiQRg781u4Ixs7kSwHgOc
         NkCmeKgZPms9+vCdbeQKh4MlUjLeb5BewFwMGw3l8pnzEF5JPlqmss3Kn4OutBEiA5q6
         RLnmbukpIMeGjJkdMDesbyk+hh+G5lZraYc3NTO4aWeSyj7wPYZHURy9sMw6T96UZNKN
         ui+hW4NW54hS1q9NKWEWtT552gckuqrO/CR+kewyLKU5aIJdngv6pp6pTqRr5jRUOJZe
         Wxm+FxmBk2LSzmP6NDR0S69993LgZIBLjH7okNKdR9p8XaOiWCg2g26UM35TXdH2Ehgf
         A4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814185; x=1756418985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++SJ5jRH+WreHKVhkZdUv3bQcfYuCui1mzziW/uI5PI=;
        b=srndMQjUfU3zJUSff3VdHI3Paa/HTVKAehoYzFg16E7vhoJhI/niewkL5ZFT1qq8k1
         85VAotnDZZXoxHQ4KE/bfjJsQu3MhByMQ8dMm0ydS+1w/Hzk7gpJRXoznOQ2TbORpTzI
         5VC4POwoATL+EZdZUSV3lDC7HBJQeAaV55RphD+mcKDL6+x/iAAnVDadg+jIAsSPwOwD
         b75HgX49c/Oj8YCpYMUhXylNpMFvCr89rMAV4EwhtuXxLL9vERxMTgCpmMDOLZ669SEs
         hux2vZ2c1aQe1FSl87yVnDSzPuuj9GoTePQ7oF/a8WRfwoAroIUyPw5DWFNczurOm2mA
         LQgw==
X-Forwarded-Encrypted: i=1; AJvYcCW9JkkaBqRQYmM99RitRTy7DH2IF+hSgFSO1JPOF6l30RDmSskKD7eFMz0YYCsvPr6VPW0WBI3MffNKNJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9kyWGxZxTOAfg1x7lGXgxwoMeqi+9E0VjznHn3q3Ef8aihshK
	otBqSGlJWrYz5ekO3rceScOQpbjqOwNxZpkHGOataT2qNmfMKE1/C6Pn2JCTlQ==
X-Gm-Gg: ASbGncv2Ppl5MxLPNeP9MWOZ1tYtsrafOnGAOhFDjkJKLMyz30J5R9hKBOm1yK2k4o0
	pWP0sy8KCJZIDZax0Sx977kIGPQnuGLImEsZliqCw2773Tdf1GUxzV71u9MmKYuVih4VPZmwcmu
	cK0Rj1aZo24ik2X6tVYJpkd0jil0QN645o/JziRTiOyUXC4bYGujEg2WTwTSjoTvJWfHJWR3kth
	FbnVjJOvE+GQn9Dd0KfHEJ5f6kpy0Ff4UMmqiGWaP4gnu9LeLke1PXeVl1TCQaJ2ZBSNVHQhCTe
	MjJ91O926/ZlpW0aisy3ux8y2PHfgOyB5eXuEp6xadiPkhqV4M2uUhw13UvChO+QzauuLsGFAMP
	JQDMuOCwPbRBU+rq4p6heUTTj3F3w3YMwe5SHI7kYPPBtwQionXK5wFQYW8TqFkIeVQ==
X-Google-Smtp-Source: AGHT+IFR3qzaOnGO7yrX3uuFPVS/s11ir63odsICB5K60MZo855LaBFjjGXcwnxMQGBeb+hKpixCfQ==
X-Received: by 2002:a17:903:32c8:b0:240:72d8:96fa with SMTP id d9443c01a7336-24602484973mr47892845ad.20.1755814184474;
        Thu, 21 Aug 2025 15:09:44 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2462e6ba0d8sm5939655ad.125.2025.08.21.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:09:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: mv_xor: match alloc_wc and free_wc
Date: Thu, 21 Aug 2025 15:09:42 -0700
Message-ID: <20250821220942.10578-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_wc is used but not dma_free_wc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 18ddbff38abc..7ef1d2b20609 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1013,7 +1013,7 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 
 	dma_async_device_unregister(&mv_chan->dmadev);
 
-	dma_free_coherent(dev, MV_XOR_POOL_SIZE,
+	dma_free_wc(dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 	dma_unmap_single(dev, mv_chan->dummy_src_addr,
 			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
@@ -1160,7 +1160,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	return mv_chan;
 
 err_free_dma:
-	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
+	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 err_unmap_dst:
 	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
-- 
2.50.1


