Return-Path: <dmaengine+bounces-3325-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F28998A16
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FCE1C211E2
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A571F940E;
	Thu, 10 Oct 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="t+Tm3TBm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E801F8EE5;
	Thu, 10 Oct 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570710; cv=none; b=i63gLmPl03LvXjqPoy5eRPoY+8GfO/i5AU0LnI0r6EzzKl2KM7bIT/jqEFrC0S0OXX+rQEz6SFsT8ILduwEgfeHj4tky5kGB85JB388rWa6UcyqRiG1FDGv0dftbAONGt8j/XLiZAbLRyiARV4priG+sv0yU3DH0pxZLsNQ4jyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570710; c=relaxed/simple;
	bh=N2m1gfifwajmg6EnZMzZvXKqHVIAAPvDCXo9JlOB5Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G/88HeZagxOSlLeJ78Qe0bIMO9TXNhFrmcp+uPrYq+ZNcqq5qlF4kOiWhKQUneagS1O6g/0f5jfeDJKtT8wQVjF2cK5DorQqqvOgqNNaqTO/YeBaLhjZn3lR4UAWU6OqVnOOSn9SEgjsoIN7C6ZDAv2oOVWePdl3/uFoI+0qeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=t+Tm3TBm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A93TNI014746;
	Thu, 10 Oct 2024 16:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	h4I11Ou8IOZpUXGFEYlLtaaqmE8Vy707B+jgjAFXffM=; b=t+Tm3TBmhs0fEr10
	plbNUtImFIFmEt0NkQBH9hdqo/B3SN/AhazROIGIKYGJl7JaGzjchPAbk9L6tx9x
	lb3I/S6hb01yQYRK4/GT3QLeMlZF213UHAY53Z+vzkpRH6b+cJEVTx2dgn60QJ+T
	Ge02QFlyqhi7s9FBfH4NbkfBhWkas4JUvFog1TkxBX4kNdPcxW+TA0r/ypAatkgF
	nGBsj04qL1JCqFplj4yMx6t1typIKnX6yTdEAec2QK+q3fNgPj9ZZ4KvlZepJKIM
	3ng2FyH32jcftnftBRM9ri8cdS8nkz7435/xGOiIBV+wPJ0HY/aalajngYGgRuco
	D0/kSA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w9xcvka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 41A454008D;
	Thu, 10 Oct 2024 16:30:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 81B392967DE;
	Thu, 10 Oct 2024 16:28:09 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:09 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:27:54 +0200
Subject: [PATCH 04/11] dt-bindings: dma: stm32-dma3: prevent linked-list
 refactoring
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-4-adf0633981ea@foss.st.com>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
In-Reply-To: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
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
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
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
So add the possibility to prevent linked-list refactoring, by setting bit
17 of the 'DMA transfer requirements' bit mask.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
index 5484848735f8ac3d2050104bbab1d986e82ba6a7..38c30271f732e0c8da48199a224a88bb647eeca7 100644
--- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
@@ -99,6 +99,9 @@ properties:
         -bit 16: Prevent packing/unpacking mode
           0x0: pack/unpack enabled when source data width/burst != destination data width/burst
           0x1: memory data width/burst forced to peripheral data width/burst to prevent pack/unpack
+        -bit 17: Prevent linked-list refactoring
+          0x0: don't prevent driver to refactor the linked-list for optimal performance
+          0x1: prevent driver to refactor the linked-list, despite not optimal performance
 
 required:
   - compatible

-- 
2.25.1


