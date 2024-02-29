Return-Path: <dmaengine+bounces-1210-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7669D86D5CF
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 22:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5581C229E6
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC55157E86;
	Thu, 29 Feb 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dJcqudQl"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E7157AF9;
	Thu, 29 Feb 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240354; cv=fail; b=UxA70I3GoItLY6YLAB3wmYqUZAGPdvUjwlEHQnufwj4RMBtCjUuZxg3LcJJtwmeKr61O7xRps6Mv4tMxcCL0/twF5jtuEhU8HhuhT0P4sCAvLBjUMsjjBsTW+tqFs6NnTIuR0ZFyKZ8I7NBk1rQb6K5/aFnB+2fS8IJVVf93OcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240354; c=relaxed/simple;
	bh=sVHqn6H+sRc+UeESOOt1xPOX/umNA7g2fhLtywnubOI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jRBqIojmSwc5q/YkINXcwAulLyN4+vyNHxo1ifvcZ4Yy/J905F4TRPDIupOn2jsTK8I87F607Q7DUvWDS2NM6e73rVCNPijLuL05TMj+dhx0yGekTnx5b1s5f+l243bsmLuYen7wVdiQhaKI2DI0WMUdTs+yvAsNgghSSbxLV4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dJcqudQl; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi1hMRVHilYOpAdzMdQR9FFgpWlsyAwk2nEIbONbHljgoGv0SrwqNhAVEa1hEUmMVA/Gup0rlXujrdYSmRJbGl7N2kImDrJ+7VrywL4kGUi78dMfSG6B+CCiQU/EAYob6PPgkc8xHhMS336oyXMVvFuann4Epg079FBwlxuadRCWzTTTS8yB4aPC5F+jap65PGKEbvLtVB3sglPfTRqAJgMOMONQgiSbV16GdM60I/6Bmmd2h6HBysB5F/kpicU8+0axM5iaIHNfWDCQQC51gIRkXdfgXkiotE8636sxec0NBFezgq8LdOV8gAsmUbxYDXQIYc5OoS5hRKbfADVK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xiz0Rtwc5CT1HzkoGwV9jE8Y6y1f6whfBWTv6CN9GT8=;
 b=ES8k9CNqAuhJnVcvdzREm0O0CmaDWDvcmKjuhrkjlts+8PeOugQ5N62y/vR4vZMo8EvTZv0hbFS7hphsxIQKDc/WT/9/1a/1ce90EH7mD2xtfJob0lGZiW4DeK8O/lycLPMfd9Sh1l03I8XsXGzwzeVVWYVCZCiyJvikI0wxtp3xWTU/4fYIRmm+is5VLgzAtoi9o4brYE8nBGMEFJ/mOGoFiZcx7y7dZuGV6lf/Y2gD4FgTdtArlfMwM9T0L8x9YkuF3QlEkUbIcMyPMrwShRWxRD1d/46ohd22KUIT6gA3EBE7lroD8z1HkjaAXKb43y/0ovsjdBOLbjLbn+JgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xiz0Rtwc5CT1HzkoGwV9jE8Y6y1f6whfBWTv6CN9GT8=;
 b=dJcqudQlFE9atGwUgP6veGL1pcc7pWxmA6/9PyzvaNWlFkUkjwK0wG08rfVfwA5ddolG5BHy8jjUWCSshdIR7YzY0ux7kbsoDAeYM1O8xe+xtfd8dUZ1XIWmrm30+0rChgJHzfBTSkKCwxR7A1e6qszAi/tVqswaLuh9qJtWcEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Thu, 29 Feb
 2024 20:59:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:59:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Feb 2024 15:58:11 -0500
Subject: [PATCH v2 5/5] dmaengine: fsl-edma: add i.MX8ULP edma support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-8ulp_edma-v2-5-9d12f883c8f7@nxp.com>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
In-Reply-To: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709240333; l=4648;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mZwQhUw7aTNjqUrbP8MTrIFtWNHaiIzM6PH4ott4At8=;
 b=GocKVEUJOnuGokK3N8i0kHvko6GHWHDEfwLd/IkuE/c5DDU7vAHmopefrPkEWsqTDAa6Kj4ks
 Jgt2+eytIPgDlWmkBrOTYdGqr/9EEC0V2Hjf7tn5Cpq6kctrBEL17fs
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
X-MS-Office365-Filtering-Correlation-Id: c52d7cae-6465-49c7-30b3-08dc396946a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8qnqoIVdpHhocoDwRmV12iORlukSF3ARoMPT6qsYlY4dd19+xRylShHhC7gaseFSWGs7vUUe0IvpFRvx+qrT6+USBld3+2yy09wSN0eed2UuqYmaqoEiPOVCnyvX329qOCykcZ8n5XEui2Q/PnF8VLxZxDjyVT73gN9S2n3km6Wmr5SjWc503BAO23qFXXdrOumjOgLWePj9aJHJkPU4xUE0K8vpC+wC2NJDtbRua7UhfV1weQTBfoGFDjEVpaW46RK1B9kzL8iNTE9zbRchBO+G2rtbmljbMGvFFMmgcsJEKB9/bN9JE+Gjw4vHwv1Lclt1G8VWsPVSsKXDeiAjmJ8dlrdJ+U6y0BaPSrwOp5keclzUemZFYXJGeYowv/jUxrWEn6bZbrGl4QDM/lSgYJAySCFy037g/ogrAqB802yBT5YoaEbn6nkqaa6qSpZpdVP66lPj60SsEd34MeEmVQ4k8aWc0Bm1kQD+NNPcEV+qc2Z42+mtW5iI0HmAVaqftU8R6z9YqXAPcqZE0X8gLFr6elfnC/4UpfcAg1haZ4Yczb9jRAsEduh38GrMS5Fo+oOxvMCPRwzD9/gp7NURjDGn4yhOTEWAMEprreNQsWRn5LFRfA1i/2z6mpOijjMIlQgfOvaTUlXyl8/8vM0ldWcMsJNLBdt/iagDbym+HvdgKX0lbbPuoKBg2M2mJZsPqRQ9YKYUk5wfkPBDi1D6BXLRytPZcsaYE+Pt264e/cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2VzSnBVRE1KVFRMN2gvQk0xZ3dPMTFJK01LNml1V3FiSm1xWU9QckpXbjV0?=
 =?utf-8?B?SUc1OTlUR1FER1dRYUwxOWdsL0h3ZTR4V0QxOTh1ZWs1U0ZuSnRucll2RHVB?=
 =?utf-8?B?NHQ5M2Z4TUxEa1htT1kxL1Q4a2FYdWpXRmkwZXhicnFjaTROaXJ0UmgwZ2R3?=
 =?utf-8?B?dDBYdHVGZ055STRzUG4zdkNHbXNVb3RySU1BcDdEQ0cvOW92TlFCNDFDNm9I?=
 =?utf-8?B?b1Y5cnhobTE5N1ZpemhYSjhWdlBoTjZ4RE45bXBmMnp3c3ZGQk5SSlhhL3pw?=
 =?utf-8?B?QkdFNXhDeC9FTm16Tmoza3NDUDNpT1JsWC9CNW50bXJ1cnltWGJhckxDRkZO?=
 =?utf-8?B?M0g2TnlZQ0hZZ0liU0RFaVBrc2VISC9mWnlrdzFPaDdrYnpONnJaV3B0ckpO?=
 =?utf-8?B?cDdwK2pwMldrczRLbU05YnRjREVhM1NYUU5UeGYrOFRDbUVsQ29rMGg5eXJz?=
 =?utf-8?B?ZjRkSkg4OThRTmhGS3k1ZDc0M0VBRzI5MHo4TFBQSXQ2MjFyaFNLZWhmdVdF?=
 =?utf-8?B?UjM0RWtJOGdGTElWdk12RWxGRlVVZUpJMmtjMkNRemxPTkRPNEt1QjVwbDZT?=
 =?utf-8?B?RmpLVWljTjhTd3ZMaU45K3Rza3VKN1FjcmhNRXBCWDVsekdKdEEyL1VienNF?=
 =?utf-8?B?djFKbEIvc0JFcSswajR1TER2cGtDSDNSdDVtN1VvRTZKTE9jK0lLRVdZSDZQ?=
 =?utf-8?B?Qm9mdWZMb3hMVmJMVVNQQU1uOHUveHcrQk1admZJZlFhRW91cXRKb1M2T2Nj?=
 =?utf-8?B?QTM3U2VEMG1SOWNPdGZLdnB1a2pNcjFvK3h1SW9ZN0N0anBFUzVwUjFDS1Mw?=
 =?utf-8?B?a3FkL0VpcnQ0SElIcGM3RUlNTGtSOXI2QXlMNm5QN3ZVYi9ZQm5tazJjdlVK?=
 =?utf-8?B?b2FVa1YxWk5WSTh4eHFHdzRPK1FESlRreUhROTZoRXRaZm5SQ3JzdkM1NFJj?=
 =?utf-8?B?c01ER282VW1lUi8ydHl0dUFiUXg0ckJsMHA2TjVJY2NLQ0E5OWJCR3FOUkZo?=
 =?utf-8?B?eTF1aDd4RXpEbFZ3L1lEUkNYUXZHZElnc3M2TmI0TytvZjE4d1NoWlBudkhU?=
 =?utf-8?B?WXgrZ291YnZVKzZGQ0t4ZytZTTFzYVcxYTFITDU1cmRoUWh6eW96MnBDWXRp?=
 =?utf-8?B?N0Z5TENBVkc0bXRmVGl2azJlSzJOSVdkelNCbkdRRnI1a1JuclRuRGlhZ0tk?=
 =?utf-8?B?R1NpY3hQSldjbTk5eEYzSTN3dWxyY3hETW5aeDJIdkF1RThSRlJ5Kzk1QmQx?=
 =?utf-8?B?ZGVSSGRYUXozZDRjVzVwTmlFRGVkVjRTNCtzd0pEYkk3YzE5bkhZdndWRXlC?=
 =?utf-8?B?RVRyNVI1VTgvdDFLWHpjazY1cXFtTnhRdzJ3WVA3U0ViVWhjWmc1bUI1TGI0?=
 =?utf-8?B?SWh2b0oxcTEzUGtsWmRvTkVGTkFEa0laZ2p4U1NUT0lCRktmcWwyZUFxZ3VJ?=
 =?utf-8?B?R0JHVlB1aEtpNXZSTkNTWENWUDhCVTFVMzcwNmJBUTRoc0xyYkZXbnMzVVdD?=
 =?utf-8?B?OVprajczVnFJR2NUbm9GeVd0OHkxTVJtRjN6SzZlQkZLekg0QkNIV2EwdG5V?=
 =?utf-8?B?TWhCcXpaS1pBTUtqcy9FcFBEY0RHMk14SlVzMVFidlBBZmdOMm5WdzcrbGp5?=
 =?utf-8?B?cldwV1JKU1FVUm5NM2hZK0JRUWdWU3lrNWZkOXJyVTh3S2wwbGFhVXc2QWd2?=
 =?utf-8?B?dm00a1hDalhqOVJoMVIvWkVubHN3L0RQbzgvRERlNzBNMEl6dkVzLzhWRE4r?=
 =?utf-8?B?S0t6dmVBbFd3ckNkRFc0NHdFQWZWV1Z5eXJIeWV0M3ZpZjRLOHJlTjdMcDBY?=
 =?utf-8?B?TUZNTXR2L2kzbWlsbmJ0NG5KMXpOL1A5SlM0dmUvTHp2WlRuV1RGM3dabDhP?=
 =?utf-8?B?dzVwZVhnZVRUbGdoVkNWc1ZYVEEzZSthdVlIL1dQdGczd2Y3ZlF6N1lZY0Rr?=
 =?utf-8?B?MktKQmpBRmJ4ekRGajZTYnRJRVVyejdDREJtaXIyeHJHc2RxOU1zemEwRi9G?=
 =?utf-8?B?WjM2VDB0a3NOOW5XK0RSWis4ZHRabVNjaFJBUVNhN2ZvaGsvWGFSSUl3SzBB?=
 =?utf-8?B?WW9vU1lTWVp0UEFNOG94allmZjZvMjl3R0d1RTkyUjg0OFRWazErNVEyY0c1?=
 =?utf-8?Q?JrGSqzmjoGGiYY00Fv5i+oEol?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52d7cae-6465-49c7-30b3-08dc396946a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:59:10.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAzqPHeLTZZI4GUC29fOOFxNBRhoEnGcV+N4Iww2+QXwgvWC036NPTzufQJ3bWSE7+n8CKSKVmNZ8dV8MnOPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750

From: Joy Zou <joy.zou@nxp.com>

Add support for the i.MX8ULP platform to the eDMA driver. Introduce the use
of the correct FSL_EDMA_DRV_HAS_CHCLK flag to handle per-channel clock
configurations.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  6 ++++++
 drivers/dma/fsl-edma-common.h |  1 +
 drivers/dma/fsl-edma-main.c   | 22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b18faa7cfedb9..f9144b0154396 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2013-2014 Freescale Semiconductor, Inc
 // Copyright (c) 2017 Sysam, Angelo Dureghello  <angelo@sysam.it>
 
+#include <linux/clk.h>
 #include <linux/dmapool.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -810,6 +811,9 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
+		clk_prepare_enable(fsl_chan->clk);
+
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
@@ -838,6 +842,8 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = NULL;
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
+		clk_disable_unprepare(fsl_chan->clk);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 532f647e540e7..01157912bfd5f 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -192,6 +192,7 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
+#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
 /* imx8 QM audio edma remote local swapped */
 #define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 41c71c360ff1f..0837535aa7548 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -356,6 +356,16 @@ static struct fsl_edma_drvdata imx8qm_audio_data = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
+static struct fsl_edma_drvdata imx8ulp_data = {
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
+		 FSL_EDMA_DRV_EDMA3,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
+	.mux_skip = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
 static struct fsl_edma_drvdata imx93_data3 = {
 	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
 	.chreg_space_sz = 0x10000,
@@ -388,6 +398,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
 	{ .compatible = "fsl,imx8qm-edma", .data = &imx8qm_data},
 	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
+	{ .compatible = "fsl,imx8ulp-edma", .data = &imx8ulp_data},
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
 	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
@@ -441,6 +452,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma;
 	const struct fsl_edma_drvdata *drvdata = NULL;
 	u32 chan_mask[2] = {0, 0};
+	char clk_name[36];
 	struct edma_regs *regs;
 	int chans;
 	int ret, i;
@@ -550,11 +562,21 @@ static int fsl_edma_probe(struct platform_device *pdev)
 				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
 		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
 
+		if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
+			snprintf(clk_name, sizeof(clk_name), "CH%02d-clk", i);
+			fsl_chan->clk = devm_clk_get_enabled(&pdev->dev,
+							     (const char *)clk_name);
+
+			if (IS_ERR(fsl_chan->clk))
+				return PTR_ERR(fsl_chan->clk);
+		}
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
 		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
+		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
+			clk_disable_unprepare(fsl_chan->clk);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);

-- 
2.34.1


