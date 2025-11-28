Return-Path: <dmaengine+bounces-7384-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FBC9274C
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E563AD3E8
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F13284889;
	Fri, 28 Nov 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENccGllH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FE21A447
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343802; cv=none; b=lXBpx8UB/XtLS32NmJOZN0XTkT9OHPW/w82FWJppy3iFQJ/9ZSKvEP909k7wMtSxY3KjCwoZGzw7AhBYJ+Ohy9WawDJIBwiKjaahZoLkKPC72eKSPTgy0w92y4GDAREJ6fgyiTZIOCa2C1nHlDmwtfsjiexxJiSJ2l42JW6B5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343802; c=relaxed/simple;
	bh=254QBeoL5Fe95P2NE9XyCG6i4ZeY8SK+NxCuQM/ifHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEPtryT2A6nWRTfzcEcakKCelWNqbrs40wMCWBxlqSia6sfMOCAHB8jQYQ3S6ZXw+p3rHaHALOtIlVxwxuIvDC5TmABEPqcaWi7rBUa4Tk1OjpC0V+AhZz2y4vYf5fT/hOxDgj4c1uZwc6712JD2cRdujSBcInzo7FrPceV2ldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENccGllH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1318882f8f.0
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764343799; x=1764948599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLw1fb3J6TOMXR+L319Gr71N9pY3Ku2H8OfmHiEFvJ0=;
        b=ENccGllHX3i/BiH+ra5eQUemTf8SAU0V03OrUh3i2fetcBlkV+ffrYLBUx7RaSZi/Z
         dA22J/vs+neYR0JjYaBCw85gPLB/RAmNPV5G/732WEIMtvO7Iq0jC6RfBWk/NHyIsozu
         7m5/WkdstlTTIdGxfa2MgQ30YA8vArXSd8J4nJWp7xdM/rPHBZ1OwYpdtKtXsTucgabx
         duXYXK1ENFlYemns9zkBqe+8Jg347+v1msF1sbK+mSVIL16XaHvxJN16soe9uaHqUAF6
         P3KyLVsdt/uPSrLeALzeYqwfpDjeaC2NTGiN/co3DQL5LCy/5u+lOfQVAvl4mjHHA6tx
         ZgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343799; x=1764948599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLw1fb3J6TOMXR+L319Gr71N9pY3Ku2H8OfmHiEFvJ0=;
        b=hQJePDRXL5rbBPxEO4YZg/ugoYhDlainMw+rmIK6LKmMVLNf0Bk+2G8yNrE9d8ENTP
         /c4LH7NqZhhtfEPb8PKPR+ubvvJkuFcWgrGkajg2EsL5aB2yy8dqqPW3aLNjZZvdxLyS
         M01jgNG5aP5/5n8LJb4xX1WpQWrCboPAK51kwpQJkSD+RiVao/VDT7KCY7Of5nJNVn9w
         j7WgVrt4Uzy0ZoSX2Sy9ikiNodLv6oZrZGEUSsGdjzi9bf4l/4ndoEfrmYcOJZiwQZZz
         Vi3zypGaQP23h4sKH7SemmczwHYI35EZBORqcgnlk/STNB1NXMjDWjjNJA2Z1n8tvbzI
         vnVA==
X-Gm-Message-State: AOJu0Yx+wU1Yn9HRWlBhHMJY3XrTwf7gYQBxUZ3YLU3gjHbD6Rzrgyyw
	WxpKDWuGSEZA7cGxNatfR+CwzWepdW1VSn4cAiX8hq/iQuo9dKRRLl3Up98dWADWYc4=
X-Gm-Gg: ASbGncs6xwb/o5YQjClQdIHtb4yPI1mgZMRrGjjlnjxL1d8j5jM0grtSihYmVW3c+iJ
	7KzIa+SsDJGNDMrBUT4Weu2dcAlLq1aHsr9N2pDqmMhEzGRDzxfXoWswNpPeT+X6dZ+kiMJy9Cp
	RgI4aBBmeotbb22HjsYRxc5kYO6La+3I+03zhfq3Rcdkplb7mW4gnWyaMs4LJsA9tUM1XMDXbf7
	cgYAbBWh/JEECicbK6gVSeLSuM646R/9MyHz/QtQedOTsFjDRq7KOqvGgO6rwZGqPUmili3rYeU
	DuXgdn6LGnGHthwInJ3g0B3KjOuMXU3Mgw9Jwgcdb1pOcQcLFSRDGDi2tQthAgkiHRob7A6zqzx
	++TslFY6ljO99w265UCbVHYuA9PWn24VaQHOA9aBVx6oLX7shqnLYX6WnUKgGqu+SPT0kEP3KhU
	Jc0GietLiEj5im0kcP
X-Google-Smtp-Source: AGHT+IHe2ydxf6lPwxV90Ak4namhsLUQl+tCtqrEoRjIaTMZaOICDb5ou+adCoW/FagZ4VbtLlpaBg==
X-Received: by 2002:a05:6000:2007:b0:42b:39ae:d096 with SMTP id ffacd0b85a97d-42e0f1d6672mr15202949f8f.10.1764343798869;
        Fri, 28 Nov 2025 07:29:58 -0800 (PST)
Received: from gattout.local ([82.150.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30b8sm10296213f8f.7.2025.11.28.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:29:58 -0800 (PST)
From: Amin GATTOUT <amin.gattout@gmail.com>
To: vkoul@kernel.org,
	thomasandreatta2000@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amin GATTOUT <amin.gattout@gmail.com>
Subject: [PATCH] shdmac: Remove misleading TODO comment in dmae_set_chcr
Date: Fri, 28 Nov 2025 16:29:48 +0100
Message-ID: <20251128152947.304976-2-amin.gattout@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment suggested that the dmae_is_busy() check in dmae_set_chcr()
is superfluous and could be removed. However, this check serves as an
important safety net to prevent configuration of a DMA channel while
it is active. Keeping it helps ensure transfer integrity and avoids
unexpected hardware behavior in edge cases.

Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
---
 drivers/dma/sh/shdmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 603e15102e45..d0e0437ad916 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -243,7 +243,6 @@ static void dmae_init(struct sh_dmae_chan *sh_chan)
 
 static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 {
-	/* If DMA is active, cannot set CHCR. TODO: remove this superfluous check */
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
 
-- 
2.43.0


