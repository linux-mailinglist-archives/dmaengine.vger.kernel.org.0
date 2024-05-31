Return-Path: <dmaengine+bounces-2224-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9A8D652B
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2551C22CE8
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B274076;
	Fri, 31 May 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dOyGdXid"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD52B9D2;
	Fri, 31 May 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168121; cv=none; b=cQRc67WpexjNYKtWIXWr2NvzwKDZsCs7BNEl3St3OeykW21NtC+qZOrtw6iG42zT+/3sMlYOPYnwpu1wXMWrS8TFs5O+9NsO5rSx7mGdPQBn3EJR+5wtgLv9aWAGpKX+PXgojle1MYA9L+3TlKiy4n7mvIcrb1i+1K2RCzzHubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168121; c=relaxed/simple;
	bh=wlwd8yfaktkbRs/5102vxtPOw07qUSsLYZdaYIeywU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFMARIhqcPPYmV8gJR3x5qPeByXsnjooI1nI7StWfN2+dSJ31Qa/6Fngg+fyIOQBo6s/gAw5NoSpIDGt8t4nuTWkxRfvy652VQWT+u+jgjmoLPZ9shEk9asMd73xyMXMALM/PDe6HzFfniv/Ja69Nc8c2BERdQHAg5hbuQ3V8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dOyGdXid; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VDHINw007208;
	Fri, 31 May 2024 17:08:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	J+3i1j+pq3XT9u6pb0xZVn9sOodnovVMoU1mIM4VGJQ=; b=dOyGdXidIjAPoxaE
	6i49hQm84hjxfsbuqS8JOxP0DPjudx8/pQet30Subrs9ukAG9s7xq7EXpdAh59PO
	J1zS6COBhRk4bo1fOLOH41RxCyKGiN9pMGaE7Zbumq5l8GbchkpHUIwBC0lTYQzQ
	B70h7FQS1ZtekflcMLOSed86gybMYW+3In/yS8hWQTFjBMMJbT8H2f91x8EcJe+s
	PKB6otIon8QueJzI1VroVVg5nIoyMRNlW6PD5ooQYmeiG2maVrEi+rMGKdTLxiP2
	MqbUwbaHYsqK34XkEYjcTZAb0DQPEOMsjAPvCJOULsPE36Z65MrkOqcnrpFui1bP
	L7gG4w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yb9ykd6sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:08:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2712740045;
	Fri, 31 May 2024 17:08:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89C09223652;
	Fri, 31 May 2024 17:07:18 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:07:18 +0200
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
Subject: [PATCH v4 03/12] MAINTAINERS: Add entry for STM32 DMA controllers drivers and documentation
Date: Fri, 31 May 2024 17:07:03 +0200
Message-ID: <20240531150712.2503554-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
References: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01

Add an entry to make myself a maintainer of STM32 DMA controllers drivers
and documentation.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..e23cc6f644fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21485,6 +21485,15 @@ F:	Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
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


