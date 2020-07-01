Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4B210902
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgGAKLm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 06:11:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35204 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgGAKLm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 06:11:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061ABSnh084771;
        Wed, 1 Jul 2020 05:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593598288;
        bh=agoOl62X5kjJPhyzlY82tgWIM3qgGNUjrKwRVHPlzF8=;
        h=From:To:CC:Subject:Date;
        b=jAFzfVo3DUJdZ8jYscNme/PpgRWladXNIHkrXS973wcWFsWpD2ikU4R8kSpufz2Hw
         u7dG5xEDTyU4TDOPNCxXMP6WJINbaVTrhes1J281LqVhm6m4hC/0RZhUW4HV/xZ9PH
         noWNn4H8nz1F54dBkqKoJlb3kKXgRRWoH+55S7RA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061ABSnV065295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 05:11:28 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 05:11:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 05:11:28 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061ABQDJ045392;
        Wed, 1 Jul 2020 05:11:27 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>, <vladimir.murzin@arm.com>
Subject: [PATCH] dmaengine: dmatest: stop completed threads when running without set channel
Date:   Wed, 1 Jul 2020 13:12:25 +0300
Message-ID: <20200701101225.8607-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The completed threads were not cleared and consequent run would result
threads accumulating:

echo 800000 > /sys/module/dmatest/parameters/test_buf_size
echo 2000 > /sys/module/dmatest/parameters/timeout
echo 50 > /sys/module/dmatest/parameters/iterations
echo 1 > /sys/module/dmatest/parameters/max_channels
echo "" > /sys/module/dmatest/parameters/channel
[  237.507265] dmatest: Added 1 threads using dma1chan2
echo 1 > /sys/module/dmatest/parameters/run
[  244.713360] dmatest: Started 1 threads using dma1chan2
[  246.117680] dmatest: dma1chan2-copy0: summary 50 tests, 0 failures 2437.47 iops 977623 KB/s (0)

echo 1 > /sys/module/dmatest/parameters/run
[  292.381471] dmatest: No channels configured, continue with any
[  292.389307] dmatest: Added 1 threads using dma1chan3
[  292.394302] dmatest: Started 1 threads using dma1chan2
[  292.399454] dmatest: Started 1 threads using dma1chan3
[  293.800835] dmatest: dma1chan3-copy0: summary 50 tests, 0 failures 2624.53 iops 975014 KB/s (0)

echo 1 > /sys/module/dmatest/parameters/run
[  307.301429] dmatest: No channels configured, continue with any
[  307.309212] dmatest: Added 1 threads using dma1chan4
[  307.314197] dmatest: Started 1 threads using dma1chan2
[  307.319343] dmatest: Started 1 threads using dma1chan3
[  307.324492] dmatest: Started 1 threads using dma1chan4
[  308.730773] dmatest: dma1chan4-copy0: summary 50 tests, 0 failures 2390.28 iops 965436 KB/s (0)

Fixes: 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmatest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 18f10154ba19..45d4d92e91db 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -1185,6 +1185,8 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
 	} else if (dmatest_run) {
 		if (!is_threaded_test_pending(info)) {
 			pr_info("No channels configured, continue with any\n");
+			if (!is_threaded_test_run(info))
+				stop_threaded_test(info);
 			add_threaded_test(info);
 		}
 		start_threaded_tests(info);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

