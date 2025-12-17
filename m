Return-Path: <dmaengine+bounces-7786-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6244CC8D95
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECABE300F645
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAE29BDBF;
	Wed, 17 Dec 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EY5V79pD"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D9249EB;
	Wed, 17 Dec 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989450; cv=fail; b=uu9tRzNKkmFYSmgAbOUAKnSkP/LjiVfYU4pNAVzIURC1IAfZ0UYdfKyTI23HJJiYaoQgUNavgWmUseBihadAPw6BWKGVsb71DPg0Mf9m9ILgy3PWzxuV1rYiKDccQXzp8sKfdfrc5sS0T9jl3aldyJc8sQFSpkutX5Zx+vTdjbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989450; c=relaxed/simple;
	bh=JSYfXInM6DEBxeN6f4CyBRjC7MqWPVwAFwdMzn2SvS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tObfUjWjFU1k9lFhWgVfy1oyWX2iulYAN6NI7Zgjf6w9buYtyS8jVeNROngx0Tl7s3HoMJHNmcAdmieSKqkVo3rcYWYZTuSh4zX9wJwE81Wkpp19QgGHkUsfnoMn1F2GtMMk6orTpMseW1kh5OsmYMg+DsobP4XvlZTCrHbGWL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EY5V79pD; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZuH8JmRGVwPeGSVNb2ri8X9WYXOi2o/t8K6qZpV/U11xTouWxurvQIfEZ7wUOLoy+W8PJLPOORHOPvnMh19tqlC9CDI22uB9FmpM8MwT6Ch9VqVHNKVuSN9rHVBu7SY6rMvqINm675ra4yTbSR7KE45g8l5VVQJhnUQCIMrTM1AQa2IsaAi/uxEmtCSN6VxeHHivAdSW3nYaRD2TIM+ywjummUdS81AhMy2mtdM0XEQ1Ii9Z7uttUQMpHuU+ljpllAlp3pEIrwT/N01Bqwi8hSZWtyCv8yBDYV2EpupdlHKHmdi7Umm0y8lY+MKENkbQ8fJK9VhOBUrD1fuOOajTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cghfd0wvu/UbbnGxScD5EAKm1YGIlF1XJ+2K8YHl564=;
 b=zIOUmVeK1YbyCWvvoTfDh7oxvnirlG4NbyPfIgHv2FIEZGv8sNWusypPCDD1Z6OzQGzH+GM81q9WZ/82T2scC8vsCO0KOhPCLceXMNsCmdnn7DC0aDbplGi8KfZc3Qm0lKh82J3EHhr5VAZ76qXx8E9Uhg66Wu8GXGRoVjbfQKlu1nQqe/C96bgwrmKcek4zz91rxj9zZl2hCwHT0yQFmFQVbgxgMkim7HL36s60nUyHDl6ajLFokNrYPiBNwm5+LaaCAkysYU+7Kf5if/pNS9f9W4VtwkSpJ91MStXlwJJfzgsdDy9GyiknGwYol/ynba4/n3NpudDtoqOwbr757Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cghfd0wvu/UbbnGxScD5EAKm1YGIlF1XJ+2K8YHl564=;
 b=EY5V79pDtpPe2b4mV6PU0sZqBR1bujv6iy291IyTb/XSNw0Xey2O1lJ4lcmAq5+Zl01qLjE5U36GDfOnx+r8l05XnUq2j7ClGy1ATHjjUFhN1SVymmD8SttcX+mb6cFleXOXYGizTAolWONOAysM6udDc0J9kP3QZV+rVHEDjnVMJ27be/QzP4WtHmku1cNfB9/3Gvvb8y8OzFFWiVPdkUemk0hNoV9OQMEZrLPz+1ryZRuTdScmiIZ59pn5K4lloXfJah8fxfDHYImN8J9ETK10C+Iemy4uDwt7G6w9XykkeumNQo3TFctSaRalS1fgGOrTQ1Z/XB7+r9Y5BevpLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB10475.eurprd04.prod.outlook.com (2603:10a6:150:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:21:22 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:21:22 +0000
Date: Wed, 17 Dec 2025 11:21:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dma: mcf-edma: Add per-channel IRQ naming for
 debugging
Message-ID: <aULYecvJAFrMX77e@lizhi-Precision-Tower-5810>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
 <aUF6CdS6WVZuEP24@vaman>
 <aUF8/r6FZcPraINk@lizhi-Precision-Tower-5810>
 <5064909.31r3eYUQgx@jeanmichel-ms7b89>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5064909.31r3eYUQgx@jeanmichel-ms7b89>
X-ClientProxiedBy: PH8P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::32) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB10475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7057b459-1889-4cbf-d8df-08de3d88516a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjJGbzdnYlRiUm9YQmRUWkQ5VWFLYmxXbjh5eEpOQWU1Q2RhTWNpNSticXBK?=
 =?utf-8?B?ZCtYRWxCS3hZTXFJTHJrSHVMVWtMTFVXdElEeVExWExmRi93R0V4cUdzcEhY?=
 =?utf-8?B?QzFCenB4aEZoY3NIUTUvSFdLVnU5ZnY2cHROeFMxdThaUENaZXVlMS9ZUXZZ?=
 =?utf-8?B?TEVJRXRLSjhuK1lCdHB2clhTVGFBMGt0dCtRbHVDVEM1Z21PRjk3M1JLamlu?=
 =?utf-8?B?b2N6aXkzSHVnSjVSS0dTZHdxZ0ZOcVhYQUd4VUZjTnk3MFpsZ244ZzQ5d2pj?=
 =?utf-8?B?U3BWYjZ1N0RtemR4eWhqV085RXF2cEVTNGd5SFFZaVVNT3BlSVRkT09LajRh?=
 =?utf-8?B?VWZMaVdYOWpFdnB6UnIwcTJzeFhrQjVHNWlMOXQ2YnVrQUJnMmY0dnp4YzlG?=
 =?utf-8?B?eGllS2Z1YUR5UmhWa0lpWTFTN0ZBV3JnVWdOdDlvNU43dFBZazUxNHA1bUtV?=
 =?utf-8?B?d0plbFptN0NjZnJuQUlJVEhHYkoxUW1McnJSTElrUHRCbExReitHUkZ2RS9n?=
 =?utf-8?B?bEFVeDlYclE3TzhTVkFKbjhyV1lZM0lsckNxNE9Nckx2U1FmVXp5ckVnT1RQ?=
 =?utf-8?B?OTdWSzBRb0xrNWJ1dGJRaURaZUVXbnBEanZ3WkdYRzMvR2JmdExRR2FSd3Ro?=
 =?utf-8?B?dHQ1QlFINDVoQmxMNTNVdkxEUHJMWGNMZ0hJV3AvUWZyalZlZlp4ZjN5ZDIz?=
 =?utf-8?B?by81STR2bzBqMnhTN3lReU50NGpuMnlVZ1NQWm41ZGtTK2pWRldFa3Zxalk4?=
 =?utf-8?B?WFY3dTAxdm1peDd6b0dxWHBZS0RCaDV4MVhHQkNteWgwbkZFYURQWGRQOFMy?=
 =?utf-8?B?WjY5TGFobWY1akd2aEJ0dkRXT1NyckhSY2dRbVd3T2c0M3M1S05rV0dHOWt4?=
 =?utf-8?B?bkVNaGE3VkhjcnlSdGtjNFpFbklvZ3RvcmpXOTVSQTRYNjNnS2VOdDJ3NVVa?=
 =?utf-8?B?Q2lrRTIyWEdhYjNzMnhzVUxadFVNNG9CQTBmZWJuUFBhTnhMSFhZNml6OUt4?=
 =?utf-8?B?ZmIzdGJGMFc5dmR3N01vNmsxQ3p4WGlLSXZFYXovb2RHdmdKT0tZVmx0RnpF?=
 =?utf-8?B?dEtuM3BKeGtJc0tqKzJzRmI5Q1Z2UWJ4K1NCeEN6SVZGcDJRSEZ1MzRDSFFG?=
 =?utf-8?B?RHpTYm1zUnJnMHhQNHI1TTdORVY5bVg0UUQwR3Y2dGZHTTNDTStrcDNJSDQ1?=
 =?utf-8?B?RjdMcHZWb0Rob2xiWUsrWkFpcTJUQUpLbk5iRkFxbktYWmdnRktLNlpyMlU2?=
 =?utf-8?B?NlBQZWVBVGRqSkViYXFEbFJ2bXhmMXRQQVVocFBSNk9RTkpLM3NpbkVVNHhX?=
 =?utf-8?B?aGUrZkM1Q29ZVlQ5NWNMdi84ZStPeHJMMk5ZMGZsaTVmMWhwN3IySXFvaE9C?=
 =?utf-8?B?eWk4bTRxd1RvUlh6bytWUitkN2VvaTcyUVZYUWJ2UUhIb3llNUV5a20rbTdU?=
 =?utf-8?B?d0ZsQVlHdnIzaUFpK3dBQzR0cldQcEx6cXM3OEVoN1doK29GMVJZRWRqNVhu?=
 =?utf-8?B?VUtuWU9MK1grUnBrMmFJYUVDSHhNSkVHYXVsaHhGUElnMTdua25VQXNadXNC?=
 =?utf-8?B?NzNxZnJ1OVVrNGZXYW9pdHRqdnQrekthK1AwemZpUXg2a2dDaC9UQWQ0OVc3?=
 =?utf-8?B?RFNjcTlMOUN1K0JFVGgwZE1vZEI2S212aVViTkE0K3FUT2twOXNuRlBBc2NL?=
 =?utf-8?B?ZitRY3ZQeWJ4VnhMN09qb0NCNVRza2w1NUpQMTBtZTJTVEJaSTM2ZzZMcldR?=
 =?utf-8?B?cTBtc1ZxRkZaWldaNTFJa3NIMHBSZnpRZEFvOHRmN0Z5ZVRSSVNMYk5vU2FS?=
 =?utf-8?B?NEVwU0l6QUlzQ2JMN3ErT20rK3lWbEQyakRnMW9ncE5BSVM2cTljOWlmYnVW?=
 =?utf-8?B?eHp3Rzg3aEUyMllNdndUVmUzYUFXaWxxRmJPbzYxbzJ0YkN2QXBtQkRwYWRK?=
 =?utf-8?B?bHJsYVNTTUp4RmNVVmJhU01PU3JCT3VyZW8yTm1MRVVyaTVUWjBhTnRHT1RT?=
 =?utf-8?B?WGNLRGFITFpMUVNCMXY1U05IS3RxSmJNTU4zc2RibVlxcmNzb0VIQ2VRQnpF?=
 =?utf-8?Q?sUxSGl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRBR3ludDVEWExoblJKVC9icFNvL2ZJQ1JnaWx0SUg5aUtBSThiTVc5ZXhj?=
 =?utf-8?B?eFl2ejVGMUFxb2N4d0FWN3dQRTNsN3RVVkpRYW1McVJ5T2p6ZWZoMVZTOEl2?=
 =?utf-8?B?TjZhcDlHdW5xS011VzI1dUU4VDEyNXVNZ000N3lNaUpDMFV5dG16cW9mUEFS?=
 =?utf-8?B?QWtMQ29WSU1Mcjk3UXNmMjNsZlM3ZEhuR2RtZUpWSmZ0OVBRcUFWL2VCYjJU?=
 =?utf-8?B?TmdWelVqK3VDSndsbk15NTNIM1JjMDIrOFNaNCtmeHkrN1RhelNHaEdXK1dz?=
 =?utf-8?B?b1h6QjJCTHp4ZG9GQkdBeWQrQ3piRzBYdFA3cmU0WGticE1CTmxkR2V2R25r?=
 =?utf-8?B?akI3aDFQNm5CT1hXdDdIZXhJSXdSK1hkWW8wcTk5L3FqZ1VrRHhLUXdpdktl?=
 =?utf-8?B?dzJCczUzVHlmM2R4aTFpQUdyVVA2ZkNKeDZkVHk1N3liMGhhRmFib25UbzZE?=
 =?utf-8?B?a1Y3U2Nla3E4NDBnZnRNYmFBYjg5VytKLzVRYzhUWHhoaTdzdTM1ZVZGUUt6?=
 =?utf-8?B?VmRTNVZtcDF1c2VqaG5nak5nei9CcnYvSEVONFg0emU3Y3ZXcXlIc2JrZVpI?=
 =?utf-8?B?ZW9FVTJxSnlhSld1eHREOFRlUER4MW5Yc2pUblpkT09DTy9CTENyNjVLUUVJ?=
 =?utf-8?B?ajlhNmI5M2NaL3U2MHJDT3FMRFRIOVY5ZGhwNmtiTlZhd2RQNk1XODFncnlP?=
 =?utf-8?B?clNyK3BLWDVsM3VBU3g4QlhDYmppSWY0VFgyQWpvUHVFNEwxb01KeDFpQVRU?=
 =?utf-8?B?NUo4M2dSTXFuR2FEZXlLU1laei9QT1d6cHVhaFRlZmMydXI1V0FxdTJGUnJO?=
 =?utf-8?B?eVd4Vko2czdlMWg3d3A2cXY3KzZQK3ZFRVh5VGp3L1owK3Ewa1FUWkhaV2xP?=
 =?utf-8?B?dllBRStFZU1RMC9mTmZGQzJWaWFKc05Gd0F5b1VYZkdoNjhITEc2WkhKR1Vn?=
 =?utf-8?B?eGg3cjJzblFlcy9EaERYQjR3eS83ZmJHZzJteGN0Zk5xT0lKbXlvUUlNdlRM?=
 =?utf-8?B?anhKVnNsNHR6R252UkpiVEp1a0kwOFNqU29OU1EwQTM4UXZ2OTRISzZwVmhi?=
 =?utf-8?B?dFFQUlZUQVZuaitoSXV6d3hIZkpWNFlkVXBHcTN4M0kxbEcvN3FQcEVvYlZ4?=
 =?utf-8?B?WnlNNUVRcGc1dDQvb3h4TnExcXZCL3FVMG54ZmdXbzlLb2FLNDV3TlBUbDJ4?=
 =?utf-8?B?anBPMzRyQlpndFdxVnMwSmZXUWNMVWxnWExyUlNjbzhCdEFpaDdUdnVMZVFS?=
 =?utf-8?B?SGhGRUw4U1ZGREI0M0Ewc2tlcytaK0FhTXBMOG1QSUk0RHlCZzFnYXlsRStZ?=
 =?utf-8?B?ZkZQWHVuWEQxR2E5dTNZM3NzYllTeXA1YWdTeUdHdkdmdXNJY1YxREJ5YlFk?=
 =?utf-8?B?TUJjckZ6YXVrT0hEV0p6ZThHZTNtUGMvdTRCQy9wK29WNE1YMmNqS2l5eVFX?=
 =?utf-8?B?RXBIUmxaZ0thS0dsVXNnMU5aSVVzNkgvWE9uQmRyR0hNUVpDNFdBU2hmdWM2?=
 =?utf-8?B?SU9ib0ZxWGxYMlU5Nk5TOTV6N3hhUkk1WHV6ZkVNTStqRmp2WWFYRjBKcTQ0?=
 =?utf-8?B?dlMrZXpneUQyc2J0UTR3enNFaUtzUW1RREZWTUYxclhGRXFVeGdpRVNQQ1dk?=
 =?utf-8?B?QjFTZ0pyRmJ5RWd0SnhhZkNya3lCNlh5OGF5b0RHR2h0QnoyaG1mUG5qSW5E?=
 =?utf-8?B?V1U3VUVFWUxrTGZUMFpSbFB6Nk1sZUtudVFtcElDejNIZlM2NlBTMXJxQkda?=
 =?utf-8?B?YS9FV0dMbW5WcmxydVc3UEdzaGFLZnpWMWZ3aDc4YklQZnlFaE5JRlBWSkE1?=
 =?utf-8?B?TUNvMVBPMk1DdjkwaGhsZ2ZiNlR0bUt6L0puZzVrUUtVZEpzYzhjMm9MY2xC?=
 =?utf-8?B?THZYQnlIMU1JMlBvNldsbE9NdTBHYXdpejd1UktqVHpGRW9WRkszbzJMa2oy?=
 =?utf-8?B?aWZHUjd1ZWw5NmFrSnhhdnJqK1lBVmt0UDBQbGdmOHhlQkFMVzdldUJyUEZx?=
 =?utf-8?B?d2lJSnZXZmx3N3ROT3V4ejlTUldvTytobGVFTzZKVmMzaW9UMnRqeUE1S3Jv?=
 =?utf-8?B?TVY4djkzK2Q2TGVid0U3d0JodDZzWUdwRDNRL202VmZFcTFQdzViMU1BRWN2?=
 =?utf-8?Q?lgbL/3t31KS5JDRhlrvEK9NH7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7057b459-1889-4cbf-d8df-08de3d88516a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:21:22.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfSZzvrsyRLwY4ukL9dmXPKK+UmrxXJkRBVe6V5srOmSSB5dj/VJhHnQWzyoAaMhoQLwpDNgv2xIZ3TgCvAIYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10475

On Wed, Dec 17, 2025 at 07:34:07AM +0100, Jean-Michel Hautbois wrote:
> Hi Frank,
>
> Le mardi 16 décembre 2025, 16:38:38 heure normale d’Europe centrale Frank Li a
> écrit :
> > On Tue, Dec 16, 2025 at 08:56:01PM +0530, Vinod Koul wrote:
> > > On 26-11-25, 11:12, Frank Li wrote:
> > > > On Wed, Nov 26, 2025 at 09:36:03AM +0100, Jean-Michel Hautbois via B4
> Relay wrote:
> > > > > From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > > > >
> > > > > Add dynamic per-channel IRQ naming to make DMA interrupt
> > > > > identification
> > > > > easier in /proc/interrupts and debugging tools.
> > > > >
> > > > > Instead of all channels showing "eDMA", they now show:
> > > > > - "eDMA-0" through "eDMA-15" for channels 0-15
> > > > > - "eDMA-16" through "eDMA-55" for channels 16-55
> > > > > - "eDMA-tx-56" for the shared channel 56-63 interrupt
> > > > > - "eDMA-err" for the error interrupt
> > > > >
> > > > > This aids debugging DMA issues by making it clear which channel's
> > > > > interrupt is being serviced.
> > > > >
> > > > > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > > > > ---
> > > > >
> > > > >  drivers/dma/mcf-edma-main.c | 26 ++++++++++++++++++--------
> > > > >  1 file changed, 18 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> > > > > index f95114829d80..6a7d88895501 100644
> > > > > --- a/drivers/dma/mcf-edma-main.c
> > > > > +++ b/drivers/dma/mcf-edma-main.c
> > > > > @@ -81,8 +81,14 @@ static int mcf_edma_irq_init(struct platform_device
> > > > > *pdev,> > >
> > > > >  	if (!res)
> > > > >
> > > > >  		return -1;
> > > > >
> > > > > -	for (ret = 0, i = res->start; i <= res->end; ++i)
> > > > > -		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA",
> mcf_edma);
> > > > > +	for (ret = 0, i = res->start; i <= res->end; ++i) {
> > > > > +		char *irq_name = devm_kasprintf(&pdev->dev,
> GFP_KERNEL,
> > > > > +						"eDMA-%d",
> (int)(i - res->start));
> > > > > +		if (!irq_name)
> > > > > +			return -ENOMEM;
> > > > > +
> > > > > +		ret |= request_irq(i, mcf_edma_tx_handler, 0,
> irq_name, mcf_edma);
> > > > > +	}
> > > > >
> > > > >  	if (ret)
> > > > >
> > > > >  		return ret;
> > > >
> > > > The existing code have problem, it should use devm_request_irq(). if one
> > > > irq request failure, return here,  requested irq will not free.
> > >
> > > Why is that an error!
> >
> >         ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
> >         if (ret)
> >                 return ret;
> >
> > if last one of request_irq() failure, mcf_edma_irq_init() return failure.
> > probe will return failure also without free irq.
> >
> > So previous irq by request_irq() is never free at this case.
>
> From kernel/irq/manage.c I see in a nutshell:
> 	request_threaded_irq() {
> 		action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> 		retval = __setup_irq(irq, desc, action);
> 		if (retval) {
> 			kfree(action->secondary);
> 			kfree(action);
> 		}
> 	}

This should only free current failure irq.

ret |= request_irq(0, ..) success
ret |= request_irq(1, ..) fail

so return ret (failure).

irq1's resource free.

How about irq0's resource?

Frank

>
> I don't see an issue with the existing code then ?
> Am I wrong ?
>
> Thanks,
> JM
>
> >
> > Frank
> >
> > > > You'd better add patch before this one to change to use
> > > > devm_request_irq()
> > >
> > > Not really, devm_ is a not always good option.
> > >
> > > --
> > > ~Vinod
>
>
>
>

