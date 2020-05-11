Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5661CD4F6
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgEKJc2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:32:28 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:58951
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgEKJc2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:32:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUBJ58iZjzLg55Tli4Flz0T9jFTjxJtaalpZOVxirPQK8v/pQBUbcYGaRjKt09L4NZKLK366SIIPvShl7mr30KZlkPbEZpovFa5hYmes3jven2AdPQQMt00jv0CpafkEf8CZf6r7r3SLilZabn+3qmELLKRXFNTt6Sl3qf+nVJxL+9OVigRiFjZtSlRTTV9j9HmgU7tRP36hiX5LptJ56BgwpMbXDXt3my44IlfZZ/VBrE/0TnUxxx4njQKS2QITlogoaWCveHhSNoLAYZVKPDjkeRhfRZ2kdLI4vhgrwFo8801Vow6KH28CfNFcp3gkps6TDe8ohoQLFLhSmMRMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl64sj8Lt5Fs5c04EiCMqJ8wORSQcVqx7AMW+mwbu+s=;
 b=lXeMbvgCAayo54vyxF1cntY9cL0230SgRC9ABOKACKlp3o5/uOopeDPeXQfbxuUVJftvWD6RIaUl6L9eecKLDc+Q2uEAk6OaKzcU2kJR5XRT4FbBd1yj4Vj+UfeDy4Gku2l5l81ToguQhLtpaDHJnbM2ZD1CLQe8ajWN7wk4UEuW/0QXMzXLDC6NIJc51LBAfCr0wuS/McEoQET8leRXHwyo+XTzUNDHaN+9k9cLetUBD6+9UWjiyfh/s7nYLQEZo7+cktAU3PwCMShZ7qLm6AD9MBdtfj8z66ADFQDPeELaQ3NsF38Hz+rmPOyz7Frak7gWh1e40cwcsQpey0mubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl64sj8Lt5Fs5c04EiCMqJ8wORSQcVqx7AMW+mwbu+s=;
 b=DQt7h2VSbAT8SDTWxz2gcC6nxTQrkeseZDWcSbt/qVulDhZ+7lWjsB02GRlDvDUt0YoaMm9anztfWMfTBo6O2ASUws7Jf1wkTwuoKz1XOR0ejRKAkwcBRMMJxUunvrGHYAgEirLfm0OS5c0W8FwmoTCvp/pjxlnJm1usMM8REDk=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6637.eurprd04.prod.outlook.com (2603:10a6:803:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 09:32:24 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:32:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com
Cc:     will.deacon@arm.com, l.stach@pengutronix.de,
        martin.fuzzey@flowbird.group, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 RESEND 01/13] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Tue, 12 May 2020 01:32:24 +0800
Message-Id: <1589218356-17475-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:32:19 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c32cd4a-2217-450f-7039-08d7f58e3625
X-MS-TrafficTypeDiagnostic: VE1PR04MB6637:|VE1PR04MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6637263E78A6837288D9AD9889A10@VE1PR04MB6637.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLKXtMXxMztKqzNhsya3EMOpZbd15xTwCoK6vSqdkVfjoHpt+je8PtU05uYy80Ad1pZEucXzDTR0iEZz+MhrZjvq795F0ftzuJRfaxQA+8dk1OJjJOLCxqQeY9FBQgk6t9wJ0mZeUBidTkdzfcoljwMH0BiiJ0C2ODQi2Gx/JNSPGMUf810HzeKVnqKNYO/cgSrb7+MFeNMggyFlFlFlFcYgbMzcAQ+TBy/TIYd/G2ioAIhAlf/0XQhECXp++9VgfUkNI+vlM4ZqmrhkKEOXQw8IAh0tR8Z4D3j7Pv9+3n1bwRmQ3gy3JsXn7bi+qniw1pKl/psh4ib3r131IOE4PAoSZJC8QXTlX8uS8ma3Csri7MG7Dh9dfev/QdjIYc8tFPGf+dTwmJ9CVCoJwgHFNcqXnMt5qhdBpP2ZZFFSkDlV6/c9MXTomIXcC8cBfEMKHzolrDmeuGZy5lfJAW8qmCqMD3blRifJk09o93PTDYvh2vOEmEYfzfHaJI4LG6Vl5k1IpP2lNTvjQeXpJ5k7SsB38jZRVP6HfI6AQKe8cy7KNSKJ/kXSErORLTEWItINtcwEcntuiC3kP/274+1EKVL9cNWQXflZfWz6hY5Jh2lmzR1e6It1hL4OgiHAlzoC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33430700001)(8936002)(26005)(52116002)(6506007)(16526019)(2616005)(186003)(956004)(6666004)(6512007)(7416002)(5660300002)(2906002)(4326008)(6486002)(33440700001)(66476007)(8676002)(66946007)(66556008)(478600001)(86362001)(316002)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3FLvKC9txymVDcCGdsdV97Gqvb+L+0WNvblF6naBgq/TV2jGBUyhc7l31dttCssaiNCxjOgdZ2eG5JGT5eaiKQJYiy+5L5rBjqKaMG1jfKJaUq044AJCaNIUhX/nQRFJg+CIbOJB8NSqfNqj3hIsaaJNrjs9v1uTRv/VBOEc47R4gBsEQP6V+oWX67J6KEijADseAOGf7iBrhA3yMKLxBVPPGScF+MGLV3R9zdL+srxF4EAXvrQSZ3SSdUjpET4k1gT4OddTsHuTAaa07VJdgsOypN9W0g+gKUeUmV30koPF+oneUvxcVbcIvOHZKNSjf9O7qNDEgBooAGRNPfKeTXqc88+fm3hT8ZSjw67FGniPaQJiJlaW9XbSMnyBkaIPgXE9N/BgYEUES6DUiuukz3zNVxPq4dmtsyOSTXUyB0Po0vrXGC1vSH0DWwHtd9HeqhiXTYktiNSLdFmbuhd19gRGNGQ/TFRqhuMuVqNHimg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c32cd4a-2217-450f-7039-08d7f58e3625
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:32:24.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brJ/qTy4V2uVrLfC5cRo9EQ0AP04hqx7a9/J390pnWK3t0476RXN+sLbfyPfYTsIFBicztYac8ZZSVrXpnIxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
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

