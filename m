Return-Path: <dmaengine+bounces-4040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51DE9F7987
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDE016AB42
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242FB223705;
	Thu, 19 Dec 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jdhXL2Ie"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CD4594D;
	Thu, 19 Dec 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603891; cv=fail; b=iSj73jyBw/Qx3VOa7NGFZupE3GzCQXq273aLzKKcd8MHa4rZ/xU4+pnMrzW747QXYuc3i1VB4wqTRVu9AwX6at/XmGHceTBGwXVtwMuC9veBKXTJfMKLVUNNM7ecf6813ANNBRqbWdnmmcH1yjfQuOeqPn2sWk7f5BApkY9mB54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603891; c=relaxed/simple;
	bh=WsjL2uE4Orn3phprwnKiCUlkr6URGo8bzo7MVbUmtbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=De/xxg8nvY1qZvJkh0FarImFZnts7JZV0YOD1bxvSU6XyrJcNIkmiPfW0OI43hoROTa+in6tfsIbgGt0wIEXXQuF4EHe3tTFYsq4ljzu1yFtqGuV1uuySkSmkgoxI8+50fWxuCjxb0yJgTVsXHR8BAt6DvfWIcw9o/yYNv1aN7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jdhXL2Ie; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pr+cDDSEghBeIflUuDco/AcltJF9AqCVLSwpvf3lSzGz3+Mx0FZprjdpMspQV7dlUuh+cACc/C/VKzoJQ/2wbn4UU/nGcdOwAnm/tLhE2eSAJbsLZOIw5EnnV9Oi5OKoc/OnAXIEBD2hOryMFvQvNi7ItgSERh3Vrc28/u4E9t+hV2rctc8EDR4lQFiR+yBQu89KNWIRXDLeVJCuMMnz9yPZk+uacCxRvVegOPD3FKc36JzHTxHGsstzZ4iDD/NCeF6zbWF40mkCFbnmQHqe/+ooPpzjpiI6gL9y/4drxCuMham1VQRDP0sm0MaaYPLYDQZ0JG1ylM+BF2EBfHbNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOYniJli5Pkhka8qYxssSA4O6lfU0+qc3aDbK4L90oE=;
 b=GAXQLzdE3sbA1nCo3fxOhMPjs1JwAPJ3jGDQ/6oDwvRLFL1gm91S1mnPhwH9/VDHHbKJEQK56BJahCo7NaR98L/nBXDL8thJqav5N6Dr3CAW/odb3SvVsIgvfI5NKdtK8qRkDmT+aYx7JSe3he854kweSGE3xfU7Ip/Qy/4vNtmPEzrnkrn1FvtlD0u6q6jOU9OZ7kzL13ieYqhdCWgzS2McBRO84GjA9l0mA2/cQ3l2GRdV+1VkoT5uiZRSW1TaZs0sqUmdebtUtuQ9d6XV3R/mo3TZ651K7C15qO+LDgRCPv3sBYpyDT+6wJHH7tK8EHqqkNS56OK3gT8VYl60aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOYniJli5Pkhka8qYxssSA4O6lfU0+qc3aDbK4L90oE=;
 b=jdhXL2IeYscjgzsOzxNOFrC3JJvtHUf8skBfFF/76Hyc4E85Xq695wbdzVKcZ6L/9Juc+mKgN/lb2/LUtSsJfb6nNfEbVbcdOtjitfNZYAPXXxcnt7hkg1AToiZOqTlRarX7sKIlpHFNfTlKmnqeQpb7FTsADUTPoi+UzFKNjVOqCHTgesDW+ZLx9TJkp7uO6cRsaS/sIvf8afdKhLb61kh7ADsPxrbu1Knoh0dzH5RKK4vfGWQzOJ7fEkr3hTVs7KMsGhb8YyJg4R4JZbSLNh9rLlIxj1VVMyvbsvMVvwKW5qNfhL6IyrCPVGnk/sgG6Lu8sUf6W+dDCAyBZfPEKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:24:44 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 10:24:44 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH v3 3/5] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
Date: Thu, 19 Dec 2024 12:24:12 +0200
Message-ID: <20241219102415.1208328-4-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
References: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0137.eurprd04.prod.outlook.com
 (2603:10a6:208:55::42) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7152e2-496b-4697-b841-08dd20175b00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE9SWkV5TktvS2ptTitzMTBYLzZFdnl5WXZFNDNqbGlLcUZLL2pIM0tCdXlE?=
 =?utf-8?B?ZEs1TzJia1EvRlp0VmZXUWRhOGh6ODhMNHpjQXp2UVN5L0xid0JlZmh2c2kz?=
 =?utf-8?B?MElrN2xTa2NFZ1FMVDdXb0hSaWhmN2xvLy8wM3VZVjExd1NHMnFNcWRjcVdB?=
 =?utf-8?B?anRPS0FDQVdtWVNRN3pZdUhxYStVcUZCbXcxS2RnVXd2cGUyTVpTcGVyWnBs?=
 =?utf-8?B?U1dBa2E2QXZvUm9VR3lQSUtDTnE3RGE0WlNqbzB0UGVrN2NRdWdET2NuN1k3?=
 =?utf-8?B?WW55NkloUGJMb08yOHd1ak1wcmxWZGx0UThFYWQ0MUxueVVQOWEvbDV4Yndv?=
 =?utf-8?B?NENXdFhBVkVJSVdBYklPckVONjRMTHBWdm9RbSs2bHVtL0xQUmdBTHo2STJa?=
 =?utf-8?B?L0tPVzc1R1pjcTNBN1IzKzdnZUpseisvUFNycjl5bHovT2VJZHp5TXJRL1JI?=
 =?utf-8?B?OUVZNWFodk4rKy9ycHBtQklUVlRtejE5ZXp6Z21YSklabTljQVdMZ0g2NWE0?=
 =?utf-8?B?TnNqZ3RwTXZ1UkIrYWRkdlhWeUd4ZnZFN0FRYzk3RjFTU2ZCSDBNUXhreWFj?=
 =?utf-8?B?aXNQVVdVRWxmNkNIQU5oR0hhYjhrZlA4M2o3NHhmRndOQzIwTlVubDZiWWpO?=
 =?utf-8?B?bWF2SmhaUTh3S2dRSy92V0NtemlZLzZ0akE2UjJ4RWlSdnFmeTdJM0NrRUV5?=
 =?utf-8?B?UDFtMzYvekljck9Gb0lHMkdwT1NuLy9YYy9ZSlZldnRSZW1vSThuVTdJVG9K?=
 =?utf-8?B?L1NSb3lDN1hNaHNld2wxdWgza01MV0sxZmZ0cGh2eWhlTkphZitpMm5iUDZI?=
 =?utf-8?B?Mm5jMDNMT0FMRTRMSUI2YlZXQno0ZHJGT29XSlZJcEl6eVVPWWVSb3FaMTFU?=
 =?utf-8?B?YWxQZzY4Q2orcjU1RDJyVkZMSFdWN3doVXhlWHB3dlZacUd3enhkWFBHSzNp?=
 =?utf-8?B?aUM4dG51U1E2WXlRU0d4Q3hILzE4OWFXNnQ0b3BVWDZTMU1yejJDL0RLRnRM?=
 =?utf-8?B?TU4zNThRTXZEMGxGS3NySVgzbWYzNE9WRzJNOVBvRC84eEtiWi8zVmdEMWRR?=
 =?utf-8?B?R1JNZU9FL0I5b0xaUGw1ZE1rakdxUDE4Q3pRV3dEcklCMGJVUzYzY3l1Vy82?=
 =?utf-8?B?T0VNcHF0Skd6dEJyaWdiRmxGYVB0RzlYVXdNTUVBS3ZCQmdGRDdVUjF4M2dC?=
 =?utf-8?B?SlE2dkl3OGNoRjBrTmk4Q1d4ZXdPVFNGVG9yTlliU0VuM3pCTW84bWxxT2s0?=
 =?utf-8?B?TVoxd1Q5RFpTZ2I0ak95SnMvV21QNDNqMVlsM0xnT1F4bnZKcnFIc1lpZ3Fa?=
 =?utf-8?B?Z3VkRWxSRWQ1WFNQTklkVnNZbnVZVE8vUlFtZzdGT0tMdUdORnNuc09MY2ND?=
 =?utf-8?B?bERYaTQyQ0kyOHJZVXZUSEhmUmpSOE1KdTFsa1k2R0dqLy94Ni9jbUY4WEJ0?=
 =?utf-8?B?YVM3YTlzc0tBUFpKakdaY1dPNTlaejRMVklVNE44OHJ3ZktpNThvc3BMaW51?=
 =?utf-8?B?VCtPUXk2UDVHT1k5dFBLdk9TSmJjL2xUZFdIY29EVmY2RlpTbU1MVk5McHdn?=
 =?utf-8?B?bmhnN1cvVEMyY3Y5T2x1K0Z4YlcyaWFKcmhsTUJLVXY1QUNKeHg5djhtMWVt?=
 =?utf-8?B?OFlwM3R0dnVaUXhkL3FhdVdBNi9ha3RQakh4ZHdiNHM2blg4RURVb2JRWDRy?=
 =?utf-8?B?bzNjbDZodEE4M0NET0tNeGlTc0c5TlMyczVFTkRlQnNjR2V1em5CN25hbkJl?=
 =?utf-8?B?VGJhYVc1QVpGQzZ5bnh2U3gzNHJJSEdNWmRScnlrdkhMNVRWK2htcEp1cWZM?=
 =?utf-8?B?bGVCbzNKWXpqNXh5YWlTVUN5ZVdadEF1RXlYWTRTeHlySXBacnNBd0UxMU05?=
 =?utf-8?Q?HYhPXWwJAKEiX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDNwbTMrQ2FrZitWR1VMZm9lRjFvdlVMSUQyeTMveXh5QnU3WXZreXo2cDNO?=
 =?utf-8?B?RUt5a2MzczE3M2lFd01IbTQ0d2lzdnE0MW95LytYL1pEZkVqTG1oMTR2aEhl?=
 =?utf-8?B?amwwUVdwWWhmTmV6ajJHZ2tHYnlHbU5JRGlSekR6aE4zdlpHNm1FbnM5aWZx?=
 =?utf-8?B?QjQ1cFBoSHVrbmZKSkRNbGcybXU3VkNiaVJuM3hKVjRZWFNyaDhCTGZrUEF4?=
 =?utf-8?B?VHRZWlc2OVVydmkzRXNJN2xMWUVmZ1prTDR2ZG5vY2VvSEVFbFVzaUFrczhU?=
 =?utf-8?B?NzgvTm5RdVRmQjd6RHBIbGhTNmEzM1Bkc0ZQcmZqVHp3WjJXT01VR1dTSGVP?=
 =?utf-8?B?YzRqbUlRQjVvZzVQcUpzNXF5dkYvSGNoOXpzN1IyVnBhNEdVaCt0cXF5eWYy?=
 =?utf-8?B?TVBsR1dxY3BsczllY281SnlCQml1eDlFdXhZLzRNYnRsUXZGRkdYVVV4RTUy?=
 =?utf-8?B?eFIvYmdmV2tBVWVqMTdMMzFQMWUwUnJoZmRQM1hOWmdHd1YzS0VRTG9MdTJT?=
 =?utf-8?B?SGJ4Sjd6QkZZeDI1WDJRbm93UEpJSGd0bkhQU2NxaE0zMklmTWZNdkMzUlNK?=
 =?utf-8?B?U0ZBSTE4YlFwZU5aNTg3NlkyWTBWSTMxMjlGdW9USm1ZSGRYZ0pXVWZBWVJY?=
 =?utf-8?B?bTIvdHRkM3EwRFZuRkhkbUt4bzZNaVVXR1YwRUdoTFhJOXoxcFQ4ME8vZUxm?=
 =?utf-8?B?Nk5DdGd1NDBiOHBIbW12OHQ1Zkl1Qlp2SnpCVS9mSDdjMVhCREVGNGpSTkRO?=
 =?utf-8?B?dFpjSitPYjNzME5tSmtNazVlTE1TMzBvbnR4OGdTTmREdGF1NXY0cXU1SzVp?=
 =?utf-8?B?cklaUUJTUGxMYk93VWVlNHd6UjZsNG0wR3pid3VXZTkyZ2NxajR3ZWVReHIr?=
 =?utf-8?B?TUQrQUt2MFR4aEY3N3RoYjUzVXc0NEdwMVBsV2pQdjg5VWxvTXEyYlJVRzV2?=
 =?utf-8?B?enVVdFpGRnpzeDJYUUQybkpsT24vcFdDTkR3YWgzbDdXZVZnTVNwbmVuZ1dI?=
 =?utf-8?B?Wm84Z1FTQlJiUENjSTNMNWR4alo4aHJrdnFjMWY3SlVRekVwT2RYNzZNbWJN?=
 =?utf-8?B?amUvcllTODE5MU83Y1h0dmltV2RZWUwrNW5WMldaSXl0UTBxYm14RlJ0M1gx?=
 =?utf-8?B?dDFwNVJXTjlZL0lXVnVPUEczU01ESFZrN296OHVBdUNXQzNqOXMwY0Q5VlZD?=
 =?utf-8?B?bXBaUUVISjVzQVhSc1pISXVoR1ByYVovZ3p4bklFbUZKQ1NzOWtMVkpzL0NQ?=
 =?utf-8?B?YytZL3I5WHp4WDN3TU55VGxjTE9LeG1iN2NyR2VYSEFZSW5UMGNuOE0yVVlM?=
 =?utf-8?B?ekcwY05veFdINjNuY2Y2bjlEWU0zcXA5Q3ZXL1JLTjRwUk1yMFUySm5FQUlL?=
 =?utf-8?B?TjNsMThSSkt2UFJHRTZQR01oOWZUdlB3S2lPYnM0dTIzOGtaYzJNWXRVUFNr?=
 =?utf-8?B?TmRhSEpKOUs3ZzBZVEZGZ0VzaGNhWjQ1Y0d5c3pGbFVQZGNvVmhhbXFoNE84?=
 =?utf-8?B?bS9QU2lDQmFhZUxEM01yc3ZyanZqMjZBQTlHak43cW9PWDNKTlhtNnovOE5z?=
 =?utf-8?B?U3B1cy9yWXI3WktTcjhkVW1oaGtGWVJZdHBwMW5FYVdrRnErTm9TbWM4WGtu?=
 =?utf-8?B?WUk2SEcySUg1aU9LMVhMQk5ab3hkbHNNUUhaV1ZXU2Vka0I5RHNScS9BMVBG?=
 =?utf-8?B?c29CZ0JjSnllVDdoSG5lMHovYnExNFBWNHZpeXZ2SmFDd3ZwUHBPN2dLUG5a?=
 =?utf-8?B?Y2JmSk9McWtjcFgveE5RUngwZStvcE85clE5N0JPWGFUUk0rbitIWlJ5U3FZ?=
 =?utf-8?B?QUdFWHBHU2V6eGJ4UVhMVWFCbzFWWFAzV2doQ21ST2kzS2krK2dLVEFUMHQ0?=
 =?utf-8?B?WldrQ3RkRVpDZmN4U0xiVXRvNmN2bFJsRWlpQnJURUxjT1ZqSmx3cUx1MWZs?=
 =?utf-8?B?aGM3Z2dpM09EL0xvaHNXNjZEcHhDSm9CelUvR1BGODR3dHpaclZ0N0hrYitX?=
 =?utf-8?B?NERUbWMxbXY2M3J6QlZYaldsRXpUN3VEZHBETlFKT3lRaytCSXRKcEZmTGR3?=
 =?utf-8?B?OGtqUGVYemVYQlFxeG9HdFdjZkhoV0NOSEtrU2tLVzJkYzhqbVljWEdFcVB0?=
 =?utf-8?Q?gb3GapWtN9sR9JIamKGjiK3xi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7152e2-496b-4697-b841-08dd20175b00
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:24:44.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzMoRBDpmyHxPPmySjm0PvEzXDY2ZNK0zfkhfY7N4ljuH3SaKC+l6xXMwkUX8sorq+dtaX9kaoYmmru+ZbOm4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

Introduce the compatible strings 'nxp,s32g2-edma' and 'nxp,s32g3-edma' to
enable the support for the eDMAv3 present on S32G2/S32G3 platforms.

The S32G2/S32G3 eDMA architecture features 32 DMA channels. Each of the
two eDMA instances is integrated with two DMAMUX blocks.

Another particularity of these SoCs is that the interrupts are shared
between channels in the following way:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index d54140f18d34..4f925469533e 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -26,9 +26,13 @@ properties:
           - fsl,imx93-edma3
           - fsl,imx93-edma4
           - fsl,imx95-edma5
+          - nxp,s32g2-edma
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
+      - items:
+          - const: nxp,s32g3-edma
+          - const: nxp,s32g2-edma
 
   reg:
     minItems: 1
@@ -221,6 +225,36 @@ allOf:
       properties:
         power-domains: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-edma
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: dmamux0
+            - const: dmamux1
+        interrupts:
+          minItems: 3
+          maxItems: 3
+        interrupt-names:
+          items:
+            - const: tx-0-15
+            - const: tx-16-31
+            - const: err
+        reg:
+          minItems: 3
+          maxItems: 3
+        "#dma-cells":
+          const: 2
+        dma-channels:
+          const: 32
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.0


