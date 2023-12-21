Return-Path: <dmaengine+bounces-602-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9124181BADF
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4880A2868F8
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC4539E8;
	Thu, 21 Dec 2023 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/KAYQSf"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A366360B3;
	Thu, 21 Dec 2023 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4GfHcT29Temo2xT6aNKP/UdlXlFrjqVCIvyrT2zvnjkdO5LNW/vpJ7xCA+tYAX5Lny6j6bai1ULv1mabf2nBHYNw34E5fm4omQRvBCDfwB3HhmBb03srAr0JLYDX2Fxk7IEWBhnQO8aPthA7ngB6SN2oegw55vIBD4wWFkrCeOrF2jlfDezmzEuCjpyNKwNVXE23f0QZtBdlftLEDcFkiaPb8K5n5ERgE5JWEI8IEzOXUrrOo4z2YiHA7vAaX/QbBT++tm4xu6L4Ey1X9uVC0t8TTsy7lSYzKTJGIPxPJzjQDNlmBRahSsptD/EWjtI3FLrMaz+Ixac+gYefIq90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xcvea8l48fy/Lkp7JRZ+cvnF0wmX/Jb84Zlt0T3xKI=;
 b=dLAZMLHipUG9mMVlsuIx+QtBeWz4n2Nm6Z8IdhZKoqU7vccT2BKCMI3lB1WEmC9nD5Y2FShNqH4Zo3B98k2WCRZYyEn+Rv9FMln5mc4uJYuNFzXqtaDqb692ibTTfd88Z2XDelqBxsbCA+4yNQLYtiiKd21vklDJo9Y0otP68hCPACPA0xRqp2Fry4DgB7RFmM304O2l7zEBdxXm7fcNSJe8m+T8sspArAf+ftxnwhMSQR7IEk0euX9cgbsHILM15rej3wQEm2lMRWeMVmcvHQxkx8DPzqSNYeu3FW9ilzilpvW6LyGLcgsEQt2Ytkz/qmuuj0xW4gei6vZxLXRogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xcvea8l48fy/Lkp7JRZ+cvnF0wmX/Jb84Zlt0T3xKI=;
 b=c/KAYQSfcxPK7+W7OpPdpcmOKBegEtfN2biC7yauw0Fix957Q1fEBLbw1Wzfl2cpKc4tdl631IasB5tqTs122/b1ij0w5ruaG5y/FUpfpfb9WGdOrE+YXf8relQr7S9C/lBnqdF2h2XYIjQgMsYPdHT5+keU9lYedGnkFW5BTrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:35:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:35:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: joy.zou@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v4 0/6] dmaengine: fsl-edma: integrate TCD64 support for 64bit physical address
Date: Thu, 21 Dec 2023 10:35:22 -0500
Message-Id: <20231221153528.1588049-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 486f4851-4c54-47e8-4e07-08dc023a7fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nVzQEwZRHNht514B+JIa0SUFM0OWAyFh8RMUF4kHWtcW2PHFBSucTEDXqDSPvrNrpcyyjrr5VjjLa22UG9jctkQ4mRAYzlKq1hTmn/ol+3gDxlc2NCu7mKWF/lUVQa3VA9FUb+2aAr8ecO8Qgu5ImIZNiuGk6RXFRG1i1cCSGNrP56XELBLVY9bzHXN+zmjGKAGJ3FMDHRvK6Z3Yh9hAwOa2KACxNVxeXNL/Kh5QLtrQ9lV3TvJbkzW4nnIZE+yS3K8QgAkojsRaqvnUZWeWgb+mmTfwVWFRzCYrt1WlfuF7+gfEYerirfjFrpOOmaZ+CBzRdEisID8a5/x3FBftjom99G933YkD25lw6tnNYhiS92AT9VN/LugUIbXggcM0SMqz+qn8cXXxiddZbTTQhO15lH6tRuaMcFrx4sB3vFNQGZhY1wwWumbfZar7+QS/UfAOsWCNe/AatupnJSwYwR9suKgPUClPCjPxoM6xeIvr9RMnkzaJXB3irduVvlH9edfdqxRGWqnIVy/oOEPaS8pEpm88vlHFA45Q8nd2g/38QnkuEDRZwIRK5CUN/U46vcS63WgnP4WVYZX1B3zzjH7o4p3C2p1pJK4RD2y4zqDxzXfOVj8a2sB/NFaLX6EWCVrsHIgJ3ULT/MhMoyFowAmOYYkZDz9A9i2oBFJXCSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(1076003)(2616005)(26005)(6666004)(52116002)(4326008)(83380400001)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66556008)(66476007)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2mTFuVsc0CkVN564pDEigiviRHutanCTfQuR00b0YCu1+XeRI6SaUDVdgdb4?=
 =?us-ascii?Q?gDRprE9yGPxjbM2N5NTuTIZl9O3AClQqiuyKdWvL6CGKMbS4ygCejOZtDMG9?=
 =?us-ascii?Q?mab26I2FVaQnF18eyvvzAaKXj2VPmODQorGHupD69P5WZMZ72HOz6IegSbkd?=
 =?us-ascii?Q?skQ0VTNn4M03HPkC60B49AQmuqfaJ5+reg5GlCXNMsQKNlf6rOiG70I5308i?=
 =?us-ascii?Q?xoONGg0NFt4W4L0k93jGs83NnZmJnLYARlupef/IauLE9CQwLzxqJXYjeBj2?=
 =?us-ascii?Q?JOpk0aFzxAiqCe6wnRwv3ZwaJZKrOIGQY7qEC+dBMDUckmpup5gmYFtMp4LH?=
 =?us-ascii?Q?CnqJ+putJ+n4v8CFyEysYY3IefVC528yPus1IaugYJsUByEl5IjnXGxrtMtj?=
 =?us-ascii?Q?Fx7ZqhRhRNyCKPTTnWMfU2BqjXQPkQ15+FgxuhtY5A4JeAO8ps3t2axxMm1t?=
 =?us-ascii?Q?6lciV4jjbH5PJTUk5OvYOzkv1kmMtLcaTEBml3zm3G9scHjKyVDhxyVfW+Va?=
 =?us-ascii?Q?s445SwQ0/FmdCp+PqedCNiA7O96RAsLzDNMEvkx+PZYwwoLXNOQ4TCQ+iw8m?=
 =?us-ascii?Q?MmMgV6HZokxCXVEYTlotw4eVxDu1lZBuutrSzIgW/XU5Q0Et6+htxmUI9O0V?=
 =?us-ascii?Q?2uBQG5ob7rfMOcDecGkBW/WHmLQA4yOgHajumfQt4vggxtMme0huqu6wo1Tn?=
 =?us-ascii?Q?I7tA9OXpEMCwMnG3uktC74gM9Nw5GzxXp7hZKLzc5B3F81QwMZZJsl/BpmkY?=
 =?us-ascii?Q?jnKQZXKr0IHFJABNJI55Pt7uU32nhP308p93byo+mB016yk8R3Rpolh8qGUV?=
 =?us-ascii?Q?e48lrDQwZas8yXU2da7aAqKyJQVRM8ZzKyL1Nd+Z0EJ1Hgcx/WoxVQQ+XMx8?=
 =?us-ascii?Q?FDQUOys27xCW8MQhROukI7Ypvha7Nlp0saXTL3wuTKxYNZYmrl+7BpPTxJtK?=
 =?us-ascii?Q?NPcE85mbH7C5lIVGXzs7ucZzQj3PAk3UUUU8d9zgYNFOMw/HnIzzjMOiMsjB?=
 =?us-ascii?Q?hRXLdAFXaiHV+qq0FI9OV0UIKLpzpes74mggn4NqasnZnuqfyhc738CuD+Dz?=
 =?us-ascii?Q?xWwRBde1XkOYEx+AlabSlAzmlgzJK5RQK6/eXKp4v5zmCyqYuY2YhwBOtaHI?=
 =?us-ascii?Q?sIrz1S2jUw3sfmLjb2ntW5fB9VWBxqC4sMKgSeeSYZrJSBJ9jyCwC9eJL+lv?=
 =?us-ascii?Q?gXp1bb6ridvHMQ6GV2+m7Ky/nbF/uBreO5k+bnPYC08XWVQNJJsBs39H6wjS?=
 =?us-ascii?Q?P/AigQ3X8FP/YS9hSaaVUF/y5D1Jd1NlUadmzV6IKu91ATEtA8MfwQlmwb1v?=
 =?us-ascii?Q?ZHII/J/0YtHK4qZJdu4DvDMjGiJIKW+0LbnDheBLo3BBsCon2O6PEL4Vb7hs?=
 =?us-ascii?Q?kAfIOEACQqEVn/O4B6b3G+JkbdS46rkSIeh2m8qSoP2NgMTbaE2/D7KEexMs?=
 =?us-ascii?Q?WiQqTnpXymo6TBmngPnII4SlFKTeohIdStvrP+nRnDv0YV4mBY3syZpwRhAg?=
 =?us-ascii?Q?Kfkuc+01VEKOT+vlndtpv1kKkD3RnZlL8LuKzaEBQIN3PInWCzbtNYSNcqqh?=
 =?us-ascii?Q?Gs4x0jplKBYSAUGDE8s1eYlwX0Qg/RebCAPhVhNG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486f4851-4c54-47e8-4e07-08dc023a7fb5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:35:45.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDB9z2GnRh+bsGgDDR5FerpPl1ERJMAeKeai6OM26H/BNkAiHn3nHhDiO7nCVhDNJOgAv2MgSSQY35gM8MHCVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

Change from v3 to v4.
Fixed tcd64 type as fsl_edma_hw_tcd64

Change from v2 to v3:
 - fix sparse build warning

Change from v1 to v2:
- fixed mcf-edma-main.c build error.
- fixed readq build error. readq actually is not atomic read in imx95.
So split to two ioread32\iowrite32.
  It needs read at least twice to avoid lower 32 bit part wrap during read
up 32bit part.

first 2 patch is prepare, No function change.
3rd patch is dt-bind doc
4rd patch is actuall support TCD64

Frank Li (6):
  dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
  dmaengine: fsl-edma: fix spare build warning
  dmaengine: fsl-edma: add address for channel mux register in
    fsl_edma_chan
  dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
  dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
  dmaengine: fsl-edma: integrate TCD64 support for i.MX95

 .../devicetree/bindings/dma/fsl,edma.yaml     |   2 +
 drivers/dma/fsl-edma-common.c                 | 101 ++++++-----
 drivers/dma/fsl-edma-common.h                 | 161 ++++++++++++++++--
 drivers/dma/fsl-edma-main.c                   |  19 ++-
 drivers/dma/mcf-edma-main.c                   |   2 +-
 5 files changed, 223 insertions(+), 62 deletions(-)

-- 
2.34.1


