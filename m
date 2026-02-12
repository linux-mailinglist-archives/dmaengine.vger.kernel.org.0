Return-Path: <dmaengine+bounces-8902-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wObUBn4Bjmm0+AAAu9opvQ
	(envelope-from <dmaengine+bounces-8902-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 17:36:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A012F825
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E17E3028833
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656EA188596;
	Thu, 12 Feb 2026 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="azQGJnOH"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020142.outbound.protection.outlook.com [52.101.228.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2735D5E2;
	Thu, 12 Feb 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913924; cv=fail; b=M+q0kva4Ia6ugzoRMENxVOCX7LrmafvLvQHKMaJmxiW80rAX6DN0fm+LgG8kh84tI93N3otDY+98yFkiXFxl5jn4jvlUamHKEcUustIR3QLEn2/k0DcRr6BUt318Id1x7Nx2C24U8oOMOVNDvD3IGNihq84ATAPY+MAzp+ilS9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913924; c=relaxed/simple;
	bh=9e2X9tWYZ5/fPDdjzvohDapDypfOvde5ZFo8YjAtO08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXzzapN7Ro7sdL2LEziXljrwxLUIcleyWBKJVEliFzv61Zk8mkBW/7RpzgKEi7ALh4fxZ0xLCiC+EaXeivZ0VVZnJ5J61WI8KIJny2effQyj6mhCVzvHLXulx0q5Jev7JOnIkRi6Y1FL2BWUsz6wiLQJ3VxtNP16eWPMfQsmb8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=azQGJnOH; arc=fail smtp.client-ip=52.101.228.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akGekCk2KGsJPVRVA9BHViBkIn2nvyd0cRHfG0s/oUZD7Rz9d1y0ZUvhisDS6vWN0I3ZDrCJGYhnICgOSjeMd2qlKiMyExcsYFw1nMr07q1n5eT1mPOU0jVRt42O9BO+s5lr8K3CulLd+ZVQeeqj6P9Ux6DbaGd4vAZaff8WvU4bJNNkXGDTOPpfTIMlL5zBvE3IxYGMlfRP9I5movuBydPGbHfBcW7Xkjz+eZvtoSof2KMC0a3oEUFf5PiJA275aM6903KAXrpCkVLOAWz++uHV8ops5AsPJLLy9H1rY5HaH0iS3Q4VanA/6luZpUROd3a+HRKC9LJO+p6PEZgTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV81Re2C2i/EFoQ6TbPqR4zudq1ZCFw8Nw86Bzq5DIA=;
 b=XkP3LlgmxM1ChyLVude4/ookn2zXuqWo8B+KILYuz09OjNKkmUzrVbqHxAU0VEYDl2ajcdey1/g3o9pY/Wi6TvgXny2FppAx5xylchSyZL0bWrAvHqido/KB2hyzjnHpQ6vOa2qQkJTkdaRHgUn9+hB5Tw8n6dJQ7eX791RHgiLR5vBQok23K62PZz69i7oHmR6JHpHRpzqK9BSWFtqvyA9FAVt9CNCc18UzzmWIdUP9TDEeZzFCDD21r8nzPo4G8zATJ5CykyfybcwK4qZTB+vAJBsY8zQvpMFqQiKLujU4g+HEa2lpwB2N/c27sRLWBrWgF2fbNMMJ4p4cAyfEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV81Re2C2i/EFoQ6TbPqR4zudq1ZCFw8Nw86Bzq5DIA=;
 b=azQGJnOHnUwzDEj64GvctyEqYOeVaxDc0lh4kyV7rNXxKfohkuwG+VJDWI4qk+GuqcQ7TcZsfp99W2ZhGoghAdFKN76ebkn2AiQeAM7WFzJ/VoKDTtYDfgCfx4lUQ9vrCF4TFjXLQ0h8l3Q0/tHwhT3e3pKSIVPdKnlyPHSeKu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3538.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 16:31:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 16:31:58 +0000
Date: Fri, 13 Feb 2026 01:31:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <k76kwfqgdkcjkiyqkc7xj3a4iilyyiloi4yfz5zdrexgwg7n6n@72idb3al7uho>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
 <aYtdEnZM5mnmcgtY@ryzen>
 <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
X-ClientProxiedBy: TY4P286CA0056.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3538:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bc3f75-de4c-4353-6d3b-08de6a543e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYTQk51Bxa5YjI0jnW1gYlkALvjXKrqrKom92mgy+rmz3FdG/8lTQIUyqDOb?=
 =?us-ascii?Q?ge0jDIVqWj23tXaD+KSYDMTB7oGtJz6TZzqcsIxjGbI3HpntBhjmoyibGe8f?=
 =?us-ascii?Q?70NEhnekR1ncY9OuG17s4/jjjhEfKe0Zl/g5UVTS4fklq/vem0F3pKbIwiJm?=
 =?us-ascii?Q?LHxsSGO2UBe5vnMACtUSipCpaNYTn5DX42JsJWT3DhjJuHIULHFGZ0aOkXE6?=
 =?us-ascii?Q?lpfLvOqqxDkaYK6BZxf9GNX8qXHe8HnxthiJ1WdQdP5jWlR0oAy6xJ/yrqw1?=
 =?us-ascii?Q?UG5mbHyfMOXmzvklnZzVuIEmGiUHNOM6dubGeiUml/Ksb93dCARAYLF22T3i?=
 =?us-ascii?Q?1CVLIx92n/uIbisX4I44ZqWwSj8E78v+Jx/BeaW+stR2Hp6hB1tRAbX2m2JF?=
 =?us-ascii?Q?u5qz/V3BxOuFHwd+W9S4lwXM/mnwcqriaGFoGW/e+7eWNsER0R++BhDg9Zq+?=
 =?us-ascii?Q?iPVAifGTKxNX8ZA07vSBqWu66cEk4Sj4doU09W+MXtVlhJWXMF0fAeOsOtd5?=
 =?us-ascii?Q?uqWTDqFc1bfSHODtakAHofiKFF3/f3iJXetaOj0ospKWjgtq3KiU4CTaAiwO?=
 =?us-ascii?Q?AiMInw1ymXru9fTnH5IYSHcBBOMH1f0MXZoeQZ0tKDqjIaj6FeZZfoLWZftc?=
 =?us-ascii?Q?AnuEjg/8y8uPzld2riqdCdPh/+ym678Plwvrsi/RBneZnTju6T0eecY5mn30?=
 =?us-ascii?Q?Jzep75MCvB7JWgdyHh/PSchCpHddqg0dst/9Kn+roGP9QDnTzrgOT55GsSU2?=
 =?us-ascii?Q?fyfoRFVugDV5wVhcWxN74dIe6PsJVDKxxj0YKlt4IGEH8lF4BCPyjem6wCl4?=
 =?us-ascii?Q?oLB6xEB6j9E+j4j/YrzbdJzFBUdhj6WibKO2XzjHmiDuOhYea/nV1mBe9H5X?=
 =?us-ascii?Q?2sYLZmo2ziokJ9ciByrrX0WUdqTw1fY61b0IDNtLy7oMczp0aZO4TKSZcX5i?=
 =?us-ascii?Q?jo6eue4rHhYhfyss8GrnUt25NWxSdb8vHMBtExYpLAX2iUOgihn2pXqwNUX1?=
 =?us-ascii?Q?CxNFNUV4EqG810IYmSGNBke0H3cMCEMRNil5UR8tZXPaaqSITUs6qJCGRR2f?=
 =?us-ascii?Q?s7/8M0zDnN8KVMDd68WZMujdxiIkTWtsAxmaBraNnsXJllzpKdPextjGRXnj?=
 =?us-ascii?Q?54K2hgirNDyn1G27IiU1PgXUQOyGop4zT7Ga0EjcXKLNsyPJWnU8E+yYDeXo?=
 =?us-ascii?Q?djReBpeIcRpykC50dDyp3HnmcMJRvr9Lq0Ih4JS5yWJPV5Dh2PBe3ijfgXOx?=
 =?us-ascii?Q?TSbGU3eXHzHodhempWsCyVvif3NuTqsG0/LTKoGDyW9da97IIBjfCZTVpJaM?=
 =?us-ascii?Q?fw2CPoPmtwcCM0HglJoqJNKral6kPO79l4tTc7+LWnZGe6t0IXB1u50zFbiM?=
 =?us-ascii?Q?P+R9UTn8SxsJ7L3qv/RLfmfU2MBQXdL57u67nQHOmP4pUi8o6ttwxZbnhSrF?=
 =?us-ascii?Q?3CuBeGv8nIZPqUrHU3zDqmk5kmyrgPTGzaIdQuUg7dkG8nwTZWqbP1SrRPt0?=
 =?us-ascii?Q?QbVJC7eSqkVn4Iw1Vb+xfVHkjLHg/ndqJsviV57bC/u1pd6jZz7yszIIjmdq?=
 =?us-ascii?Q?oHxEuCPGg6IvDiRMmqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPD0oJ5qXZ353ak952VEgbZtadTtoVH8nUh4Pp0u+jaxasjkoGU0OXyf8yN8?=
 =?us-ascii?Q?2P4+/vBRMUKr1YdX0WRH7XIGlrbstYH/DtAXqWOiUkDyveBLUANuk2T/z0DR?=
 =?us-ascii?Q?7m+ahak8pnoZGgVRbg69ofJg73LmjwGKyQnbHlxAXoSO2Nhd9BWN+wv+g1on?=
 =?us-ascii?Q?Gw5+dRpFOLOI+u6ObiWGu01ktQVmXieOjLGRRstBgVTPFjGXgG1Bl0mvgaAB?=
 =?us-ascii?Q?L9xQDwu+eVqvpS4hErxeICDlOuVeqiEBYuGSea0AVPD/dRZRK6/n1ENj1Fhl?=
 =?us-ascii?Q?PI/DbH5Iit2Yl/LjiLEgqt83Ic9y78Ua3iVcEs93XyUngClzlbGrllxdWkuA?=
 =?us-ascii?Q?yRv3MDXEVyyFvCntz1rZHnenE8xwdq9QOqTymLvGYXlb1orElKwuvEfBRJLy?=
 =?us-ascii?Q?8Z5FIUpZ0e/+ctlDAm3gG/q2NKbysEzszhoLLT3jjAHM6e3QwMj2lVUqV8BI?=
 =?us-ascii?Q?uIjDIaiD+SfpwObhQpYpKHLX4Kt5ywXXoWVffkFw6wtNO0M57uTEanBPdrPk?=
 =?us-ascii?Q?3XRTf4JO83Z11h3e5RmH0jlFc0Kl/KjA5QXMPtdqsBequLbCi/sSEstBIxJN?=
 =?us-ascii?Q?OfFOBa5ahZrnzsmbXAWfNz9cc7gmdzIqBFZ3TxaN1YRBqST3GYb/hlC0jTFq?=
 =?us-ascii?Q?1DIW7VX81Eh6wr+2g96Y2MJbRYydhaDngsglSHRZcbG8vxRisYfLC1VY0zwY?=
 =?us-ascii?Q?RYmqRjOFEAWQhkK9Las6tU6BaxYZDTTBpM4HcarNiL7ZUlAlWlG7A86vDFzl?=
 =?us-ascii?Q?WS+NIqr5VN1Aq5gKTj26eK6uLh4n/kR97bB6tW7aYNis5hyJ+M7Tlnez9kK7?=
 =?us-ascii?Q?kIAqWMGkt7WwnW6zcyM4kFZGQnTezWEyMMxSY5CDI5uwMgMmoTHkbmJMJ1P7?=
 =?us-ascii?Q?9tRiHI+Oe90xbWPcEP/CBaBwrKWgwqGcMvU1y76jmBwSIFyhNjtLfbKW4c9R?=
 =?us-ascii?Q?CiObK79i7meCflKJEXOykd365xlzSN3GHpQJm9GDB4ZUFqdaRCAWH7mac4Dx?=
 =?us-ascii?Q?XGvcN1vgLTxgOV5I+g96lr+CuE4sr832BYDRTMByJfATnA1HqkMHbEPW4xc1?=
 =?us-ascii?Q?EyPzEbhzQDUAr6Etl4v7Lvb1ZU+2+bJmB5je56OjqV4CEiPWcda9gg164G5I?=
 =?us-ascii?Q?23pGgsXS/RKPigs3/OvXCUI4lEz11wf9EkfNoRrnglp3deusbg2vKTZtWczB?=
 =?us-ascii?Q?jsQ/4VnoPuZmTZ5fP71cOE8Akzchnx76dmYrmz/gRgS6OCCzr22bKE5oos3M?=
 =?us-ascii?Q?VIUIvUi2ye76EQavDh9ej0v2lORbGZNtU7e+4kQMERyGwKEMFnisAFcVN4do?=
 =?us-ascii?Q?bRQONGKmk7qUhVHRRctR5n4rTIYrijybhx51mDaUJDzwN45qtDvBiWwYEVIT?=
 =?us-ascii?Q?6FyL7XZA9mSHdPp+khKg+3H1i6/L2yNF/PDmuqBi5q+ZR8VrFbnI85x7UfDQ?=
 =?us-ascii?Q?00XNRBetCnz5xc7SepnfeB9lsv3nUjDNe9v9cXESBdtK5cySg+HPwi1DvoOJ?=
 =?us-ascii?Q?W5R/WZsihilfFkUZNH2aUNErczkPQDL6IfT3aYFkCMbzFeMVSVhOPSuMgri1?=
 =?us-ascii?Q?HuS8tySsqQSC4t2rArud8WOn5YoRl1amdP2wZimlpRETEDHm7eJy3E3y6nBW?=
 =?us-ascii?Q?hZzwiEYqJIYNAZUmJ0uXz/PdJKsXSmdbkggi2PctCtcfwImS/r2L3XWIB6dE?=
 =?us-ascii?Q?/vzmdf79QxvAwmfbJP/7PBKYTzHuga7N/FzItq3PdhhZ6cuc0oLzJjO23YKn?=
 =?us-ascii?Q?Zevue+ZovZYcSTbOmkbqGvfKdYbeIvWXrC1Qk9VTnGaLD7JWlJxa?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bc3f75-de4c-4353-6d3b-08de6a543e07
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 16:31:58.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PxbiGHjeRnHfx9dHEUW92Mw2i/50SmhM8WfWdJ8ZredzkX4O0GPRgwpjDZpKkXDqrXFfp+shOEgpJwD/a24aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3538
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8902-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msg.data:url,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 6D6A012F825
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:57:52AM +0900, Koichiro Den wrote:
> On Tue, Feb 10, 2026 at 05:30:10PM +0100, Niklas Cassel wrote:
> > On Tue, Feb 10, 2026 at 11:07:16PM +0900, Koichiro Den wrote:
> > > On Tue, Feb 10, 2026 at 01:24:29PM +0100, Niklas Cassel wrote:
> > > > On Mon, Feb 09, 2026 at 09:53:08PM +0900, Koichiro Den wrote:
> > > > > Tested on
> > > > > =========
> > > > > 
> > > > > I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
> > > > > R-Car Spider boards:
> > > > > 
> > > > >   $ ./pci_endpoint_test -t DOORBELL_TEST
> > > > >   TAP version 13
> > > > >   1..1
> > > > >   # Starting 1 tests from 1 test cases.
> > > > >   #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> > > > >   #            OK  pcie_ep_doorbell.DOORBELL_TEST
> > > > >   ok 1 pcie_ep_doorbell.DOORBELL_TEST
> > > > >   # PASSED: 1 / 1 tests passed.
> > > > >   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > > > 
> > > > > with the following message observed on the EP side:
> > > > > 
> > > > >   [   80.464653] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> > > > > 
> > > > > (Note: for the test to pass on R-Car Spider, one of the following was required:
> > > > >  - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
> > > > >  - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)
> > > > 
> > > > I applied this series on top of branch pci/controller/dwc
> > > > on Rock 5B (pcie-dw-rockchip.c).
> > > > 
> > > > On EP side:
> > > > [   39.218533] pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
> > > > [   39.219125] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> > > > 
> > > > On RC side:
> > > > #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> > > > [   40.297892] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
> > > > # pci_endpoint_test.c:279:DOORBELL_TEST:Expected 0 (0) == ret (-22)
> > > > # pci_endpoint_test.c:279:DOORBELL_TEST:Test failed for Doorbell
> > > > 
> > > > # DOORBELL_TEST: Test failed
> > > > #          FAIL  pcie_ep_doorbell.DOORBELL_TEST
> > > > not ok 23 pcie_ep_doorbell.DOORBELL_TEST
> > > > 
> > > > Any suggestions?
> > > > 
> > > > (All BARs in pcie-dw-rockchip.c is marked as BAR_RESIZABLE.)
> > > 
> > > Thank you for testing.
> > > 
> > > If the failure was observed in a scenario other than a plain
> > > `./pci_endpoint_test -t DOORBELL_TEST`, could you please try again with [1]
> > > applied as well?
> > > 
> > > [1] https://lore.kernel.org/linux-pci/20260202145407.503348-1-den@valinux.co.jp/
> > 
> > I applied that series, but I got the same problem.
> > 
> > I added debug, and the EP side does use the correct address for the eDMA:
> > [   26.279457] msg_addr: 0xa403800a0
> > [   26.279898] phys_addr: 0xa40300000 offset: 0x800a0
> > 
> > 
> > If I write to the msg_addr directly on the EP using devmem, I do see the print
> > that I added in the IRQ handler:
> > # devmem 0xa403800a0 32 0
> > [  155.861989] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  158.809160] dw_edma_interrupt_emulated:696
> > [  158.809543] pci_epf_test_doorbell_primary:729
> > # [  158.809986] pci_epf_test_doorbell_handler:703
> > # devmem 0xa403800a0 32 0
> > [  161.241326] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  163.466054] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  167.378662] dw_edma_interrupt_emulated:696
> > [  167.379045] pci_epf_test_doorbell_primary:729
> > # [  167.379512] pci_epf_test_doorbell_handler:703
> > # devmem 0xa403800a0 32 0
> > [  168.880179] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  170.492176] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  171.729154] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  173.481271] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  174.985787] dw_edma_interrupt_emulated:696
> > # devmem 0xa403800a0 32 0
> > [  176.517131] dw_edma_interrupt_emulated:696
> > [  176.517511] pci_epf_test_doorbell_primary:729
> > # [  176.517963] pci_epf_test_doorbell_handler:703
> > 
> > But not on every write....
> > 
> > I'm not sure, but could this perhaps be because we are missing this patch:
> > https://lore.kernel.org/dmaengine/20260105075904.1254012-1-den@valinux.co.jp/
> 
> Thank you for the detailed debugging.
> 
> I don't have a Rock 5B to reproduce locally, but your log indicates that
> the emulated interrupt is not always delivered on the same eDMA IRQ line.
> On RK3588 (rk3588-extra.dtsi) there are multiple eDMA IRQs (dma0-4), while
> pci-epf-test requests only epf->db_msg[0].virq (IRQ 53 in your
> /proc/interrupts). For R-Car S4 Spider, chip->nr_irqs == 1 and I wasn't
> able to verify whether my earlier concern here:
> https://lore.kernel.org/linux-pci/p4ommmpcjegvb4lafzecf67tzmdodtuqexeoifcn5eh7xqyp2y@ss76d3ubbsw7/
> 
>   > The proposed dmaengine_{register,unregister}_selfirq() APIs are
>   > device-wide (i.e. not per channel), so I'm not sure which "channel" you
>   > refer to here.  Also, when chip->nr_irqs > 1 on EP, dw-edma distributes
>   > channels across multiple IRQ vectors, and it's unclear (at least to me)
>   > which IRQ vector the emulated interrupt ("fake irq") is expected to be
>   > delivered on.
> 
> actually holds true in practice. Your report makes it clear that the
> emulated interrupt can indeed be delivered on different IRQ vectors.
> 
> One hypothesis is that: we currently program msg.data = 0 for the
> "embedded" doorbell, and we write to DMA_READ_INT_STATUS_OFF. The register
> field (RD_DONE_INT_STATUS) is defined per-channel, and the register
> supports interrupt emulation by writes, so it might be that writing BIT(n)
> selects the channel/irq line, while writing 0 does not consistently map to
> a specific one.
> 
> Could you try a quick experiment on the Rock 5B EP side?
> 
>   devmem 0xa403800a0 32 1
>   devmem 0xa403800a0 32 2
>   devmem 0xa403800a0 32 4
>   devmem 0xa403800a0 32 8
> 
> and see if the interrupt consistently lands on a specific one of IRQ53-56
> for each value?
> 
> If that is the case, we can make msg.data non-zero value instead of always 0.
> 
> If that is not the case, [...]

Thanks to the experiment by Niklas, it turns out that this is not the case.

> [...] then we may need to consider two less ideal
> options:
>   - switch back to the ~v3 approach, where we run the registered hook
>     exactly at the time when the emulated interrupt is deasserted. (ref.
>     https://lore.kernel.org/linux-pci/20260204145440.950609-6-den@valinux.co.jp/)
>   - or, require users to request_irq() for all irq vectors associated with
>     all channels. However, this would not be very attractive from a design
>     perspective.

So now revisiting this, in hindsight, this part (the two options) was
premature. I'm considering taking a different approach, like:

    - alloc a single virtual IRQ dedicated to the emulated interrupt,
      associate it with dummy_irq_chip + handle_simple_irq, and have the
      parent handlers clear the emulated interrupt (i.e. write 0 to
      INT_CLEAR) before invoking generic_handle_irq() from parent handlers
      unconditionally (*). Or, create a dedicated irq_chip and use
      handle_level_irq(), where the emulated interrupt is cleared in the
      irq_ack path. The virtual IRQ is taught via
      pci_epc_get_aux_resources().

      (*): Because the Done/Abort bits are not set by the write into the
	   INT_STATUS, and because a DMA transfer completion may set those
	   bits between the write and the IRQ handling, as I understand it,
	   we still need to call generic_handle_irq() unconditionally.

I'm planning to rework the relevant code for v7.

Kind regards,
Koichiro

> 
> > 
> > # dmesg | grep eDMA
> > [    1.243339] rockchip-dw-pcie a40000000.pcie-ep: eDMA: unroll T, 2 wr, 2 rd
> > 
> > # cat /proc/interrupts | grep edma
> >  53:          8          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
> >  54:          7          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
> >  55:         15          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
> >  56:          7          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
> > 
> > 
> > 
> > Anyway, I was still curious why this did never worked when writing from the
> > host side, even when running the test case many, many times.
> > AFAICT, the inbound translation looks correct.
> > 
> > RK3588 (pcie-dw-rockchip.c) exposes the DMA registers in BAR4 by default.
> > If I hack pci-epf-test on top of your patch to unconditionally return BAR4 with
> > offset 0xa0, it works. So my best guess is that the fixed inbound translation
> > in BAR4 (to the eDMA registers) somehow messes with the inbound translation if
> > another BAR tries to use an inbound translation to the eDMA registers as well.
> 
> Thanks a lot for letting me know that. I see two possible ways forward:
> 
>   (a) extend PCI_EPC_AUX_DMA_CTRL_MMIO to optionally describe that the DMA
>       MMIO window is already mapped to a fixed BAR and should be reused, so
>       EPFs avoid creating a second mapping to the same target. I guess it
>       could be treated as a quirk for "rockchip,rk3588-pcie-ep".
> 
>   (b) alternatively, clear the default BAR4 mapping on RK3588 at least
>       temporarily when using the pci-epf-msi doorbell fallback.
> 
> Koichiro
> 
> > 
> > 
> > Kind regards,
> > Niklas
> > 
> 

