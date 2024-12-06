Return-Path: <dmaengine+bounces-3921-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726099E6D98
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 12:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E8D16420E
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B41FF7A1;
	Fri,  6 Dec 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b="Rzt8tD1P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DA1BDA97
	for <dmaengine@vger.kernel.org>; Fri,  6 Dec 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485884; cv=none; b=P6nv9+sENlYkQBID87CkVfRWjQCf8BRl+3pjut6chf5OXGsVSXDytKaKjawzdmx8FKJxM50HMNM9whYaJj05N9cnLU5sNo4XRXHm/jviRyfZ2rkI+gp7Flo+M34LX72RFaaGqjcFFzisNSRUD36R3OE0sxHbDVcZzsTaPI6K5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485884; c=relaxed/simple;
	bh=jcKtMmgxbU/AntUCd/uszdkY27gKuPkRyQVGCHTm1Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AB4nkjdl7for/pYW6keWsT/2tL8G3fMNo8eveqCoqKzgeC559AxTu7b1U3mY59YrNMRP8i87ZfR8RF0urQvae1jFSiu+jZlF81y54q0gRTpUKTY+lIE2GPuIm/V2CHN51tQaJWC0tSe4G2iZibdpoBfHUO2icy0KWGylmvu+t/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com; spf=pass smtp.mailfrom=cornersoftsolutions.com; dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b=Rzt8tD1P; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornersoftsolutions.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3990bbe22cso1912917276.1
        for <dmaengine@vger.kernel.org>; Fri, 06 Dec 2024 03:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cornersoftsolutions.com; s=google; t=1733485881; x=1734090681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q62PPXsE+VSeYwcr9qAvv8yZnUeLKqIqrisYrdVxhtU=;
        b=Rzt8tD1P2KbhSHWSTGtCfA1sPzh0m/puG08v3FGZe5sx5m+sC58HNYOFSC/L44Uefg
         W/Sbt/NiOZzRx1kKAIJYItaCt0A/ms28XSr6b1vVSnGWpItcw/h+sxIQQ7TbXYKyxWCD
         MwP8W6EN9Sm+ZE56v0tKLRfwNBuBaUdHZGsVnarA1wdkfFxYl8Ih63xZXi8K/9BiXAxc
         4gDXLFOWgvXEq3E2JKKy2a1cYBniVxYe0Rhlxjpje2k++ZmIFH9TE0TY68aXLvWFPRyV
         /R+jjt6N7DSwl3h+TBdfNtF1OFdGwUaGtY+kGUPdCK7NNqzT8085YcYzK07HNLqZwugO
         FhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733485881; x=1734090681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q62PPXsE+VSeYwcr9qAvv8yZnUeLKqIqrisYrdVxhtU=;
        b=HCJr+BlrLlJ2/L92Boi9k8uZCBzhLzrMB/zLit8VlvtWPGAM44CKeVIgtD/N2p4joD
         tjZa/af1wAs+tq8QwIUb0ePiYup1rSntcr7RMffNlNhb3mNbmm74ELGp+AMSB1AXa258
         f4tYVC94sEtKRm3Anp5EWc1dzVORxE6hmbWH4VEe0lAv73si6P2F/NzwM8gV6wrbYjIu
         MlDYvSydabT+Q/Ofir/CedVHzFE8X0t0C/fKZ2GZgDfY5gAtHKeikT8t+naL5Eng6i4X
         1eZmi46kRpuyvKsYM8z4Pq/XZC52hBDuxgUtxU7txZfJVKM7F6DLD6lsWb4TQE4JPxff
         czew==
X-Forwarded-Encrypted: i=1; AJvYcCWWXmZAE7mgmZ95DCRA4kWTSAbcAWogcBfSJ2JyWO+dpwlMF3GasSRK3qtP/UPexN+f5KG++wvHwsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUzRkF1bf0otwY0X5mBkngDlmk4P8K62h7KNKcHSpYi0ZUIxh
	BmQcDbM11Kwy+QJ4gpwLlH+bKbFDqbaYa9ffyAaTjsvG3a4DSy492tZl5z2SecZ1xHdcUVX/Na2
	yk5iz1A==
X-Gm-Gg: ASbGnctExy0WO/c30uRsVlxCjmLXHZri9/9lfOqBqnYjV7POdOtWARZRlMQ+QpI8lx9
	OTdDE5G+wGnSWNAaUuRPhZJlynPW46QhGJoc/jTv5rzF2TeGipAMMN3EB5C8U4QeZDcGDts/EPr
	HbCOVU50CCwPHBxCl+no35M2e9hYlCkPLzIoBm2j8wr/fuJSJ5L6SUhe3nAXO3TIgdITpUi3VZm
	aI3H3FA+5nD6oOM2hugVu/xAn9sUYle2ZIV+jY6pSeso3wK48JIafjdlKOFJAZMU6A5qwAHz7ci
	9S9KQu2eVF9aUcmZ5jXs+QRTSM8=
X-Google-Smtp-Source: AGHT+IG4eyt1sQPkyNP04ZtSf+u7M13/3ucraXNd9uqXuxzTv7vxnzMKhLqN6poDe47NCkgRh5GBaA==
X-Received: by 2002:a05:6902:2388:b0:e39:787e:d9a with SMTP id 3f1490d57ef6-e3a0b786147mr1906937276.53.1733485881356;
        Fri, 06 Dec 2024 03:51:21 -0800 (PST)
Received: from ken-engineering-laptop.tail1e0d8d.ts.net ([47.196.152.243])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efee2fc130sm802467b3.4.2024.12.06.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:51:21 -0800 (PST)
From: Ken Sloat <ksloat@cornersoftsolutions.com>
To: 
Cc: Ken Sloat <ksloat@cornersoftsolutions.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: dma: st-stm32-dmamux: Add description for dma-cell values
Date: Fri,  6 Dec 2024 06:50:18 -0500
Message-Id: <20241206115018.1155149-1-ksloat@cornersoftsolutions.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma-cell values for the stm32-dmamux are used to craft the DMA spec
for the actual controller. These values are currently undocumented
leaving the user to reverse engineer the driver in order to determine
their meaning. Add a basic description, while avoiding duplicating
information by pointing the user to the associated DMA docs that
describe the fields in depth.

Signed-off-by: Ken Sloat <ksloat@cornersoftsolutions.com>
---

Changes in v2:
    - Remove redundant comment regarding dma-cells val
    - Reference bindings doc for DMA controller

 .../devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
index f26c914a3a9a..b7bca1a83769 100644
--- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
@@ -15,6 +15,16 @@ allOf:
 properties:
   "#dma-cells":
     const: 3
+    description: |
+      Each cell represents the following:
+      1. The mux input number/line for the request
+      2. Bitfield representing DMA channel configuration that is passed
+         to the real DMA controller
+      3. Bitfield representing device dependent DMA features passed to
+         the real DMA controller
+
+      For bitfield definitions of cells 2 and 3, see the associated
+      bindings doc for the actual DMA controller in st,stm32-dma.yaml.
 
   compatible:
     const: st,stm32h7-dmamux
-- 
2.34.1


