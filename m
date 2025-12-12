Return-Path: <dmaengine+bounces-7578-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D9CB79C6
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 03:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B167F30319BC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 02:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1828CF52;
	Fri, 12 Dec 2025 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEC5UXfX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550D286D5D
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505170; cv=none; b=KMvgEnxNcarv6R2tNOBSNnmMsn+vulv9eypKMtq9e6F5XEQSxR472XlnqkrS8p0Kdp+WcKh3lIHyQ2w67ADWp3C9SyaMCQE1f5m44dAlFOBq07sM5ZAJ1cxNuBQOboovKdDReyN4yc5s6GP3VUrWLcC/9PHFYuKRvo9v3VTiltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505170; c=relaxed/simple;
	bh=5C+xuJE/8j5c4wzd7i8X2a/0lBR3bC/ArFxnUHcal6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3FSup+sYoewQtmXsGpdpVtxf9U/N/CxEKN4y+hiFozIaMUTOOii6RU+O1CwOjsIVcCA/msfPLwpcxRgDdBNjtN0s4vtjC+DFOwTCzaYaJxtj9rITwqAyCdr2pSmDp2VcvMLX+fprYoTv6l+2VqQr9CTRC0sJV9fR8n9DXUMkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEC5UXfX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so748513b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 11 Dec 2025 18:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765505168; x=1766109968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcCzUiXMsxI84pITFnN6DrkZDZAsaj1mZ+yE52KyDfA=;
        b=FEC5UXfXEJNIck0prfwdyJ/U0/6c5T5IjgChrQTp9uYkGdkTiZnJ+5MhBlxl2LSjK8
         M00Z4gUBpyPV5+S/p4DNF8kW1iGmWgQnDhjeUNfCEhIcp1C7T58oZYFOMUV6NVRxZU4F
         Lzi6avNOELWJQWJyM1si6sgO/7I2rgZIzr0CpkxSpXuadwFzKuAIgnGPnFh6E7UAl/MY
         MAqTl5G2koZEbm6c7Cffyn086ko4s4wnV5do1M1O6ZNEkcoUtd1XiNrNTFP56mDyZ3wD
         gZhFXjPaQPImBwgGiGL9GZYhUhizO6fa5fUKBFKdaix+3xQCjfbOeswGNWdrgJFeZ3jm
         WzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505168; x=1766109968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EcCzUiXMsxI84pITFnN6DrkZDZAsaj1mZ+yE52KyDfA=;
        b=QaIZUzcZ3QhNM8motmFsc30HfG2KnBkLG7/ePLgVcTN58Ik/+fyB7oO4C1qOAQmZg+
         Ga6mgeX4xS+RtKM6VkYxFGECfm2ZXR23SofjVFgCckCNzLD3+sI6tqBNK1izXHUZ3y8H
         /C4ulJDdeC6xxPc1C1han2lVK6YYzAxh4+9qJQdWRUyf65Y28OQN1sTjvy31BXfcsjzW
         FT55OapgjKOoEfvxtE6yvOwBzYmbAcByPIXOqD74NVcYKTy1+OhxpEhj8WiRqpMxx0Q+
         x4ebu0pV4HQ/AGUzogHAhmSX1QbGJBieg0ZVO4TdQ6dN3llX14YeEDWMEr5ma+4ucNAv
         M4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVZNdOQrDYy8zazKFkHPilzIi1YeSyeeQi/IS+xUK8gngwfD+BENwokIYnOgj8JHN45CnN6A3C7aKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOc+dOpmGcYIKp1mTL71Y+wwqkj2zjDt5VYEqWSWicKb1WtaJv
	WzUQl+SwPbI+8OE0NeSeyydjZX6WBXaqAaTXx60HFuVIfHsUnWxlPomq
X-Gm-Gg: AY/fxX5boEs5tZCv9fPBi5iby4wQ0I2FQhS+Q7gYnMLMfGdapbS79C0/urSQT2UR8FQ
	Z80XXz6xXtVLKtgqIvoNLOAl+pqkze8Tln9ZqPfG8sMI3xHccD7yHOxXiuMQzF6LkjS9gQsptxH
	AVK6HKEw+lwgvsM13WykMCDVFaSIflIfECdR7jY2qTk593kb6zsoON0xZhTCIG4rV+VtVV5jL8c
	DcQRRNk6Glc7e5Cpa+nUiNhWmCKVNAj/Z5FixQmtnolNq2k+mxD4iGDd+jpZSzxo783o3A9EI5z
	TnT5CP7FmFsKTECK1N9bi9Op3ZrWkg3GbqGqU/9az7sqw0TilPRQ8iIz+DXBpeqPjmP2GPVr13h
	8nNCXMQqIQgXnpU7Qt4mmjYn0vo/0GQ71/2eRdQbKpDMTh+5lEUWfKS44UDNiAosN+qJirJwRZ9
	nTTD+74j5azA==
X-Google-Smtp-Source: AGHT+IG4OglOWBlD1VKepmk+tiFRagNZMAVHPJzfqBDDWkRcGZOlcpelbUg9zYKtD/uPOdqR748juQ==
X-Received: by 2002:a05:7022:e997:b0:11a:3a1c:6c5c with SMTP id a92af1059eb24-11f349a48c3mr530798c88.3.1765505167760;
        Thu, 11 Dec 2025 18:06:07 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ffae2sm10501159c88.9.2025.12.11.18.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:06:07 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
Date: Fri, 12 Dec 2025 10:05:01 +0800
Message-ID: <20251212020504.915616-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212020504.915616-1-inochiama@gmail.com>
References: <20251212020504.915616-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA controller on CV1800B needs to use the DMA phandle args
as the channel number instead of hardware handshake number, so
add a new compatible for the DMA controller on CV1800B.

Change the DMA phandle args parsing logic so it can use handshake
number as channel number if necessary

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index a393a33c8908..0b5c8314e25e 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - snps,axi-dma-1.01a
       - intel,kmb-axi-dma
+      - sophgo,cv1800b-axi-dma
       - starfive,jh7110-axi-dma
       - starfive,jh8100-axi-dma

--
2.52.0


