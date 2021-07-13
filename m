Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085133C6E80
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhGMK26 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:28:58 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:55623
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235285AbhGMK25 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9QYQl+6fHbf+6AeqSZK899HqSymO3PvzSFdlwBxPPSwoY18/sfLbcMLCPaFgO/+WImozy74ocpGEv4kN4h02fudCRLi4nUlfYtd+x2op27ClugxPqiIpnEEomK4MmDIOMKUI3ALQPCvDCsADoKAVqqQ+juoNWOUuqayGwr9VYs9x0GkwK7G0eqrLocBWhD0nbi7ogahP5dNqgvc+fqJhO2jNQMJutrkGTzeX0o2CtcGDnGOPEuSVNL9Fz9PXQKFpI6uMZHmPk1Ir2LhuKgfPXonNSeUEQFVKJps2CNDiBj6hhVKaPpfDCbFHOPvDNfbhk8EWXPQ8eAVF7+CArsJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D2/Czfs1P7IlGvBqmpgpZj1U+vvrqQzpMQiJsL/4x8=;
 b=LlSuIr+DTVR+Pldl/undWtgi36knylMSxYm1ZyUPvnMnkAux2PLKOZBemiip396F250Alwzd5Hz9bfV4hPY3T3NX2yxrV7dQYTKgLvtmpnHBWMgUn+jK1fLNI/P6EMoEYStLK4V7b71z0UVs9D37HQwDSrt8WiUi3DEkXwBnnWDNJnSdOX6Qod5tJJcHD5qHYTUb5Nj7VpyE4duFrnZjqLVArChaUJYTHRDnx3c6BPs0vEk+xcwYnqhtNahg5WaTuPSxRrKmxgRcVeUrQtZInQL92xfvxE1V18IVh+zxjua5QnAL2pQiUbVxi6viHe+mNWxifwJ0Rw+5YzjlF16F0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D2/Czfs1P7IlGvBqmpgpZj1U+vvrqQzpMQiJsL/4x8=;
 b=dQ2kHwt+K6QH0extTguJg/QfQQ1tOy0VPZbYJzEmjA5aGNM3/9kIGLgSFn8ubAERcA3rmNKClajHfFQMPwivx4betlmaLkpWN9Dyf3cGRA1YJ/Ad8n6kgvgg7uiOS8fF7/oRZ1hIXCJQ++AZiV9C4eQIvY+rFzB43S3ZSr+caSg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:26:05 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:26:05 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Wed, 14 Jul 2021 02:41:43 +0800
Message-Id: <1626201709-19643-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:25:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9de4c7f2-86d1-4efa-d14a-08d945e89eaa
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288A8FE1B5B40EA1778CCE489149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zQcKeZcj8dhEZiAmEoMv4o+MgXKF16mcfCx4emFc5mTmV6pyae/qpVRlgmDo8dsdywfHibfY65dqAvyRlGfptRgxe3X8LFK7zi2WjyQvOeG74SzlO0m/VapkJauhaMrPDzyt1sKlWCiA3wEw98welyJyfVZ6hRUnd/LV5gwND7c+RiMmCxsR/VK+Vu5X8BiTjnYdXYHbLX2nO0hGu/Sj05L3edTLD7V5JIzNC+tVYaSMdCpKu0AVW0LxlXPIW5dyVskLvugaYPlI1TDS0nGlsQ4G5ZGi0M3LyIlmruFRQZa2Xv2BIV6feW5BVkc9Rr8nt4aHwTBHVAvsD2G7xH/u3+xo4p42LZQRCFYQxnUbpVc99qalNjyA6HriE4Oz+0VhrtuqWoP5J8kuJMQgQokr6DDUVeWisapz3gFvJdv8iH3ONhaVyNV6wUINPPa6tmICbfGeZ9H/syZMwiK9yrCyTEuzpReidagME7Ilh/VTH3iBfrLJGs21B/H7qrhpVmCJcDjjOLtVzwtH5I4ZasNqSktCyQg09pVVPHeN2ZzYCOUjhy9JHkAUc0c65utysYcxpg8rqkUJrQ2CWxjxFmQe0KHXkv95vml+O8+yQlev4vcmpC4lva3AnGyxyi3jrCkR5/QDXph405bqgLj4Lm69lpHThIC3cKZzTYG3EEdLaksf3eXKfAkDf2nu+SZ0Xm2RymKFIqvJsudkX4PZTBM66IqdOmh2Hg7wTdVSXBPCi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(66476007)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(4744005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ukQcSG7j3zXW5VOzGIE7DLktOAWy0cuMJ4BThMnGHc+mTvRuvC9K5VwlbDj6?=
 =?us-ascii?Q?Eexb2l45NEV4IvuyLfg9xVCYFTVypbqPx+wjb2iYXB14/UyHEu5A3VhAaa5R?=
 =?us-ascii?Q?VD/H5ryg8icuXCEnfqmTbDLRpx9LNPcSmD1BdSvokUr1jPSsxODVtt8c5zd0?=
 =?us-ascii?Q?9qMrcw1YyuXBwc/NfA+ZT3A6u6OyqH236bTZdlJ7Z5gy27hJN+8suDLtLwZo?=
 =?us-ascii?Q?ovrA+Qil4Y6clVwe3h1E1R91Oh7VA8HzY7h2RjOL3wZdOFI2UGP90R9bTrHq?=
 =?us-ascii?Q?8udrOXOoe7/Qe68wHTFUbsprG2ZNE+Q7sYF9QMyAeDSvn+xQpGLys+xVbnFz?=
 =?us-ascii?Q?SgmSghYsyDeAGXA8EXLgKi6usPFNSAWUAdqsSKWGxeeT4+goDjyhdh9L8M7b?=
 =?us-ascii?Q?NfYxzM+LWRHwndSShF8heyctwGvGzeVcfZ7DkvI+SPlUdcU8obTKOAvL6SW9?=
 =?us-ascii?Q?gyUSmD45zUbXX/eM6OfvczyLPG9jeM1xCkbG0GjpIH/oaZ9eBl4Ljgqfs64g?=
 =?us-ascii?Q?KvWeZPdLNH7TdxwpzQe2WmKRT078i/CfotbnwSC7vU2/ehdo/lwUPyDfBN6v?=
 =?us-ascii?Q?0ZTOQB9EfEj6gZGbYdo5em9ZcnBn1U1Tiv0wCIkkcuhambFSemenOn6UHWHD?=
 =?us-ascii?Q?kVDClo4jbMLQJJ+MSo0z0Z9Ga1V3cyD8zN34DImZj665WLuv0WkTCu/bJP/2?=
 =?us-ascii?Q?j5ulbity8DGTXVHRbLoiGjZZefQbcf9XHe2QSPi1jDIMgJAUx/S/+I+7852O?=
 =?us-ascii?Q?fvdudQpTIG7PKi2kDiiEBRGpXVufDjvTPp6Ew/AHfPjkjtUUUdVyN5tz2RpF?=
 =?us-ascii?Q?5H0shKNqTHAhyr8GVxOMEoQsKTJ2Gwh9O1on5kXPjf3jskG7B4oiXLlkBfdM?=
 =?us-ascii?Q?V06NJvjqlJaA+up/PCIxjQw0/2mKFQn6yqITj3WVjIz12PQ0BYwkvwt1bj9N?=
 =?us-ascii?Q?toN02PoLhwslCRDlaJlF8LEIlR+skZRMjy2y3xPreUe+hsxYWzZ/dAr3UpX4?=
 =?us-ascii?Q?NCZEjZ4UdvnUYDml6ZtumSf/pUeCnaeWBvDX8bK+xtlpD1MKY/o/dXEkexEG?=
 =?us-ascii?Q?NlstvKR2dGWKDIXr92ANWyEnRU9tapqi6XQHBN3yj2W5mxYiWN7C7N23h06Z?=
 =?us-ascii?Q?bbv5oRFFI6uFyA6t6QPomdZm0ooNLY0O5x36fWjwdSEj80o0KjWeIPUFFsBI?=
 =?us-ascii?Q?YU6sfJQPu4qpVMUCVWR92I3AHfmhMePSQn14t0/9ONQtt+27e1kewSV8vgWp?=
 =?us-ascii?Q?Ffa2Ekmke1D03K09kY35FZdE3YlK/EoXhBmwLJaZIEjK1D5uYeGGffUkA25Z?=
 =?us-ascii?Q?QqRvdVpzxSXj1uEtoNmBwoja?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de4c7f2-86d1-4efa-d14a-08d945e89eaa
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:26:04.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zptVrS5cH7TMvVRhjgWvQNqg/yyzM+qncVn+j9DZ75NB3gQcFXJuYltCUobFxM6f21+OMxdOV7pVGEJI4NfYLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 639a783..4cb2e84 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -946,6 +946,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
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

