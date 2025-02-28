Return-Path: <dmaengine+bounces-4614-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A855CA4A0A6
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A81899AD9
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15C25DD1D;
	Fri, 28 Feb 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iP+hXKnh"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8D1F0991;
	Fri, 28 Feb 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764557; cv=fail; b=pMx3992RVq7ot68xcCUrnsj1gN/xVylxe2Un/Ni9A+sQURoj1AHpUiDKfkpuBkIPlC6de6EBsKIgCI9OooBrRJ5LXdMCBBlzFBjDTct24/kRNtZDUuEjcmdpjbZ7kRcn+pEAJEuDbFLjN3TZLUDH10aX/ibqI9zFysTIRHt9MGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764557; c=relaxed/simple;
	bh=oTjSEYnhDo9nAYFIC/QeOoe7IM9FvKQThAp+PYmyQEo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MIUsbptsJxj7lJJPmNfSk91cPmahpV9b/A/NlN/eXjriOkVVXwQVbjM8tX5qRsa6dAGijVI93r1P4zP5MiM/0DBerjXUvgQp8rzyl4ZtgCTcVwgBwmob9vHoJ8m+4kiJqskGOU9bna2KD6O4Nf2yuvVovjJHQAPm/zzkMb4hxL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iP+hXKnh; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYfZmYnOeGJ+XQ5Yzu6A8v05Xg3M+0E2Q7Bzv8+c4HAvdUzLotU+TvQUQfC7noUn5bPmRR5yvM4LpaTSL6Va8Xr955E3rBxokpeWkRRkiqgX5zJsMn/TPG0wkZQjUq9gfB6jGsZJnS4pgu8d5y4Bm+9J6mSwrt83c+W9vAOHelzjSLgrMGahjgoNJJZBYSEjhQURtRMjiMb2Gb3ETdKb+jycnMsqoU45AV1ikgrgk+yJ8KW6rVLPVYgLAqNfXuGwGOa+AqDKyX3H+dbOcbhqRPxPW/zKsFU/6H1xpLGBAV6h5B1inkucFH3+wzH4wVA2pMkch3RJBmw2Yzxr66V00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVn/3bOB40GUMzOnnlNWzrDdN4eXA2N+0zK22Y5JBh4=;
 b=qqI8qQFcnr6m8jiR5eaOp4wjgA/3RUNVID1geJUS7icibl+Cyyr4/TWivVVNPkWew3XDrAKnYnqv95EgY4OAwNHa9xldr9XOV5TKolDX4f8U4UG3wxIrfTCMl3Lz3BOhs8Vks87Ft0Zc8JZiPQWV10/k5Q261TBO2qUlVGR5XZ0O76+1T+WJ5zfFUeySBhpxZO78g+tRNGvMeSblYpyTV7HqJMSmo5kCpy9ihP2PDNR/pvdiNsA6cKksVDXZIM06tqeRN/rx1ljj8aLl6AhR+4JRK8x8tgSRXG6t0Q0wWH3vP+K79EPE2IRkV1S+FTL1eXFWnFQdwgxstnBh3ijovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVn/3bOB40GUMzOnnlNWzrDdN4eXA2N+0zK22Y5JBh4=;
 b=iP+hXKnhZMHoVsx9SXdix4Q0or0uapKvwD/s5h25MBWx2JhMXYE+MVzaRT6FN0lI8SoLD7JpmmUpyPsu2stmMSJMK5PptA1fTigK7jnskyc0aOg65uAv/F44cstrq8KxZS2dEjrDUbgPXBdSJ+LPuojEkA+QdN+0XKHdFjGORrqCblKJZuzBiz8cTVMmnJgKi3TXVkLsxf0gyfp/WgBcAoDFCSoiYl0C1rk6LiZYjcgWbzkZ+O6hJIObygmRNSDN8fHnzEpbrxWNRCsKcyuN7+XPQ7vw4dTwSvxVh7pmuH1dFdpdxUmbTRFl/tVOoVqTBnypcfy7cMXJQr9k6JKT+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10498.eurprd04.prod.outlook.com (2603:10a6:10:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 17:42:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:42:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] dmaengine: fsl-edma: add error irq to help debug
 problem
Date: Fri, 28 Feb 2025 12:42:02 -0500
Message-Id: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGr1wWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNT3dSU3MT41KIiXdNEc2ML01QTUwsDAyWg8oKi1LTMCrBR0bG1tQA
 4vpyFWgAAAA==
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740764548; l=946;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oTjSEYnhDo9nAYFIC/QeOoe7IM9FvKQThAp+PYmyQEo=;
 b=fR7BbgEcmvHF2qsZeKpt+owiXtoP48K9JQdipeHm7L66lwTdI5lzSG7cqaJc0VqTSIAoYdpNf
 8Hmi4QpnEucCNvj1XAbLqAOI/9tNQYrExfYDIJnp2jpxdnWAcx9/KvR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10498:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f42d537-1499-4aba-179d-08dd581f472f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEdRby9Ick83c3JRaVhseWRaeFd0L203ODlzU3JIVG5ieDBKM0xXOWU0enpt?=
 =?utf-8?B?aldVbXEzWGRzbUNzRDJNaTBncXZIL01RVklXbVMzY01IVW1hVUdtb1RtOXdL?=
 =?utf-8?B?RTFPeHpraXRteDVSWGJMRVRFTTdMN2dnQ0ppaWNwaVBUK28xSjd1N1M5Qksv?=
 =?utf-8?B?TUdlUnZzSEd3VlNpTkwxZEpoNGpnTHREbTFRV0tSVlFObTlob1BPcVJyakFw?=
 =?utf-8?B?K3FwbjBKM05EeHJDSTJtQ1pOSHV4SkExS0FjVU9IempRSjBGakdxUjBKM3VR?=
 =?utf-8?B?WTc5VVhhQVlWSkJNTjVPVWs3YkU0SEYvL0ZrS2F4NWlsK2J3N2I4M3RXWGNL?=
 =?utf-8?B?ZXZtVXRDNWNFd0lTTXpQajBkSDlrVGxFRlc3YWR4ZDVyaThNOURJTS9pWU1Y?=
 =?utf-8?B?enR1czJCWXRram5uR0tWak1oK0Yyb3BFU21aUEZJMVozZUp6K2VHd0hqdm1v?=
 =?utf-8?B?V0dUMHluMlhkc1NOK1h6eGgwTjJ6MjVrd3lzVWhmUUVRUWtwejQzb1F5WUhi?=
 =?utf-8?B?QzQySnU1eE5yTTdzNDc1Zldqb3Z2SU1FejZNdGlZSllTbFpXV1BjMDFWTm43?=
 =?utf-8?B?MENCaW9PTEY2QVAxNlpyd3U5bExkeGJFczZxNERkT1lrU1lnaExmWFE3NDFM?=
 =?utf-8?B?bmVMTEgwbmxVaXpNcjNOenNPOEZXOFlLRVlrYzFmV3hsZFRnemNVWXBpYk5D?=
 =?utf-8?B?NkZvRGNlaXZGUXAzenNGMENZcDJUaWl0TzNtNjhuZVN3Zkg2NFBDc2ZwTUFn?=
 =?utf-8?B?NFpRdjBzcURwYmFvcHlrbXVMaXd1aHQvZDNUaFQ1MmZjcllVOGtwTmlVTlVi?=
 =?utf-8?B?RXpRd0IwU0lSeU81TEd0TGNnamVYSFlBMU00NWViaC9ld3lyL3J0REhTSjN6?=
 =?utf-8?B?enh2OVIzWW1ZWm5BY2YwbUJxWVEwRERidlBiZlIwODVJTzgrL0FoN0o3RXpk?=
 =?utf-8?B?V1Q4UTlvWDZKUUovMFZDOU15RzdVMDQ3MjNlUGorOExhLzBPRnZaQWtrem9a?=
 =?utf-8?B?WDR1N0xOdHdLL1ZTcUpQenhqK3V5QkFsQmZsRVhnRHNJNlVZWS9qWFVjK1JH?=
 =?utf-8?B?aWxpcGlvNHFNTmpZSzd0aTROd0ZTT2Q3UTJCM1l3YThGTkFyNHJYcGZKQk1t?=
 =?utf-8?B?Q1FnMHNqUWdyVWN5VXA2UFF3MG1QMDlhdldRd09yL3Nyb3hwVVVtNm5DY200?=
 =?utf-8?B?Vy93MWo4VXpDSTdqTEY5blNWZzNhSnMxYitqbnczNnVuRnZ1ZDFKeHhVRHBK?=
 =?utf-8?B?MHcvTnNMK3kzcXpwS2x5cUdBdmhGcUU2STZRTWR2UXQzbHVzU1RTakdrTzB0?=
 =?utf-8?B?cktKQWwwMzk5TkhBdlpkb0NveEQ4WTc1M1hEQjlrT2hvY1ZSc1ZiS0d5aEtD?=
 =?utf-8?B?VC9TZlFCeUxTdHZ0eGZJcVRiM29PaDZsdWk0QWt0Y1p1WHBRak9oL3NTcWhR?=
 =?utf-8?B?N0lMTUZZVTRZS3ZHMnFzTThzUHNSUUUwb2hXQ2RSRlQ5TWorUVNwWDR1Y3g0?=
 =?utf-8?B?MFNxd1VGWUQ5QVVicGhXR3VGZjROd2plNXFKa083TXZMYmJnVmdFUjI2Rm1Y?=
 =?utf-8?B?cHBydDQwVmVxTVlONEVCT1BCMUpqT0VyTkFtSitTb3p3TklMVnA5ZGpUQ0o1?=
 =?utf-8?B?aEMyY2ptSG02R1JHS28xUElSQm1mOWtmcE5KUDMrNGZ4eHE2RVE5bEljVEZl?=
 =?utf-8?B?cWZhYTBocXdtV2hDcGxpaXBmVlUrMlg2K0lranMySTJ2aUpVOG9Ed2ZzcEQr?=
 =?utf-8?B?MlpOcStjS3luT1RYeW1pSFNoZGpYeU5Nd1VyUHBjYVErYXVvMnVzQWExZ0lW?=
 =?utf-8?B?VDcyZ0hiQTBhTGRXcmFoU3FMeHpCc09oOUFiakZyZm1ZQW0vb0ozMXBtMUJo?=
 =?utf-8?B?a2Qrb0hMT3NzTko1c2czUWgyV01PTmZIMVNEMk1VQWMwdzFnczI3cFRMMnV0?=
 =?utf-8?Q?qLgtm1q9pdnjk7NTQjTDlwEQMlI+lJvm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VS9HT0dKcWpWd0lnMzFKWSthaXdhMkJrc2RRWUdmUHRiV2NrMVZnak5Gc3ho?=
 =?utf-8?B?Q2tqYzAvaXdZTFpBTldsNlU1M01wWmxOR1VZSjlYL08rbXNSQ21PSEVpejFY?=
 =?utf-8?B?a0FBdWtHQ0RqUXZRdXQ3dVh3TlhoRmlvaUNoUnVwMHgvbUtzcEdJS1hFSWF1?=
 =?utf-8?B?UVJYLzFsbFBCUkdibUFjcTN5QUdlSTJHenNzakwyOVhlVE5PckY5czJOR3hE?=
 =?utf-8?B?WVMyTDRyTmcwRmk4eVVQZVZ0WHJFRDFmdTk2R0VaMjFQUEFLSXI5eUgzamdj?=
 =?utf-8?B?dFROWFIzS1NBcVBNUHp3OXhZL2lNYTUxWVQ4ZmV3ZWdWT0RHa0k4RzZhazli?=
 =?utf-8?B?dTRWV2RBUFZkZXZRenNsa0x3RVN6eDBEL1QweG5ZUEFyRTdqdlNPbmdQemww?=
 =?utf-8?B?dS9OK3JXSUxQMzZBRDBMQnRKTXAvY01sV1ZiL3lTWGJQY0Y2VVRpQWw2VnZH?=
 =?utf-8?B?VUlNY2UrOXY0eXhxcURhME9NemZ3VkxRMnhKR3J0MHBDT1ZIWTIza1FVdDR0?=
 =?utf-8?B?L3FLNjhOVjhDbWhoWTNXNHFTRDR1R1FuV1Y0c2RzYVFvU0laaDdQK2RFdnl4?=
 =?utf-8?B?L2w4NWVza2lma29pRERsUjhzekdRTlBuODRFM2VsMXQvcStEeDhYSHEzQVE3?=
 =?utf-8?B?OW12a2FuRm5RcHV2L3MyUU4zcTNBZkVmS3JIazhxVGMrekpYVFdYb1o2WWJk?=
 =?utf-8?B?TmNMRFhrbnV0UDRtS09RSzVWcGk3RTBrblJpQWdRbG9rbmNoT3UzeDNBM05G?=
 =?utf-8?B?U0FtdFdxM2ZXK01NOFFXUWpMVm5UcGExRnFsa0ZrL2VrZ1hrM0p1eVhzNVZ0?=
 =?utf-8?B?aEFiU0djQkxRejNlY1lia0s5ZmJPb2JyaENWZDE3UWs0OE4zZ05henZWaUFN?=
 =?utf-8?B?cktkZGRmL1FTdVFTaS9zTlhkUWZRMEpqdjN6VnIwczUyOEVVK2F6dmYwYU1G?=
 =?utf-8?B?VmpERGN6cUhMRFFLZmVFVWVRTkFMRThnQStqYVd0L2wzY25UejhoMnJueC91?=
 =?utf-8?B?d2ZlSEtIbVJYSlRMWkZTd2pRYTA0ejVuRUJJSzU0VUR1T2VpS25XMk11bmpU?=
 =?utf-8?B?N1pMMUt5ekptRDY5NDRsWGU2alprWkxVaCtmM0xuMFk3S0FxemVDRE5nT0E5?=
 =?utf-8?B?TlIrY2Z0a0laSEw1U0V0ckhjZDRHWHAwczc5TzlqZm1QTTFaeWRFQkxMVzQ2?=
 =?utf-8?B?aU5VVElvbzJxN2RVNE54eTk5MHdmWDlJalBrOVBKT3hZY0tDMEJ2Z1ZsRHN5?=
 =?utf-8?B?Vmc1OXhyVkdPQk9hZ1VYdVp4eGY5b0FOekc1M0xsNDhteTdNcWtLZnM3QXZE?=
 =?utf-8?B?TEpWWFZCSmZiMWpvS1JYZTMreGV0TGJ5R2lkdG1FMVdsanRyZ3pvVEJJczA0?=
 =?utf-8?B?K3Z1VnhvZnlwWXQ5Z3FQK2thTjUvc1JnS0cvUWF4RG1vWm8rUFdRWExoRUI0?=
 =?utf-8?B?OExZK2xqU0pmOWxwQmdZcDRYbVNwcnE5SDdVM0QxbDIxV3hvelFiQkpvcTZB?=
 =?utf-8?B?UnB6TituQmFhdFRkZE5wMUhwVjRicFdJRmNtOEtPU1Vja3pMVUttYlU2K1FC?=
 =?utf-8?B?OUlRWGNGVkk5T1pqQTAvT2RDamFkKzhkNWFoeWlHQk8vTFIxTnJBN1RkdG9K?=
 =?utf-8?B?QkxONExTUWo1WGFYQ2lIRklOWG0rU0liMjdVTC9YdHJxVnpTaEdSSzlIVkc4?=
 =?utf-8?B?YmorUkdIK1RjeXhqdkpNc2U4STBxTXpYKzFWU3dOQ0U2MXNKblRBYm1TRnRN?=
 =?utf-8?B?eEdMS0lDZExCa3FZWmp1SU1MeW5ZL3BBNWtTakd0ZlB3R250emt4bG1zUXg0?=
 =?utf-8?B?QkxQNzZzUXJYNkw1ZldlR3NTLzcyTXdWQVlqcEFpbC9XbzlPQk1BdlFDSFQz?=
 =?utf-8?B?OHVrUTdkMituSFo4TnF5U0V2Z2ptOUZqMHFqUzFDSmR4cjhLR09FYUVlNXpz?=
 =?utf-8?B?T0xScVlHNGtJN3V3Y1ZDM3RaK3FEcis3SGlZQ0Z1TXVIekRlZlUrdTVBcmNp?=
 =?utf-8?B?UWVPYU9LamtyTFlpdCtMQ3F2VmxuQm5MYXA1ZXZKUXlaVUtKUVpQYk15bTJZ?=
 =?utf-8?B?eEQweC9kU3F2K25MNUh5bmxGMVZ1bHFkNXNMKzg4L2JiYlQ5Szl2T3I0MEtT?=
 =?utf-8?Q?uwYLqldQC/ovfS8h685itknW/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f42d537-1499-4aba-179d-08dd581f472f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:42:31.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59EK4dFx1NvVVJOtDef9+mQaf2gflFmpk6cjPE02vLD7cBMbx7wSXqWOwCf6WalJjMozabGNGdfgivQN1s+h+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10498

Change binding to support optional error irq.
Add error irq handle for fsl-edma drivers.
imx93 dts add dma error irq interupt.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Joy Zou (3):
      dt-bindings: dma: fsl-edma: increase maxItems of interrupts and interrupt-names
      dmaegnine: fsl-edma: add edma error interrupt handler
      arm64: dtsi: imx93: add edma error interrupt support

 .../devicetree/bindings/dma/fsl,edma.yaml          |   4 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |   6 +-
 drivers/dma/fsl-edma-common.c                      |  30 +++--
 drivers/dma/fsl-edma-common.h                      |  18 +++
 drivers/dma/fsl-edma-main.c                        | 121 +++++++++++++++++++--
 5 files changed, 158 insertions(+), 21 deletions(-)
---
base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
change-id: 20250225-edma_err-5a7385e45800

Best regards,
---
Frank Li <Frank.Li@nxp.com>


