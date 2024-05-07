Return-Path: <dmaengine+bounces-1990-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695538BE2A2
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19627B22181
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D8E15D5BE;
	Tue,  7 May 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gj9W0nO3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB415B155;
	Tue,  7 May 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086570; cv=none; b=KPYD1ak5FowKuEfNkZploOmn7IWp05ttOCohhoEtdsuOf9SevoCtzcN3aXbpbht3ZhAEWfD0dxWcR5iEXi5PAzHQ/JeQ0EVh/lyc0/GLvVFeKCSRhRWQiOmJCMHB9uYnK8/Dm6YvIU2zIelapWGFgTrv90z227g9N5+NGlxZRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086570; c=relaxed/simple;
	bh=iDEDAYmfy4jslRTOnluvRfFFFUrJoFW3xug63TASxKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cT79t76YXmmVZgdMeN45kOIcCZIUB3UodtDGOqNc/dEATWhmcPO7Yy4/AwXH+bNVZEI1gjfu8Yi37z4FawyLQH/JcCdeXixIv/INZc+qmdoeAynDzrFz38dQgrwZ00dEFBChcU6W78g78LALQV5B94b7QENHQH/JUd/Xjs2iG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gj9W0nO3; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447A8XKK014239;
	Tue, 7 May 2024 14:55:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=SG7I3HEsC5ECx95PvvYobz+zYDq/lzLwLC3usCOh8Yc=; b=gj
	9W0nO3UUBPBEbwOa/DxTkedTBGFzMHCA5hs+ByhI/Ndf6vMyEUQP7dWFEYn2bu01
	YYodgZRzN4lHJvk1o6ThFQLQpqnD3uAcqGny8i5sZIIIpQtV4INKR2XMmBW90fHu
	zRew4y82DG/UtSk7Awy8ECpvUDbJwQnmC9ljOfIK0Ls6FrUEgR1nIFOAFDCrIq/a
	jEosrc0jLX9FP5LTOLZ3gW7bFXdrwyyW/TSnPVwck+DsBruDxM3H8VMWA9QoR2h2
	qZIdUi3ohM6vrnPlU3VssmPWow/8DBAu006FIZ1smQMyT+l5Hs10tF/73QX+0gzX
	qTZeaAvJUMyayYveC+rg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwcbxbsap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:55:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BA29340047;
	Tue,  7 May 2024 14:55:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCE3A21ADC9;
	Tue,  7 May 2024 14:55:03 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:55:03 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>
Subject: [PATCH v2 03/12] MAINTAINERS: Add entry for STM32 DMA controllers drivers and documentation
Date: Tue, 7 May 2024 14:54:33 +0200
Message-ID: <20240507125442.3989284-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
References: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

Add an entry to make myself a maintainer of STM32 DMA controllers drivers
and documentation.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfc11cc17564..0462e61ea488 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21131,6 +21131,15 @@ F:	Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
 F:	Documentation/devicetree/bindings/sound/st,stm32-*.yaml
 F:	sound/soc/stm/
 
+STM32 DMA DRIVERS
+M:	Amélie Delaunay <amelie.delaunay@foss.st.com>
+L:	dmaengine@vger.kernel.org
+L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
+F:	Documentation/devicetree/bindings/dma/stm32/
+F:	drivers/dma/stm32/
+
 STM32 TIMER/LPTIMER DRIVERS
 M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
 S:	Maintained
-- 
2.25.1


