Return-Path: <dmaengine+bounces-11469-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MqIUNBvYKmruxwMAu9opvQ
	(envelope-from <dmaengine+bounces-11469-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:45:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F486732B9
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:45:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=acuPsDlD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11469-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11469-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D973C3001593
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945B2BEFEB;
	Thu, 11 Jun 2026 15:45:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C22E413;
	Thu, 11 Jun 2026 15:45:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192725; cv=fail; b=tTeVNNvpFG8vTC7YYM/+hZN2M4+IvKpRaGZXpSyRtpuhax8faz7UHEly1AhXG5P5bqEsWtv/TxWqRWpyjPH7DuPVH0ARWjViA7wd36tym6cJwHqGNh7/7dq+THKXbgcGcf30UN3PUSOvLntKOW1VZ5kYI6LxwKjb7mpFWaPO9J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192725; c=relaxed/simple;
	bh=hbND+mI15as/JMr61a61Zu24Czjt0hFwTDnT6bWnpfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dGlqUWSilhAMzho6AgwkBnB7UtnjdonsksgARXcBf7mQdea/zrzgy0sNU/cRQXPzCex4aDsXclEi83zVl/VPrW0ekyXg59Ak78e1az2iAlYBSi4tVWGUTspIGY8NCcXPn8QpS40HGKf02x0nZimBJCIrJM/HYoH+dGb5nmcODKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=acuPsDlD; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqGBDwSy57vc6XmH7/4I/oaKZz+SwoOfJh/0QkHiX/UFeeLp7vYlWx06DL3OrnjLymJWMRj85XHw9sp/Am2q6hWiTa4ToN6Ul3OdmmCibALrqEr9fKs+VTWyOOSP6zwP7EO/X8Yw7zi49qt0oP20dka4WtFDdCssx9NWOgCHVHoSdThRzKFg2j4gmMGOrdE/q2d08YdX3OmA6pOK+JEQAxPC3gmJmgjsSEg7u5JIFI+cJRcns0QE5VjiUDPKliqShQG7TrUfIA/wK79eQklpFJvwRuVjcnOHuo3hW8gpX+M2tI9RNQkCBTZu7echvAozE0zSKj0C+NVWI0RRVVEJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GGJwsI09XMkzHEzZvSHf1Qgbz8pv17gqZJ2Fx5SNHY=;
 b=RfSHUqBll2HtRvsk3s6qOV1h/sQC1VI3lByOarzSl3JV+0zlkYqorKXKnKhzil18bbREy/ake0RRlufAEf4QJjJrYIxAg/OpGK8FEk2+1omKZk7I9P/DDUFUdx6eP9XRWsxLmmSr1loCI2MktifSIrXt6SkAhxNYX463iL3Af0e50oMlCEkoai/nc63hO7zJxyNkxjEYbpYrdf80McDHOXSkjJ5PRzAFbXdf1IAyjM0bKUgQ1dIwo20tte1u0afrFlx9NFERSbe4t1KdTIiAERqRvBu+I+qaKtoIn5+LOTOmOTqIHjoDdlsjEFFwFOG+W/ckMOd1hywNqNHCSJ7DVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GGJwsI09XMkzHEzZvSHf1Qgbz8pv17gqZJ2Fx5SNHY=;
 b=acuPsDlD3wUlixvx+rBhfI8ALIZzrTenb5JWA6cz7gUwUh8p5K4SfUTqUdGsdnGIF8OuG39XOwnvjHmqnPbsFkochhtOwhRpxDddjw5f28V2xojHCEmRK3Qe3yl6eyVL8ku5q8+aywpfZjzi3HGc2NnYx5fSQMHsSsP3dUfeYVd8xWCimJOTx8P18Yo0hWLK5uHcV2WioZzKZMVUO76sOflL2wNopYKrUt98TY/T2K6S/XwgcEJ1achseOo3OKpHA0yxSMyl8R2NsSu2JycLJoyxswdU1jCjbClVgoKe1UNywXsK7O0vkLhRYrta9GwqeRRLHctdZ8cZn1MYlvTHAQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11818.eurprd04.prod.outlook.com (2603:10a6:800:2ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 15:45:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:45:20 +0000
Date: Thu, 11 Jun 2026 11:45:09 -0400
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
Subject: Re: [PATCHv4 15/15] dmaengine: fsldma: fix kernel-doc param names to
 match function signatures
Message-ID: <airYBcTxaSuCMIhj@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-16-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-16-rosenp@gmail.com>
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11818:EE_
X-MS-Office365-Filtering-Correlation-Id: f3db80cc-e9e8-4053-0c89-08dec7d07121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|366016|1800799024|56012099006|3023799007|6133799003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YKzBi0nhiH1IcFIWgeQ9B07hSJiwUROgDe6ohVp2Nb7YclaJ5vsCwsnO9afiagdcuYOulODDqODhoqwu0MPH0Ryg/XGGwLYi3rym7w+x1JPbe/rwfyS+uFoWyW1QsQjtmM8NHyBXr9peRUnoAzRocg7seDX2VWy+IBJ7GrEqeZityKqjvTAkSTP4oHCwjOf2HVqfcY4LZ2sWusk2QuARfo7AxF/PCFo0ixXdgf4TB0e7Hz+YWErCmuhXHRuZLtoGkKke503jXcWbSLPJuxcTUdPnFOjaRsRfS+UlED42BLcb7Kz3wXxqQZH3IFRZVjWHuMvVv3nVWrfEcxoc7YA//CrYc1sm/FqqXV5dlgyQd5MIZQFuU4J6bAWD0rUEadQyGoMOiC6Kb1LnbSgjj1gMJRj/MQkI8xaA28GEOTzusENOmni4bEkE672nzunrjWl/yjY+VyM6bHAr6oBBqDS2GAjlvcr373TlvXojUDS3rQqOqUjRlp85BSYhJkiDsoLjOVx/ku+lV5qeAGaPfPGFMxOE8xR8xhNQ4i0Ybo9wYMutq7vY/VvFePqrCo6UwDV3HV7F6QRZObnxbvvj+YmNyKVe0S1LFCiOYo8pt4gj65YDaXcobP3jBcwG/M6pTHCvsn5kb2ZGYwB/rUgoU+mxnwkGalfDJhJkQfIhnHcCxVnpvrldBk9008q0cVmT52I4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(3023799007)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VHjucEikZac5mJAJUAx0LqbNO74M2irtBMZD6f0ap7Lv349DbLqPE9E6MUfu?=
 =?us-ascii?Q?OwFXEWbVFh30MdS5DrKHM6wjZF2wAhlml7uBvvuII7/ZWvQwouk0SJwT7yrR?=
 =?us-ascii?Q?wFVZ/WNMO5ZIfwdG6um9fjT1OZWVKnLvhWkvCr5CNRqLDVbodwMcwFCW59gj?=
 =?us-ascii?Q?MnU29lkSp8e2mvHRyZPsofGecCj2nOKfsSOZJZbS9VZMGQYYglEdrMU2iNXZ?=
 =?us-ascii?Q?S5HiCcLIYz2UBX5bvMi/6HkXRi1OVkbVHGTHlqE9/FPj2F349YgGULPPus46?=
 =?us-ascii?Q?gGlsJlQbVDa9OKGGM5ezg7Xl7gvEm2WVfLSQWg6EoV1JAVXgTG7bIsdL84gT?=
 =?us-ascii?Q?3ao1AN++f8EUPywX9Owj5SFZ5Z656Di2hSDWXc/doDE+8Ufs8gxVzJwsuN1M?=
 =?us-ascii?Q?D7/JZzf9FYegyMpTgyaydFQiFSIx0N32lLUWhc0SvlIFU39lLXrUs6vY91AI?=
 =?us-ascii?Q?ADi+FfynK2KUDAUVrKs/1SD1Sg+ueMDq4zW8BAF/QRguc3bWayi2dtdEHe+4?=
 =?us-ascii?Q?AUuOj9E2UYcwOPRc8eeh1Ui0aI3uu0EUdGhXB7dviVbbvzNTCNNp38CqbONh?=
 =?us-ascii?Q?9jN5vKi/FyJXFTINjNB2m/UTyq1kotrxC6MfPr85UzHpuVlNyyzdTAkcJXoW?=
 =?us-ascii?Q?pnrnkOGySQS5q1mgoBH4sMCZOPc9YdvveSrOKTtIKhSWmRFoXyc2T8BhEEjW?=
 =?us-ascii?Q?QZH92wnWA2hHL3XC1wkJo3pUt7nvVMcNWT+t+z1mmh6pETIJSiAxBrfiCz9Z?=
 =?us-ascii?Q?pM57McO4M3bk42D4vmlk3cyXaBcNLKfmLOjEeX5voVesQ8+sJljD4gTx4wTw?=
 =?us-ascii?Q?uCqfH/94HcpMVustEhutDDJLZim3qwC8k1P9rB2c9dOwLoROyURlUMLTI8MM?=
 =?us-ascii?Q?ntqQjpZaRiyBDjvxs3Y0OwTm8Siz5pSuYeZf0gHZD7MI4SOe9nHXyNS5kGa/?=
 =?us-ascii?Q?5fkSoCm5uAY1hC0MLtQp+DI0HRBYqhPtf+ZUM7M0M2UG0zLTfjlIpmejLO+G?=
 =?us-ascii?Q?68V4sqwWoEOCU4n9UDwXw8b6Er0UWA4R7GiIb2xdOX1hro5K1qDjbKFuGw/c?=
 =?us-ascii?Q?YzND7I5NoKD14aHiSRHaWHG57ARBtSqYYOBzN6k7/cvvmo6/de/QSSTbcFSL?=
 =?us-ascii?Q?NCpsF7YVIgKmm7b5SuuomyJ3BMnhAf0E9FMlBkBjoK5/dzV4Oklm4ZAlVRzC?=
 =?us-ascii?Q?3iQFJ8xOCbRqXorDxbRZPbjZcoAefhnxLaAu75H7/xyBWAuCJhYhwUet30CU?=
 =?us-ascii?Q?+5uvlA4oSpeMNOjGTW3+pA++3lOBhe3jH0y7a9HzWHgVsAML+b5pJVCQhPJo?=
 =?us-ascii?Q?4jxfQIHsgIYxYDrsqBtgG2nGHxe18bLeT+Stl/+48sqC8A8D6xBFSzIPxwbv?=
 =?us-ascii?Q?7A7DnhMQofLCkRcfwIn/b+u6qKxokZEASxVm56jO8FY+l6OChrpD1hx5pHQo?=
 =?us-ascii?Q?5lYC+vVJw1BZY7w8HPz+FGFWzVnqiKuJHVULpkavRrlQ2U4l+rbp0maKjuoN?=
 =?us-ascii?Q?GZ+uN45BOBxhXAbMy6YA/LgD4zOBhUCoDFNickL8klpNgAGcsMeYz0HzyUZg?=
 =?us-ascii?Q?zUcv8IqgYISNZhm88rQg4S9WO/65f6IuUjzLoNjwe4xf3RRzE36psxMirgt3?=
 =?us-ascii?Q?oTL504gpYN63wvYJ66HGgpvV/o0y4s3trw/kAwgbZZQTAswBfmD5zlRBWmBk?=
 =?us-ascii?Q?eD87TSQ2awcGH4XwdsikGjPXST7uKDKdnUbj39AoJrhHcNkSOVSFKRaAvENc?=
 =?us-ascii?Q?AG4SflZgkDDpoQa1Xm4ZNAtBriorRCgnY6CG0l6iQ9cfT8mYqShF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3db80cc-e9e8-4053-0c89-08dec7d07121
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:45:19.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+YGFU1KbU6MBM9fd5C3Cfwjje2iqHAmBUyINXU/oYIZtmrjSU+FPPIXT52Ys2JjB1/tBJtXuZp8BIOdIS4N0ykB525troQPzn19N7PzVzcMWqNyALpAvfNm2zpDuZUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11818
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11469-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.nxp.com:from_mime,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lizhi-Precision-Tower-5810:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9F486732B9

On Wed, Jun 10, 2026 at 08:52:45PM -0700, Rosen Penev wrote:
> Fix kernel-doc warnings where the documented parameter names
> (@chan) no longer match the actual function signatures (@dchan),
> and add the missing @cookie and @txstate parameters to
> fsl_tx_status.
>
> These are pre-existing mismatches that predate the recent
> devm conversion series.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Can you put this simple fix to first patch? So it can pickup easily if
need pick subset.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank
>  drivers/dma/fsldma.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 157db416eaaf..694c1b12bf2b 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -685,7 +685,7 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
>
>  /**
>   * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
> - * @chan : Freescale DMA channel
> + * @dchan : Freescale DMA channel
>   *
>   * This function will create a dma pool for descriptor allocation.
>   *
> @@ -742,7 +742,7 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
>
>  /**
>   * fsl_dma_free_chan_resources - Free all resources of the channel.
> - * @chan : Freescale DMA channel
> + * @dchan : Freescale DMA channel
>   */
>  static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
>  {
> @@ -878,7 +878,7 @@ static int fsl_dma_device_config(struct dma_chan *dchan,
>
>  /**
>   * fsl_dma_memcpy_issue_pending - Issue the DMA start command
> - * @chan : Freescale DMA channel
> + * @dchan : Freescale DMA channel
>   */
>  static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
>  {
> @@ -891,7 +891,9 @@ static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
>
>  /**
>   * fsl_tx_status - Determine the DMA status
> - * @chan : Freescale DMA channel
> + * @dchan : Freescale DMA channel
> + * @cookie : DMA transaction identifier
> + * @txstate : DMA transaction state
>   */
>  static enum dma_status fsl_tx_status(struct dma_chan *dchan,
>  					dma_cookie_t cookie,
> --
> 2.54.0
>

