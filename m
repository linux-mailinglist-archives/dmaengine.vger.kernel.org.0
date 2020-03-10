Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05817EF12
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 04:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCJDao (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 23:30:44 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:59975
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbgCJDao (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Mar 2020 23:30:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGMntEnzoC0cbmjPUNzST50r6U+Aa5EpCnEko8Ug0YgURjhr6jeADQsHZEhT4Hi5oJmOIWbt3dFCsoPc4Nb9n1lUeDOKVeUREEoUjZ315FRJXWJ9GWWd3RExLU2hIfj6z8WijqwwQP/WqrmqZhswlJ82Rtz0Ued2uvYtv9sOcURdMaNhv5wsb8tj7QG2tmGLpEOM1uzpsujAx7s8SW8fCE6DeYpLi814owIPD1vFXDWcCa1OpiFhdH/l3pOAk1o/j2GTSDw8AlEjH99L/j/aKlllOVukuHxQ8TvlehDPd9cvrDmAX2MkBMLjumIA/p5B+QxbOHq8BCmwDBrmRtwC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXqvjYhMA+8lQNEtgB6AalVcZA/kOUialyupoeyjrrw=;
 b=jcBKJFtWwLFcpZoWAsK6snFvKvga5pIzXwVIIxvP+zXoqFcwoli3FLYAt1CKF9xjozrjrjiEwOWReM7sOuRLEF+tj3ymsZ890nTNOetrTveABn6ayYatTTgUD/sJBntXEZ064hFNoW1c/tdNS4SVnKnsmVvjYV9GQeWG2jWuerHDMMx5+C6H8EoAn2GmOM2v1Bv9HlFj5mhuiMUzX1XYTPHnJCE2jCNHDCwf+zhabRRNEmoInfAf6hoSOja5BCkaZREJa33FTf85Pyrx/3XweEgMWhfRzLqjHcTVIPND41HsyVcJ75waFInll9I76BF4tvqr2jy+hDWfD6Qxxa118A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXqvjYhMA+8lQNEtgB6AalVcZA/kOUialyupoeyjrrw=;
 b=qU0sPcbJDT4qbJH+EUwHLJ/MXX88FZ/WtEw4A079ygAttsZ28HhQFYNNz8eQOLkFurnBrqW+h8tdriQ3Z1r5oOT+bkDN5xFgs7F7yeYRj+dMWpdqgAmuIeJZmR4vxOQGXlcY1uCb1NiIlZJlZ1cQDuYBAqMKB4VsOoiplFIGxak=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6621.eurprd04.prod.outlook.com (20.179.234.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 03:30:40 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:30:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND v6  01/13] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Tue, 10 Mar 2020 19:31:50 +0800
Message-Id: <1583839922-22699-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 03:30:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1f1ab44-2323-4f28-11e8-08d7c4a3681e
X-MS-TrafficTypeDiagnostic: VE1PR04MB6621:|VE1PR04MB6621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB662175E81E88910B95D6C6A189FF0@VE1PR04MB6621.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(4326008)(8936002)(6666004)(8676002)(81156014)(81166006)(2906002)(5660300002)(2616005)(7416002)(36756003)(66556008)(66946007)(6506007)(52116002)(316002)(956004)(26005)(478600001)(16526019)(186003)(66476007)(86362001)(6486002)(6512007)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6621;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcT9y46cIq7l4syMKqYYBhlJJ9KLyNW9SVg9JPJf+jlhUQ14RTDDwIUi3cIU5UPCNNDXffCHcICaBddceBeOBIfggQXd16WwxBOhlh6MDD8891mNR8pf07RANXYFlOTxchUQ8fAlwSNL50dSTJf3sXfvn1o/w6ev0PfZ0hzkqECrin9BGxM05xlHKKv2+lSHmczcXqoD3Y/nMerM2Yg9M5CdcGY9q+4zbakVbj3IE3wvEK9gzYQi0ZyOPSjGUewFK8jYyNl0cwCdPE2r7iA418HqZgjXer6u+jgNsrOHk+J9tC3OzJ8E/nxT1lguf6XDgXzXPyETomfOSiV9Q3pFwBNO/L6du/uZkLqYusNacl28tX5msOatvUJ20IfcoAQtnXkVJ/c9TCzq9Miz740ETs/bYbrYNFLPI4gTAN4Jb5YF1j4NcwJyMa8+2DrOvIHxEjg7uzxlCE/GWIfiJcQWSNKFgrRfyycT1SMjYeHQpcxvsqUsmlf8jmB0YmByACO/umXkNZop3fqW8nbbx+IyM3auRFISSUFxnNVZPxORiPMETRJoxMwH6kmoSQZTjWCpDfoHdjHp41u9xq9xM2Fa6zcgU7nRkoCtyZUFTeXENME=
X-MS-Exchange-AntiSpam-MessageData: D9rTM2hFUXExKaCfgIp7fkW2D14KLEXfz6RBWXUhmydgXkQMXitGwxdu2chTy5ho738upQDdqERDc1C3H2ZUolqPigct2eL99hwsuVR3jfYBr8zcGL+QNCZY06uc0fzs1iLrzDTM0fChd8DaXUI4ag==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f1ab44-2323-4f28-11e8-08d7c4a3681e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 03:30:40.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOgSzgSi9V+Czx/Y5pLZxc9kKn0lnub2dcS55mbthvASED54uqfdhZjmKa4Jn72DyoW673vO5zRKYXPPBOTvJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6621
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are two ways for SDMA accessing SPBA devices: one is SDMA->AIPS
->SPBA(masterA port), another is SDMA->SPBA(masterC port). Please refer
to the 'Figure 58-1. i.MX 6Dual/6Quad SPBA connectivity' of i.mx6DQ
Reference Manual. SDMA provide the corresponding app_2_mcu/mcu_2_app and
shp_2_mcu/mcu_2_shp script for such two options. So both AIPS and SPBA
scripts should keep the same behaviour, the issue only caught in AIPS
script sounds not solide.
The issue is more likely as the ecspi errata
ERR009165(http://www.nxp.com/docs/en/errata/IMX6DQCE.pdf):
eCSPI: TXFIFO empty flag glitch can cause the current FIFO transfer to
       be sent twice
So revert commit 'df07101e1c4a' firstly.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0fad13f..81f693e 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -175,7 +175,7 @@
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
 						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 11 8 1>, <&sdma 12 8 2>;
+					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.7.4

