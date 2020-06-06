Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD651F0762
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgFFPVm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:21:42 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:4772
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728863AbgFFPVk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIpCHeYel/Bav5B6+NMB/TezoMnCSvBwNQufwiWpsSK9j3IS18//6YDLH3/dK6kRqVvxBuoEE7uFzrkVeTxSaKYKAqUsCCihACKJx9EqDUfX4SFPYTIubiUBqvIp9jkBpv4fRHg/brEN6onNxsyjD5GRL1T0Po1UZUZRNgz8RozSAdcrI8uSbF6ZtHUPMgnkLp5ZJz5HDrmJI9ZFD1JSlxwH2WBioavzd2VPk3vMHUIZnxzAvLw+5Zo1J6xvBMqC35c8j+eBX2JTabgtHdpSlWPS9769Qy1dknB2l20LVwUrWj9tJCKBDlncQGJVfCowTcbNr7e8ZkqMPmnFH63LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR1u5QVWcsTcn8Rv9kigsA1HCSXIoglRvxRKA0j3gMQ=;
 b=Jbwp6av09/hcY1fowZH3EyHTsA74ntlpsgAhyhDAkJs9rT/YUzeYMcF7+wxXA0UVv9UjiQ2s/2ubaf8H56GDShu7XoVR96ij7A5h5ak7NE74nJ0MWPIFc/a9kEGeuRCeBGLH9pG5ohLGP+tv1Lg3hLPZSmZq+qbYsC+vge/YoHSjS2XrmF0J+b00xMrnfUVM/PKVbLOecF4F9WhFEvmlbhFsw0Adon/GYccplB0IAkPNs/JRW5tDgYPU5QYwoRnwbS4QtsD8DDlARFp2weUxPMH4mtha7vHEHhKXDheCRsJCwhVmvlkC9345XjClgIx3fXZ8MvdvQq65BYYGkBxWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR1u5QVWcsTcn8Rv9kigsA1HCSXIoglRvxRKA0j3gMQ=;
 b=dW6V/j6lVec+OZwT4b+UGLC/6WDRn1fhYNSYLw4c/gYEGeyQv+jAlCzLN+RxO2BCyhp0M2fBQJVZcbxMgs7KcXQuii3cbY6ZJhh8cqfes2cAA1FRoYkx6iyuFmUdR4Cy6uoSp1O8pz+44rcs26w7nSDiJx7iUznodSMvsMxWNHM=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:21:34 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 05/13] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Sun,  7 Jun 2020 07:21:09 +0800
Message-Id: <1591485677-20533-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9da97669-917d-4010-91cb-08d80a2d4c09
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6511528C9344885B8B56C2A189870@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX+00+Ula5Iic/7vVAfLu4CEwblWSECFojplIX4E2yW/R8EvTpE8+omLO3Ph37EymBkLrA9oyYyzcAcYARJMns5keXqreCfIG3pO+N6s7rqmN3EvoPF7TDdXGErNJz/ePtrb5tdKDCtD07AQWa/H/SX3OsCLLTp0Hbfd2HRgWwfA/w8mu8291PQhJlBRHx/xXp1BuGStMdQu/FuX29KkgFJIh6k0ptqpTh0JFkYOGlbhvD3+WrvV1pGFRDwwOfu9ulAk3CWaKCEH1Q7oth9M+SlFp/VCcWIUWvVTCrYwgtz84CUCiXecKv+zCGjcHM8NZSiWejjSYEIColXo1kH0g7glgAkYsOLCr3vgKoYi03nAMYL2v5OcB+4dLP8jpYve
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(4744005)(66476007)(16526019)(6506007)(66946007)(956004)(6666004)(2616005)(186003)(36756003)(2906002)(7416002)(316002)(66556008)(4326008)(478600001)(52116002)(26005)(6486002)(6512007)(8676002)(83380400001)(8936002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sH9TYBzGmwAOCQmkmkshvf9dQSCmugCCSMqVbKNu/D9fi5htPFQ3HIojStVXFh8u1DTVovOHB23qkwDL2GnQ1KjvEyXj17mETVDmtmzPQqyTGDauF+vzWAKPcLkXPIfF5KWTZz6sXtZu7HpaJdwMLtc4otut2aBN1qimnT6q+clKxNJtNoeEFnNqX30L0nWZFEA5sOOqa+F6uTkPc1ck3wcrw/mqgTjZtuwHs8W5r1voycKhv/D+nQBdN0N7INZJVy2WO4Xg8UPaFjIrMmtBrquLXsJcI7+WgxENplhM+WE0t+Hn801VA3jMioqFUkeYWDPpLErYNQ4GcrKayI6k7rtibPcmY16krKtrbQp0Ii6pXE7H4L2OGOvb82FXKFHQkLRyZ+zyxDN69k95wNrfA+u0mrZvJullgKijzxRAsHoHebibZV+X0dkPgKzFbq8M4PuCoWLvEdu79aSA0q5Z9bgRuYZCsnqoKTyGlb2dDt4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da97669-917d-4010-91cb-08d80a2d4c09
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:34.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWYPc+ISwitbi1IJfTZO6yBgjXw7GPSfXvFyqlhfkyvw6OtAX0Shl922xhnvWXpur8E88uhiTdCuh/+6PskRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b1f61eb..4440ddb 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1137,7 +1137,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1177,9 +1176,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
 	}
 
-	ret = sdma_load_context(sdmac);
-
-	return ret;
+	return 0;
 }
 
 static int sdma_set_channel_priority(struct sdma_channel *sdmac,
-- 
2.7.4

