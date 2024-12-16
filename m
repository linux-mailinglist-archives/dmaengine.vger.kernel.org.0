Return-Path: <dmaengine+bounces-3994-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E19F3C1F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 22:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DA1168271
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E81D88DB;
	Mon, 16 Dec 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IIPdAtkO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC51D514B
	for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382277; cv=none; b=e/+sOYmpasWaJV4Lfj80b+tkKntT9yANIEvzACmuz7bduWYws8raVz8ceAp2bzZiABKQzWJDQhYlBFTSe3GFmUz/WoDknnZk29ETHXu4EuY/qM1ZBJ2Ry0lRSi2rOQhGIC3njp3Ab+KBHf92HuRai9CKa8zi56GbGeutiLPQ1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382277; c=relaxed/simple;
	bh=vNP9A4C18JfdqCO8C4qyuw1JeEu32Q85qs6oleMDKCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qVMtA4qWpHJGuPyYxXqY7gEm58jaW2oKs6evMRaORu+eRBQeWEIHbmCGNzdTeLSCqUyV7VZjl+BTOv9wyOyL7Brwob5eugBWGA0ss6mKAbpJd71VSfXeAFP3qSQwcNE71GpLgC5D4S+TlJu3HM2BGi4a5UNXL6cseKm2ll90/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IIPdAtkO; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e3eb8d224so684180a34.2
        for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734382274; x=1734987074; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URnb8c85jwthSeIOjmWdLO1dJRmKyq17s+Or2MsbRA4=;
        b=IIPdAtkO2B2LU+1Ckv2905zDjbiMTKqgWvgFpdSgnN+ebUeOcWydpiZIsll4vgfNqP
         uqt5GJSv14eeNjsdkdmExHW4q31aT5rqrwPCY2QcRRohDc95ksrvfCvEZ9AIOrLGIh+D
         TgjoI+7mPkjuR2dvXAZnr/YYi7Oe5hsOanmxGQrq5NWu44Fzw5HPg3MPziGPtKBiqAr8
         yBOHTOZ1krBq6sEzCVb+hmmH7sqLipkgP0L//THteI0SPMvXV/0H6pANq5mIoI9dShRG
         jMS//xvW/Dsqs7U/VQoUlCU1/P2VNrOa4W9HlEyG7FwzDs7fJNUsOfENUEm/3hNQXYYL
         +21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382274; x=1734987074;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URnb8c85jwthSeIOjmWdLO1dJRmKyq17s+Or2MsbRA4=;
        b=UWcBtcc10fFJrKN9g7yrCnEugLqTUKB2FkVKQ3P6UX7KtNiObezFQpyNAe2bs3gh0H
         jNLiP4lwgId3bVhSJsykdiueaRM6CTLEsIj6DE7bcPEJFVhUEfVQd9UqJztnYZshQkzg
         RIjQmdLS+tSNeTY85DiaudyezZWILxbW3DZjuNWWGczX7zwFnp1HOzSUIOuEJPWFJ7XA
         BJbuRqFzqSwwHgJ8wRoLJMTU8R8YhoO+TS6SkxJj1ZMQ5r+SLYJNHYCQ5ScV00oExIfg
         cETUaPCWKnTObl7H/iaJsoxqOEMBPVtZly4pGN/MZAgLSJFY0bjTAnI3k3qlAI+fWy0b
         aa1A==
X-Forwarded-Encrypted: i=1; AJvYcCV4YnLlzvouYlI/derQ13hBH584cfFgwX+RV2V99c4znKLAS7pphHAxy4a0CtkqwDo1NnOu88UmTy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFB3P7smHw8di2Z90s3ud5nUHTyN/E/W34A3j7TcOHrr+dUwuy
	XYf+YluGdh+AQBqBZYzNMFd3RHO//ztVXfYWXGBvNhUN8EquUfV4t/CgDINoXXr0aI0/J71UUdN
	U
X-Gm-Gg: ASbGncuGSP/Ufwb6E6q00w4s96XP4oN19eF6IgWW1QmnstHX/PdTiCdU/KzL1SP68Zm
	yDdUGWObCwc95YKaZuvWDxlAd7aRkI18XeSqsO6eaDu4j967TOJY2U1SPCa5bSUZCOgwLTv20lA
	cTiG6AQpQIWC7yiW36zSotlVR+Lv6lyB1Pa66gOvSZs7SoEOhqwEn0xvb6rBlORA6K4RbA+Hcfz
	jutCtAPCdFJbe/+NYiJffqyPSL6jTwb4lsH9s83aaixxscVYvbv5Dw1IHMebPexvnMImsE3Ky7f
	hBtnGczhTzLf
X-Google-Smtp-Source: AGHT+IH1J3XcLxwZtLTGQT1Z5igc3BumUE320qN/m0hlGwtTCk7lq302xmrBaQLKwY3jWYE1crR5hg==
X-Received: by 2002:a05:6830:440a:b0:71d:415a:5d30 with SMTP id 46e09a7af769-71e3b5bdb50mr8590525a34.0.1734382274271;
        Mon, 16 Dec 2024 12:51:14 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48355dc0sm1649022a34.25.2024.12.16.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:51:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 0/2] dt-bindings: dma: adi,axi-dmac: convert to
 yaml and update
Date: Mon, 16 Dec 2024 14:51:00 -0600
Message-Id: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALSSYGcC/3XNOw+CMBQF4L9COlvT3kqlTg6yOuhoHC7tRZrwM
 IUQieG/2zAZH+O5J/c7T9ZT8NSzXfJkgUbf+66NQa0SZitsb8S9i5mBgI0UABwfnrsGuRv4hE3
 NrbZbiQ6oMMTi1z1Q6R+LeGGn/JwfD+wa75Xvhy5My9Aol/avOUouuM5KQNiYzKVqX+BU+yLQ2
 nbNwo3wTphvAiKRAmqyW1dCKn8Q6o1Q4ptQkXAKTZEKXRptP4h5nl+sAxrPPwEAAA==
X-Change-ID: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Convert the ADI AXI DMAC bindings to YAML and then update the bindings
to reflect the current actual use of the bindings.

---
- Resending since this didn't get picked up or commented on for 10 weeks.
  Maybe it got overlooked due to the dt_binding_check failure? As mentioned
  in the commit message, it is OK to make an exception in this case.
- Link to v3: https://lore.kernel.org/r/20241030-axi-dma-dt-yaml-v3-0-d3a9b506f96c@baylibre.com

Changes in v3:
- Picked up review tags
- Fixed rebase botch of patch 2/2
- Link to v2: https://lore.kernel.org/r/20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com

Changes in v2:
- Picked up Nuno's Ack
- Added more than link to main description
- Moved source-type enum definition to description:
- Moved additionalProperties before properties
- Removed unused label
- Fixed node name
- Link to v1: https://lore.kernel.org/r/20241022-axi-dma-dt-yaml-v1-0-68f2a2498d53@baylibre.com

---
David Lechner (2):
      dt-bindings: dma: adi,axi-dmac: convert to yaml schema
      dt-bindings: dma: adi,axi-dmac: deprecate adi,channels node

 .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ----------
 .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 129 +++++++++++++++++++++
 2 files changed, 129 insertions(+), 61 deletions(-)
---
base-commit: 95282a5c5eae59227d58d3b63ec57f377a9093c7
change-id: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


