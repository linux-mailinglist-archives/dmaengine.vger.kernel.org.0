Return-Path: <dmaengine+bounces-3636-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDFE9B52B0
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45AC1F25464
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D59B1FF7C2;
	Tue, 29 Oct 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qVmjJUJb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1DA20720C
	for <dmaengine@vger.kernel.org>; Tue, 29 Oct 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230163; cv=none; b=UkfiRZIVUYcvs75Sm3jFpgEqZ9r0tvik5Ug3RuFMtlDSDxbiiWf2xPqRWfrTRgidUjbXx2n4GUtbiConw8cmpvGSgIKy6Xl0p8wMP0KaqjbnIe1bSAfDYnlVnhV80U57HVWBPeoJxVwlXLHwJ1vI/lIEQF41Cc5jCgs5HGnR0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230163; c=relaxed/simple;
	bh=DtVmQtn9HI5DAtC/+hS0I+M75RQI6qsz7cwlNvaj1hM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jpzYGwh9jfaL7olo9WCA9q5gwnUsjw9JdQedBH0z4lFZ0Nej41QfH0YzraB6uv0Gmk4t15A4BZQumVGRAn0JcAm44Si2TT2n0u7FU4zl/iAm1YlI8uRAYUU/mObU71JANivrUcF4EPXLbYHnrgdZ8dBwsWwiuK1oir6gkb+Ap0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qVmjJUJb; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5eb67d926c4so93318eaf.0
        for <dmaengine@vger.kernel.org>; Tue, 29 Oct 2024 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730230160; x=1730834960; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJTkGWDwf/MKcVOFsQcp1CeeeZH7LiL3lewL8OqxkcA=;
        b=qVmjJUJbGH2mc3K9zk4r6BGewxVEE7nME5T0gi906xkP03yC1vIALZrgmAAXaiBACT
         n7BQx3/c6bl+rnjjyX8pcNKsKIGv8qvRY3tJy5ED41pZ5LJPeV6KB3XPD/x3K7D3E1AR
         FidqLhL25RFbde4DHATwJKg7aMhnEYKORcsD4Cro888mkALadvfmEs2vAIfhdNDxf5pP
         WNBXbqkwJMBeGTzYCtQqyWLmJY/84jJp8oQx/SQf+fuhkfORRsU3lJatnhsKtVCiPWm5
         jKwGe4jrx+8i5cXnyEPH4YgzWPsfMg3JsXTq8u95PjpGxketuJPG/d0+Px61nvHddHdt
         bzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230160; x=1730834960;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJTkGWDwf/MKcVOFsQcp1CeeeZH7LiL3lewL8OqxkcA=;
        b=S8cKLLYfUZx7pMuhTcWTP7xavcJ4kmvzOC8H+Ou3tSBs1bIMDYdWsglRyR8qcyPeKR
         OqGNx0djXheB73Ndynab2gaeojmsD78ElxvOec2prD1kfWeddEApfjncFFLYRklS8y0I
         zzQW0Q13iubLgFMEmnw61oeBhUBaNyU//mYg00mLZqkPTO6dC5iusBCEVzh+eV30UPWG
         fkbkISh2wdthE4EsKndHKvtaEQnV9nB9Vfrm9WXXrKqBKvylObmTNuW06MdeEfR46f9H
         TBQXRgYM/dK3ZBCy4rLSUYbtcywpxtCYB7xjl5jtPNGBHv6WrEa/2KJCWmc+k3fdl2LY
         GVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRpCWstWneOHBFcQk3Fow/NluDjGJQvbRvYRPnvGOhvtGhEaRRh0dB76Qp1LkDzWaLihIxwdTxp1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyupik8HInAGWa+M5Xjcw2teFIHTM5pFyzjQtn0vnZuFzSDFmLT
	7SkcZ2YFNzGLXRyZlL/dMAkLVmA8DyQ95X+WFriIj+FfBYUmqJtDI7hkNcWyzIM=
X-Google-Smtp-Source: AGHT+IFlvLGWWB72G+Y3LmzvyDEe3ZU8JkxVbdDOnmsiok138JD6F6ABnJdEkDU9VaGV28ST+sWJdA==
X-Received: by 2002:a4a:c59a:0:b0:5eb:5eff:afbb with SMTP id 006d021491bc7-5ec546107d6mr2051491eaf.1.1730230159844;
        Tue, 29 Oct 2024 12:29:19 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec18598e79sm2452495eaf.14.2024.10.29.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:29:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] dt-bindings: dma: adi,axi-dmac: convert to yaml and
 update
Date: Tue, 29 Oct 2024 14:29:13 -0500
Message-Id: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIk3IWcC/3WNSw6DMAwFr4K8riviUgpd9R4VC5OYYomfEoRAi
 Ls3Zd/ljPTm7RDEqwR4Jjt4WTToOESgSwK25eEjqC4yUEqZSYmQV0XXM7oZN+47tLl9GHYkdSk
 QV5OXRtez+K4itxrm0W/nwWJ+9n9rMZhiXjTElJWFu99eNW+d1l6uduyhOo7jCwYL8xaxAAAA
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Convert the ADI AXI DMAC bindings to YAML and then update the bindings
to reflect the current actual use of the bindings.

---
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
 .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 130 +++++++++++++++++++++
 2 files changed, 130 insertions(+), 61 deletions(-)
---
base-commit: 52a53aecddb1b407268ebc80695c38e5093dc08f
change-id: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


