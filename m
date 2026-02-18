Return-Path: <dmaengine+bounces-8960-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD4DNafflWneVgIAu9opvQ
	(envelope-from <dmaengine+bounces-8960-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 16:49:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F751577BC
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF95B300616C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4645341AB0;
	Wed, 18 Feb 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V5OHRL0M"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB990340A67;
	Wed, 18 Feb 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771429796; cv=fail; b=uGibIawoLFmgrjlMA6nel3wXy4O9Tpma25Igx6lAA+wVu+baS1h7Uw2dHGu880lHDWv4NtM2u49vlDx5jT7cuAqjjlmeHolPk2/nAGo7jrfO6HKiZETPqv3jHgCgTvemkkSzokjh9zJxW8oEZRcOmB7dvc4Uuauyw7x60Cc+kr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771429796; c=relaxed/simple;
	bh=Y13Yi0XeURiMwSqoovBhhqb6SwJvEYkZ7lG2SjB3hnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLvEQrvysvi+1veT2xWld1K1lbyazEEnzmOqM86sJvcIEDG9dbpF86ebvcfuOmqbaHRgM5gkD0A56HsXvKTT5+7pyOBBI3LgjklzuoxDucYgqn/DDrn0EpMfWxswrzJ3/kYGuQ8L34V2xc3ElRUYk+jTw3t02D1vr9MYa4JJuyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V5OHRL0M; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYeetmagOJTkmi07ltYCIKAFYK4iuZOzndelXW7J/pUmMrptZCq1oXEFBn+jzH/je6cK9CiM2o0X2jMpZk/Diur15d5P8eO9laOiVxhae894lyKYbTUCq/agpA5DOxJPX1UwABQF/OlO4+Rps5fGHY5ELCNLOh9P55Z4aCFk0jjW2n9CuksV539Ro+ywMfRzm9nF70Bcp+L8MgR7Y+oxKfcgxhLDf+itAwE8N/dPvFyzJCNuS00zxCvOIlWs5SdNcQ8XlBxlNkdKXgv4n+x+61+8CFWDC882Zj5MWJLJM5t9xl74cyagwtexf6ElxYP6S1D/0WXgzzslTOdUMeAJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct32sK8Z5yqiyltNNR3mN3VaG/ac7LHqJOnsWUEy/kA=;
 b=u7wXNzYaq/D+9IFcPz8Wrfh3FEn+QEMVvKooYZS8v1pGPAPRmov5wanVDyl4i5O9ZxFrePlzRCYSCe81SokadGFFgUmsWn+GeaZ7PqTRWxJJ4S0ZiuHKsCaPziTAbqmxovHRjfgsjy7jtk7SzCVMU6l+G6d44DZAtXPsqK3zEzDkFsbTXwopLCXSAV6Rlex7Wl2UvXqrP6brTiq4xY785mw/PUJsJio6c6VnRG9umHMoumMmhj+m7NwUhC9B+pwTSgmyJfniTZ9RgBw1906HTe/hHk06DNVt9KmKjxIR4HmjLTmi+XvnesAWbhG+6dAQg4inCM4bHDJjwum1pNxM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct32sK8Z5yqiyltNNR3mN3VaG/ac7LHqJOnsWUEy/kA=;
 b=V5OHRL0MDz64Xqn4J6rEzMAx49Gk/pNr3IFTBjkWairNne5xWtslOiin9nD9m3pYeFNBonMBu/nL7sAmJafCt3y6smWI29IqfoVkRJW1sZHJQuKMgCojDzUgePoOw3oK0b3Y8gDT4+ZEaYsCDZ4w2k38P7iQ0NUCpUnbRlhnIPq0sxE3ezFEp/JGzrsqiqyvR1q2UWuG9HXWUhpsBGte4MCcEZaVQxWbDiO3xflfEAZhvfw0wpmWnHfZcpErPCTQ5nv7amu5uxQu60fudZsy2HaK7JIQ7dp+ElxFiMIatVp0GpUGUhfueUxY3AD1C7Rsi9iqhxowRT6bvgM9vB8usA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6938.eurprd04.prod.outlook.com (2603:10a6:10:117::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 15:49:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 15:49:51 +0000
Date: Wed, 18 Feb 2026 10:49:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e85a0c5-b7b4-48d1-b5fc-08de6f0559e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zn/p567MwlHSQ1PppbRGWALaCbznzUK9COUMHAZJN/eqBj0pcgLoI49iUOZ4?=
 =?us-ascii?Q?FdRZmK//VtGQYhrso8qZapm4ARqh1dmdfh5J1jZnH8CMsLx0lH9ssAjKaGqd?=
 =?us-ascii?Q?yO+kB8ctTk4t1y8GmJ9ZTfFGAZT/ICgMs+ABVUWVlypl6WC+ErdF+5g+LCHQ?=
 =?us-ascii?Q?IW743hXqWIjgzm5/l++/Zmz99llkfbilO+q2n3/u/lye2AaYOdD4tEPsa2Tw?=
 =?us-ascii?Q?c7030o9R3Dx1ymBm9PtDC9+8MzRWJHMUqkwjid7hiX2v/U0oczgs9i96H6qx?=
 =?us-ascii?Q?/1n6aQ1JCM36pOSsQgia+oYDjV3yqoWbCAQ+5m1WvLQjueT6h9bYaNX8gvw+?=
 =?us-ascii?Q?+vJnBQ9X7GkzN6yvUkYt2oOLLSCgthAJrgBO8w6FD0Uq7E+F7Sc8yPVITLSD?=
 =?us-ascii?Q?wD9NF3nMhtAkl57sGqyCCpdHBskZ3qgxRZyoy0Kg1vB2N4zubk3UokxOrkRO?=
 =?us-ascii?Q?7FM9ONiLkLVZ9SeP5kBjvCy0d0zmKLepznynxA2TPjF/7maY7NISCmkM1AN4?=
 =?us-ascii?Q?wQBpmhbq0DjSQlxp7bdIGeY0/WDxbovipZfQglpFNef8sRK7Ko0TkxRW7Qna?=
 =?us-ascii?Q?uhodhsrrCyjKvdIj5eE8gYrOVLDZAmshDHpjbMaZrqTJo3MxLQN9C60q0uG2?=
 =?us-ascii?Q?1m8yBLWGsCk8o62bczzXFvdHIOk7lTJ41hIRwRJHFI9RC2pLYD/1j0NkB2ly?=
 =?us-ascii?Q?sVXUUgWa1aA4FljjDEaLt+rot4LzDG/HE9jE/D469qi7uDlTj7T53ui//Y3d?=
 =?us-ascii?Q?5SwLVZcMat4kglFzA5pUCal6DrUwMCvD4vAkS/gFfFuPDodCFQ3met+kqz1C?=
 =?us-ascii?Q?+q6lvDbI9d84DlIBk8x9i982S87PHr8ogOEWe1eLLrtz5fBQx2GOfHp8r0NR?=
 =?us-ascii?Q?YLPVn7PKZnqkMQMS/gvPxaS7W0cCAj17v8gPGnK2wSAwX1nspPObaCHR4gVU?=
 =?us-ascii?Q?tcsYIEoXCmaRM1+MKY35yfvzXkdxAwse6FJ69x4T3cb2rVZsU4VmoHBVBR0D?=
 =?us-ascii?Q?3YlLzqIrvKm4IqLidaB/tWnYew+xa5keKN3o/blDK7UyshExa8LGJnAOU7+D?=
 =?us-ascii?Q?eoXmWv7j2Yx+Kob1Q/MDP0hpRlEUpO3h7j1YbCEJ/20Ir3K+t3JcuU0iS2hg?=
 =?us-ascii?Q?yd1tXgZ4u59Hop6/VBqdlzrCbsTWL8rb1lRwjLL6FxZeq1D4v52snpkvfimw?=
 =?us-ascii?Q?9iFWr3uDuQuFsWt4+JEiHqtHP9XyjXV3bRGIEU9wk1KEwE7mcfr0NregIAlm?=
 =?us-ascii?Q?LJgP+L+GAGX73gESjzB9CtANMP14d433anTBFgXzS9gjDxs5tS8zKqE/MRxO?=
 =?us-ascii?Q?6SUi5tKT9b4ca8V4O+1UOcBBP3gdGcDXH8TiuXXmaeHtrcKiO0GpU9tXsPiA?=
 =?us-ascii?Q?G7o0xOfqAcp6cdSe64vG5+qXooJkyxwHxVqEopVEjH2B6TNDUYbHh7eNlzF+?=
 =?us-ascii?Q?a2kGaP53rMwgTwvelvtsqV0pt+3fN2Mj8l8WdGQuk3UOR3zi0mpxK/howoa2?=
 =?us-ascii?Q?8wpToEMlPwkoFcugzGOcKzddQcpua9xrCFe5+B8AmRnix7PR0FRJBWD6BhkB?=
 =?us-ascii?Q?6nBIKEHicGqikhib8niRI+eYXLrSps7oD2oOB0RGbFoFImg81BdU+QwOIwSV?=
 =?us-ascii?Q?cOYnjkZycGCRjELNFhKqv0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u9gs0TTnzLp31XprZBW2Uz2nP/BEm4ELfJ97anF9mTmk++IhyEqQZmQ5/Yo4?=
 =?us-ascii?Q?mAzkBg08YKIG3z3R0l4ezOG4SZoy5v3jtoDkVNnQWWwnOdj0Iuvxh4xb6AVN?=
 =?us-ascii?Q?6ePUa4ZVwR8ROZwG6oueu9Tj2tn/4l2Oosjwtl0d7BuRAj7bLRB1CjzSOZaA?=
 =?us-ascii?Q?f3Qbs1RmbvBxn82dxBlj2n+AvB7Z+/34L/dwuLwqmYLuQ1hljmXNpaYH5u0b?=
 =?us-ascii?Q?jZkZcHxoT4uIdoekQSvkcqV3K5jC1m5hH6MARWzCW03X1nJ1QhAXlIz6F0d4?=
 =?us-ascii?Q?nzX3SlbuwN72Ty18dphHszRONfAPOzImbrFKPvXYph2tWkbC+AIIaEMVsOiM?=
 =?us-ascii?Q?S6Q7JWwRRU6WYWAUGaboJCG+/3uUpACk4SZ6kSMMUh2R5yaNkscD6Bb6RGdn?=
 =?us-ascii?Q?P1etdZ5OrTNAZBU6iiOEsiTyDQRTQvT+fO2JUY+iyObrSp7UcS4B2xlMfnPi?=
 =?us-ascii?Q?WY260FgLfbeuDPqfBvm30jG2V1LH6amH+xMuaNUyi/6XKCOXaAUXdWOpWasP?=
 =?us-ascii?Q?AnBtUODy0Dv/+9NJzLll624yFfX/pn1UuJjkZVzoRNnWn6RMvP7Q4dEQkjdl?=
 =?us-ascii?Q?ZSV48jp9UrrOrLgTHuvJDqV6Sc4n1PEJOjC+KFcZ9tB1tyAT/3ATQsAQSyLs?=
 =?us-ascii?Q?Ma1jKCmopCoYl+gmdIAz3WHMBYHyXFVZcA7Me9erm8YwCtknfFhDfZYX7Oih?=
 =?us-ascii?Q?mc84R6kbYlxswyH48oYRTODIBtpWylxvbuzJp40qs6QDjrdfBO8Roi2f347a?=
 =?us-ascii?Q?+iFe0DysQfOC7ERmZ+FxqtLngkNghAFf9/bWPFx8hmng/l9aYU9z5zdNVSvc?=
 =?us-ascii?Q?ffiXmqAFf4r4htWGVf8YEV4CXMw5RB5uTwBMZWEWsvPUrQGerLAM9kgu3Fca?=
 =?us-ascii?Q?1ZK1zsWeLh2bHVovH74rpGW+0iCfIlPEQsT1iLMJo3ZwxWzygGA5vQV9Te6r?=
 =?us-ascii?Q?EaQ8akH71wOm9CUoUlGxfoRi8qIlkSgjxTErpqvX5lJWVn5X02QMZUTGFcno?=
 =?us-ascii?Q?nYZJFcK/eK9Yk2gk9vNiRzxKPXg4t0Qzjemv/w2oLpZnVkNniKquzrxspixQ?=
 =?us-ascii?Q?FxaA7/ZYzi6OLdjApsqtMyxf8gz2XqAbsITGCybdl3eF1CdT7VZxLO4FOoVG?=
 =?us-ascii?Q?mLpflSOKUQhWWCXj0JI9l+xLZIVUwm0PGzVx6QSgy3bUnYyFp6FOzad5divk?=
 =?us-ascii?Q?aCfpNvtHnUcYHN075ZKLpr0HW6Lz6J9V2d8X5tPzS5ytyVpZdJnjykAxWgIv?=
 =?us-ascii?Q?1QE6qOCZjt7PWU+4xVpk8dcIACyH+awLGMo5SxsfIuFEzzNXe+AmhEfzhFUe?=
 =?us-ascii?Q?jrK+mX7/qUcHkTbzSBQmHp8JI63Lgo5cUVToXc7hMHy9BRZrt+GsQlSfTnxu?=
 =?us-ascii?Q?kanH5EuCP6PT3mkzfaXwRKjEoKbi5O0d4XRtWUAqqDZGCe5EskxDphjd7KVD?=
 =?us-ascii?Q?zlV7ELGLZE4ndbhGXYxBe2FQ5iaOeq1e8yjKRf50/rU72tjWvzDCMywbndzv?=
 =?us-ascii?Q?7RJLkI3uTIP4nFT7mR+zXpXG/Xd3LEiBJcAUHXQgneCPicM54YW/98S4JiiF?=
 =?us-ascii?Q?AGZM07EAf8XtAjbRkiyMtYqzWJnDUvczfiqoVw/vg15legwsuuPmUIoDzDvF?=
 =?us-ascii?Q?PYXvc0kbth6XTq+vGhR4gf4TynvFfQScdhbpGox+SnMeFkhwVtsxAxf4fgpr?=
 =?us-ascii?Q?nQyiNM9bMRyzjzoxlSNviBgwNcNg0aoixPdvg+99kEAIaTLN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e85a0c5-b7b4-48d1-b5fc-08de6f0559e6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 15:49:51.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG5GxB1W2d3sTUEK8ZgVJ6p3URsGoBrOMJr33NTB6UKp0c2FyNrddBXT/tISKVNzMspNfcjL7z/tgQqEeIhfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6938
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8960-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email]
X-Rspamd-Queue-Id: 79F751577BC
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:32:57AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Tuesday, February 17, 2026 10:09 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
>
> ---[ Snipped some text to reduce mail size ]---
>
> > > > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma wrote:
> > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > > The current code does not have the mechanisms to enable the DMA
> > > > > transactions using the non-LL mode. The following two cases are
> > > > > added with this patch:
> > > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > > >   the device side DDR is not configured, then the IP can still be
> > > > >   used in non-LL mode. For all the channels DMA transactions will
> > > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > > >   is not applicable for Synopsys IP with the current code addition.
> > > > >
> > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > > > >   and if user wants to use non-LL mode then user can do so via
> > > > >   configuring the peripheral_config param of dma_slave_config.
> > > > >
> > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > ---
> > > > > Changes in v10
> > > > >   Added the peripheral_config check only for HDMA IP in
> > > > >   dw_edma_device_config().
> > > > >   Replaced the loop with single entry retrieval for non-LL
> > > > >   mode.
> > > > >   Addressed review comments and handled the burst allocation
> > > > >   by defining 'bursts_max' as per suggestions.
> > > > >
> > > > > Changes in v9
> > > > >   Fixed compilation errors related to macro name mismatch.
> > > > >
> > > > > Changes in v8
> > > > >   Cosmetic change related to comment and code.
> > > > >
> > > > > Changes in v7
> > > > >   No change
> > > > >
> > > > > Changes in v6
> > > > >   Gave definition to bits used for channel configuration.
> > > > >   Removed the comment related to doorbell.
> > > > >
> > > > > Changes in v5
> > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> > > > >   Comments follow the 80-column guideline.
> > > > >
> > > > > Changes in v4
> > > > >   No change
> > > > >
> > > > > Changes in v3
> > > > >   No change
> > > > >
> > > > > Changes in v2
> > > > >   Reverted the function return type to u64 for
> > > > >   dw_edma_get_phys_addr().
> > > > >
> > > > > Changes in v1
> > > > >   Changed the function return type for dw_edma_get_phys_addr().
> > > > >   Corrected the typo raised in review.
> > > > > ---
> > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-hdma-v0-
> > > > regs.h |  1 +
> > > > >  include/linux/dma/edma.h              |  1 +
> > > > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > index b43255f914f3..ef3d79a9f88d 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > @@ -223,6 +223,31 @@ static int dw_edma_device_config(struct
> > > > dma_chan *dchan,
> > > > >                                struct dma_slave_config *config)  {
> > > > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > +     int non_ll = 0;
> > > > > +
> > > > > +     chan->non_ll = false;
> > > > > +     if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> > > >
> > > > Need handle EMDA case. if mf is EDMA, need return error when
> > > > config->peripheral_config is not NULL. Or remove above check to make
> > > > code work for both EDMA or HDMA.
> > > >
> > >
> > > For the case of EDMA, the behavior is unchanged.
> > > Even if the config->peripheral_config param is set then it would be simply
> > ignored.
> > > This is retention of the previous behavior. This is done because
> > > device_slave_config has other params which affect the behavior of the
> > > DMA transactions, we do not check all those params and return any
> > > error. The error is returned only in the cases where particular
> > > parameter from dma_slave_config is used and if the parameter is not as
> > > expected or in the expected form. The parameter used from
> > > dma_slave_config for the particular IP type need to be known first then it
> > can be checked for its correctness. This is behavior for the peripheral_config
> > which is used for HDMA and thus error checked.
> >
> > It actaully hidden error. Your patch provide an option, which need't ll memory
> > to do DMA transfer. DMA consumer actaully don't know which backend used,
> > which is private information by DMA engine providor.
> >
> > dw-edma-pcie.c is only one of all edma users, which know DMA engine's
> > information because it creates this interface.
> >
> > PCIE-EP framework also create dmaegine, PCIE-EP function driver use DMA
> > standard interface to get dma-chan.
> >
> > if (config->peripheral_config) { /* only your specific dma consumer set it now
> > */
> >         /* optional config information */
> >         if (chan->dw->chip->mf != EDMA_MF_HDMA_NATIVE) {
> >                 dev_err("edma have not implmentent no-lll mode\n")
> >                 return -EINVAL
> >         }
> >
> >         ...
> > }
> >
> > Add EDMA support no-ll mode is quite easily in future.
> >
>
> This looks reasonable provided that HDMA got the support for this param.
> An error check can be added in the next revision.
> The addition may be slightly different as following:
> If (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> ...
> } else if (config->peripheral_config) {
>  /* error handling */
> }
>
> Using the above, if support needs to be added to EDMA then a check for correct 'mf'
> in the if() shall be sufficient.
>
> > >
> > > > > +             if (config->peripheral_config &&
> > > > > +                 config->peripheral_size != sizeof(int)) {
> > > > > +                     dev_err(dchan->device->dev,
> > > > > +                             "config param peripheral size mismatch\n");
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > > +
> > > > > +             /*
> > > > > +              * When there is no valid LLP base address available then the
> > > > > +              * default DMA ops will use the non-LL mode.
> > > > > +              *
> > > > > +              * Cases where LL mode is enabled and client wants to use the
> > > > > +              * non-LL mode then also client can do so via providing the
> > > > > +              * peripheral_config param.
> > > > > +              */
> > > > > +             if (config->peripheral_config)
> > > > > +                     non_ll = *(int *)config->peripheral_config;
> > > > > +
> > > > > +             if (chan->dw->chip->non_ll ||
> > > > > + (!chan->dw->chip->non_ll && non_ll))
> > > >
> > > > if chan->dw->chip->non_ll is true, It should return error if you set
> > > > non_ll false because no LLP base available.
> > > >
> > >
> > > In case the 'chan->dw->chip->non_ll' is true, then the default mode
> > > becomes non-LL for HDMA ONLY. There is no option to the user to
> > > configure the LL mode by giving 'non_ll = false' as part of the config-
> > >peripheral_config.
> >
> > This is API's callback, you can't assume caller do all correct things.
> >
> > > The configuration of default non-LL mode depends on how the IP is
> > > programmed by the user. The user is aware of the IP configuration.
> >
> > It is not true. DMA consumer don't know such detail information, which only
> > know which dma engineer providor.
> >
>
> For the DMA consumer the only option is LL mode as default mode. In order to
> use the non-LL mode it need to provide the parameter in the form of peripheral_config.
> Given the above statement, the consumer even if gives the 'non_ll = false', it is not going
> to change any behavior.
> Even if the user is not giving the option the assumption is that controller is in LL mode,
> unless the DMA engine provider provides the information regarding non-LL mode as default mode
> to the DMA consumer explicitly.
> In the case where chan->dw->chip->non_ll = true, following case may happen:
> - DMA consumer provides no peripheral_config param or simply config->peripheral_config = NULL,
>    in this case non_ll = false which is the current flow.
> - DMA consumer provides a valid peripheral_config (!= NULL) param but the value is '0', in this case
>   It is explicit but it would have the same effect as above case.
>
> DMA consumer is supposed to provide the only option non_ll as it was not available and LL mode
> is set as default for the DMA operations.
> When 'chan->dw->chip->non_ll = true' then this was added to make the chip usable when
> the LLP base addresses are not configured. Without this, user cannot use any of the modes
> be it LL or non-LL if the LLP base address is not configured.

little bit confuse, Maybe the same as you. I expected behavor

config->peripheral_config = NULL        choose hardware default one
					- 	    LL mode if hardware support
					-      none-LL mode if not ll list region

config->peripheral_config != NULL
EDMA: return false
HDMA:
		0			force to none_ll mode. (always success)
		1			force back to ll mode  (return false if no ll list region in chip)

DMA consumer decide if fall back to none_ll to continue.

>
> > > The check for non-LL option
> > > provided by the user is useful when LL-mode is default. That is why
> > > the value of non_ll == false is not even evaluated.
> > >
> > > > > +                     chan->non_ll = true;
> > > > > +     }
> > > > >
> > ...
> > > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > > index 3080747689f6..78ce31b049ae 100644
> > > > > --- a/include/linux/dma/edma.h
> > > > > +++ b/include/linux/dma/edma.h
> > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > >       enum dw_edma_map_format mf;
> > > > >
> > > > >       struct dw_edma          *dw;
> > > > > +     bool                    non_ll;
> > > >
> > > > Can you check ll_region directly? it should be equal to (ll_region->sz == 0)
> > ?
> >
> > Do you miss this questin?
> >
> > Frank
> >
>
> Yes, looks like I missed this question. Could you explain a little bit more? I am unable to understand the context.

you set chip->non_ll = non_ll in dw_edma_pcie_probe()

and only set ll_region->sz = ll_block->sz when !chip->non_ll.

Thats means ll_region->sz is 0 when chip->non_ll is true.

So non_ll have not bring new infomation into dw_edma_chip.

check !ll_region->sz, which should be equal to this non_ll.

dw_edma_chip is the exchange information between controller and dma core
driver. Needn't cache it here because you already save a copy in dma-chan.

Frank
>
> > > >
> > > > Frank
> > > > >  };
> > > > >
> > > > >  /* Export to the platform drivers */
> > > > > --
> > > > > 2.43.0
> > > > >

