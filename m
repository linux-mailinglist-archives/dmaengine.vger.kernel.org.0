Return-Path: <dmaengine+bounces-1135-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8BA869DB3
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0997B2E4EC
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64F014EFC5;
	Tue, 27 Feb 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hOZ53IHf"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C874EB23;
	Tue, 27 Feb 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054538; cv=fail; b=QmNfhGKwhepzQ3Xpn9z6yvOa5My9CoqA54EIgUYo9Z7tm+L1ZxpAqb9pfT9QptGxE5a3miWvFvZ0kYWCSuLMIpZwbRS9LuhS8e4qbsT2TfEXZkSYDbWPX/UhTwNeNadMMu/o+6WA2zbjzQqO1yM0y5lwcHroec0uHqeVrSa5PS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054538; c=relaxed/simple;
	bh=r+SX1BIbt/a8XXIeUpEhiy0sFQzztcqic+7HKpVi/bY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=neJ38x96EBTEpEt9As2V3v7CYP9/tIbeJiX961M8IHdiaqx0tCzzhPzicj0DI6BWe4T9tWw6XM81+F0SUr1MP2mk6NF3XyUk1f0GJMS90K76yTohAT8Gob8Q/WidUkZaQ5Q9+7BWAhxeP9d/7n7+CdTmffGEHL0GQ77mPeq4gFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hOZ53IHf; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMm7C/0q/z53RCQF8LxWNpkX53U+23LcPOOIvum5xlIZSDKmmEuP1scYmAYm20hC16+iyXHBYgA0HXugFB4PpEVbso/8z7gwVyr2NT3bYuGVKlXHx/qRCEnnZr4cUxJEe9J9SfuvjS8+i/FaDdFjaKRr/0zfpDqvwkKv7YcjicentKFcD+UTqbQ0dB+bkxx7fXQgFYlYvArqCan+osT269boAmgONMXkwnQUx97Nek/rqQeVfBktVkLVxA6dZM0M/QzSn3l/2H4WoNarC5I9hY+eZ3z2cGLqc47dJOhhmGAUkKWO+iwK/lE4iIjRMr5Dg2LwtBVu/nIXPwTHTno9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77nLzVLA9I6azS70HtRDarrsUyxHIO7L2AnlMIBiP9U=;
 b=FncyTObRvPgdrCSI6L2rU6EcrtjoIh3Oy3GAeT1/XImUApPx7jctd7+4J0fWhVd5yt2vctnngVgATI2ZcH4DfxK55fb21ERbe5wYwteLPCTxLFExo2DJVdNeSwupp+3hqxZjYTHKVqEgOm2MCTPrqKq7HcupCHG/5I5yApbEj4931QlHA07Z7KH+DdtSphedg/AZMWrXobNQzqrC5Yg+F8RiB79uDLU+MglRfZ2GpFVt97zx2/crR0ue0U1Pu1Z7MMX+vL/J7ExTfJUeke7JR4vVltmlvxtmYJ+/XnT85T84okPHeCF8/zLe348sE/gV/WIbedJEXeZssqai/iB/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77nLzVLA9I6azS70HtRDarrsUyxHIO7L2AnlMIBiP9U=;
 b=hOZ53IHfEarTtclBOExSaivWb6YlwLCkr5rQjLatU5+MuxOveU9OuYPfApbc2lOBVR8jZL/WY2TQLrqbShaiGqQocLM6PsRMMWbOA6k/dWEPhSX50DS21e929olOpg2w92nuLx9ITDfOI3C10sRzJON4fEE4izdcPBpUpobQ9PM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Tue, 27 Feb
 2024 17:22:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:22:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 12:21:53 -0500
Subject: [PATCH 1/5] dmaengine: fsl-edma: remove 'slave_id' from
 fsl_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-8ulp_edma-v1-1-7fcfe1e265c2@nxp.com>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
In-Reply-To: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709054529; l=2161;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r+SX1BIbt/a8XXIeUpEhiy0sFQzztcqic+7HKpVi/bY=;
 b=cfGe/Z3C5UnFeJImNZ+LXU4oZem9gGgPsVBDA5wtpcW/s/FDzBRM9a1qPbyYHdTnFViuclkiX
 YamgA3epya5AntarmvHrkIA44CiEvkylBjbz+ghk0tMmNDcWXVpNdPo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 4493227c-4ded-4eeb-569f-08dc37b8a42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nB5yQdgBObp/kGZlX7IoRk6NszQtfwlJMqFXCjZhhIqy5uHX1JmzPvUX2Z6V3wKQx6BU5K/GurCWk7CI9FlgMKfMKG3NVjXxxPiK8kJuh6EyccbuG9e7tGYRO3qMgG/TtvBsUyLoMtdmdxaVR7zmx9TuXOrAQ08j83LcEOW7njVLmGmmRVMKN7qlkfgXW3B2ERsjySAPyonShcbEZ+OEZu8GmZfu2C7f7S+cHtylj/muEtSZ5M1zsib6EougKuqSFlf0HaOkjqHy+9J+hAeBBS4kZyfwtb1DhJBMAgoIkB5tOcPZqCeYufg8olWKuHOldOrWOuq5+Bax0+F7HkhLiYUxbFJczlp+kKTw6A/UUA2nxBuXpnOt1rKA6psMHbErzd5Qhm1gELQ3+NUpTMWbOKko1vGBgq9dEV9bb12Dov0QI5OoLIw+1+YiYwxUpglMtgXN54WAj+xSPKjOrP9K9NW8yo9s1toV1ihqop82E0QssNG2PpOrIn2lC7/eltapWwGSwQA8gDM5003kpqH7Q1TXAlqvP8q5kNN9Fj2L7VCI4Nrb0CdMLZ6UQCYzweY56UPFHtQwz8QFZ2uvcisU8iDoSlmp8dXt4kVX0SRjXYTS/a7yRbmrlxwzWSp6+eltgp7IJGY9U1OFDjH4GYurKw8eUW51nGisDOTghaKKxr0qZniXyJ1+0WrtNCqHuquZn+z2tMlbNL5rTmLzNGChsm9iwqXS5V2FPI+DgZU3BmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0lZTU5kNHBaYURRa2lIOW4zd1BlU1lNbXpvYlAvZDVDc1lmZkhhbG5GMEtN?=
 =?utf-8?B?aVpGNk1YMFpkejRjZHRlTmlJb3RPeEFPS2U2cTVtTjRNbUE4SlM0V2Y4cTkz?=
 =?utf-8?B?UjNHeklTOElhSDZzZFBoVUNJQVl0aEp4dkYzRFFNOHduT0Q1ZGtJQ2NoY3Fj?=
 =?utf-8?B?UkE2cFZnblYwdzZybGdBN0xuRlpqM1hJSElUR2NTQVpUQW5YS2JRU01qMk1n?=
 =?utf-8?B?MFNnaGlydG92NWtNZm5FOHZaSFhRVFRoSUpqVS9MMkVuV3lZWGN0bk9vUU9H?=
 =?utf-8?B?R3pxNlllYXl6UHV1UzF4akg2d2V2YkR4cnlCWnNiT0o4dkVlVy9KclhoenRp?=
 =?utf-8?B?VlQ4UHZIR01Edk9YekhNRGphMDNkN2tJU0plaTEzbHViN0RmZVU3UktselhN?=
 =?utf-8?B?alc1SjdVa05aeEVjdHk0UzQvTjJJdDRBaGUwRE9pRnh1S1VTU0NzVE9tOXJO?=
 =?utf-8?B?MFhzTVMzeSsxbXU5MkpTbUFyZTd3cDJJTnZXd0tGaVhpM2NzRG1wMjM4Y1Bi?=
 =?utf-8?B?NkYvWnI1RTI5N1BYcmNYYzJ4dWpway93WjJwQXV1eVY2NGFucHBpWXVWcndI?=
 =?utf-8?B?Zmt6RzJ3YTd2czRWNXpucFhiTnBEZ2RPWUt6TEcwU0drOTh0VGRZSDUwdENQ?=
 =?utf-8?B?NkNYVEdvYmtXKy81U1Q0N1RjdXhnMHVGNng0Njd4M3JHVU9IQ3lpMmNRdnox?=
 =?utf-8?B?blhsZHVnMTR6YWpsUlpCb0Y4TVR1bTB6Z1F2eVdONkxmdWd5OFlUU1lid1dD?=
 =?utf-8?B?NU44SXkwZ01meEpwS3FwSUQzcWZrUVFyZFU3dUx4NHlXT0Yveng2RzQzK01E?=
 =?utf-8?B?R21ocE1MSWY1UmIyajRoQ3ZhMHBKVzcvT0xYdjA0UkxySy9EdlArRVo5Uit1?=
 =?utf-8?B?ZHV4YkhSSFpTZ1k0Y2J2SFg4ODBSa1JUQlBRajhIQTkvejZxNFJOSTdqWVp3?=
 =?utf-8?B?QzU4UG5INnFGZXg4b0NId2pMNVMwZUNKaU9uSDB4RjhBTGhLNmQ0K01iR21y?=
 =?utf-8?B?UUVEdU5mdVFrZmRrQXN0bHJ0a3l2VWN1UE9BZlk0SzlNN0N6VW9rK2xwSExj?=
 =?utf-8?B?TmhpUHFwQ29GRDRyd2FqOTJNTHJ2TG9DdGl5eHkrdHJJMUhFL2FJSDlmZkJw?=
 =?utf-8?B?NGw4K1hERjUvMHptaWd3dmZWcjdjRklLWnNFVFRWZlduNnQ5UGpjck81V3Jw?=
 =?utf-8?B?VTlSOFN3ejJRcXlsa1JIckFkc3ROVEtQcnhTOGg2eWhGdmw2UjFVWUpaTm91?=
 =?utf-8?B?L3gxSkRvU2xrUno4MVB1UUQvSnhzbWU4S0pQOStOT25lT0VaaVhtbVNIRVB6?=
 =?utf-8?B?TUxScEtaSE9JL3JnMXVSVWxsWklJaFlGNW1KcERiTlluQnFPTmV6cDlyZVdl?=
 =?utf-8?B?SCtKTlg1YXpSd3I4TWwzalNqcVNkRUlkVHRHQ3Z3Ti9HNm9iblp6b1BsLzBR?=
 =?utf-8?B?RlpJcU9YWDRXUVpTV1FwN2tjaitDYWJNYUY3MTgvMXpaUDdtdlphWnN3Y0Jr?=
 =?utf-8?B?enhaSThoM0Urd3g4NldHMm5FQXZXVzdCWnZidVBySTg5bTQxVkYrWjVzUXZF?=
 =?utf-8?B?V2kzRTV0cTFPbXo5N0sxaFVrQldOU0JtK0hGZ0dBTlZ3enZMNWdWWlZBTndt?=
 =?utf-8?B?amo3dGVQYzRCN2gwSGEyZDhEY3JTREVGV0JCcnZYTkFTbUNJa1d4SUdXSG5w?=
 =?utf-8?B?WjViQ0hzVGVLZEEyaCs5S3Y5WWtMU3c4UnpRbGN2UUhZMHM4RWRVZGg2Q3M4?=
 =?utf-8?B?MmRsMWErRjg5QlRqaVMxYVBjUDBWMHYyOERnNFBWT3hzT1piTStiUmcvTFpS?=
 =?utf-8?B?RHF6a0tNZkdvaUJ6QzBtaE1ncVhITlZCd2dtOVhreWUzN2FvR1ZTZ21BeW02?=
 =?utf-8?B?dllwNFRVRHB3Tmtwak9nRzBhcGtROEtRN0tyMUVhYmF2SVNoeUgrTUozang0?=
 =?utf-8?B?YSt0OGtEbFM3R3J2b25qN1VGNWw2S3NJZ0Y5dFNuVzkzMTdOTktuaDdBZ3Rh?=
 =?utf-8?B?a1ZTRGxaczhHVVJmbEIwbnoxMFg3YlF1N2hITjZKaVNaN2tWcjQxVk9UNXhl?=
 =?utf-8?B?a29KZ0R1ak9uQWNoRnVrcjFFWlkzTWhMU3grVVFqdThBRGVtTWUvek0vSWxq?=
 =?utf-8?Q?dn8Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4493227c-4ded-4eeb-569f-08dc37b8a42a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:22:14.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdjXTUgGbVcb9qOL8xGCo15KngQV2ZqVIQQbJqqlkQYQB3Lbzg1gbJ8J15539chboxGbz4FBvN/N4sbJlbKcFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9754

The 'slave_id' field is redundant as it duplicates the functionality of
'srcid'. Remove 'slave_id' from fsl_edma_chan to eliminate redundancy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

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

-- 
2.34.1


