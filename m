Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB31B2D93D8
	for <lists+dmaengine@lfdr.de>; Mon, 14 Dec 2020 09:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439101AbgLNINR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Dec 2020 03:13:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33984 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439067AbgLNINI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Dec 2020 03:13:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BE8CB2G080597;
        Mon, 14 Dec 2020 02:12:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607933531;
        bh=htOduzL7vjGqrjWzTT7IHR0XQC3lDFvtir2HfpFW3wU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XWHIhS+PPzQ+jN65m5gyiuJeAt3nI7m5aLkcihufZvNJfRgIqtqLT4IsMwpLllQ+Q
         tfoiRBnQE2HY9qGy/D2WtpFNyvW4a4aYYZmnLEpsHOsp6dDvHGCXPHyMpgs03/OQ4r
         Ka+n0YQ3+tk77+SvcaOtr+AqqJyhA0QeKqv7BJD4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BE8CB0X030744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 02:12:11 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 02:12:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 02:12:10 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BE8C6DK065906;
        Mon, 14 Dec 2020 02:12:09 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>, <kishon@ti.com>
Subject: [PATCH 1/2] dmaengine: Extend the dmaengine_alignment for 128 and 256 bytes
Date:   Mon, 14 Dec 2020 10:13:09 +0200
Message-ID: <20201214081310.10746-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214081310.10746-1-peter.ujfalusi@ti.com>
References: <20201214081310.10746-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some DMA device can benefit with higher order of alignment than the maximum
of 64 bytes currently defined.

Define 128 and 256 bytes alignment for these devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 68130f5f599e..004736b6a9c8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -745,6 +745,8 @@ enum dmaengine_alignment {
 	DMAENGINE_ALIGN_16_BYTES = 4,
 	DMAENGINE_ALIGN_32_BYTES = 5,
 	DMAENGINE_ALIGN_64_BYTES = 6,
+	DMAENGINE_ALIGN_128_BYTES = 7,
+	DMAENGINE_ALIGN_256_BYTES = 8,
 };
 
 /**
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

