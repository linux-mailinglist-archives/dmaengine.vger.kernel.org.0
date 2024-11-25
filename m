Return-Path: <dmaengine+bounces-3789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59699D7E7F
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 09:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6AF28260B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734018FDBD;
	Mon, 25 Nov 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u1jt+Ilo"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324218E743;
	Mon, 25 Nov 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525027; cv=none; b=FCtZSl+Cdd3DGpUhdZ8rKop92eA9XPOqZGOaXBgkYcAoPq6Da1JM2ZtcpChigJFkBKFyazF0Bqcv6+p2RwZeYl7n9yVpis6Fi1uV2xgVwIwVgIQiqJbprm+YKpToENae42o9Dnhf12Av2b+deumEbanQlBXo8siYqMlUA+jOhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525027; c=relaxed/simple;
	bh=89H1oY7n/jVmYUnepVsRNX/uf61S+3gSfuUPRUNkwcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZnJMAXaqoOmUNKzR0rlzTDo2SyaKeCYEgHC5qun7yU+ByZ9pWSXbECTQlh2hNRztk+gGgv3kz57VRRDFeWMoJekLSEdjFkRp85sRiWWXmJNJdNacUFV/RQEe99Zc0XDlda0m6Il4bHP+ZTxtUbulNYffnh4wKyqcHBDMsAKfzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u1jt+Ilo; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AP8dJIX640452
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 02:39:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732523959;
	bh=O0BJjjCQy7Zj+FprbmEr/wm97eZa4a7mYBEhWAQnj6g=;
	h=From:To:CC:Subject:Date;
	b=u1jt+Iloiunt+ZMkASgyfT4+boovhthq2c8it0Xnhmglt3kq+0F1bMyGCCSHzCtb7
	 tRVCKAqCFsbpeB4Jde9IxVmMVF3iQ+6401s1UyfV3WBxAeO3oixeHIVKLVPlThzbFv
	 pjwqNaKhY+5No4EWcepG/pzX9h7gkGU5ZLZw5MNw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AP8dJTX087175
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 02:39:19 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 02:39:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 02:39:18 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP8dEin127929;
	Mon, 25 Nov 2024 02:39:15 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 1/2] dt-bindings: dma: ti: k3-bcdma: Add TX channel for AM62A CSIRX BCDMA
Date: Mon, 25 Nov 2024 14:09:13 +0530
Message-ID: <20241125083914.2934815-1-vaishnav.a@ti.com>
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

J722S CSIRX BCDMA is based on AM62A BCDMA and supports CSI TX channels
in addition to currently supported RX channels. Add TX channel
properties as optional properties in the list so that the same
compatible can be reused. K3 UDMA makes use of TCHAN_CNT
capabilities register to identify whether platform supports
TX channels.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 27b8e1636560..c748f78b313e 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -138,19 +138,22 @@ allOf:
     then:
       properties:
         ti,sci-rm-range-bchan: false
-        ti,sci-rm-range-tchan: false
 
         reg:
+          minItems: 3
           items:
             - description: BCDMA Control /Status Registers region
             - description: RX Channel Realtime Registers region
             - description: Ring Realtime Registers region
+            - description: TX Channel Realtime Registers region
 
         reg-names:
+          minItems: 3
           items:
             - const: gcfg
             - const: rchanrt
             - const: ringrt
+            - const: tchanrt
 
       required:
         - power-domains
-- 
2.34.1


