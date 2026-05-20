Return-Path: <dmaengine+bounces-10579-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABjpF0E1Dmq58AUAu9opvQ
	(envelope-from <dmaengine+bounces-10579-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:27:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A459BFEE
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4353130C6BC2
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB19C3B6BE8;
	Wed, 20 May 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V8ZfvM3K"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363B3B5826;
	Wed, 20 May 2026 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314470; cv=fail; b=n2vVK2w83vBBrq5eT3KLVvPAtfOX8KjEikAyiMTuppC2iaGkL53w8anr+DwDFTokh70UgUmrynQ0a43bxAmRP+b0M5TEQ1NaETrxLfDHcktDK44i12RYGId5nJyeyKWfL0aEVh79ju+Qe8qPUsR2gZotv/Z+YImtYg3UTKzb1Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314470; c=relaxed/simple;
	bh=IPs530ljxyZEklWA6fCKo4SPitNmyLEzet1kpmM0cyg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kdr4EfghSMWnQ5CMyCgGZHsoLprgy8iSRWwaiWDixpiuzBV1rri4X5RQxyqToOIxqajGSMpQ6klKjChqH3XEelRrqC4S5saPgIjuujam+3KmzOD3Cw0q+2zWsTMZsneKawacn0DoCFF4Xz6AssVz06/N0c3IjRzUCoH3+U+1GPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V8ZfvM3K; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Y1UKL4TF2knxKiyKK4uRNk2PYO7in6ler3XDrdUtEiCdZN+AykeM5K7SrI+QwHhT8QYsD4pRGIY1Hrdx2bnvD3IoiNI5GPv81h30Z1752JDGTKFd21ksErJXyaE2RT+ThCpZo0Kxyj2Ku7OxJEU1qdluSfoyDqsye3rJDmJF6tYBHdiIIboyCTBoW6+lOaRi+4LUxnrV52Jqgp45j1cGuyeDPef5vuPftIlyx2pQW7SxqluM9NfLippT6SBHmRfhZMfVCJ7FFNwC+llM5c+7N9BpGj3vrZhFpquSsdLh9MhEanzzwv+QZuKtY23JppSqyN63ecA3T0SsWosn50ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ktn4yDDK+X3BcUkupV/7FBh4aTe/41UXRom1OC5H5c=;
 b=Li3fdwBfCLlDzTEFREOghnltZhHlkJf2Fadgh+nduQHkp+xeTNYNA/GHNyhB87G7L1vv4cm8dSKrtZaskUjq8NRgq2aTKhmVWxZlJYu+Iaj5mQeLoIFTnm2+Ai76qr5E+5mIBPTepv1C9XC2D5u7AGK/CCTtZtHaY7P2k05aF8wSYKxI/debUTnJJOrApR2m6YNJjRhX/YL0xMtwqy2gPI1YAKQWb7VtnsA0bWST93rWsB9qUA0t7UNvXwSApmvaBQqZoLTlDst4up25GNZJCWd2u1qgLujr/YcklnRazLBrnNrrtCRuUkm7uWryRV7eRZ/PAypAWPrUEfrPbl6REg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ktn4yDDK+X3BcUkupV/7FBh4aTe/41UXRom1OC5H5c=;
 b=V8ZfvM3K4ZjHZ/P+KquRWwuU/0f6p/ZtsbCjtEO8FELVVffxK5wWJuZcvp1r9VXYbeHFu16gvmKOx5ksYkX1D7gPCs3CUrXy09icBn8//UaS7J1jtE7z3cNiHpKOsUUtkb6f0gR91nH121ElsUL9EEnCpq+7XLnh5DdNXJikGBkcyA+06pt9cW5VA22SXdQKFY0tTxgcc3SkfSeHtHwlgmvwRyTrTX3+0CA4LRG7z+xWGZQKE5S6mX5yPuLwR29n6D4iDFXakW6RuD5NHzbwNKTpjQz7XoTeZ9UqZ4QrPDYILqmf6AFOt+ApUrqWuCrtgqW4UbsJbn79fVbirX1aFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:00:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:00:58 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:43 -0400
Subject: [PATCH v6 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-2-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=6305;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uyPouf7iyzCcucDvUuV8ZtysqANoCh3TR/YpsX4alSI=;
 b=ngtZq9I90mmbIdnupiXwC7GVOw4pdjdeubZzsnNM2COERXHnq7YmJm0nQKoxo5+le1tmklGip
 ZINGEdDTxvpAeNFuv2SDbzo8sB/zi3Y8fafSB2evT8CmBR/vubtOFKt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:806:24::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: cd160737-5b14-4139-cb59-08deb6bb4616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	HlI0IevGY9AvhaRsJMO+ofVyC5oZOXNHqhaB23UZUpXUi7gzWNr/BKKjhikHxsTzUIgz+zmtPmcpggNbEXwxf3uNgJ442fc3NmercTlL7LqLQdRss0DGtYvnLkv7I7U2ldV2246n5uFChnq//ZruRVuQvaE6YJMhJMbnzfdzb2/yOS29czvGTiVF2j3AcGUkEUyfiU7we6W5Xksv5tgxdrXw/YcqKN1K1INTsvSz0lCOa76iy8f11dixRp5J05UJQPVL9+bMWggk61bogowR0Dc9S9cmeGhxfsF2uSjA1dC/M+zda7wB5jwoK9t7q4Yj5Bt+IhXhsMDlfh29oqool+e8VF07f4TkguuSkQ59eQ5SSGtBvBP56+v6p+dbZ9mrfiZsUeDpIsW674dDEiXDOtoG2SVmF3Rg4HGXFSDx3NNVu2PbcdC0MAQBq68fHoYMApbcwGIcTvwL6+K9ZFRANtIu9dHpN4STI0xIiE79Y7nDtEa8FUvFSwHy+HCS+58jQAz87HkqqbEJpm5K6Xso2825mgjsfPPE9XcjUC3kKBLMk/xww17/u9qazttJRwRy6i2I3GHIZPkjfkFOFcPTVsP4QtT9dlau5Y+cl1CiC0RDC4S6B0vDZoDeJcrg9RODElC8mqdPgJ1Tdj26eB69bH/DDiTmcfRv2JTc+udEA45tIQ/5j2sPtRFt4NoTonWUcup5QQsSEPZt3+q41HTpf1TC8kN5JBeFX0sukXG5xYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0IwVWNnbExQKzZHYjZ0enVOU3A0S0tTUTFPVFBERVprYjRYSVptdFRGT1hj?=
 =?utf-8?B?ZlFTREdmbXJKVGJNcTRVQjRHSGhDajZHTGUwWE02RVlESTZLVEs4UGdlMWlV?=
 =?utf-8?B?M0tvWktWbHFxZHVlVVJ2cU5VSTBjUkp6K3A1ZGs3QVFQaUppSXFBaSt6K1ZL?=
 =?utf-8?B?cGYyOGEwSGdqQjZzMUlkcVA0RlpRQXFMbTBHdDg0ZTZUUlhQNUdGeHh4OEw3?=
 =?utf-8?B?NmNrMlFnZGhrWGpBOTIwdXVFMFVIOXhldkRvR1FNN0JUUnl1MDBJNHowcitt?=
 =?utf-8?B?WUNyd3ovb2tkQmwvcFBxY2VvTXBpcFFqY2ZpSHlxZE52QU5MbVVxVndzZnlG?=
 =?utf-8?B?Z1oya3I3WTRyeDlwQThDcnNweUxDakJjVDNaU2FqZmgvRjllM1ZCK1Y2MU53?=
 =?utf-8?B?V2pEa3NvcVpIK29CT1JKaFdQc1JhTU4zOXhLQXlHQ1ZuRkNCR3hnamNLaXo1?=
 =?utf-8?B?UFV2UmcyZndHa2tiZmdLWlZieFA1cGRUb01vWkFlYW8vZ1FVVUNTalBLMEFH?=
 =?utf-8?B?TEJ6Vzgza2E5QTJvVEdOazhZaVVtSlNxa3RCOGxObU9TNjZ0dFQzdWw1UHQ5?=
 =?utf-8?B?MXNXSU1KaTV3ZFR0THpYaHAyZFRsdnJqbk1xRGY5cnNDWkMzNnl3SHBQZXdm?=
 =?utf-8?B?ekhneEJFSk50aDdoMjk3QWVwajZxQStxTUU1RzVreis5YWgwYncrZ0gzbjJ4?=
 =?utf-8?B?NVFOMWs5V1FmRWJMTi9uVnBvZHluZEdIZ2VEY2ZWOCtUWG5yajcvVGJ3akFV?=
 =?utf-8?B?YmFMaVdYY1orU1JNbjhsZTBId3lMemljTFZoSTJ3Tmw3OEdpVFY5TGVwQjc2?=
 =?utf-8?B?a0Zpd2ovbTJsSmx1bmtEUnJzdUVhRi9oNGdUYkJaMVZPMG9EMXd6SjdPazZq?=
 =?utf-8?B?REJ4Vy9iUXgybUxscUVjdG05c1BVN3NMSTdMR2VhYjU1VjUrSFl3K0JxeHBl?=
 =?utf-8?B?Q3l0b1p5S2FidEJwL3g1Q1ZaWkdBMW5vTVMxRnBoWEUrMndDK3RKeDhqZHl2?=
 =?utf-8?B?eGFSUzEydVI5ZG9aczR3bWZmSE0reXNlQzg0cHVFU2ZPSG9vR1V5UzJ5Z0ps?=
 =?utf-8?B?dmZ1aVcyY1FFL282YnA3L3MxTlJ4eVpuL0YxSk5OMXoyOGJCUUdjMnJVODMz?=
 =?utf-8?B?OVc4cGJxRStEN0NJVENYV0t2SzlaY2Z1TWx5ZXpaR1R4N0tvQyt3RlJWaElJ?=
 =?utf-8?B?cXErWHp5eU9DdjdadDhKUXM5aU5HT1ZuQkUzbS9BVW81eWZCc2VjWGJyMDh6?=
 =?utf-8?B?aURIeG52ZndqZm5WUTB6bERkT1VDdGFvRlZRVTcyMWcxaFVqQll0L05CQVVG?=
 =?utf-8?B?OE1rcWpKdnJ0QUl3dm1nUDBZRWtBc3R1SE1oSTdiZ1lHTXU4NzJCd09QNlA2?=
 =?utf-8?B?VGltWnpPMU8yNmZHUFlWSm1BUFV6SkFKaTNHNFZyeUFkY1ZtWjNiUGJlNG1T?=
 =?utf-8?B?d0k5L1AxdWQ2YStpUVNKeHQrcUJoaDBDWGNwUitkVUp3TnAzVlM4L0NOek05?=
 =?utf-8?B?emtXdXBTdXdWd2x2SXJQZnRWMEFzUVlzU0l6UFlLbGQ5OXdCVFRjb2wyVVRU?=
 =?utf-8?B?cFZUcmlZVjV4SS9kaWZzSjZhRS9QcXNMVlJreEI1VktDM0FhWldmZG9xSG1o?=
 =?utf-8?B?Q05veXlSSGtVWHgwSHdPWFRGajJxQnRRenlJNjI3bHpHT21ya3RJcVo5YWhF?=
 =?utf-8?B?elNKK2IxeXFXbUxiQ3A4SVdaWmtKOFluNE9oRTZqQThCVnBwRmtidlp2QWxm?=
 =?utf-8?B?Q2NBTGE5UzVaMjhZLzUzbWFvVWNZdnRTQlhmTVdkT1NjRHR0cllNVDVpdHZn?=
 =?utf-8?B?b0RuQllCZWo5UklCdDdrT3dXOUJnVGpXUVpxNm5mMzFLdHFVb2FjWmQxOExh?=
 =?utf-8?B?Y0oydjFLZlZGOEE2aVR6MVRnQ0lhZ1J1Zjkvc3NQZis3czNoWUFNc2x0VUFG?=
 =?utf-8?B?VUczeERRWVV1UG5wQmdqQ0daSGJyMVBnMFdVeXZmcEtjZjgyY2wySXg3UEtI?=
 =?utf-8?B?UXlzZWRzTElkeTJEVytia09MWXIrd0ZSUGRkMzdEdkJDczhSd0JlMGIybmJz?=
 =?utf-8?B?VU93RnEwaU9ISzk2NVpWMXdSWkJxZ1VrNjRJbDdURnlBUUdUVFpWd2c5T1RI?=
 =?utf-8?B?OGwzK2VnVzNaby9QNHJ3ak9xd2dSSGZqOWRQNktpa21Mb0MzcTE5VDVxVEY4?=
 =?utf-8?B?RmRWVzRtYzBxWHZFSVBWOFhlMjVXRUxvNUZ6ZXBlOFo4bGh0aHdySXBNWkts?=
 =?utf-8?B?T1pHaEljZ1cyQWE3N0ZZcjJ4SVZ6cERwaE1FK3doM0tDSFJMNmpzVklXWG9t?=
 =?utf-8?B?TUVLS2JvNzU2cFVhNmFOaHcvR1BERnVvaGs3bVM2NzBpOExML2p1clVMRmhT?=
 =?utf-8?Q?7P961oubdMvUUtVIVQYA/JJWEOW55b3JDpqsY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd160737-5b14-4139-cb59-08deb6bb4616
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:00:58.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f88UsbjlGb8+214/FkyPtah/A0WMOH5uQvl2dTHnFpZ4vdAQxcdYDs4OdW+7pppqCNn2n8E+TBoYq+6XrmKldTKdaTqu2RgR6IDj4MV+o5ivWnleM++9Gn8WPQEatkrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10579-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 726A459BFEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Introduce dmaengine_prep_config_single_safe() and
dmaengine_prep_config_sg_safe() to provide a reentrant-safe way to
combine slave configuration and transfer preparation.

Drivers may implement the new device_prep_config_sg() callback to perform
both steps atomically. If the callback is not provided, the helpers fall
back to calling dmaengine_slave_config() followed by
dmaengine_prep_slave_sg() under per-channel spinlock protection.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- replace mutex with spinlock in commit message
- use spinlock_saveirq according to AI review results

"The documentation in struct dma_chan notes that *_prep() may be called
from a completion callback. Since completion callbacks often execute in
softirq or hardirq contexts, if a thread calls this function from
process context, local interrupts remain enabled.

If a DMA interrupt fires on the same CPU while the lock is held, the
completion callback could attempt to call this function again to queue
the next transfer, leading it to wait on the already-held chan->lock.

Does this fallback path need to use spin_lock_irqsave() and
spin_unlock_irqrestore() to safely disable interrupts?
"

chagne in v5
- remove reduntant lock commments.
- use kernel doc to descritp API

chagne in v4
- use spinlock() to protect config() and prep()

change in v3
- new patch
---
 drivers/dma/dmaengine.c   |  2 ++
 include/linux/dmaengine.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 405bd2fbb4a3b..ba29e60160c1a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1099,6 +1099,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->dev->device.parent = device->dev;
 	chan->dev->chan = chan;
 	chan->dev->dev_id = device->dev_id;
+	spin_lock_init(&chan->lock);
+
 	if (!name)
 		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index defa377d2ef54..6fe46c0c94527 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -322,6 +322,8 @@ struct dma_router {
  * @slave: ptr to the device using this channel
  * @cookie: last cookie value returned to client
  * @completed_cookie: last completed cookie for this channel
+ * @lock: protect between config and prepare transfer when driver have not
+ *	  implemented callback device_prep_config_sg().
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @name: backlink name for sysfs
@@ -341,6 +343,12 @@ struct dma_chan {
 	dma_cookie_t cookie;
 	dma_cookie_t completed_cookie;
 
+	/*
+	 * protect between config and prepare transfer because *_prep() may be
+	 * called from complete callback, which is in GFP_NOSLEEP context.
+	 */
+	spinlock_t lock;
+
 	/* sysfs */
 	int chan_id;
 	struct dma_chan_dev *dev;
@@ -1068,6 +1076,84 @@ dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
 }
 
+/**
+ * dmaengine_prep_config_sg_safe - prepare a scatter-gather DMA transfer
+ *                                 with atomic slave configuration update
+ * @chan: DMA channel
+ * @sgl: scatterlist for the transfer
+ * @sg_len: number of entries in @sgl
+ * @dir: DMA transfer direction
+ * @flags: transfer preparation flags
+ * @config: DMA slave configuration for this transfer
+ *
+ * Prepare a DMA scatter-gather transfer together with a corresponding slave
+ * configuration update in a re-entrant and race-safe manner.
+ *
+ * DMA engine drivers may implement the optional
+ * device_prep_config_sg() callback to perform both the slave configuration
+ * and descriptor preparation atomically. In this case, the operation is
+ * fully handled by the DMA engine driver.
+ *
+ * If the DMA engine driver does not implement device_prep_config_sg(), falls
+ * back to calling dmaengine_slave_config() followed by dmaengine_prep_slave_sg().
+ * The fallback path is protected by a per-channel spinlock to ensure that
+ * concurrent callers cannot interleave configuration and descriptor preparation
+ * on the same DMA channel.
+ *
+ * Return: Pointer to a prepared DMA async transaction descriptor on success,
+ * or %NULL if the transfer could not be prepared.
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
+			      unsigned int sg_len,
+			      enum dma_transfer_direction dir,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
+{
+	struct dma_async_tx_descriptor *tx;
+	unsigned long spinlock_flags;
+
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (!chan->device->device_prep_config_sg)
+		spin_lock_irqsave(&chan->lock, spinlock_flags);
+
+	tx = dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
+
+	if (!chan->device->device_prep_config_sg)
+		spin_unlock_irqrestore(&chan->lock, spinlock_flags);
+
+	return tx;
+}
+
+/**
+ * dmaengine_prep_config_single_safe - prepare a single-buffer DMA transfer
+ *                                     with atomic slave configuration update
+ * @chan: DMA channel
+ * @buf: DMA buffer address
+ * @len: length of the transfer in bytes
+ * @dir: DMA transfer direction
+ * @flags: transfer preparation flags
+ * @config: DMA slave configuration for this transfer
+ *
+ * Detail see dmaengine_prep_config_sg_safe().
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
+				  size_t len, enum dma_transfer_direction dir,
+				  unsigned long flags,
+				  struct dma_slave_config *config)
+{
+	struct scatterlist sg;
+
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = buf;
+	sg_dma_len(&sg) = len;
+
+	return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir, flags, config);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.43.0


