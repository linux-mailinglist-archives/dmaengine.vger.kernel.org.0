Return-Path: <dmaengine+bounces-1922-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE78AE621
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C839F284DB6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117512E1E8;
	Tue, 23 Apr 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f9T5Kr7M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F282C60;
	Tue, 23 Apr 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875689; cv=none; b=ArMQ2AQt3+bBvI3jJD3LlmT358nr3YHWn0+xxG1uOIbrm2mYF3F8FBNF6/V8zCQcJ3JjAX0mApo9UhXoGJmt8Ss73/8HfDarCZA1cNGyBPSXLSMdwq04h8IYJGhm79GiIGFniGF/oo+OOcpmqiOWAMKGDu0OUjlEj6arWY5+rYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875689; c=relaxed/simple;
	bh=6tiGjDLZUtnbfvC9GHJt45IUMbXVon8DpoCL26sRS5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHoeamg1JmpJrbrb2tROdQszXvQVFrUGekEoRlLaBXn8b4m/IvN9Dk6Pp19E+ZTk/YMjTBQL69ClHWqjlG/6beX1xXTyaKTY7OY0uyFeUm7CftAGGlXm6wA6BAecUCfp8tzPVT6thy5RMC2fA2gyYqMN/3UNHcLMH4Wl5hIVGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f9T5Kr7M; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NC4kw4017695;
	Tue, 23 Apr 2024 14:34:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=n7hVufsgTZ5gpYQHZe2dOCK3i7enDHUkBsTupDTYBHA=; b=f9
	T5Kr7MIwWY78nq1kSRmaY1bXfuQ06OaaPxGGMHC30419tCppkMrNdCbhDpVsFGye
	T/XaZGTpvFAGc4ZAK3D84Klf2OFvPJoJDlIdGoCvPg9dwFeW9SSrt6dqlYlM04Oa
	xXecszcmWyVKhIDVNhIGjbRnMGp/w2jo8gMeeTF9z+pWqqSXu2ijT1ivZYjc0V3w
	6W2LFI7Blk0jZ4/oyRj/0jQ2/WFeVHrDzaWbUIB7kFv1nFrQvf9J1A+7nbbREX+Z
	KnwetTxGJI4YPsNWc3zOZGIGguiDD1GD2x1ODcTCdoOQvb70SmGtr3bS0eqTFojP
	BGtmrAjd8YrB7a5r/cNw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4edudpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:34:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E67B44002D;
	Tue, 23 Apr 2024 14:34:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1CF2C21A23A;
	Tue, 23 Apr 2024 14:33:26 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:33:25 +0200
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
Subject: [PATCH 03/12] MAINTAINERS: Add entry for STM32 DMA controllers drivers and documentation
Date: Tue, 23 Apr 2024 14:32:53 +0200
Message-ID: <20240423123302.1550592-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02

Add an entry to make myself a maintainer of STM32 DMA controllers drivers
and documentation.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9038abd8411e..c117184b7d26 100644
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


