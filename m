Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3771041B2D3
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbhI1PV1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Sep 2021 11:21:27 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:23919
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241405AbhI1PV0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Sep 2021 11:21:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJQU159iLdHILyOhzLgaBtLQRK1pRi8p5anpMwPWF8P6zG/b8McAHLa+c1JNq83QsVnaC3dUzZaxLd6kNEtZh+JuCpSHCkC1Thh0suajNPomGoDbjyHmguxKTKne9mk/4UGiwsKCxh0eJ99Q+Ntm+6tEQpviKhezxVBJR097xLxBFI6oBMIztdd/u1+yMmfbYtJ3azpg+AsJR+iFW+t7AxLM2B5JbxrGalB3EV2iXxV4xIdPwi3L71/qb/iSqTtAZqwLX8B5CMn839pvqvpkzV9qUCLZLfd72536AGv2tFWghD5vYFcIs0TlGxoPIyTIMPjSjKwg+lstqF6mrG084w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U/J9Jxtg1ZhSR/t0TTLQkJ3qosQzIjuGrAoDsnxTPBc=;
 b=TknHtlNR5WAWy9zvQBHj83aaQQ/InX9hSds2kJfK4UR0A4AvJzhPvQetjiz2xFvXnqYGnl90k/Jc56SCRmCu+uFWYRaMZQmgvDzJGj5m434NLNgba/kJJhwDXA60ByraRoQ3QP0N9vmLWFWkbVO9/rA7mgRcIB0toNRl3slw0kPtfiXTfplwA1CIcF1NuH/42fbAfZmEQLBuxSbPj1Dri1Hs0KzldoJsTfYxWXyWLhgPy9aezNBaBAti5wBEkwg3uoTWpoeTu8urv3VPODvhW5qeFG7tfY5uYqhhmiJIHM8ec5NF++Vb/I6gwtjlNAO3a5zONU8CONi4ZEX8McQWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/J9Jxtg1ZhSR/t0TTLQkJ3qosQzIjuGrAoDsnxTPBc=;
 b=dHbMYGhaWIbOWkF2tHIdd3W8hwKAC3bDXf5uSTo2ZJUghNWDzRXp6yM9lz3lzsvVFLhpDLzoCiFvzxxBmtOL4CyZzm5Q3Jwlcb+DkT3duJK1O/4EcbW/9hQJxI5gXRxMHZl8mG0CFg2BX38GDcABs4+PoOAz/1EcW+l4Q/XrFLU=
Received: from DB9PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:10:1d9::31)
 by DB7PR01MB4396.eurprd01.prod.exchangelabs.com (2603:10a6:5:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Tue, 28 Sep
 2021 15:19:44 +0000
Received: from DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::d7) by DB9PR02CA0026.outlook.office365.com
 (2603:10a6:10:1d9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 15:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=asem.it;
Received-SPF: PermError (protection.outlook.com: domain of asem.it used an
 invalid SPF mechanism)
Received: from asas054.asem.intra (151.1.184.193) by
 DB5EUR01FT060.mail.protection.outlook.com (10.152.5.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 15:19:43 +0000
Received: from flavio-x.asem.intra ([172.16.17.208]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Tue, 28 Sep 2021 17:18:50 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/4] dmaengine: imx-sdma: remove useless braces
Date:   Tue, 28 Sep 2021 17:18:30 +0200
Message-Id: <20210928151833.589843-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Sep 2021 15:18:50.0907 (UTC) FILETIME=[2452CEB0:01D7B47C]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 956eb1ef-9b64-4521-1543-08d98293664f
X-MS-TrafficTypeDiagnostic: DB7PR01MB4396:
X-Microsoft-Antispam-PRVS: <DB7PR01MB43966CE6064A3DA8DBA0027AF9A89@DB7PR01MB4396.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGFwlnNzGC9LH+eDcST2EiN7KLXnb4yzwkHL3kwWgOKPIWN3ip1pmHBzxoXWFg61pxh6I703cLSea4viGFvxX1IyHcQyhrOKmP7geu1HDjzn45Wz7rNkhtf2UhVSHNOAt6s6m6H+ah5/tKte3b+xMU5kSF6dpxb+J7YIYIFBhF8KdTFhPNQzUw/Q41MpEgFtDTFfMR7EKdxX5JFQCHRdfVRgu6O5XEnZ3hsYTn0imRJ6oZjJWnAPiE/I601wZL3cjvsozCl4qEIegtn5anaunUW6ig0KJRmp4AylSXc+As1WTnw9wGuQkrHPaG/HmrM2OYgdD7NpDOUCI0BJBX6vKMisneV3G/i2f/eIH1WSf0GAzgOT1KKTyHrjrucpx/pR4+nZKPcH0cNIHNpGdVfRhgKPVyJRBZvKhesakROfxKN04/JlGfERGy7rtXwTmxKY0npIxEgqySnSNgoipvWLuadAXJ0gfrLWqM5TPNYVNhCKRW58zC3TmfU8b8en8kvUyYVCqCL5sJBo5CLZmMw12nz86xb0IIn0PApuqqokyHNsjQHgrzi6zHHOKbvZlOggFbwfhKdvxgEFWeCrXBXaWlIIiWDk+8pd9DwPuLaE65En/UuJfap3KiJ5ESzjJMxxYVjf+3hbdZfjePsTtr9W/euwnSq2Jdfwwkwe3DTMOiaf6enf9j+WEKuW0Fmk4vdcC1DRBJgz5iNiKMOnSaQvtVMq2B95GCl4fAw7rk5ai0Y=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(46966006)(36840700001)(47076005)(4326008)(110136005)(70586007)(70206006)(54906003)(508600001)(8676002)(36860700001)(83380400001)(8936002)(82310400003)(450100002)(316002)(1076003)(4744005)(6666004)(86362001)(186003)(5660300002)(2906002)(81166007)(336012)(107886003)(356005)(2616005)(36756003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:19:43.6538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956eb1ef-9b64-4521-1543-08d98293664f
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4396
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Braces {} are not necessary for single statement blocks.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/dma/imx-sdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index cacc725ca545..a58798fc3ff8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -741,9 +741,8 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	unsigned long flags;
 
 	buf_virt = dma_alloc_coherent(sdma->dev, size, &buf_phys, GFP_KERNEL);
-	if (!buf_virt) {
+	if (!buf_virt)
 		return -ENOMEM;
-	}
 
 	spin_lock_irqsave(&sdma->channel_0_lock, flags);
 
-- 
2.25.1

