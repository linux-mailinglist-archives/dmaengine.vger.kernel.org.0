Return-Path: <dmaengine+bounces-1477-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BB887940
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 16:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A7D282DFF
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052C57861;
	Sat, 23 Mar 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SGXMSiGO"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7454772;
	Sat, 23 Mar 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208129; cv=fail; b=jagU1IGbNdirlZh2E++VuNcsVj37TUq8YTeFoStfi37UFiC87BKc/ez0FgIQrlSZE/r69gASItU2RVz7pq0nKuV+t/x/Gz2/E/Rb2vl+/WkNP60IdOMfCE7vI84jPzIWvFcEwOV47j4v4jephTuitTuvsaBwqpGpAZaeS8es64g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208129; c=relaxed/simple;
	bh=jmlf1mu9SIIEHrRpBqByG+5+aDGIj5pcURPTe4jRfQw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=foCxomYsxanC7wte6J3qhU2hLG/Vqs0P0/HzVoj6EbvX0KTPuseZIMD1iJ9EGQeJ0RL8+url2jWI5soAnwJ20ZQpaTljC6V1LfqhDh99zq53rvEjHsqsPS9Q4cKq7syOVmEbkTmDcNINJezWFq2AYFFm4dkBSLeylY75TDmdjm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SGXMSiGO; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZsuDn79WnXL0JUhfptrCqiMPgdwnYN86VA+/AIiJNyFiUnV4cVIAyPA790/WhCpvaHZbTXh0VZ/sM2/mTR6Jw6LlkaJK42MqagghB47wCKsTBGGQf2Z0kRNWdqSfkzHHaFvZNv2i2pmJz/xnOz0lZ+QJC9zx0XgQIUyAjzUTu1hJWblD2BH2FYTj/VMcRpHNT+FzWdySemtIx19LuTRRs61NpwY9/JFpXZcNgAThXKA9ir27ljJVTWx++mX3hgCPmAsYkvjOLJhwZCPOY4NzWUILQ9LWxTvzMPAHzoN5YvPUFRtroEkMDPJRjmAG3UfRpo/W1Heg26nZcEyXolPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imaT9IItAsYq0kzb6hA89QzoqQlsZKPxNqqPWFASA1I=;
 b=fVauPk/bSwHJ8Tad/BVUt+MPqZJHfpo9XnGvP5W2D2MvUUQSKYIXEnGU/Tg8RoxR8hXMHcUUUicI+o01UouszB3dpA/9xQPrbkczl2Ovkj6iHi+THW+LV8BMIllOFo4o/wZSZJgjZsiqrRBVLxjM2w9GhETGJbUGY+8JOunnxNBekSMevyQh3dKBQOB3cy/+8MAJSSK7tRTutTGBT5WZQFqmqc1Bue0T/hJBeQ6nwfsV6yrOXLfgxWXKaD9GJAaE/ZsDXJWlbHXYuSGZcjNpB3FnxEcN9axietobEiOViFHgngra8fPciTiolBOf0EPsqivf5A3hSnWSKeqexTwj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imaT9IItAsYq0kzb6hA89QzoqQlsZKPxNqqPWFASA1I=;
 b=SGXMSiGOEasPY/PPboIAJcXBVD2Qe64nqlJWvhhw2d4ypmJA1eMIuE9h4+x6MN2/c8v9x6/FfL04lxoIP2P7pkbMO8iDQKueIKE/z/mk93cmtm6dJ3wm4WXRC2kw/2uCl7y8/m6Q4c3dSrZJHiybtt7kXLueMeBnNTEkGXc4T8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 15:35:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 15:35:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 23 Mar 2024 11:34:53 -0400
Subject: [PATCH v3 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-8ulp_edma-v3-4-c0e981027c05@nxp.com>
References: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
In-Reply-To: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711208112; l=3937;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UmrfX1DWfzT62mckua+anmk2tRhZNJCIIZ6G3njiUg4=;
 b=qhueX0+1U1qmjr4RqY4hiT92RLSAsXV/HlEa0iX1ZO3XgixIBT1sL8ZMjIOXiuylBX6FzbijE
 TqgjqFN3rPZBL6fqojV4+y9ZYM+/VSLcNjCy6+udwaWxSOHtY4MjqOh
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
X-MS-Office365-Filtering-Correlation-Id: 20db2aa6-17fb-4f95-1b34-08dc4b4edc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2IuXSQz70Bva61DvXVpyrdi4x68MYkNuGl389KQPHuIRGKRdoxqctyEk19JkF7ADFzpXqNSQkQHHC9WbnDtFIGxcMdf5DDBFZFpR4gsc2URJkP7f+bGISmEWF/F7ntvvCItLuW5r+0Zh7nl4Xq5IhE1PHRTn6CeEo2RW+WjDYUAg4lP5IfMHlpU5tgVWJGUaMacRW/aKoHGHkqSTkJH5NWOzthuB2xLgaYZsT0vZLTrTVZWa/4vrB2JAy8bDupDxyO0gN9wfsQIfCxXDTFLtqp8ogyI23xuw3+UtgBGU+S+hou88NUZP6TGwp0aV+UQbWWTfw8gzf0GrKxZbDhANtKfnQ7qz8e2usUBVnRe2SDw2qcHu4QYTjpDru6V/bwZuv0jYdBff5wLc7Ric1MXBtYNHcJI6wLI0DTK/9lwsqIPNLU9zg473TuBDB41wmCqPDnywYzs4027YiCo/uFH4bBO8mmCKoqa2xaVuOA4pgNFSBCYCXjTp6zMc9iBlpOaTW7GLEGWo/fKRh1RApPNuEvei1REkVYiSrdzMshvZ4t+Sl4p+aU5l2+t+QDhQx2bNcIoNmec1UVb+wGSrdRXTPpmXaoij2Kjq2BMQtgonZKvYvNK0gmfUf6S6QuhbRx6GgUePv8TMPc8VyPqi3HJBzEpiOvRkMWLIhF+Sgce5KM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGl0U0pLd2VBSWxWcFRyUEtiNWVwdmJDc3IraTloR3Zkd3dKakxXT0lySDhT?=
 =?utf-8?B?TTZuVGhHZjhpR25nK2t4N0wyYk9Uc0FZeCt5L0htZktEd09SZmlnZDBzS0Nu?=
 =?utf-8?B?TzRpaU82YzVQY1ExTXFWMkFXNHhESFJ2L0JFMWxSV2ZpVmdaYWh5NDlJRnpC?=
 =?utf-8?B?TXFnaXF6a1FhWWlvcDB0V3VpNGhuTTZHNUpIQ0NvWjRRenRNaWlhd3VYUmVN?=
 =?utf-8?B?YXpOTXUvcmZmWlNOc1JwaHFmRmpQWXErY2syc24xb1J2NEI3VUdkcElPblJC?=
 =?utf-8?B?ZEFTY2JmSzRPS0JsZVZCa09QUDdKUEpqZGFKUkw0TmdhOUtkUmNtSUdac3hG?=
 =?utf-8?B?aEdoby8xb21Za3R2dkMyNEpFWkRzRkFydzd2emlGeXBNMG9mZXp0TFFkUk1n?=
 =?utf-8?B?RTNtY3A4eXMybEo5MFJNRVpEMU5YUUY5T3VTaFFaSkFNbWxJUURReGZOb3FS?=
 =?utf-8?B?SDIrTk1KQldybmFMSXZlZ1ZvUFdiSFNsVnJxSU1Vb3RGOFFKTkJ2eW9NZHJC?=
 =?utf-8?B?S2V2cElYVGNtN3VFMyszYWJHNG9MazZQU29OSkNLV1VOaEVKdm5jUGJhOHM1?=
 =?utf-8?B?c0kvaml6czJGVVVVZWhDMHF6NHZXRUxIaVhYN1l3UWZGK2lEOXhhZ0RUVkRX?=
 =?utf-8?B?UnRzQU5aTjZwVDZvVjd0V1RmMEF3SHVtOFVRaVU1UlNOWnZsRlRBTUdPUWk5?=
 =?utf-8?B?NTFxRnRWYXE0Nkh6SllDY1NlbmJpRk5uemFIOFZCMUZXaHB0SEJUS1ZiWTF3?=
 =?utf-8?B?WDVIZ2owbUlvMDh3MkJNQytHWG01UDZyUmJMOGNZK2VWVzgvYW0wT1hVQ3d4?=
 =?utf-8?B?ZG9jVjBXQ2VMUGlsMUVCVEh6dU5QM1pCZEpGcWk1WXUxSFNsSzNwWEw2RVYx?=
 =?utf-8?B?MUdvTW8vazJxMVI3d3p3NGVjZ1k2VE9Kb3RnTm9vV3ltN2dtOENaN0JOazhM?=
 =?utf-8?B?cXM4KzRPbUhOR09uWXQ2dE5lOS9HdHdkUy82MGRralRXZi9QVVdoSUo0SjJj?=
 =?utf-8?B?bmEwRlNNdjBWd1p0RlZ1ZlZzenAxZGU4TlM4R2plMHIyRDdQdVRwR3RKSzEv?=
 =?utf-8?B?cDlOdCtlOGxrVzBJNnYwUzBuVG9hUi93dklOV3B4RnpwSXdjNFdFcUVJZi95?=
 =?utf-8?B?WUxXdG1ZVVk3TzJjMW92bHQ0UEpWN3FiUlJVeHVhSmd4OVRYS1o4ZHZIend5?=
 =?utf-8?B?RmxMNzNNRjFpeEF4U0Q4cWtRUXh1ME1tenkvSmZnWXk1WVRGSGsvbFVFUzM2?=
 =?utf-8?B?Vms5WjYzQmRXSFVCOVZTZUVqMWRQY0xXNjgyd0VkeUp0azFiNmZrSnpMdm9Y?=
 =?utf-8?B?cjZJYmgvMzFjZU5rZkhyM0ZRVis5NkxVQ0tDemVOTWhxNFJLR0JBaTFUMDcv?=
 =?utf-8?B?T1RRZG80MjdEZTBxUDJObGJpeTlhdnVNV0JHYjJMWTB6eHZTb2NkdDd6MStJ?=
 =?utf-8?B?RHRRdHdwazZ3Qnc5MnBmaFJ3NnlJcXUyM1JNV0NWLzBjakxsOVBFTkJuZ1V1?=
 =?utf-8?B?NHMxSEFadVYzVy9hN3BOYjcxeWtEaGpZS1A3VDVOZ3FsRUlJM20vZDdkc3JH?=
 =?utf-8?B?cnFGWVZIbE82bkthVXFPcm8vekZJVlg3Q2dXMUIwWGpuYkJrWFZUMmUzNGR6?=
 =?utf-8?B?cUhsR0JQeTcwRURnNzJHZUd6ZHdPVGVLNHR0TUg5MWRoTS9JbXUwQ08weVo2?=
 =?utf-8?B?SU9BdE9TUlBjbEcyc3loR3VtL2Y1eEtUNjlKVXNSQmlXajkwbGxRVTN0b2FP?=
 =?utf-8?B?RFVVUUt1ckM3VzhNZ2xEMkFpRWVwS25RR3RVRTlFM2J5THhrWHRqcVArMVM1?=
 =?utf-8?B?WTVXRFVOYWlva1Bsb0twMFRldWhaRC83SmRTbFZVMExzSTZxbGUvc3piWEJT?=
 =?utf-8?B?YlVLanJQR1BwdnA5Rk5TbmFiblMwOTRNYXBlUVFxN2N1L2hXeDVwQnp6eVVY?=
 =?utf-8?B?THhYTHpLaGJodzRpREpKcHFzb2dQQlBsYjhMQ0xxOXE0K0h3VkorS29mK0hm?=
 =?utf-8?B?QnBwVTdncFZFNmFSbVFRdFRpakNjRzdqUzBiaHljcXZaelovTFB4dTBNc045?=
 =?utf-8?B?b1RTZG9hM01jRmpKQWxwYlVyM3FGTGtsbkltbGpqeDJTYWpvcmtsc0FUN2lO?=
 =?utf-8?Q?ZDXsyyHuVkJXxOY1VrZRXjZF7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20db2aa6-17fb-4f95-1b34-08dc4b4edc6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 15:35:25.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYFL34A3Jr2w1zmcpBHOeJqYqmdELd19PH+ZA0FlHS/ZjvLlkzn2EgjO4ltSisLUgZ4zmIKMikCzSdDYRleJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

From: Joy Zou <joy.zou@nxp.com>

Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
eDMA architecture features one clock for each DMA channel and an additional
clock for the core controller. Given a maximum of 32 DMA channels, the
maximum clock number consequently increases to 33.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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

 .../devicetree/bindings/dma/fsl,edma.yaml          | 40 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index aa51d278cb67b..825f4715499e5 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -23,6 +23,7 @@ properties:
           - fsl,imx7ulp-edma
           - fsl,imx8qm-adma
           - fsl,imx8qm-edma
+          - fsl,imx8ulp-edma
           - fsl,imx93-edma3
           - fsl,imx93-edma4
           - fsl,imx95-edma5
@@ -43,6 +44,17 @@ properties:
     maxItems: 64
 
   "#dma-cells":
+    description: |
+      Specifies the number of cells needed to encode an DMA channel.
+
+      Encode for cells number 2:
+        cell 0: index of dma channel mux instance.
+        cell 1: peripheral dma request id.
+
+      Encode for cells number 3:
+        cell 0: peripheral dma request id.
+        cell 1: dma channel priority.
+        cell 2: bitmask, defined at include/dt-bindings/dma/fsl-edma.h
     enum:
       - 2
       - 3
@@ -53,11 +65,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 33
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 33
 
   big-endian:
     description: |
@@ -108,6 +120,7 @@ allOf:
       properties:
         clocks:
           minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: dmamux0
@@ -136,6 +149,7 @@ allOf:
       properties:
         clock:
           minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: dma
@@ -151,6 +165,28 @@ allOf:
         dma-channels:
           const: 32
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8ulp-edma
+    then:
+      properties:
+        clocks:
+          minItems: 33
+        clock-names:
+          minItems: 33
+          items:
+            oneOf:
+              - const: dma
+              - pattern: "^ch(0[0-9]|[1-2][0-9]|3[01])$"
+
+        interrupt-names: false
+        interrupts:
+          minItems: 32
+        "#dma-cells":
+          const: 3
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1


