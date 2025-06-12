Return-Path: <dmaengine+bounces-5407-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C44AD69B1
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 09:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83A33A9AF4
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25821CC6D;
	Thu, 12 Jun 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPhNhTUR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE12745C;
	Thu, 12 Jun 2025 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715070; cv=none; b=vGD93ufnrGy/Jz4JxuaIKuGsuHly0Jrr63MXAKuPSb8gpqTaBHxEY6dW2l2Irf0F0aIpOEPmdPrcgd4LQhkAMvM+a1wFIb4wzijtLAyhK5kYCO5S3SVd9f76UieN18A64XNc2P8v8UEcIQQk4tRYJ9QmWqwl5Gz3SWlTG5HBnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715070; c=relaxed/simple;
	bh=BfLIKo1HiCbrqoDrKnG7/7oHcuUU05eEz9tUOm5YGyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqMc31cXzOAYu9TO6FmvwJGzuTCnsCTA1JI6FsS1TiRmxD0qL+gh+W7o/1njS/EgbtF4+CaDFNQ782+jfA9OpQv24BviyEqNNfMqlNbxDi53n531snhXP1j5Sd+C7GOJvplM0bB/k/F8BbJLQwH2t7E1bEe6OJkgpET8McOnZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPhNhTUR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-236377f00a1so5814765ad.3;
        Thu, 12 Jun 2025 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749715068; x=1750319868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kMmDnp/7KxTybGoRkO1628zyd7TPuo90TVmVTUGRNFI=;
        b=MPhNhTURFrTO5VOC1EQaHDg+sfED6eEy/8rJ78bp1gDl81mOeIgi4lEtXP+sCmuuJ0
         l9opyhf+boAa+qYJHtiIy1AE3ES1z1KXYF6WEdSz5YtQVSLIhDop1ZwXslPr6AwRTdgZ
         8TA6yF+ui4o3aBg5vLbav8K6vlmzROsxWBkaUFNXdwX8q/BDrYkaCEoZCG3AlsL+ZTqM
         HWWJRdljkGBi0KJwB7Oup7JFCw8x67+8Y7OHIT1gQDA6HZCQ+AgeLyu9J8P5MnIyhkXk
         ApAkmx0uH+smOfwuHTSFMh1yZTBfaw0C5Xmfx01Klqqy7AWwEVVeRZUCwccN+yaXqaZW
         E4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715068; x=1750319868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMmDnp/7KxTybGoRkO1628zyd7TPuo90TVmVTUGRNFI=;
        b=n7FiD/DOEeTvgpG2dqoyD/kkAK6cA/fXG9P5MbRSlgbp3Ad9Gfb+aPyOBmylEYputO
         /NNHDqLfuv99GDCKzAgbWSLwrJIB6gyhIMkOhg5q0fYJ484hx/LOW/iFQymbVm+hRI9H
         gOTgvDhCmB+RSaF86ZtSTKmPoouxnCjoI8nGLHvvm9U/SMMy6jq8fB16skZ4LhipYGDQ
         5euvcTUWepbIcyuVE8sYQMINFE69vRanOiqxVUF8GN7FEqSAKjWczZDs76Q3MODjvA9R
         Ka9ZZ5KsmMMmFV3LKlyYeHvxfY5dJH0ltiry+1efJWL5Dme+RteJCzyVUqOb5yf13yAu
         c17A==
X-Forwarded-Encrypted: i=1; AJvYcCVOwRR/8gbabOWDeLqsYgrOQ3lchqiXy59s27H//WMLK2K904U17stlUNaN9bThdSAfeEHh+/5I7Bg/@vger.kernel.org, AJvYcCVc1lhpGD9uqCd1RDhaV5gdYhcFZiHx1Rbm8liNOLfTzUKLxpMohvENvyZqhwuR3ZYveficn4vflKsfHnII@vger.kernel.org, AJvYcCWcgYKyqM49EOslIIion8Eutak1P/yEborgf6C/UJ/LwrX5BfNdPQ9z+DuhLFtciSSUGcd6JiV14VLg@vger.kernel.org
X-Gm-Message-State: AOJu0YwGu6MPi02UF3FXsA9PDGVraQDXc7vMuNDoI4wVhswr9KtE+TBJ
	7BlA/88YrboMZh+WG/u5lAoT4pG7qAY28qUEHPI0Ppf1F95RlVCD1n81
X-Gm-Gg: ASbGncv2OWQDoNXAwr89OLJODFsDoxplolcTSYTsDpvI3E3l9wr+1/nXLCc+MEB1Z/d
	lxQ0WLf0pakW46973If/Hl8AGgt1LG+JdQvHdUKN6DH9NI1HJPjymkpGuoG7S5QfwxoLrXmhQNF
	z2+SucOgjxfUWdd6hcNEmvq/M9nLbkPLDzImoCyw6O5qTlCgBYHK4HFXB6BRHcSTjXGlFSArG4X
	qi8Y4J1iSkFgjGjYCpRLCZaGw8VsHOMsyf2ciLkhlM3PFg2MVeqI6BNLvJao3o/F+MO4K8FrT9n
	QWIfXe5FQY2lBrw7M1xLcqw8HsvjtCC+6kwsx8tzF26lcmj2QYIQ0qa0/0QA
X-Google-Smtp-Source: AGHT+IG8n1tZENbfzk/Y7YDopw8nfD52u0VQOAnRgBEt2xXrShoh3h9JbatBD/V3wyoe1EymLv3JGw==
X-Received: by 2002:a17:903:3c23:b0:210:fce4:11ec with SMTP id d9443c01a7336-23641aa2325mr84452695ad.1.1749715068002;
        Thu, 12 Jun 2025 00:57:48 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e7345basm7880235ad.245.2025.06.12.00.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:57:47 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: qcom: Enable GPI DMA for sc8280xp
Date: Thu, 12 Jun 2025 15:57:21 +0800
Message-ID: <20250612075724.707457-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds GPI DMA support for sc8280xp platform and related devices.

base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in v2:
- document dt-bindings (Dmitry)
- use describe in commit message (Eugen)
- enable it for sc8280xp based devices
- Link to v1: https://lore.kernel.org/linux-arm-msm/20250605054208.402581-1-mitltlatltl@gmail.com

Pengyu Luo (3):
  dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
  arm64: dts: qcom: sc8280xp: Describe GPI DMA controller nodes
  arm64: dts: qcom: sc8280xp: Enable GPI DMA

 .../devicetree/bindings/dma/qcom,gpi.yaml     |   1 +
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  12 +
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |  12 +
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  12 +
 .../dts/qcom/sc8280xp-microsoft-arcata.dts    |  12 +
 .../dts/qcom/sc8280xp-microsoft-blackrock.dts |  12 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 368 ++++++++++++++++++
 7 files changed, 429 insertions(+)

-- 
2.49.0


