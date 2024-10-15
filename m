Return-Path: <dmaengine+bounces-3365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9D99E973
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD181F218AF
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87F1F4FCA;
	Tue, 15 Oct 2024 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nOcGlcw1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230A1EC00D;
	Tue, 15 Oct 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994602; cv=none; b=ioko76i/y8tqYjFyaDSrkizQFY8OUf/aL4U7frrH70WaeJOTCenT8IalMverIjD3m1zrnvRubb9dZD2b47Her1holJ4d8Zh+oIKgu51Dd3wb8DQmRSJAeEpKGmBTWEEpnUJiTng1j9X0AC7L6ObvGUlQV0H0kWITlEY7IscF03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994602; c=relaxed/simple;
	bh=KJJX6Mk2BIPcDHxmAdAAVN4AJzb4fo5uCPsJqP5Eu/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i6Z+kXiYp3UAWP7dBwxYxVVSUck2HBsYA4XG6+e6u/MkrgXtq2+Nl9sOaIDfnXciBaPnyVmFNOaElQB+cwB9wxWSit+8Mds2hc4o2OR2o39s9OeSpTgm4gQs+O6BwGpI/JLJU/N8NF2szKIMfpSlVNCKWVJiZ+Vr8k+6qlq1r90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nOcGlcw1; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBmlSi018353;
	Tue, 15 Oct 2024 14:16:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rbIrnqQYiSJv3pnlZhdNGe2+XdPzVYU0/oTVXJYKvZg=; b=nOcGlcw1VsnJFLIW
	Oqk8zgm2Q/Vog9QyUEeK6Bz+rsZbMLXgVGrKWvcp6aP6BduUqdl0w10eYOhwDbLW
	V0A09IGFxmn+ocHUz5+eXCoIcHLiUrT7MDXiZzNLlaqu7K1cDlLk+R3caa1cFuQi
	+KljtQ6GdUMsAMXcPT2PJdfcveeVjZcMnBap060lUDe+qyA3hMMyydQUv13FW09R
	Rcn9sEoMdcZionsMxW0oiECJPvXHZ7OixyTHTFdRkIt02eU8E09HGmMb15t+Nw/8
	wYjToD3DwjDocGwTk63lElbzzWKjRbRQWYonLzdRIsB/lpGoGVwuTnCs31LYbnoq
	qpQNhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42842jacm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:16:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 07F4940047;
	Tue, 15 Oct 2024 14:15:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 69C96222351;
	Tue, 15 Oct 2024 14:14:49 +0200 (CEST)
Received: from localhost (10.48.87.35) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 15 Oct
 2024 14:14:49 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 15 Oct 2024 14:14:40 +0200
Subject: [PATCH v2 4/9] dt-bindings: dma: stm32-dma3: prevent additional
 transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-dma3-mp25-updates-v2-4-b63e21556ec8@foss.st.com>
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

stm32-dma3 driver refactors the linked-list in order to address the memory
with the highest possible data width.
It means that it can introduce up to 2 linked-list items. One with a
transfer length multiple of channel maximum burst length and so with the
highest possible data width. And an extra one with the latest bytes, with
lower data width.
Some devices (e.g. FMC ECC) don't support having several transfers instead
of only one.
So add the possibility to prevent these additional transfers, by setting
bit 17 of the 'DMA transfer requirements' bit mask.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
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


