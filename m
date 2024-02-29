Return-Path: <dmaengine+bounces-1206-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD7786D5C3
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 22:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F35628E8C7
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847A155A39;
	Thu, 29 Feb 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="isj1jj4t"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2F1552ED;
	Thu, 29 Feb 2024 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240343; cv=fail; b=Vx0iNOIaEPY+mqMOWtpV9cgewcupSZC50Fpxh/X9EApfakqJ9LpjqCqTHQ2Quv1OvlpLXzGXm83r9xVZfuseFcw2duf2P0IdlrkVhalLUXlFXiqoY0s0oqXATLbXQAroP6TuJM+R9IFYow2Ot1qfVmo/HRQkr0uEHGJigKejHE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240343; c=relaxed/simple;
	bh=YZqvNpVwks9iUdy1m5WD7RpsLTnC33dYL8qYlc2nwns=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dU843g3uy2A3FS5Qginrgk5nbBkGsk9ELYs3SDwp9XS4L/5KN46xVc8XToIfdzUGdC7rbSw7fRrjOisSaJvqbm+TiYdkT97iJsr97P1C0vT0UZgHmRbd2a3c1FmAz1MmT9IJXOWguVIo0TOT7Q2e9sAv77SC4vsDKQH1CTKK4Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=isj1jj4t; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtUVHjbvTf3CYb7oHyc1Sq0RjwuGNSCTwXlKCqYjYfZL2T/srYD1KdUGWURDynl5pXSGVypOEn0rH1Ix0x2HLHpnCiaISj9GB9gBHTj0DuBNwPbEryfPLgk5nankG5wz3u13pd22f32rl0RpMryTubf75Yqz+0IwTaXNCqxMX7zaGjzcOV8VxHdx3dr9rl6fHBnZLSklDiKlMulHWQnzIwDxbnK+dfNXaN3Tr+uxss0TZnL8VwjMGoPClSEk/RJ3W54So5Q151j/LcJ1co3NUR2sFIyTbEdXX36JDpQX90WhwHqj7b3UfaflZ//d+Cf/xasY9a8xjnG6HbqLOkyrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9vB4OwEoRdCLUY1BP0w7hccRMhYCWqyz+SfWM5vr7Q=;
 b=Fkl9DLdSUj2Sh9KICzpsi6lcuPRpNk+aNANgmo40jv+Ob5UUrDqXnrXKbA4XwWNe2thHBR/H0Bmre2YPdm6rN8oGIHa5Ug+WwzxUR+nWBRNd3Q787TWzgLSYWez+zy8FxIPhZUnomcXG5Mp4dYW6ZNZS2C4X//Hrjx5kwGG/X48zBf9DLiIFHePKraLT19Jej14kGnGYO0ud/ivw32OyHX8qLdv+Brs67emo7AYlICpp611roFTgtEiaFEvjHBz9wJ5aycv2XPd03uQRU2yg8iH/Sc6g6K9ZvwhtH68jK11YW4yhHIyAGPxS9SvrKaqe58U88bMYOcNHfeujinOfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9vB4OwEoRdCLUY1BP0w7hccRMhYCWqyz+SfWM5vr7Q=;
 b=isj1jj4t6SWyUbPmoRtUYE6P9FQFdTq8RYShQlhmWRWyqKIcTMACnARBlvjKXRlIOooENjfuT3b/s9pTkezB15EUvutrTZUtHhr/YTows2ZauIiviVghIHAv9AxSCfJKaiWr0vpFtQubILA9zMP9tQ8q/H/6GXy789N2a3aoerg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Thu, 29 Feb
 2024 20:58:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:58:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Feb 2024 15:58:07 -0500
Subject: [PATCH v2 1/5] dmaengine: fsl-edma: remove 'slave_id' from
 fsl_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-8ulp_edma-v2-1-9d12f883c8f7@nxp.com>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
In-Reply-To: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709240333; l=3059;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YZqvNpVwks9iUdy1m5WD7RpsLTnC33dYL8qYlc2nwns=;
 b=Zz+9dzeyam/Le+5FYweAqg5eDM7wQ0jl+Firgi8RgQh8caF3O8vZkDYDqxFwzRLsZjEWgZ1cz
 6nSUFX7TlK9CYf+giBu+4ryqLiYejDlrV7J0VtGXAyV149q+pUAvsFB
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
X-MS-Office365-Filtering-Correlation-Id: bc2fd6c9-de8e-453a-0832-08dc39694015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6W7IwT3hQ99FdkTUFVEooMkzq4waSL5C3rpomDzgRyE5Qxmoo300pqVS4tOnniA1tX80mTBGVyL2ZDcJIx1J2bq5kUigRiqXzyPgolBhK5rWBggg2phK/1O9RmclH7GrjyVkH4N/PweGjWsdgXri55aOZ1bg2u2I4HLyDnwjvlRV7XST6cNUthJJ0XLL2zZSqrfJSa92QDTSByIQO8IoDGkDQrmgmugiKjh1yEZ5fgzbzPjDt5vsZVxGMZTRwZ6gUQ3KPLDxT1VJprfKJYKeLGj9VIOt1PZznd84bou32AhsAWAGErzem0YQS/uK8hCPlCMi5peyYyuVgctaE0219iG8ESKOeU3aCQrSKnvT5GAQq6Ck56SLRrMrJZLi5rn/qAJYxD2BFotxlYADx77387DFBZdWy4AiJG6jis9n6p6GEvDzQHK9V/i4eHblr/slWz95HF8iwUnGCCSWrELld3jSnZJIwPdSavogQm7/xthhy0UjzH/1NEbbJlkDDihokE/VnHWK0T6+2VOzkPnnEnyenh8kdun3WTU44F8kB0gzCsJ3KhBl4ICT6AeLn4GbQbez3nENvxNP2K+OHZHFwxy2JAtQy1q5CKvVrYCxRH73M3MpgbGYfwI909rpqNVYtyXo6Z1ATTTCueqICVlInmYw7gQhekg2bhK74b1B9qyfb+ao61qtBXEaeR1W0PmH8e2csHUEzmef0zGJek4gMJyjmw3tRxYN0IOR9RqXzow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3daMXQ5YngvWittRk9uRkdLeGhPU09aYUZrNUZ6NW9NdXRJZkc3TUtjQjg5?=
 =?utf-8?B?Q3VqYkhTdEZweERHMmdLVzBPMG5oVHlMS2N4d3g5QlljWkhIYjlaTk0wVC9T?=
 =?utf-8?B?ZGluN0xCQzVxN0J1ODRNQTBJTEErTkVjRDlJU0J0Z2h4aE1qTmJRR2M1SExZ?=
 =?utf-8?B?UmZsQlpSZFVLUTJTUlNWam0rRE1rWG1RUUNUTm9RVEx4dy80akZxVDJER1hh?=
 =?utf-8?B?WkZEcWVZS3JJRHN6RUNpNmpDcmFBZlF6YVk3NVFUYmtyZVdzaWc1ZERaTVk4?=
 =?utf-8?B?SDk1ZmtIY3F4b1NvS2dSSGlJZ0xURmIxeXRvZkdtbFhnQjFiOHpXVDQzT0cv?=
 =?utf-8?B?eVNZQ1p1SHhiaGYxaytVWXg3VEN3ZGZVa1hhNThwQTB0cFZDdERJVXl3a2lN?=
 =?utf-8?B?c1ZxRjJEM09yd1BtMURqb1dPcTR6SlNISUJJQldoQkhjaXhWSlBxNjFSakRW?=
 =?utf-8?B?eWUwL0loZzMvMzBVYmZwQjJDa21uL0tZYi9ZUGhZSTAxWngwVTh5SFlPZUdL?=
 =?utf-8?B?My82aUpmRnFwcElxbXRGYUtXTFJFWDVGcktLZnVRN1d0cXNyay81dUM5N2tB?=
 =?utf-8?B?MUZsS1UyVHJIYzJobXNvQkFRS3pmbFUwV0p2SVhIWTVrOVFKTzJQTC82Wklj?=
 =?utf-8?B?WkxVYnJZdGlRM0FjWHJOSXQ2bFlIaHg2TWx5MkdETEZkSFFEUUJqVlZVVGpU?=
 =?utf-8?B?TnI2Y1NHRlBYTEpZTVFkRVVSQmVGQTBpZERrNGU1S0k5akhmd3lYYjFrUXBu?=
 =?utf-8?B?N3REVkdtQTFJcUYvOXVySGhWSG1iclBNOXR5enVHcHBvQzM3QlEvL0VkR2ND?=
 =?utf-8?B?M1VIQWExeG45WnZiSjN3TE44NnFWbVNvSTc4bW0zWU1pSTlGMFN1YTk4QUg0?=
 =?utf-8?B?UlE5bzV0QWtJR0pFeVFBaGxwRDl1bWRyWnRWb0VHK2dVZTJ2SEk2RE9aUnpR?=
 =?utf-8?B?SDVhOTRWV1lSRG1lOFBpeGkyNktNL1E2eGp3dUY1NnZuS0hFalVlOTRqTUts?=
 =?utf-8?B?S0Z2Wmp4UDZtelRlekJDOGlmdEg3dStKcWNCUnFkV3RLbm1tU3piT1htK3ZD?=
 =?utf-8?B?TWFVSGtLU2h1SExyN1dva0M5L1pwT011VXdaYmc0M25FRTl0YzIzKzhTRTFH?=
 =?utf-8?B?cVlPZXhCV0ZXVEtjaDFrc2lwRlh6dnZCaFRMWEg2THd6RkFDdnMwdTJIVlpm?=
 =?utf-8?B?ZG10emNQaklwMWVzUW5wVWlpbFRVWlhuSEd1a09PTndkZnV2RG9YRllpRWFz?=
 =?utf-8?B?T1Fvc3NQbTF1a08zN2NTNllMWEUrTlF2R1dvK25oTGY0KzJJVGhYcGozZWVZ?=
 =?utf-8?B?ejkzTVMzSVZLUmNPWEkwUzkyeHdMNHJ0M0YxaE02TWNxb0NpSHhWS09QZzlP?=
 =?utf-8?B?bzBUY04zcC95Y3BqWGlKSCtsSEVXY1RKd2xhMEZ0SkpTNDR2Ym5VVHhjNm5n?=
 =?utf-8?B?RG1raktzYnZ3WFZFR1FJR01pT3JxVGNXSDdsM1Y3TEJKcU5qWXNGeGJiMkZx?=
 =?utf-8?B?SkJUZDhmK0ZKUlJsQkdDWnNQbSt6aDkzTUZkbnpEc2ZoejY2V1hsL2VPZVhJ?=
 =?utf-8?B?STk4bWlDRlY0YU9vM3ZqWlltYTBENmx0ZEhueVhaVCtmUEpDQVMrTS81ck1p?=
 =?utf-8?B?WkdJVmtBQ0FyV0ZobHF1dTVsODUwSkZCR25uR2xwQ2U5ZVhrRzJWNlM3VEZl?=
 =?utf-8?B?TTBtUDYzSmdGUW1xZlA1L3FlUkIzUW1BM2VsV0dQNVphQm4vb1JMK25UOWZ1?=
 =?utf-8?B?NERlRmF6S1dwZWx6V1ZuU2VBbkZzeGZZQk84UytaUHBmYUQxeWhuMGVCNjI1?=
 =?utf-8?B?Wnc0UDVsWnBYNU9ueEtrU0VmNU9sMkdOY2pnWkU4clNiMElUZ2ppT3F5TExy?=
 =?utf-8?B?UXExVzZwZEpJYXhpM1NEc2JKTmR1ck1TVDVIWW5vd1d2OGNRREQwRTRKME1t?=
 =?utf-8?B?ZXFDdDlMdVB2M0dhZDZOSGhlbjB4VDFWWnVLRWorODRtalZMb0FnaGlDbWxt?=
 =?utf-8?B?NCtPbjB3WnVaWEVmNTM4MjVvSlo3WnNmdVdrQUxuQU1EUE5qWjZVdzFhVzI0?=
 =?utf-8?B?MCthMkhnVEZtdFV1TE9BcEV0emQ5Ym04M1FTa2pHbFNWcG93SXFqelYveTdX?=
 =?utf-8?Q?bA6Hfqweug19msDlicuzCcI9W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2fd6c9-de8e-453a-0832-08dc39694015
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:58:59.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+9UkAFMgeNaP8cJWKi5N6BhnQ3/arMGCQZFXFrXMsPLM1CR5Yvk1ksLM7IrLpvMwJi0c54+LHnpdOyENmY/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750

The 'slave_id' field is redundant as it duplicates the functionality of
'srcid'. Remove 'slave_id' from fsl_edma_chan to eliminate redundancy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   | 10 +++++-----
 drivers/dma/mcf-edma-main.c   |  4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 7bf0aba471a8c..4cf1de9f0e512 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -151,7 +151,6 @@ struct fsl_edma_chan {
 	enum dma_status			status;
 	enum fsl_edma_pm_state		pm_state;
 	bool				idle;
-	u32				slave_id;
 	struct fsl_edma_engine		*edma;
 	struct fsl_edma_desc		*edesc;
 	struct dma_slave_config		cfg;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 402f0058a180c..0a6e0c4040274 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -114,8 +114,8 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 			if (chan) {
 				chan->device->privatecnt++;
 				fsl_chan = to_fsl_edma_chan(chan);
-				fsl_chan->slave_id = dma_spec->args[1];
-				fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id,
+				fsl_chan->srcid = dma_spec->args[1];
+				fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid,
 						true);
 				mutex_unlock(&fsl_edma->fsl_edma_mutex);
 				return chan;
@@ -540,7 +540,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
-		fsl_chan->slave_id = 0;
+		fsl_chan->srcid = 0;
 		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
@@ -682,8 +682,8 @@ static int fsl_edma_resume_early(struct device *dev)
 			continue;
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
-		if (fsl_chan->slave_id != 0)
-			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
+		if (fsl_chan->srcid != 0)
+			fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid, true);
 	}
 
 	if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index dba6317838767..78c606f6d0026 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -195,7 +195,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		struct fsl_edma_chan *mcf_chan = &mcf_edma->chans[i];
 
 		mcf_chan->edma = mcf_edma;
-		mcf_chan->slave_id = i;
+		mcf_chan->srcid = i;
 		mcf_chan->idle = true;
 		mcf_chan->dma_dir = DMA_NONE;
 		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
@@ -277,7 +277,7 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
 	if (chan->device->dev->driver == &mcf_edma_driver.driver) {
 		struct fsl_edma_chan *mcf_chan = to_fsl_edma_chan(chan);
 
-		return (mcf_chan->slave_id == (uintptr_t)param);
+		return (mcf_chan->srcid == (uintptr_t)param);
 	}
 
 	return false;

-- 
2.34.1


