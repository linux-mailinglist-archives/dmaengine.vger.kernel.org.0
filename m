Return-Path: <dmaengine+bounces-7598-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21647CB9F12
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7303030AEC93
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1F3126BE;
	Fri, 12 Dec 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LChgevis"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C70311C05;
	Fri, 12 Dec 2025 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578391; cv=fail; b=jbZ1AbW/51OUHsnLlsHXtP8y75WhJjWVp1LeXPY3xYk0C8Ku76eu/cGjqMd82Hf5EJmsHdJBhrFZKXmVDrSWbzEO1xtixP8ri3KdipxrXxdAjNRwsFaDDu3oqofGwOONknKrPR+JVGIqprxs8cF/is/IY0ZdM924qiv4RCdJdwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578391; c=relaxed/simple;
	bh=aOAaA7jThMYTLvhiPxxVJZNwV14iX6s7QyAVIfn6T48=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rofrt8dZh74jEtehxuTSvRQpSF4oCmAzKcxJ0u1l1T9WFwWp+eTgscmurCs/DRkw+zUCfpKakFGlTruq4mjHk217EvJQ6Igpjd4y5pbjOTeeVN86AZqoO0EnJRH7Fx3M9JOkSdAH959SiVCb4GR1MUe1m774KRKaiokJVyrTm68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LChgevis; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGE/t/oB60HuHhovshvdf5fHX7oy3MAv/CqftC14YFZo8mRRKbQyn5OOaDTkoqG52B50HYwiUKR7P0+dZ54HkedbZIRCgExDmprZXk9IOae6C51rh+7KCAFaBz1JXkvHIFT2BIz0v7F4cEk8VZSwjsMoNM/eOoj+C1F2zFWN8bwFrwsfxSYiMwjQJPXZh5OYUuUwvaW2BDK2qiuYz8RV5OQ4fKiuK7UqNIXQZBy2aOqMLQViZOCIME3H9YCmaGYkEb/w3+TTHpGXQiqGSbFXzVXH5zFPoDGjgrWNk93Gpiyf1jeH4D/61HJ4OJ6GP9nNxyDzPcckjYQhfMf/DvfClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILU8UFmHXUWrFEnocL7/1SBQiZN/bilsyMgv0JmFyvI=;
 b=cXSZaHxzNHrbWQ5Fb1I6HfJe3XNdlA/lK5Vs9h4vMr7/ElOp2Bv10r/KiurPJPPyoS++amUCAZYskzX5HyOy720UOWspMy/MsRyBHDuNN3BDaN4RAvmbxKoLgchNLPjX1odp2H2PWv0jDwDY+CITVwRfHeqzobY6jDuqABpZjMz1FkXG1IaVXezsgW+nyraGiK3BzA4qNgg0uiEacH4VOI0LHIkcnaEKoSQ7O/tfZYF/t5uA2+cEo6J4snIyct33wELNwIeZtybDUNeXpetwT9NlkzAupTnwg1ZmXhFtwO7K29rfDrwIiVQ1mGZlhr2zu9jwesXtakA57wNv0oeCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILU8UFmHXUWrFEnocL7/1SBQiZN/bilsyMgv0JmFyvI=;
 b=LChgevisEOSDqWinkDebl+lyIo+HJhVh12wkuH6G23qgJ10IQ3Il4C+yu8eoCKo9N7eJIusKWYzzJjnA2wu4wNnOWqSemObVcxnOIqFbrynJ73L99k2EoBpWbYVoWCQeM0BD0CI+FW/dDj+YkeHU8dQeO+LKYoQWd0AKfnAPxGn1xKXrk3O+Qcci52X1Itw0jfyE213PSxhPMRKl1rdNYOMgfMCKkmViK8XU5AnFsEKKcEWyDAG/j3FF7jEl89KYh5R/piuZftKpjWPi/yO34drwTFaqY8KtnYZ5oRYLKR/zYsdNiD4/2egWcIyLiLnbYhhO6f/t9im1++XtSfcIKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:27 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:45 -0500
Subject: [PATCH 06/11] dmaengine: dw-edma: Pass down dw_edma_chan to reduce
 one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-6-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=6978;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aOAaA7jThMYTLvhiPxxVJZNwV14iX6s7QyAVIfn6T48=;
 b=oTMullFnRvcgDCn4UrodMjw1gEabZ6PgOExdR0Tchd/aF6I/s2sl46Muk/XAXNjXt9+RW3gkg
 BM4cvgr8qaGB+t923c7fSpyztuEw101Fy7d9BWcDQ1FzJ5VwOScF3HS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 453be186-359b-4b65-0697-08de39cd5952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnV0d1E1RVdWZWwzYWdvZXJwb01pTlA3dW8yZzRXaXE3UnRKczM3Uk5kaGZz?=
 =?utf-8?B?S0lBZUN4NXk3RXNCZFJqTDZzc2JkR2RURTJUR21obEpqNytoL1hGZVVzRnhJ?=
 =?utf-8?B?ekRJR01tbEhyR2tUbmlYby9IQnVRQ1JwNElwbC9lcmpTT3YyK2hDS3hZWEI2?=
 =?utf-8?B?Z1ZwRzBGWEcrK1JuZXNibGdxMmFySVZ0WTJIOERmQmw0NHhlcXNXQ1FxZHpT?=
 =?utf-8?B?RW5idVBWaUtVY1N2TzlSQzZWZk9JMExINnpiSVBqTFJ3Nm5XTmJ6MUc0Z3po?=
 =?utf-8?B?YVB4RFVIcms2b2dXZ01Uclg0TjFJUlovTUx4VmdIT09UYXFKSWtRUkY3N1pB?=
 =?utf-8?B?NTBKYXhoMFZ2QUU0NHdwMjJHWDVOMGdGRWFpL0s1UFJvVERlbTBZSTk4aDIy?=
 =?utf-8?B?d0xGL0V5UDZXaHUydHp6cjM0cDFCUGN0RC9BSTFvdndTT3V6aXppU3JHUHRz?=
 =?utf-8?B?VHhRLytLUmE0QWtaM1pWVklqdlV3MFdtV245UFY2aHloblpscGtveDkvdWd2?=
 =?utf-8?B?dngzcDlUcVkvUldmSDJhQk9wd0F6TEZYbkZjamFRNnduUkpvNU80cmdjWjlq?=
 =?utf-8?B?QXJjK1JaQUljaTFaczJMVU93ZEUzVHB2em92M0ZEeDZuTWgyakYwc3pPbVVU?=
 =?utf-8?B?NWdqZnVQeHJiMDFiK3NyVzNQZTFIa2JvT3Fac3BPTnd2ZExLcmJqZUw1anFT?=
 =?utf-8?B?QkUxRDlRS21ES2dhcTVDdzg2bzZZU2ttNmJ1KzBiQ2xyWW5XdTJFWmJ1SWow?=
 =?utf-8?B?U1hqcU0rWlFKWnY2ZDFRZll4cjM2Wm9KU0p2b1hvN3krbHB6TDNmV05iWEFX?=
 =?utf-8?B?MGlhdytTVlVrMWRjQ2wwMlExRlcwVXVrb0lYanBuVE94SjlSUUlGM21rQ29a?=
 =?utf-8?B?dWF2eUVFWUM3bGt4aXlVdmkrOEdvUnE4eUFUdVRrdzZmT0xORStKbitWVTl0?=
 =?utf-8?B?UkJVZTBQTEFFbGxHR0JTdGpXbHdrTWlGWE5leFVGM1hQZjFLQXBKcDZrcVBJ?=
 =?utf-8?B?NE5EOFAwTFhSanZMUXh5Z2taOTQ2OTkzQi8xb2I4eUpzOGQ4My91Vm9iTTNT?=
 =?utf-8?B?Rlo0YnAvRDZpTGdhYUFnQjNzOFhNeXVWS0ZRWXE2UE1LSUFuUncvQ2kyN0cx?=
 =?utf-8?B?d3dlWE45bDBoZld6TE5QS0xkSWhYQkFZcDEyK3pUSGpuSTdSNzNDYjYxN0Rw?=
 =?utf-8?B?RDZIRTNPSUl0T3J3Y09JZURVNG5UWUpHWFVSL3hlWGpQU0QxOGNaZTRMNGY5?=
 =?utf-8?B?ZjZQaHhDYXRjZURuZFpTbStqREJjbjFwdCtZYUtCWGdxM3ZWOU5MMjZ0N1Uz?=
 =?utf-8?B?VVZWVDAxY0RZaUlFaFRtMFhqZWZKcDJSWTcveUZaQlAxYW9LVEJEdmVsZ01m?=
 =?utf-8?B?a2JLQnNvemJ5ejd3T3JnMGdyeEpzQjEyS0tVNGxGVnFjTWcrRTEzYThNNXRK?=
 =?utf-8?B?TWR3dnpidzBUc3FZeTNTdVRaUnMwUHdPT0NrWGZMb2JqbHExUXhCSHlycW1V?=
 =?utf-8?B?MmN0Y0g1T3dkeG8vU1hzdHovRURiRWFIc3FKVW94d0FkaGpiU1l4dGZyeEh4?=
 =?utf-8?B?UkwxWnY5SEQ0UTNtSWxuclEyMWVZL2pYSXhHUlRpREJDRklncnlvSHIrUHBQ?=
 =?utf-8?B?NDhOSzVOT1ovcE0xMENKNjlnUW1OTU8xWVVWZFB2TFMvZG9TN24wVlB5eUFR?=
 =?utf-8?B?TFBYT0w5b3BhVEFXeVAxMHcxNTM1YnFaV1p0YW15RFhhWmI5YXZMME5ueGZT?=
 =?utf-8?B?aTZQUDEwTXFmZ2xuV2ZqdC8vL0EzN2t5SE9UNkpIeEpmUlF4QjM5RmpMa1dj?=
 =?utf-8?B?Y3NESk5SQ3ZPcE1iU01WQkwzZnBPL0RNR1pVTUYrUDIyUVk1NHlLUml4b3Rm?=
 =?utf-8?B?RXFnYUNUdkNrTFF1cDJ0c093bGcyZ1dkNS9HVERkU21Sekgra1d2R1NNNFNn?=
 =?utf-8?B?SnY3UXFpbzQzUVcxU2Y4VUFSaEk1UG10SXJGNkNpK1d5NVFSSG56SURwdzlo?=
 =?utf-8?B?T2p2WVdYbTM0M0crQVFHUVozU1lnY3FwbGlvcnNScEZ2aE4rQ0dacytRU2Jw?=
 =?utf-8?B?bkpuOUIrWjhFMG83RGswcEY4cGNpeURST0F5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVnMy9nMUcyT2xTU2VDeVdyZERhRjVmZ2tyS25EeFd5OUt5Q29PTXJ4OFp4?=
 =?utf-8?B?Y1FGRW55MW1HRnMyTWhjVld3d3F5M2ZaR2svOEU0OUphME14UmlmVjVWS3N1?=
 =?utf-8?B?amFUTnFUR0l3dWlmaWFJYkhYZXNBSUw2NUUzM1gwNGVjNFRpU3ZVci80T1Mr?=
 =?utf-8?B?SnpVTVdoZllTM2xxWEFvVU9HVjVRYTNyYXk0RllaVWsva3RGTXEvcUNVSDNU?=
 =?utf-8?B?bC9GQzJaMmhJSEZvQzRHSTkxVkJZOThUblVTVFFRT1MxckV5a094aTFyUmd2?=
 =?utf-8?B?dWcxdHd1RTVIYlhaaE96TFNSaFcveC9KMTRUSnhlOENGTE4vVnJwb3RMWERx?=
 =?utf-8?B?c2dPTVh1OVNJWjVOdEh5T0JnajBHQ1ZMMDVlZmpabjlSVlhHN1dtNUNvVWxt?=
 =?utf-8?B?V2cyNDUxVW9iNW1MdnljdGE2ajVjV0E1MEtGVXRrTWFkbTdQbUtwZk9tUUpG?=
 =?utf-8?B?VXJ3NzlQbDhhbE85RGtabEU5YnZuSHQ4NFExUkptUklORUUyWXArWDFKM1JZ?=
 =?utf-8?B?dWFqVUpPM0JYNkxON21MSEdjVGxHOW9JWHh6R3A5dXd4WjdCeUVyMUd4V1Ur?=
 =?utf-8?B?RlVsU1R4S2JDcnVjQTI2MitObyttR2JNZFo3MTJQQ1ZRa1EwbnB2T3N3dmdC?=
 =?utf-8?B?S2NuMG1nVStEWjhzcVFlWElya3RxNXFjYW1nK1FhN1JoL24vb1V4TGpPdjl1?=
 =?utf-8?B?RW5YNVIzbXRwN0d2M2dCZHF2U01CMDZ2K3M0bG11cHdKamRHOU91ZmJiOHpE?=
 =?utf-8?B?SElKZEl6NkJmM1FVVVhVMHZxbW5hUXhsdFFqVG1IZlpZbm81TXRwQ0ZZZjFM?=
 =?utf-8?B?RVM3U2FtN0E4V29JbnRQNEFCS0pDdTkvcjkrY0JjQWQvK1Z0OU1ON1BnUGlS?=
 =?utf-8?B?aE9uekdiYmtwamt6L2pKSk9VV0hIU25yOWY5R1lZZEtoSExVZnFrdXdIczdJ?=
 =?utf-8?B?NnB1dTBDMXllNXR1WnB2ZDE4Z21qUlk5enAxbkNFVytDVGZkU3hXSDhkVUY2?=
 =?utf-8?B?ZjIzaXBDdUdyallTK1FOaGxsQ2cyanRaNFZQbVoxbXZTOW1FUWxVTzd1M3Nq?=
 =?utf-8?B?QzdxVjBXUk1zaWRCOVBOeWluVjlQVGdFQ2ZrUmV4UUxzUnVHaFhScnB2K0ds?=
 =?utf-8?B?c1RpUkVyYUVNWUlabEQrOHNrMVhLbjEvTGhFUmswN2ExelBLRjQ5c1BZekhn?=
 =?utf-8?B?UWZtaFJvSWV5cXp5RHRjQnlFUmx4V3dHUUR3bzZETXJVWEU2RmJCNG42UTJn?=
 =?utf-8?B?TXBTY2doRkxlUlNUMGtuWXkwTXdnUDZEZkVRV0RYeXNlbExTVmVCWjVEOGho?=
 =?utf-8?B?ZTBENS84ZjFxVnNvZGZSK2l2VUpmVExNN0R1OVZwRVQ5YnNjajB5NU9jcytK?=
 =?utf-8?B?Z2N1M1d2U2ZZSXF2cThSUTlZWEZUbDFrUGdwK1Iwc3lsWlBGRHBzYzltdSsr?=
 =?utf-8?B?V3B5M3NXZGV3bWZPMnI3U3pPdTVFMmhlUFJTNmhhOFBETGgvWXMzd014KzVK?=
 =?utf-8?B?alErbGxiaVZWZ2tvbWRhUFBpcSt1M280WFNWYWh6MWhnTWdhVS9ISFJXandQ?=
 =?utf-8?B?ZU9odDZpNzBBcmpQSkorclpWSFYrancrWk11aGRGZ0ZlcXdldTBlWFJIM3Av?=
 =?utf-8?B?WHViQmJIWGwxdVpuNzIxZFllS1BhOXBGREFZNEEzMisyTXlWc002YXRVSnNq?=
 =?utf-8?B?RkI2d0pmbUl2YzhES3BvY2dRaVZHek8xdUVjdTNhU1hPRGM0R3lGQTk4MlBM?=
 =?utf-8?B?Q2xveDJQb0Y2cVNUQzVDV0x3YzJmQ092cUtEQ04vVHAwT05QK3hnVGVPbC9P?=
 =?utf-8?B?bGF5bWUyYjRVaEdqUFl6VENaS1JUUUdYOTlUUUhHeEVLdStESjVWKzMxNER5?=
 =?utf-8?B?Y3c4cGw1aDEzTU5xUUhWV0prMnJGVzNlb3VSUE1PaTVHRlA1QkVCMGRIRGdW?=
 =?utf-8?B?RXlUdmdqRjA2bmVOeTFFdXJQa0NoUDA0UXh5L3B2QWtnc211ZS8xckllN0tL?=
 =?utf-8?B?YkFjdUdpd25iTitPRU9FOTh2UE9oaHpCSmgzYmV2QzVocEdlT05pek1jR1pV?=
 =?utf-8?B?NzFXT0NqczlBOC90anhQbG82eFJPYnJSOHYwZjBvQXRRM1UrWGl4WG5ZdTBr?=
 =?utf-8?Q?5rCw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453be186-359b-4b65-0697-08de39cd5952
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:26.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EAOiEPaUCVRgu8RaTgnMUeqwQNbjoUsV0fnmGRZFNJSbMp0CCw6Lh0VEc6FSZzs9+yAtiDZ0anUJLfJA2uzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a1656b3c6cf9e389b6349dd13f9a4ac3d71b4689..79265684613df4f4a30d6108d696b95a2934dffe 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -300,13 +299,12 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -339,7 +337,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 				control |= DW_EDMA_V0_RIE;
 		}
 
-		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 	}
 
@@ -347,10 +345,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
 }
 
-static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
@@ -360,8 +358,8 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -437,7 +435,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  upper_32_bits(chan->ll_region.paddr));
 	}
 
-	dw_edma_v0_sync_ll_data(chunk);
+	dw_edma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index c12cc80c6c99697b50cf65a9720dab5a379dbe54..27f79d9b97d91fdbafc4f1e1e4d099bbbddf60e2 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -152,13 +152,12 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -176,13 +175,12 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -198,6 +196,7 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_burst *child;
 	u32 control = 0, i = 0;
 
@@ -205,17 +204,17 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control = DW_HDMA_V0_CB;
 
 	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
 }
 
-static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
@@ -225,8 +224,8 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.34.1


