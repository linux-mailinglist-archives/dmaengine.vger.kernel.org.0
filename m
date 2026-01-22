Return-Path: <dmaengine+bounces-8457-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAA0DoBFcmnpfAAAu9opvQ
	(envelope-from <dmaengine+bounces-8457-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 16:42:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D36569176
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D685B62C478
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC89366DD9;
	Thu, 22 Jan 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rZks45nm"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020093.outbound.protection.outlook.com [52.101.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5E36829D;
	Thu, 22 Jan 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093895; cv=fail; b=RUeoD+ZlBHQhD3ffe0dhPdalyroNdWcXtpH2GykzQd5MqYZLvorCQQQ9BMsWmUunYz7SXPDtkppzwUMFlIrSjr4Pz9prMJmXsQeDDj//jeP8rcHU7giE0/v1ojXoL1z8HcySnSvyJU1wtlBCEPWuRu2Ij6l9LKEM86CcdMiGQj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093895; c=relaxed/simple;
	bh=BLFs8kgw+nArrQg9sg4jclDpigQVJlrFiOMxr4KwRaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFGGzvrmLoxu9p3EewSFO9r5LCI6VUCAOxmDbIQ3SyMxXHKVxGgRvQPpDKMVZlvL7iC6fmUMeU9z6fYdTeSttq7T4WFJy79c1oSTNmeWKvmC7tl3/wSafBiEtAKHBs6Rf5dXlIuycmvNo1fb+WUMQZxXYcOGfZCPknWxO+SEZCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rZks45nm; arc=fail smtp.client-ip=52.101.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UM8wEmrlDfxRBuiohjz4RQajuOXlOaDKAa20ak00yC5Jbvk/mh4z2UyrnTiiu/w9v1HQyIPiDaLnrb4H9tINryt2G+Pkceeogq2tp4YGHzGlgBpHg/kFreTEqdmxnqztjo6njQiFqLj5LaK3eL7qo+BBZBtxajRHXgqmGlNykHqXB1muOSWTdojEBpungsmcV6yUpI8cFZ/+y3oyXT+rfpj+4EK4v+OlLPo9IURyKHAFx1rqVFJhKzj8FUHqI9JMPzYeo40DBACjVm/K89DCB/N6mWGT9/VprfhzrFiPXn5GP0BthpqqYeQmAHSsFsBK3AkY9wYA3tWvrpFBZWXzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaReQHK6QSPu5uMJTncAtiNWb1sGDGl4dBOfhAstCkw=;
 b=GGmQGOmktD5bY0mg6Rs2QQcHw6Hct3WcUxaHQ922ROxwhHX4Cizx3vUwwbGjNajO/i+Ci2uSjeM6unQy5RVuWLndIZenD3OYyUx0D+J1/Wi9uPDYjt85yNIve6pmXMDBE/4AbIqJvIy9Oh5cePnIIlP6MSN/WHiyhUDEFLGJ34DOoHH3tSUwPBmpc2bYmAhQEsSvARVX6b4zVwCrzEc4hAp7vkPJmMXkvVVNQCwnUjz+e4emGwUrs7Snel7/74hPA0DA9no+4liZ+eebsHAlzBHAGcKuyXfDjUzjI5IQ4BQhiI/P2CrAmJv+i+sc6g67ctonPuytDdiCIpYbth3Esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaReQHK6QSPu5uMJTncAtiNWb1sGDGl4dBOfhAstCkw=;
 b=rZks45nmHi27hqLSUuVIMqqA1gXTor0/Z0AAyORKoGBCy6u41YiG+lkEqxNckNoMN+agvfkpKQWx3TLmIBqKR4fSfJfTiUB4OlWi9helxLT+EUgrWOTsrqPecPKrHgbxbyY1lfwq3rg535RAF2ipFdaE4DOA+qiuDs/Kx7Mhzrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4703.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 14:58:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:58:11 +0000
Date: Thu, 22 Jan 2026 23:58:09 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 15/38] PCI: endpoint: pci-epf-vntb: Implement
 .get_dma_dev()
Message-ID: <536garhbuvs4cxwyiajoggdbjpoa4blpd2aoou2xbi6bcsqilm@7furekczlvq6>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-16-den@valinux.co.jp>
 <aW6UWJ6HLltjwhT/@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6UWJ6HLltjwhT/@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 26273b54-1b14-4bf8-c4dc-08de59c6a92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sb0QD6JQwAqz6S1q5gyC4VnateM7fp6UO7G5KklI527J9JEExlV7BYsAAIAg?=
 =?us-ascii?Q?5FT34xaIwkAKYOT+rT2E1HBf5qIPq0Bp4qgrYdEfWjuQAKx1mA8jB6x2Yug2?=
 =?us-ascii?Q?TCwhPNtiVckTubd3kjJqe5fs5gXwtM0W/LMeCF4cooR89g9zyCf0JZj64qSz?=
 =?us-ascii?Q?hSsxAe+zEYyFMbECEYi2VMPW06l0UraFmpcCT9oMkViOHPtjnOgbu6OBARAB?=
 =?us-ascii?Q?OWwGxCiXLVO69SvBncikx/qpAihNHOGxfPoiymCZbid2nlz67Jo+MGzYshqe?=
 =?us-ascii?Q?uqR5Y4zcfVK7RdeUs2qHTYJ287VIs+LMN/LBHreb11YRKujTiIN2EuVwkokI?=
 =?us-ascii?Q?CT1XDdY19tbfPLkhVxJLjoHqq54RAGUYliTToea72vVgdbSepvDrpi3os6Tw?=
 =?us-ascii?Q?1/INU1f1yHqDopU5qvjyGx1f15gD9DoZ5lwtEHBhMcRFZW4rTjic4dEvNpPc?=
 =?us-ascii?Q?LIIw2VIU0WxpWbjCPEId4MEdBkrKIh/GMW43DEgVciBvQ8PhuqNsYrtoHswm?=
 =?us-ascii?Q?p8jUJW7u955mvHkS8R4HtOoIB+H4nBcDsy/29bLl77NY72diLnuUhCJQC5Gw?=
 =?us-ascii?Q?2KRN44PIXQN1mKCoUQXEiYXAQreXJSxn/NOBPaWkWfiFUeW/av+SbgnbXgvA?=
 =?us-ascii?Q?xJKr3xtKKeeovpUVEV1HYWJUfRh5fRC6EMB3hJbVEAjV2EfbKNSBvALXxm/e?=
 =?us-ascii?Q?/jlaSa7Vy2K0ckpE71KASX8kMdEn42x/fsvLNKa1SAuIK1QGvD0IUMa7TVcT?=
 =?us-ascii?Q?idEb3ck5GcceHx0phF/b1cXT0wq3l1M1VIuBfoLcvz6yXfbbbkNkrVerFUmw?=
 =?us-ascii?Q?zi/Y0j/Qp1bcstV+owtxPPeA4cBPGLG1dUnhfJ0zRzqe66M5LRaA5ncHZTGI?=
 =?us-ascii?Q?eLvpU08LJkkpSMh8xg+5+yGPOClfCZc7l71ZqceSMM7VqI7fZptzfssz7wMe?=
 =?us-ascii?Q?71drFRYqCFH3FqE4hKYlokwLLFUEl2VHbidG+D+kaB15i2iEIJSDWPS2H6m4?=
 =?us-ascii?Q?LtQpV9aUyAVB98mWFI2hvO2Vawk9BsGuE1q9LykbC0P0hIyy4O4otS+IOyTi?=
 =?us-ascii?Q?re0kDczFYW2XQdPtSiOPpofnRMfrpc1VC2iqD+4OgEPGiBs5vb8hadIpZJLt?=
 =?us-ascii?Q?QvvtBpysprbvoVAMoCX8RqtyCvSUsYrqUkhcsUNjW59eKNqQbshPlTy6smjP?=
 =?us-ascii?Q?sIvGTIbM+OcnhS9jj5JRGQsRqJiVdbgLRcRGcuzUhGhenefMjsE7X/Y4WJcS?=
 =?us-ascii?Q?BLlYA37AMzTfqBfN9fuoUOo9ZXbPQTy4znfdOT9Xhrn/+n3hyRXbl/1kmRNg?=
 =?us-ascii?Q?498To9x7mWaH5MAvvP2ZYgABzwSYyVjZarkfgV3KchtnIBl/Pbgz3dEud87r?=
 =?us-ascii?Q?vM8JVtXbBu7hA9iPRHYaG/OicSkT9q2e33zH2/JrSfkd20mD5nCjm1Bfulik?=
 =?us-ascii?Q?bvhgqNCBIpdTAitrpV8CzcFBBaiIPWBwvYT414pLEG6Rlj5BZ4qwC4m+HOYW?=
 =?us-ascii?Q?UmwkoED6uMa2ocSj/f3iORkR0Sn69EDn1k2KUK9rD9bRvZYgFOCFevFx9UnH?=
 =?us-ascii?Q?02IjPcxK6OQaSKbQLW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDsnHtYHlqv6on1CsnsVr4HdqftndKRp8pkV0omwMV/TfKqjUo2bjU/00nz9?=
 =?us-ascii?Q?Zdd+gLZCstSwG3ZwpJBdUzDdCUd9nbrnwAZpgHCLDAH19cBLcpXPFVbmVfFN?=
 =?us-ascii?Q?GDz+o8ikLk1KKga/n6WhbnpEGHnKiD8ztEthoOcpv1SBpSfVjQ/biL+hpNwV?=
 =?us-ascii?Q?hwo7A7RB2s7Z8AKCqLW8uFzSrufEgkB5iHprNH6fNp7wVsLWCqtR7xgg/CcX?=
 =?us-ascii?Q?hwB7EcatpL4KZxJNmcbCGKbG/76iUVjfS9+3cIX3JsQNu7IsevD9gsrf42PG?=
 =?us-ascii?Q?bdhbyLVuGTxoETwUjGfAsgsfIgYGj8H1WWQwdCzF2xRMjL3XbgJZioJYig2j?=
 =?us-ascii?Q?yPweN64RiK6aqJz7PD/7E0FTnVI4a5uNPZCTxw4T14x3NN4oa5I/+LbOZZv1?=
 =?us-ascii?Q?jysChiGRNt68yXEyMqzNKq0ryS9w20upLkXpeC0pqsauxylaTeI41X5qcbMv?=
 =?us-ascii?Q?DH3k86h6EXVK7n+Sg+z/LYH+VkvGtwwOOt1hceKsOVhmiYOm8wgy012jQ61O?=
 =?us-ascii?Q?/3ywsxRpZk108MjLt6MgO3VHXai9W3/JjWgaqMkt4cDDH+fUZF/RK6av3MLg?=
 =?us-ascii?Q?v4thSjXP2y8PcxhJtXvsVDOul4KnmKYAXUTte8yd5ah6JwWVM84/IEq+vDmS?=
 =?us-ascii?Q?vk18TU9pQkw/0AJ9CJAgWM9N/eO360yuT8dy3hF8RnRa7JyMW5Vx74ABMWIQ?=
 =?us-ascii?Q?dCyFp1bs0lQ8KeCSzhgFyVEvJm6vvMJL2SB3ejiT9FMF5JCAviMzVz4pa/+P?=
 =?us-ascii?Q?sX6KKf8OPKDBy/XjoJzU5VEZBdo++MVLgkAahEN3n6aBibipKS5qDSLuN9gX?=
 =?us-ascii?Q?CYCYQOf54Pd7a4QxhyYP0t2M7YSXWUd93kkLs9oSBE3tR4TszD8SWaZ6Ae9w?=
 =?us-ascii?Q?of3QB27ZHVoC2soKIGnfdyhwWNLe8ddFbzmMRKVxLW+rtsJ3umS2/rihtbkA?=
 =?us-ascii?Q?omqXWxZBgCzGwxwY14Jt1RAwtXeJrnnI6oEe15VOvBgYEW5Dtqx6Jb2f26yE?=
 =?us-ascii?Q?rfVcxMt94tw2l58z+7hqLa67vgyq9kUIarA4GQaEszBnrXEh4VmIKo7PQtuL?=
 =?us-ascii?Q?eHW2WouFljg0FqBFqK1e5extaL57jAGj1hheTjDC2V+p0YTYvqzXF0Yo7tiu?=
 =?us-ascii?Q?Ome4DGArjyHfMlETlv30ZEzwWTu/z+GScbqegeHrbWbkh59BcCFErJzG6WVL?=
 =?us-ascii?Q?vkXFKZr6fXvmHgyUeGCPw7ZqGXPfeDfxvC1hkiRu/F73QjskAllouUc9fJxO?=
 =?us-ascii?Q?divIMt53VdgAY/XtMVfR4ArdSecteoU8JsyJazjI2gkzSpB3v6HtSHAIFocE?=
 =?us-ascii?Q?yZbK0Z4eRrLDNKtiqa5jbHOLWhs7A/i8024fOmrZbLK6++QYsJvbUS+NaqU/?=
 =?us-ascii?Q?NnaHl4Pof0zfiidAasVFVB0aAMfy2MhcI8bIZQTUrNvZV+VeR2tY6GpfZFON?=
 =?us-ascii?Q?3SmuKVUxxu+t2oPKFbjzOpL7wtr/hOOZzOpnvK0ce0Uy3aOLW067oPemRKrm?=
 =?us-ascii?Q?KhEh2iDlXMQkjVjXj12MlSJ+sooahwVjz0LRxxJ56Rs3x4NHGuo+4f2dllxi?=
 =?us-ascii?Q?a9bucMAY1vh+oLjVnQsaABY4BTle6NeV/iLhNhLbJTh8eBj4sItkicm4DaCh?=
 =?us-ascii?Q?VdqEwXvaILsl5LvGhasI9zdY9j7jjormzff9pIFpd4bia1F+LddCy+5cpI3p?=
 =?us-ascii?Q?f1Lgw61ICM8fC5JmLNTZc5RZWP1fSo6ocTmgdGmS8nrGTn3EbTCp9ADkUl72?=
 =?us-ascii?Q?Z545Kdl0Kda7dy4oVFCQEo5gfA5sh058/OlryDgzgge5uRfPD/+k?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 26273b54-1b14-4bf8-c4dc-08de59c6a92d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:58:11.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3PD8pexPCatHnOYZrsFdayUAes9Xp04ZGttaBTJjHfdwWimaGjIqrY/MhuoNTmEAz17zMRlukzH4QVaYBIxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8457-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[dfw.mirrors.kernel.org:server fail,valinux.co.jp:server fail,nxp.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D36569176
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 03:30:16PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:17PM +0900, Koichiro Den wrote:
> > For DMA API allocations and mappings, pci-epf-vntb should provide an
> > appropriate struct device for the NTB core/clients.
> >
> > Implement .get_dma_dev() and return the EPC parent device.
> 
> Simple said:
> 
> Implement .get_dma_dev() and return the EPC parent device for NTB
> core/client's DMA allocations and mappings API.

Thanks for pointing this out. That makes sense, I'll update the text as you
suggested.

Koichiro

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 9fbc27000f77..7cd976757d15 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1747,6 +1747,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
> >  	return 0;
> >  }
> >
> > +static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> > +{
> > +	struct epf_ntb *ntb = ntb_ndev(ndev);
> > +
> > +	if (!ntb || !ntb->epf)
> > +		return NULL;
> > +	return ntb->epf->epc->dev.parent;
> > +}
> > +
> >  static void *vntb_epf_get_private_data(struct ntb_dev *ndev)
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > @@ -1780,6 +1789,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
> >  	.db_clear_mask		= vntb_epf_db_clear_mask,
> >  	.db_clear		= vntb_epf_db_clear,
> >  	.link_disable		= vntb_epf_link_disable,
> > +	.get_dma_dev		= vntb_epf_get_dma_dev,
> >  	.get_private_data	= vntb_epf_get_private_data,
> >  };
> >
> > --
> > 2.51.0
> >

