Return-Path: <dmaengine+bounces-11461-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M3SyJtrUKmoDxwMAu9opvQ
	(envelope-from <dmaengine+bounces-11461-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:31:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD7867315F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:31:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Kuf5T7Ml;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11461-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11461-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E3530F8E19
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B3941C302;
	Thu, 11 Jun 2026 15:31:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7B26FD9B;
	Thu, 11 Jun 2026 15:31:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191870; cv=fail; b=Dck7VPqmtYl/Kp/qBxEXt9bhhClFsTsewe7GP7pUVsQuHDs9zekfaS9TFNZuNWssRC0bB7QMcA7Hw6mJYj/kFFnntFuWYFjkXkUgefJH5R+guxB8Pd7WJZpQvSPyCdkN/x6RHXUyNqtXR3vrATd9XfQO8/urFQxaJy6FWLDBo9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191870; c=relaxed/simple;
	bh=KeVUSzxormdWHFRGA+h72DnUs4Xxj2xiePVu/n6YJrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxG7j0BoAPF7VUq2u6BmV6fcLKrviq+v+CPt5gcWSuF1na6iozJ2ytLxpAFWyf7dsyML8lx/c17TbFtX7E3vgLjGiLrFXLzQeeZHFKxIk7mdbRsTSxFbvopYRxFXyxp8VLgd976md8iaBkryTz6sV13F2KUR5+aOERn60ZNr4i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Kuf5T7Ml; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlEeLgq1rFLY79iemhOjcluL0ndMmilYnxyr8qY1D5dYJNpNIErcByDkZPLGqiM2KNRS1Cla/5/wF7XvAmcuYBCB+cxpyOpVhQzRG1GzmJ6S4ZEJqrEaNFIzVffx5cRyHR4DSpxWYfaofnXBdhp9uc9aTI1WDG4PG26Vjxyjxc4QkYt7muA4krvG3eynbIF0iiSmzNRqPhGBmhelOBXPcmAiMGr7M1DwiaiPsoUBeaMzJ8AhWcUfFdnzGCWxf2Nfe3YQJ7lVP8oIxHi/gl0k58t9Da7IEG503GlX1pZZqfiRAZ8750GbN6o/4DXnqVnhrLJgzHBciSvcpnYOP3qIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyVaFPrwteUDnfG1vmyOcwL6d49lTLfDtRkpCIyU04g=;
 b=H5Q17G5okAzRGaDpoWJ783wfKi8+NRBV+FesbbOQ/I55LrR7tDPfigVtUWf/rc/E/ky4LEGG+ToX+TEM1dUbgODiW/JP7dp0qifeaxHBnchdHSlieHxvK5E74UPfzB5L/MnRrsZ9hGienzNS8aJpkY2vGtFKTJJo8f8BCvNE8moelmkiBhjo1wjreBkhicdkaOuOHbds+WV3m39oQanXk2F2XYGZNlr54lBlbDNVNa1IkvHldpfCBxjUc5PNIjFE2HBoyVjH0Pz6QWfq8g37zuTb+J3jQ5u/LfgNjCi9ZBZ8wSbDujLCq1lnB+OFr/pabs+y9u1sUkK6qcu3EI1lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyVaFPrwteUDnfG1vmyOcwL6d49lTLfDtRkpCIyU04g=;
 b=Kuf5T7Mlybwf7NWpPABxUZ3PB8HBa9Pp6u12OYqhPidqW+/liAWByS9894omKQ8XWSeWxeJUv8yb1EVCMjx/hYBYFDLoQEin66+XfsMAMSnUqtgP0pAqMRFGKPmLt+fEuQBgOL0/JtORmGxTRgOGkZ1/OSnFeluKOm/2GrythVGbWHv7fReQnAwYgJ2HyqsiFBrtX9wj4zPfoFOpK9RhK0kfRKeLdUOAnnuO9R2YObYupqFKH/jLYQu3L6W+/ingsBLW8A/vfDUQFPV5nek3T+rHliI+IYoLbGMPT/HJOTBoPIb3t6CFSsu5m+2EnGgx5aVsCHEe77w9Wod4BnWsDw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8361.eurprd04.prod.outlook.com (2603:10a6:10:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 15:31:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:31:05 +0000
Date: Thu, 11 Jun 2026 11:30:58 -0400
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
Subject: Re: [PATCHv4 06/15] dmaengine: fsldma: fix probe error path not
 freeing IRQs
Message-ID: <airUshPd6FcXvQGs@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-7-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-7-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c0d8ac-46ba-4890-d2ad-08dec7ce73cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|7416014|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b0qWpjYygQVmyWijVPu1O9h6KwVYzGjJC8bNZb6CLWtPWyCVvAvlNYWJ3DfxOupuDMlnJx6Vj+dVQEDGZ65bep+FDKopHNNNh6QQs6FmieZjuNRFwuCWWHIACmoZfnYmramtmTbzsmwCQhBvEdOe7Yc546zqIdPDXMk1JUwRLo+v3t3sc3vopJS/rdI8sXKwIbuB/OooLyVa+4L/Jud0Hm2df2EqPkaGEAVwd4jZeAGNDjG7mqb2/d5kLGsGrluHk3d50FGclZFtV03iWzIwkLP6B/77Hq1n1I8EmJ/UJedGcK+5nYov4gRc2dpx1u3NioZTV2/9tuQvb285mGLF1FzMN1HGT2hRDASqR4rqoTz31z+yLZnzyniKZGBDCMom5W5GSLJYHaCGsxSzZQ6ANjN+FzrYgmAaA2quv2wjRX0afQOC22sy1jRQVzFa010x/A+vkj21H7bgLAYvM/9Wy73PSOgXyZRHLEpQ30IqygWgYzUN+ktRDsxiZh9Md+uA/JmZ4A1dEa88wQ5rkass7NAHsRDHjrXNeGChS7EV5Qj5SQzemLJMa3esd6kXK6reMOZ0pEua2ygCF4lZHOXiKauzpiIVoYUkhXrFb7oRYAsA16k9lqQuozpRjvEyU3MG50kcB5/5eXFGJ/aWC5Q2K4puM/umYhi5BDGdEnXeGOOdap5nWxY56yQ7NW1ZNC/K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l8Uu8NHF2jbnPxajH5F7HKuH8h11+rIAfetOur0PbDoKK4+zSf4bp2g4SbcI?=
 =?us-ascii?Q?MIPLJxuPxbt/c2Kn/vwo4CzmMQSVcw5raUm89NEHwz364pfzTr7i/vfzJXbV?=
 =?us-ascii?Q?PVUWpx3AtmOwNN892lsqlWg2j7DLmlvn2/8tCHY+95aIy7z62cAvRYhWSFL0?=
 =?us-ascii?Q?Xeqp/WDnUC+dHhs9PQ5aYgSdOzMuWLje5Slh/zMjNNL0IB3vjOqvoxLcCKWk?=
 =?us-ascii?Q?u5f0psAoWRcPY/8fVa3CjT0/iw1CPNRKznDFZLPQJ/L+rPx5M+I3VWkDmTYL?=
 =?us-ascii?Q?4+QVdTeQR/0y2zE2TfUt4Qll9SCBwesAyCx/eHyvchNUpNRjhepC/KDeHYFP?=
 =?us-ascii?Q?gX7HRixupPm2G/lq9TaF/j87T4DSfKPP0mOUlZKAUoq/qPecGRjMxG/dD/dt?=
 =?us-ascii?Q?0y8JKlvBsQnvGpTGyHhjXLlC3HmBRyXMq+UjRgN+kxpzwFOrvz7urvQa6xak?=
 =?us-ascii?Q?vZCbTLhyl/1LBylQP7yUfM/6e0EMem9BZzLVQSdyeZAEY+mGCXQxnAwXAjBw?=
 =?us-ascii?Q?4DyFDf9nvNG735kibz8+p0fkb3Iyxe1pbu+WJsorqBbOWHeBqsiIdKakSy6l?=
 =?us-ascii?Q?6N8SsrFsa/3dOWWj6lMDTJAvmJRxz34eaTYxFC47yeRXu5RRRA0rEYC0kAGO?=
 =?us-ascii?Q?VaWLDGYWDucURdDwbyc1I1KU+guc8ouvglx83TZp2+M6XKlIsBgZpUTI1ZQ/?=
 =?us-ascii?Q?7o+RQUnxdTQLIwHGgDhYNrwpG2PxrP0X9TDcV8OUEeSfg3+fVwgDm4DhpepZ?=
 =?us-ascii?Q?aiSpMmCYKbVnGqR7nzVtinpTLMUXmEtVwXV2+JdRFtS4RBtkkbpBVWFwJzot?=
 =?us-ascii?Q?MzV3SJPP7AYwQWuxAb513JRPBLYDDynCfFNNFnF9lHYLX5a9RjeYyqt884qE?=
 =?us-ascii?Q?kSFi3U1YNyh+bMjnDfMzLPF3z8BUjjcnCxibgz4JV9zEHFBH/IRETP1Fkni+?=
 =?us-ascii?Q?2DUF1gy9vy3xbtIaF8/l+llmyERC1P+sIUfBAvu1NZfWruaXdHgpMJsR3VAC?=
 =?us-ascii?Q?K7T1JpSUjSng/aqTl0AseddPafEYeMs2ZhSVzCJ775ZH09iFg3hgARfWW61k?=
 =?us-ascii?Q?g7Oo/cFSk+vEI1K1UloLxWUHcWKgSa2b6I6xTrZA5iXvJ0+NyDhKMf3rAsW0?=
 =?us-ascii?Q?skHqk1fSIwuK/zCikB+/133L0MXHNMXlLjbNxZvdqQ64lcmbbsA0vZpY99FD?=
 =?us-ascii?Q?dEkT+tyXbjBputJTapowSBUIcGsfCS9faxisV3P9f41NPz8q93SQEiJ99tZC?=
 =?us-ascii?Q?Efw/mKTq75Wy1H2XGa6oHI3POj/6y5LCqy1OUtt2aM+U5BeyBxtuz+oLW/DE?=
 =?us-ascii?Q?/yu/7QPuHNTqdLHawi5nFJuNof/JeoWLJffNaD9e157vG7sBaIsvsslhvotz?=
 =?us-ascii?Q?wbSCqYTlLZPa4rQtw1AzLx87gF32yUkmgWS4lgQ7cT+agOwXdZf7+1D4BD4Z?=
 =?us-ascii?Q?DfM9HCULZiyM7gMmcWNa4USHD/MCVXMaLd6PcqcIBmhwiEDzo47kBYwoZF3p?=
 =?us-ascii?Q?k+xsKBstvWxgiOMeb6j1nYT1deD+TmqQ/PldmjEly7NCqvrDh+SBSR7uT5z7?=
 =?us-ascii?Q?19SbDThAbwD7C8AU8piz5b/Y8JNRF19QkUQXOIse2dwlYAlqWi0GoDmtMU7l?=
 =?us-ascii?Q?4bkzTVw1Nk0q9j7Gxt0RIUNKR+XrHka4V2JTcn/Yj/3bZfJNiERBlXvqqMmO?=
 =?us-ascii?Q?j4/HWs0BTusA5ktFncdRQDC9BjZy2Dr2c6xOKbOdgn/JEoyNOW/9mayg5aZ9?=
 =?us-ascii?Q?wWIKh9H7QGmgalRVhACqz1c1oRKNr/96o3uA0nVjuitus4ZrzXxu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c0d8ac-46ba-4890-d2ad-08dec7ce73cd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:31:05.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hFIlMvBIG31k/oFeNWSBgzuS/jQYk81frKzY1Op4rCnnWJhnxUADQ0UW+ch1S+CvaOXaYwro+tcaZP6dsxIiH/+Ba1HhsDKCTaZZpXqffaeSND6dp64yuwfTOICjSeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8361
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11461-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,lizhi-Precision-Tower-5810:mid,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AD7867315F

On Wed, Jun 10, 2026 at 08:52:36PM -0700, Rosen Penev wrote:
> If dma_async_device_register() fails after fsldma_request_irqs()
> succeeded, the error path jumped to out_free_fdev which only removed
> channels but never freed the already-registered IRQs.  A subsequent
> interrupt would access freed memory.
>
> Fix by adding an out_free_irqs label that calls fsldma_free_irqs()
> before falling through to the existing channel cleanup.

use devm_request_irq()

Frank

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 3009e1531292..4475d50a94f5 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1306,10 +1306,12 @@ static int fsldma_of_probe(struct platform_device *op)
>  	err = dma_async_device_register(&fdev->common);
>  	if (err) {
>  		dev_err(fdev->dev, "unable to register DMA device\n");
> -		goto out_free_fdev;
> +		goto out_free_irqs;
>  	}
>  	return 0;
>
> +out_free_irqs:
> +	fsldma_free_irqs(fdev);
>  out_free_fdev:
>  	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
>  		if (fdev->chan[i])
> --
> 2.54.0
>

