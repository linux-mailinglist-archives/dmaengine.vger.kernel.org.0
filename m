Return-Path: <dmaengine+bounces-3385-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CB9A0A97
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 14:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541282837D7
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66592144BA;
	Wed, 16 Oct 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WMLdCqP5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CA20B208;
	Wed, 16 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082598; cv=none; b=h3ooa5GpHaIErg0tzYrS6Hq31MSa7oCU+GIGgFd4uf0FaYtIWVnYoKRERi49fXM9w0OFwBt1+rKky6Xvuzq1RWAg6a74hehQyT8WpSitoaId35zgzafiDS+S0xFmdjTahmAVKR7m36VnycOXnDCQ54nWGhXw3rT2+r44WxyIrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082598; c=relaxed/simple;
	bh=ZbRJjkFZ5jgtGlpROPX2viy+J2b/GpN84Rz+FWIgnfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tnCf6eF79f2WIMb5QlypRGnuqH1WWauW00CMANIRwxy8DBl16MwRA/L76CWUle3nlZi2Jx+cSsQLKBrUZhMM87VNVuvw1m/HsZgznTtwscrEcCyTOHSyrbzuR5sJmJ5IiZdqbsHdOOf8eORPtGQvCTk+tulbpPiYON+aWWftL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WMLdCqP5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8etGR018119;
	Wed, 16 Oct 2024 14:43:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	AywPOgFsLqijDHgfXc1Tq2E7o/XJRJw4qqNyoZ8Ff4A=; b=WMLdCqP5JdsaBQOn
	dQ5k9ez75pztdY8LXLnTQ3k7rpxIpDtapNsaR3FQn8WNNY5wUsWZSdiiMjlVVAZl
	SXiGkGkh31h7cF5AHp+0hss92v5OGk8PqF9NlaIB8H6zjYEiWBX8cA6uybrzyImJ
	FmNE9MQwxxQ4WV6CTVkpsJq07tCHRkUEiBpLzI6ML6sGWvznfqZ9zO6WN2Amc/R3
	MWUvX6IsdMOXDJ3UPOxCzfH4XpM5kQIbCEU7/kw9N0ufVjH92QHoXqFYh7ST0TDO
	IjNaGxbDxRYLtSTDnLHJutJ65p6Dxp3qVw4HggApvJ59HFt0wx/3mwqyvF23gY7z
	dpwh0Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42842jfv6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:43:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D6E0C4004B;
	Wed, 16 Oct 2024 14:41:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 572F123CB4E;
	Wed, 16 Oct 2024 14:40:23 +0200 (CEST)
Received: from localhost (10.252.17.239) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 14:40:23 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 16 Oct 2024 14:39:56 +0200
Subject: [PATCH v3 4/9] dt-bindings: dma: stm32-dma3: prevent additional
 transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-dma3-mp25-updates-v3-4-8311fe6f228d@foss.st.com>
References: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
In-Reply-To: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Some devices require a single transfer. For example, reading FMC ECC status
registers does not support multiple transfers.
Add the possibility to prevent additional transfers, by setting bit 17 of
the 'DMA transfer requirements' bit mask.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v3:
- Refine commit description as per Rob's suggestion.
Changes in v2:
- Reword commit title/message/content as per Rob's suggestion.
---
 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
index 5484848735f8ac3d2050104bbab1d986e82ba6a7..36f9fe860eb990e6caccedd31460ee6993772a35 100644
--- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
@@ -99,6 +99,9 @@ properties:
         -bit 16: Prevent packing/unpacking mode
           0x0: pack/unpack enabled when source data width/burst != destination data width/burst
           0x1: memory data width/burst forced to peripheral data width/burst to prevent pack/unpack
+        -bit 17: Prevent additional transfers due to linked-list refactoring
+          0x0: don't prevent additional transfers for optimal performance
+          0x1: prevent additional transfer to accommodate user constraints such as single transfer
 
 required:
   - compatible

-- 
2.25.1


