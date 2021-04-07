Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7A3564EE
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346350AbhDGHQJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:09 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:25859
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237787AbhDGHQJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6I6QRxOxO0yYfmvexQQE7LSD9lFaSJ3aVUnBJr+1iISv7ZI66Kk5nJbBaPXtH94hTKJGlSNJWp72HT9DY9ZCUfAFEIl4xu2LZlyBhdaGqn8pq2ole8Nplxw/QWDOrAvqIxLd/vcxK+oHxU5yB2nNDuViC3xOfDFB43VY3myxyNWDxEIFn/U6KXfyQRawrEVUHO0Mnw6pt3tV/66+LLg6eKaYk+3HOkO36ZUZ66J86WJ6KEzu6f/rYNkFTfxvFrEwiTS8j8F3cRaPql2x0jF3JcgOT0DmnH9gZ/gYN0lxl1Cs0rp+9p0/PZ6Dj5Tqhc4U6m5whpl4CyBRsMFds4HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxxWqYCZL3ulrwAp2tlBDwUh4YE/HLrn3+vQSUeDltE=;
 b=BfEeCBh9GcPLyqFRNuPCmRWBnqxF49LYY8hPLnAElzsp4X4yPt2ommciMpGxjmFHnjXZYM+uciH7DiemsAYa6oVgltpCOAYjUo+oiGEqiCLSedTDv1rEEjfIzCpxxTzJt36HcH0OlY6qvlViOVTFBjr92mOFiiJ7maSg0y4k3GTJwec+ZHy24Rmo64jk6efLz8/AUepsquYN94RAIVbv3G1F2HY6Nzcf5CIbYNR6TmP9+eg7zYga/W7MM7FchD1tWCmjfP6v3dvcMyNsXygdfIFNokHx7dL4208bBHn2u1pbGuVnNDD0z9W11gNTfRknFn11Bt1pvXm1y0V4Bw61+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxxWqYCZL3ulrwAp2tlBDwUh4YE/HLrn3+vQSUeDltE=;
 b=FE+lgtx6FRpFTkXaTDI3NbqVqBfodCm1OQ866VDkBlihXgWghaeDrZHfEYrz3y3jldx97L8N2z+uYuskVxOmhcX1p3wz/hC9699bLtQtGVN8WJCxKCu0HeZk3aUT5lVlj08TWz43FEW7mvsuP3eUxhM18qoa4RP0LUUJ9IgtHes=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:15:57 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:15:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Wed,  7 Apr 2021 23:30:48 +0800
Message-Id: <1617809456-17693-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:15:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be86e70c-435b-4f9a-3239-08d8f994fd15
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB65091BA3DDF4429EA430AC0089759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nGiXiCx9/uTcizftfsUaVxlMK6/3JBlJzJmdZt2EhItSCvqc7omxPIXDzv2kfN2Sz565mVFGYYThS6v4f9LVbMXZMc3I5RLHkIFF3U+grdN3va1EnSxCV7RgOh5R+IpRuWG5q1I7bHlJVDNK+kujQkHBPraZtrWjdkWhN8wtdtS0wHhm0+NKFr3P7fGZpb75avPylPygdztvc+/QdqRn5/PaByFJPZJBsPw58dbDrZ9/FFiJbv0BuqXu8thvvmpm2hjhYTvTZgrhnV6u1d6xHdvuPiPT7jAdg7lOGx4YdNRgJuWMNdMwB/R118McvNbRIlqCejLmL22qJDVB6etgG93SZeTnj312FeTASevv6isakdordQgIU7m4PJeaZOWbcT4Q77CXWVfKevoy1ywBvN/jd8CgOgKduEvAOBO0oBWd4amwkUO4goWVTR5GvzfxW5vT7/+8uFdpkYXw/BuElsBPKrlcJ1R8KSeydS1uVvKS4VnWydihpgruL23vAF0Sf1pd+aFxthIPeizpz038ZG/qcylmU0VQ3u6qj0HTGa38yTBLIovMx68SaZs4vOvk/3FDKtKSJ1C1x14nz07AXohb1uLNxtuD+imrXAgEw0hNJwZOTt1CVp/MCwyQfcFhWB0E7HRZSKb8qgCjSiRguv7BdwMxF8WcDet+04SHeD6qSSHwlrsRbDbk1aqfxCnjvQyHdllSOHCsJtDEpOXnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(6666004)(8936002)(66946007)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(83380400001)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kEQjzvJx09lpXNbeLTg37xP5vTGEV3c95SvJK5pnfBzXt9Qct308cEI6ftZV?=
 =?us-ascii?Q?TQSr4vjfGiA9aNYTfv+FqkUg0snQYLkuw/0TEgb+boRACwWPI/DBV7/DlRS/?=
 =?us-ascii?Q?4HSEJ1UnO7HR42Q1IEvKt/rhkwSIstwMbjViACjOo3xBY/NgtJ5Z2lASQ+3l?=
 =?us-ascii?Q?8T5fnxq/XgLlh6zPfuB+ZxU1JVKxtEbgtEzc633GvishRF+0hUdC0BAB8TcT?=
 =?us-ascii?Q?s4mCVlRXUCrHjWKaPNR9kDcLY4llaAbYaFseXURWRAFggh2cMWDGfIebqw2q?=
 =?us-ascii?Q?vOea42pipdpxcArnd/F0EZrjLKJGBq8Wwl12CFgtbIkqYRTeHeAl0LWxkVvc?=
 =?us-ascii?Q?AXMHH+ee/VqOBAEoa4DL6kIY+penmzMPaKSclCfIg+5pa6XXLKoLRnAuK3A0?=
 =?us-ascii?Q?j8liZPvnoaZ36O5EIR+EAEBImYWhT4TTC/4Ak+YJP3T+CHXl7ney/VWIwLDQ?=
 =?us-ascii?Q?+21nC8O3Fv/j/wSJ2S/hEIHNg6qaIqDh+QOE4Xd+dGB4c59k7JWkkkGLAoX+?=
 =?us-ascii?Q?iMtauEZ6/I7MjyCWPUkwH41Yph6LoLJrHv33NI39VUfL0v4SudTG4u802NzC?=
 =?us-ascii?Q?1WJQxIPXqPa+QFKmYzCjYYWeWMd3TugWQUfe+VLOA9jfOt1VmCVkjofM9M17?=
 =?us-ascii?Q?sU0KZ9SBsn341KNurR7q6i0KtUA+hpQqwVqTHMl62yxJwXqvdiUKS+rHM+z+?=
 =?us-ascii?Q?Kq/93C+Ev2VWhe8MrHWQKys/Ga/Ch9Se+kCM2VTQokNDEDhjH18NorWB4y/4?=
 =?us-ascii?Q?Q+zg/1Su5x7NhfXRb5s2UP2ZZJFsfGofTuYHNt2CMHVp+ikck2+Dpi9+8Nyr?=
 =?us-ascii?Q?4PGJuco1sAJN1A30CkpVr7RV2kIU16X9bTgKooGU0PzrY8ukDoRqcFwRjcCP?=
 =?us-ascii?Q?u83oXCGn2dN2FdwPGXgioNx2kc6FgC8ttS5o6F2phxSuFv38nQlyK5Y+vHIZ?=
 =?us-ascii?Q?wxxhen2zHTqX0aLTSXKAK0Blf028resPdly5hyEylKqj6S4V+bGK0V0Antew?=
 =?us-ascii?Q?OKqYIy/w8qD/p5KIEE9iwEJYK8eves12CNYPFfdI59fBstooWFzFgOIDbpr6?=
 =?us-ascii?Q?+0yFUOD/UiD8vpbyZjl2pISnKByTqyK/Iw4TcpvcTnpcAKsasbMpG86nMMql?=
 =?us-ascii?Q?LSy7c7eYnZBVrq7XYsgpIDnouSVPxGfkswDp0798Ctdfy2kpyAdPhGtbz9Xk?=
 =?us-ascii?Q?WUJ8JIwPX+P0Qe8sZ+daNMRTLKS6vnbfldQQUlcfmx0hYI8xFoMdPANQwJRI?=
 =?us-ascii?Q?gP6NjvvFlljrMVRsTr+Tbch00H+b8jA1gVtyePFQ2EieOmhmBYR0rfkFujb9?=
 =?us-ascii?Q?JQ2v2tCWOtUUzCurhR10THl3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be86e70c-435b-4f9a-3239-08d8f994fd15
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:15:57.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gys9lO9UOcshbGSGoZa+dsyX5M5c96dmkwy7qvzdtkyN+BSNFjP7pDeSbY93k5fECV8OGWMQksd0FbOOQDJTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Fixes: ad0d92d7ba6a ("dmaengine: imx-sdma: refine to load context only once")
Cc: <stable@vger.kernel.org>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 02f8584..1c636d2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1107,7 +1107,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1147,9 +1146,7 @@ static int sdma_config_channel(struct dma_chan *chan)
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

