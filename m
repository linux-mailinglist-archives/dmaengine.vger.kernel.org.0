Return-Path: <dmaengine+bounces-1906-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D158AB153
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCF3282346
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02712FB2D;
	Fri, 19 Apr 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fwutf3+6"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D112FB15;
	Fri, 19 Apr 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539279; cv=fail; b=DIzTMuOogNj8kbwHMwr9Atp6S0ocp+KvbnFxkhQP/oJRIB14nhHsRUI3LMgK3iwr8JKcZqKbKEBMQPVxIRyDCQEOMwqkTTGbI4ax/OCx8LHo9PcbqHkaHj4Un0/b86+C4WMZwLu8+GUurRlebxV9glIu1OmgofMVdeimbvc+uXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539279; c=relaxed/simple;
	bh=PjuIazkEfgX9mP/bwXFKUwikSIiIBUShPh5k9IO1nGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQgBqANihdnz2Qru3UdMFjd70Dx5QSFw1CNvxAQY96LMDqQtGanN8D9XTG5hw8NicpUWEy9kcJMXhif7fe4Kgqq2mRrSXxNNNr5drQ/QpCjCKw7hLjpLNzQ4/HJ6TjNoXaKacMDT+j+kX+SjJ3xueIv7CcnK8WBTg0tbJpwRM+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fwutf3+6; arc=fail smtp.client-ip=40.107.15.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X11P3bNeubFZsRqBfun+KPanFSZtLKG4IBi5ZC8Bhu570T40VmH4XF+kXnNJ16pQPSTzCl8GBT0eZguwFeA7iCcABYsP8A/uCzdmNgZdQSJ/R0XsUj8alfAXIBm2TE0cJfSHpwMMRFkMmog5C+7bsJZFIA0dmUKDvzMneJXQv2ozxIhgTUufTE2SdVQzzdN8R2QuBpoUQ8ajyezYakYEV7QUc1mzTCZ/vtpjPO3NTjAvDWHAMANUyqqSoXacrdxEeu7Z8Z2fNrO50ES7pld0JOgARx2JdPlMyF/RbwBy2PZYCViZgPx4lwEp8lsV1EPRddOLcgpl5STJsxqiEihFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbob5Skd0aZ0iLEPzrStt1DsImjOZD7ZLxlgYrgl26Y=;
 b=GqA1UGSAde/MXVarpdT8dLBUqgid75lZgTv8V36wRI6rcschp6MaX6CyEwSB0+Q8DhD8thXavZCIuamax1UGsMBDgpG5lVKQM7a0dTr8Aj6gxKrxQ/Nw/StdsghETeacFl9f7NfeaiuTq4R3TS4r1Nn6DHNlzIsBY60TONhi1pmUSvmmdqg0chrsZHqGZF9wQhSByesKDu1PPwOEQBzFJ11zbAWbQL3A0sPbUazXJAyGXo04v/dLAFTZK9q9EHeGyOfETnk9bY48j9BgVY5vnsb6rskuijfI6VjRamkXkLknjXI/0M+NbCWl7zwlTV8wKpYsA8CXfMfNL64rP4u69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbob5Skd0aZ0iLEPzrStt1DsImjOZD7ZLxlgYrgl26Y=;
 b=fwutf3+6ruvgjL36s4GLBiH2y7W0TmmOYYGaSWE8vQ9JlNNzbTP9lSoDBCjDAI7sZ/b8NOq+nCQwnwXXmMIzyWPCj7H4jnSEagbKXdiV1YNjVYauAGAxGv9YYVWyL43WSMx8uGXYmJZqfqMDAJgYLMdEaW1OQSut36yMAFcJhVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10330.eurprd04.prod.outlook.com (2603:10a6:150:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 15:07:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:07:51 +0000
From: Frank Li <Frank.Li@nxp.com>
To: vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 2/3] dmaengine: imx-sdma: utilize compiler to calculate ADDRS_ARRAY_SIZE_V<n>
Date: Fri, 19 Apr 2024 11:07:28 -0400
Message-Id: <20240419150729.1071904-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419150729.1071904-1-Frank.Li@nxp.com>
References: <20240419150729.1071904-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10330:EE_
X-MS-Office365-Filtering-Correlation-Id: 547299e4-6431-4d9e-e8a6-08dc60827ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMppfv10gNqUSjyHUT/fn0CG3RGckrt9gKK50BypLummq+DDaSd3sKhj/Pa5?=
 =?us-ascii?Q?t5Azk9eKmB0Ct3O0GIzLfErjNWieV5a/cAXMUy7R0aeWU5BEtvzKOpJF0em6?=
 =?us-ascii?Q?WDvZlTbtbY73KHWRC1da/By6+5tbpMpQt/hEnSOm+HxcyBLi7q6Tsn6W4z2k?=
 =?us-ascii?Q?Lkhb5KJC44ARAg9VspZm3nI9XRXp+XxThRHzSjTHNaejiSyTQp4inPXSnMXu?=
 =?us-ascii?Q?X/LaMzuxvkVaaCjGU0Axlxlof4mK1TvnMVZKspfflj5nXSTFL9/tYMqqd76f?=
 =?us-ascii?Q?MsXSlHZfj3+ugJOBBO5jesBTcFv9m1fIKeEt+mLE5eLEV+O+Ogc/07UKuxhc?=
 =?us-ascii?Q?WkPrrafuorWAUNrbLwf0FuFuy77RuVbrWkQvnTjjFVB1eA+Qixy0rUjfs2Xl?=
 =?us-ascii?Q?zIi6+6il53zVakImT89OIJZHqrGGqpJ2/mZrs1+Yu4B6gqErStC9wa/UZQ1B?=
 =?us-ascii?Q?QPhMW6XLC98PCXs3UDIKRjvn4Or9bVfW06brbcze2JVPm0qbcby0PJqq3d3/?=
 =?us-ascii?Q?T9uy8t1vXcnytE7sjkV9ICiE/eTqFGTe8+B6HHQ71wEv+mLyFdcBvwANZapo?=
 =?us-ascii?Q?kbCofPsY6zGbIFnqeZfLAKDD9w6VQM9KTIvnerJAKu8RnHvzR5nYkj0SVXyv?=
 =?us-ascii?Q?Uoj5yWuNhmUdrZPHrN/hbC5AVb/MWHUAMAXYGrCnHTfjMQ0D+Rt1CoNQ/TJR?=
 =?us-ascii?Q?8BiaxGZVNK1ni4ekTHQtbCxvWCfFMT15NyvB7UhL4PGHocndTvNF5bE7xxpt?=
 =?us-ascii?Q?bKjLHU1IeWdyHqCg08SgOgk91UkuwrDxUcw8tYl/B4UWtXiwRavwmGXUhXNG?=
 =?us-ascii?Q?G/3JxYqw6itFwKYXv6iKTb7vXG9y5z/fw0UxorARTPGTcg9rV1jLjBEj+Y9s?=
 =?us-ascii?Q?+HZte/BWR+7dZr1Y6B+hIMYqTy18qcDIMeoGDsi7OFsSTH8V69/7YbGK3zhc?=
 =?us-ascii?Q?mdv6pUQq9AECzftsFzelZQstBZddtWUZlqnZMdsCzHjAeZVcdSzJ5fYcT/Ni?=
 =?us-ascii?Q?0iHisCJ8lOBZjZmqpSRoU4XuSwIC5nX+OxJHkMAUucutj4xVpf9da6msaueR?=
 =?us-ascii?Q?VygjoVkqsW/mEJQ5GBKFtsgrW5Ax84tWteuO+q5D1Z6LuxyJwN2cZ0rgA1EW?=
 =?us-ascii?Q?Rd/JH78S4AoZ0hTASUctVNoU91EO4U8SQCyLaXStgtjHQRCXoHtCHw4zfxNR?=
 =?us-ascii?Q?FZC9dVAxVCPMYABNOe7LZTrSc5dgWZXasCVVAAWqAhplt5aq8E5bZQMJUyWk?=
 =?us-ascii?Q?Eb+/E/ok+p1Vgx4CA/rRnLxHGQiodtt2J6ulD5EHnhPYGdvwG+Ogsu4ySeO1?=
 =?us-ascii?Q?WV/X5LT9kcelk6jfmNBSza0jRpcBSb2gxIWWAGMoopr9dA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QY6c6/zk01VNA/GEIcosaydmTgREx0nSmTZJX2TTl/QRUF1yjLSh9ulSM41r?=
 =?us-ascii?Q?ADP4XvVohyzz49JBHh8/vyPh8Mfn9wG+3p0vbSszzco9wMouApa4iAWLfk/B?=
 =?us-ascii?Q?a/ElmJbFDF41OyqHBr17JLev+FIZWVe0wlDhXCN78FtGY/dxa5Xjk8hw0Egs?=
 =?us-ascii?Q?4eNkIvC7twUpw5f7NG2L+eQkegu9k4tKDs4KT3OzjDs7yYxrQ/g4vNWPqpvs?=
 =?us-ascii?Q?v9KFJFagY4BMXTxJ8g8telHRdpIR/k83BxGn9DuMrwjP1WjNnBHdwj6bBaQW?=
 =?us-ascii?Q?ZcgkIPBe6RW0x7BJtc/agoQxtx9dp8XFJBvwOxK65+neZDhkTzVNiGodxsd5?=
 =?us-ascii?Q?8gxej1+U5hFQkyOfBwhKyNzwhDmmwcqKwpD5IiVUxmMFmidJqrV+nPit9gMM?=
 =?us-ascii?Q?nEXwtRmu3H/F3Rx46AfC3gbYGy1dlcTrVqbOGrHN90FXPP+lK39lD9PiKUSq?=
 =?us-ascii?Q?mwMlovJZa4FzGSBafMpdQUfEg8HTDYYzrlm7gX18/jze/ujnye8HGsr8vXv8?=
 =?us-ascii?Q?oEZq5Ps9VPoiJtMABg8pydTuzUALHWRK9zv94yq7XDcpt+yqvNt+jpafEiHU?=
 =?us-ascii?Q?mdgrGHef3tIOTYXVgM1IYQUNC2zUPAZhts7Dt5Vo8rFN1uNDY1hfZOfLsu6h?=
 =?us-ascii?Q?wFhp/bOVroI/6WIGNyyIWcv9N7Dp5vqKLtaswP/PMebuCSWCcAuOYjlBZeXo?=
 =?us-ascii?Q?53WXcnmUKwqIc7ZCDuc/dBzpyP2nMZzJgvjsmbh1VFmcEuvqIgQ3/3gjOYxb?=
 =?us-ascii?Q?/V/37eKN0BRqOFgVWhdGUJlhov6OsvYjT5QdZ+VMKPtcEt2Xdftc4eH0buGj?=
 =?us-ascii?Q?/dDN6BvZxu/TA8NSktFPsZT1rymrmhBFj54COoM0E8+Jox/33rnP0Mbh07Ep?=
 =?us-ascii?Q?MVVtVsKlo/C9WytNh4SDN0Y+qaovmyXWzO+lBu2R7tG+dcrtv9ZesUVJYE7T?=
 =?us-ascii?Q?8z13OF9khsTA++PeVuU19QYIaGa9tJBd8TrwUtbf+oq1S00ip4WtSKJZAoZp?=
 =?us-ascii?Q?M8entODfDmOSwWVPHw8f9ZUK1CNDAo2opc93FBn7OkGzEHQ2p0nkZphkq/aL?=
 =?us-ascii?Q?7r1blMbIj5D5H5AiX84zi1T5KIB2GvEoCihwQZRY/h+qVAyfR6lbHeLhSOd1?=
 =?us-ascii?Q?O1ndmzO+jGFuV0g0HnPrTAhGtAjPi0jZq4EQOD3xgz9KgoSmLqS/1G1pPrGN?=
 =?us-ascii?Q?2kCeEG+mjILinL757flwTGR47FAplW4UpQJsiIxjKRflK/eahvWt6tw0bvRE?=
 =?us-ascii?Q?ELm5900425nb3nSGRY3RD+/E2GAhKim6EVoz0VFLZx1oFs1UWBL+UNAnGpPH?=
 =?us-ascii?Q?9gn3XaCTPMneS3CgNnZMiLAzR3e0pAF9GTkW3S9XBRrd+3UKDBCBZWX2FL1H?=
 =?us-ascii?Q?CHbZoseRVBM5v3HOJdNyC2j2HMK5sl0/F3l0pb2xIVosuyB49jpToBW8Xojc?=
 =?us-ascii?Q?iKhrTn/04hqAmQck667Isf1fW/fG/mZSUpvnml2zylMM88URBaeVXYcaVbN0?=
 =?us-ascii?Q?QQme667wisp/71Y5MHLfLAqitJa0JYifPoMa94HLq7VqF8anHhEyXNYYimoY?=
 =?us-ascii?Q?/Fbh1RgR4640jHAoIKVxkEBGM9itPzFxdDlGzw7w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547299e4-6431-4d9e-e8a6-08dc60827ba3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:07:51.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peAwbJHSKoknBAoiV4wa2NEmnwO3HTMlwKZOl/aAAqo84CAyvyjaTUjOU178JM+elaQipZu/LbU5ok2eciPZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10330

The macros SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V<n> actually related with the
struct sdma_script_start_addrs.

struct sdma_script_start_addrs {
        ...
	/* End of v1 array */
        ...
	/* End of v2 array */
	...
        /* End of v3 array */
	...
        /* End of v4 array */
};

When add new field of sdma_script_start_addrs, it is easy to miss update
SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V<n>.

Employ offsetof for SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V<n> macros instead of
hardcoding numbers. the preprocessing stage will calculate the size for
each version automatically.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change at v5
    - new patch

 drivers/dma/imx-sdma.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f68ab34a3c880..4a4d44ed03c8b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -240,11 +240,11 @@ struct sdma_script_start_addrs {
 	s32 utra_addr;
 	s32 ram_code_start_addr;
 	/* End of v1 array */
-	s32 mcu_2_ssish_addr;
+	union {	s32 v1_end; s32 mcu_2_ssish_addr; };
 	s32 ssish_2_mcu_addr;
 	s32 hdmi_dma_addr;
 	/* End of v2 array */
-	s32 zcanfd_2_mcu_addr;
+	union { s32 v2_end; s32 zcanfd_2_mcu_addr; };
 	s32 zqspi_2_mcu_addr;
 	s32 mcu_2_ecspi_addr;
 	s32 mcu_2_sai_addr;
@@ -252,8 +252,9 @@ struct sdma_script_start_addrs {
 	s32 uart_2_mcu_rom_addr;
 	s32 uartsh_2_mcu_rom_addr;
 	/* End of v3 array */
-	s32 mcu_2_zqspi_addr;
+	union { s32 v3_end; s32 mcu_2_zqspi_addr; };
 	/* End of v4 array */
+	s32 v4_end[0];
 };
 
 /*
@@ -1915,10 +1916,17 @@ static void sdma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 }
 
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	\
+(offsetof(struct sdma_script_start_addrs, v1_end) / sizeof(s32))
+
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2 \
+(offsetof(struct sdma_script_start_addrs, v2_end) / sizeof(s32))
+
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3 \
+(offsetof(struct sdma_script_start_addrs, v3_end) / sizeof(s32))
+
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4 \
+(offsetof(struct sdma_script_start_addrs, v4_end) / sizeof(s32))
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 			     const struct sdma_script_start_addrs *addr)
-- 
2.34.1


