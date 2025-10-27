Return-Path: <dmaengine+bounces-6997-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B3C0BD29
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 06:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA114E4B7F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127C2D46B3;
	Mon, 27 Oct 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="o1CpXFGt"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E192C08DA;
	Mon, 27 Oct 2025 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542978; cv=fail; b=sPG2yvzZ8oQRbjgs51ErbtCLc1Uo+QWYloyiBSP2BhdecycXn0z7ul8kSPrVUbTZQqXoesur09SfGuhh3ldOTa065Tas2gCwo/yBf7hn3XslPG2cTTMqsZ6cGLsgIY63HDvxg5Od6hqdIkn9Fwi8VntY7ZPXVis/JG6yEDpScDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542978; c=relaxed/simple;
	bh=AgxdQ/Z3u13cCYwoI/l8opwTeYKlXvcAdrLOnP5/EwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r6mYuJM0TnRCDgPmtZI7oulDfWPVC67H7khlQrK2oZFQR22imNy6u4MWRa/bIWMHLOMdp6BtK1FrwO7HX4qOoD4QqlZ3M/tOLaDlUMINddLrhzOAn+Kn7s6NE2FRuWdovxK/uHkIYLwsqSFK/9qiRcps7siuqhR6GwtbuVb/vzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=o1CpXFGt; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+4feyXOFH+CyWnbqwrB/dZxdpQSbETWRTblE6wDgW29bwHpDaxtMLZ0NWRqqlFuq1cbtTrlU5+Zj7QRUEBw+ejHzglB2jVMdK8JBCD0j3WTb8jPNdOIVyEqM74aG0yIK71XQlzXrJCuSYmRn5juq4Kll4HrewxU8xKFfbxgATcEJB1p1MWMKSTYJocOL16Z3NDj6P601ey1Gej/7inHwmBOwgVuKlNAAzUqZW0zij5KjKINUmoS1kJMcD9OCDPhrB30M+qD2HJTwZeoKv9iET9F23vJUo4c8iL5AaWnGs+fd7xW+viWe55NSB2SoqsqdnuIVgl/1go8yRPBOP5Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKAD2n8uzoSkyiw+51etpyrvKbGtb/y1Kq8Y78fckzo=;
 b=E1Ombjyin6rYJ/K7PqKUP8sadniw9mhiYpj+O2En3U6pfIeYxt6ebg4PrVu51s3/cilGcEueO48omcMC8jz3hoUbGCcub8o+7/9uug9KS7R5KQzDnKTBvMs9onIEIv9HqwoLoljnd5qgTkTJ4LH7wAm4knXqgm7mxKhnHuHWGKJjjB0i7HBu5q1+w4zzUgMX0IzkJXCadi4LF6TIhXb9aIrg2ISslbW7kdpov1P6VOz0PkLjzVZtZ01Glz4SZ0sX6+1do2h6qlK6z5KxIB3BJdN8Opk/KQNQ2VQSI1Ku6eLTlxprcuOFWafg0Dm5aVUHshNjifEm3a+ep5qrWUtZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKAD2n8uzoSkyiw+51etpyrvKbGtb/y1Kq8Y78fckzo=;
 b=o1CpXFGtMBXJ3hWhD3t4ab9vvoRwFvaWjjaOcQIGxo+KD1Dn3QPJp2xgOmcV+cPZSYjT40fRHMQNX7dtPQ/JxQTLJaw5juWNThVKgCP9EW/SiOrYbGQ5rtK4jNuKxwUMlhQg2ee8WCb5ehyabrLAY3a8Tgs1rLCQ4hwecmd+skg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYWP286MB3383.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 05:29:33 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 05:29:32 +0000
Date: Mon, 27 Oct 2025 14:29:30 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW
 offsets
Message-ID: <igcadmsutjrert76iwfjhn7hg5j23z5blccxltwyuotbeislz4@3ze2av7sa32b>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <aPryDenvU7VTYpBp@lizhi-Precision-Tower-5810>
 <p6a5rfawgs3vcycm6ku23jpx4nhtmbuououfyfsypqli5t6zin@lekmytllocmc>
 <aPusw9M5kRA8G6NC@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPusw9M5kRA8G6NC@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::11) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYWP286MB3383:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ed4f85-43b3-4296-e331-08de1519cea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eksvNzh4bExoOVMwN3lycForeWx4QkZSNWNGMFhVQmtxL0VEV0ZxQWtVV0Rn?=
 =?utf-8?B?ZVdiNEFPQmpHNlF6TTRQRGFlWU9EdmwwVTl2VnpQRGh1WndKV0liTjZyakpK?=
 =?utf-8?B?OG9tZUZNOUROUXY0d2w5R2FzdkoxZTNROVBjL1Z5Uzh5OUdESXJNc3N5NW1K?=
 =?utf-8?B?NllGeEc3bnNUUjY3ZkFDYUpMMDYzZllyM28rMnpnNGx6a1FqTE9pV0s0bEVh?=
 =?utf-8?B?V0JSZ3I4QlNFNm1WU2JhRjAvRFNISmorTTkwL1YzVXM3anFVOU1YMUMzQzA3?=
 =?utf-8?B?QXlWRjllZEFpeFVJZXpvVmhzazBxVWExVDdlaWRaNndJTHlJS2JHU0xYR1hS?=
 =?utf-8?B?anVSc1lvQmN6SlM0NnNCM3JvNlAydTlOd0NHMW5DRHJ6Q3B0MFZiaW1naWtB?=
 =?utf-8?B?M2RjdnQ2TTNRbFI1eXNjR0RCRHNGUUJ3eEpUclpKa0tNSGdnQ25YRjREOFZo?=
 =?utf-8?B?cDhjbExIMi85WUZiTnRMVHlDcms4RUVxYUxyYWtRM2psRHVwZE9mMUpVY3My?=
 =?utf-8?B?NlJ1OEJ1NFBXZ21abnJtWDZMTXVyMXF2WHJQS0E5UHhOZUQzajBpOHNPTldq?=
 =?utf-8?B?eXc3VlJROGVPbkRHQy83M0pHNEtBRFRoV2FpNjQrNUhDdTJIaXdmaE4rY2dM?=
 =?utf-8?B?S2tZa25uZ3hKMittYk8zaXVWcHJIVkp4TVpWOVhVOHE5TFVuUXBMakp6bUhm?=
 =?utf-8?B?NmZ5M0tKWTFhSThYd1NBdldhNktDcjBvbGI1MTNTV08ydjV5cko4MnJFVHpo?=
 =?utf-8?B?MVl2R3ovQVJQb1RXK0tGc1JxMGVQS3pDYmlrR3kxNFMzalFjejgyenlJdE9i?=
 =?utf-8?B?a0xpSkJCVVk3bUlGVUU3cjBlU2MzRW5VdkxXWlZLSmRSeFRtUjh4bDVLSStK?=
 =?utf-8?B?UDBYcFh0ckRuemFCYmxVZGxiYmN2aFE1NFZ5NFF1UnFBT1B4UjYrVW8rUEhQ?=
 =?utf-8?B?L2JSdFBsSmlmckV1YmpqelkyMldHclBpbzJ3SUlIQk9ZVTZRRk9OZmRsSVR6?=
 =?utf-8?B?WlBMbTY5S0NiSzJwWVJ6VXVMNlJVd0tKd25ER01hd3FBay9zcEgwTk9tZjAy?=
 =?utf-8?B?WGc3dy9obUNZUFkyWDBrTHFDb2FOMFJnckovYjJXNytBNXc4SUNLUndnblFr?=
 =?utf-8?B?RGFXNXZxUmJULzR4R25TQU1VYXU3ZHN4WTN6ZkZJVW9WSGFsSVl2bWxHdDU0?=
 =?utf-8?B?d3dPakxia3V6c05CMlVwQ29QVFFXSlE1aFdwdkpWdjBDenRjSzFBWGY0TkdD?=
 =?utf-8?B?V21ISEIxMG5XZmh6d0NCVzE1VTBFekZ0QVQvMlhmMEx1L3VkSVlBdlNNamh0?=
 =?utf-8?B?cDhUeS93dVdiOGFOUWdrN1pkUDJjOEE0TW95bkhzRFVHK012SXNERGQ2ZU1V?=
 =?utf-8?B?MHN1K0QvTVR5YWlNZy8rVmVGRk9WMDl4M005S0xoVjltZ1BLa2RVM3VlZloy?=
 =?utf-8?B?bnlOcm1LZ0o1bURPcFlCckdPaGVFVFJhR0g0ZTNIL1E2ZE8xUEg2c1hwa3pp?=
 =?utf-8?B?b1NaYVpDT1ZNQzVrczUzSmFZbmlsUXd1N1pvb2NaWmhNMnFCNGVVTi9PVkp5?=
 =?utf-8?B?NlBsNElXcS9aTVFVMmZxQ3JSaStXV0JENXFCWEpodlNZa3pJeTlvWE9OK0lP?=
 =?utf-8?B?T2NxMlQ2VWg1TmZpZ0NYVDl2cHVwaDhCR1F2NmtBRzkvK2VDdU1SQXZHazdP?=
 =?utf-8?B?Zll1cnc5SXVRQXY3Y1FJMHc2cEJnVXFWaWk0aGZoY1ZwU0pKZlQ3cTdHUGl5?=
 =?utf-8?B?eHA1VnM1andNdEZxR2hRY29Vd0IvUVhzNHJPQVlMOXorMm1ydnNkS1NHeWIx?=
 =?utf-8?B?eWdiYWFnTGdaVW1FVThMbDR2UWJFYmtUVzY0T2ZsZDk2OUpoM0lYWWhVUXFF?=
 =?utf-8?B?eEZjNHdZRzk3Y08rK200amxwbGFzODIvVHhNeC9DbVBTUVoybEhZV3RlZ1Jq?=
 =?utf-8?Q?kse5V78UlB4159padJddLTvA7f7gtcoT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFpwek9abmJ2ZWtPNnllTHhDOHlScXdlVm1XR0NDckVMTjdmRTVicE13K3dR?=
 =?utf-8?B?eUd3aEtXZkhxb2RibDhETHRxb3JObDNFVGh2ZVMyZ1NLYjEyODZ2SDBoaUVO?=
 =?utf-8?B?SEwrdmMyNzVBM3o1U3pScCtaZ2l5UTcrZXJlUjNXdkI3QXF1MXUra1RFV2RI?=
 =?utf-8?B?UFBsNDRqaUczMU0wbkFwaWE3NDJTbnJPQ2tQZ0lyekJtNExPdldHK1lkbElM?=
 =?utf-8?B?dWc5cGhxaEpQVzBnYzBLeG5MREswSEJHeXhtRVgzZGMwUGR0OVpOUlZybThS?=
 =?utf-8?B?WWtnR053NXc4d2VpOHY2UHo5MStMeFhXNndUMXRhL21pcmQ2c3lqWi8zRkpv?=
 =?utf-8?B?V3JnM1JuR3EzdThPRStpNW1CY2ZjMENsbEltNzlIVHpZNTdrUzV4cVRxbkkx?=
 =?utf-8?B?NlFKcVZ5bUU4WWVrb1hLOGNoZTZKaFlqblo4YnJ5NjlxdzljaTcvZXEwYW9Y?=
 =?utf-8?B?SFZpNFpHcTcwVkRrM1pIUnM2b2wyQ1hvS1VQdWQ2VmE0WTZCWXVtL2YxV09m?=
 =?utf-8?B?K21QNEhTWFFKazVKK29Bd1kxYm9YUDBuRU5uQ0tEcHFwSDg0cnhleU4xUm5l?=
 =?utf-8?B?NDJmT3gzSkJPcVFvTTBEajBhSGlST2h1THE4MWlVUkRTUjk3Ynp3VHlFWnRE?=
 =?utf-8?B?b0xaeDdXWmRHK3F6YitsV2FWSklqdXpVbTVIcnFCaC90MDM4cWhEUHpXU1I0?=
 =?utf-8?B?am9BWU5KMGFXVnNXOVRNd3N4SnZ4eE5qdGRZcWVOYlp6NkI4dHNtSGxEZkQr?=
 =?utf-8?B?eGRFTFk4cWdnY1JvMWNqOHpwOTJ2VWxUR01WQ1NXL1RGUWZ2SUlldmpvSFFF?=
 =?utf-8?B?Ykl0NzBuSmtSRitwakRrRzZTQzVURGVBZWgxblY4dGtIMVB3dXNxSGhaekox?=
 =?utf-8?B?U0QxYmlPUEp3a3RLMkYxQkViSWxpNmdqak1PUkFxdmMrLzZ5VElPRXk3QWpF?=
 =?utf-8?B?ZTJoVE8rd2ZWKzV6RHVjZHBleEdqQmFJVFZMS2NGdWpyVTRnSnRxZ1VvY3F2?=
 =?utf-8?B?QVNjT1pJbGxWczE2SXk5L3hVUEdaMGM5dHJFWjEwOHYrS2ZqcUw0ZXg0c0Yr?=
 =?utf-8?B?MnkyVFhiTWhFMENvRW9kVmRZMi82cHNpb3FhKzhwNFlSWFE1V29XRFFUdy9S?=
 =?utf-8?B?SU1waE5EOHJsOVNRdmozNTZ3dE95dDJwa2wrOWxFckJUM3NxU29BT0NQUkl2?=
 =?utf-8?B?RTRFaXRqbUY0cWtXNFQyUUR4T0QreUhNYlN3TjNtd1dNQ2Z5OS9QNllHdGc2?=
 =?utf-8?B?RnhnallmZjdDY0VwaFFsMzdTcllhdGlqYy9hSmZiL2syRitnY2Z0eDdCNVVQ?=
 =?utf-8?B?WEtvRExlOW8rUzIxTlprdGhkaVZsNVMvYmdIdDN0MzNsaVhHUnFPZEtWMVlM?=
 =?utf-8?B?K1ZENmhQRlk5K2tWK2ZmeGc4bFpJN1pDL211cjdtMHFveFhGNmZBelRwUkNw?=
 =?utf-8?B?dkpQY2lDN2FEcDFuMk53YlV3NGhrVFk0aVVla1NzZGRKWHlxc201dyt4bmlF?=
 =?utf-8?B?cnJjQlJUU1laN1VWUHFnaUJoMmFpZ3lxTTdRcC9NdjZiUTFIajE1T0JRUXVX?=
 =?utf-8?B?VEdEZDdQdVE4dlBBSGtDRUp4TnN1aCtQcEhzQWJBVHpTV2tVcXd1ZVp6UTc4?=
 =?utf-8?B?QlI1VGFVZnRjUzY2ajZ0MFZ4VmRoaUJ5aGZna2VDczRSdS9aZ1dsdlVmVmtw?=
 =?utf-8?B?NkpQUnc3bnY0MU5aeGpmenBuUW1rM0MwWGpxbXBXazFVRW1BTUxRZkR4aWhT?=
 =?utf-8?B?ZzhRLy82aEdIU242dTVZL3VFc3ZwaEJVNUdHT2RkN3p4WWRndGNCWm5IaFdM?=
 =?utf-8?B?NjlQeHdwaWlXNG0zaTN3OE9mZ2h5eU1qTVloQ1c1QkZkRmNHQnlyTGZUOHJl?=
 =?utf-8?B?Uk92WnYvY3JXL1Mvc0xwYlpCSHVza1ZjLzRqMlBXZlcwb2pFMkI4SVVRN0lI?=
 =?utf-8?B?YmlpdFpIMzMrWVRzV1NtNVdVazJxRWxqN1EzcFA0WElvaXkyMmlRa1NKK0Fr?=
 =?utf-8?B?dmprZk1aZndZQVBQYUJ2NnlLM2xGQk1nZ2N6Ymh1djFmTkZDUHFacC9hd05q?=
 =?utf-8?B?akluRFlJZ0RjWlJBSXRNMDV6RDlXMkN1dlBvaTAyTFhuNlA4WXE1ZFVlMXdF?=
 =?utf-8?B?RGRVaVNwR1dHbDhhaGZ6OFBRTmFHVHM4L0I1NTBRUm9zK0sxRncrZ3ptbkxy?=
 =?utf-8?Q?KsyCHKjaWKyKNaGAuPNtRV4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ed4f85-43b3-4296-e331-08de1519cea8
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 05:29:32.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eU4WBu2y6ezMVTUL+2t8JPmYwptBlEfWDhF294oPZxBi2neSKHe5lUlRolV7R566f7BACTEbtlGenHkSwM8zXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3383

On Fri, Oct 24, 2025 at 12:43:47PM -0400, Frank Li wrote:
> On Sat, Oct 25, 2025 at 01:04:01AM +0900, Koichiro Den wrote:
> > On Thu, Oct 23, 2025 at 11:27:09PM -0400, Frank Li wrote:
> > > On Thu, Oct 23, 2025 at 04:18:51PM +0900, Koichiro Den wrote:
> > > > Hi all,
> > > >
> > > > Motivation
> > > > ==========
> > > >
> > > > On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> > > > does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> > > > result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> > > > (EP) is not possible even if we would add implementation to create a MSI
> > > > domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> > > > traffic must fall back to doorbells (polling). In addition, BAR resources
> > > > are scarce, which makes it difficult to dedicate a BAR solely to an
> > > > NTB/msi window.
> > > >
> > > > This RFC introduces a generic interrupt backend for NTB. The existing MSI
> > > > path is converted to a backend, and a new DW eDMA test-interrupt backend
> > > > provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> > > > parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> > > > windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> > > > The vNTB EPF and ntb_transport are taught about offsets.
> > >
> > > Map multi address to one bar is quite valuable, so we can start it as the
> > > first steps.
> > >
> > > But I have a problem about DWC iATU address map mode. for example, bar0
> > > to cpu address 0x8000000 (Local CPU).  but difference RC system, at RC side
> > > bar0 address is variable. May be 0xa000_0000 (RC side), maybe 0xc000_0000
> > > (RC side).
> > >
> > > Set bar0 mapping before linkup.
> > >
> > > How do you know PCI bus address is 0xa0000000 or 0xc0000000.
> >
> > Thanks for the comment.
> >
> > For vNTB this is done in two steps:
> >
> > 1). In the epf_ntb_bind() path we call pci_epc_map_inbound() with
> >     epf_bar->phys_addr == 0. On the DWC side this only triggers
> >     dw_pcie_ep_set_bar_init() and does not program an inbound iATU yet.
> >     (pls see Patch #5).
> > 2). Later, when ntb_transport's link work runs and we actually need to
> >     set up Address Match inbound window(s), pci_epc_map_inbound() is called
> >     again with epf_bar->phys_addr != 0 (and an offset for the sub‑range). At
> >     that point the RC has already enumerated the device and assigned the BAR,
> >     so dw_pcie_ep_map_inbound() reads back the assigned BAR value via
> >     dw_pcie_ep_read_bar_assigned(), computes pci_addr = base + offset, and
> >     programs the inbound iATU in Address Match mode (again, Patch #5 is
> >     relevant).
> >
> > Because we do not program the inbound iATU before enumeration, we don't
> > need to know upfront whether the RC will place BAR0 at 0xa000_0000 or
> > 0xc000_0000. We read the assigned address right before the actual
> > programming (again, see the Patch #5). Am I missing something?
> 
> This should work for vntb user case. It needs generalize for other usage
> mode. maybe combine multi regions to one bar.

IMO it's already generized infrastructure. I'm not sure if we need to
retrofit other EPFs (pci_epc_set_bar callers) in this series. We can do
that when there's really a concrete need.

> 
> Add a case in pci-ep-test function drivers to let more people can review
> it.

This sounds reasonable, though it may involve seemingly a bit of duplicate
work, i.e. adding a similar configfs knobs on the pci-epf-test side, expand
the control register fields, make pci_endpoint_test aware of it, and
makeing sure that the selftest still pass. Please correct me if I'm off
here. I'll take some time to prepare that.

Thanks for the review.

-Koichiro

> 
> Frank
> 
> >
> > -Koichiro
> >
> > >
> > > Frank
> > >
> > > >
> > > > Backend selection is automatic: if MSI is available we use the MSI backend.
> > > > Otherwise, if enabled, the DW eDMA backend is used. If neither is
> > > > available, we continue to use doorbells. Existing systems remain unaffected
> > > > unless use_intr=1 is set.
> > > >
> > > > Example layout (R-Car S4):
> > > >
> > > >   BAR0: Config/Spad
> > > >   BAR2 [0x00000-0xF0000]: MW1 (data)
> > > >   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
> > > >   BAR4: Doorbell
> > > >
> > > >   # The corresponding configfs settings (see Patch #25):
> > > >   echo 0xF0000 > ./mw1
> > > >   echo 0x8000  > ./mw2
> > > >   echo 0xF0000 > ./mw2_offset
> > > >   echo 2       > ./mw1_bar
> > > >   echo 2       > ./mw2_bar
> > > >
> > > > Summary of changes
> > > > ==================
> > > >
> > > > * NTB core/transport
> > > >   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
> > > >   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
> > > >   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
> > > >   - Support offsetted partial MWs in ntb_transport.
> > > >   - Hardening for peer-reported interrupt values and minor cleanups.
> > > >
> > > > * PCI Endpoint core and DWC EP controller
> > > >   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
> > > >   - Implement inbound mapping for DesignWare EP (Address Match mode), with
> > > >     tracking of multiple inbound iATU entries per BAR and proper teardown.
> > > >
> > > > * EPF vNTB
> > > >   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
> > > >   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
> > > >     set_bar().
> > > >   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
> > > >
> > > > * DW eDMA
> > > >   - Add self-interrupt registration and expose test-IRQ register offsets.
> > > >   - Provide dw_edma_find_by_child().
> > > >
> > > > * Renesas R-Car
> > > >   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
> > > >
> > > > * Documentation
> > > >
> > > > Patch layout
> > > > ============
> > > >
> > > > * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> > > > * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> > > > * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> > > > * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> > > > * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> > > > * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> > > > * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> > > > * Patch 25      : Documentation updates
> > > >
> > > > Tested on
> > > > =========
> > > >
> > > > * Renesas R-Car S4 Spider
> > > > * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
> > > >
> > > > Performance measurement
> > > > =======================
> > > >
> > > > Even without the DMA acceleration patches for R-Car S4 (which I keep
> > > > separate from this RFC patch series), enabling RC-to-EP interrupts
> > > > dramatically improves NTB latency on R-Car S4:
> > > >
> > > > * Before this patch series (NB. use_msi doesn't work on R-Car S4)
> > > >
> > > >   # Server: sockperf server -i 0.0.0.0
> > > >   # Client: sockperf ping-pong -i $SERVER_IP
> > > >   ========= Printing statistics for Server No: 0
> > > >   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
> > > >   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
> > > >         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
> > > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > > >   Summary: Latency is 5995.680 usec
> > > >   Total 45 observations; each percentile contains 0.45 observations
> > > >   ---> <MAX> observation = 6121.137
> > > >   ---> percentile 99.999 = 6121.137
> > > >   ---> percentile 99.990 = 6121.137
> > > >   ---> percentile 99.900 = 6121.137
> > > >   ---> percentile 99.000 = 6121.137
> > > >   ---> percentile 90.000 = 6099.178
> > > >   ---> percentile 75.000 = 6054.418
> > > >   ---> percentile 50.000 = 5993.040
> > > >   ---> percentile 25.000 = 5935.021
> > > >   ---> <MIN> observation = 5883.362
> > > >
> > > > * With this series (use_intr=1)
> > > >
> > > >   # Server: sockperf server -i 0.0.0.0
> > > >   # Client: sockperf ping-pong -i $SERVER_IP
> > > >   ========= Printing statistics for Server No: 0
> > > >   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
> > > >   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
> > > >         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
> > > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > > >   Summary: Latency is 127.677 usec
> > > >   Total 2145 observations; each percentile contains 21.45 observations
> > > >   ---> <MAX> observation =  446.691
> > > >   ---> percentile 99.999 =  446.691
> > > >   ---> percentile 99.990 =  446.691
> > > >   ---> percentile 99.900 =  291.234
> > > >   ---> percentile 99.000 =  221.515
> > > >   ---> percentile 90.000 =  149.277
> > > >   ---> percentile 75.000 =  124.497
> > > >   ---> percentile 50.000 =  121.137
> > > >   ---> percentile 25.000 =  119.037
> > > >   ---> <MIN> observation =  113.637
> > > >
> > > > Feedback welcome on both the approach and the splitting/routing preference.
> > > >
> > > > (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> > > > later if preferred.)
> > > >
> > > > Thanks for reviewing.
> > > >
> > > >
> > > > Koichiro Den (25):
> > > >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> > > >     access
> > > >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> > > >   NTB: epf: Handle mwN_offset for inbound MW regions
> > > >   PCI: endpoint: Add inbound mapping ops to EPC core
> > > >   PCI: dwc: ep: Implement EPC inbound mapping support
> > > >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> > > >   NTB: Add offset parameter to MW translation APIs
> > > >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> > > >     present
> > > >   NTB: ntb_transport: Support offsetted partial memory windows
> > > >   NTB/msi: Support offsetted partial memory window for MSI
> > > >   NTB/msi: Do not force MW to its maximum possible size
> > > >   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
> > > >   NTB/msi: Skip mw_set_trans() if already configured
> > > >   NTB/msi: Add a inner loop for PCI-MSI cases
> > > >   dmaengine: dw-edma: Add self-interrupt registration API
> > > >   dmaengine: dw-edma: Expose self-IRQ register offsets
> > > >   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
> > > >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> > > >   NTB: epf: vntb: Implement .get_pci_epc() callback
> > > >   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
> > > >   NTB: Introduce generic interrupt backend abstraction and convert MSI
> > > >   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
> > > >   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
> > > >   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
> > > >   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> > > >     usage
> > > >
> > > >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> > > >  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
> > > >  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
> > > >  drivers/ntb/Kconfig                           |  15 ++
> > > >  drivers/ntb/Makefile                          |   6 +-
> > > >  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
> > > >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
> > > >  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
> > > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
> > > >  drivers/ntb/intr_common.c                     |  61 +++++
> > > >  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
> > > >  drivers/ntb/msi.c                             | 186 +++++++------
> > > >  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
> > > >  drivers/ntb/test/ntb_msi_test.c               |  26 +-
> > > >  drivers/ntb/test/ntb_perf.c                   |   4 +-
> > > >  drivers/ntb/test/ntb_tool.c                   |   6 +-
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
> > > >  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
> > > >  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
> > > >  include/linux/dma/edma.h                      |  31 +++
> > > >  include/linux/ntb.h                           | 134 +++++++---
> > > >  include/linux/pci-epc.h                       |  11 +
> > > >  29 files changed, 1310 insertions(+), 300 deletions(-)
> > > >  create mode 100644 drivers/ntb/intr_common.c
> > > >  create mode 100644 drivers/ntb/intr_dw_edma.c
> > > >
> > > > --
> > > > 2.48.1
> > > >

