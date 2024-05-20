Return-Path: <dmaengine+bounces-2086-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556AB8CA020
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 17:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DE6281D53
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608C137771;
	Mon, 20 May 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="03/irbYu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776354660;
	Mon, 20 May 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220262; cv=none; b=B1dI7Uy1gOk0XPfvsmRuuD62Rg4e+HyFtbHBK83/BZG6GVp7iBMiC93YrzBuN9y8NHO3F/w+Ov/oZ4znAnS+mis51K8UQHWfwhyFhPsCqgK9SPtoFDfVK3aD/DdNsPhm8WaVhJc1IdqQfU8wFyU0QNaxCdNQSs+oxL3KhTrH1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220262; c=relaxed/simple;
	bh=iDEDAYmfy4jslRTOnluvRfFFFUrJoFW3xug63TASxKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsYvz8mnxHkR/EBGagpK9VF4F2qPM2f/LgY2V8GfWNJNgAX9IPGZ/fpOreBVKKON752bRWI5tkMt63jouuJ+arC9DLgpUN8fFjXt5qPfnxoiJ+NqrwWl+4eQHkAYzsw5rBiPYDz5zFLxSWN6YuVjm7AKgzro6TEbVliLuY5N5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=03/irbYu; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KE7aXw023335;
	Mon, 20 May 2024 17:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=SG7I3HEsC5ECx95PvvYobz+zYDq/lzLwLC3usCOh8Yc=; b=03
	/irbYuL7JBgXsGqextXbpF1EzrFtizX4wZmJKIvjWIq1cxPzU1UMRy+Q7vRP8974
	M6Dz/JEAkWCLJvllHZJ1D1pk8UEtCbJV/nlUKHMTdKiUnO8oL+yRuWaLiVMZzB0V
	eBxUWAu/ctZLzBuz63pnG4uIvjVjZmd/oCcq7Be7un/YnL+vx+03c9O3eVromq/c
	t8m4lfT77kZ5+cVGLyQ/cPCPM5O/hWlOfY7PtZQC9/TmWogFik6zMUPSZvf1DcsL
	wjWFxaziXmQu888w9qczyvVh3FztOWH5Maqy1IMLDpaadGTZH7mzrJ6wstycc28i
	yH2euR2P+5VRTXJnW0lw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y6n337q0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:50:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AAC0C40045;
	Mon, 20 May 2024 17:50:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA530226FBF;
	Mon, 20 May 2024 17:49:54 +0200 (CEST)
Received: from localhost (10.252.8.132) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 17:49:54 +0200
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
Subject: [PATCH v3 03/12] MAINTAINERS: Add entry for STM32 DMA controllers drivers and documentation
Date: Mon, 20 May 2024 17:49:39 +0200
Message-ID: <20240520154948.690697-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
References: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01

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


