Return-Path: <dmaengine+bounces-8842-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBs1I+fYiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8842-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633010F2B4
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF39F3024133
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334DC377571;
	Mon,  9 Feb 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fOe1HSJx"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CC377559;
	Mon,  9 Feb 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641604; cv=fail; b=DZsQzh5G65ZdeoksecT8O1TR7EL+KDPpmNAH5yVnGZHWKzpKcV6HjUO8KGVp43saDHMxQxy+WO2+D2H/8N/Jlloj3ZMa+AKjAWowwgYcgNf7efe5UP7gOO2/yE/lDsA1DxWW5LadV7hgfBhlLGevglsMmvJ7tih7SZUA1tTgSas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641604; c=relaxed/simple;
	bh=RuEu5ELvxMj5sc6sxKixNVeRDRkAahwzkDV43tCtMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+SdoBX4d3cg/TY3/7zQUWDuOWBLdq8ApIWMtNIm3j4HNIw6Mvu5QLLJR9/LHNKAxYIEaYyVdmoABICRpDKXiwMpjioQ+QEwqbqg7VMW0Jh2SQXzbnH8wqmARpoxC30vxyVvR9o6wkj2XrAx2/OEuLKzMzPnlQ+6g300lh7NCOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fOe1HSJx; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef38vF5eQTvzc0uZ/5jpf33v/iYGZXm7lvTt91eNZalCWy/Yg0NHvz21xRvLYvaQLcyBDbyC2Csj+5nHP4Dj3/ccJluJMkJbzOXHYoV5WcLbBihky/Hr45TcCNYX6HlCvXM4jZY5OdBIsGat1LdC2iKjMyPvPbglN5mz4AtcUSNZ4LLNLCDgcExL7u3ofkjpJWc53UzM4GRRRCn4fw11N78xFm9crq08unLUwYqCO5SzTXx2XZmD+ETXW1N5kH2TFPaYzU2b2aHWzSsv+VQ/SQsTcVVfvHCNuIe/RwO8yR1owRw5grJ6WcDOn4hiS9bMH8pib7HlxFr+BnjfaT5/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMsq/VHFkA0P4T3E98nvet/M9krabS6F1m1j/RtHSWY=;
 b=qnXkkR3NPfNuxOAQdDN56PtXicwnvR8q6WnBv0K1whuPlF2rVNadUac/7c1xGFTzf13Nl5UuGf/8vZbX0fn2E2DxdjnBmuLnYuZUuo/Gh0d4Vt9htgZo6E8YlziI5fNvJPfCiZM0MTiKaN4mfhwbE6nnNq2zygB1H8hqfm5NO/MK4fvfIVd/R/LnVVW4WlXOX8byKrdlmQX8F7351eUWXLuy36zGbKQkC6L8xgjsmSF8BRItfud6sn0uLq97m6PdMbJ+R6RiHU/xMiF+8RwU9LptJAi3CCVOjNTkgRWsGlkNz/OR1v5KTNX4SkrgF4QnXlr2L3tTcCAfV8FnQZuUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMsq/VHFkA0P4T3E98nvet/M9krabS6F1m1j/RtHSWY=;
 b=fOe1HSJxSbQ3XrKMa/X8QVXecnTP1YNFkq2z0OjAFUfkdmgDjvrWTkFUxjkMGkBmMWg8QUaHuUxSiqQMr0NIvl6hgB9NV8kavYKTMz6rJ3gmWhKNATEFWvEUqudT0VR8NaFhpxsB0H/W1tUd5xpHNEe5oYsUtE47X8Zca+shgUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] PCI: endpoint: Add auxiliary resource query API
Date: Mon,  9 Feb 2026 21:53:11 +0900
Message-ID: <20260209125316.2132589-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:405:3::22) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f4d9c1-3fea-4cd4-2730-08de67da3470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2iJC6mdFuL4OByKhcOCbV7DgF+5nNqMEXq8oWe96sqSmF71mlBJrLmPz+k4Q?=
 =?us-ascii?Q?/6VK218Z1ABLWZofP1CZ+FU1YDRgTVeqNNWUDZRpZdia9i3RHlOHs64cwbbT?=
 =?us-ascii?Q?0j4KiiKX+QN7Uz2tLamEIe7Nn0uV+aJXjhtcVoGnA+h9JRlAD3n35DCULNqh?=
 =?us-ascii?Q?R3b2Flslw8tgPEeQ7FfuNr31OXGd4aJ6+I73IDZhUf4hkfytghxkhAQu2jvj?=
 =?us-ascii?Q?GyRdM7i5oWWSkcmFoaSvtaiApGdaDxhNaai5AIQQZmo0P95TrGNnk5Mqrjqi?=
 =?us-ascii?Q?PiZzut6TUwks61tvDz5VI71kQYF6GVjCHsgleo0uXBI2snRaSD420jW7AZJk?=
 =?us-ascii?Q?SV8zzhlMNgWONNpp+AdHvo9cOQx1xcnGkorziNuWMoOvlbZ/m7tWLbL9hYMf?=
 =?us-ascii?Q?IGTk/fFBthjqIEmn08tFZrXO7/JNaK6+Yrc3Jy9QU4HMolw4B/IrtM1H+M+a?=
 =?us-ascii?Q?CvRqWUcbhjPBznQep7oS3GvYTQJYpM9atUjpSX95oiKtSm2EV7PiKV1dIYj1?=
 =?us-ascii?Q?blTvSCWkysqvEqikEzXIQSoRbv429l2i+2pe+TyJiZAPP/031n49rRKMn5gQ?=
 =?us-ascii?Q?ZlxOJt8y9RvGIa1SsHxDAivJwMjHK4P/KOrcU5C0SOAaHunYH1v+yKuUdEHH?=
 =?us-ascii?Q?ID2yvWLJdId6C8VJatvi4RGXZAcPcLdu8EyUKPD3n8bdDWbk4qKnIzUwwt9O?=
 =?us-ascii?Q?Ngk96hrdNqHBEbnCrskZWECVef8eg3nxDEb7VcegkKV4/xO0NI2t9hw3gALh?=
 =?us-ascii?Q?lsOkcU5OwhPesl8qW+uRdPg3XqoRfK8RaAUxFtPZAk1zmeXxDZTozT0Y4eYb?=
 =?us-ascii?Q?NC+GcKX5mQMCxKKPmQhECEpOhFDKt6bl5drl3dTiZQwdGWaOg0/PnGcSS91T?=
 =?us-ascii?Q?SM5pmQzkUKfrFTNL0WMzhDveiP3yfLYDlgf8WMrv0llU9eZMgVuq8HneTm0M?=
 =?us-ascii?Q?AFjPxddLqdg03X7ZCWn9CI8VDR1U3Km2tI36m8vfAROrPA+J4ifUQDdDlthj?=
 =?us-ascii?Q?+0TValHLA8JMdKixNkPVy4MTigiuXopVCEkjg6tuyTBoWr1jRFLyCFTy4V5L?=
 =?us-ascii?Q?ExSl5YMUjNFazWtNQQEQ95rauGoB2UbP+pIs6MujAzzVuh539kkL5TJwgopS?=
 =?us-ascii?Q?tZn5qTEbuPVDCylsYJLH3JoARcuDU4umm2hhFhKEayfHie/YLef+OUXIUjBh?=
 =?us-ascii?Q?8J/eZjKZ7NHG+czMDuf5IvsHJxubrDdBGWPNocC4R1mnESwUNz67i7EOQNi0?=
 =?us-ascii?Q?9ZTS7qTsdXtj3RuBoN6hRPhObhqZNHQKc17w5WYAMkJpMMEfuA/lICsqHPUW?=
 =?us-ascii?Q?FUfW1oTy0H3plFc5Uoa3EoE1NvdJuY8iCh0lZvH//t+H6xhSy5oIFAZWC3zv?=
 =?us-ascii?Q?6Wvl+8DGLo0eSahAX9586OscBdyK60+Rj1Eu0PlcbdkB4tTgq0HvrRgftx3+?=
 =?us-ascii?Q?bMT3RWyfqvh+DR9hkQbiCH/iEESLpPtqUVwqQj/9x8IksVNiXVl51eU0wgy4?=
 =?us-ascii?Q?KHpzXx5bZIbL4MORkoYcpywHTPyWZRu84D+Rjo30eaDOZpU8c7Ls8u9rMW6k?=
 =?us-ascii?Q?vTaZH+TaoVI9cu+EUjr2py6gryeN2GGX/XUBTgl14AB2Gt6jGxlUVsfctYKc?=
 =?us-ascii?Q?KA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ImRJvnx7AYtqHf20QdzpafHvX5ZKf/HL1yrxaqpWrPm93pPbf3T9cirHBtnc?=
 =?us-ascii?Q?zk416AX5WFr8IR5/mjlMJwfIqYgEJzz12FnejrpIqrdFawtdIrCo5S6c75Ic?=
 =?us-ascii?Q?OaYd3ZXJH2hltNrOFAbgyTD2MzKEp1RLHGDFO3jOwspjVmUecsLdjoVwBoRj?=
 =?us-ascii?Q?PJtegfgJjJhpOKeRgTnqnvM29Otlq/5MbpsOvezCecPurcMC72nW05tR1w7e?=
 =?us-ascii?Q?u4121HqBFHAsq/wqHa5oXhLdOjk8SsNG+82eBEVOckffFqXx101Jr0+CyI9N?=
 =?us-ascii?Q?qbzTd9DcYjD+DkpZBhJHmDCCbY5F64rMLtM0bKMw3NiloylZwbWRgFIiucv+?=
 =?us-ascii?Q?urkXqf6j6aZUt0ABN4eU8ZoRyH7n8MA83QKyw2lh7I2FJNWIAID3O1JtlPrL?=
 =?us-ascii?Q?lf/EBhCA9npM5dIZIIFGWHgF2bygNMoCwuf6lIhsGMIMHQe+YIT4ulwV29fG?=
 =?us-ascii?Q?62X0PG09G9sPVM8Js4iJ4vVnHe0dy74h7joko8XojNC+IL5DySkp3N/et3fU?=
 =?us-ascii?Q?BZiZ367b2ci5cwdXZGaIjZH6K+4JbB47S8Bg+7xEmBgVPh+xp1wIxhYyVU0G?=
 =?us-ascii?Q?zXqQglwCMC6TfkPS2xak847pZHkbhfbU5vVTd9aiG9pxkk2lcQ3d03n358mV?=
 =?us-ascii?Q?ju3HPKOmsZROTrcOBid4J/LZq+krKG4G+VyrENS0NwkV0GG9pGC3phFGImIQ?=
 =?us-ascii?Q?VJC8JnhoAPxseeET7tn8lU1CN95mOtFXZ5eABwRTLHHFrxkJGb4Sz5JC3Gw3?=
 =?us-ascii?Q?Gkcau/NvpCcx7Pse7GRudf9kY9XBQvI28iB+VnfLzRBZMDPOl2TqJVzJafw4?=
 =?us-ascii?Q?SEYH5YTGySgxf+wHJXePE8LVO5Ug44vWDWv0DiFmd42kI9WgvoxAPDgJYGw3?=
 =?us-ascii?Q?kuj34Lp9FnFQs54aKJ7Sodl3hPGm8ylr7UcmXXxAKArxYcYbbK1fVYe3Armw?=
 =?us-ascii?Q?QP4zYDp14YOPCMEih4+wRI9sLGpY8ZpJxbEWgltOobG5m+ClbzUimfRQFNz1?=
 =?us-ascii?Q?qQfhGYHCVqPHVdFZyxGkVRkactXOuni98kZit5/2+8Pn40z0iKrysDWjCvyf?=
 =?us-ascii?Q?U/LIgydw7ZzhCzZ3IPTb/Kpn2tx2B9c+4YNErSrz08ZUuZk2+bohudR8rKkK?=
 =?us-ascii?Q?T9HD8NeuDrVXUeURvUOH30zUtWq3YCEkc8Mac/P0RNDWXC6cqscWdtwTrshU?=
 =?us-ascii?Q?HZ4jm7+77nsIyEJwlr9HSWw2QsIGswRW2Q3H516q5kgZV+pmKavOKbmg70AR?=
 =?us-ascii?Q?9NoBjgkKyKcqhYCptcHlMX3M6PT0nonydVc872Yq8nWeyisp4ArAZdhqVvp2?=
 =?us-ascii?Q?4Kh1pyhCytoU85sOxGAEfuQg+JR9YIPFfOjBE7N14U+tb23sOfV4B+uifQAN?=
 =?us-ascii?Q?9F7/SKGxBFDQlJ1EAHT/eQ606cWN3fjfnfvaHmBVfOADU5BcEZCqZdKSYoWw?=
 =?us-ascii?Q?4LwOjouDxBfKZUw52NxjWKP0u0C++F6q02brZmEKyS9DnEK/ESAeOTZPSijv?=
 =?us-ascii?Q?chKwRHpMrEwvdAMYn7iXl2RkUPhvxLUsSmaHqteqn5tftsiqFoyBoRNemOZU?=
 =?us-ascii?Q?Mq4DG/Ux1zQES0Cd1D+ibANAHwnHtmqtwgUECD+9rryeDwz+MYgQFNQXmoHg?=
 =?us-ascii?Q?CtINcG5J3ersaoYhVY5b2CgnlNsWpdIVZsgab2yy4V71VXFwi25v17A8S75d?=
 =?us-ascii?Q?WXnyZnBoYlZbTN5SFXKktOvXMqip0zONu+Ox4T1ffOpehGzMzxcbVoInaflQ?=
 =?us-ascii?Q?dwJ1/xIRMHU65TWs9hd2J81WLgfNU+EL7xldHlVh4jLovBup4Wdn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f4d9c1-3fea-4cd4-2730-08de67da3470
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:21.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRxHEmudO4QLDB9mbcyRF1vt45LKosmHzRvauiT4qlisByVQWVzfVWF9Jszuu7/bMKxT+D5gp/ngkatAj2oRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8842-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3633010F2B4
X-Rspamd-Action: no action

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
get_aux_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
 include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..01de4bd5047a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
+					  num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..5d3e1986b49f 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,45 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_aux_resource_type {
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN_DESC,
+};
+
+/**
+ * struct pci_epc_aux_resource - a physical auxiliary resource that may be
+ *                               exposed for peer use
+ * @type:      resource type, see enum pci_epc_aux_resource_type
+ * @phys_addr: physical base address of the resource
+ * @size:      size of the resource in bytes
+ * @u:         type-specific metadata
+ *
+ * For @PCI_EPC_AUX_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
+ * information.
+ */
+struct pci_epc_aux_resource {
+	enum pci_epc_aux_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+
+	union {
+		/* PCI_EPC_AUX_DMA_CHAN_DESC */
+		struct {
+			int irq;
+			resource_size_t db_offset;
+		} dma_chan_desc;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +123,7 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +155,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0


