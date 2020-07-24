Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEC522C33A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgGXKhT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:19 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:9696
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKhS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmCy8F0C7o2jKZO2nKEkHTCUwzxlg4HkKv0hxGKDUQvNLafILwpZjM+0hMKzU3z48hSvkuFlujQqak7P1GmQ4v8cxkBi6bx18PZ4bBuDetd4Q1sAcbL2HJ2fRKZ66hp9XNc+5dihk3eYQC1jxxZ/ZYcHTb48u5wriSMDEYpH8uvU9bA2XmJ19QzJv1qvO2myhyOL1LJUajlyroXUheOXNbimYgRrUN0RnB6kgWNJ/yI7rp5XzvNceGcAg/R1RQ1DWzL2koLxPbJC5aDUPcydm49Hi0Avj9oq2L384nnK6h2ojuOHwrIs8apdOjDoz1IkP1yNVjODnJD/6O1QUdTKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=Dd0FnDmadFViUZng07lS8pLrDQAHlURW0NphXgeHAazLy0O/eyrWwLn5FvfwHd5tNfDuppjguD6jH2BsIh+u1fJaZd3SQ2Lr+B0j3td9qw1RA+alarGJL8wMFoVTP+liwWJuHSiLuqZisis22DActH3Qa1pBUF3DJZyOt/iqUee69m1hvD6toeVObZqZ3Zbw8tSv5sFWbgMf6n4IU1OpmEu/vOGTH0+5+PfI7PHMZJicnHW6vNXYNplwR0ugdAwmbwU6MjvHiMrWsTWdfRbS9eoMqlGO63RCN58CZyHVa6ViaIFNZY/s1qpfBx6HtsekwkQhlqu9rkEnZ+LD1TRzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=GMtHJ9yCGrIblEHo9JpgmVxUrDu5hOl+oaJExSrXXbfLqY+9xg2nTp+uzResNx5TZoILZEJLGeOxnJ0b8LxxjrpRb8V03UnT+sefCOeTvsMiNxGJs9KnI3l4cwTwQLC1s6PKPRLakWyWNR6lIBQlJFHXhg9ItszwnCOulpsbY4Q=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:37:15 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:15 +0000
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
Subject: [PATCH v11 01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Sat, 25 Jul 2020 02:51:14 +0800
Message-Id: <1595616685-9987-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:09 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 252a32a4-daeb-48f7-e291-08d82fbd87c8
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37103BE8731DD62516FE7FDE89770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9j1penTa7bvwP8flPQakT618aIQQWC3NqwSuU6Y9sukZanc2bl4bMqE+W3RSoH8wKIe5+SYapLAJUNwbiZyj3if9qclFn/A/keV7DO/3Lojmp7kvdoIdMmh69ss4efixfAwH4s3kirwCI4ag34WfOZE1pSse//Gnl18+eD/U/ELxPwR1T0rXg8v5laXsvGABQtWYHrkwnHG7EG2KIpfhNWkQnbsAQwxQu33oKKTD1tcZxTjaleO9B+9SDkCQFFZzOdnlRL6OwbiSHYuwfjE87yzRgARfK/wFtQEgY87+tWbl8OAIeSs48Vmp8zytR4C/aMLdsPNZcDATV4Vvn5JyGre3reDtr5+S5VPjfrIfzXNKniJNwR7sqx7m/QEfAzxh5xfDBb9lWwCWUA8OFKwwZy0kUM4N84IXExCFzSqoq1qf2bt4lOcBKKBFpW5zAZAbMmdb3GseSFTXM1jMl2RGujYPTogfQJnzSHmSbKB0Be0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(83380400001)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(32563001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GMYROg28qegConl9DtP8vkZgr5gA4shB62xaTQl/NhAOilZbtrEBYWjqFr594wV8shUT//AFhne/VkWUeydINeh+H9s4FiU4kqk8uKyABxm3Tm6r5+9MTIm23sM5teWDj2Fykr6APx8LwZljN6aQs/G7LYoFZiznyKCqWho0Q2TVvElxA2sYzSeyWICTzBNMkH865zGrulJZuFZfxBT6BqjAcND6z8RXx4xchjbhNgLxMvMtDQYtZYuwsU3SQqls4oJ6PwbDFdmIoZ3mnMgM3VA1pKUGoZymzf2VHkNQAyvbRPrPIrqlkZTKUbjtbTyxeScQS1/XwjXr396SyzCSFZuhsgRww4oYbfKxSLLTiRqTdGh+S61eACSv7u0r/M79Vj2R2wuJxc2F4nrL4Eo5KEWqn7S98YqSMwJyAwy15aJcGLmLsfLArtFzmKh+jKW6+irVE9KssY7P7MLwTRti/s8O1QA6usu8twONwgNaDs0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252a32a4-daeb-48f7-e291-08d82fbd87c8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:15.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPkegzei+Ihbgxah4LQgR1OyFJ07MgZM5yx0gG5O11DtFVQgRm7K1exLH3/FvwHq1npw8WojpeBtMsrdP5UHag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
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
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 78a4d64..afdd9eb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -177,7 +177,7 @@
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

