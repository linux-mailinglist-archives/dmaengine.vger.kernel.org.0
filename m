Return-Path: <dmaengine+bounces-8733-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOk+Ksdzg2mFmwMAu9opvQ
	(envelope-from <dmaengine+bounces-8733-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 17:28:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC00EA378
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F838300F984
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408042669D;
	Wed,  4 Feb 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fwBmR6fF"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB4642669A;
	Wed,  4 Feb 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221854; cv=fail; b=WOXFLS3UxvcpcmRS1Smf1c2roBKZm3P32KNNh+ML/ji7mIWGdTqUxQbTMNKuxR3DSWku+7HHzM0o+46Tn/4pbj/1nzIMHIWWkRUC8yrboE2p6TrkctEKJfXc4C5i1KT/XOffdGanDUpkZ9fGdxViqRT4NhsGBwbnZmRPnT5+/C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221854; c=relaxed/simple;
	bh=SxB1XYmk+ZOejgX1YoX720+lK6ckCbbSPFNKNI6oGQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DvSBZtvamg01RZGv9o55e1Uhdulv+hWqGp9e2mv/lqeALqhJh5Uh7sis5NdhroUZuiR5+TlGGFgkxnA/F0sx2p3wqRTHf8A/GkNDzsM51k6F+2cPtRlsA52DJh+DVpn5d2H4tmxONGMcjffB1qZUxlKe+uBkXBQdJyZ5k1hzWEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fwBmR6fF; arc=fail smtp.client-ip=52.101.83.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up8TZezIs/1jkd7ru88VH+Pb+1YrSr3CGTdPLjh0mDdCLJ03L5sd30OCkDoK/jDDCSvFPjnIRl5K1keYrjXsWPwoYttxOa7Zaj68ZS03WDZfHp3COtZ0nN3L0JyJ/ESJL9aOw+iEyrCOp4wz538sn++zxNC+ayoqU+RCbFcE9s7gNSxUckogfUDVfJNZGCdX63i2n8hlji/rhIA61685rBQExwIwLyMSMQjNqQnSfmTPcU0XJalkYwL5bqGD5H3UIquoWoEUPI0RIZ3aQqkvU5s4PoncQAH6Xnl9K8DaNdIxFvF+ZTWdegZjM8qFbD7lsdcaxreldhw9TTgE2AjXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv5/SdbkEQVXi5Ma3pIg0/taCHBOzUGom6QrmrHMhDs=;
 b=wq2S/5ILP9dwZfNsTkT5EY7PXUS4UQ30EuxWeWoCwQmq/ivoZNFMNJzOGTcuGQZURV+W4o/60vopCi+c9xsmUI2Ao+S8SeGwFa1zTug8CgPZjLdrTDdSIfaOfkppP6hiOt5CvIeQcYdefESmSjYmOuX1aN/QbRW9hntN+HwK73rIIILDG+juRU6vg+siYmBsxZPyRttsHZEIgYz7GMjcF779jkeKs43mRFzNqi8GpyxeVigpj6rFeN3x+de6ClvLZECWclek5rJ67hnP8vAXw3fqJOpDY/eSDsbb8GWBew2C6M7P0/LHyTJI8STQc43ooaSkiZfSoRWyaT6NT9eZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv5/SdbkEQVXi5Ma3pIg0/taCHBOzUGom6QrmrHMhDs=;
 b=fwBmR6fFLf9g5dMPOFm6Mjc5se0c2rXygmsNviGlHXZJKpZ4lhg/0jvdPr/N92aEaAZkztaGQD//uxCO26HAL7PO6qEiqMDi6edjsqeKfm8IbubtoFPhvSJ+Dr5+E7eNr/dbzrNb4PEuCQROsapAHghTtWuTfJpcH4p//loeRR36/ge1Q9tvOwZzmE/AV6uv+i4fU3A8obIPtIq6TUeL8yCSuhV1km1EikZOPOha143AXcxV/oDwbe5+fVln4EX1FhqzW7PLhDcttoyEqdG2i4P64jkmDu5MlXr+na1kqjWjJInGMKPPfHtyOSEik9gHXG+82l3G2GagDc4j73Vhig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS5PR04MB9895.eurprd04.prod.outlook.com (2603:10a6:20b:651::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 16:17:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 16:17:30 +0000
Date: Wed, 4 Feb 2026 11:17:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] dmaengine: dw-edma, PCI: dwc: Enable remote use
 of integrated DesignWare eDMA
Message-ID: <aYNxE24JcnGNye9J@lizhi-Precision-Tower-5810>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <h3uhcd426u32lmn4ajjcrclabuptiy3d4lmtdbwhtu5ca2dv2s@co5piltmkhx6>
 <aYDX2Y0n8lD/iUcJ@lizhi-Precision-Tower-5810>
 <cujofbyvnhwaqpto5pjyxdl3gosat2frixuyhic6tr6zf32rzs@rvtfrcueqq2h>
 <aYIvyvHR8s//8STf@lizhi-Precision-Tower-5810>
 <3wtr4dllqg2ijbzwb4eklmcwwuzgt4my4bdcw2ivslgj3aoix4@kckvh7fpna6y>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3wtr4dllqg2ijbzwb4eklmcwwuzgt4my4bdcw2ivslgj3aoix4@kckvh7fpna6y>
X-ClientProxiedBy: PH7P221CA0033.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e027534-e589-49fa-0ba8-08de6408e53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0ZFRVRwK0poVFFWRFB0OEJ1TXJIVmJEMG9DcU1DbTgyaG5zYnFzZS8rc0I3?=
 =?utf-8?B?VEN4aGhTaXN0OEdVT0k2T1lZSDl3MmZseUVkUDRqR2Nud09WVXd3cFo3c0Zx?=
 =?utf-8?B?c0Vmc0UzSkpVeE1lVy82LzJyQitLK0xoZmZwNWtEai8xdE1tUW9SdnFmQk53?=
 =?utf-8?B?UUFEb1ZYSlRpWDdwbWNaRzdTMWF3cUlPWWdXNS9kM1JrUytSUVMxeUtjY1pk?=
 =?utf-8?B?RmJPTHpyNTZweVJtOWt5d1cvT0tEQi9JNEFhZVdIby9HdGNlSEhNZzJ1YzQx?=
 =?utf-8?B?VjlBbWVUSnpEZHdNV2ErRlovMWZaeWFrVnhYaEJwRTRHenNFb1ZMWmxNM3NY?=
 =?utf-8?B?VXhNVklUYnZCbU9VQm1HdXhCeGV2d0FsNW9QL3IyTlNPZGZPaEdoTFc1ZWxs?=
 =?utf-8?B?ell3YzdXS2lNTmc4TWxqa05aT1F2c0pobWxJSjM5THF3QmkrQmgzeWZ1ZmNW?=
 =?utf-8?B?anArMFNzMHRVZmtyNzRhU0VvTE0ybndZMk1iNlB0RWQxWFVqcDIra3NUc2dr?=
 =?utf-8?B?VVhTVkJlQW5lQmV0QXJDcTlPaGEwOEhDZjNjdktMaHBXaHNiTjU1T2pzOGd3?=
 =?utf-8?B?akdlaThuN3crR0J2aXhOZ1FtQll1Mk13Y2VFQkMrUnlnZW9Ha2ZQSG1YTkU4?=
 =?utf-8?B?Mk5EK05xcWw0OWNJaUhaQUlnQWJqU2FSbEVBYTV6NWt0UmxNOWtNQkx3N1Zi?=
 =?utf-8?B?STNKdlY2L3I5Nkpaa3E3UkhYTkRCdkpZUXY3cDFSUHJZTlRxb3c0TUJuTXNR?=
 =?utf-8?B?VXEyK2szb1JZRWl2a043NXBpRWVQNGF1RlVTall2WEdCRnIyS1ZaRU5pc2Ft?=
 =?utf-8?B?ajkrK0pVTU5NVTY4SkcxR1RvOHRKREo5SnQ4T2tMR3krdkNjd1R5Rzd6UnFu?=
 =?utf-8?B?S2wvaVZaSzREZXRHYmxYdVdrZlo3K2trOW05YXh1S2xQV2FsbUh4dlQ1SUEx?=
 =?utf-8?B?V3QvR1ZHM0R6dkNyVGhZdndsYk9aeGM4aWJ2WWNodVZ3UERyNlRKM2VGOFRL?=
 =?utf-8?B?b2hURTlRZDFmYTZrTTVCVkErcEMxRGlmT25WY3BPVi9sZThPK0ZreXA1VFVQ?=
 =?utf-8?B?Q2dncWZVUDhxWCt1eFdScllQR0o5L3dYS1V6UWNOaWpnQ2ljV3I3LzhoZ0Mz?=
 =?utf-8?B?cHc2QksyQUZNZUFDUkp2YXUzWmw3d25WR0x0UnA0RGQ2eFFoV0lITTBaNjY0?=
 =?utf-8?B?M3NlSVVBVFZNS25NV0pBMVJPQ2xwdDdPWlNRS21xaHBCNlFMQVQ1cEVDelBu?=
 =?utf-8?B?ZXZWdks4ZDNTbmJUV1oraTRRNmdROExGNzM5cmV1c2VXWjdhM0o5bW1vbVV4?=
 =?utf-8?B?bUFrVWlmM0cvYzB4eFcrN09yTktkTHhxcjZsMEZTZGFyZDd5bjRGbjRVSkJW?=
 =?utf-8?B?V2pDdXFhQ3V0bytYdkh1d0Q2SDdTbHplbWNUM01UV2crNmJoWm9BalVCS2hq?=
 =?utf-8?B?bUFPL2hqQVdvRGQ2bGsreXRoTWNHVEQvNmQ2Zi9DekIwUUpPRnVpRUExRm1m?=
 =?utf-8?B?KzRVcko4MGpzWnpyRTEyMElFUDFidDZaRVRHRUR6WXc2S3FkSXpPa3RYZVlT?=
 =?utf-8?B?dk1uUFhpRnVXaFg0d2NpT0Y3UmpsZkFrUFdjYlhpaFFqQ01wQlRCTEJyenEz?=
 =?utf-8?B?KzFpcmNRS0xPTWtsQWFYamxuRzJ4V0Z6M2tNbDBhWjNPNkdITXZWRTJFdENR?=
 =?utf-8?B?MWh5YU4wWEFwT0xFb3FIMm5xbkp1MnpBSXRnUjR1WUF2UUhLczRFdnEvWHo2?=
 =?utf-8?B?S2JQbENNcDY5YWFXMVJzaTUxT0VRTWNJRnhpdXZ4THdkamoyUlRTQVgyREx4?=
 =?utf-8?B?UTZKeHI1RitYcmZ2WldoVGhBd2FFVHJOQ0l4bU54RHpVeVMwRVVOTlVBNU5q?=
 =?utf-8?B?cGppbVBtNnUvbForL0hpQUp5N3hEYlRGNWh3MHlLQTJIZXFFZXBlYzRjN1Bx?=
 =?utf-8?B?R3dPTjFNRlRkYkJNVlVmZzErYysrQzR1cGtHU1E3OElXVHpRR01RcTVJSXNn?=
 =?utf-8?B?QXgxb1YyS01PUmh1bVVLeUhocEdRZmwzOXZGTHNjRHNWOGYva0xnV2hhbmM2?=
 =?utf-8?B?QUV5aU8rdUlUekZ5UDYzMVhySXV2N3g4MVNjU3B2MHV2RDRyTXNyS0xzcW9w?=
 =?utf-8?B?UXNUSXJTZHRnUTUwbUZaaG1nNStYOURMQTZjUnc5ODNFTXpQOXBhNDFDMW5D?=
 =?utf-8?Q?SRncQp7iNQn7BVi0sjhY9xg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTVtdERmK2tsMWRLMnRSRUt1K004WTR2L0N2cklqQUtDWVNWbnU2VHU5dWlP?=
 =?utf-8?B?M0RZS0dZeEVRb3J6Lzh1emhZbHlEejNVekxLTDRIOWw1WXpyU2Vua1Iva0VG?=
 =?utf-8?B?MjduSUFjR256aDlxc0JpRzRQN2VZY2xJSU1aMld3MllOU0E4OHo1bFMrTi9j?=
 =?utf-8?B?bmdoOG1NZkc5b1NXUjhrKzU0SG8yenJod0VWd08yYjltejVPejZ6RVlNanc0?=
 =?utf-8?B?dzE3eFFuZ0FJRUVrcUNmR1JQSHVWTzZNcXhDdXRxdmRhdm9MZEtvWlRaUzk5?=
 =?utf-8?B?Z2JFVHlRbW5Tc1JUZXV3RUJxc1FUb2ZwdVUzVzdVUlNkWUR4eVJjaHRrbmVU?=
 =?utf-8?B?dGlvSWphRjloNUp5WldxcXc4YnJ4a0VVK3RQekpTNitFZGo3WjM0OXRXaHF4?=
 =?utf-8?B?SmVERVg5K05EZ2VWOG1JaGxuRlpzTXB3bDkwYVh1Mnc2QW96ZkZsY001bldZ?=
 =?utf-8?B?L3FLT1lKMkRadVJKS2FtTnBaYWxnMEFTZkl0RFpqYnJqd0JaUVJacXlkUVNJ?=
 =?utf-8?B?RVo5bHRBcU54RTBHRHNqMGNnOFdxWHhuME9TK3YzaHJ4NWVFWkZXdDQ1M2Fy?=
 =?utf-8?B?TzhFS0ZMbDNnSWxCTklKSWUrMktadkJ5cGN0ZGhRMjVnVnFoMWJTMlQxcWxt?=
 =?utf-8?B?Mi9hdTV0QktOS3NyOEpHZytPS1lzYUZ4SjlNdU01MGlKMlEydVFnem1pVjVZ?=
 =?utf-8?B?dWI5SllNZVVwUG1Jd3k0REZxbUtLRlQ1em1CVHlSekkxcExWSWo0eVpmNVdu?=
 =?utf-8?B?VUdhbXJQUEd1MUw5SnFEVzdNc1JIZzQ0RlI5M2ZvbkphYWI4bGppSk5IN05V?=
 =?utf-8?B?THA3aW5heDVBc2NLWis0Wkk5K2dwQ1piempweEs0d21JblR4dmdWK3l2aXpu?=
 =?utf-8?B?a2xCRmZVTTUrMTR4K0VLOUJsUFFma291OGRYcEE2VGFETklWQm5KYTdWWkpU?=
 =?utf-8?B?SnJURVVlRUVZalY1eWd6ZFYwR1AzRTBTcjFBRkhadUFFSmpFWGE2R3M5d0JL?=
 =?utf-8?B?amZyaktMRk4yN0tiTHV6N1RJUkxLNDVTbHYxUWhaR2ZsK1VEbE12RUpqZENl?=
 =?utf-8?B?S3BGNU42ZEwxb0QyS2JHZW1YZkJxYkc0RFhlQzgzTlJTd01FeEtTNDhOQUZi?=
 =?utf-8?B?QWdpUWNIN25tZUwzMG1Wd1JvN2VZVzAweWRoYVFtSXRCUUtzVDlNNk5uRnE2?=
 =?utf-8?B?SXBmQStJUGI2VVJpMklQc0hudjZVNFZYVG9Yb3JwbkJ4MEdqZEtzSjU5NzFE?=
 =?utf-8?B?ZTEwUGI1WEtGdERWM1B3ZnBjTDRhZFovR292OW1YVVh4cnM2dXBGZHZFNjdx?=
 =?utf-8?B?Y3FsSFJiWEpLNFcvbncreVFKdWZWaUhuZnZEZ0dZTzBZVUlwVlV4TmkxNFhq?=
 =?utf-8?B?a20zck5vUWV2b0NJSHpaM1FwZ3k0YldWUjVRQ0N1a3QzRzZtaFE2VmJzYzdF?=
 =?utf-8?B?anpIRGMxSU1WamdhZWd5MVJwNUNiSWpMTjFHalU5cXdLN0pmWG1maE96eWZ5?=
 =?utf-8?B?R2Q4SXhNcVVkbEVRMXA2TXJJU0R3MkVGaVdIWkd5ajZ6aWNOZEQvMUZEbWV1?=
 =?utf-8?B?aUJXVHBiUzhOVTR0eGZOSTgyQXZ0b0pqeDBZM0FHWUQwVEhaUzVzeGhNYW8v?=
 =?utf-8?B?czhBck16TjV6VnhZZ21zWldPbWVpbEppNnkvZUtRc2RxVEk4TUpFU0YxdlIv?=
 =?utf-8?B?dW9nN3J0Q1hibkhXeGFyYThjYmVvYkZUMTFMVGx6dEpGd1ZjU3o4RFEvdUdN?=
 =?utf-8?B?byt0NndXbFJMSkhCVDhQcFZUQVlPVGt1OXdRbGJHd0hvdGdhcnZuRkJUNUNi?=
 =?utf-8?B?ZzRha3FTYUw0bUw3djIwalFUNzhLcStQZk9TSytWdG1uWDh2WUNINkJEWlI1?=
 =?utf-8?B?OHdwTXh1dkhKY2ZTbE5oSzZheHRkeHByVHN1d0NvQmFpOWc1Yk5jZmlGdS9u?=
 =?utf-8?B?WmNGT3g5ZmtqZFd4SXRCbWxic2V3NUtBZUFYVHkyd01RcC9GYXRNRHpteE5Y?=
 =?utf-8?B?S3ZkYVh3L0U5N0JsTUV4N2labW1tS0gxQk5vQyt6dHZiM2VaY0h2OW5mQXNh?=
 =?utf-8?B?Q3ZyNHgrbFdpcFk3VTJhYStBN3ZkMkxXUVBqRFo4dVQrQllWNTBFR2lmY1dw?=
 =?utf-8?B?dnUwK1RNL3F6SUNIUkN2QVNTRjYrd3pLbHAyWTNaN25CTkk1NVpMaE9YMmVF?=
 =?utf-8?B?Rmdhc1lZUU00OFpYWjFDUjJLN2wzOTNEc2JBN0Y2bCttNmpGQll0elAyZllY?=
 =?utf-8?B?UzlzVTBzVm9qaDVCSStHT1ZUcXErVnNJYW1lblZRRnhIQmJ5MHpabDQyS29U?=
 =?utf-8?Q?AMyYHQkiQIgjClcRSC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e027534-e589-49fa-0ba8-08de6408e53a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 16:17:30.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8dKVxsoW1WpC1kzygUSDt6TMUC/3FSGB+b4PovkQHSMTd9q+vj0E1QQk1f6h7sz6amz9tngbokWNiDN7Nlhmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8733-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBC00EA378
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 04:27:46PM +0900, Koichiro Den wrote:
> On Tue, Feb 03, 2026 at 12:26:34PM -0500, Frank Li wrote:
> > On Tue, Feb 03, 2026 at 10:59:10AM +0900, Koichiro Den wrote:
> > > On Mon, Feb 02, 2026 at 11:59:05AM -0500, Frank Li wrote:
> > > > On Sun, Feb 01, 2026 at 11:32:23AM +0900, Koichiro Den wrote:
> > > > > On Tue, Jan 27, 2026 at 12:34:13PM +0900, Koichiro Den wrote:
> > > > > > Hi,
> > > > > >
> > > > > > Per Frank Li's suggestion [1], this revision combines the previously posted
> > > > > > PCI/dwc helper series and the dmaengine/dw-edma series into a single
> > > > > > 7-patch set. This series therefore supersedes the two earlier postings:
> > > > > >
> > > > > >   - [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
> > > > > >     https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
> > > > > >   - [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
> > > > > >     https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-pci/aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810/
> > > > > >
> > > > > > Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
> > > > > > instance alongside the PCIe controller. In remote eDMA use cases, the host
> > > > > > needs access to the eDMA register block and the per-channel linked-list
> > > > > > (LL) regions via PCIe BARs, while the endpoint may still boot with a
> > > > > > standard EP configuration (and may also use dw-edma locally).
> > > > > >
> > > > > > This series provides the following building blocks:
> > > > > >
> > > > > >   * dmaengine: Add an optional dma_slave_caps.hw_id so DMA providers can expose
> > > > > >     a provider-defined hardware channel identifier to clients, and report it
> > > > > >     from dw-edma. This allows users to correlate a DMA channel with
> > > > > >     hardware-specific resources such as per-channel LL regions.
> > > > > >
> > > > > >   * dmaengine/dw-edma: Add features useful for remote-controlled EP eDMA usage:
> > > > > >       - per-channel interrupt routing control (configured via dmaengine_slave_config(),
> > > > > >         passing a small dw-edma-specific structure through
> > > > > >         dma_slave_config.peripheral_config / dma_slave_config.peripheral_size),
> > > > > >       - optional completion polling when local IRQ handling is disabled, and
> > > > > >       - notify-only channels for cases where the local side needs interrupt
> > > > > > 	notification without cookie-based accounting (i.e. its peer
> > > > > > 	prepares and submits the descriptors), useful when host-to-endpoint
> > > > > > 	interrupt delivery is difficult or unavailable without it.
> > > > > >
> > > > > >   * PCI: dwc: Add query-only helper APIs to expose resources of an integrated
> > > > > >     DesignWare eDMA instance:
> > > > > >       - the physical base/size of the eDMA register window, and
> > > > > >       - the per-channel LL region base/size, keyed by transfer direction and
> > > > > >         the hardware channel identifier (hw_id).
> > > > > >
> > > > > > The first real user will likely be the DesignWare backend in the NTB transport work:
> > > > > >
> > > > > >   [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
> > > > > >   https://lore.kernel.org/linux-pci/20260118135440.1958279-26-den@valinux.co.jp/
> > > > > >
> > > > > >     (Note: the implementation in this series has been updated since that
> > > > > >     RFC v4, so the RFC series will also need some adjustments. I have an
> > > > > >     updated RFC series locally and can post an RFC v5 if that would help
> > > > > >     review/testing.)
> > > > > >
> > > > > > Apply/merge notes:
> > > > > >   - Patches 1-5 apply cleanly on dmaengine.git next.
> > > > > >   - Patches 6-7 apply cleanly on pci.git controller/dwc.
> > > > > >
> > > > > > Changes in v2:
> > > > > >   - Combine the two previously posted series into a single set (per Frank's
> > > > > >     suggestion). Order dmaengine/dw-edma patches first so hw_id support
> > > > > >     lands before the PCI LL-region helper, which assumes
> > > > > >     dma_slave_caps.hw_id availability.
> > > > > >
> > > > > > Thanks for reviewing,
> > > > > >
> > > > > >
> > > > > > Koichiro Den (7):
> > > > > >   dmaengine: Add hw_id to dma_slave_caps
> > > > > >   dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
> > > > > >   dmaengine: dw-edma: Add per-channel interrupt routing control
> > > > > >   dmaengine: dw-edma: Poll completion when local IRQ handling is
> > > > > >     disabled
> > > > > >   dmaengine: dw-edma: Add notify-only channels support
> > > > > >   PCI: dwc: Add helper to query integrated dw-edma register window
> > > > > >   PCI: dwc: Add helper to query integrated dw-edma linked-list region
> > > > >
> > > > >
> > > > > Hi Mani, Vinod (and others),
> > > > >
> > > > > I'd appreciate your thoughts on the overall design of patches 3–5/7 when
> > > > > you have a moment.
> > > > >
> > > > >   - [PATCH v2 3/7] dmaengine: dw-edma: Add per-channel interrupt routing control
> > > > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-4-den@valinux.co.jp/
> > > > >   - [PATCH v2 4/7] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
> > > > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-5-den@valinux.co.jp/
> > > > >   - [PATCH v2 5/7] dmaengine: dw-edma: Add notify-only channels support
> > > > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-6-den@valinux.co.jp/
> > > > >
> > > > > My cover letter might have been too terse, so let me add a bit more context
> > > > > and two questions at the end.
> > > > >
> > > > > (Frank already provided helpful feedback on v1/RFC for Patch 3/7. Thanks, Frank.)
> > > > >
> > > > >
> > > > > Motivation for these three patches
> > > > > ----------------------------------
> > > > >
> > > > >   For remote use of a DMA channel (i.e. the host drives a channel that
> > > > >   resides in the endpoint (EP)):
> > > > >
> > > > >   * The EP initializes its DMA channels during the normal SoC glue
> > > > >     driver probe.
> > > > >   * It obtains a dma_chan to delegate to the host via the standard
> > > > >     dma_request_channel().
> > > > >   * It exposes the underlying HW resources to the host ("delegation").
> > > > >   * The host also acquires a channel via the standard
> > > > >     dma_request_channel(). The underlying HW resource is the same as on the
> > > > >     EP side, but it's driven remotely from the host.
> > > > >
> > > > >   and I'm targeting two operating modes:
> > > > >
> > > > >   1). Standard use of the remote channel
> > > > >
> > > > >     * The host submits a transaction and handles its completion, just
> > > > >       like a local dmaengine client would. Under the hood, the HW channel
> > > > >       resides in the remote EP.
> > > > >     * In this scenario, we need to ensure:
> > > > >       (a). completion interrupts are delivered only to the host. Or,
> > > > >       (b). even if (a) is not possible (i.e. the EP also gets interrupted),
> > > > >            the EP must not acknowledge/clear the interrupt status in a way
> > > > >            that would race with host.
> > > > >
> > > > >                                   dmaengine_submit()
> > > > >                                           :
> > > > >                                           v
> > > > >        +----------+                 +----------+
> > > > >        | dma_chan |--(delegate)--->: dma_chan :
> > > > >        +----------+                 +----------+
> > > > >       EP (delegator)              Host (delegatee)
> > > > >                                           ^
> > > > >                                           :
> > > > >                                 completion interrupt
> > > > >
> > > > >   2). Notify-only channel
> > > > >
> > > > >     * The host submits a transaction, and the EP gets the interrupt
> > > > >       and runs any registered callbacks.
> > > > >     * In this scenario, we need to ensure:
> > > > >       (a). completion interrupts are delivered only to the EP. Or,
> > > > >       (b). even if (a) is not possible (i.e. the host also gets
> > > > >            interrupted), the host must not acknowledge/clear the interrupt
> > > > >            status in a way that would race with the EP.
> > > > >       (c). repeated dmaengine_submit() calls must not get stuck, even
> > > > >            though it cannot rely on interrupt-driven transaction status
> > > > >            management.
> > > >
> > > > According to RM:
> > > >
> > > > WR_DONE_INT_STATUS
> > > > Done Interrupt Status. The DMA write channel has successfully completed the DMA transfer. For
> > > > more information, see "Interrupts and Error Handling". Each bit corresponds to a DMA channel. Bit
> > > > [0] corresponds to channel 0.
> > > > - Enabling: For more information, see "Interrupts and Error Handling".
> > > > - Masking: The DMA write interrupt Mask register has no effect on this register.
> > > > - Clearing: You must write a 1'b1 to the corresponding channel bit in the DMA write interrupt Clear register
> > > > to clear this interrupt bit.
> > > >
> > > > Note: You can write to this register to emulate interrupt generation, during software or hardware testing. A
> > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > write to the address triggers an interrupt, but the DMA does not set the Done or Abort bits in this register.
> > > >
> > > >
> > > > So you just need write this register to trigger a fake irq. needn't do
> > > > data transfer.
> > >
> > > Thanks for the comment.
> > >
> > > One concern I have with using the fake interrupt mechanism is that it is
> > > effectively channel-less, while the only documented acknowledgment path is
> > > via {WR,RD}_DONE_INT_CLEAR[x], which is strictly channel-based. The RM does
> > > not describe how a channel-less, emulated interrupt is associated with (or
> > > cleared by) a specific channel's INT_CLEAR bit.
> >
> > According to spec, it should only generate a irq, but no bit set at status.
> > so needn't clean.
> >
> > >
> > > Because of that, I don't think there is a spec-backed guarantee that
> > > writing INT_CLEAR for an arbitrary (even if reserved) channel will reliably
> > > clear a fake interrupt, though I might be missing something. In the very
> > > first RFC v1 series [1], I ended up writing 1 to all enabled channels
> > > simply as the most defensive approach. However, that clearly does not
> > > compose well once the same eDMA instance is used for real data transfers,
> > > since it risks clearing real completion events.
> >
> > Transfer a dummy data is not big issue. Only have to write at least 2
> > register to finish a data transfer to trigger remote doorbell.
> >
> > If write INT_STATUS work, which will most likely push doorbell. I have not
> > did test, dose write INT_STATUS work?
>
> In the RM, WR_DONE_INT_CLEAR has the description:
>
>     Done Interrupt Clear. You must write a 1'b1 to clear the
>     corresponding bit in the Done interrupt status field of the
>     DMA write interrupt status register. Each bit corresponds to a
>     DMA channel. Bit [0] corresponds to channel 0.
>     Note: Reading from this self-clearing register field always
>     returns a '0'.
>
> Based on this, I originally assumed that writing a 1 to at least one
> channel bit was required. However, after reading your comment, I tested
> this on R-Car S4 Spider (eDMA) and verified that writing all 0s to
> INT_CLEAR is sufficient to deassert a raised fake irq. This means the fake
> irq can be acked without interfering with ongoing real DMA transfers on any
> channel.
>
> For HDMA, I do not currently have access to suitable hardware, so I have
> not been able to validate the same behavior. I guess something like this
> might work:
>
>     SET_BOTH_CH_32(dw, 0, int_clear, 0) // channel 0 chosen arbitrarily
>
> Anyway, based on the above, I have prepared v3 of the series and also
> locally updated my RFC series ("[RFC PATCH v4 00/38] NTB transport backed
> by PCI EP embedded DMA") accordingly. This fake irq approach has been
> working well in my testing, so I plan to send v3 shortly.

RFC is too bigger, can you do small one for epf_endpont_test(), which
already used MSI its as doorbell?  you can provide althernate method to do
doorbell, it will go quick to be merged.

Most DWC controller included DMA suppport, it will beneafit more than MSI
ITS because not all chips have its or there are other limiation.

Frank

>
> Thanks for the review, it helped a lot,
> Koichiro
>
> >
> > Frank
> >
> > >
> > > What's your view on this?
> > >
> > > [1] https://lore.kernel.org/all/20251023071916.901355-16-den@valinux.co.jp/
> > >
> > > Thanks again for taking a close look at this.
> > >
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > >
> > > > >       (d). callback can be registered for the dma_chan on the EP.
> > > > >
> > > > >                                   dmaengine_submit()
> > > > >                                           :
> > > > >                                           v
> > > > >        +----------+                 +----------+
> > > > >        | dma_chan |--(delegate)--->: dma_chan :
> > > > >        +----------+                 +----------+
> > > > >       EP (delegator)              Host (delegatee)
> > > > >              ^
> > > > >              :
> > > > >       completion interrupt
> > > > >
> > > > >
> > > > >   Patch mapping:
> > > > >     - (a)(b) are addressed by [PATCH v2 3/7].
> > > > >     - (c) is addressed by [PATCH v2 4/7].
> > > > >     - (d) is addressed by [PATCH v2 5/7].
> > > > >
> > > > >
> > > > > Questions
> > > > > ---------
> > > > >
> > > > >   1. Are these two use cases (1) and (2) acceptable?
> > > > >   2. To support (1) and (2), is the current implementation direction acceptable?
> > > > >      Or should this be generalized into a dmaengine API rather than being a
> > > > >      dw-edma-core-specific extension?
> > > > >
> > > > >
> > > > > Any feedback would be appreciated.
> > > > >
> > > > > Kind regards,
> > > > > Koichiro
> > > > >
> > > > >
> > > > > >
> > > > > >  MAINTAINERS                                  |   2 +-
> > > > > >  drivers/dma/dmaengine.c                      |   1 +
> > > > > >  drivers/dma/dw-edma/dw-edma-core.c           | 167 +++++++++++++++++--
> > > > > >  drivers/dma/dw-edma/dw-edma-core.h           |  21 +++
> > > > > >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  26 ++-
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c |  74 ++++++++
> > > > > >  drivers/pci/controller/dwc/pcie-designware.h |   2 +
> > > > > >  include/linux/dma/edma.h                     |  57 +++++++
> > > > > >  include/linux/dmaengine.h                    |   2 +
> > > > > >  include/linux/pcie-dwc-edma.h                |  72 ++++++++
> > > > > >  10 files changed, 398 insertions(+), 26 deletions(-)
> > > > > >  create mode 100644 include/linux/pcie-dwc-edma.h
> > > > > >
> > > > > > --
> > > > > > 2.51.0
> > > > > >

