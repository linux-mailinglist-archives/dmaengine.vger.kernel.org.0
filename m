Return-Path: <dmaengine+bounces-2553-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D076B91A653
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE9AB295EF
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF171553A6;
	Thu, 27 Jun 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OExd9x+i"
X-Original-To: dmaengine@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2152.outbound.protection.outlook.com [40.92.62.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B885154BE8;
	Thu, 27 Jun 2024 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490205; cv=fail; b=hYWjIqRV9y3sUMhYjDoOjoe7ulkTr680QGSNnLjPCG54stq8igA/HdANCYHOenmUivwF3tUrQOgWONpaULf2Nr3SY85KHyeSdpew4dqa3fFHvISSRDp3oLNhpnQmaZ6fXbJ+EwLrcgKJOl3BeSRJ2LgS6xrcH/jI5a/xXDD9u1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490205; c=relaxed/simple;
	bh=/lYJeNCa440ckCAbiBKuMEotJOEQSOJMZumXJAtsNKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rY48KBT9wxl1jZCjQvs4eFj2p4A4hZ9nQf2NSr4gqOYleqDS+1VbgHWqQy72/vsK/sPMupziuKEGl9DlIGsBPf7TCuA+LC1YEyZBmsFje51FnftGA/McagmglFz3XE3i4gcAKjz4kGqzRIKm96OeRS3AVCLoLWP0W9h1zBZO484=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OExd9x+i; arc=fail smtp.client-ip=40.92.62.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0IGx/hGnUEN6hUhRWsf9VWLL99NjH00+cnNW+cuEYd0n+Plf2sThew5fJc4m7FUzBKvpLyRFbiCl5aulyRJUaEMRU2pdvrOuXt3SuI9MQqbSioELooLS03Ixzn9t1QA45BarbGaH/Qi/CtfbIR5vITyho/EpWr0wEY7PMjL59Mv/Qv5NruP/7+EqrTcJ7YtPV6jK0WkgTeBX1HW3LJ3L7Sz/iJ8AAL/R0y/qn9UkOEdQ/2VmUU+0oAB56aAYtrkoSIvbmHGvofmC3tQEkYhqaAtqtfLUQCdeUgdc1EPC7MrUb1/5WyKtFCmQaK0zV61JFMHzzw60ljqPfunxHM//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/I3G0oq+GfXcfUIg6o292lWiODPBPYER2+MOKhmtzU=;
 b=DkYgALcDdYBkO0VvE6vkbhIam4RXXR6v79wxxPWL5Ri2tYfryied87/gih+JyJXdJYk4Oj43jiGdi2cdd2O5eso42pm98blxEqL/iKxY8pxne8UHFyxts4yXwGTKhBDoMXIpvsd8emSa3D7Z3kYJsJiSCIY/epiHPSNZfXtCoTSX+43Tq6nJjMujIzSxpv1kT0SQ6g17Ek+SqhNX4nCn/58G660tAiWrv+Z6RMj7z7ZJVd+WSdrBv1DUqRKunfyB0Mpy+4CNqC3BL5OZ/5PEuWiWfzbrGs2dNMIpE91esLnN4n13wXoQhaHbdeo/MYE4LNNLOcWHwe+iDEf58RIZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/I3G0oq+GfXcfUIg6o292lWiODPBPYER2+MOKhmtzU=;
 b=OExd9x+il14crkZh1xnTW3mGvMPcdHGf9vbEmNJuDrq9gXhxOlmWemeyMGZhpEvXL67pXnRxiAkPDrNouDHqf0JLFWT7DZLKP3zttCxZ+OzQgazI/TwqhOmx5NYqc1y8Y5TqRzapjuwefomhQpq0nnkjHyagg4aLAWx1WdfIOP21FsL8Pd+m+CVDLrayQgpnQf3Y9nUC6ehGSI5RJtqkARJjzP9FKvqq0aEF8D/v2fBVb+yQ6qrBmnQK7aC7PhXm3DoSI9r3avC6An9gnAiW9CkueurH37YfW9yJuwZ3RCqk1lGWQrqhvlmtDsVcTtxfbNbf3aNzTrgSR/oBRzKwmQ==
Received: from SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:117::11)
 by SY7P282MB4753.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 12:09:59 +0000
Received: from SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
 ([fe80::aaba:e4e7:4639:7a7e]) by SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
 ([fe80::aaba:e4e7:4639:7a7e%7]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 12:09:59 +0000
From: "zheng.dongxiong" <zheng.dongxiong@outlook.com>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"zheng.dongxiong" <zheng.dongxiong@outlook.com>
Subject: [PATCH 2/2] damengine: dw-edma: Add msi wartermark configuration
Date: Thu, 27 Jun 2024 20:09:47 +0800
Message-ID:
 <SYBP282MB2620CCF5690B0CDC437E3205F9D72@SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627120947.11677-1-zheng.dongxiong@outlook.com>
References: <20240627120947.11677-1-zheng.dongxiong@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [5W9/pyElRSqS/5bp+b6YduCcrXUw+J2l]
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:117::11)
X-Microsoft-Original-Message-ID:
 <20240627120947.11677-2-zheng.dongxiong@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2620:EE_|SY7P282MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: c547e5fc-8cf9-439b-97df-08dc96a210e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|3412199025|3430499032|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	omXv+AuvXV2H2QFxXo6Czh2ulCX05DmxExkglcnU5pnLkSsd3mI0A/S4AkHGjtMtT9669v3VkLuqGmro58Wj8EXKxW9BjDTWMrZq7vS4512UTYUEv9W/kJBoBPKzosl4PGyEi/F0WpHX+6vRrUNfxvoW5sM3gt8Vw2DRS7o17UiqmaIx3IgBj34QyUQaOzj8paB+IGUIb7OH+SthCHFAaHXFnhEJrHUHrPog5HgDi4f7KFkHbI0Kaby23sltz/3P1F3CdInkTTeBFEcGSZhB2wwETk9EOyPhEXAFA66oYCCF0fnMfiIIfVHNtDK+uKAX65P+k5jI7y4R6bDgghPya33vRXSGrjP5hinghx85qlxH4uSfOISASsILZJ5uBAy/3JIlslpGwDA3VotzLzaX+p4TZfoIzuyJ1h9aYdqH8T3pkBhT1fYyACg3Uthl5lMlzNYQHf0IKwKLlwxhK/Yn9q7PQ6u+ar55C0a7TIUmQwupmL4Qkp5aP+lL4ZHVOnQ7CjnwolfDP1zzRnVSGj/w0igjCBS+sPsC5Btuph0GFe2ReSupfop9ukxx0oXqdjQflFuI9Ohv+awGheJ3ZeRSGLoOEFA1q813Ns6U+XLMwbav1onhqMU1AJNgahR/gA21
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EV7umKC+bbxBd9il6skkaRxfvDqNQlKPhRMmlmA1IpYKILu2ftJvkKoDHXHP?=
 =?us-ascii?Q?UwBF93+2Q0gqy4FjaJFcZtJxnZXla1wwKzslzCXd+9d/i6oR7/nhazclILPq?=
 =?us-ascii?Q?i0v75z+A5rbdo8mTppsj39pDmA2tJEp2VG2os+tZhZbFrk21pmJjFvBPwb/c?=
 =?us-ascii?Q?RvsQmkiw6z2rOlMAec7UP9PncxS0ITYb7iIwZKLyHT9v98XfF6u8Or8g2Fey?=
 =?us-ascii?Q?e0rUAzNRYWCOxwxvoDUCVvNwpCOnVr5l6OQ7kgCa641u7KAf5eKArPvF0vpR?=
 =?us-ascii?Q?7d5fnJxhfpQc7kkv/UHbGHQ26NE798gUMCQcyVTvtnPWg9OhNYoGAkb59+mc?=
 =?us-ascii?Q?7omaEN7dauZWD2ZuJtGAcYSUZI2k28XR5fmBTJCpNpGeHQdgH09SQwtfbpJ5?=
 =?us-ascii?Q?WtbrTuYDio7Ix0q9Q972vF2BwNtitRBTTJ4p0a2XznPcaR3TDzOEoZExNkhz?=
 =?us-ascii?Q?dc/BgcbWBtOGXqtCtU6If0+bycV4BTcFK19iRRrNZAY2rNm5j2c3WF2WCQB1?=
 =?us-ascii?Q?bzSTIXPMkDkHCUaYAoxornbK7c4POZwJThiz0S3kFmYxwrnJvBFoKkaa5UoA?=
 =?us-ascii?Q?4AyA0Bnw6qa8otPL4b9Er3sfQ1MYXLM0aZvsInlbrY5Iq4Hhp14umoUQPWvo?=
 =?us-ascii?Q?H+ip9fBmVHtOSZDEuTj76YHSlJmVejoC7C3YeWEXTbs1D77HGjEMOPJoagHR?=
 =?us-ascii?Q?DsXfOHoIqmLJeqVZwSeV4x5o72vjToFJVojaw4bdqzBNUyGS432FasfTrqMP?=
 =?us-ascii?Q?EebQjoKAONFtWWUSVYm2WLgn668DAmtqufyZNuMo3VWRza2XdtDwQCejbHWq?=
 =?us-ascii?Q?xsrjW/7WVWQYTJUMC30UGwENuMSv/T53TyoXdIKoonKKiU9zvSvNLFjmtZfB?=
 =?us-ascii?Q?9O7x6KKO3OgsiZpGduXuBMXud0iihmsB8qIGq5TYGW6KxXgD49cJ1fOSyZNU?=
 =?us-ascii?Q?3aJURRmCLuRxVQtR7xrCmIe7w1mmsB2hiNloV5sJs1x6AClJGWBbw8hRfvTL?=
 =?us-ascii?Q?3RIwjx7PYkwUEf3uZXDwLNubLXwPtT4OvnUcvynlnM1LC32eS9pEKfzP3bF0?=
 =?us-ascii?Q?72ZGApMjJpLK1PRS7DU2P6WYuF0byAHQ5kRkKE1IPBAjJAybFfZ4wYaTPhmS?=
 =?us-ascii?Q?uTesdxl3cUQrNRNUgEFPBWne/FbHuEPF1Ymr5gPLnnrsd34lzsw5D+vGM/CQ?=
 =?us-ascii?Q?p2Pdi3+d257sNMFT0RLCixAdtw9WWr7hiD86MafJ1XHUYQ2qWEvTXOp2QpPW?=
 =?us-ascii?Q?GxdiCOqI+BmaUM6tnHOh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c547e5fc-8cf9-439b-97df-08dc96a210e2
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 12:09:59.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4753

HDMA trigger wartermark interrupt, When use the RIE flag.
PCIe RC will trigger AER, If msi wartermark addr is not configuration.
This patch fix it by add msi wartermark configuration

Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index d77051d1e..c4d15a7a7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -280,6 +280,9 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	/* MSI done addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
+	/* MSI watermark addr - low, high */
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb, chan->msi.address_lo);
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb, chan->msi.address_hi);
 	/* MSI abort addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
-- 
2.34.1


