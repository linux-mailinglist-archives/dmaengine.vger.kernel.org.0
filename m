Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E691294BB
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfLWLGB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:06:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39096 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfLWLGB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:06:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNB5eGN032255;
        Mon, 23 Dec 2019 05:05:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577099140;
        bh=M1ivEh29hpV8EdEIdoVxe758e9/ZAjRIkjB2WDihgI0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hYUVfMXssJk1iZU5wrCs5NLKOQ9vWueJuucBE+anjp+E9hthXch9UDkOGg+6OmbT5
         xTvIixaGdnlm6T6Eiic2t8zkm1IR7pn4oRIzFWof3/y0ExBTUxuRyefJo9cwdCyNY7
         zIjolHX0wCr5kfnrfQxj/kbkNnTCjFuNQJb++08E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB5eTs037678;
        Mon, 23 Dec 2019 05:05:40 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:05:39 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:05:39 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4eML025693;
        Mon, 23 Dec 2019 05:05:35 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
Subject: [PATCH v8 14/18] of: irq: Export of_msi_get_domain
Date:   Mon, 23 Dec 2019 13:04:54 +0200
Message-ID: <20191223110458.30766-15-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191223110458.30766-1-peter.ujfalusi@ti.com>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Export of_mis_get_domain to enable it for users from outside.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a296eaf52a5b..73017506ef00 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -673,6 +673,7 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_msi_get_domain);
 
 /**
  * of_msi_configure - Set the msi_domain field of a device
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

