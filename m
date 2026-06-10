Return-Path: <dmaengine+bounces-11387-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jqKrAfDSKGrGKQMAu9opvQ
	(envelope-from <dmaengine+bounces-11387-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 04:58:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBD665854
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 04:58:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=IqD3B9l1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11387-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11387-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6088300A65B
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 02:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD87320A04;
	Wed, 10 Jun 2026 02:58:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FC21C9EA;
	Wed, 10 Jun 2026 02:58:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060329; cv=fail; b=erV32neL7pkjFYCslDO+378VS3qzjvHhv0ROB/W39nBXuMDkBq8wlU7tGzaVgrepGOYK6MX/+3KZiTD2PkUDFQvFuLecNCksTFTtmbx9Tu1SCSsKkrihVlsdl+XnUhy4emSm0VNq6fZlo/bKQDXzFhtLWeO6ZDGi+/o0wBfP5kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060329; c=relaxed/simple;
	bh=KqI4KLFKio9aPiVCE9vn5eItUQ+8oMPwup9dYFGkZas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTowIxLCS6ISiuvwqfYa7FB7Id/2yzdCeNTDcZdKzaGAe6c1jLBF5jrXmx7M/WJOVKHfnDxk0p4esFZ3xLb/GHpzCs7SmPfw/NKXM5gYuBfQS7yZo46VKxExm7s2bt2feq4gXc62JAL5TVYUtwGjdZx+7CrkaRKrZlWuTZQKLlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IqD3B9l1; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR+UlKw+inq5lclzZ5iWMpTe9r0hsTZBmr5ad1gg6CM9TWGKvd3OupS8LEFZo9wyZUM7ygoAbwksjCssCquyJV27Q8zNCEhq2SBwwC9ZaL1mRwHfYRGpOVVx4jnGMnW6Y8yJOWgwoT5y/vPcNwkhU+a+ewudhGFtgZCx8HGmHYXPowRVLOouUYnjm7XzcjfdPKZCcgi2LyWERWj4Fy43yHRrnEG32EfRaJNlUI7u3MjXyd4n+KAEWEvhZb/eTIj0js/EsgzD+sUWa+De6/2hO3O+ccSY3gDf+CknPqWQ9e0l2OlO315m+eYhYknhUqqDk8ivJoI5T8FxlFDzPKKyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2Xna/3EzXRvr46eLiAm0p3QN0qbDLihzDgmMdSMZ/o=;
 b=xLNxpY1k9lXCeYSY5q3CHfkcuZafqAa64bAULoJsDvLPSBxFIcNIx+yqiSRRq5fPl39KsSX4E2BnH6nZ0UGQCLvW71Hxp/ZvqFwgHZiWCSdOYfga81vkQ1qehhq6OSajwbiP/a/YLW5jXwyXN1LObbRpVPHGGTheE93+vNHGX/bOwQ53dzQSVb/++EsJF0Mrpmhmiv0KSkcHTY8VBB59TRxOJmSrCn/1mBgVpXbWX8A2lbqbsHbBOiL+I736lyfQWj0NUeLVQD6I2BLd+VGczw8tcNkVI0EA+LhUaO3QYHREFSAi21S8mn1wMrbXJw0yEFW74vdByFA58K/mYahOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Xna/3EzXRvr46eLiAm0p3QN0qbDLihzDgmMdSMZ/o=;
 b=IqD3B9l1bNvejycj/LU0eQK+U9bMt/MxchSZYGYiBI0WES+E5tmG4MSc15p1evWC5iYjnrnxJkS3VUfe2tFgx3uutIQcN7cy8wVlZy2xB1X/sHfNzLgFzNryez0C3nW2ACSCknYByCIa+pcyLyUt6U9k9b3HEoi0orl3pmZQwoxJCfuQJb4HNmwPLD0feBfpZaBR0Vwppezi0yvcgQD5JlXqkqqKB6/is/UdiiGVatSxn7sFDoXxi1L1a3eap949lVfsU7yE70Bqgp8n0lmx4JKFfbIIPIAbDZVr0n7+xN/sxX+HEiM2k07bkQa/G+C2ReeOck1oY4N7QGRwDPW0Jg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 02:58:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 02:58:44 +0000
Date: Tue, 9 Jun 2026 21:58:19 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv3 08/15] dmaengine: fsldma: convert to
 platform_get_irq_optional()
Message-ID: <aijSy4Diinx4LBRL@SMW015318>
References: <20260609221926.35538-1-rosenp@gmail.com>
 <20260609221926.35538-9-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609221926.35538-9-rosenp@gmail.com>
X-ClientProxiedBy: SA1PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4fe80a-b349-4550-e00c-08dec69c2f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|19092799006|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	wKvsj8m3qEr/QHczH0qlSZBzg+b2nNEa8dDU6uWluXWqPrcM4YT77Lclrw6wgJ5DJS0muveDcY6pO8NyUL9UIHpYwwk+0QOGOMZ+jvvPtnRLbDJYPk3BOMSV3V3cOT61DGDgAS7Aah4yO1UiqWZuayEwQFIegekpxGM4DlXnURaCHOF5OQ2n8+CZg5n1AgQoZGm+xqTscNnJhPwZCy5cARfOkxiQYfGuPby2WH52wpQ6GQeKBrj8WW2fgAswawjkTDQuZ3XD4zJCPv0ASQIsQfqsTPHJTPFTRvvU/v3xuWK18Ey1chPCHPpEfzHgdRYHYS2GFJbqwucggSS+ZkssP1C8NsyRrX1ZCD563Vdwhmp9nOvEsNXop02akEoIovwnar0THcucwLT/Oi6NXXUB9DVX5zIPwpelvVykBN8l5/p2nxagQnobpiVgzlz/ATtaNNm6NPp8XHu6QazfTJJ0UQjtUafhKQEBMDem7l28DP5tBmglBKRv5e2tOxyhexL7reqq+j1MzMJZvxTrjOjwQyPtdXNor8X2fuJWoh24KRFdeRiUQ/XgCxrPERKrKTZ9Nykz5Uurrqiemvj4LByqZtvCFeS+hVK9mswAXVHOChZyEwaUs2v2KwmuwWTFiw2vLzABRblqSQtihUGbP/fAjC1J/d8xL7E6psrCj41uhAJahYi3GKfEZ74ANjL5Z5sh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EM2tx3h8Ybiswi6Dfw08JJ3Ppi04jQG1NxFNkmzNyl/1+2jEZze1GiXG6k6+?=
 =?us-ascii?Q?pcG0ISLoBCTRFvUDRpv6JAAZXdPb+qFQUyyg86dQeAYAqkAGXc+Uun4QdI42?=
 =?us-ascii?Q?9Gn6R5Pa8JYAK8Em+ccnr6MtA2rsNcFsSFFPEfwSfAHIC5Rt/yapFFDAqH0k?=
 =?us-ascii?Q?rrgg4+BaK7CxRnStCqDi2P672vVZoORiko5wM2yM4Z1irVEpKmaU7wM5Emrv?=
 =?us-ascii?Q?IP1ig7JTzZDRj9+hHLhMV5ztmWeDq6UAeYZwYtHTPBzHKiQKoxpP5H/whbqK?=
 =?us-ascii?Q?xcTp2y5wbsa5z4IRlLSZACHbnfVFRzlYDAp+nwhMykiO5Q0qSGyAfNuMnSBD?=
 =?us-ascii?Q?dpXKWj13XDLvHqNjrj1+HpZx9K4UqVed61UB0y6tG9kKL/1HsOGCQ1JTAu7z?=
 =?us-ascii?Q?k1OZ7MOTPeTKhhsxO1ekwkS5/WsmrWfd20kXoMwdjnZJQ4s/xcod049PXKYr?=
 =?us-ascii?Q?tCus0zkcGDND0r6NVkGps76l7jigzeCuLVgobuEqv86/5vrdCGSGSu/Ea3Pw?=
 =?us-ascii?Q?Axf03DkReEebW1KcJh5fGsstmqTDtf+L6BEDvvI27KDeKkeEQxpz8nfNuyEr?=
 =?us-ascii?Q?E5Dlg0m3aXn2H7+GAkN2WbVWvtTY5xxxoJm4tMlcp7ngvzJhEaCN9S4AXRSU?=
 =?us-ascii?Q?yN4nedSy24SPMTHjn5qOkiYCm2LGU3czcbCyBp9HFTzAP96sbjeaPoBZnPXY?=
 =?us-ascii?Q?pKq8SL81LoxrdRAZjd21qEUXwVG6+X2Ky+geZrKa8SCkiJ83sE4lrnJcyCp7?=
 =?us-ascii?Q?uHdlcrcsO1W+da2Zu+33gd15sAlOTW/Ewo/EJqpO/okfmV1zkds4c3dfl0G6?=
 =?us-ascii?Q?kQMTKqYr/0JUaOg7EaNJHmUFJPCZKTHcePeoXDckvawyxa5PswZSiBkmIMMS?=
 =?us-ascii?Q?Z9bmMdZkKsy+THV2XDZtJ8j37kf4zaz1yPI9DZFPPoTYbElIGEZWbAMg8U3G?=
 =?us-ascii?Q?2fYUwVwWBnu05N1eUISAhqSw6fQ8hO5F7vY71KiKrCYIN+cbi1I97oJ8N5Pt?=
 =?us-ascii?Q?1wWqV1T0kPhLEAWVV00rOCsVAs+0WVeMJ0Smq03xDy5XpjMKuqARaqPysgj9?=
 =?us-ascii?Q?htdiG+l9n0VsrBU48EWDNTmx+2jOg87tn2vTpFWiNo2F757wqu0bHtXHdz2Y?=
 =?us-ascii?Q?WEFKYcNgYJQCwZqGgsB0Af5uhRbben2CeVnT2Apm0l4VJWZT9/5af9qHNq37?=
 =?us-ascii?Q?A4Ex15x1sN6yIWP6bM6i+/WUzSYhgtP8w/9ZzcSl4VUVxe6a37Rcl9h5TWvy?=
 =?us-ascii?Q?MiaUAqGPFq9M5km4jEn8zBmnmxm8NSlJsG7iwgkc1k2rjXk0gvgjY+C25O/p?=
 =?us-ascii?Q?YR7080oneadBAy2MlpikoLAAC2UazOQ5T1w9ctYMo29ALF7v4Ho4vuXoZbrb?=
 =?us-ascii?Q?KnVJiaT7v//J8PJ7RLQQZNry5IV2r+viTtpSocLm2qXvi59JuLQfIBHEn6a1?=
 =?us-ascii?Q?eO7wml3Qt4BcIqUwSqn/yBVcnlZgeWTiAMxmcA9xb6QIvlvYa66YiUrdKOSg?=
 =?us-ascii?Q?NLilTtQ3nCw8XBZgQCIdXFJlvnrOtt2zDvg3gBROPZHPzAUFZHa6/LreWXhW?=
 =?us-ascii?Q?pnVLPENL///9oHDpoccK6i7j8Ru0VrM9MQbdgdgb9rLso9wDZALNL8LNo0jc?=
 =?us-ascii?Q?Qz2TZ936gglVu825W/mKAz1eZMs+8dYm2aisgYVLkQXr/f/9INuKT+lkFZjD?=
 =?us-ascii?Q?7P5KehF/WYKAocUT2btckjNljeE+jVCABVxEWTyWe3bs4NUpitE1TJpXctzK?=
 =?us-ascii?Q?QdjralQqxsqZAUfM48aFQZiRKbXL8r+wbc/9uiuBGhuZ7oEgKoWM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4fe80a-b349-4550-e00c-08dec69c2f2b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 02:58:44.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBWe16WL/lGC7MVZ5HDf4RiJ7jhSYvI/ni9OlD+PXFq+Yy7Y0geYuqUF6Gfif6W7L6p7kTY+5A0+dWT4G6dkrj2At91PEDvm36tP48YNGpExJQUBtZCNdnHfyR5yNqCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11387-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zh-kernel.org,gmail.com,google.com,lists.ozlabs.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,SMW015318:mid,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBFBD665854

On Tue, Jun 09, 2026 at 03:19:19PM -0700, Rosen Penev wrote:
> Replace the per-controller irq_of_parse_and_map() call with
> platform_get_irq_optional(). The controller IRQ is optional -- when
> absent (-ENXIO) the driver falls back to per-channel IRQs.

Nit: The controller IRQ is optional when absent (-ENXIO) and driver falls back
to use per-channel IRQs.

> Any other
> error is treated as fatal. The corresponding irq_dispose_mapping()
> calls in the probe error path and remove function are removed.
>
> The per-channel IRQ mapping in fsl_dma_chan_probe() uses a child
> device_node rather than the platform device's of_node, so it is not
> converted here.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsldma.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index c04a7fbd2ed0..eba194d64105 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1213,7 +1213,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  	spin_unlock_bh(&chan->desc_lock);
>
>  	tasklet_kill(&chan->tasklet);
> -	irq_dispose_mapping(chan->irq);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);
>  	kfree(chan);
> @@ -1248,7 +1247,14 @@ static int fsldma_of_probe(struct platform_device *op)
>  	}
>
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet */
> -	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
> +	fdev->irq = platform_get_irq_optional(op, 0);
> +	if (fdev->irq < 0) {
> +		if (fdev->irq != -ENXIO) {
> +			err = fdev->irq;
> +			goto out_iounmap;
> +		}
> +		fdev->irq = 0;
> +	}
>
>  	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
> @@ -1317,7 +1323,7 @@ static int fsldma_of_probe(struct platform_device *op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}
> -	irq_dispose_mapping(fdev->irq);
> +out_iounmap:
>  	iounmap(fdev->regs);
>  out_free:
>  	kfree(fdev);
> @@ -1353,7 +1359,6 @@ static void fsldma_of_remove(struct platform_device *op)
>  		if (chans[i])
>  			fsl_dma_chan_remove(chans[i]);
>  	}
> -	irq_dispose_mapping(fdev->irq);
>
>  	iounmap(fdev->regs);
>  	kfree(fdev);
> --
> 2.54.0
>

