Return-Path: <dmaengine+bounces-8844-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF0qKP/YiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8844-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:54:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880710F2F1
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62FF8302DA3B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319B3783BB;
	Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SJz+bqzc"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B18376475;
	Mon,  9 Feb 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641604; cv=fail; b=OamAVn/U35+gFLVPr7ngFB877Vp/EiT8P2aG2pcG0n16Mgp6wz6DOCdKp6/rnwkU1XRLxhohPKn+VRB76ureyW5PXsJn/5V8R6IzTaAXpK1UqYoJqwQ4Q2RtEv25dnWQvUuW8MBnt7Kwn7zZTLdbMooMW9JRD5sjA+RLQpbOChA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641604; c=relaxed/simple;
	bh=m7gNzrd3xshvHeDWmQT6H7u+Yg0bDwxNQTJuH0FSzNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvyS1YOP229NVOQyIvCjECOrKZcPOQnfUsjeJ7DKp6zL61835BxhSVVjKZ0bl4yle8yiC5AdiUPv9F8hJQGKa1wGU2NGSA79GnqHBz8VF39Bl96T1lCIqSadf4V26Y/YI2b1rn41ime/IWsZeqJW4UBvmDVUyhzduazeqX3n1Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SJz+bqzc; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at9idiKjQMBYWj+DxMGECypg3tPomZ55U4VsTuEg1KHpad/awZQAMuIeB2XGIRFWyO1+EHuxk/Mv2ufqZ10Ro/ZgtL2BJIQ69igtGEDARyOR7Abs/FAzAAcSBWieZyFISyZ8/jg+QIx7G5SFcUj6Jl9wZYcAqRF7awJ9liB46KvieS3X/Z7aSdaDJaqjN8o+RbDS8GnUq/kb0+jjxRymdTrPSiUrLWpPM1rwxWAuPCwexqqiZyhta2BldlgZDR5UTwtnuneqOSXgqHHvv7a6LqhAqD+oibhGD8y/dCqBM2tcLfpsOzsRAb0BKvGrBbbYdyjweh64P1aub8rrB5lrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxG6ojMrkmLKQRceuNfassnYLg0CvoRYtyz0JIbPhgM=;
 b=ZpXM/yUkJ8xWYsozXVhod8xkWgfi5uzH2X/1zU3TNx1MXlCGW9xWg6/caOpxegWz/Uir/BGuRl0plM4tDzZTdJMGq9UakdUB8arypffh6O29dvB+YvSbUnOM4wI9bsw/SSLui5VQm6cfGuKdsBn3cXohCDFzy9OIi2ch7DRVN6Cn1IHocB1yUG6P4nnLuxVbLF3fTHMZuzCmI2I9IWJYjaSJqlzvkaM6EdideWbtzmyQRc8KMZmb27Z0oOcirXakvwKHCK0Z4cgJZMPT5Oxd6CL5y+wszfyJ57Z/YDDLEJKpS07t1ULkx7hkhvXxNYENPrFPaIabDj1ZOWlhhWs3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxG6ojMrkmLKQRceuNfassnYLg0CvoRYtyz0JIbPhgM=;
 b=SJz+bqzcnes2PfddfA+Gu8s1uR+bIo9EDQWa0qT73Sh87fN1sdM7w0eH4iHQrcx+ZHP8ceEBfok3jk+vw2W+6A1Rj2kv69lwP24s3J6pOCEn+AALG8aE1JJE+pOy22dnjkYMYUkK9UO3lGxI+7y5kiuBoDTFLRLcn+bZD0Jm0js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:23 +0000
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
Subject: [PATCH v6 5/8] PCI: dwc: ep: Report integrated eDMA resources via EPC aux-resource API
Date: Mon,  9 Feb 2026 21:53:13 +0900
Message-ID: <20260209125316.2132589-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0352.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: dc567df1-205c-4477-e180-08de67da3564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y9zpGRUP0F5UUUAP4e0k6lkfwXkaxFMww6i2lZJupdO/i5mFDkfMxD3N/2BD?=
 =?us-ascii?Q?gaXCwL3r6lgJWIayfhDtrHZ6ZXQ4S2iE35kcMUUEtNX/CiLfoLo0sFNtdaLL?=
 =?us-ascii?Q?Mhu0TnFLg+IQlf5hVabLuzgugKkDudFmx+iplxdaLvUHMEaHYd2FEUHRIT7Q?=
 =?us-ascii?Q?CXlrectZDTGnnde33PDkdzshkISlpte8gH6S1aEvSWNfj4QAtSYbP+HUB62S?=
 =?us-ascii?Q?cA3RrYohXCpmcZSziG8eez/l9bTH6cOr9gsxFdNkFK4hfvVmzPd1ae6IeTma?=
 =?us-ascii?Q?RJFiPTA4jhY6SCdq3xPNmH8ybTr6TkLd/gtVrS/lhl6AdSKyVFzvMeGjBUoz?=
 =?us-ascii?Q?30Xx519Gx2xLYpALTaM07qjJbZr5peWmSSd+H9b7gsH3cKeVoH2j7SXBN/+Q?=
 =?us-ascii?Q?p7wmGCt1TjRyNlFT38c/AzZWPu+vsXtfr68Rlxy/od3dcHN+qXzZe/cI5NtJ?=
 =?us-ascii?Q?YPNq3BZyjkexwBw3A2PxD1dKAX/AG9wZSlRQa+pw3pBALhllUN4s2iwzibvB?=
 =?us-ascii?Q?ubM1nTn2PIgmqVINLP8xXjejdjYrxjXCSoZPGV8K039rc2JPXaYteb/AECNA?=
 =?us-ascii?Q?r6OLetKoOWXpy6Fa+gSMNZUpNaLWHiYEmBZQ+LZTOoo3hc7erDlLGcIUvLTp?=
 =?us-ascii?Q?AzW6PQElUhdMsvYYUgweL4TOz1YDLEpkPCY+qQV6G+d8fzBAXfqmXC5eBWk1?=
 =?us-ascii?Q?OmfaOG2xURIq5PsvHfrMButDaKfjShNUfiwsFQuPhjoU2ncIHlQMvKXYpMp8?=
 =?us-ascii?Q?HDlI7RwQqFyZrE5qtU1EHdBXIlauzh6J3Uv9WB5PqvzT+jDGy0N49tpZPV0p?=
 =?us-ascii?Q?ZA0PbRIkfE2wovfY6vLBHSI8735P8cojWbaa3tzC+kOOqSnbNV+vmMRgfxk5?=
 =?us-ascii?Q?YCXBGv58q8bjXflKuq2TlRfXUfOAnKivE6ld83AMsOEJRQviNjaMkYMmXLe6?=
 =?us-ascii?Q?zBaeoAt/+YedLNoj7pZlN5HcgeFAboSy38PHey5wWyKsBHmAxd1FMbFQrQ2D?=
 =?us-ascii?Q?kDDqK1xar5LbMX2/Fkqi4Pf1UiDtg/+YMNWKd5Yg6ZwLi1tJn4r9BxKOnQg2?=
 =?us-ascii?Q?okvMK0xuIfCF0DAo5/23A3fC3WD9UJbT9BOuyAXmCsqaJREaFsEF+1aW9qX4?=
 =?us-ascii?Q?HEtTKI1FhCP3oi6f4zwNQsTEyzkZYDdUBw2cmzsizrjzjfjfwxkO9OH8nsPs?=
 =?us-ascii?Q?UotmWJ+XaWIRaKvPrYhpQiG2BbBBkurnlTBgX1g8tfTrKPgCu6XkIoFMCnuW?=
 =?us-ascii?Q?gWj2pBNUnA8jxjcuhiWQfOvkDnod5zN1DAxJTKkCEndcRWAbQDqFpP8vMZWd?=
 =?us-ascii?Q?S2chw8xugATaGM60L4M3VAbEdBr7WcepbzoQWaa0jg6Axm6uJbmxvJXAIqUc?=
 =?us-ascii?Q?4GcnU67L7votUmbIuwifffsotxdvjK1SdHemOm+QvVq08YWMYQ3svsjkmxp9?=
 =?us-ascii?Q?wpg3yFQX1sgaySSAgIm3oZdf9O6YVVLd8NYEdz66KhyuHJNnyM7LopY6OIda?=
 =?us-ascii?Q?dLb4/5WgzjXQT3RFGMgtcCNLhPuUyTzmEMH6vFlcg/UMgAfBfMMw/nyNwct7?=
 =?us-ascii?Q?di/SaBewP6cZ1ARBEriQs4rwd8kKinDG8vZFAzIk0+5CSoBZPlfWNK6hGldF?=
 =?us-ascii?Q?aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzGQLEGFRVwkZ2elUOLj2+vt9RXmX3/j6IxnbwL+HdLhh7cZbRVpsD8Xl4m6?=
 =?us-ascii?Q?x2JHwUKD3HxqB8MGlx1ceVGgcW+zZNTFpLgCW6JrlUUXW1jc6H1SsSaiGXZR?=
 =?us-ascii?Q?0RrpHNb9E7ceRVHtFnnSsi29u/2e78vJm1v97PNzFnaof3O3EhNC2elf7t9p?=
 =?us-ascii?Q?XVeCn3/Mm3sJUPdT42vtE0SZDDmW0XtN6Xbzanw6Q3a3seEnL0PETF5w2ukp?=
 =?us-ascii?Q?7hjV0RcNj7HMWz466oL5TnL24rtb1f0eoXz2RQIHJ9BDQcx/ZhhkrqKTavKw?=
 =?us-ascii?Q?Y1WxVSv0ENEliT2ymua6Ew8/PvFZS1ClrbvvcAmrXkHhS/Yed/ia3tcgdtwa?=
 =?us-ascii?Q?qSxTVzsMHYftnUhBkYhV/M8+/KGHu+V54RUVC5NIx/66Q4WFi1naCd5W5hiJ?=
 =?us-ascii?Q?xd02evXmqs304kLpFc8R9C4DN4pMOzXlEfG1fXMN4usLKX0lWak38SvJzNCw?=
 =?us-ascii?Q?17TYc37EZQqkDx5bosolBT69oSuoL6sJhoO4/eGGpyshkh9d19xiC1L053Og?=
 =?us-ascii?Q?3/3ibvtcZJOVSrxo+64wTxk4+epuMstKWVfwrHxo5P4JCeeNGMn9kjlNzQWz?=
 =?us-ascii?Q?iSxy4nvyzs+qYF7OxN1J8HQS2xgda41d5LTYlgZSPxpBTm2QXynbBxWAqCK6?=
 =?us-ascii?Q?WIvB9Arf1xBohdzNxa2rWpg+oUy4Tb0ZbzCooxZae7sNfPgj0vqFr9QIzgE9?=
 =?us-ascii?Q?AyOjS6O66L5K5+a2gleGs6aQ8ZyYIDD3wriu/ObNheXgp8cqxhotWW7jENFI?=
 =?us-ascii?Q?2GEvSkYUUa3rN7vfYpI+neUK7tTwvwbpYzFrYpazUncfORL8CwIG08KiSCyX?=
 =?us-ascii?Q?CoAKwv3RtICulvjC57gikTWrfQO45ZheTgJ0/vbnYrRXkkimu0vSGeHnTZkd?=
 =?us-ascii?Q?0ZDgMwSWFtjRyi5TVEvqvrQeKO9TcAkDesHHI0Ozgt8BlATWZFpuCOyDgFuM?=
 =?us-ascii?Q?/d97lWzNTX62xE+Gug3X+ricaUVIB4AjH3WRYw3a8iP5ta3zu5KR8hiz82Xo?=
 =?us-ascii?Q?cyVJiGnXnjNZX6rDEr4/O0imoem49k0EaoiOW5td3Zx+h5mwaOZatuOpG/cc?=
 =?us-ascii?Q?i9ZL1XVmcktqJDDpVCNzUyp9JtFC59xUBse6OtGtFbHSsqIL87Q/YDvGXFzP?=
 =?us-ascii?Q?k588fGmDnl4vlv+8TBr2YMJAYWKawYVneyuufK3naZBwnLL/rfpd1MEsAZZ+?=
 =?us-ascii?Q?6T2QG06YeXe2FdZR5WPJKgqKIYcH913GOS3LKF60VD0VrC+Mg/UEXVYHmyG5?=
 =?us-ascii?Q?98b8QNsyaRrktCSDOf7rZ8UxdDVF4doBw+9l4LFVdQe9Q5bL7L/knJx639oz?=
 =?us-ascii?Q?PB8waBOJKADfpckuPySdJO1tt/OwTRGHfPY853nFhgzI9M6Yx4LM7RWrD404?=
 =?us-ascii?Q?q2x25Tcs8mfC7e9Md8+sug105kNT8j+1pE7P3fX6dQLYI+RuRZEL2aZqqFsn?=
 =?us-ascii?Q?A1rXDJHh6ZvQcrOsQfL3+gDp2DdAx+0ufwkQJqlajahcRigAHr/zA2+NRSrD?=
 =?us-ascii?Q?WHpT1q8DHxVUz1b0Ko7Wu98tMi77dUNn2s5K/TCKEN+QDGzK6gbGmw/raWkk?=
 =?us-ascii?Q?SEm5Oy8mEhhEP5DGd5x8wBaFGphUQU6cEbY5A6Z5/GBT7wraH20KPBLxZ4ez?=
 =?us-ascii?Q?6okrB+kTffT3GGiJLAWgvwmtC8/sOWpQdSxvL9ebgitORaSlZUiGRSB6StQC?=
 =?us-ascii?Q?CniN5d10QIwOPBmmMzrBp+cw9GdkcrfYwFJWXlqvZ8cv+mEpzVLwZK1LP5S8?=
 =?us-ascii?Q?0wtgz8+rJMIKCA9xVVT1z2tfrd22PuPCegDXRBJreSL3/aCZXNT0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dc567df1-205c-4477-e180-08de67da3564
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:22.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcDXOCl1DBaU7bqk21AGwyuQCR4czKM0+fD10UEA63L/EXr6FUS3WR5tqGwJ/xK/Slj7GQOKa5Bk5AiEvEJEwQ==
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
	TAGGED_FROM(0.00)[bounces-8844-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 4880710F2F1
X-Rspamd-Action: no action

Implement pci_epc_ops.get_aux_resources() for DesignWare PCIe endpoint
controllers with integrated eDMA.

Report:
  - the eDMA controller MMIO window (physical base + size),
  - each non-empty per-channel linked-list region, along with
    per-channel metadata such as the Linux IRQ number and the
    interrupt-emulation doorbell register offset.

This allows endpoint function drivers (e.g. pci-epf-test) to discover
the eDMA resources and map a suitable doorbell target into BAR space.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..c99ba1b85da4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -808,6 +808,83 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static int
+dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			     struct pci_epc_aux_resource *resources,
+			     int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+	int ll_cnt = 0, needed, idx = 0;
+	resource_size_t dma_size;
+	phys_addr_t dma_phys;
+	unsigned int i;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_phys = pci->edma_reg_phys;
+	dma_size = pci->edma_reg_size;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (edma->ll_region_wr[i].sz)
+			ll_cnt++;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (edma->ll_region_rd[i].sz)
+			ll_cnt++;
+
+	needed = 1 + ll_cnt;
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return needed;
+
+	if (num_resources < needed)
+		return -ENOSPC;
+
+	resources[idx++] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+		.phys_addr = dma_phys,
+		.size = dma_size,
+	};
+
+	/* One LL region per write channel */
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (!edma->ll_region_wr[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_wr[i].paddr,
+			.size = edma->ll_region_wr[i].sz,
+			.u.dma_chan_desc = {
+				.irq = edma->ch_info_wr[i].irq,
+				.db_offset = edma->ch_info_wr[i].db_offset,
+			},
+		};
+	}
+
+	/* One LL region per read channel */
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (!edma->ll_region_rd[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_rd[i].paddr,
+			.size = edma->ll_region_rd[i].sz,
+			.u.dma_chan_desc = {
+				.irq = edma->ch_info_rd[i].irq,
+				.db_offset = edma->ch_info_rd[i].db_offset,
+			},
+		};
+	}
+
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -823,6 +900,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0


