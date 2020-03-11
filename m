Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8E181355
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgCKIgX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 04:36:23 -0400
Received: from mail-eopbgr30047.outbound.protection.outlook.com ([40.107.3.47]:1323
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728648AbgCKIgX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 04:36:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GySC8doXZGORfYpE4RsJbWhk9zTH6rC9HAPsh34l/+2r9LHCnLOZoO4UkLBAVHGmn/pcidfJNeqHLwENnAFhV3cRT0E6iyky3IYtoLTAdpDVZicRhoWjw1iR7Ua0ttZTt/0z1S5zKgwZX/1PGTPhigFQQ/vjQOhxQMr79zhhzFwqob79Jy8G8pSBpiRuU6kzh6HRwrver8+DEP07Di7QbeeCIFVEGivw2c4Szpsz9SOrbhAyqledYxxN1P84YHez7DDSXRvxM8j3I/5c7jnDugKvJnJ7ja+zkwIam7Albmhm/5GFCi9R9f5cC8XcJP1aEvhsjYtmCq0FYu5PkZTjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=M2hunbdEPTnJLfMH0hMY7C0S5Q9k9lzfNHp5fWDZq01QPZ1LzBErOlR5aPgJBdoJAXMKHFw28+h0QS0W8dckUs43k1T1at8I69aG+vXFRqP/ai+L3WG3OfAoMoWqo+VuD60BpsiPvT00SdEOk6TGYK8YyLDLkVYNPbVKFwOk5+gFV7zuoYZbm937kUxNYHjsBaoC5LV0uPArEVpuIPRCZ01y74c/ojvwjy93BGs5CTWcOofl5HquSmUu2SR0ak6EGBIcF4lGteYOwajedyeqKQF8REIFb2Xa1QdoJNQoBIfTmRZZWPQZK8YeBcHi4xb2uUBeSTQ5/qcsRA1r3cHVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=sr+rBfkfLULJbcv4iJ05Aay4PyiZeUf6xTSKwEihnNBqer7qZrOuoIkvRovFpgv3TADArP7BGgD3lJNZ3NgUBxyrBZd4bJPgNn0gxZiuB/QZJnH6CBxzaefipH0XGBYKzTZs0HZaJ7WREdC3FjrXH0LFhyBd4yhnlTF/Jcj4CEU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6462.eurprd04.prod.outlook.com (20.179.232.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Wed, 11 Mar 2020 08:36:19 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:36:19 +0000
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
Subject: [PATCH v7 11/13] dma: imx-sdma: add i.mx6ul compatible name
Date:   Thu, 12 Mar 2020 00:36:34 +0800
Message-Id: <1583944596-23410-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 08:36:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0eb12153-e07b-4f6b-c18b-08d7c5974523
X-MS-TrafficTypeDiagnostic: VE1PR04MB6462:|VE1PR04MB6462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6462504DF65F16611901076689FC0@VE1PR04MB6462.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(52116002)(7416002)(36756003)(5660300002)(6506007)(8936002)(478600001)(66556008)(66476007)(66946007)(6666004)(316002)(2906002)(86362001)(2616005)(956004)(4744005)(6486002)(81166006)(16526019)(186003)(81156014)(8676002)(6512007)(26005)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6462;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCGIbNPiytEedIPdAhSzPM1X0FqO/hg8eK/hrb9ml8W/ZuIcisbTpbIqhQbzi+VUEfbg1khEuC1CQ9dMwmXx5zrkkenJOKBbNNmtIKG6t+og0VnISu14bTqq4jFr9kGdC2IfCeKoeGxjnkYRJRhfKA/KMkTWdKPtZ6L4YzjcnfnjO89dALPhT7a2XcYc20cyw2BgTbN8lHoroQsLcuXpnKxU+ZzBBwPXiLxZFsS24+T2E79GoT22zKR3ZRMePr161ZjLntrhqwfFKigG6syXFE2FoG4BDx2/ojDhC0V5RuR+CqGtrOziO+nve9l8nviLtp/4lDnLT0T7ahFpandg0bK9GM0tNcSEndO+fSKUREy1dyzYp0WCTYhcY8NRtd9S/Lb3vTSZVZkXLCoAbcgxsJBv+8OSaUIU3Hd7J9SfyIAm48nBYJmJxdAjnd4cfF2JjP/T8HRqyEXzolLsQHoWP7umhSfD1+D0xMUbaXKmraNfKw97I4VhNEDwlKEe7E5o
X-MS-Exchange-AntiSpam-MessageData: R70EXTXFaxvoZ3oMdHSYdulSKIEEoxG4oQu4v45e35hMPEd1U3VfDPmdSeiPxV/I+nk6/Vc5Sjui8NOMgrV9tCSp7p0KJGMmPGzH9btYLPBOSDpSWp6DBqRyVxM64p9NIkVpsTfU1tA7vaGBZPVxRQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb12153-e07b-4f6b-c18b-08d7c5974523
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:36:18.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9HDH1xH/oo6TMNoSyoDlT2qxnMYlAMR4xacUX3X8gA1o0j6yrm4N1Oz4pSS44MIcOAPfdQtnEwdJ6ANAJ1gBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6462
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

