Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2125722C365
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGXKiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:38:20 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:49672
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727991AbgGXKiS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:38:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmVY5MITVKgmkwgZGma3xTZPKY0fcum7lVaOXENzVykM2b7UWb/8os3KNR0EQIp0+JsaDEZYM0lGxLFjaUyIjGYBn5J5iULEOiavC0NqCYDKjMaZkeB3FoWRi02n8Kiyic7XLQ+yqD4QHWto1bRZjdCZaYtDLiAe1KVLrGLNbCoaK73neaCD/s9HdlHJ2WPUnrev2wfx3xlCo4+xtO8CtQFblkSQqm9pf7wSCAwIrcLtVlFk0cG9aro8kckI9sfHrvell+iS1dkNLUgV/V4qeshVkWg3rkDUQCsBNppMh73Lw/Jz2p3iS6XYzwMJNyjxhwQVucNEDs+1vxxCPjb4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=HMXiciakCylmHSRRFqzK8nqkhsQiwdG6K6a8ovcLdl7fkGpR74BCjAmC6xcnMk1cdsleeS0gstyi5dBY3/OsxE+3cl53I5kXhbGj+yVnuGgCmThtKtcETAkEF02My2v+7T9TCW2pXdwikxXGV7h4kxgXw6F2IsXvmkWBPuv9JYLIbGXZbG52ULqOyQ60LSy9Vgof6sBCOf2nRWAYW4dbT5bjmC+eKlsTs0GBy8jPeFaD2XFsHDMZn6XRIXNE2tvNATTknHmy06sJoRplvDHMwtBVNVGDQTFPjgTr1gKW+8QqsH6PAK41mpR0HF8f6aGlKh/E2M5oORwdTc82usntIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=pk5bIdGaPvpvJpL3YGPFLXpPXSxCFUFDALwxMdGxlVr5Kw8vxOzIk/9ksda/jVmkROWR5y2Jez43/cuos3PAoM8L0QjN4ZN9xQMFRUU2xdBHK+W6lcCkedF4Qr6l8FxE0O7F2+BOk2Vt6vKBelDzfgLN9T356BYzRGgNcx3g6NE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:38:13 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:38:13 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 11/12] dma: imx-sdma: add i.mx6ul compatible name
Date:   Sat, 25 Jul 2020 02:51:24 +0800
Message-Id: <1595616685-9987-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:38:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68d5d591-b89d-4994-1acb-08d82fbdaadb
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37105A58BBEDF19C8E09E5A389770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsM3bMuEreoOVGTbH0uU68lUb7meg3r/Pt9JhagGUEvFVbmOj1ecWBuJeHLp8CoeUVtZxo73xEJlSUIGsKMCI1yUSMesx5p+bg8yKB0UBsahlLD76RED0b84Iq47LJuViIyyHNd4wyjhqDBN0XVwUKoEw/6q3NhA0UXItyz7OLBEjdVIz8Uo7zfaytLj3QWSgMfmdjvi+APfW22mAO7Hnkx6VKVGLW2fT2wkVwV14l8o41wT9r9BDzp/pIYEyz3io9ic0pVRg8VsUuNXK3BIBxu2/fXE7eUwoDnXcbRvzDVrg5UVE7T8YEqvYtqsTE1Xj0o+23lvYyWXxmHSuc7Vrz9PulOB5SWCeU2H1/4jkkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(4744005)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6blbqbqVOi+TkpW1uzYZ9pECg98Sz70RsA12fYCnsdhcXtEOekt+H+jsnO8eex6hAV1DSAukiHTVMPSyENUsFJ2mSWGfKkQ1LHsAOlBEh361l7m6ZVvTLvMW5ndGjLgYxToriFWswnSo6yuOcfHxXfn8IrDyudPHHwHeCVcRaSA51lBtUw9T6UOVSUc1f+Zi2cRzGqWnw3VYgBBpOD7XvCOxtvzNuImnk7wDI5D5f7tX8F2DrBk4nqrdfIXCJ7vm7nP3oHFUAiSl+drW26oW2x+iRoF2XC0EoyKOMoaeL1bULQekroDdW/8OdYYGozHgBT+WigMp89L4GM5alC0bwdIXUD5Tk8/Yo3AFD+YxRxvQWxAKJdTpO/Py1yfuNjrPKmd8CC9jDq4VPgWRgMMdc/84zR+XicIexC2d7jNRJq1DxwqfDxw9L1VRTcNgLQwLvSyK2oFt2PSfIpFWMIhjyXGCjXQVA6D3QhSpcy5Z8Yc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d5d591-b89d-4994-1acb-08d82fbdaadb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:38:13.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaJIkXN5ecx+nUUTwSW0hZUCiE4Xnqkc5+CWEQ/P7XQUnwKDwQeofPsSLBrt33j6Z82/07Sv8Y5s/rzEdNGKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add i.mx6ul compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index c9e9740..12c316f 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx6ul-sdma"
       "fsl,imx8mq-sdma"
       "fsl,imx8mm-sdma"
       "fsl,imx8mn-sdma"
-- 
2.7.4

