Return-Path: <dmaengine+bounces-3361-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D618D99E967
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 14:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EE11C22525
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478941EF09D;
	Tue, 15 Oct 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="i+EpCeJP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E21EC004;
	Tue, 15 Oct 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994590; cv=none; b=ppV99MGt7AT8SVp9R6Gl8eg1lWbiBTTN5i5nJaLlo8tNWY8gFSX0ItLw9mgt6XHDdLmzCaKZu49FzlOITVY6DAJ8N2MvcbpJusgHD2hJd2ITUIH7rK4v0gTmxlXNMK3vNpaWVF1l/B3/NEuZCZ/Xitl7psTnAboAnceFmI+E1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994590; c=relaxed/simple;
	bh=dJQWkcrhwk0Vkj1AihIMxNRLDfQsHXxazUmkVVKOLlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OMBK7KOoOZHZX//V6K6mVEf+ftuPfQ8638KmY0rJx/Lt/2+VnIigeIED5+R5dcf6ZYqw3E8g7eoowgCbQ2pCKbXUZzXcM/lfvWkI8b8xxk8p+UWIbPD41MHUZOjajGJpjWnpVxJhY7BDYkJ1NButKGKOjzz3ksRIxqvkKcMegC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=i+EpCeJP; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8bYfA027894;
	Tue, 15 Oct 2024 14:16:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1FmGrSANQn07iSNnWCRz9WCfIaMI09hSsfRbqu2gnOU=; b=i+EpCeJP2v5lQoKP
	7wHXFfPiAb0MUdQuYdomotUyZGBeM3pWQhTsJz7KvjBqh8qg+8N7owPlycG9D/Uh
	l5akDnfr+1U+B81/BrulzujahyC1ij3h5eEUPTtyJXuXHuiJdzKxHGTEY+o2DA02
	ek3J2DIa+YrcnoETc85jrpccnTkJHlsDi6S22hsFiZ8KMQG86vTdoJD3t7OGF0p6
	hd0fY84V4HJpfbiIngHCdXo/1tQUnG/5hamgUBJJquiBrNYQT3a8IvcS92V6c5sY
	cy8mobAO4dO7ccFKQuvAjGk6P3McC9T+zTaHVInYrwTG+OR/IFd9gFMIPb6ebkf1
	jQV8zQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 427gewwakg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:16:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 084CB4004F;
	Tue, 15 Oct 2024 14:15:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4CA2322233B;
	Tue, 15 Oct 2024 14:14:47 +0200 (CEST)
Received: from localhost (10.48.87.35) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 15 Oct
 2024 14:14:47 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 15 Oct 2024 14:14:37 +0200
Subject: [PATCH v2 1/9] dt-bindings: dma: stm32-dma3: prevent
 packing/unpacking mode
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-dma3-mp25-updates-v2-1-b63e21556ec8@foss.st.com>
References: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
In-Reply-To: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
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

When source data width/burst and destination data width/burst are
different, data are packed or unpacked in DMA3 channel FIFO.
Data are pushed out from DMA3 channel FIFO when the destination burst
length (= data width * burst) is reached.
If the channel is stopped before the transfer end, and if some bytes are
packed/unpacked in the DMA3 channel FIFO, these bytes are lost.
Indeed, DMA3 channel FIFO has no flush capability, only reset.
To avoid potential bytes lost, pack/unpack must be prevented by setting
memory data width/burst equal to peripheral data width/burst.
Memory accesses will be penalized. But it is the only way to avoid bytes
lost.

Some devices (e.g. cyclic RX like UART) need this, so add the possibility
to prevent pack/unpack feature, by setting bit 16 of the 'DMA transfer
requirements' bit mask.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
index 7fdc44b2e6467928622a5bb25d9e0c74bb1790ae..5484848735f8ac3d2050104bbab1d986e82ba6a7 100644
--- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
@@ -96,6 +96,9 @@ properties:
                including the update of the LLI if any
           0x3: at channel level, the transfer complete event is generated at the
                end of the last LLI
+        -bit 16: Prevent packing/unpacking mode
+          0x0: pack/unpack enabled when source data width/burst != destination data width/burst
+          0x1: memory data width/burst forced to peripheral data width/burst to prevent pack/unpack
 
 required:
   - compatible

-- 
2.25.1


