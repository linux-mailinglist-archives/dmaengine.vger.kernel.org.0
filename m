Return-Path: <dmaengine+bounces-11997-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dr5DLbjXRmr0eQsAu9opvQ
	(envelope-from <dmaengine+bounces-11997-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:27:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 111716FCF2B
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:27:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=k3I0mwKT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11997-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11997-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D4B30EE360
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809DC3A8FE8;
	Thu,  2 Jul 2026 21:22:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DC3A8FE1;
	Thu,  2 Jul 2026 21:22:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027338; cv=fail; b=k52/Ryv/lg1Pr0q0jXjfiOnbC72wpLzngS044tFA5cUWyIcTqbRvllkDfZ4We4HDM7O+Un2zo+S673q+623reesqtX5risNkUDMgBp2Q5kqKB0pn4MmH90D7/3PrxxuN/xDiRokLruqfIPi7bRvAIKyfpkxDnzU/0XgcdoJ0W64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027338; c=relaxed/simple;
	bh=R+OO1eVTXwWzQwQ1ofpPWy673kxBSxxMcJ1i3QVIuFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BcEpZ5+NBObr+62AqnJcw5OIhM2V6DCUxeAPuqS8qT7STYeQ3mCBj0bdzMvrQXSb6vAOGjy4mJG/9NYu5q19v8B7PiWbneEW547fQbJEslbPNv56kvFaAzjcjJU55fiCPyChMyHmsgKYwj03vZGOb1trnnC+t6xoeVGQuBA5+jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k3I0mwKT; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP1+FReBNYy4KXyq2JKo6CW3V47Vr2nq9kpThvetRuywKE0qR+GMh92Wlh8Cr7Ft/aDmt4YEhZAxkhpLbEB/z672ULCkWObZ0Otng0SvcgyAitLpZoRgxYADujeY0dM12vsPZUIWALmrN1g4VlDKIB31b28qyCgJcB2Afxr+j3XASE0JRVl34Yn/uWJC3shjb2ysv1iU4zkGbqR0j9z1apuwSuOcGQBZTTVvGLDmwYhJvupKz7wXeETDG6Q0Ef+WBoVwRBV74x+S5/WiUGwGdYJXGtOBE/vx6AyrhlIk60JzNoaV42fRxC9eOwDeoSDiLBYWAXqPclrCcOmgRKJCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZKjWH00lAKSGEOJrAX08WJgeeQyon+bB8M7gVdV1ow=;
 b=q8I9rpeoQ1p0WakGhdoX4+g8JVRSt62vquIKO81zLfdhpcKlfk6fv9YL126mMae41VF9OYnrDvJDOcpFV7El3qcFwuwHra5jpR+p6I2PuYw56aqOM0stC3MkdoGhte8aGo3jdketo9/pTDKHqQaa7eKT/PY6hzNsy/3c0pv16WgI2w0V6EB+Dih/cY1B79fysey604mcXxA6vmrpl6JLc23CBJXXVp4Dt7KpN2J9OXXygh0I7awL+b9VSmX16SxF5B0tgfet9x0ZzRfadGW90Q3WsTAus7kgS6Hj/Kq8ib4vL/EYo4sW5KuVbmMgqWMiXk1raQCoptuK/Oo9oJdkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZKjWH00lAKSGEOJrAX08WJgeeQyon+bB8M7gVdV1ow=;
 b=k3I0mwKTMgKVzLCF918aUSs9bFPuqulCDiOnkXLkZdhzPM+0buIo1OPtW0QNrNtGLgkJbTzNRi9DZbicLnyrxnP9b9Qt1GlAN2Co48T+EYVMYvrUZuFUwQ3sfupIcqtqAwEfSOYwZmvrt9QhqaDWDcb70uUot7g2u1bc7Tu67TPaY6dK3xEtO2Deu6KkyMqP2hNdxDUQMI8F5Nf2ygd+EWjG7dlnyuCmxT3A2loWk2CdByRgduD3M+mS/+ZWUxwZYmr7aCW5EKliKTwyU8U1Tl1PLBpKJ7315qM1K2G9vOH/P11Ukng/hIkC2BZDaKCBrdSRnDkt1ItuxJarhNRe8Q==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:22:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:22:05 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:27 -0400
Subject: [PATCH v3 07/10] dmaengine: dw-edma: Add non_ll_start() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-7-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
In-Reply-To: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=3598;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0FbI07sVk151xs0IhofSsRvZh0/5tRQQ3n/ygXCidmg=;
 b=GlXoLaiJaYHnsR2ggfXz2TD8jnRMaFt4LcA5h2LcFnC4U/LSkiHAh7BNhpcJ4kqTHkH/X0qWi
 oT2KYYtDmE5ABHuCYKPFBINzST06+THHhAQ1shwpTX7ZTbp4znkhXhe
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 67585733-d4b9-4bf7-d0a0-08ded87ff6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	+ZPR4hFU9j+X2dflijVR4+W7EUKA8U4nWJ2rVx10YdbYGKcwk+hOy1jLgNLECMA4PeaskSqM9/z8ZU21tRvcQIEnrY+MqsB3Yf9qPCs3En/3PUi3cormQCqX5s4/QBcCjf7vNM+WEz0ZEFlELSc8M0guQC/MEmmiQ3Cs3c2aceeQ9MAFyxN5jcaBALfVJd/kmb8JGlUzoAvoggaAA7l/5lznqUr8tQF/ai/5YazVfxSTtD0X24sniTph/Z4wRRsTMvXu6XbHk0flMokP4WDqU7WDBg+QLpxyfh0EanFSfNLX3lCPxY7Y/tBx8Z5rxZK+/IdExOXYt0gwtj8GuI5vwF1tYgIP5pIKnpw38yacgYLLC6uv8ypgolzdurf1SYjRbOTGOoAA3vgdcJhUAbV9M+3Vnl9kbBWTlubcP7eMdBLWEweusqwElt8/CDE4oCfvZzf8cuCLFOo+8+4HkgnL8unVPxJnxUqCZOmCDC2iOOFnc1ZxFF9pQZ+Fs5rR2cA/A1CCI/Z5oQMwbDRMIRNjLUp2cIuC/Zvvor3/23XNktbM9Ib1/LNLhvP4EYfWcEo12thOaOYX6JpiFPAzAEMYOYH+7FsIOGDGbsblrNvr3dvqRWEpaHsT1fDu4pArShoVa+9+deR+he1IfWcLDjZALG9AX4yr4ebCaskiRYw/keUY3nS0TSH1okvjGpS5rDHLYHb6F8ybmRulEehvicYcuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVY5ZkZxQ29NcHhaVlVPZzFLZkZCanV3T0gvUkxpU3dmTWs3alBXNStXcDVh?=
 =?utf-8?B?bkx1VWxHREdrSzV3bXpRUmhoOVZCYTBwVnR6SUVtUElnMWhQd0o1Q0MvdUQ3?=
 =?utf-8?B?Qk84YXlxS3NwZjFLNXFnQUpiMi9FaUhjaXFqTWRuc1AvVSt6LzZHZmkrWWZl?=
 =?utf-8?B?cWFlclhUcDYxbFo3ZXc1TWt1dkE4ejZDMTBrMndsVmx5VkFmMDloSHZEbllt?=
 =?utf-8?B?enVESHRTcVR0VGFRWGhsU1JCc0JXZXRzUm1EOVJ4WitiSmtOYnpCVGJxRlFn?=
 =?utf-8?B?ZmsySEl5c1M1UjdtRXdQenhrOE1BbmgvS0l2NFB5QURJRFJLV0lXamFLcVhM?=
 =?utf-8?B?eHlTUHY2dkE3SENDQURHTTg2Z3J1clZGV0F3NEhRT1E4eXlGeUpkbjdXUGpX?=
 =?utf-8?B?SGFzNERGcWJBbmlIOTVMdUYwUWRRMitGZSs4MHNWaGxkWnF1MTdmOFVZQ3By?=
 =?utf-8?B?L0lwZ0VoU1NPOUFRVFRYUFFsNmdiMGRsQmxWcGxVSjhKZlVrVWFuVzh1WXh6?=
 =?utf-8?B?c3AwbHpTdXJEUkdnT1A5K0ZBNXJZaHNIVnFLOGVSK0FqcVNGNkUxNGoybTd1?=
 =?utf-8?B?S1grN2JLcTVQTUMxL1NOQUxIdE9kTlpxU2xIc1k3Uis5Q3JOeWs0M0JmL3hE?=
 =?utf-8?B?T1dMOU9HYkYwUDJwMWs4bWw1MFRYQ1lkVERHTTdpS0poVnhLUTRtMHFQMjJp?=
 =?utf-8?B?VXBFSVQySUFCc05ualk1VDg1amZCWFFmSS9lNkNGUHlxVHpsUmtNM2JKbFRN?=
 =?utf-8?B?cmlhQnoxK1Q1RGpHWTZLSG1jNGl3RW9yTmpvejRNRnhFUlRzVWRuc0t5R1N3?=
 =?utf-8?B?R0NwdStQTkJJaTZSdXFUaFJodEhoNW1JV3puVGVPVTRPNW9rOWRoU1U2SHo1?=
 =?utf-8?B?elphd2xXUEJ4L09PVXZSZEFjMzVWWC9FcFJWMTcyc1ZiVm1BZ3h1K0w5Qksz?=
 =?utf-8?B?V0ZGTEkyZlp6SVVQeUpkNEQ1S0sxSGN1NXA0V3RGdnNtRTdKSlU4c3dTZTMz?=
 =?utf-8?B?VkpYNGlOdGQzamNVTGZQTFR1cDNod2I3RXR6aXRORVROa0UrUmZkazBEaUt0?=
 =?utf-8?B?VVlzOC82RklHS1FTQ2U5U3dKSWRKb0NTL1dGYS9RTnA1aEdHeXphbDcyanE3?=
 =?utf-8?B?V1NONkVQQWhoUmtXQWF2WWVsdkdNWHFxQVM1UCtVYXB1dnpWdnhmRngyNmE4?=
 =?utf-8?B?NDBzV1h0SzYrMVA5OVZvcENaQmMxYW44cThFcnhiblZKaFhhdE83ZmNrZ3dK?=
 =?utf-8?B?a3NpWGJBL1lJM1ovRDE3ck8zaVRDOGZKWmNoMWFmRmo4WWY4a203NnhJR1l5?=
 =?utf-8?B?TVpJYlRKcWVjbmFIejVTVkNybHQxZ05qV01WRnEwNVVwNytiUjJqNmw1cS9n?=
 =?utf-8?B?MkV6R21QUHVXb1oxQ0VGYlMvZTZhS2U1b1c4eDJpSitJTXBpb291SWw2ZDFX?=
 =?utf-8?B?dkVxR3l2QXJCN1J6TWdoMUI2UmJ1UDZ6MzFNWkVoaDVQak5OZlRGai9udEJP?=
 =?utf-8?B?Zk5KZHNLV0l6SFg4RlNJaFUxNXE3UWV1L095TWpYdXBvOEdtSzIwY1p4UHEy?=
 =?utf-8?B?YURkNFhqaWxNb0M5UjJkNlFta01ORTdEcUNVN0FvcWJLdHJEYUJiTjdPMURN?=
 =?utf-8?B?UmJFWGViSmZVcVh1YU1QYWlHTXBiMFBWdFR2SkV1cHhXMXpKRy9tMUZvYjky?=
 =?utf-8?B?eGlNdllZaUcvckNIMUxKMTFvZEFhM09RV1hna2M3MFFFNzBPMmk0YkRyelRp?=
 =?utf-8?B?cnBBUmdMcjZmYkh4U2REZWl3b1ppdGQxV053SUR0L2wvbGZSZTBSVVdZZ2Fa?=
 =?utf-8?B?bURvZXFTalFTM1ppZnU5SExqWmgrRCtoSlRDR0Y3YjBFVFloZ0V3SFVCTzND?=
 =?utf-8?B?dFVPQS9oQVJESkZ4YUltUzZ5aWZ3b0hjSHNydjNLWnNqaXNUdjlwMVpLYm45?=
 =?utf-8?B?bnVjRG1wUDgyTzdUMnFDMVdxZFFQUkFsNjUzenVLSStSM3didHhLUWpXY2dQ?=
 =?utf-8?B?c1FGK1N0RitUSGZCbkJNdG0rZy9iUEtVUnN4RTJ6aW5raDQzcDdkakl5bHZw?=
 =?utf-8?B?cXY3dG9WT2VKSHh6N3hzTW5zL3QycGpHamZUVjh2VEs1ZmdReVM5RVlnemxi?=
 =?utf-8?B?WnNHQzdadXg0aTltVzBHT2VWMjJ4WW9lbjNTTFRLZmFLakRUUVZqMkQxZUp2?=
 =?utf-8?B?c0JRRG5tTGdDS1hJZXZOVks5U0ZoVy9JZTVnemJiNlJiSVRMdk55b3lUK2Mv?=
 =?utf-8?B?a3VsUTVUNys5MVFuNGlDb1lPSC95NncyaGJXUzBRVEIwN0RGQXVmSDhQV2Zs?=
 =?utf-8?B?aDhXK1RwL2JwTlkwS0NoSlBKN2hWc2lXMmorbjloME85VnE3a1RNVlhYdEZ3?=
 =?utf-8?Q?afvM4qes5nnD01YdlZIjPW0nhNv1r+2AABzAd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67585733-d4b9-4bf7-d0a0-08ded87ff6e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:22:05.0479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpBFLGWnRVOqjCc7aqqI6QjGJxjB++8nqdMFzrllzoJhxGCnu5ObICt4dSuzDo0qCoqdwp3qT0/DSl4HCnKhLRN9D6Uk+YMLBs4Q/eFO0qIQTyi5B/ZFU0MDSdJ+txOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11997-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:mid,nxp.com:email,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 111716FCF2B

From: Frank Li <Frank.Li@nxp.com>

Add a non_ll_start() callback and move the common non-linked-list channel
handling into the EDMA core so it can be shared by both the EDMA and HDMA.
Prepare for the upcoming reorganization of the burst and chunk structures.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.h    | 12 +++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 ++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index bab4d49c92feb..e18d6e827c2c9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,7 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 static inline
 void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
 {
-	dw->core->start(chunk, first);
+	if (chunk->chan->non_ll) {
+		struct dw_edma_burst *child;
+
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			dw->core->non_ll_start(chunk->chan, child);
+	} else {
+		dw->core->start(chunk, first);
+	}
 }
 
 static inline
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 52c6ea09fcab5..4cff839022213 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -272,18 +272,12 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
+					 struct dw_edma_burst *child)
 {
-	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	struct dw_edma_burst *child;
 	u32 val;
 
-	child = list_first_entry_or_null(&chunk->burst->list,
-					 struct dw_edma_burst, list);
-	if (!child)
-		return;
-
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
 
 	/* Source address */
@@ -324,16 +318,6 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
 		  HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-
-	if (chan->non_ll)
-		dw_hdma_v0_core_non_ll_start(chunk);
-	else
-		dw_hdma_v0_core_ll_start(chunk, first);
-}
-
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -399,7 +383,8 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_start,
+	.start = dw_hdma_v0_core_ll_start,
+	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,

-- 
2.43.0


