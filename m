Return-Path: <dmaengine+bounces-8812-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oskPLFdhh2nEXQQAu9opvQ
	(envelope-from <dmaengine+bounces-8812-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 16:59:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055DF10673A
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B823C301049A
	for <lists+dmaengine@lfdr.de>; Sat,  7 Feb 2026 15:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA8336EC9;
	Sat,  7 Feb 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mkADJ2Q/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294E3358D0;
	Sat,  7 Feb 2026 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479955; cv=fail; b=S77tOzv5TiCmHw68JR1wQj/7ckAQkocH3ASO7d91k340xfudaH/8Rkar5uVW6f76OsAIbZIaygGGmp6s6mlIKzaVRpXrKJUBh69ZaFtRw2Ulxy+bB4sAmFTWG/oDilIQVH8xgVDzOUT8RW72un1pGOGpvl/0nlZI/mzumwryoLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479955; c=relaxed/simple;
	bh=p/+YDU1wv6N40aPKI8Y4Dbq+AYiGW6PBMUCthsLHti4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RXysXE9envf3uV3EsBYp6nSFzkDwvbFqMmjrstpeTAjHiyosVXTJSjFIgX8k8tDu6i/meaJIkisiFGMqCZDpqbH9L9xvjbbODiuRuRyzQ4u1rlZeDkYY1zA8bpDwdwgJzHqzdfwqQDZw3osgOgzMUCdubHPK4SJA/qyeNZ8+AuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mkADJ2Q/; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYeC1njGkq+J6x0RsxLdbmPHpxC9Mj6Vh7yEIc6FqZbaDwJh0uB0A5vGvbTyFyw6woGKQZ95/zFaAvICi15o9h339o2ccbQhq/ejMqiHTUtYk4g4PX78KKZRgplQOphdShOGqAWR1uiQZ3ziWp7leNXVt/+7OBiP8KLnCCi+ydkl8sJbjP8DYUPmSO+jEznhtPnfHS1/0+mj8anbAlLpeK2HFFRVYSIgwm+Y2CYamQ4EqHWwko2J0OKz5pI/5CitNTEorlb8/vEd95auE/kSJN48lBqIjqIM76HARx9qSuF4YOUbVsiyPuE2jyMGT8f0YkoG8jAUEgLG++QQ8wiYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M43Xr7TVOfNVwGtzQ4oRsXxmvLStACzJzQtMynjQoto=;
 b=Fa4eRVJNMWGDqKlK8LFJnYG6gm2tye6nWVYP9ezOBEFUCV5CD3GSY55BUjejiUgbNqfLAWWAspRbaAdAgzGOgL+Vo2tXKFC2MVJtOVUTdja7aWGsi0qDRJ0XNkFQxx7WUGlSiiAOSfNaKqVUIIj9ISTWCE7pt6PPBkyF9xtpoSqE9gfz3cvzECxCTwhsVx5Wew4thpGUHFVMr/wVR6J0xJpX8E6YnMYZzcNH67hl7DvpT8WUtz6gt5yQzb5yJ8wLCc1THUsLJpF31S5kbcptbHFTjh4giyAJhQ0S+m9eVlV0rfl3bqkYenmE49R68ihYU1b+ginB+I/n69/yc3w5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M43Xr7TVOfNVwGtzQ4oRsXxmvLStACzJzQtMynjQoto=;
 b=mkADJ2Q/uWnBS8gGk2dqAfd6c2FC+GqBrMcsW8jmzjMMjetzdSctcfgbPE6vYqapMNiv1bJclvx8FO+l1v38jbrfkdMrOT8CZNivC7aK5hfucN5r9rlIMmX8eWbXE2SDK2IVx+W0XwBiMIWTaKnB/kibMwIayvJYIIbDgsCRk9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2321.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sat, 7 Feb
 2026 15:59:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Sat, 7 Feb 2026
 15:59:11 +0000
Date: Sun, 8 Feb 2026 00:59:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] PCI: dwc: ep: Report integrated eDMA resources
 via EPC remote-resource API
Message-ID: <cuihp4wo5bcku75myq7mfbfvyddwptitiyy6pz5ldq2l6robxk@kghlibxpr7wf>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-7-den@valinux.co.jp>
 <aYYttmm9alHg6LAY@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYYttmm9alHg6LAY@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2321:EE_
X-MS-Office365-Filtering-Correlation-Id: ca317dba-1be7-4428-dca4-08de6661d59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AKEaxoC7ytANRw03oJjxXkzcExpjNylTpSU7JK/lROlL/Ng26gFsev7N4hhQ?=
 =?us-ascii?Q?kMI0oz6V9/zOPgfRqbfpLfVyI2KKsK03KfjLsGZe6LDECFG2nGqANo2MhfZd?=
 =?us-ascii?Q?EtF/O1yOwzNmRRWj71Vtrf2W3rN9xBHX9HQiWLovGxDtMnhdgCAtt+7qeyyA?=
 =?us-ascii?Q?kHf13jWXV+lJN0Ljk/Qn0o0jKRX5azggoyQ2LqNDWTTNUbdzPTuEWf6hfLSz?=
 =?us-ascii?Q?P9DyN3wcARUfpTSmAzGcJ1mCcBfSzKyNUorsFK6aCybNjRKkn+ZX/omYBaNz?=
 =?us-ascii?Q?eI0W5592MDhSUuE9uB+3Wb/357akzXC9VdvgeAB9GQyeGqKiUUpJKzckewj7?=
 =?us-ascii?Q?nSceDG0MULIrldQuytY8cR5mivxIXJudUr9EEo2Ln+3Cbte/ZnDzkf6uPLQg?=
 =?us-ascii?Q?SXJ9xxpD/Re7acbNFc/pfXpLehsFKi5WM94Nar0eU7JuezqtWj++8OnD3tfY?=
 =?us-ascii?Q?YnRmK0VZl/0mzfeu1O/wUU2vDnelMfOAWoChpzPQSeB27WgtKUEucr9u3ICy?=
 =?us-ascii?Q?tL5r29tbCfV2sIk6C7NXBGiLLTSEZrDhTAiJ2dyV0h+PDbI4UmcxLK/cjBHg?=
 =?us-ascii?Q?qukqcZceMHLIzzL2CnWBhIL31buvIg46NUicF1oIa/PKAg6MsfkUh4xCdQKF?=
 =?us-ascii?Q?nCBEaRVheEfnngJf+ZaznY8jhxPTvlddxZYQd5FkM7hYgnKh3LuxUus8cLcS?=
 =?us-ascii?Q?dE64nlxiujvkhBGEHg2F1QCPpS7XWswfvWoD83K6gUUh/fj0D8LCWBjeZG0H?=
 =?us-ascii?Q?7BuM4+vZiZ9saXo3lXF0V2xt4h42j7TGaKH2A+m7o/s5OHsPGovhPVpFFf25?=
 =?us-ascii?Q?5B6QSCLSTkMjvoRb9cQNy3rToTej4kIZrSUNyr8MQN+XymR7aAXWQ5c1tRsk?=
 =?us-ascii?Q?mDKJYkDus/FbiFpH1O9Ywd5fYyS2uDsxx2ypW8xqWLfjYTRy/kuM44GTZNgh?=
 =?us-ascii?Q?cdNlaEnClOswhzNZtKbWmLnAaP4brXeAg8raa/5G+2sQlxK4Wb6HEZO91s/P?=
 =?us-ascii?Q?dTCnonN2SnVtyXvgOJGCqClrBZo9oze3SFyOzBQrigU+OMKpZlYlMuIMa8XR?=
 =?us-ascii?Q?Ds6c08fGOtXnfGhcteMvChjwZuGfWJqMnFX6fciMkwKdBu1E+Crg6htYXIqZ?=
 =?us-ascii?Q?DoBQ+mmT7OchzwxKDcWtPKbygVsNMF/ZPd62Tu8D8ytCUbAQi8TKgol/Bwpd?=
 =?us-ascii?Q?mgjRX4QMcTVxWF//MTcTtD5+ZElIVDG7oCDx9n4f7LQ7rM5PHNlnQXzNu1Pw?=
 =?us-ascii?Q?PqOMLYT4XXz7P1/0U1k1PDlQY8GhzMJ1olef8Eu+29AKHj/vLANN5ZaW+MrO?=
 =?us-ascii?Q?IPQeTv7s5jF1/XqSkRV2RE1XG40PK9LzMrbIRjvToji3aBBTJsobLbK5GWMg?=
 =?us-ascii?Q?x2Vg0B9fPoNuSZ260xdzi74JjvPe2MXwDyr+9uTlnns2ZBKho5Dsyvr7xm4B?=
 =?us-ascii?Q?Uxp/FppKqKJ+g8xQe2A2WqMoLx24x1imSX1vyJ+hJpxO/eD32kx+FNcjivf7?=
 =?us-ascii?Q?1NPjUz0WibZRe/CuJQjlyciEA/ocDOp0JKMAhBn4BtWE/RIH1PYnathgNzbG?=
 =?us-ascii?Q?Wyy+nBGF41u9Y9uuCWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j38RlKLPlbiwaPJWI/pKan8k7ySJ43Pxmp7JvynMIoQzbDs7xIc2vfEX/e3+?=
 =?us-ascii?Q?+07/C1fOl24NtVXy2cgV04bTscQaIHxRzusLtKLC+focBWssQjCUy2lDTDUI?=
 =?us-ascii?Q?qyMlEX82Vy6gpVyNkPDo2SdeVJprJqfuiDhiIHnhlLGtkBjHxV0fc1VvNt1s?=
 =?us-ascii?Q?ukAEUZy06oV5XHhObs6OlqS4O//Kxy42gF7lQ1IzSIMruZZus/nD/2+RghEQ?=
 =?us-ascii?Q?fizge13gX0esPUBBaCnuDWxfGnuv3cQiWEIt3FlF+1WJ5EbLbsiJt7wwgfbm?=
 =?us-ascii?Q?V2NBML8qpmwrIIoAVOuSDbkBSrhRA8BWjCv8GSkvMpCsinoMXzAfyaOMZhMO?=
 =?us-ascii?Q?pAFEc361KSzw3A4nfNWfLLQ3UzfdnbUBv1gYHwAF2nCABaDiE9ZOmBuucf/A?=
 =?us-ascii?Q?de7ZCgyAX0sWqBdxBdCvZ/sfD6NTK5bNRP0bbXzeH4Rd4vhvzlgwFANnOvrj?=
 =?us-ascii?Q?jOIGYF7/p4ERTxRUfW0zrGV/UIpsmVdbrjNjp28MeeYxzl+iXPxaJQoQyzv8?=
 =?us-ascii?Q?kQIDjfP6LMWTQe0CsnkpxcnUVGOvAE08faEloIco1zdY9AKZb5Eoj3cdiHGS?=
 =?us-ascii?Q?tc/Mqy+WvNBNyJbq8JpMzPX5k6Yi4EFft8jq+XWwXZ1DEJmgVFm0Qpfdm5Ro?=
 =?us-ascii?Q?LVx2EuwbDKz306DwUBmbpRBrvtXioub5BA0Sf2wDcx26jRTFSzeDX09rx5CX?=
 =?us-ascii?Q?Sip9NZeD3n0We24tFxHjxvjofdpsMEUa63T0HklY+oEeWdrY89gRPWBz2HEU?=
 =?us-ascii?Q?bTphW6Sh/rhoSj0L7axDillpEh1tHHAHzGSQzXvR7lH5x6W9qqs9PPqH4nmj?=
 =?us-ascii?Q?bPAg49/b0ZMIHxm5M5DjDxqTPN1yNe7mAoyOBD/pWym4RBjTFpxign2IHFcg?=
 =?us-ascii?Q?PgnbO8eoJI3W9c8Z4xrgfK/2uQa4Wg0cSA5AU59KNJEREXK7EvlAKYW1CBBj?=
 =?us-ascii?Q?OBJWNWayUALhc3mGNXCqcA+Ro7O8zxRh3YHoKstbOAOd4EmekJeTVDZhBMii?=
 =?us-ascii?Q?xTlNKT9NIXoGf6TE6/NJKfjSiEk8QMkQxHtG3+AeQ0Pxewtstunem6FEjXQF?=
 =?us-ascii?Q?GfAZcShUsA9mVeOw83PoRqcyTkdOFwRMhTCHzEdcVa3zgzJJV+9sRH6w8v0u?=
 =?us-ascii?Q?dTHnP5tyPtnR9ZJgwNSp9ArCtNckjtGP3If7Qh8JRMWba2aH4SP//KYxUkAc?=
 =?us-ascii?Q?bVNYpJo7PJoFKihYnekKFmXmI0EIyI5nr3jtQ/+NCzfUWmZ0C/VlzJXQIRin?=
 =?us-ascii?Q?qxG+8fxUJTkLTOOPhLQrZNfNy7t8UeTa5mNWnfks3aNOe3PM2ZHohah9/Loo?=
 =?us-ascii?Q?yIFNvXVm/KI866hipjLNwmRfYy/WR43HAhUdlBsq9sp2I8Z+G3lwhpjGhPPS?=
 =?us-ascii?Q?GG/tkh3BBttHqfmarM4awnRjwLG3T89Kb3VsUD8IS9fnoI86RDvVYzbMpRT7?=
 =?us-ascii?Q?lpeKTQLPYCqo6C6BtmmyyEbD6NNxyHC1Y4ccr1DcqJeJmnMvFZ7RXsRZgUPi?=
 =?us-ascii?Q?8rFJWtuWnr8oJ9Qk0Ew6mwCrWtwaIwWZtipy51B6xd9+3DvVnoIN7Ho8Mxeh?=
 =?us-ascii?Q?B4kW+BLw7rl+Y6TgnYUmepwNr3H4qpD400lU3rw5EAxSETfrOgYrSkU1vwje?=
 =?us-ascii?Q?ZkC8SF6OH++idg2JC1cfhf/zdjdYmhQgbK6chfBbc874JqJfH3el6KErIeT9?=
 =?us-ascii?Q?CfiIuPr3vB6NQK93qErLvmHsuiOvrqxyTJN+Jn7Z82C0ag12TtUwo0cdVul3?=
 =?us-ascii?Q?e18cDGKBBP0Bd6WLxoD45cBDn9Xd8KjCNBhd7QfZtR27N+FFHbUV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ca317dba-1be7-4428-dca4-08de6661d59c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 15:59:11.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwoaCS/SThGgCceocCG9yOa7RRI1n+AJhdU4i263qaL5gdKyDqVYV+K7LhvnlO7wYXX1UDBp73qMuM6b17NByg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2321
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8812-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 055DF10673A
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:06:46PM -0500, Frank Li wrote:
> On Sat, Feb 07, 2026 at 02:26:43AM +0900, Koichiro Den wrote:
> > Implement pci_epc_ops.get_remote_resources() for DesignWare PCIe
> > endpoint controllers with integrated eDMA.
> >
> > Report:
> >   - the eDMA controller MMIO window (physical base + size),
> >   - each non-empty per-channel linked-list region, along with
> >     per-channel metadata such as the Linux IRQ number and the
> >     interrupt-emulation doorbell register offset.
> >
> > This allows endpoint function drivers (e.g. pci-epf-test) to discover
> > the eDMA resources and map a suitable doorbell target into BAR space.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 85 +++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7e7844ff0f7e..29dedac86190 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/align.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/dma/edma.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >
> > @@ -808,6 +809,89 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> >  	return ep->ops->get_features(ep);
> >  }
> >
> > +static int
> > +dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				struct pci_epc_remote_resource *resources,
> > +				int num_resources)
> > +{
> > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct dw_edma_chip *edma = &pci->edma;
> > +	struct dw_edma_chan_info info;
> > +	int ll_cnt = 0, needed, idx = 0;
> > +	resource_size_t dma_size;
> > +	phys_addr_t dma_phys;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	if (!pci->edma_reg_size)
> > +		return 0;
> > +
> > +	dma_phys = pci->edma_reg_phys;
> > +	dma_size = pci->edma_reg_size;
> > +
> > +	for (i = 0; i < edma->ll_wr_cnt; i++)
> > +		if (edma->ll_region_wr[i].sz)
> > +			ll_cnt++;
> > +
> > +	for (i = 0; i < edma->ll_rd_cnt; i++)
> > +		if (edma->ll_region_rd[i].sz)
> > +			ll_cnt++;
> > +
> > +	needed = 1 + ll_cnt;
> > +
> > +	/* Count query mode */
> > +	if (!resources || !num_resources)
> > +		return needed;
> > +
> > +	if (num_resources < needed)
> > +		return -ENOSPC;
> > +
> > +	resources[idx++] = (struct pci_epc_remote_resource) {
> > +		.type = PCI_EPC_RR_DMA_CTRL_MMIO,
> > +		.phys_addr = dma_phys,
> > +		.size = dma_size,
> > +	};
> > +
> > +	/* One LL region per write channel */
> > +	for (i = 0; i < edma->ll_wr_cnt; i++) {
> > +		if (!edma->ll_region_wr[i].sz)
> > +			continue;
> > +
> > +		ret = dw_edma_chan_info(edma, i, &info);
> > +		if (ret)
> > +			return ret;
> > +
> > +		resources[idx++] = (struct pci_epc_remote_resource) {
> > +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> > +			.phys_addr = edma->ll_region_wr[i].paddr,
> > +			.size = edma->ll_region_wr[i].sz,
> > +			.u.dma_chan_desc.irq = info.irq,
> > +			.u.dma_chan_desc.db_offset = info.db_offset,
> > +		};
> > +	}
> > +
> > +	/* One LL region per read channel */
> > +	for (i = 0; i < edma->ll_rd_cnt; i++) {
> > +		if (!edma->ll_region_rd[i].sz)
> > +			continue;
> > +
> > +		ret = dw_edma_chan_info(edma, i + edma->ll_wr_cnt, &info);
> 
> edma's information is what dw-EP pass to edma driver, supposed dw-ep know
> irq and HDMI or EDMA's information, I think needn't go around to EDMA again
> to fetch this information back.

Thanks for the feedback. As I understand it, yes, dw-EP passes information
such as nr_irqs/ll_wr_cnt/ll_rd_cnt to dw-edma, but the per-channel
chan-to-irq mapping is decided inside dw-edma. The doorbell offset is also
derived from the dw-(e|h)dma v0 core registers.

To avoid having dw-EP call back into dw-edma just to fetch the mapping
(i.e. get rid of dw_edma_chan_info()), we could cache the per-channel
metadata in struct dw_edma_chip and have dw-edma fill it at probe time.
Then get_remote_resources() can just read the cached values.

Something like:

diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 53b31a974331..83503aacaf5f 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -88,6 +88,17 @@ struct dw_edma_peripheral_config {
        enum dw_edma_ch_irq_mode irq_mode;
 };

+/**
+ * struct dw_edma_ch_info - DW eDMA channel metadata
+ * @irq:       Linux IRQ number used by this channel's interrupt vector
+ * @db_offset: offset within the eDMA register window that can be used as
+ *             an interrupt-emulation doorbell for this channel
+ */
+struct dw_edma_ch_info {
+       int                     irq;
+       resource_size_t         db_offset;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:                struct device of the eDMA controller
@@ -124,6 +135,10 @@ struct dw_edma_chip {
        struct dw_edma_region   dt_region_wr[EDMA_MAX_WR_CH];
        struct dw_edma_region   dt_region_rd[EDMA_MAX_RD_CH];

+       /* cached channel info */
+       struct dw_edma_ch_info  ch_info_wr[EDMA_MAX_WR_CH];
+       struct dw_edma_ch_info  ch_info_rd[EDMA_MAX_RD_CH];
+
        enum dw_edma_map_format mf;

        struct dw_edma          *dw;

Best regards,
Koichiro

> 
> Frank
> > +		if (ret)
> > +			return ret;
> > +
> > +		resources[idx++] = (struct pci_epc_remote_resource) {
> > +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> > +			.phys_addr = edma->ll_region_rd[i].paddr,
> > +			.size = edma->ll_region_rd[i].sz,
> > +			.u.dma_chan_desc.irq = info.irq,
> > +			.u.dma_chan_desc.db_offset = info.db_offset,
> > +		};
> > +	}
> > +
> > +	return idx;
> > +}
> > +
> >  static const struct pci_epc_ops epc_ops = {
> >  	.write_header		= dw_pcie_ep_write_header,
> >  	.set_bar		= dw_pcie_ep_set_bar,
> > @@ -823,6 +907,7 @@ static const struct pci_epc_ops epc_ops = {
> >  	.start			= dw_pcie_ep_start,
> >  	.stop			= dw_pcie_ep_stop,
> >  	.get_features		= dw_pcie_ep_get_features,
> > +	.get_remote_resources	= dw_pcie_ep_get_remote_resources,
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >

