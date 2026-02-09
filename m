Return-Path: <dmaengine+bounces-8839-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCfOHsrYiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8839-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2412010F22E
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB673010B99
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C9372B38;
	Mon,  9 Feb 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QfO7rpYV"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48037106C;
	Mon,  9 Feb 2026 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641603; cv=fail; b=DZKMeAeAuJdMXMboNct1mAvAMqt1etwudkw3xO9apEBuyM9NOYogYGFgkf0CC9Vbb3n3XaqtZ05uhArkDEC31Ys2mZBhKR595s6I89A5MvHS/gL1mVe8ZlWjbGz6+DRIac5dQqUP19jKCxt9IxDdQdHTSgkzEB1xL//UL+2USbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641603; c=relaxed/simple;
	bh=skEwvxfiIxQm0wDNcNgEu7Oc71wzHjFfSaK+g2VezxE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YXepWnX/azDX8SRw52gzaS8oPXgaCvWDRn0g59f3pWyBei//1bmezs5rfm0HpfqxWUKV55Qg6u2KhN697NlDqR1WUIMO0ibip4mf+ymRUKgUYnGszR9yTd+5SHFmPj7oFaZdXkxZv/qayfZOMYkegUCVlyJ9Fald5jPF1x0htrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QfO7rpYV; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2PL4GpjlMWmuzwM4kjzqQAFHqWKevt2VNOzbo89hJDgbMec9suiI8CkSmmjPAOnh5ZrVy7PZgSiJ8yPf4DSqLG98n15ijPM1PRkQByAxkPSZiukbSNXmYO416PTi3Trh8xgOCo298F9j60p5WPUbKQAqYqSmyj45sNPHIFGa3mq7fE/2qfqG3L9/FXslzJthhLDaRkJOxp/TdANYPcAUhPA+YQJfKdlMSxNFWvFe7XDsB08wJNiqJvO3C7W4dbsgmI/l4TagMf29GiNc3MfwXCF1nglewA0nONcJj/u48Ecqc1bQ400RznkWewKXgd9tWUrsdMejz7adoglN3icvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpbPy/YJ6QIFkMp1RFEUO9w/IQxUFqDvUjOBPkTd4YQ=;
 b=B9qvt5Inz8XiuQ4lCEDXOL+7/Y0+Dp0/NgRn/4p/9Pzu3Y6/dYArxHU5HkiYwFMT3poGGdfLe5m/koEUedw5JLXjZQD7BEHtZSoL3f6L75N6rkcP9HEtLY8fp/vti6bPRPXGuIraZ+AqPTEByjxaY4uYUGKFkvgKJdeXSyqL1Y2HGNfwuucFuALc1/ogZIzvTcfOklRh68/OmiM0jJ1ljOD89pQmmaOJ6sziWTzDRiJhqxJbywWDtB8AVKTZbFAqv/2N3rCiDdR/Yq9Vfu0KcKiMehYFG9ZNQ/bo3VL5m1Rf9IzG536iDgPK0QyhotYzA8U5ooj1MEC6z3mnDdn7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpbPy/YJ6QIFkMp1RFEUO9w/IQxUFqDvUjOBPkTd4YQ=;
 b=QfO7rpYV2TFYIovRfuZ8ARdncdADznsZeRRSeX1RqcukbV1IZxVy4OFKnPKa31Z5PiMwNA3fsC+mjAZxSH/kPkDkwIgRgBeFdMHqbf6qjQGJNiBq974WkSlkErXi5iAk6QeHH9OX8pcG26+JGlD+AX0kX4buagTl9toy12z5M8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:18 +0000
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
Subject: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Mon,  9 Feb 2026 21:53:08 +0900
Message-ID: <20260209125316.2132589-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 4556711e-bbd7-44a6-4042-08de67da32d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jf0y3ALx7DRvvxXtKzf9wdbXFlb719D8WemiWzLxwH+paIWW49HeCRXiJsnP?=
 =?us-ascii?Q?KLwP5ei1nWldU3+IVwta18lp+lhzGrEo6dwvg8I/X3tvAzeX/Ov8gvzqGei8?=
 =?us-ascii?Q?6X842YGFl4hsuEgxOhA3IZPgaslCSfz+l8zXTAdnHkWAKJYD5BLRU7P+ezpW?=
 =?us-ascii?Q?gEzfYqjwnbhRBIEYRWw5rO3iepdZ8LdqBBqwb2nB/7s457quKEsSC4h9L9tr?=
 =?us-ascii?Q?GzHcPRAY/uCErHWTHgmNKzc/yM8i/gNCCy1eJVItYf6QGnUQC3fhVewWRwJ0?=
 =?us-ascii?Q?5M0NugsgIM/5lF4cozbL35PQR8uh8gOLo7RxyF7YNeFfMXp36MKMsIkNB4yc?=
 =?us-ascii?Q?LiRxtq5ejua99kl4Qaj/W2oODobUtBUdxc56GoVQIhWXojzRVXOxzW+1LIx0?=
 =?us-ascii?Q?wmyZbtVTxyaiOqPbA7M+Mjr77RJ+zCQrY+YTK4tOwPBU4/zGd0l0lZMCsFlk?=
 =?us-ascii?Q?54Axzk4b2y5GyCntdIut3Zb2ULOi3vsIVWMzPxiA8wueqjzE0a6dXPxGwJWB?=
 =?us-ascii?Q?U+uEfIvj+JDqQ3jzMG2P9BeJ6AmRFe/pwGML8/NdJFzd/8iDawDDam11FYPr?=
 =?us-ascii?Q?T9xGzeapDIz58vsk9lsDQzv4AMcLBNWO23lin1n8RIy+uVlpTU3Af+xccyAg?=
 =?us-ascii?Q?Jt6tUYUwZcWn1qSPE/+Cwr9LQ07RyD8zjTd0k5brPnD7+IsXinAlvD/1Wn2G?=
 =?us-ascii?Q?fg1J1YpeU+B211UkMhpFUoiKigS4OYkSzNbLVGZ8TG6BMwbHM2dYTOxhsxhP?=
 =?us-ascii?Q?qNuAHzfd1eCPOQNhQklij1G1VId6ycWgNirxNl4meFSApc7xT3vLa4hjpXua?=
 =?us-ascii?Q?4q4M+MSkMOoSVjFOYDpQx6QZlxUpJC0NCnsGdyUqhFFgN6VSKPoutSgwj7wF?=
 =?us-ascii?Q?MBHxO7nr7RkW1aENJQqXHJj7NDNg+0ZOLdYlIgsLhmM5NsSe6vUQiDjsI9XP?=
 =?us-ascii?Q?hFOHavuqvpsR8YceQ4AKbAWBzauXUS49wIBUEDKiKmOr6rIb5mxDq3X/7MOn?=
 =?us-ascii?Q?G2uJnTfVrXnzgstfZLQgKMk1bJ9DwtOiqJLS7dp1GHDmf+TNTY+kp6rqimDF?=
 =?us-ascii?Q?6YK9kFIf2DFtoR0un6RmYryjfxDlFbgM7xVPVqIYRKTuL8BleasVr1CT0GFD?=
 =?us-ascii?Q?9siIfUkXzIAtn73FfbTUEDzXZnUctOOMLmYEadq/pyzoNahPCZAuA3LQ/X8x?=
 =?us-ascii?Q?k0OLz/S3PojcAk5QdbmAWrJ6fRnF1X08/l1ikvzgonHDq2HKRnGHE6rpYrZX?=
 =?us-ascii?Q?tuLrxAXsBZdBkeJ+zlbpXOcGOI0TUcvmTaaM+ymK/q/HzxvtOfN8YPhBzPUL?=
 =?us-ascii?Q?TBWvbb5Gj/J9lCCaTt3XNNn7MVtHkYeSfjMR12RBeCB5aV+bSu1PyQQeXr4X?=
 =?us-ascii?Q?+o7pE1exIuzSC6oi9do5o+6rk48M+p7iQSaRoQvXSXRauhBnk5w5JBoP16o2?=
 =?us-ascii?Q?t4BaprkE5JloGWdcqkjnBdPGX7dQMhcx4CMiraIRaRsuLeJ7921iZg0Ee5V8?=
 =?us-ascii?Q?eYgxhIKJXFVmYXyC0WkfeWRxn0IkAZt+t2JH2I54J324VD1fOH8uVVihLyBZ?=
 =?us-ascii?Q?3Ona+CLc/iOw1AKbV/s0bUgjwx01m9fkC/lpRqThRkcniWv3uzmwScWDxXDq?=
 =?us-ascii?Q?c0H965I2Fpdz6ewc5yquwuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ghJzRqhhi2WeyA6lVjsZX8OA4BDvutS6bDIKMpi1DAEpL2oeYD557Vr1E8Xg?=
 =?us-ascii?Q?9AQhxIVN0RAuJFF+ayxiJWqqnMkDd84uT/4Zahv1y5FSuFoy62UIHbPYLvZ0?=
 =?us-ascii?Q?BMnlY/x3rk2qXwv1Qjgh0QDAMjMShiv5/CmXETL28UnhXRoGiNYs2tLqXjBE?=
 =?us-ascii?Q?arbxQ/ysABMuBLPsNKh/NOmYJhb6VH84wRif+/LtsLDDc4c4QGSrweUi9s4r?=
 =?us-ascii?Q?Y9Yrk5U4ErE7ssvM+bSMHDjUMkKFo60j4PS9GJz1Z+cksLFbNgE2eE9qQNEU?=
 =?us-ascii?Q?CW2INKVFEKxYzLKdsVV364wBVw8ZzyRhS7nu3YVSqH6elq0xwFHaK0SAWGOr?=
 =?us-ascii?Q?WyT+VhS+cNXm/BtL2ozNVdnYuJ9DN94yk4DJLj9yPlq0zXgTufXfrQ5bqT/y?=
 =?us-ascii?Q?OqlZ0edlNgqLHTPRKa6Rl+05llOe+nbFMEIoMEEywn+qPBUMq1+O9gltt047?=
 =?us-ascii?Q?7Ei/gKhUoD2intiTnkjWuIiYyQk2Evv3isxvN3UmjRqPkrzcV7v1HQwe7/wD?=
 =?us-ascii?Q?3XvYO4tZt9JbxxYXI/H5cGtbCMDhOCsXFj1scj72ywIlIWlywcnwdh22KafF?=
 =?us-ascii?Q?90HDEmaSfV16gj2cIuDxONjNv3Tn18nsjDkr6JyLrNUjIjDeW3oOg/0kgHw+?=
 =?us-ascii?Q?APngrPNq0LvX97EJbTncXcPdpYNAphgK4wk/X8lRiu6BmUBob1htW16Smbti?=
 =?us-ascii?Q?yO6LbSCabG3mtezABns1uF4VrVjlUdHdy78x25/Xi3agzbKZGuwXtMYe1CRm?=
 =?us-ascii?Q?hHNYcxDSpGanDYTRg3JEScV8Z8m1iNA0rNxcV1YxH6LDQDe8xRoBjNQ/82A7?=
 =?us-ascii?Q?wFBqV9dag9AyuQ43QldayftpxTYvXAzlLr2n2zuXF4OSwSVCQjgLSpajm96A?=
 =?us-ascii?Q?+7VZw0EK3HEO1noGxPJXsPaQnOb8x//bcdatQ/aXHjnpztUeJqNi0+/Kal1n?=
 =?us-ascii?Q?kPHaCZABNdfoLoQWH74acUvuWyBGfTgYj3D7upv5XV2Nu3GMMOkHXKszF7Ae?=
 =?us-ascii?Q?HSV3W5Dqhgexd/iuwbZslQ4IMnmjPEjAkFtEnz+uLCKXn7/4y8SWucC1D2Jk?=
 =?us-ascii?Q?WyTk2CeLlCbIHmYvqxlMXbGH/MSitmgcW0oLT+dAfuhhtwat8s+8btjqjYpZ?=
 =?us-ascii?Q?2+UWgtlaxP/FQjaScutxOrVg9261s+jbbMnpHMIEoDYEWOemrVQ0BSPlbAsu?=
 =?us-ascii?Q?IVPjhm5JqNvTlR1BD1HABfb6U5uotafPsT408SrVl1sUPS6I4M4ccvdDEWnA?=
 =?us-ascii?Q?mLMactwhN/sJRi8ub9KZj+P2eo7ArcPulWYOcpgOBRuEN5KhZKBguXIulTE8?=
 =?us-ascii?Q?KAAHrAbhcincbUpAM/SyyFRhUv2fvKlke7Gtk0DNCF3rVLBnpccdzXVn+1x7?=
 =?us-ascii?Q?QU/ZVGdU3MBZCis4xU+B6+J/o+lRc/waNgzN7PxHsvfBY3G9rSdjK9ZBcmBS?=
 =?us-ascii?Q?BDwYfZlnpO8PVefyQgWo6wuQtntGnnK4818VyvQ0szDvI16dIbifX1Qegnd1?=
 =?us-ascii?Q?UHuvVBzgMzZypl02uXAYEYmjyIG8N7IB94GP4zGXb3tnBxqfthLQyS+5FrdC?=
 =?us-ascii?Q?TKMkf7NQIB3ZltTJukAvZ9wVkfsQbKYgnMwzEofggR/Lf2sat2zKqdyAWm13?=
 =?us-ascii?Q?Gow/8PEpaU9S6+U7RgxWsoqtB3mBCFxMVnFE50bD2i63+6VrQfZyl/RpvZ+a?=
 =?us-ascii?Q?GbaLpKfkP051sWD/YDwpqUf+G3ThCqHroU06vw0FfxhWOwVePQryaUmM2VNw?=
 =?us-ascii?Q?8Cp06o4GFFV+4uKaeDxWfj0TunmL/1c9bxQp+mpT0GZajbLxsN0H?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4556711e-bbd7-44a6-4042-08de67da32d2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:18.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RouwRf2N3LvSxIRAdzOc+espV6cPj3KRaFpLqsFXkPJporVVvqJzLuehIZ0s7z3zIwxxB5Ud93r3R/qw1qxrvQ==
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
	TAGGED_FROM(0.00)[bounces-8839-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 2412010F22E
X-Rspamd-Action: no action

Hi,

Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
instance alongside the PCIe controller. In remote eDMA use cases, the host
needs access to the eDMA register block and the per-channel linked-list
(LL) regions via PCIe BARs, while the endpoint may still boot with a
standard EP configuration (and may also use dw-edma locally).

This series focuses on using DesignWare eDMA emulated interrupt doorbell as
a pci-ep-msi fallback, in a generalized manner without exporting any
DesignWare eDMA-specific API.

  * dmaengine:

    1. Add explicit deassert handling for eDMA interrupt emulation in the
       IRQ handler so level-triggered/shared IRQ lines don't remain stuck.
       => Patch 01/08

    2. Cache per-channel IRQ number and an interrupt-emulation doorbell
       register offset, so integrated-controller drivers can expose these
       to EPF users via the auxiliary resource metadata.
       => Patch 02/08

  * pci/endpoint:

    1. Add a generic auxiliary resource enumeration API
       (pci_epc_get_aux_resources()) for EPF drivers to discover
       controller-owned resources that can be mapped into BAR space (e.g.
       an integrated DMA MMIO window and per-channel LL regions metadata).
       => Patch 03/08 - 05/08

    2. Add an "embedded (DMA) doorbell" fallback to pci_epf_alloc_doorbell()
       (used when platform MSI doorbells are unavailable/unusable), and
       update in-tree users (pci-epf-test, pci-epf-vntb) to request IRQs
       correctly (shared IRQ constraints, required flags).
       => Patch 06/08 - 08/08

Note: As discussed in the v4 thread, v4 Patch 01/09 (dw-edma per-channel
interrupt routing control via dma_slave_config.peripheral_config) is
dropped from this series for now, so the series contains only what's needed
by the current, concrete consumer.

This series evolved out of:
https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/


Kernel base
===========

Patches 1-8 cleanly apply to pci.git 'controller/dwc':
Commit 43d324eeb08c ("PCI: dwc: Fix missing iATU setup when ECAM is enabled")


Tested on
=========

I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
R-Car Spider boards:

  $ ./pci_endpoint_test -t DOORBELL_TEST
  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
  #            OK  pcie_ep_doorbell.DOORBELL_TEST
  ok 1 pcie_ep_doorbell.DOORBELL_TEST
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

with the following message observed on the EP side:

  [   80.464653] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback

(Note: for the test to pass on R-Car Spider, one of the following was required:
 - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
 - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)


Changelog
=========

* v5->v6 changes:
  - Fix a double-free in v5 Patch 8/8 caused by mixing __free(kfree) with
    an explicit kfree(). This is a functional bug (detectable by KASAN),
    hence the respin solely for this fix. Sorry for the noise. No other
    changes.

* v4->v5 changes:
  - Change the series subject now that the series has evolved into a
    consumer-driven set focused on the embedded doorbell fallback and its
    in-tree users (epf-test and epf-vntb).
  - Drop [PATCH v4 01/09] (dw-edma per-channel interrupt routing control)
    from this series for now, so the series focuses on what's needed by the
    current consumer (i.e. the doorbell fallback implementation).
  - Replace the v4 embedded-doorbell "test variant + host/kselftest
    plumbing" with a generic embedded-doorbell fallback in
    pci_epf_alloc_doorbell(), including exposing required IRQ request flags
    to EPF drivers.
  - Two preparatory fix patches (Patch 6/8 and 7/8) to clean up error
    handling and state management ahead of Patch 8/8.
  - Rename *_get_remote_resource() to *_get_aux_resources() and adjust
    relevant variable namings and kernel docs. Discussion may continue.
  - Rework dw-edma per-channel metadata exposure to cache the needed info
    in dw_edma_chip (IRQ number + emulation doorbell offset) and consume it
    from the DesignWare EPC auxiliary resource provider without calling back
    to dw-edma.

* v3->v4 changes:
  - Drop dma_slave_caps.hw_id and the dmaengine selfirq callback
    registration API. Instead, add a dw-edma specific dw_edma_chan_info()
    helper and extend the EPC remote resource metadata accordingly.
  - Add explicit acking for eDMA interrupt emulation and adjust the
    dw-edma IRQ path for embedded-doorbell usage.
  - Replace the previous EPC API smoke test with an embedded doorbell
    test variant (pci-epf-test + pci_endpoint_test/selftests).
  - Rebase onto pci.git controller/dwc commit 43d324eeb08c.

* v2->v3 changes:
  - Replace DWC-specific helpers with a generic EPC remote resource query API.
  - Add pci-epf-test smoke test and host/kselftest support for the new API.
  - Drop the dw-edma-specific notify-only channel and polling approach
    ([PATCH v2 4/7] and [PATCH v2 5/7]), and rework notification handling
    around a generic dmaengine_(un)register_selfirq() API implemented
    by dw-edma.

* v1->v2 changes:
  - Combine the two previously posted series into a single set (per Frank's
    suggestion). Order dmaengine/dw-edma patches first so hw_id support
    lands before the PCI LL-region helper, which assumes
    dma_slave_caps.hw_id availability.

v5: https://lore.kernel.org/all/20260209062952.2049053-1-den@valinux.co.jp/
v4: https://lore.kernel.org/all/20260206172646.1556847-1-den@valinux.co.jp/
v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/

Thanks for reviewing,


Koichiro Den (8):
  dmaengine: dw-edma: Deassert emulated interrupts in the IRQ handler
  dmaengine: dw-edma: Cache per-channel IRQ and emulation doorbell
    offset
  PCI: endpoint: Add auxiliary resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Report integrated eDMA resources via EPC aux-resource
    API
  PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
  PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
  PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback

 drivers/dma/dw-edma/dw-edma-core.c            |  57 +++++++-
 drivers/dma/dw-edma/dw-edma-core.h            |  19 +++
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  22 +++
 drivers/dma/dw-edma/dw-hdma-v0-core.c         |   8 ++
 .../pci/controller/dwc/pcie-designware-ep.c   |  78 +++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  38 ++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   3 +-
 drivers/pci/endpoint/pci-ep-msi.c             | 130 ++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  41 ++++++
 include/linux/dma/edma.h                      |  17 +++
 include/linux/pci-epc.h                       |  46 +++++++
 include/linux/pci-epf.h                       |  17 ++-
 14 files changed, 460 insertions(+), 22 deletions(-)

-- 
2.51.0


