Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC722C34E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGXKhu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:50 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:61931
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKht (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKB1PZdNWlTNDquewRfb+VTDIYaLq0borL8l5VaE2YWyetPpeV/fiFxAz2IztTn7s8jukqJY93vXn4dFXiQrbnK18YY9d+/DXZ1ErwaRrGtFTm4EtgsTW/gJcEUbUeRvsb96m7l4lkQB+gaNYj9DRar6N3xkoO3EQ4dLBj/PKlRPXmjie79B5Tw5c1+j9WLgYqIT42NCxVSd2NlTp4oQwpbVfnD3IiQp84/doik3ALiUDvhHX5A0Y8we5CTtJwUkr/jhAR5bBbJUdFuj/QmTWJTFa4bkUYsAmTyGDXWGcnioKWB+zW6Y0P+kvg8MbHDNVUkIWEr5gSqKEh42zzVEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZKBPwv3h3QlWAM24YnwpxiPhRgJFyrgSksGB04gjZs=;
 b=PN0filUqHB8of7DPgLAftHmNnDPxFwlAI4bxzeleJwHNRXavsBkjBA000N6zDbn1yjR39aM48Wtxr1kfcYquL5BRQZXBjtGdT8CKVYEcjRQc9LwP9JIoEn+rCMbIzxynTTE4IHcscVDCoWgnckile0TIFSXbcs8pNjYC8TTEHKhkyxOTW6e6ggRz1lxt52Say3v47mahjljfo95qJ8tldDDViLIVg/bscpbj1XV3J8TvQhfld+rhuCj+b2ysoFEV/mukzuROeeK8YjLQeNRBvF0UfStnprEgjRZJGAjronMv9ay+QAX7gjGgsCi+r4EQC8hfogTsaHa2RTWA6t2I/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZKBPwv3h3QlWAM24YnwpxiPhRgJFyrgSksGB04gjZs=;
 b=Qx0eL06QTpcxMCue9PnwEZU7eV8m4EPJkQPwbGQrewVLZqew7yEEWrE5y3ELppraODe2lrf+v7cAlr6iNuhLEG9JqRZdph7oo4RScTG8sAcJq83Ho7ZqxnTiCvXxvu23wU2qrynkqpVU2EW4XeExZA7EXaeRRQCzOz7TGyzy6w0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6125.eurprd04.prod.outlook.com (2603:10a6:803:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 10:37:44 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:44 +0000
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
Subject: [PATCH v11 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Sat, 25 Jul 2020 02:51:19 +0800
Message-Id: <1595616685-9987-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9e41508-7e9e-48b2-5e83-08d82fbd9987
X-MS-TrafficTypeDiagnostic: VI1PR04MB6125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB61258406477E3059CEF0936589770@VI1PR04MB6125.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+0mTTPTSOCVvUQwM1vvr2DDLWUag/vvoXXBqlZ/QuF0mZ7PR+zFMHnL+Drb8qc9FUswt4UxjdhllgGekE/4eFwWaDmZzjsmrVUxfeedIUcKGmk72wdkeFWuMEoprjmEoHRfj1SFL1Rz25J/XmbNbdnIPokh1TIs6TKTYDeY7yWm0OP3EViUiUD8ftsGfYlzjgoXSLktlWB2ldjhqMolWV/3fSLsam/ItK2OCVxvJab4HfBifgaap7a+R39A/e5R/su560vT613SzNZ0ZBrePa2JDGvq2jATHUZ7/GZzPgntNdiv/52NqXRnZjdZ7aO0iWncTSkNy9YQMspW9446OVap+gV1LmRiw+WjB2n/UgFXTKtl52FAaUDMd9IixY3l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6486002)(478600001)(8676002)(2906002)(8936002)(6506007)(86362001)(2616005)(26005)(956004)(6512007)(316002)(186003)(16526019)(36756003)(4744005)(4326008)(6666004)(52116002)(5660300002)(66556008)(66946007)(66476007)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2QKqR/n45kf7Q4VIf8uaiW1W6YUQeUTzrfJyonTROmwgJORDTcYqgzk4rOC/U39UqtSjG0wFDcU2XPx+LqiOe8t4lqJt5wg8imtgHSr9d6+Y/lL58a1VBRNRpnKNB9JL+DxuVOtmjqsWn9bRtt/Qo1ngZpduiBPYbhrMWeKV6FWttd16Hwxd/+YSp30KlhOogSTQz1+fR7n6icgV0gCABrioIB8KsJQ/nkNfDVaF74Bf+WNZoZsw2eWUxZdYp7Eo9208kO/T7Dprh4zSYGEnj0xiOve0wGam9H/LDWzV90gHy6YCL93s/rzr0sTwBgnt/4134MSI2yQmU95lZA4lJTUnXPNcTFjfpGqgSlaAtiHrLY8cevDmTrerD0BxjFfw+LpTOW/gwpq4clb76bftPea5RHy0mdClEXMVSlaI2xOmduCG8GLfWTYdkuYXyz+9EmmdNOYmz82cE4meGlTLHybwk4fQvcnSWexX6G1jdvk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e41508-7e9e-48b2-5e83-08d82fbd9987
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:44.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhPqkxxt8SKAC9dq+Ji2tFieF33SgY30PjTLEMubfW0xw6ShdoMaro6PBO9xXdQSNIv1Uql4knb+5q6sVaxp8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6125
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index cf02c3e..d5d5d40 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -922,6 +922,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		sdmac->is_ram_script = true;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
-- 
2.7.4

