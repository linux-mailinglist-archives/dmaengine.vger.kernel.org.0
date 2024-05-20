Return-Path: <dmaengine+bounces-2080-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328118C9FE1
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0351F219DF
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5571137755;
	Mon, 20 May 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QPm/STZB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA86136E3F;
	Mon, 20 May 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219806; cv=none; b=VlRwTV6lssPb47+GYONfcIi07TtYFINSrfcw3bpMp38u+acgvxV+eTwWD8BfofrwMDzDvDYd1IGMFiDjjS0zuedisNsoJa2cozyFE3mvCpcc9zaRW7CmCI9bd66Ieoy3PXHELfh60fwQipf5WFSZAKqL1/qdOedq04E/pl77VTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219806; c=relaxed/simple;
	bh=iDEDAYmfy4jslRTOnluvRfFFFUrJoFW3xug63TASxKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=df5dUmKfLAgixqCVZLrw9OZG653tFEFwwOB8RyyZR/uNt9YPTHeC4eghPNEu6UVuMEacglXmJHuqXHdahdAaV/JDXGTOTDGyLT+3couPwtZZLUh/wCi1d0/Ob56gSZf7WcT6Ednjat/jEO6C1AnMJwys9BWVNaRRp3ajBftlMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QPm/STZB; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KDw4US006477;
	Mon, 20 May 2024 17:43:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=SG7I3HEsC5ECx95PvvYobz+zYDq/lzLwLC3usCOh8Yc=; b=QP
	m/STZBU7T2v/x/vGVRuUaccDXP8/EB8IuVX0yjfwQOcsXzipb7P/fNTZxSXFx3P4
	sU7vKuJ1HQeOtjUtGuY0ffMQZP8bkbRsZM3QyE5cL4Gxevq3MYpz0dSX/Jwwejly
	kw4Q/qHa0DjKpBwITKqc51b0vdiojKVrl19Ek1mONRsWEHaoqyxrMYF9SaqCKjJS
	PpIsG5Al5zkLg28kGtkFl8CkL/3EWfLeVT5i43lbHW/KJcVEl7j+/4Gu7usZnbkR
	f26stK0XrkkhQ2ytU852SK/ptEcDrpFf+6wDQ6H/NZSTMzwEGGuH655TU212lHhu
	tqtweBCPLbatpS+oX4MA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y6n6hfnk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:43:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1025C40045;
	Mon, 20 May 2024 17:43:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F81B226FC3;
	Mon, 20 May 2024 17:42:18 +0200 (CEST)
Received: from localhost (10.252.8.132) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 17:42:18 +0200
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
Date: Mon, 20 May 2024 17:42:04 +0200
Message-ID: <20240520154213.689699-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520154213.689699-1-amelie.delaunay@foss.st.com>
References: <20240520154213.689699-1-amelie.delaunay@foss.st.com>
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


