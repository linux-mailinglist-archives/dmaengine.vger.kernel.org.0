Return-Path: <dmaengine+bounces-1825-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A938A2404
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 04:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DCE1C21125
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB112B77;
	Fri, 12 Apr 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DFJxz6ho"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732C11733;
	Fri, 12 Apr 2024 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890655; cv=fail; b=UFThnhUiGpl3z4HmH+yIzaa8vs5Oag+PvQEOtR5yWrUhnSBD5/73fXn6IJ/VwpW8SXEtnxOdBWnh3lq6mc/AD+GzbAvgyEE9AjMmVZX5DxlfYMthYqQ+O0Jz2VOC7hIvbF1CdiYPYUPAo0iyleMg4IEQGJTReMOrhQN6xnuoW90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890655; c=relaxed/simple;
	bh=YiyVlSK2E+X69WJ9WHTD3/MvlgH0130bFCAckLhTERw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CGdcFsJz0Qgyba43RWiuwW2ttY5/BaMOiTd9CmxsesuicgGta9+UEeUi1Pu6uCkzX0zyD+lWvUJQz0J6vfKIBsY9Q0hDzZJu3cZ69NKy1wkVFG7C0gnfxf28gdaX67+vWNnlkxjlbffItAx+hK6eOetRVfNFDEl7NNMfBnIx4BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DFJxz6ho; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYLhxjmjFvc7BfNgNN97STJ8W/DaBXGe09AKzt+PqXQUJQfngMha/Vuron1vxuGUtl4v4XqWxt9ZUsS0giRjEaU/x3Kvk4rDSXXFwNDm7Vpa5t4M9wxLRTZglRpOx52t3Z7SyKDQ9ssXrzaytnebwjuoBxYOlsprm/aERNxa+vybs3gOxh1KQvDm51/l7pE0zKOTcHx3ny+lUPaCR21sNnmFSpUgC8js7zV7kDQGiEs3qnIqBQ/r9cJiBEPf6b4uZVDYpQyznFEIshtbA7eVmqaShYlcFd+qK8GPSWaKd3o1n7fzR/4fTN4b2gGr84N1FYTJPS1t8DTobLBp+S+yZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okYK9aI1rtaWsa8kOpMcVz51DUrX5zbYUFRW489wr44=;
 b=lg7YJpDCbGt4kualtuPnEyeYZz8mL3RTX3TVnnKRnLIJUoifOvrZ/9y+9+3LjfoYoK6pMJbWrhXFYrWaLSZwSZdqgyi7pxGyBAzaccnSVG+JjPSYgZYU27t1OqFJOdJTdFfqFNabXc92onIlb6kplcxAplShK4keKRhP9AXtK88Cdn/zO3jNw0RQ7/vUsTNvS1+jR65nIwHMVcLtYuAa0y85/iaOfIBGz0lAVcFyzvmHPEtbsPQNBlNcpakFGQ8PdOhuObM5LnA5Od0hcEXv85O/vXM/teYy3RndmqyjYb3M4FiX7H4RQqxU9pOrB0ETx3Mcx3l+TbAx2tBM0owH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okYK9aI1rtaWsa8kOpMcVz51DUrX5zbYUFRW489wr44=;
 b=DFJxz6ho2VAT0tcwHWmpduR1aW4bQbXovfewFY2y6+E+kxpIsOxLBGKqJlSG3K0IBC6tNokdMzr5tRv1Uzif/jkiMrRD+E382U2EpWU5u4RuJOZzXVgCb4QrtdsBkntNAypqzbJjo36J2qcoLYljlQgCQsu4XvdspLm/ienbNu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 12 Apr
 2024 02:57:29 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 02:57:29 +0000
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
Subject: [PATCH v3 0/2]  clean up unused "fsl,imx8qm-adma" compatible string
Date: Fri, 12 Apr 2024 11:04:34 +0800
Message-Id: <20240412030436.2976233-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DBBPR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: cf37c43b-5cd0-4e21-5136-08dc5a9c4a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e0hIwumPugqmEOVEITc8SkJ1dJoWMf7t+0V5ABKz+/QPKrdSepPrECqf9Fk9KjcV9DS7w5TJG63X9tlPLPtyHDrzHqw+gvs9hk8+5hRknd+8MDtGpjj5POlOH7Ibtgk5M3gRg7Let1uMJYlUkx6bhnX8x4yZEOjQYfnTQahu13eguHyJVuOng4ayL16KYXF+fhXcONK5CmxjGUEvHukuR/lYM3X+RVG5bnxf+DiwPsGX9K5XvDey2+7q3CLUoLL2NaX9L9cigqMLXnWKMOA1xRXtsbsCmS4wTOFTHDqOmIXyjHJ1t0vd9a+RupV8bAbA0vcUoUl9zTAdsOtFK+4CG/EBbjiM9F1oQnPKn7ue+h4sJFP23NI0OGfakO1qR0JLcm3W0xjCtHH5zEvSERE3mv9PbHXWhj7DlLlj5sxmBqDtDJgGzJ7uFr8uig27ara2oPxxIsa2FIoUb0u8pV6jD8+o/CG24aOS2PjpISJYbTrI2UtL+cG+M5mshhzQ185MsF/lSHy7eHdsmujWGkXJ3Lfmp/7luFHNBrCfACePVQQfQvZMvczslgzJZ8wbfIoY+7Qoz2qkYOGgw26RIm2RpINNBA6/wwB5TiKenIQZVnTAaL3MLJLO1tva+GadZ/kK1XVTNO6uUTTcYDhC0PRaAfV4gB7PtNi/q2wOu4aUoIHNdw7u8H/IHh1J87ZIGiy7SsOEj7etDhBRki5zx657fw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlL/nM96APUIMRN1xNk6+EYacpcGs3mCAO9ymg2BCxAV8Yt95+5DtIW2JQ8Z?=
 =?us-ascii?Q?vXiwfyUrNH0q+RyoEykPd2Ovq6498agu6P+/dCpPB+q1k5EXgkcG+WOVLNrz?=
 =?us-ascii?Q?yYToUPJrSIpAQrlV4CmAezXNWCYZH+pXVVxD3FXwdUyexVV5HquboMgqZrdk?=
 =?us-ascii?Q?Qe6wHRFV7e503ZA3514Nj57Kj3baZGIGLgupsHwfdTdKiyhoaY++G9F+QOH1?=
 =?us-ascii?Q?QkhwNojE9EupT9quxDtuUACGV+2HLhZgguqqGsVK/dRG4MLER3CZUJtvWEwb?=
 =?us-ascii?Q?86PKVWGjYsDEBMOypft8YBE9981AV3ceZnhLqgT3ojDtVJ4oKEgBMXlHLVtY?=
 =?us-ascii?Q?7ikjwAInHiWYDQgfGoW8H5LQh2ivfMm1IsHqTgeVGBF4pWSc6h/ENupaEepZ?=
 =?us-ascii?Q?aZDg1WtmcqsvGShEDTUXyCMjG+VqFv0HxRecSb0NxoHJU7UHoZpTxLkkXFT+?=
 =?us-ascii?Q?wP7NHgm300EdUaDmWDTy6V3po3oH9fxFCDC05pJuN+zO9n8pPd+hchWjze9b?=
 =?us-ascii?Q?Y5/d+spt80WpAGJsUbjj+VJi5GWEMm9YiLDhMCfqSGOodJlOl0kD/CBnPAlg?=
 =?us-ascii?Q?ECLPsFOBc+Q64bn4oxSbyubP2/E7MGn/iFy6uCZLN67UQk8n2OGCZ14FS2bL?=
 =?us-ascii?Q?r8nYKg0NN2OMZYvnqmiNVFB9RfU7opVbI8GM0+vnRdOiXxZFwyhlzDvpDlnC?=
 =?us-ascii?Q?jL/qUE6oKtxY/+X30g8auCrKSWr4rASc7lwRLQjprl/EJW2MEhx+apoI6AN5?=
 =?us-ascii?Q?cP1cZjyd2DdVuXZxzdDSCPXJ2sKDdWsoVxVXFYv1uEcOdMv2lO+73aWaCewL?=
 =?us-ascii?Q?7C4hlmD6ZMsY2j12MJObca5mObd0HdHiioeaqhYrhs4T3L9hfKaYWVFr/0Ii?=
 =?us-ascii?Q?QGt4EmfHuIz3xFNfnbWqytCyDFPMnHcmjcMshPLTKR7z028Y0OtDCGDafcuQ?=
 =?us-ascii?Q?Qtj1jYhggaMDNRNZrwcIjsjZALIxRhQlkRU0XW8xibqkg5NwAXNkNfu+jeYe?=
 =?us-ascii?Q?NCEkI8jbdWZ0XnyjD7wGAvqCbUbE8r9Hno6cXy8cOtGRloolMRn+a/iaoVKT?=
 =?us-ascii?Q?G0m/PPnkSOvhYMRykszYxDEfQQTURx/RJv+aR2dIO7N7qofaIcmclyyX8yIL?=
 =?us-ascii?Q?zyZINr13bdV1mMXLaTcdWzls28NAr04bNDLztORwfxaYnNoeQW4ygmG10mAs?=
 =?us-ascii?Q?Il0qXRBI8FiVGZiVFI9UnsiXnc8zeukxWlMhDHeUT+GVhoX5hRIyq8ORh16S?=
 =?us-ascii?Q?Il9/TSOrQ3wzq/dy6+5kkYe7MpFwu+aOAr866vRSMLXPD2v00BcRn/l03JIU?=
 =?us-ascii?Q?FD9EVPi1IwSAk9YXt0B4SaIQPG329oQ9cBGy/MHPzdjO6TBe+Pqn5ruKekEZ?=
 =?us-ascii?Q?4wU/ivEZp9Zq/AG+2f0464GjY1L/hlHnL+OZJzJkIaudih2BMUQ5Xg1jpjoO?=
 =?us-ascii?Q?FGz92L0bPFsYCr0extNlDRtqK5pbMLi7hoFWYJzeqyyYDSSYBsp6mFeBeoQu?=
 =?us-ascii?Q?nIjzwqd47TBaq+JgzNfdQlNz336eVczCAKr8EbiPtX09Vy3NvHehOuxVc3iJ?=
 =?us-ascii?Q?ydyNAa1N+Dn7p3wRTTRct3zM4sqjqXXswSz14ZZ+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf37c43b-5cd0-4e21-5136-08dc5a9c4a5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 02:57:29.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvSMtp+5XmrKVyWyNZPF32GJ+zRIJg7hYauaE3WMSwKKOcVJY9fcf9+cbHPBwNSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

The patchset clean up "fsl,imx8qm-adma" compatible string.
For the details, please check the patch commit log.

---
Changes for v3:
1. add more description for dt-bindings patch commit message.
2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.

Changes for v2:
1. Change the patchset subject.
2. Add bindings update.

Joy Zou (2):
  dmaengine: fsl-edma: Remove unused "fsl,imx8qm-adma" compatible string
  dma: dt-bindings: fsl-edma: clean up unused "fsl,imx8qm-adma"
    compatible string

 .../devicetree/bindings/dma/fsl,edma.yaml        |  2 --
 drivers/dma/fsl-edma-common.c                    | 16 ++++------------
 drivers/dma/fsl-edma-main.c                      |  8 --------
 3 files changed, 4 insertions(+), 22 deletions(-)

-- 
2.37.1


