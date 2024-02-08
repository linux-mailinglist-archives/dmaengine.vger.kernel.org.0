Return-Path: <dmaengine+bounces-984-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13784E9AD
	for <lists+dmaengine@lfdr.de>; Thu,  8 Feb 2024 21:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0011F2EB58
	for <lists+dmaengine@lfdr.de>; Thu,  8 Feb 2024 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B4138FAF;
	Thu,  8 Feb 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moaMQX58"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66E38DE7
	for <dmaengine@vger.kernel.org>; Thu,  8 Feb 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424072; cv=none; b=iF0y4vGl1DGB5oX1I7xl8p41Gk/R3inT6BkEZXYGS4OK5s5gYOlPEXvctSHMfh/JmWdv+8DldhM7a0JVJfMJLgeeoCauGy2nO3/TOy2iMwc++zFK9w06uYTDJD0NYTsjwZpASHF2jdsgMw5n5j9dVDM2L8FENpkN7GrzYSFh9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424072; c=relaxed/simple;
	bh=vFxXV0CMitFA5HtWV0cE6DuKRu++Rris7YbjEufvo3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVtgB9MfC5WFb0NfQ9UVm6I25uU5jLKXTrWo94leNKti8XdwMb/S9qMLQfkqXX55UT3JpyZH93RzQCMSYlN27286AbKvEDuMcpC3DLX9j1110wR/gS8QhuXYrwwh2JZDhaP0LWfX0Ttct0tWuL3ln7dEOQg1sr77CTb5XTIf7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=moaMQX58; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-410489e1a63so2020265e9.3
        for <dmaengine@vger.kernel.org>; Thu, 08 Feb 2024 12:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707424068; x=1708028868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JuiKd4Pqu+cNXuLAtoDDjFiKegltder1S+vVqg9Rbg=;
        b=moaMQX58ofWGF0zC2+Kql5ILkzmCYwS1sUVwT3uG/MMtZPbmdt6kQg9IXFmpynFijZ
         CZ6Y8dik8WtylJ0T/qByUNT3zmE/5cnlrFoBoii6LoX3jQKurkw5x6g2/KUZ7QzhCzB0
         m4F7liWYu8ep5mwGN2XlPWemNuVKng99Nx4kzrU1cOn/CQK98EibSS+OqRidz3XbmyK5
         Kn0ECEej+qaec3vY/o5/NzsKnMRCHjfqf+9yLmRKTkuhUpbX8hSYRL3MLHVL2RthVSaQ
         GClFpkREHU7f2gjHjAf+JHjiZ9fPsxNiJQ5yUbO8HqiMOuxEcIfpOKQTM8AIDuSggJtF
         MXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424068; x=1708028868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JuiKd4Pqu+cNXuLAtoDDjFiKegltder1S+vVqg9Rbg=;
        b=fFCYeX51AFPpKsA+vl+H+urhHuvkUsDt5RieA9JiJo9s77K6hzOgEw764hHOv+YWwN
         FXn2oHJSAqqNyjMg1ZcEYpsV0U9+f0mC2/QWxllIyH4YGYPNyMTCQfLjiLREaQtz0DUx
         88xakRxduozrCrWdt+X7OlDbGnGCHzQ5PNs4ZbFQrFv179X8m2hJqM1IgROeGYIy091G
         df2XOJD/dm5MQ3pu2kDfTpZTOsjBuzyzNMNbIjCRCmdDr/Fz4R3yWcku8y4gpGzmP6sH
         do6bMv1/WPjwuuyPIIlvduYqSwRBeByUS5l58UazpMIxDRmYgLisfOg+DLJReRAvmNqn
         3VFg==
X-Forwarded-Encrypted: i=1; AJvYcCXjEVq3gLSVR75JXE3/1ciBUtC79j8HWZYlgo2D4s13w0Wrsffx5OyVIBMUWpSMmxpK5yZREv/M5e392bHWRxNnW6bSs5kuDQRg
X-Gm-Message-State: AOJu0YxnPkfxwPSJ+peXBVWBNqLxostpGOHLb0lkgneB/Z7VQ9+8XO2q
	II6SchOuDmhXnsQ3b3WmqxQtoUtvm2AC8LTc7/jZlF4frY3Jw6BfPMBVUuip6jc=
X-Google-Smtp-Source: AGHT+IHrg09/crGsPn7Yv0ifeRJcFeNOIWdggXx/AD6AvYfYliE0xR5RyJWvAN1mLuWDbNUmwria2Q==
X-Received: by 2002:a05:600c:4f8d:b0:40f:b166:7688 with SMTP id n13-20020a05600c4f8d00b0040fb1667688mr339622wmq.15.1707424068763;
        Thu, 08 Feb 2024 12:27:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhjwHl5cnxJuvqsCCefS/vwqiR7V/KJk9qJX1AzhVUqLI1edCldqbn/2tW2G4yxAwdmnkRVixnmeP9M2toQqqYF2wGMygKsdGyxfogumQ+mwUcpQqbeE4zGvhPGMpK16a/bu/ubuQo
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b0040fa661ee82sm368027wmq.44.2024.02.08.12.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:27:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dmaengine: of: constify of_phandle_args in of_dma_find_controller()
Date: Thu,  8 Feb 2024 21:27:42 +0100
Message-Id: <20240208202742.631307-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208202742.631307-1-krzysztof.kozlowski@linaro.org>
References: <20240208202742.631307-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_dma_find_controller() does not modify passed of_phandle_args so the
argument can be made pointer to const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/of-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 775a7f408b9a..e588fff9f21d 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -29,7 +29,7 @@ static DEFINE_MUTEX(of_dma_lock);
  * to the DMA data stored is retuned. A NULL pointer is returned if no match is
  * found.
  */
-static struct of_dma *of_dma_find_controller(struct of_phandle_args *dma_spec)
+static struct of_dma *of_dma_find_controller(const struct of_phandle_args *dma_spec)
 {
 	struct of_dma *ofdma;
 
-- 
2.34.1


