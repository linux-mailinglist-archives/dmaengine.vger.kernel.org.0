Return-Path: <dmaengine+bounces-3796-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E119D977E
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7620B259D8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456B1D2B11;
	Tue, 26 Nov 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b3O5saHG"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF11CDFBE;
	Tue, 26 Nov 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625529; cv=none; b=aElvB89JpsW/mKNeNPU941BGlgtFog16mvSTewSzpgxglxFDCKQgAXlG5Nj7HVuFZSCGQrTJzk/j1tHW/4EkJdc0rOdo77VHxCrA22yXD6vwTkqaIUdqMdiZoQfjMHYRUPiXoEX5IFyAlX/7RjXCyAn013s3qxgZJ+UuIINNWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625529; c=relaxed/simple;
	bh=9eLbBmVDRr8FiRqYc3AmWUBXlPkASUxroR/sxaycl+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IkR6PGv86AGXdeZ0gxg770/DOImUgaOiNu7JqNeBeAdnW2FNCv7u2r2uBlLSnq0HllKc1Cn7uJdXx2FmGrNA1dTMvwIgoMef8Lqdv/p09RVgA8Y8J2gLfMK/7Lg1q94uN6l/K+vlNQ/qaSIpjPCjzrTFc5O9zR66DaxWUxLjpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b3O5saHG; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQCq3Cg836590
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 06:52:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732625523;
	bh=9geHmMV6aN5aTzxUudRlkCnXCH0ILLe3Yy/urstaKwk=;
	h=From:To:CC:Subject:Date;
	b=b3O5saHGIP7YYBvPT2fieFEmuAoq9TOgZkvzwS87Uprx5HpHhlBndGJn559wpond5
	 q9s2F8H/k74GoqJ+s2ipkliODUPjSm5nE0pfHwmOlGT4uOrmG0UEgwUO4ZqpfBYIyx
	 KVXm5OmGNJZWHzdho1UHTWwV4NcXYbzvEYDSkyeo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQCq2of018836
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Nov 2024 06:52:02 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 06:52:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 06:52:02 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQCpwjn100089;
	Tue, 26 Nov 2024 06:51:59 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: dma: ti: k3-bcdma: Add J722S CSI BCDMA
Date: Tue, 26 Nov 2024 18:21:57 +0530
Message-ID: <20241126125158.37744-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J722S CSI BCDMA is similar to J721S2 CSI BCDMA and
supports both RX and TX channels. Add an entry for
J722S CSIRX BCDMA.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
  * Address review from Conor to add new J722S compatible
  * J722S BCDMA is more similar to J721S2 in terms of RX/TX support,
  add an entry alongside J721S2 instead of modifying AM62A.

V1: https://lore.kernel.org/all/20241125083914.2934815-1-vaishnav.a@ti.com/

 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 27b8e1636560..37832c71bd8e 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -196,7 +196,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: ti,j721s2-dmss-bcdma-csi
+            enum:
+              - ti,j721s2-dmss-bcdma-csi
+              - ti,j722s-dmss-bcdma-csi
     then:
       properties:
         ti,sci-rm-range-bchan: false
-- 
2.34.1


