Return-Path: <dmaengine+bounces-5317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A2ACFEA5
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40133B10CA
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73E28640F;
	Fri,  6 Jun 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIdt0Sqq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42FB283FFB;
	Fri,  6 Jun 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200442; cv=none; b=U8JKcdIJ2E6Mxni2rzlicMwzwt0Ug6luqp4sVsD0ybhVSfulf7VICZMFQFRfbLWIY46XtACZY2XkAvKjshdvmHedxP+VgtyWd44LkITMBGGB+ii4ylq3PIinu9SFF2+bRS92+IbQOlK/iLZo3CMm8DvLbRgXpmn5KrncqJeajls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200442; c=relaxed/simple;
	bh=hua8O9rgb0Y0B53K2JGIm1JlLWfji5bzqwET3Z3XDks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SU03LJGaxtdtsJGOR4JKERRxCDrbV+b9sqbDatYK3OfkXGfmxTqe9+WR8Q1cD840wHV1sE2YLdDnU1fPhrp7ibxep7f/VCSfN9yfkiV19qdfMQAMgOjtAMawG4dhZq8SrDK3Yp+XL7Sw84ZpLe07d+zcmDOAvx9M8P2gqQPyUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIdt0Sqq; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22d95f0dda4so24849815ad.2;
        Fri, 06 Jun 2025 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749200440; x=1749805240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Toi2tQAZrviqm160TJzNi/82azbGkUfQEBaQsphdcI=;
        b=IIdt0SqqIt/s7/umM9OCJ3+oB1/laLIvuCAovgnPt0+pE4SubFDuGYqP31Gxf6wSCN
         /Wgky6FPtIdpae8TmbLILtZRF1SZvprpYB/xSg8hvyEEuCX/g2YDwSbqRju5GaZowR/w
         gkymVG1YhFIy+Nw3XqoHSvqyHa4pGLL5JKz9FmpbOas12zCcOzmUZbFf/KmzkOgSDREo
         EzmYek2cJk5jhJjMIKROeTECzDxIUVKeFr/1q8rfZm9OXdnS4LAk8GHAo9UAEz4IX9/T
         ePJ2cliWe+0ON+lQWCWSpp1iw5Aq4TYYpyyxoerWkCuYY+1HZ0i+MtmKHunuHn4GHd/y
         75aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749200440; x=1749805240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Toi2tQAZrviqm160TJzNi/82azbGkUfQEBaQsphdcI=;
        b=ELuBqS3AC8BudUkJ1iYONs1v63lDEnz1JZDKHJskPuSVWgr4BTBBqyBSTn6R9eOCyc
         5XvEA+zcwk8vdRGtk5reRyIbGYFw7iVKRqdgjmCkp5z2T+vjK6iU2hRnkBNAgL79iYSZ
         8vE8Gao6iBZH+mO4B5X0AN3sai7Z6ruZQYgDciDPgbZIthpYMXKfx79EbzY7lQsUB7e/
         RszlBmbW05qdVaWkA6/hcuXbiQx0nbnghRjmldMDgbtldRUioNve7yf69kDanlBNOZAE
         bzKZ31G/7lBCE6l764eXP0mrIZYaK2gk9oJRC5p2GJytnqQ3R8mbbU50EDKFEE7RRacy
         nYNA==
X-Forwarded-Encrypted: i=1; AJvYcCVUzggR0OY36+8VuwAkmrUziiP7wKG/muDVChA+bsWmZkxbNhoFtn1CHC4ieZhiqmlSRCCcPAwqStqxwTU=@vger.kernel.org, AJvYcCWoWfhjVcCl64qdchnHq1Dm/vZAnSEmzGQbZV3xRWasOPdmBIC/r/XqaQR/tyzNIfdFjiEoM27G@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfaFZAVld8wc4AFO/NJl60p69NE+rv+LxKEz11Tv3pyd8ttpH
	EAHJK0+hkdNxFMsv1CSzEA56hGQ+bD2ng386t0hZzdXc0C3ihNHRgTs/
X-Gm-Gg: ASbGnctUSF5SJd36QIKWpfXpgI9SmCDyeHu0lFSwWWkz4KvejO/XGwWOX0iOP4ctrFW
	0aoZjIJIg3Qwkox3TzfBeOPzaKdareltbR+blPcgDsHcJt0Z7ytnG8k/7DJBQk3ihtIYp8lXs9S
	NTOtGlvBJImyVlm92oGUB/hBEc5lVkBTgRa182mdjT/5jluBz9D5cQtausFRZpktqs6cMVyiJq+
	MVA4JM6BQVU8oxFjxINGsEOKxWbuTU5kRlMD9fZbgadoNKnnVDsRF0CIr6FgEiQEATp7tHJ74Qq
	NFJF3O44SGQ2KHvADWV5pGNSm3KAtZMWfKnr3/PVExceSVu27F2V4sgJR5nU8XmqybIyTg==
X-Google-Smtp-Source: AGHT+IH15PyfKv8D2hZo4jz4TX/8Ll4a83KhJNiOMLH4+nrqpTtsFeVLOHL/LLeT5zU+0mYoyt7KqQ==
X-Received: by 2002:a17:902:b18a:b0:234:f1ac:c036 with SMTP id d9443c01a7336-23601dab2ebmr23801085ad.50.1749200439705;
        Fri, 06 Jun 2025 02:00:39 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360340d87csm8140735ad.189.2025.06.06.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:00:39 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: sean.wang@mediatek.com,
	vkoul@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	eugen.hristev@linaro.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()
Date: Fri,  6 Jun 2025 17:00:17 +0800
Message-Id: <20250606090017.5436-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.

Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505270641.MStzJUfU-lkp@intel.com/
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2:
Change the inner vc lock from spin_lock_irqsave() to spin_lock()
Thanks Eugen Hristev for helpful suggestion.
---
 drivers/dma/mediatek/mtk-cqdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 47c8adfdc155..9f0c41ca7770 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -449,9 +449,9 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 		return ret;
 
 	spin_lock_irqsave(&cvc->pc->lock, flags);
-	spin_lock_irqsave(&cvc->vc.lock, flags);
+	spin_lock(&cvc->vc.lock);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock(&cvc->vc.lock);
 	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
-- 
2.34.1


