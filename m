Return-Path: <dmaengine+bounces-8761-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNA/CQfBhGnG4wMAu9opvQ
	(envelope-from <dmaengine+bounces-8761-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:10:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F95F5034
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5A1C3010D86
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3A342EEDE;
	Thu,  5 Feb 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PiwDbU5+"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13447428841;
	Thu,  5 Feb 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307482; cv=fail; b=JGQ5aq2W/ak+agq+aWikTAKiT0l0vSPGLi8dnTgQMoRThsbzvGwCXJHPR6gR7YbZfApC0S+OnvJDyoUdcSJFbbTrJhOFdclubqilMYviIr4cIAJr/5FwqxYebkkBAVHMi6gqOgSeI0x9s9ISitGuOrpOPZDFUeTBp0UlYVlLGgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307482; c=relaxed/simple;
	bh=5MmG4So9kSW+bRUr4wBrQX2MD/reecwS89cxTQNyhw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IbSaVFj/nVnZiRjiO4EHHmj2IJ0rSlU6BanGeuV9aluYKzsv/+1umF3hvTKqnEN9Ib7BGh4Zgyt/X6l4sm9RYzdigmZfs9FKSr3wasj6Nq3MW1OhRA4j6jzVm0PtsGMRcdM9bxgF/QHUQPybSq9IQUMURZYld4Hz3qfVyMk+kgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PiwDbU5+; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+U+jBbBx6oMotJdF/m2UE+WdEM3loulSRJk+9TysrOrK2z+H2SYYrp6DR2gKzMFDdp+rfruEzTUiiVEfW4d3gNrAXrK/rWUIEpAUpgJxxXm1Ed9Fq8xTHnJxU5jqzEpFk9IFrjV65IpfAA7aVHoAlWfQaKmUEGUm2tfGLYMjh2jGZ/KElGJvhHVUqx6C4DNZbmsmdsFop7BMH6Dh8iULvapH6G8Vww45OaXezssekYLCX3jVJJnS9VZLvStGwqcd6xfRjbPJ/eFuoRDjRxj7CdKGMjlmYPisOz8Z6rVZPisMKuOF9eM4rXDEEiJlVxa+MBqO1Fcj4T+qlEZkZxa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvZ0mk/sLJBJeIQSLmKLH8fWMJ3DaSvA+7z5vmBTEgI=;
 b=VSptlLTtla36+C6sw+HqLf7bIfUKKcXjY+i397gJbyyEDZ555z5/PL5SgJaa3zzcBQEb17k+Nyo85NzsfpGS2amL0dzNm3lt8pNX/F95fWcoOwWSc3VWrJvSnfZHu60q35odhO6AAFMp6bPoWqDS/Wrm1q3oGhX9hRDyAHxI1y7668Q7HZP6SnFRFyFKSZZ/FJhxQdDOsqsvVpDfT86aIjvmuoFl+Y/0GXxI1l52h7EFWFwj2NMDTH+Ft0XFJrGQsG3XKuXbjVQCYOvrDxPlRGUWM/28t8//iLmQhaBo35qS7r6zi2lfPkw5QQaiTcxLla1uip8v2Z3DxK1K/pwblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvZ0mk/sLJBJeIQSLmKLH8fWMJ3DaSvA+7z5vmBTEgI=;
 b=PiwDbU5+AA85uYk3eomVtbQCRF4/YcHZnQTDoj4MoQ4rsRAxJvtmvu139ThVidaW0rcmhnACh+XkMLNQpUkL/V0F0lccevVjawf8CrHol2Jb1kAooytnIMo+KG8XSeJILkrDAmbc5uGA+b5iaNebqstMGm+bs72rrQX80HyOvjGYVRBOs4SU3hjuMkb623TrKjQ7dQWYjajz/BnYviCKmmrkY4pywE9LX9akRLbelr/M0e2kjQUETRlKPZLx7c3xJZFlc1iwY/8E0/VfgpGshm2kmCHR3tSqSSOfyfjQwOLLg+ima5x/7TCINHcxVEWdJm7Du9ANC7DmYpI57R+YVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9899.eurprd04.prod.outlook.com (2603:10a6:10:4de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 16:04:38 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:04:38 +0000
Date: Thu, 5 Feb 2026 11:04:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] dmaengine: Add hw_id to dma_slave_caps
Message-ID: <aYS_jsvr5c5ZMcXJ@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-2-den@valinux.co.jp>
 <aYOgV-dmeA8XjNyw@lizhi-Precision-Tower-5810>
 <f3byxj7aup6sixkxixtayamh4m6q3df77rweiawbmmtcsw4boh@vbfbjhufe45r>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3byxj7aup6sixkxixtayamh4m6q3df77rweiawbmmtcsw4boh@vbfbjhufe45r>
X-ClientProxiedBy: PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9899:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5d2375-1e53-46c9-19a4-08de64d0435f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9iopub7iYTZimdZl0KT33XXdkIcrzigo+9dCwrnDmjef2WxTt9qxC3bObZl?=
 =?us-ascii?Q?xh8wwfBTsCletWqHGJJ/2qiHIxf93dJSLjDa8Ercw2YsvdXW+ugXzAZw0Wku?=
 =?us-ascii?Q?PCmHRvPoAsGbEO9RRtAi5c75hnqcqS/81AeBSRqPlAqrOXXsg6iXjHlj43Hr?=
 =?us-ascii?Q?n64/KDDGl8PqSbOhvo5Ef1GsDGKCkiTZId3BpKTn3iHH1QHK2yPQfHewf9Jb?=
 =?us-ascii?Q?m3rYe9IKQPz+iQT32hgmQtq850Vs14Qw/gEvWReT5X0hO017beAcH2iVGfI5?=
 =?us-ascii?Q?GOJoZbiUAgOLf/RJsbSmezfY05u8osEsz5cYL6MUThszgudAJU2fvcp+MjCI?=
 =?us-ascii?Q?i1UPzxOQz5X7Nt/UyxyNJgpMITiZB67pDfqzLbENdYR2l3Z/WLQlNGvXjnhd?=
 =?us-ascii?Q?74TNV3ud4qbG+m2asGik/w/POvy0U4WlHDKzsXYSPq90aYRF6NbiRNrgyNnC?=
 =?us-ascii?Q?SizAb+5Hexf4WUyMEvJkogcUEE/ZuxFosid4vYkWW6kq9qhGyZ1/6VtpZlQK?=
 =?us-ascii?Q?YjrJpDCYnK0wi3c/KA7P1zwCnELu2cUV/HTyxXgPHoKiUxr3VVOGGghakOB1?=
 =?us-ascii?Q?2UN+q4Ns/riduWT+1khmswwOs26gG0a9YEqEW0tXgU9v7ouHkTFfeRkOvRvK?=
 =?us-ascii?Q?vkpPSQW4BbxOpbGqT5bZLuQxTfFwaUwglB9AYkLHctxj+eqIXI2aaI+XBE/n?=
 =?us-ascii?Q?jLq5BaBDtc53UFt7P5bNq2Ojgl6SsbQM3cTQ//+Jw+/hvZjjMOZFASmxbLJ+?=
 =?us-ascii?Q?aXIpABJASeXfGHkKLLBNI6tSYtX1LlEy8q9o/xjXEmPw3h0a+gpu6IzZ2B+5?=
 =?us-ascii?Q?Si02MyMZtu1iGv7lLa8dkN/pXM+sxEyTelzx0duZCzSw/PxZPf2BQxsOCsqo?=
 =?us-ascii?Q?YWv/Moj7JFkWkd0MVH8mo0LzES8VX09Xp2ysglnVqrI6ddHWh9PFUnFqzpTj?=
 =?us-ascii?Q?7TVECOvgbM43wOEyYAby77kGSQUULQGfHPIL3QiPBaOQ52mcVtDsU8kVC/hA?=
 =?us-ascii?Q?1aweO0Ta5kDV682xanPoP0OzkCyui7MJlkhQ/pchJPkOtOOPXxvga5Y4NLmq?=
 =?us-ascii?Q?peNNATSWyrjVWHPCkoqa224Z01itkT5Y7QX3GwYOvIynP2x7MX7Z9Wc2/Ne1?=
 =?us-ascii?Q?MM7TKN4DvhmcX50Eoog448vTb6rvvJ+N/JdaCmW+jZdqAt7PfEi3Z5nL9Kq7?=
 =?us-ascii?Q?RG7sGPxA89DYfSwWciZWXRP7CuriHoJ0+5nsbInUsgnAsN6YJDITs/jV+v0J?=
 =?us-ascii?Q?PdH6hY4Jua3E1JsGkcH4nhrn7G01W8nU1ClNDPzMcf+1yavErhO5wTtz1nEf?=
 =?us-ascii?Q?UCajb6LsLXbvLCvweQDEZmeJZRPWsnWq3Qib9Rg732HRMXz3DJ+YI5JCxzyX?=
 =?us-ascii?Q?91NW00AwlLpiwYKkH+VS4nk+hxbFF8c05AwHOAKf09oda9O+hAFIAf2+VXGk?=
 =?us-ascii?Q?tKBJnd+FIPsK7iFc7UN0Yf2IiP9TGjDuxC54s/jwylVkKX5ccW62O520ajif?=
 =?us-ascii?Q?TSJ+jypgcd9V963fgmS5iJVBVTbyMpA4vvDY5tkvzE4eTPs408IdF07+zcVU?=
 =?us-ascii?Q?FeRAGoYkd525un3kdNHNPQoVpZjUqwKySRF1mcJyz4+aFvNPe58naiTSwDGB?=
 =?us-ascii?Q?MHgyZh1OwmwMLOq2hj3BQ1g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRUQUcRSgNFdLJ/lzZhRl0GrPzNdvPrdgjLbwcVkAIEOl02oy0t8p/o10RRV?=
 =?us-ascii?Q?Y+MymA5D8yJoDMctn99s871cl20ss7FKGNSMKCI2iKaMRzPzzQSUCbRqT/c/?=
 =?us-ascii?Q?jbz8Pu24qdBGuqTE9f6c/dSaT683eWuyE0w9egnesA1ZtqgyhINNJfzfHglZ?=
 =?us-ascii?Q?cZycMCWN6Qhoi+uVklHUuC29GqwN+a7BrVdOot0ysF5PXo2xiiPOKanxTOio?=
 =?us-ascii?Q?OVTgHPNMB0rCfk0M/qLqwQNcVSOmFm4vhVQ19eNq+yZGA1VRL7wftlsICrY9?=
 =?us-ascii?Q?J77sFUV2uxw7qkts5+2Z03uFHmoNIZtbeY/M2jzCcGuFuSTmNUiqLDi7Objp?=
 =?us-ascii?Q?givr0VLGkoToDrGNVDExCL1iJa3Py1iDL11cLYmP8Y1ba7ROZGZrWqXuEESQ?=
 =?us-ascii?Q?eAzS9wb7Z6lvNq02GuA17Gcrcy7O0A01VMMwbGKK3Qug5dEx+iWij5bph3ze?=
 =?us-ascii?Q?QPLIkuPsGOfbc+vmoQdz1NKxbYQL2BfUHXrEUM/FWXK642fXuVqgdaUILU1V?=
 =?us-ascii?Q?G+0/wH1SzNjggXp3BLJFIsPgIPZgYqdZnzJjmxtE7Y2pfNPy3YgmZFD02+2D?=
 =?us-ascii?Q?YY20ckZboge7sqH9r0EppXqE8KTMmS9uOHQVtUXim+Cbi3Qev92qnwH29jXB?=
 =?us-ascii?Q?aWxLTZh8HURtWWKKSCewHGH7lrZDetSEkVMRqKYLCxYtkMNE54YgJqnDT8fc?=
 =?us-ascii?Q?o+lGhPG5N00j1v9dQHwhUea2Qe/708ufKIrmOA4nWwe6IjZpBW6KLxqNUm4H?=
 =?us-ascii?Q?gbI4qkSRpmd22qJnD2odJIQ88/kO2QHd4C9UmY+MJ+an4FNEs9PG+ntoAlDp?=
 =?us-ascii?Q?SyuknFyE5yeU5VLEXB78uraZWaPB9i8mt/APgxqi7+JreyY3FXzg+5CAJXIg?=
 =?us-ascii?Q?IXvZYx3RUGSpNJRCOUhoxJMj5fmHulQgbvakJX+2UwcdJcE6WtmHyjlwqNDL?=
 =?us-ascii?Q?bc87yI4+WRUrQfCQ0tzigtsarFIOf+Mk5hiOWhXA/cOQzbfiFOuAbHOSXLzW?=
 =?us-ascii?Q?1lqXIVzt81ma07lvxVmYMaQZIzcVlor8X/b8dw6G97cHXIoe4By0tibpCWET?=
 =?us-ascii?Q?YU0OmoLpZyaxncfdJjLBqHFGO+6gAELYdNuC85gwHByQl1VXjdj5CapkdKN1?=
 =?us-ascii?Q?fae90O2ojK8XmIxEPNuNKXaOWpNtoUgPso0fukATSgM2zjRIUSX3wygBV9bF?=
 =?us-ascii?Q?+ofGoSsA6Q+jYlZx21p86/sp3f0DNYzDX7jcdOQrH+eeI7bBPMxPi2thlZZJ?=
 =?us-ascii?Q?qu7qNOuS6vhpjJD1WiYw2wRwkqPcUrPBc3xuZka9PHhToBP/6k+USvxYUY/s?=
 =?us-ascii?Q?3Y/7cvylzePJQIu/Nat6u4P0qdo7vkxNnY9+2axDYkK0N1bOoR1fyF8JDr8M?=
 =?us-ascii?Q?vrdp2D8oQIX6OhtvRKW28F0jMT2vopognRhzFVl+EqPLYXxH4U2TyVKJpu/5?=
 =?us-ascii?Q?xHHekNuHaLrgftp/mfdBuyMRUpVAR1kWfSrfv+uvj7FGgLyV8fF0ArwKuFsw?=
 =?us-ascii?Q?TCyFZ5CmAiPOrDXscg0VmfpNLi9tIQi5mf4KkrXA8GKiMT2VYJscuI5A8z/t?=
 =?us-ascii?Q?qSVuM2Gh80JjESQ7NeaJUO1WYvNa0x9P1XhTMy+Pim8IlkrWd5g54WcB5rDO?=
 =?us-ascii?Q?yrBigNUaF4zX12JsbrPPFcDlo0GBN3y4GWSj2LBHqMSxgvs8B9N4ugbhW3hC?=
 =?us-ascii?Q?jC3Ci4kDn+a5ND6gCrk8mBwN9yZp9BxGU4PqtyzmU6thec3UMvGkIEoc6ZWc?=
 =?us-ascii?Q?J2Twyg0yCA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5d2375-1e53-46c9-19a4-08de64d0435f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:04:38.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iZXAK6qvIGSaKr+pGvaHkrZaPKpw1E5y6vMPybhT+3H1KDpqwL6tFzY66cXzOJN3y6G5N8nSwFs7PmNTGZHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9899
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8761-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 77F95F5034
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:46:37PM +0900, Koichiro Den wrote:
> On Wed, Feb 04, 2026 at 02:39:03PM -0500, Frank Li wrote:
> > On Wed, Feb 04, 2026 at 11:54:29PM +0900, Koichiro Den wrote:
> > > Remote DMA users may need to map or otherwise correlate DMA resources on
> > > a per-hardware-channel basis (e.g. DWC EP eDMA linked-list windows).
> > > However, struct dma_chan does not expose a provider-defined hardware
> > > channel identifier.
> > >
> > > Add an optional dma_slave_caps.hw_id field to allow DMA engine drivers
> > > to report a provider-specific hardware channel identifier to clients.
> > > Initialize the field to -1 in dma_get_slave_caps() so drivers that do
> > > not populate it continue to behave as before.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/dma/dmaengine.c   | 1 +
> > >  include/linux/dmaengine.h | 2 ++
> > >  2 files changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > index ca13cd39330b..b544eb99359d 100644
> > > --- a/drivers/dma/dmaengine.c
> > > +++ b/drivers/dma/dmaengine.c
> > > @@ -603,6 +603,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> > >  	caps->cmd_pause = !!device->device_pause;
> > >  	caps->cmd_resume = !!device->device_resume;
> > >  	caps->cmd_terminate = !!device->device_terminate_all;
> > > +	caps->hw_id = -1;
> > >
> > >  	/*
> > >  	 * DMA engine device might be configured with non-uniformly
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index 99efe2b9b4ea..71bc2674567f 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -507,6 +507,7 @@ enum dma_residue_granularity {
> > >   * @residue_granularity: granularity of the reported transfer residue
> > >   * @descriptor_reuse: if a descriptor can be reused by client and
> > >   * resubmitted multiple times
> > > + * @hw_id: provider-specific hardware channel identifier (-1 if unknown)
> > >   */
> > >  struct dma_slave_caps {
> > >  	u32 src_addr_widths;
> > > @@ -520,6 +521,7 @@ struct dma_slave_caps {
> > >  	bool cmd_terminate;
> > >  	enum dma_residue_granularity residue_granularity;
> > >  	bool descriptor_reuse;
> > > +	int hw_id;
> >
> > I have not see where use it? Does src_id of struct dma_chan work?
>
> There is no direct user of hw_id in this series. The intended flow is:
>   1. obtain dma channels to expose via the standard dma_request_channel()
>   2. get 'hw_id' for each obtained channel (with this patch, Patch v3 1/11)
>   3. call the pci_epc_get_remote_resources() API (introduced in Patch v3 6/11)
>   4. iterate the resource list obtained in step 3, and find a resource whose
>      .type is PCI_EPC_RR_DMA_CHAN_DESC and .u.dma_chan_desc.hw_chan_id
>      matches 'hw_id' obtained in step 2.
>
> By the way, I couldn't find any 'src_id' field in struct dma_chan.
> Did you mean dma_chan.chan_id? If so, it's explicitly a sysfs ID and is
> allocated by the dmaengine core (from dma_device->chan_ida), so it doesn't
> correlate with the provider's HW channel numbering.

Yes, I think it'd better to align HW channel numberring, we should extent
API to allow set it to hardware id or add hw_id in struct dma_chan.

hw_id is not caps.

>
> (Also, correction to my note in the previous v2 thread:
>  https://lore.kernel.org/all/zqcu3awadvqbtil3vudcmgjyjpku7divrhqyox72k43nfzcoo7@hflaengfjy27/
>  There I wrote that the low-level dma channel id would become unnecessary,
>  but that was incorrect because dma_request_channel() does not provide any
>  guarantee that channels are allocated in hw channel order: other,
>  unrelated components may have requested dma channels earlier or in
>  parallel, so the set of channels obtained by a given user cannot be
>  assumed to map cleanly to hw-level channel IDs starting from 0. So this v3 still
>  includes this patch. That said, since there are no direct users in this
>  series, I am open to dropping Patch v3 1/11-2/11 if you think that would
>  be preferable.)

I think struct dma_chan should carry hardware id information.

Frank
>
> Thanks,
> Koichiro
>
> >
> > Frank
> >
> > >  };
> > >
> > >  static inline const char *dma_chan_name(struct dma_chan *chan)
> > > --
> > > 2.51.0
> > >

