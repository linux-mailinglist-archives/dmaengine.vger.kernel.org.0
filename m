Return-Path: <dmaengine+bounces-1815-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D448A0A0E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 09:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078001F220A7
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 07:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232413FD92;
	Thu, 11 Apr 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIJFYhYj"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7013FD8C;
	Thu, 11 Apr 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820953; cv=fail; b=HzOPG41Jasi5JA0iTJJDS+m4qpKhvV3haRMMHOSlNOr9rqtxunVXMO3kyygCYYelYZ5ySGalccqdWP9HDsGHVmaxcMCG/BDCi/Ht2u8LZCY9RQQjGynKpVmgUWIXigUe2NhMdKQ6hjS76+iNSlsw3KUXfVISpyZu+CNvQ9y6tEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820953; c=relaxed/simple;
	bh=vicBYEVcecbcuGVRoAQKMxKnDONvnWdCf/Tn/Mq+DxE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gpe+xsKaN34ip97PA4bLY5iUxjed3eurDyKjIKuTmCBQhNzCgmMEtlvDAHe84MGxle7qHiQrdN/d3r/F265MnGHlp723a4klanOfTjgaHoh3eOAc3QRJjDFDH/yEt15JY4xZwCo4QHUvdPGjJrIhA/kfWUIn/ShiLat6ce417zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MIJFYhYj; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMuqTanVsrkuXOZZLG0oWEMJ1IyLK7xS0XXQ0CiSybvcL/Bjw1u888oFlNfa2TM5WFR/CZvbSacAAKzcIVlWrcpDH7aU5DRNPLes0T/aKk5zrs0igjAvDpnqEknK/l7RymVu/AdfOvNUEY9VcrTwP7Ks64zUKmGkCIKNcRf+vj2YYGJRIHd92MYujE1an0ZiWUMWgTT5e8ArwahESUO6JMPJazqXudoiJEt9G44xuxiIRYjV2pi7rOMg1j99B/eGwZx4wpC1Wg6T9BJOh3wbcLH5vzPDcZv2M2lI0AmqpdgIqmSEQIceiLQV6XV2Da16pTsQE1Ct6mhAhgutL51k6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flLZExif4dTZLba4Ul1vXmL1nXdVCQn63Oy2pwjFo9Y=;
 b=BYRDQmNylBrFK3Lez+ErgE8f7tH/xMvsDJS9oPnZCZCfu6s/csMhbqXrxkmpHw4IkapXYJxSo+u5K604VER3zLONSmWj1g1dFJxEHgKOJiQShHl8XcTzHcnOfpvYS9m6Egh5BavYBxnfxXvtXpY9v3SwEtthRacbbXbt4B3nD/lTt71+smy4chUoKAsjSA0n0cokMCl7ElWknT5MwZ4oxnPIQIhhza0piag99CwW1W4m2IHdrWler5frtnR1vLwBktpgKUalG4TuP2qq9YC41wn6QI4s4cvscU+dgN2vJKbfieqvxJjS8Ew6cThB9bWqsbH9MpB3Y0jRWcNx+SRwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flLZExif4dTZLba4Ul1vXmL1nXdVCQn63Oy2pwjFo9Y=;
 b=MIJFYhYjTCBYF7QF9yWvXDWuP/ko7bre8bstOGvYSphnoNse06rQmw3HEA+Ublo57VDopoUtp/tO10d1VyorbqkqERPcRYrChnde5EACQ0F2/EbIidymJScghlGdW9Q2LatjkhyFEMHs7n7lZxgeKkvGAlQzca/0cU7ZTipWRBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 07:35:47 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 07:35:45 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] clean up unused "fsl,imx8qm-adma" compatible string
Date: Thu, 11 Apr 2024 15:43:24 +0800
Message-Id: <20240411074326.2462497-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b8449a-c06e-4dac-5c5d-08dc59f9ffde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cF512UXqRpLpAevO1ZN0JkjBVEK+gpfkKGRsOnU3FVt2DnPkX5hwOhBXSPFHbdqfKuUqLpfccBtMRRLX2/83L5a81DSOYZKH2Jujy0bkplyk4UMQB6NFYPElffNRowBokqvtZHhDbv3bO//t/HyYrr7Hf3j1S4ZGggNMblZCFvP4CFiF/wtY2fz5+AzMyd/yI4bZwcq6o4fpFnTmxv2pM3YVhxTY3g1xqEqOb4SSyv6jC1UJu1jITwKgNFtzzrhQboNhD5Wrnna5OU9Q7ngb9uCO4dVEv46vikkbPDfEDgMv2PXPuE8bNwG3fGt+4ulguC5kzAn4tSs4ecS+g7GTqJjysaWB1vQ4WM2o7Tszs0q4DVjtKze9Mr29PhOqFelmaKfND9HyTpPI5cvKCFmn1yOYpa81t28Qd867HJLmPEksqS+lJ+isPyUKdHoOhRGvSmRB+x2TNUzmo9+PnrH125N4IXobSMirHyQD2t8b2VOzcEhG6wkbPVZ9GQUJq59fUWXqGk3vFF71Ut2H9fkmYAGl74R7ONwo5Ef9kdNM7GmiSXXgolqS1TbarV2jpiaOZyhdZYi3ZDqNLHy1Pn7GYsvhWeyui0B9HfOCacEZlZqNBzTF1HfeRIPCd0WNao4amPzS/kkUs8QAkn4KKUigKxK4rfvMqY7WgC97EqoXCEIdV+L0SlFUoQNjuZ0cOKVwCCml+FZgI6VBvMNZyZ5TWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgO1aqEKbdE+jw3BOPk+T3jTZrVO1otYWmQERXof1fO/Zs3UNvJ/YXwJpICd?=
 =?us-ascii?Q?FR48nv2FKZz1/73xnsELZ3mWj1laKHaSH62VJEJ0WmG304VVJ5grokUAnbAw?=
 =?us-ascii?Q?4JMUnmmSZWFLWi66k5MzH99QZ7PJQFo+FOHNotrcvKsdgGEunHWL+uqV9+nk?=
 =?us-ascii?Q?KBMvqEO4MNWJcVNqadeS/BLQ8sgYsAC+lalkr5CZxj64l/XARvSHnU1jgFMp?=
 =?us-ascii?Q?PXO/gXo3hh8nxFxAI9A+A2OZr/PLXttvRW9PfSaYauj+4zfYPUN5wpU4uwH7?=
 =?us-ascii?Q?7q8m/YmFdBDLwY4Xs6t0KwJXbh3kjxOq/OAg7gVwO8qEOmjzgMa1GAWTgl/u?=
 =?us-ascii?Q?DS+w99peiuFfkn9VQvv6r1Kpadp3zWDhq4OMrLS/uCKMxNSZzlt6n39hh8ZF?=
 =?us-ascii?Q?ltnU8tQUs+MbMFHlUpYUE8PHuTjGThwgvyFBXiZZzhYAju8tWON6AxE/J2HK?=
 =?us-ascii?Q?xibBRKZ4ZL1YgA+kKkceqm5l7u0OYx64Z/htAjQj6h7cZcMN0PuvlCgIY0W7?=
 =?us-ascii?Q?k40YNOeKnk4Q8KvqS5yeAF23ssp6WoMppnx0b4gMA+WsS4RrtPLlM2lxzKxO?=
 =?us-ascii?Q?2FIopYnZofoH9FVRt5PUPynBLslKuvWOHFcfCfgJ4De/ysF4X282blhtrz+l?=
 =?us-ascii?Q?YMP7F1TTfksETWMGFZUG3NQ3qSDxtuv1pdW4wcNGrD5uoJw+TnvziKK2tMaz?=
 =?us-ascii?Q?6HwCePVfWf5ZGgRtCTb5S3Miqq6J/cWOljMHago+KiJ8RPSxLyegZqLAdBI8?=
 =?us-ascii?Q?ODpqReqc+kWWQXRID2J4Z37upsUO675AtOoscIRDw16tdZC83ren9BeUIqcB?=
 =?us-ascii?Q?VHJ3iF/M1rn0uEwdQSbA0tPCGzc44TZRrBKu4z4QwgmZOJD+prCQuEY+aN+X?=
 =?us-ascii?Q?LB0yTxipFxGpd5sBEey69/SFmo6HXVrpVpdYJfIwWfd8Dbj1IJkG+YR5g1sl?=
 =?us-ascii?Q?nulzsQCqSMoQvv1lrgaY0EC77/pP0JQsGAPVHdJ8adIZdiioxBtpi/NgPt3o?=
 =?us-ascii?Q?cSfVYwv1ixR+X2S9CmHPcMqedZfImah4n+l5sZtHL2g4RFyJmGTohLhKnOot?=
 =?us-ascii?Q?HsWoBF25zKFLVB/SXd26hp3/4dKCaNqOsk9Oj/Nw7wBQZbmGt6wD0f9q9s9B?=
 =?us-ascii?Q?r63o16GrgiYqaAV7aOG3SXH/Qng79UaN/V2hf61S+xMS6r2XLAM253uJSZSH?=
 =?us-ascii?Q?7YjD/eMjr2uYaBT3MWBv7wDn9vsnGyeH58lxetGv6c3lnWLzz1QkcPXNdkcK?=
 =?us-ascii?Q?zlXJH1i6IYKj59urXqu23r5b60lmZ5Sj7qi1y5xOUaqatParD+pjnl11Q6xf?=
 =?us-ascii?Q?nOtB8q3z0ScgzPiP/SrhXsrJ9hvhb5q6COJkV8V+07Ey2A1o9QXQzGYFIvU4?=
 =?us-ascii?Q?k3Y+2XVD+vG62Qd3oIZjr3y2ppqyTqaeZRtUh1EQhS7b2MJK/nTDMG+zrtk0?=
 =?us-ascii?Q?23DjR0wOnBB6hNe9qpkrvsOflIpRrQzkkG1OSVLzm7y4Qez+H1T9W8WX2XJV?=
 =?us-ascii?Q?6e5Xhyb2rmBE4/3z1ASxkz71dDhYNGcDSqTregczcz1uG43HTLibMWRofZnp?=
 =?us-ascii?Q?FAoa2ZimbqAgISxceQIrjT6ehNdExdUrFKjaoH6z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b8449a-c06e-4dac-5c5d-08dc59f9ffde
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:35:45.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1g17Tqdb5tBZhQTT/LY4vmZoFc82/MLmWheW0Iynw2eyOMJhME6QiUDyWPZEUW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

The patchset clean up "fsl,imx8qm-adma" compatible string.
For the details, please check the patch commit log.
---
Changes for v2:
1. Change the patchset subject.
2. add bindings update.

Joy Zou (2):
  dmaengine: fsl-edma: Remove unused "fsl,imx8qm-adma" compatible string
  dma: dt-bindings: fsl-edma: clean up unused "fsl,imx8qm-adma"
    compatible string

 .../devicetree/bindings/dma/fsl,edma.yaml        |  1 -
 drivers/dma/fsl-edma-common.c                    | 16 ++++------------
 drivers/dma/fsl-edma-main.c                      |  8 --------
 3 files changed, 4 insertions(+), 21 deletions(-)

-- 
2.37.1


