Return-Path: <dmaengine+bounces-11342-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SzVEJhmyJ2rU0gIAu9opvQ
	(envelope-from <dmaengine+bounces-11342-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 08:26:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF1065CBBF
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 08:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=soe9vxsZ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11342-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11342-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73ED43028012
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 06:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8D3D34BC;
	Tue,  9 Jun 2026 06:23:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020119.outbound.protection.outlook.com [52.101.229.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3F22689C;
	Tue,  9 Jun 2026 06:23:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986191; cv=fail; b=cozV5KRHIgQMoVDzLfxzSJLg1CF30F4IUwtbs4MG5lZOttdKyLZaz0R7IBXWnikUDoC3eOKuw66Qfdv2hXca1qKLy24kXLXP2nB8LXOVw6Tp6NTGOu+8eHfZ8FQwjvjxrXO9v/oqi5ZjSgGJTiHFiMz2vTWxnS+C2b34qucra4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986191; c=relaxed/simple;
	bh=R0rTDDXqFjojGwIkIre4Hq9D1t+fxQp4PajdAKNbc7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GCp2j0OjfSQ5KEWefD+WX+VmH5O7UcUjfuIpuUzBIkxznkhnAAx/cRlB+jmNDOY3LZ3wCAbnyZ/724UJ4V1T2AXTRCTxDDjrxYIY7eD0kuwRcTpOlyC3FHV1RXVMEzoO7/+othdM96bDZyUv9u8ThSAYqFEh4o6TEcCLAecjnyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=soe9vxsZ; arc=fail smtp.client-ip=52.101.229.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ+7iHc1jb2HrrmhUN0QuK4BlOBLHFFHpC/H4BnEnbn5yGw5w1/fj6wUSP8scn0RgRvZvVuGimyfPhqTe/gcxgXeciuCeqrlkPNCdm61D0RrSKFG+X1M6XLxw2nNcMPt+gEChe0vpOkq5erFF6nijL3c+TJX/kPha2pmR/gtzJNnIGjkQ16LZlnbXabMucAfq8W2+9ZWTUzNJcAdkkTMbQS3cMR0Cy+mTSEvbsWZkX/LLb25bc6mL/IjFC9JYXF3lrZ38aUYmde9IPnIhH6/byJNOjSTSqid6BBN5yjMhUFG3RV/DodEIFCa5TWRB/nRBYcqgJKtplFtASGkiT+Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM8O2z4O7s2YwAsFg0BRWlQyPGfyy6q/HvY0TPXgVDQ=;
 b=RaK13XnKwtZUUzTRoiqnluhMF9jxFWiiHlkKUqwcfEHRqZhgBiNI8igJaYTPYJn/wtExRNNEKhqXxVnUxKBVoYdzG+E/5xLmyaulTRVIhMZXGOkCRNmHsdmT4tsGS4rHorUwZUtdv+tfGB/Mwn9LgZBsCByr378N/sN1a6Q9dZwrXKPvVPTOhyqEUwvM6i/lpzLvEBRXGYvq7VTIyl7wLxWdwcK2114uMAgVIlYPcbtzP8cFVVplIiXh5Ok0uhKUhVdrbe/KzpKBoA87cIf7Ikro9O4uErUNJJYnedKg8mypumHjBGU9zMs7gTg2jmdH9/AnpoRLUWRIBsbh5mO5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM8O2z4O7s2YwAsFg0BRWlQyPGfyy6q/HvY0TPXgVDQ=;
 b=soe9vxsZEzzwJqugx3A51rkrG2l8KZxzkkneIgSvKII7EEf4/jh1cNK9o6YTTxVAD9akUe0lsjEj/fqg4WzsYwMOO9P7k34NazJYm3qtt7wZXuBQWvqeGKqjFzCgF23mG1EsfGL77twttt9QtEFIijIQ8lWOGuX6xXgMWhGW/Z4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6099.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:23:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:23:04 +0000
Date: Tue, 9 Jun 2026 15:23:03 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Message-ID: <w7fwh4ztgg5svpfqrfvw43kvfznrzn6gystacaq6sbf6zuqwge@ccj4rau7p3hy>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
 <24a5wo2ncgf7d43mxbv6pacvqkzmiuo4bvuyygfeyoq4lbdt25@kqw4cx7xzrfu>
 <aiMWmI8QMddHUzL5@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiMWmI8QMddHUzL5@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0123.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a58261b-1cdf-4943-c1b8-08dec5ef9081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	upj+DE8p49a3FsQZNrQh9N3bjdTHaN2wVegitw1vtt5XxwkYGMAsTDbY3xNQn31LZArOX+0gKjmiXKjkiHid5nzWWDHqpSqhIhPuvQnZA8CcBaQAqhhS1vaN5M5154UTaTpWKKCx8OudZoDA+RXra7nS3tfwqjXawvSlTUULjFBAYNAHqm+edNsCP1DbnSmkF5cbGdzA7CFHJRu4zhK62vt8t2HontS5VPG6h9uoxQI4G+EYsDfoqKuQCmlku0nUNFAVPEKuryIr8jYa53EB/FoBrUZxwQHZc9PA5vgraVyvhuE5X5rYP52mnTz/IryYBUTU5n6lptQ4XPGB6CBHHYBvkhULBa2dr9LnzJXE72o+WAVOdLak0c2uqhllT6PcPFd40fLEabkI1n6WTqPbN34O7Fci5G+qXqeK5tRFPJc4746L0PasrcOxx5gH3TFltVizpiXdcg/kwNyJ5b9+25pmfYh2cCaAcsZzY2FMSIBKGrAo0c+7gT/gJ4CmXvdAbodEgkIAP8ygjp3iOCu5/Th1oOrv/KNXnTmJslpeYkarMLESe7tE7Iv3XPP1xCAHI3ZQ6HHcUnIcvyHJOG5zH/bD0sof5sPS4SN0T8Md1f5YaCHjk0Xh+xCFAfSqxI8hwaJXfkhXYjI60b1hJ8hBeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FnzwXCzzdQ7uYBWUxyGyb+m4eq4pwGsRCmqKnY7XzLL7U/3bATVYpa+QkoXo?=
 =?us-ascii?Q?lyjSyHgm4F1BUhGvjB7V5Ppd8oXedIQt1DGYmlvqddc7pzTJIgwYX3YiGSzp?=
 =?us-ascii?Q?dcxDPeVpN769hNAHqU1Wtwh3bQtgh3PsNby2TCWQm/CvuyxEcAYhy5ASGeze?=
 =?us-ascii?Q?3gHUoehpiOmRPdVzCl8mCGvJ+FWPTJ86pedwofO0mH/UU7iG+Oqlx0FVzgX+?=
 =?us-ascii?Q?r+ah6Porg2TDgkeID/5osVUVedt33rHG106EHHDN2ncgLZId48LTkMsoXzot?=
 =?us-ascii?Q?Lb5veXWHAZ2p9EW9WIvoMk8o52z2mYQJtE2LuHwNNxAxAKoEWPahLZtso89F?=
 =?us-ascii?Q?zl0d747sfobKWalPgjA+QYIwEqy5U6OSqVXHVwuajmRN7V1bKpNNm37LLq3X?=
 =?us-ascii?Q?0iHtAtRZz8WnhAqOXGwY/BXO2HLi5NXx2Cz/D/p3AS50di+Rihg5VRTYiMtb?=
 =?us-ascii?Q?jFkmW3fufqF77t5nRRmJqioS4PS6mbZpqTovTviEAV59KNLHklC9v2Npp498?=
 =?us-ascii?Q?f3DPpV44fEoV60hOyaseUdwZivRQGp7UySJzuMYesoDKId/RSjRyAXywIlwW?=
 =?us-ascii?Q?oFQx39lhpEG9WfL7Wde/1iRhtfj8IcvIQOXu/dD+f1wjXEi/2jNeNn/XncqW?=
 =?us-ascii?Q?nhK4T5/MOCh6hGpOU0BX040a6JirHUCgLVXPpcK92idOvbEgsSsuN1a4qurO?=
 =?us-ascii?Q?LQNh3nWwAYiqbn4pidQBCYBv/o6UcNHUsJbYJmFuiHEx2ukpvlHjjtzRihOf?=
 =?us-ascii?Q?TfE6iq3rqyGF37j1QXWsEoJ/sqfSxWi6OtL/fthHxSAr50zKottwOUYGED2c?=
 =?us-ascii?Q?P0A6cmtN5YRCjWClro2oUxjURlSWyhR+Db0VowPezrM7SJQGeHaHhwuRBX98?=
 =?us-ascii?Q?v8cvY+JYFEw1se/XxVBzZ62mF/OkPcOKPYVsB6EEbcyCTnCrNNuzezRsCjsa?=
 =?us-ascii?Q?54xxEblCC7AN6nPRjw26oatAbqpQe7pEVr4wuE/uU83RMFtiflyygOzvdgnq?=
 =?us-ascii?Q?Jk7Xe2HmTFg7GCQ80NnKY2FP8GXPC7V6LfCR4Ya3gvVRu1LqfOHD6Q+b4lEE?=
 =?us-ascii?Q?6QpawAh0+9a05D/nUy6K/6Bpv4CxItkpL8McskcO7MpENPhDUSIPzCoyvmHg?=
 =?us-ascii?Q?OpuWRUYzpQNS1sWiFuEsvfKI1leW6sCta2tNU+zy1z8L6BpV35UCjrfRJgBU?=
 =?us-ascii?Q?4bIv75Qg4Rym+nL/Kz4FcgY4gDdnpqF9OxLzN3NSvqdDOubgyJMm70yJraTA?=
 =?us-ascii?Q?WV92sSYf7EqSgYKXnTb+0Ymz+Kn8DUXq88/vQuJBxQrakSKNB92JW4e6ZyXY?=
 =?us-ascii?Q?zoax+3IH2P/CZN/TmgX6aO/i74MszLsxMRGLHEGtNhxDQTkofzeAfoR/0Eq/?=
 =?us-ascii?Q?GJiZGRyjcCytFwmiSZYaSjwekTeNiFsQ14JGdkWfj7Iaqbz4neZNx6UliCaj?=
 =?us-ascii?Q?hcHhR9ZIKmvi5uOFxemBk4goxWj2Ldib7et6jX0s9QlHieI4Wt3pdXRt/C+E?=
 =?us-ascii?Q?q4ojvf3Pii8Req33tT/GOAaGk08iSTRGNFIjSqoWZ/H1ktEJhmbLV/JPH0qG?=
 =?us-ascii?Q?k4vReSdUtjrKiSBJ2hl/UOznU0W9ZC7M8ugVj7bFF19ahg3g73PenSpLTXjD?=
 =?us-ascii?Q?V459V3AtmWlX7WH2LycbX1of7C4LjVOvQF5ax0M1huNixB/E86oqljof+WyS?=
 =?us-ascii?Q?nSmOmQk0KDCapk5nZbvzjpp/pHTZwa9LPPVYU6MUZ5iPRYyWNuIg+VN1EjYZ?=
 =?us-ascii?Q?RsykJ3652AjW1gTdQcDrSE73iegbbKGhOz+nvicbt9Fbc47UnwcB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a58261b-1cdf-4943-c1b8-08dec5ef9081
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:23:04.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLirn5KNyNGGx6DbiFhPtdytesZDyGlWPAxKdFNh1ZTFdGjIi7I2yOL1JLVC0DgZ4pVChO2PcHV2Vxdm94hs8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11342-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dlemoal@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CF1065CBBF

On Fri, Jun 05, 2026 at 02:34:00PM -0400, Frank Li wrote:
> On Thu, Jun 04, 2026 at 04:08:06PM +0900, Koichiro Den wrote:
> > On Fri, Jan 09, 2026 at 03:13:24PM -0500, Frank Li wrote:
> > > Patch depend on
> > > https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t
> > >
> > > Only test eDMA, have not tested HDMA.
> >
> > Hi Frank,
> >
> > I expect this series may be revisited in the near future, since the first
> > dependency series reached v7 and looks close to landing.
> >
> > With the latest versions of the two dependencies:
> >   - [PATCH v7 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
> >     https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
> >   - [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and simple code
> >     https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/
> >
> > I tested this RFT series with the HDMA engine on a SpacemiT K3.
> > The test results are below, using the same format as your results:
> >
> >   Baseline, before applying the three series (v7 + v2 + this RFT)
> >
> >     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8567, BW=33.5MiB/s (35.1MB/s)
> >     Rnd read ,     4KB, QD=32, 1 job :  IOPS=55.5k, BW=217MiB/s (227MB/s)
> >     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=83.0k, BW=324MiB/s (340MB/s)
> >     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3817, BW=477MiB/s (500MB/s)
> >     Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1346MiB/s (1411MB/s)
> >     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
> >     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1515, BW=758MiB/s (794MB/s)
> >     Rnd read ,   512KB, QD=32, 1 job :  IOPS=2795, BW=1399MiB/s (1467MB/s)
> >     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2795, BW=1404MiB/s (1472MB/s)
> >     Rnd write,     4KB, QD=1 , 1 job :  IOPS=9035, BW=35.3MiB/s (37.0MB/s)
> >     Rnd write,     4KB, QD=32, 1 job :  IOPS=38.3k, BW=149MiB/s (157MB/s)
> >     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=41.8k, BW=163MiB/s (171MB/s)
> >     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3969, BW=496MiB/s (520MB/s)
> >     Rnd write,   128KB, QD=32, 1 job :  IOPS=8260, BW=1033MiB/s (1083MB/s)
> >     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8295, BW=1038MiB/s (1089MB/s)
> >     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4609, BW=576MiB/s (604MB/s)
> >     Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1345MiB/s (1410MB/s)
> >     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1524, BW=762MiB/s (799MB/s)
> >     Seq read ,   512KB, QD=32, 1 job :  IOPS=2799, BW=1401MiB/s (1469MB/s)
> >     Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
> >     Seq write,   128KB, QD=1 , 1 job :  IOPS=3722, BW=465MiB/s (488MB/s)
> >     Seq write,   128KB, QD=32, 1 job :  IOPS=8246, BW=1031MiB/s (1081MB/s)
> >     Seq write,   512KB, QD=1 , 1 job :  IOPS=1283, BW=642MiB/s (673MB/s)
> >     Seq write,   512KB, QD=32, 1 job :  IOPS=2072, BW=1038MiB/s (1088MB/s)
> >     Seq write,     1MB, QD=32, 1 job :  IOPS=1037, BW=1040MiB/s (1091MB/s)
> >     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1540, BW=768MiB/s (805MB/s)
> >      IOPS=1549, BW=768MiB/s (805MB/s)
> >
> >   After your three series (v7 + v2 + this)
> >
> >     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=7216, BW=28.2MiB/s (29.6MB/s)
> >     Rnd read ,     4KB, QD=32, 1 job :  IOPS=61.1k, BW=239MiB/s (250MB/s)
> >     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=75.3k, BW=294MiB/s (309MB/s)
> >     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=4711, BW=589MiB/s (618MB/s)
> >     Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
> >     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
> >     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1497, BW=749MiB/s (785MB/s)
> >     Rnd read ,   512KB, QD=32, 1 job :  IOPS=2802, BW=1403MiB/s (1471MB/s)
> >     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2798, BW=1405MiB/s (1474MB/s)
> >     Rnd write,     4KB, QD=1 , 1 job :  IOPS=7411, BW=29.0MiB/s (30.4MB/s)
> >     Rnd write,     4KB, QD=32, 1 job :  IOPS=39.3k, BW=153MiB/s (161MB/s)
> >     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=42.9k, BW=167MiB/s (176MB/s)
> >     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3736, BW=467MiB/s (490MB/s)
> >     Rnd write,   128KB, QD=32, 1 job :  IOPS=8302, BW=1038MiB/s (1089MB/s)
> >     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8314, BW=1041MiB/s (1091MB/s)
> >     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4092, BW=512MiB/s (536MB/s)
> >     Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
> >     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1474, BW=737MiB/s (773MB/s)
> >     Seq read ,   512KB, QD=32, 1 job :  IOPS=2794, BW=1399MiB/s (1467MB/s)
> >     Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
> >     Seq write,   128KB, QD=1 , 1 job :  IOPS=4135, BW=517MiB/s (542MB/s)
> >     Seq write,   128KB, QD=32, 1 job :  IOPS=8307, BW=1039MiB/s (1089MB/s)
> >     Seq write,   512KB, QD=1 , 1 job :  IOPS=1259, BW=630MiB/s (660MB/s)
> >     Seq write,   512KB, QD=32, 1 job :  IOPS=2073, BW=1038MiB/s (1089MB/s)
> >     Seq write,     1MB, QD=32, 1 job :  IOPS=1034, BW=1038MiB/s (1088MB/s)
> >     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1531, BW=763MiB/s (801MB/s)
> >      IOPS=1540, BW=765MiB/s (802MB/s)

This was false. I cleaned up my test environment and retested your three series
again. It seems that the test cannot even run properly. Sorry for the confusion.
(Note that the other results, i.e. "Baseline" and "use of HDMA watermark
interrupts", were re-verified.)

So I looked into why this RFT series does not work well with HDMA. My current
understanding is that HDMA dynamic append needs watermark interrupts from the
beginnning.

The PCI Express DMA Controller Databook (6.10a-lca06), Table 7-3 Channel Context
Register Considerations, says that while the channel is RUNNING, HDMA updates
HDMA_LLP_* only when a watermark interrupt event occurs. It also says that
software can use watermark interrupts to obtain the current transfer location
and recycle descriptors up to the LLP value.

So, without watermark interrupts, I do not think HDMA_LLP_* polling from
software gives us a reliable/valid running progress point for cookie completion.
The only conservative completion point left is the STOP interrupt (i.e. the
current base model).

However, with "dynamic append", software keeps recycling/refilling the ring, so
the channel may continue running and the STOP interrupt can be delayed
indefinitely. In that case, DMA cookies are not completed in time, which leads
to dma_sync_wait() timeouts on my HDMA setup.

Therefore, now I do not think the current STOP-interrupt-only model is suitable
for HDMA dynamic append. If no objections, I will submit a reworked version of
this RFT series that keeps many of your original changes, but enables and uses
HDMA watermark interrupts for the HDMA dynamic-append path.

Best regards,
Koichiro

> >
> > On this HDMA setup, I did not observe a clear performance difference from
> > applying the three series alone. Still, I like the overall direction.
> >
> >
> > P.S.
> > Separately, as a follow-up experiment, I also prototyped an extra series on top
> > of your three series that allows us to make use of HDMA watermark interrupts.
> > With that series, in particular for the high queue-depth cases, the results
> > improved noticeably on this platform. I haven't posted that series yet though.
> 
> Thanks for test it. I am monitor above recondition patch set.
> 
> Frank
> >
> >   After your three series (v7 + v2 + this) + use of HDMA watermark interrupts
> >
> >     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8016, BW=31.3MiB/s (32.8MB/s)
> >     Rnd read ,     4KB, QD=32, 1 job :  IOPS=63.4k, BW=248MiB/s (260MB/s)
> >     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=92.7k, BW=362MiB/s (380MB/s)
> >     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3530, BW=441MiB/s (463MB/s)
> >     Rnd read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1500MiB/s (1573MB/s)
> >     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=12.4k, BW=1555MiB/s (1631MB/s)
> >     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1541, BW=771MiB/s (808MB/s)
> >     Rnd read ,   512KB, QD=32, 1 job :  IOPS=3116, BW=1560MiB/s (1636MB/s)
> >     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=3099, BW=1556MiB/s (1632MB/s)
> >     Rnd write,     4KB, QD=1 , 1 job :  IOPS=8748, BW=34.2MiB/s (35.8MB/s)
> >     Rnd write,     4KB, QD=32, 1 job :  IOPS=57.6k, BW=225MiB/s (236MB/s)
> >     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=80.3k, BW=314MiB/s (329MB/s)
> >     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3878, BW=485MiB/s (508MB/s)
> >     Rnd write,   128KB, QD=32, 1 job :  IOPS=9798, BW=1225MiB/s (1285MB/s)
> >     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=9970, BW=1248MiB/s (1308MB/s)
> >     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4516, BW=565MiB/s (592MB/s)
> >     Seq read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1497MiB/s (1570MB/s)
> >     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1571, BW=786MiB/s (824MB/s)
> >     Seq read ,   512KB, QD=32, 1 job :  IOPS=3073, BW=1538MiB/s (1613MB/s)
> >     Seq read ,     1MB, QD=32, 1 job :  IOPS=1573, BW=1576MiB/s (1653MB/s)
> >     Seq write,   128KB, QD=1 , 1 job :  IOPS=3977, BW=497MiB/s (521MB/s)
> >     Seq write,   128KB, QD=32, 1 job :  IOPS=9806, BW=1226MiB/s (1286MB/s)
> >     Seq write,   512KB, QD=1 , 1 job :  IOPS=1404, BW=702MiB/s (736MB/s)
> >     Seq write,   512KB, QD=32, 1 job :  IOPS=2496, BW=1250MiB/s (1310MB/s)
> >     Seq write,     1MB, QD=32, 1 job :  IOPS=1252, BW=1256MiB/s (1317MB/s)
> >     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1682, BW=836MiB/s (877MB/s)
> >      IOPS=1688, BW=838MiB/s (879MB/s)
> >
> > Best regards,
> > Koichiro
> >
> > > Corn case have not tested, such as pause/resume transfer.
> > >
> > > Before
> > >
> > >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
> > >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> > >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> > >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
> > >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
> > >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
> > >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
> > >   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
> > >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> > >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
> > >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
> > >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
> > >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
> > >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
> > >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
> > >   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
> > >   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
> > >   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
> > >   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
> > >   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
> > >   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
> > >   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
> > >   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
> > >   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
> > >   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
> > >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
> > >    IOPS=266, BW=135MiB/s (141MB/s)
> > >
> > > After
> > >
> > >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
> > >   Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
> > >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
> > >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
> > >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
> > >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
> > >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
> > >   Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
> > >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
> > >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
> > >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
> > >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
> > >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
> > >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
> > >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
> > >   Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
> > >   Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
> > >   Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
> > >   Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
> > >   Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
> > >   Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
> > >   Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
> > >   Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
> > >   Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
> > >   Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
> > >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
> > >  IOPS=299, BW=149MiB/s (156MB/s)
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Frank Li (5):
> > >       dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx() to get completed link entry pos
> > >       dmaengine: dw-edma: Move dw_hdma_set_callback_result() up
> > >       dmaengine: dw-edma: Make DMA link list work as a circular buffer
> > >       dmaengine: dw-edma: Dynamitc append new request during dmaengine running
> > >       dmaengine: dw-edma: Add trace support
> > >
> > >  drivers/dma/dw-edma/Makefile          |   3 +
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 215 ++++++++++++++++++++++++----------
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  42 ++++++-
> > >  drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
> > >  drivers/dma/dw-edma/dw-edma-trace.h   | 150 ++++++++++++++++++++++++
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c |  39 +++++-
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c |  17 +++
> > >  7 files changed, 409 insertions(+), 61 deletions(-)
> > > ---
> > > base-commit: 020f6d8442f35105660a29d0d236d3f8650c8142
> > > change-id: 20251212-edma_dymatic-a57843ff0dfe
> > >
> > > Best regards,
> > > --
> > > Frank Li <Frank.Li@nxp.com>
> > >

