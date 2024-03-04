Return-Path: <dmaengine+bounces-1233-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3B86F937
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 05:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EBD28111A
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 04:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6BE290A;
	Mon,  4 Mar 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uh+tQKjM"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D717C8;
	Mon,  4 Mar 2024 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526815; cv=fail; b=pgLOTdCVMRCjMzt2LoqUI7smqtTvnBStHNA0kbHw77/rLWi1iVy7D+os/NaTWr4w4r4psQVmWcbkdvcAtZRPI59ZnnlQxK0VGOqfGugV2OyPITYax1CxelS/Ud1EbZYx0NylLKYwof9jvuWkTBxby0dCnkoAyoU5Ty2QpTVwg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526815; c=relaxed/simple;
	bh=o0QYRSOkrqLDhg8vIviFJNSWkrPfiyBVIcr325f3rFE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OQH8H4MspzQpUOnoJNoRH7/PZBUqDVxLqlX4SCBE5C3ozDizrPuuUP0dNrMbzYpCllcEnq74tygA7mPVpMrkFlOIUx5dbXx9qaGgzX9fL3xY5vBBlNy/6INUv1s64Tq0TutPnqPEYjtazKZvF//gdbws2TKU0oAa7treW109SN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uh+tQKjM; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlq/56xJB2By8u6buUor2RAYq4NGnRwjA0fVbhJst2lUbUdj2bCJhZrdfG5n5bezZ8a/lInF6SVh5gHr0rUSLoJU3kx9G+yJUaEdJhffFAFhaEzqGz/OvmnFFPtqBDzn5fu4XPLm0ij+oTGjE0YTunseQXy5v85bu3S6evYN7i2ax2dXLQjZgAVIH1NLFMjsI8K/wNbYZVmEkkIxmJ4rU21TJlE4t5w+rVI0c1AvWchsYtGUshCnlTMBOUS7jxhwyU7aGLqL96TqSjvCRF4EBR+ZVvP1VB+V0jk5oyJ3TYfJWnGiZdbMum9u6SsUiAJ/W+yISQOoZWADu5aFHUDImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL0v/YIhMipp8GrsMjHJ55nMElctzoQJ/nfdC3bFfGM=;
 b=RGK3ZYcqt7WWNHUW0v6gdjkJjLIKDCWIdOrTpI8O9TwBKs1IgXDfhCEyPs4aIc0j+Q4fhgytpU3zZaUKuie+GpGpJ0mOFheJOs/tGp11yHcnFZ+/I22vWQV/KMFWA/HPB9aaowA5CC6I0AsJySGXUUAayOmwBtgzUa9MBq2x0c1iuEd6HGGEpOCKS5iq/QK7f6VB9VVnvdnPAVLpOefmejrw7exTaKV9s7Erq9Rx/EZcYc3qHGHyiQhlXIGFUi2D8ymCcHTBn8iTYMSke41s4lu6SUdyHaXL8WifavjKgjgUyc94yGAmlLj/nTbO9NB2LejfYg65PNAM1jubyphcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL0v/YIhMipp8GrsMjHJ55nMElctzoQJ/nfdC3bFfGM=;
 b=Uh+tQKjMb0b9DEVAQNmHaFAcAfTeuBlGdaWwkhc4SuNsBZ4P1c8H3KZoiUnhpP1Q7slhr8ct1TLVuENsbEvedULOWpYBlFjbJdXnk69Z/mJ2U94DzO9U/RqJoZ80z8Q1dMunX2vJtwY8R/kxETDAcU9yl88lcI1adDfbDcE7ZFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 04:33:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 04:33:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] dmaengine: fsl-sdma: Some improvement for fsl-sdma
Date: Sun, 03 Mar 2024 23:32:52 -0500
Message-Id: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVO5WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNj3eKU3MT40oLikqLUxFzdxOTUpLRE0yRL8zRzJaCegqLUtMwKsHn
 RsbW1AOTcEtJfAAAA
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Nicolin Chen <b42378@freescale.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709526805; l=1084;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=o0QYRSOkrqLDhg8vIviFJNSWkrPfiyBVIcr325f3rFE=;
 b=Ohna/1Z7BOmtpXQG4QGpb5CcqgDpfXFzJVhryyDu9sIR5b7qSuBOl4lz2N9jgmPJlLwIyqEGv
 UKZSvHbRe16B6WpESFi/0NHMua6Hv6KoytnkbFcuXmZPw/tN+CCvuXy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b854dd3-02c8-4582-e393-08dc3c043d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NuGF4YpLX5LkqVw1sdGDPmAepp9XHEvdFlLX9RgiwXm7xaRbN3y1WHsW70PKfikWE98JfP0PrDCO742HWMJ92Wzzorj6WO2FqRIt0TcTxcx5foaQOkJkxTpnmkwntFz3pWr+hEVCKGasJNa3r8alSczfZJxho1IQpjc+nFur9VoDXGf9lERSCAH8WasLiHw8rTdsHZoifBQYwbCd3aXa+Iyf5rnXwRUCZMwe1xUcW/LjDKW5QBN8KKazIaw8lk0ubhZpjuwaTczDxZrM1yQwtDzvMjIo1FQHXJksGBm55BetHm1Dg3gUl8y5kqj7tlU+Nx2W9f9kvNno6H8yRvR96xEcu96kM/yLVsShNgYlmnzq1A7axLtJ4cVp+XTj10zId8e5zSJa39rKIC6FKgzqERyHKsWqeT99UmGBHSr9zT1wjKs2jOxUu16GeOis9m1GlEH40qQs6EMsggSWqA4QRNlfcxqU8FkeQB2eB4jFXtK4IYKLnuC+TzPANyVtQd3x/sg/JNNK8n0cMIUvHn63d0nXJK89eOYc3WL7g4RAhlzgtMZ4lsEjznW+v1Iu0UHrqLBXbZCsZ8wvWK+RaZ0V0qAz8OyYY1zxSX6QHWZ6WK11cgdygl2LRkQKI2MsuQibuYQXrDW0nRQqQtBYLJEnYhWUvjQDEOXGlDszMMiScVCMWA1GtVzG3+P86M7VqEaAfuOmFISOm3lkLJCoh7+hEXCD4aBPTOqGcslXSgJAt/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3UxaWUrV2ZkRzRRK1ZoTjBLUlVoVUNtVjZzMXU1VjlzZ3hwU3N5TEd4ZXhQ?=
 =?utf-8?B?RWRmQVZqdGRvRE93V2NPNktVeUd5MHozd1B3U1luYzZIOWxWRXJpN2x0VlFo?=
 =?utf-8?B?SkZPUDdDZmZGeUFOaWYzeTdVZmM3aUZidjExRk8zMm1mSzJrbVdkbjViL2Fk?=
 =?utf-8?B?ZnRHd1RqZ243RmZJdmZvRjdzMmFhb3Z4Qkdza2phWG1aajQ4aW5LT2ZpRDZR?=
 =?utf-8?B?TjRrbFpIVCtsaVpRQW5mQzZIUktUbjJBMmgzSkRGZTdnQnZmMDJueU1Sa2h3?=
 =?utf-8?B?SlpQTnhkaS9BKzFMVWZkR3hQRmVnd0c0Y3NUcHNWc3g2QjhWTWtOSVg4bU05?=
 =?utf-8?B?NGo4N2pFWkhFSER6VVN2ZEZZdkpNMWdoTklLamthekdvZS94T0NqMHd0bmJI?=
 =?utf-8?B?RXo1aHhUZGdlOFNaSU5PSC85YWNIL3ZqQ2dOaEkxdFVwZlJORllsWFhEQy9v?=
 =?utf-8?B?YWx6VlA0eEl6Sm1ZdmFjTFd3RjBQTmErN2dkN1NNejB6ZnEzMXdxUElWM1NY?=
 =?utf-8?B?S1pUcnI2dXNVSk1TUEV1TkVrWU96YXkxZHV5azFBZy9FSmhJemVBbU9Rdm90?=
 =?utf-8?B?TUd5Y3pPcHNkNzluUWNKWUk5bmRxclc5aGdGdHI2c2M2ZUFVN1RlQk1GdkJL?=
 =?utf-8?B?YU9IRGVUMkp6N1RBNEVFVVFUVG5NbUZzOGJoakdqZ1NrSzVZK3F5WjE5bnN6?=
 =?utf-8?B?TDd2eHU2c0Naa3pjV0lTQnFtalc3czZWcFRybnFoSExVaEgxUzRBNDFFTmF2?=
 =?utf-8?B?b3FZNTkyQVJTZ3dHdE9zTFVlWTBUU1p0K1ZjOUlVbkZoR2Z5VHY1T2FvaXZQ?=
 =?utf-8?B?ZWJ2RGhpalVpa1lEMGsrZmptakVnajA2NUZFK2lnUlQ3WG43WGl2MVlQQmkr?=
 =?utf-8?B?WjVKRm5VcS8rQVNxUEg3bVNxc0FYM1c4M0hKZG9iRDhtNktQYXNDYmQzM0VH?=
 =?utf-8?B?Z2ZTaUFBc2NocHU5ZkhUVURNcDJxWFVsUU84NW04OXgvalplbHlUN2RVa0Q3?=
 =?utf-8?B?OXdYdUtsQXZmSlJsVFhBTXVqRDV6L2ZBeThJZnRGYzFpM1dPRitCMmpXK2Z4?=
 =?utf-8?B?YVY1MHJrYjNGVXNIZDkzSXpaMG14WnVrc0h6S00wakRBdTMyUDFSTU91Q2ZX?=
 =?utf-8?B?WHFvTm1rMnUvVElpUWJiQjRiVHB4Q01ZZ0N3ZG9qY1lhR2tUN3pMQ2VsNzRF?=
 =?utf-8?B?UGl3aFFtejc3TTF3N2RURVp5U2JydnFsMnBzamg1blE0T1RrdUJIYTZaRURt?=
 =?utf-8?B?ZjY2R1BLMU1qTGkrK0RrbGFKc29PVHV1VHFWdDlkTHdNRFE5bGE1REZFdU1F?=
 =?utf-8?B?elNlKyt0Y3B1QjRCaEtvT0U0SkRrVWhEYmZ0MXNJclZ4dTA3T1RyV1lxVW8r?=
 =?utf-8?B?TnYrSkFTOXY2NW0zNk94UnA1NUVKNXJDMWRudnVqRGdPblJoZmdoVm5BaUtH?=
 =?utf-8?B?Q0NnUFoxTFF1R1QzNUFHMnR0SkhkamdORXVkZDE0T2kvRlZYL0hvaDZEVG9y?=
 =?utf-8?B?WTlDa2QwZ2dnUXFWdm40KzBNaFR0M2NteElvL0kvMVZuZ0VqUTdESEJlMkth?=
 =?utf-8?B?OEo5UE42eUF6OXNLVjZxRmduaURzcjB1Z2RhV0QxVXdtOEszNkE5NHhYUWpU?=
 =?utf-8?B?SkkvN2NPRUR0TU8vakNrNUd6Rnh5WTFlR2VOUlNwK0ZUR2FZMXN2WXRCNUJY?=
 =?utf-8?B?Wk5xUEJaVHFHcHppR0dxeit0QnM3cmNSU3ZYdkE4MHFTTGdVeHNEVjFzQUE3?=
 =?utf-8?B?ZytPUmFVUXNPclo2TG5vWWlyc3ZRYlc1VGcrL0Q0Y0JjbUVBcDczZS8zR2lQ?=
 =?utf-8?B?bHJ0eXZ5aTBrbndRZFpNd1FweEVaYVJmazlDNHZaZUxSU2FUdC9oK3pESFNK?=
 =?utf-8?B?WER1NjJaWU0vV0V4R1B4QUtzQ1ZyZ0FpOEVmMHRmUFZGQUtvOGlLZURRc3FM?=
 =?utf-8?B?M0JUZTBlbmkyd05SeWdYVUJ2Mm44V1UrblpaKytKbEVrRDJzTkZ0R1VLTC9X?=
 =?utf-8?B?a1htZzUxZlUwSW5Ua3k3RmFiaFNxblA0VmVweGxJVFhBSDVYLzJmRUZwUEV0?=
 =?utf-8?B?elU0SlVBNnplSUNHU20zRkF1U2J3WlJmZ2wxcEwxR1lsZVNPWU9lZU5pWW9t?=
 =?utf-8?Q?LoM7hj2IrlmxPjKUV+ZRHfjYt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b854dd3-02c8-4582-e393-08dc3c043d98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 04:33:29.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRREBoKhgVwL/xX/TY6/uwUnw5ab3KZjLoteUFEaAFzZzlFBhx3TM/84zSXpzGXwtYl0nehZqTqKEmR630GK7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234

To: Vinod Koul <vkoul@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Joy Zou (1):
      dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV

Nicolin Chen (1):
      dmaengine: imx-sdma: Support allocate memory from internal SRAM (iram)

Robin Gong (1):
      dmaengine: imx-sdma: Add i2c dma support

Shengjiu Wang (1):
      dmaengine: imx-sdma: Support 24bit/3bytes for sg mode

 drivers/dma/imx-sdma.c      | 71 ++++++++++++++++++++++++++++++++++++---------
 include/linux/dma/imx-dma.h |  1 +
 2 files changed, 59 insertions(+), 13 deletions(-)
---
base-commit: af20f396b91f335f907422249285cc499fb4e0d8
change-id: 20240303-sdma_upstream-acebfa5b97f7

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


