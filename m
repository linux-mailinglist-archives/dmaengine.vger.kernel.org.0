Return-Path: <dmaengine+bounces-1042-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4B85ACCC
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280531C21600
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE846B9F;
	Mon, 19 Feb 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMGug0Hz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676D2C18E;
	Mon, 19 Feb 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373489; cv=none; b=VgbNDgzgSvRgUPyVc+6GRjeToBGdx+OHEYMKad5Lw9Nwqsb/zsewmFbeGEpjvcvX9fzbl5bfgM8ugjDQbpMy94yYic7CN325gYk82ty2IMNKKgiF97OLlv0Ybod4SnzFBcu05cDNRQ8CWTwhP3gJatJVyO9Zo1sMH4tQYBsxrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373489; c=relaxed/simple;
	bh=UPuL2QESr83aEWzdYjyYKl86iEbA72Vji5sZ/hiS5qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7LLUZC54kkyr1sov11TitJTEAOFibnSgiLqA00/LWGaYqq82T9cVJlMTBoxaGHwaZDp/MYR9tVv62wUS5ZICf6VqX+j2jTgoSo1TssX/X0nYKYxaDqqjwzvKdt3lhuPt6qbo5Oa+JAT+EuIiFG2Ssiwoc8RtQbPXvWbmmerLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMGug0Hz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso4294242a12.2;
        Mon, 19 Feb 2024 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708373486; x=1708978286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7gdCVLWEkFBnciuG4iD/OFCGUG6GObGE+T3szY+0f0=;
        b=lMGug0HzhLPLm0sm8/v566CWc/7ZG00sbgeYtYBAKsl2zYWgE6cS0ZpTDnyQux5IeW
         j9/cWIEYFG/u+XMJ++EZHRUBEiz2pjmgMAmJEJR3CJOxANrm1Dwa5iAnLICOKBtZfFLX
         7/rGz2Bqg1UNq57FJxtnU8l9dILSBuD68E0fYbMOkzpuyw3RPQuKk03JTJ9CHmmTtlWa
         tDjDmOEzyiquY5aljJIlsWXv13sxDWyrocrdq+Hk1wzHqTM48veO/4+K8UH3HYE96sTf
         pjKze5ngH6/ajHLRpvmPkmYiBmHVXNh9DGvL4k+7Ub7imOkEdacrb56kWP/R5fvPgMi0
         V4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708373486; x=1708978286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7gdCVLWEkFBnciuG4iD/OFCGUG6GObGE+T3szY+0f0=;
        b=CRsH0wrmIbAT5etyEcMH1c2Zf9SxF9ouyuVoH5T6LKOfaOWLWlYdPpMS4ngtCTKNmt
         Y1MoUp6kKknXcMsn76Iv4tqjFmW7tICtl4HE205Let+vHc8m68QPzX1qSYXtjOPvTFl+
         sYGRDhOo3uS1a2BcnMvncVxyJXO+SDKvl6QDVNUyzvcLVzdziqmsRwIPjVykEKOvSh65
         TkqPrCM3eXOeTA3CtrB18rYj2XLcCBRJSOssLwdU/sMxSOlDdKATp6mC5e6HlKdGi2dN
         EA28+SbCCyr9xYs8MXS0wv9oCOMz9lJbxAZ/DEi8ETwvWAEB60eZnSs5eoe7TxmkUtZL
         H/5A==
X-Forwarded-Encrypted: i=1; AJvYcCUcwoECHASUsP8WKCyx1fXbr/ofPIokN1gqgLS73V/QOCLHqTNiHJC+jicLJzsmCeAy/WqBsnBqwJ/BB5BNwjXS5HnV7cqzgG9w3uwkBv5h4+R66Gq36A1OgI2dp/YH4mFk
X-Gm-Message-State: AOJu0Yw9LysXPaclCsjcQpuNgqGmjHFMXlvB8B13bMRG2Y6NHVvAKhkq
	MS68YjPmGPHoHqeqAtGboTH/68DqvSD11sgOkdReE5E5t/Z67+jZ8O8moESei9o=
X-Google-Smtp-Source: AGHT+IE1VqWTIcjJn85XPVwAx+DtYi+mXKUMWde2gnI/dsi4C9XaRw9Y8U56hj3sGFM3CqEIYpI+9w==
X-Received: by 2002:a17:906:d0c5:b0:a3e:b952:3571 with SMTP id bq5-20020a170906d0c500b00a3eb9523571mr1918085ejb.68.1708373485911;
        Mon, 19 Feb 2024 12:11:25 -0800 (PST)
Received: from desktop.gigaio.com ([46.151.20.23])
        by smtp.gmail.com with ESMTPSA id q19-20020a170906a09300b00a3daa068f76sm3266001ejy.65.2024.02.19.12.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 12:11:25 -0800 (PST)
From: Tadeusz Struk <tstruk@gmail.com>
X-Google-Original-From: Tadeusz Struk <tstruk@gigaio.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Eric Pilmore <epilmore@gigaio.com>,
	dmaengine@vger.kernel.org,
	Tadeusz Struk <tstruk@gigaio.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: ptdma: use consistent DMA masks
Date: Mon, 19 Feb 2024 21:10:39 +0100
Message-ID: <20240219201039.40379-1-tstruk@gigaio.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
References: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PTDMA driver sets DMA masks in two different places for the same
device inconsistently. First call is in pt_pci_probe(), where it uses
48bit mask. The second call is in pt_dmaengine_register(), where it
uses a 64bit mask. Using 64bit dma mask causes IO_PAGE_FAULT errors
on DMA transfers between main memory and other devices.
Without the extra call it works fine. Additionally the second call
doesn't check the return value so it can silently fail.
Remove the superfluous dma_set_mask() call and only use 48bit mask.

Cc: stable@vger.kernel.org
Fixes: b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA resource")

Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index 1aa65e5de0f3..f79240734807 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -385,8 +385,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 	chan->vc.desc_free = pt_do_cleanup;
 	vchan_init(&chan->vc, dma_dev);
 
-	dma_set_mask_and_coherent(pt->dev, DMA_BIT_MASK(64));
-
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
 		goto err_reg;
-- 
2.43.2


