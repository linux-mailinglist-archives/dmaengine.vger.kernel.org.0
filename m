Return-Path: <dmaengine+bounces-1473-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E99887934
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 16:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B00B215E9
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9EF41C7F;
	Sat, 23 Mar 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GQ3iavMA"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C581EB5B;
	Sat, 23 Mar 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208120; cv=fail; b=nSXdnz0/DPTqRQ3gDGvFSPB4T21qh2o+xQy16BN3Q2ZS6V0eJ2w0OXZsts0QneXrsWbWF+POg6fV/AEasJl0WsZJgyagzrqxMp0OKqy2DZEabE8brHnatEXWfEns/dp5VeFOjKgoW/u9f1elNfxrSgfwyJPm6stqWAvc70NjEfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208120; c=relaxed/simple;
	bh=SI0hd+QTH9fOULwMPbIUagxMk7V5O4ZVgnZEbO8VbJA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mUASxYiKryuItcnfKej9Wvr8MXktM0iMeUXsXPK5di5ctMm5C1WiOh/q3cL8q2BWG0PJefND82/CX+iLYMJgcrz+okSfWm2BC0fgwuAxlJEThM5XrIBZ7BgmJi4k1TeMEg70/FZQM7Jj74hvB2YMaRukFQDcTIBODFzFjb/kFvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GQ3iavMA; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAPT01fphtBWff2d1XwNeWl0SYSTX7WZAM52l/yp14vxfLe0wLmgnh/Qw2pnKrGiFrnnV1ulfop1OqjKayKT7VBu1JevrfhhkM5zgMKBNwXhlLFY2JWMI6FfoDS43RXqVsfl60oB3M7tL78PFfmxmdzaqujdllZczI+0mLgdm7pBZWnZ5WFacPq9RPPGyi+K5lQIEPZrGQZsRiYEEreRsFpOqt7+yUn6leFMMX2EiaQq3lar+Wr33YPOkOEmvskaARitEHX1jj83npbGdBO0rvEcGjt3TDfQqYVhWKcRce+ViMwGVmY8EoKZNxknzlQ+D5r+JH0BZH9HAOl6ZLP/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pLLC5PEtOnpe6WiH7NmjjsMSKcjrnec+U61N1KXB90=;
 b=k+HNaNAfwKkdgjOz3sWtHHk2ICzcc7YWf7kKvmMNJdWjnnMfWWz4Qq0/f03eO3cPNNJNfA0/Qp1pKOeGVJiciUol2jTSsYCEPEoPqobE1ZhDfyqyXZ+uRLHa+GywuskhIf6Qh2oIIDIkPsvw7MI2raagjmMYsQ+VMFu0WiF7j9siSXO2cmckiSYzWmcY6UtT3x+z1rm96kuelQ1URWV4us9YpdNtbN/mwHQ2kb5eyJBYWoY4Fa7Q00Qs0+zY4xhbQfaX8hVu5awUFese4FTOGennT0mbFySWHlUlgUGc9ZjBd3OnXNxLh/MG92xCF5kQLrNPte9X59feoFLvcb/tbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pLLC5PEtOnpe6WiH7NmjjsMSKcjrnec+U61N1KXB90=;
 b=GQ3iavMA24u0IJ9pwyFvrrQTFLOGyH+jzZd1AAME/jmGQrW1NqKh1gkoAPqJAxfdM3mSqJyfhb1wjJWLW/8GvUszgjUUMeenGGMdpLlPXfwCtmNi7H4tyhEbd2T+svqhmqLdqPQw6aTG6vZj1C0TVSppFxDq68pswjyrv49KFjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 15:35:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 15:35:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/5] dmaengine: fsl-edma: add 8ulp support
Date: Sat, 23 Mar 2024 11:34:49 -0400
Message-Id: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJr2/mUC/22Myw7CIBBFf6WZtRiYolBX/ocxpsJgSewjoKSm6
 b9Lu7ELl+fmnjNBpOApwqmYIFDy0fddhnJXgGnq7kHM28yAHCVHVEy/n8ONbFszgUR4lNoqeYf
 8HwI5P66tyzVz4+OrD581ncSy/qskwThTzjgSuXYweO7GYW/6FpZGwq1XbT3MXmUFOq1Lo536e
 fM8fwH5MPfp2AAAAA==
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711208112; l=3513;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SI0hd+QTH9fOULwMPbIUagxMk7V5O4ZVgnZEbO8VbJA=;
 b=jabq9qU5f29R2rLbt7h0g+1sgk5sMyVaRV1sk5yiJ70jFOBGR3QEdiT8ldXlUDuN7aH4fmCn0
 hTsBatnhIpZBQchC4O5tN6kITwBJBTpOw9JHB8EX9GYzSGR3Ko46cwV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ead93ba-e8b7-4644-4f31-08dc4b4ed62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/W7cUK6K5aaivPNZdwZXYwNPp0l/lkOhABGAmSIgT1fVmq0NBy9UhqbF5oyPw9aIMfp7ccxNtMRRMQ3MGX5vlBtHEZswlAD6WLr+SyBRiFNfg1d115JBy3K2qujj1SsWXnOmHss/rHkQ4n1iiYIfombGLj106ip+k4OrIRVaBLmgpb8nX4n6uclpHla8bZtP3ze3yYorBPcw+6HyoD0FVwriHw94P7mwN/uWtc7vsrPffcBgNW3fIafzkQNjnKpaWsnKkGzzwzjKdGtqKMcgiVBhCAPooL1tjlo+NAJtUGemcQeA8jXhPrSoSKxTOfkcXC37SymviVeILa/CyDEhaJTCheKvO20+KWiIMsxx0yskbyetxJ45PUpRKtR7FAODvPgpb7q7lnGzDUoiLWaK1ImpzWBZxuXXe1ooRJTDcaJ8vi5o2MH5VvfUEWJ2AZv57FL36+uW0/odWCsC91+QjGdi4qjEYTIdnFft02CsvyqJ7+A04UdiPJZVhZLtfoEtVGckaedyVAEpVquPv+gwzPv9F3HER+WlMQYenaiwa5crsOlwZD/lPD9Qdu5i0hYbCmjWxxuxZlPrXeLK63UCYgIN+3PYOm2uovuSY1KjK7bwod4LhcI9Hvylax7Bx4D1S7lf8iAJpeDAa7yuTz1p9GGyOicrQNpKvouvALMT+K8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmtKWCtsYTFqc0h2ZzNhTGc3bHZROUM5MjUybTJzRFdNWDJ0ZG90VjdSRCs3?=
 =?utf-8?B?WGs5WEN2Z1p6NHV1bTR3VTh1S0NvSWZocGQwVmt4Q3BwbUYrWkNuczhVTkNX?=
 =?utf-8?B?L3g0U1R1OXAwdG45QXU1ODVTaVpzK1kyaTZRNGpNbWJ2akJzcnJHZ3dPTWx3?=
 =?utf-8?B?RkN1ZndKcWEvQ0Zjb1VlV1AwYjZFZXRxZlFoUHZabXdkMTBKUDRsbFVPV3Zz?=
 =?utf-8?B?ZTQ2NjVlUVdmRVhRVkM2djJiZ1lRb3hsVHJkQyt0dkkzVjFxL2o1RllLamQ2?=
 =?utf-8?B?R2VGdTg0NCtNZmQzU2x0WEE5RUNLWFJmVmJuc0FqYjNSL2E1Y3l5NkNIOTQx?=
 =?utf-8?B?cVluVlRvSUZuVEQ3OU52REhQOXcxbWZlUTJuUmlmTlNPU25QUU9qZmJlVWlV?=
 =?utf-8?B?b3E2ODVsVnBObjV6TVk5ZCtBYm9wK092Q1U3QlpObi9wemsxK0lSTjdQMG5W?=
 =?utf-8?B?OUxWazBGbGJvcFpVWHpWMkJNUlJMU01HdHZPckE0b0ZHNDRtbHRJVFlPOWdD?=
 =?utf-8?B?Yi96Z1VsRGpWazl5b3Q2VjFVWW5kRUxYVVZ3dVJtNTNvRFZjS0RrbGxhV3RB?=
 =?utf-8?B?Si9kZENnRE8reG1XcW9IaFhzOFRjb0N3TU9MOG5LcnRtRzd3NmlVdUdUQWht?=
 =?utf-8?B?NUJFVG9uSnh1VHIxWSt5bmdOa1pMS1YzeUVIWC9scWozUFBGOHBZY0ZyYXdz?=
 =?utf-8?B?R2ljWjF6VGZjRWdJNEQ5eGhkOU0vS2FYY2hhRzRuZWo1NGJRemQ5UlJUYllW?=
 =?utf-8?B?b09NaVgzcTlEZFpLcWN6RVNiODFzK3BGUjdPR3N1Y1RiWExEczd4NU92TWVZ?=
 =?utf-8?B?TjNldmdXeUhWWFo3OHl0RGRITFRWOE15OG1GLzgva3pBV3JMdzg3KzFaSTd2?=
 =?utf-8?B?NVhEUVVEQWNnSE14akdMbzMzTUtBYVU5N2oyUWVXYWlaVVVsTWloVG1QWHRo?=
 =?utf-8?B?MjNibzkrOXhQRWlGamg0OUV1TTVTUkoyS1VrcDZYS3ZCb0hnSTVMMWpWeG5r?=
 =?utf-8?B?MHEram10UE1teS9hSjVlQTc5Nk0yMTVBNUdUWWR1WnI3NGdkVnRFYnQyMWZ0?=
 =?utf-8?B?OFhERTE2V1JBbk9xTDBJL0JpbUZWVTRwYVNFcXBzbXhCbUxZUU9FTkdEbHhD?=
 =?utf-8?B?RDNOQ3NQRzVFcVFIcFhqV2hWRXRYZWdUcHg3THYzL0tIUC9hcjRVVSszd1k2?=
 =?utf-8?B?Q3FHM0xwbEt1MzJSVDlDNzYreFRieDd2dFY0SVBNVlZmRFY1cEVZd3ZwSHRM?=
 =?utf-8?B?YjZKMkJKcWdjNkhWeUhSeHpkMUx1OStBa1ZZQTRjMmE3dFNQREFWdXZGREhn?=
 =?utf-8?B?c1N2NXJ0QTU0VERPOU12UUZlVmQ2T3Zxb2lsejZtMVdzTVh6bm9hKzBCZ0ZD?=
 =?utf-8?B?bmdZblJpOHJhMUdTZVdIOGxZc2dCOHorVDcvZVZkRyt4ajdMSHJqdTU5NXlZ?=
 =?utf-8?B?UWRwM1N3YUdOVVYvRlUrd0hGc1B3UUdVc2c1NzhPUEtmOElzdXI4WmJ0bGpV?=
 =?utf-8?B?b3lJR2VXb1QrSXZuNXRJd2RsamtGRTRBam9vbUJBdCtJU1lmbGg1aTJtRlJW?=
 =?utf-8?B?T284RWFRblR6dUR2NXJwVk9YemtVdjdtKzkzL2lRZFdRNlFlYmduTW1GMkYr?=
 =?utf-8?B?Mjc3ZjdFbHhxdkY5ZThvZzF3ejczTWUxSklNekJvZVlaS2FacUx4MTZ4SHBu?=
 =?utf-8?B?dzNDdU9DMUs5Wm1yTWJqWW1ERFdxQ1lQU1NhUlE1WUdNUWJnZko4VkxoaWhZ?=
 =?utf-8?B?L0NpUmV6aHF5Q053elNiR0x5ckxsa2pXZVdJTFlYU1FaeXh0enZadCtseUs0?=
 =?utf-8?B?TXEveFdwcmxxL1JEVzlzZ3JzbWJVYk92WlZnNy80SVk5S2NyWlhxWTFnekxP?=
 =?utf-8?B?QVdJLzFUc2Z5a1NraTc1VUQxV2dUZDVOaGRDQzNPWm5udVNaVkdoWXRSTnRp?=
 =?utf-8?B?MUYvb24walNRS3N4dVI3VjMxUUtLTUErZ09pYU1EaGFZTFJmSDFINGJRM1hG?=
 =?utf-8?B?Q3pmRVhxWDRMb1Z0Ukh1Vk9jcG5EeTl3YlRmOW1HcnJyM1NVSnJPY0V1WkNN?=
 =?utf-8?B?cWdDY0RvUEpvMEFkOXp4c2RHU3lqbzFvbi9xNkJuTXF6dWVwOFdudzNQajUr?=
 =?utf-8?Q?Gtd5kLGK+fK5wMNWTdxyf9Agv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ead93ba-e8b7-4644-4f31-08dc4b4ed62d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 15:35:15.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHgcl8ZTBMGlT1izlRhRADGODh1Gd8lP7TSnfOLhXJQdDs5kNyj+O3uEKaaY78vuiH7TLGGwzdj2wO1GKNoYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

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
Changes in v3:
- Change clock name form CHXX-CLK to chxx
- Fix typeo 'clock'
- Add dma-cell description
- About clock-names:
  items:
    oneOf:
      - const: dma
      - pattern: ...

Which already detect naming wrong, for example:

clock-names = "dma", "ch00", "ch01", "ch02", "ch03",                       
              ....                                                         
              "ch28", "ch29", "ch30", "abcc";                              
                                                                           
                                                                           
arch/arm64/boot/dts/freescale/imx8ulp-evk.dtb: dma-controller@29010000: clock-names:32: 'oneOf' conditional failed, one must be fixed:
        'dma' was expected                                                 
        'abcc' does not match '^ch(0[0-9]|[1-2][0-9]|3[01])$'  

Only lose order check, such as ch00, dma, ch03, ch02, can pass check.
I think it is good enough. 

I tried rob's suggestion, but met some technology issue. Detail see

https://lore.kernel.org/imx/20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com/T/#mc5767dd505d4b7cfc66586a0631684a57e735476

- Link to v2: https://lore.kernel.org/r/20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com

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

 .../devicetree/bindings/dma/fsl,edma.yaml          | 40 +++++++++++++++++-
 drivers/dma/fsl-edma-common.c                      |  6 +++
 drivers/dma/fsl-edma-common.h                      |  2 -
 drivers/dma/fsl-edma-main.c                        | 47 ++++++++++++++++------
 drivers/dma/mcf-edma-main.c                        |  4 +-
 5 files changed, 80 insertions(+), 19 deletions(-)
---
base-commit: 37cbf12c590dbe3e66c6d489aaf9b35f7b6a0670
change-id: 20240227-8ulp_edma-12ee2648d74b

Best regards,
---
Frank Li <Frank.Li@nxp.com>


