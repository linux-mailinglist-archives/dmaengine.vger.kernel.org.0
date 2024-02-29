Return-Path: <dmaengine+bounces-1205-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C583186D5C0
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 22:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F828E87A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE0151CCD;
	Thu, 29 Feb 2024 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Etv6RV9h"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF3144039;
	Thu, 29 Feb 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240341; cv=fail; b=is8ivxTF91vfOpP0NqcGdRZg8xuyKsyeD0tRuOaICA1srRzlOlomrVf4P50B1f5x3xgxiS8wELTrGpoUHlq4fTUe2bn85YbiKcWusdIc44//YctIXqyAECqKwnDoDUELN+ZgKD1wEqbEPZTLsOWW52nBfSHSXwXG/2mOsPMmFkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240341; c=relaxed/simple;
	bh=BOhAxlAQpjXP5BFUPIPaKX4PvfSegiWhigjuBpv10A8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rdJMvyFBfQ7i7TbnhsbqAxKCxQIJiDfTeJWi21oWgEUyZ/vYp35irJMSMO6kzui2xHNcWSiqzxJFQPQW4MwUwvJYimXGDkdzh5B7Nkfkd+Re45/1PZg0yYS32fFlke0nlNr/cAAPkVkirGQoB9t444/tu5OqfcGF6TmOol7XMRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Etv6RV9h; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0dGBEEB+LGXOHk+Oj7Sq9uDv5lE1xNXtGil/3DV0628Yw2q7jMaRGAqVK/j//J+CiWpEKNacKrinSa9pa8olQoV/XAxftpXJOra4W9zlPPdUm7ZNU4b7it4IW83PFNMxeyfHNGAH6ZkKcZYfB3XRX2Qc7o0oaHVwmARblF+Lg8fKEICpU4U4zFh8L7Sm2oCWuTj4WrkZh5iNlbuEZ3HaGebN82iQSHxWqOYbIb9QtX7Ke5/bL+ESnv0rqh5kqZLDcrvek9s0762HvBuDFkGj9Ko5M3F1AhMcajmX9aihyFvgP+aCqsSfSMukq2TUDYG036lDYbJNZKi2Evw/J73ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YL79eQ/STH4lR1ykKvxWP7JGdhc6lCztU0ALXEbBaQ=;
 b=jK8/N5ykWP34k0UFp3QRQWCT09iLQekP419rubArth5uCBC5pX1hqMypq/H0x5/EGP4gcEw4feZRC66pt10935NpiiOzSrVLa5HYnRdHKp4DhvjCScVOYg18hjSLjcLP3GPw3mq5NDWfIageBGgyQP6GXgkQMOru8weomfyd5xjaz4EvslCOQYm/g6/9oIDscIt9DUjoRjLlOLtDJayyQ3OLJ+Z2ztFund4vlaZbfPaTZkulGM9Kb+urgCPwPQe/CIXx9GDcS1o1dPafbVuNtToQLdbkvIlGKVxuci7GhVytMVEIq+GybHbVR799Z4HMp4zyizrlcUQoQBUYk71zAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YL79eQ/STH4lR1ykKvxWP7JGdhc6lCztU0ALXEbBaQ=;
 b=Etv6RV9hcjHlkclBk4Zz8znbsz0CSjzIuKKSg+LHRY7DxCA8wABPdpUHkGIAwog9sLn+peiCYQvYZe9cpfI9eJlUQxXv/1MULx0R5vX7JaPGDHIcGoLEGJNBA64PKyw14wlFg+Gr82oSBwSq2Acz44GMjMK5gDioGIMDVYhOT2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Thu, 29 Feb
 2024 20:58:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:58:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/5] dmaengine: fsl-edma: add 8ulp support
Date: Thu, 29 Feb 2024 15:58:06 -0500
Message-Id: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7v4GUC/23M0QrCIBTG8VcZ5zpDD5ajq95jjFh6bEJT0ZLF8
 N2zXXf5//j4bZApOcpw6TZIVFx2wbfAQwd6nvyDmDOtATlKjqhY/37GG5llYgKJ8Cx7o+Qd2j8
 msm7drWFsPbv8Cumz00X81n9KEYwzZbUl0bSTxqtf41GHBcZa6xek7w+VoAAAAA==
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709240333; l=2213;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BOhAxlAQpjXP5BFUPIPaKX4PvfSegiWhigjuBpv10A8=;
 b=pd00CBTXWa+4HpeJvoteTvYAXqjgL8KOopkmEqGkz9SNX38YcqnMhG/y3H7z5bdiYHEKQSf17
 HariI70lcmxDtSTlVElBd9opuQT+q/Zh+RD9jZfZX9CZJTJKmstrgB1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 21374ea2-3b12-43e7-e595-08dc39693e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+02okbSWxPmq4lt/QDVAm7woQTY311VURQ7m/uDv6Brx60i7qDJKAjM/TTsTj+1qqMBqsmEXDUNW0y+Wd3uwUECDfSqdN+EWsjpJnTvu/Qj9szZvkv6PZUaXMcXlWK7/bCc0OasH2ATKVyUMq58ur2k5sFIKAzp9Ug54Xcvhb35NDKRX0bgZTVLxN4p5n/jdzqmPAcF1/zb/Vr5BSDr2z2HmEis7fsP/ELEWzbGpi923Vg65Y0nYgFycKFhOV4Yv/HcFdR6vjalxvWxzUlLwP6FoauHxS/cCFR8fVw4HW2E6dpXXThb5270IpSOlI0QBHeeiNgt+kP40NnIbmaKdC9icx0NlFLOqHpboxfeGYFiDHiKdUYnEElFVrl6nP7oDTQrUn9inImvx/52g0BtI5Hsbv2xKIctPFDnsqa2KTcBuCjnatPQK5nuWp8ilt4M07OqrdZ7FV353iLcKQEkjTOv1Xvxpk8/W4w+NNGVBH+VZDVFPjZsxmnXq1Z7P4JA+zSZw2hkbxVGLjIe5ByYrInPp6bkw63vTd9hxfTCNhIM6g8U7O1OWpxUC4HVpuxg4zwUueVlRAnC/bRf1gKR+MgRE7jimz9npwPvShMQfza3UCkMn5DTtuOzw2HHb7/KnrLL5VgDmDr6QOI9HUqrQV/M0l768ZSyU4wJZenStEc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THNITHVsN3F2cHovZXRNd0JWNDFONmsxa3VHUnNtdjU1RzlZMWpsdWtvNnh5?=
 =?utf-8?B?WFdiQjdWUnZyVHI5WEZVQXFCWEFubithZVVvUUo3ZmNIVFBmdzFpa1p5Z1ZX?=
 =?utf-8?B?elVNK0RIU21nb3VYL2xRM2FVKzZXclFBeHI5a0lwWDJteTF4WXBZaFJ3eHJy?=
 =?utf-8?B?dkNYZXN1RW5yejB4RGVPRTZlOWpETU1ZZ0drdkJOSC9sYlVWZzh5QTNJMk1G?=
 =?utf-8?B?dU9MUnp0ZkFjakpPenpzRFQ4UTl4enRGT09BTVd3alRHdGxxOThrUjdHc2ZD?=
 =?utf-8?B?UVVqSmpiMDdzdk53OTErR0RjOVVFbjlmZU5aZGZMY1JqTWE4cDlUSmRLOHM0?=
 =?utf-8?B?WHpLZnhOZjhCdU5ER0UyckkzMXg0TGNIN0RjQjBYUU1QRXNseC9EZno3Mmg0?=
 =?utf-8?B?Mk1pbjNDYklPNllzb2NuQnBCZUFxKzJKVFErN1AwMjhiSS9MOHlkSzc3SnpR?=
 =?utf-8?B?UEFnbkQ0RDdkMWdxb2dUVElsZ1ZsczF3MG5LRDBRSFVnZWJyeUVHQW9RU01a?=
 =?utf-8?B?U2R5NGJmTHB3UElnMVlXcUw3RlVoTkhvTkl2TEJVUlAxcDIraUNtelZtU0cz?=
 =?utf-8?B?TDJLZlRIaVlzTVhvdEF0R1Q3aDYrSjRaU1owY0NsSjNpdWdHL0l1NFpEY0o5?=
 =?utf-8?B?R0xGNnVuNnF3SWtsWTJWVVlqMWRmLzlIRjlyR1VuUkk0NXdOa3Rmd29nRkxt?=
 =?utf-8?B?RW4zYmhYd3pYcnFqWnREQWc1cFFJVlY0eEphTzV3SGtmNHowL2lOMUl6enBk?=
 =?utf-8?B?VncrTTZmL05qR2Q3ZUZGS3VEbkhJTk5MNHNsTmZLSDgvSFZ5MmZ4THVvSFZP?=
 =?utf-8?B?ZkZ3V3hDRUQ0ZzZVUVoxT2c3WVF3TzQ1cm1ZREVOZGNnSXIweTFQMFNoTGVM?=
 =?utf-8?B?NGd1MFNudWREa3VJT3hkUE84UFFQdEJRS0FvaVJVRHZGT2NIQ0FQUkdtcXZW?=
 =?utf-8?B?SVdUREVmNWVJNzR2SG9oR080TmxFK0thNUJMZnNLeWNKWFpYVHhreEMwekhi?=
 =?utf-8?B?V0ZRRUpSdXZPSG1Pbm5Lb0U1ZzJMbTd6MlJGN1QxRE5rdFN2eFNveGpTVXFF?=
 =?utf-8?B?dWZ3eWgrQW9JVFZ5WHJDWkJIK3loTUJiZzdHMHFlYUliZU1XMjVHNTZ0YmxD?=
 =?utf-8?B?eitNY1RsdVFNSVk5ZXZkZHF4ZHlWYUk3eE8xUGJVa1RDcERzbitXcDdiSTg2?=
 =?utf-8?B?elYzbWpPcXNaemh2dG9OTm4vYW5pVEJiSTZqWWdLRy9USjIzRk1mcis3emh4?=
 =?utf-8?B?Z0JIS0wxbnFiVnI3Z3JCU01NQlB2NkJIYThFNzFWVlNmSUpjUkwwVUJMNHBK?=
 =?utf-8?B?eFpFdU1TQSs5R2Vab1lTb2RoeTJYdEl2SG9IUjdkVTRoK3NBcXVXK1FkMXNo?=
 =?utf-8?B?RktWd1Vnc2ZRWVZvOFBnWnBMNmJBRkhDRnB0VVJjc1hkaEs5cEVvVzVNYXNn?=
 =?utf-8?B?OFQrUmtwL2xVSDF3cFppcXhLRFRqTndiR1BZSis4cGgzdkdkNGtERXpBTFZw?=
 =?utf-8?B?Z1RiOHBEcDZXNm5mdnYvMGNqenN0WlRiUlZrVTR2S05LN2hhanJaK0V0U0Ft?=
 =?utf-8?B?aDFBVDliSElYMFd4L3BxUTNJa0RXVURPZVlnNWZnYkhDQk95Z0xSenZmejlN?=
 =?utf-8?B?YXNTb2ErUVdPOUJ1ZzFBeVBiK3BhMXdnNG95aTVjaUpjVXcvdjFDQXFDaXFS?=
 =?utf-8?B?S3hCWWxBT3VOSy8rSENsUEFSTys4QXZGRVJvUlQwS2RSYThmWnBrUlplTzUv?=
 =?utf-8?B?WCtoUkczZXltaEppVjlBMjNlWWxtTXF3UDRUcmVmTVNjZlozVzl2Snp0MnJ5?=
 =?utf-8?B?QVphU3RHd1I0VVpuQ2ozUzNsSXFScEx6ei9ZNTlIc3p2L2kyMGJMekw5WUpK?=
 =?utf-8?B?M2FPTzhuQUQ1V3A1T0s3OFJLZktDdDU5d21RSjU3cDMwc2VocE5WeFVxdmRm?=
 =?utf-8?B?QlkzUm5OT2xSbzVWRENmMGFCenl3QlM4QXFSV1N0YUl2cXRVMUxzUnJaTExE?=
 =?utf-8?B?QldPM1NpZGxieEN0aUU5K3BJTFpzQ1B2Z2VpUEZ6VFRZcGQwRlhXNFVPbFBZ?=
 =?utf-8?B?MmZFUjBrZlVMeTNvWlhHSVo2Mlo0ZWRqRXBMRUNJczN4d0Npa1lXQ1ZHWUtl?=
 =?utf-8?Q?yuUAISRaHUXolJMyffEAeCO0X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21374ea2-3b12-43e7-e595-08dc39693e74
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:58:56.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hat3g/uOBXh8LYCj2b3qda89be6LGq6A7fYzWjHT7d0tgSntvfK454FZ1hfS4bNYjIE66skh9IuKKsDA5QpbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750

Do some small clean up.                                                    

0c562876972ee dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan    
d9b66cb5fdf62 dmaengine: fsl-edma: add safety check for 'srcid'            
aae21b7528311 dmaengine: fsl-edma: clean up chclk and FSL_EDMA_DRV_HAS_CHCLK

Update binding doc.                                                        
23a1d1a6609fa dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma compatible string

Add 8ulp support.                                                          
dmaengine: fsl-edma: add i.MX8ULP edma support

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
  Fixed dt-bind about clocks number restriction for vf610. Keep the same
restriction for other compatible string.

  Send out v2 to avoid consiste test rebot report build error.
  Fixed build error

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402292240.149bq00a-lkp@intel.com/

  Rework dt-binding commit message. Add reason why change clk number to 33.

- Link to v1: https://lore.kernel.org/r/20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com

---
Frank Li (3):
      dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan
      dmaengine: fsl-edma: add safety check for 'srcid'
      dmaengine: fsl-edma: clean up chclk and FSL_EDMA_DRV_HAS_CHCLK

Joy Zou (2):
      dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma compatible string
      dmaengine: fsl-edma: add i.MX8ULP edma support

 .../devicetree/bindings/dma/fsl,edma.yaml          | 26 +++++++++++-
 drivers/dma/fsl-edma-common.c                      |  6 +++
 drivers/dma/fsl-edma-common.h                      |  2 -
 drivers/dma/fsl-edma-main.c                        | 47 ++++++++++++++++------
 drivers/dma/mcf-edma-main.c                        |  4 +-
 5 files changed, 66 insertions(+), 19 deletions(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20240227-8ulp_edma-12ee2648d74b

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


