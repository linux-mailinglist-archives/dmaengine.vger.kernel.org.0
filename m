Return-Path: <dmaengine+bounces-8874-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCRjH185i2neRgAAu9opvQ
	(envelope-from <dmaengine+bounces-8874-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 14:57:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 367BA11BA01
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 14:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCF98307A9EE
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C734404F;
	Tue, 10 Feb 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aM0ctJ9/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020142.outbound.protection.outlook.com [52.101.229.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92E341660;
	Tue, 10 Feb 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731668; cv=fail; b=jshKRgoWjnB7hMe1ag+nT9xhw4MFVSWJEHUaQoOtAwe2Noqn9eLbSdXJC82rVHeHno5s8LOAY4z19Ub3vU9vLRqpGqq4hRyDRzhFwGGt7nUMkeAW+zTY/JhVq5mmyy1rOeeW/gvcDEDZkrF6VKzlhZsVQxHA/i5JLleJmgfhvU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731668; c=relaxed/simple;
	bh=isnBXLBGJiXU+MMtbw1ff57RCikSWpSt5p99pGKE4M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GM7OuK94t5mfR2mBUui+v7ja+4R614Ggj+dLxOA/e/UZeNBeuwv9qAiCs58swLnwIRvoDP1Ck+Oqxrxt4YD6KLantENWkpTtbaF5RJJm0C4hEFKJl2MKN1MPpEj3XoA+G0/JSL9oyF3mr7ARD3/xyxSC30wvsXV0spVQ3BZZvY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aM0ctJ9/; arc=fail smtp.client-ip=52.101.229.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQgqaNs/Ikyj7lpR26BicdhyQp6rcv4A7QxygJUBHyee5lKZ9A4S5xBFugeyjeruFAUgbiNf7TnztOR4qHr4cIutQJ3iL0Mhq4fzUbJn/NL3+CL8yaAw6VG4IXACzzAyuUM+Dq7lG4xbW/jct/U1BCYSN45NdJ8eyMGDI3sppNbPmxlvAsphfDYwwyVd8VTJnKmWb2Iv8SKppRrVcIoVIH2OtfZGeUN9NkWz1O+abW72bj7OkCG9u58IH6GlZWysjaK8MYaSWea+k1smCiW/tHDAGNykvcCw4GnAsjQSbqgXwBvfcVbu9Iv+WhwrGF20Uk0uWj52U/vbYt18w+U7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgFwTjt75wF2g9HrpGyVPLn3n7O2Nfl6mqFCS1bZxTo=;
 b=d7KqB8HBa/oig0HSqGvrMaTbSF/XWy7xWMErqrHn3ZciCZnXX7WSXAzNDuOR+vr1DxOH4JoSm+adii2lEeBVyJFhNvbt0oaknKHuoZU+J2FrO72fz7cFl7a9N0aROC6hWd4iu8/48YGlbX/l/dxMp+NOxWHKAdwa37L9nfNzUPDSjdu4Vo1JckkqXX6a6HfG5Kf/URYRNaI+I1Cf6C/HKEu0iw6ztm9yHNw5pNxurkIar631D5TQlfrdOJwMaUgywR2rzh5J7jk6/9hwfe8nS1FXYuSWkYkUwq8eDt1Qsb6w1WWpv/uNbWh5WU0bFWTc6juExV9j5HRw2NqOpBWPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgFwTjt75wF2g9HrpGyVPLn3n7O2Nfl6mqFCS1bZxTo=;
 b=aM0ctJ9/udKcE9wnVUvlf1Kq0MxOXUT8Dtb3k0v1WvtDKkQ7r2mLk/KxforyrFXSBF9rVC7WBGr46Rg7ateT0PzTlobV5L6reQLbcLAVLroKhaapGT2EIAib9QwiXlRav9+cJh1tu0UMEiFCwrH9IgCOmBuTET+8UtbGmAFWnNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:54:22 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 13:54:21 +0000
Date: Tue, 10 Feb 2026 22:54:20 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <uvuugqkiaravp6gmn6o7x5koyvo5zkmbwwbhdq6ctvvdtdhoyd@rnxwhlysqs7d>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-7-den@valinux.co.jp>
 <aYsmTbSmn94J6uN0@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYsmTbSmn94J6uN0@ryzen>
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 25680db4-00a1-409c-9fdf-08de68abe455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0Zmj9D0hysFsQDhlmOT4d8LNsvP9bA+/EuK6Xhy85vy9oe29cTggDF4nQMo?=
 =?us-ascii?Q?x1/MFY86tlJzuyMrtzF9IlBwjT9BhVQkXSDlqRyvgbn5wSj0aQesGV08OvtR?=
 =?us-ascii?Q?QK2fexHhRKKbSNOm+BFliFIL/ox58T8aRCdzHuefZNYhEXpoXMCNWn0VjqyT?=
 =?us-ascii?Q?YERsTdfTMb/Cbudem7FQrk4MhtXNlVw6zetBEYpFTghU3KejKAJEGmDsIQbX?=
 =?us-ascii?Q?PB+DLD/S9HIUOC7DxMZvtqb/mp6kUsh3h6SYWDnQi9K69RTXYHsQRYBj0e7y?=
 =?us-ascii?Q?L/QySDckCLcSW7rAMQ2KuTXyRMm+f1w84q5CMF4Crz0+Lnag+MeGTUmfTKGl?=
 =?us-ascii?Q?NpUOXpjxN10I/11o1UHQu04zTHBCcyycoB24d9qvd9XQGdBN0NKd6U8SxGQv?=
 =?us-ascii?Q?eHWSV7mwRU9B2C6vSYJ4h9cYB/D8TgyyfAKlBv9d1uC/bedk2Bv11u6wWfcS?=
 =?us-ascii?Q?etwzFRva17fgd9ww+QfPTBV9lTg+7AiY7q64xoNkT1jPAs4iFpKsykv1QE1H?=
 =?us-ascii?Q?lNkbgMd32tlVL+uljq9z+fs5eT7MgzrwD6aaXxsVkS9B3mEGlIgL8jd+QkFt?=
 =?us-ascii?Q?jrAU5Occxa5wd3Ffj56+h2XYWw8vvfjcGjsUmGkIW/rhWKGRRHvOHxSrXl7H?=
 =?us-ascii?Q?YP/HuH7d6Xxm0Vd4LUOF0dylGjU3pGIjCiR90DCXs1FVYEmpOi4T6xf3weTj?=
 =?us-ascii?Q?JUZu9Z7qXBDspfnYMWb4bR2x73DVywtvc7Kqngu/1kEZFqfjM1S/WWJTLfVW?=
 =?us-ascii?Q?YdZ2hPxjrjEpEJBttXEAjNOLjVr9wB+LnxSu0MT0DNJOA4vnNq23XDo5ZsT5?=
 =?us-ascii?Q?tR+QwBkG4c8cbQBtjLbtN3ou4NcIrzuTfItVYjB/ll5BQchrcTXCzCOb1omh?=
 =?us-ascii?Q?SzR87JlC3nRWIrdJfYDy3na+nIU35TTGdw85N2jJiwzZmV8RkaIw3pA7Ts+6?=
 =?us-ascii?Q?eTvjClTpEeLPfWIkCb92IrCHaftzv+OZ8soquFe/kQMT93PnkyMIpXnYDNlr?=
 =?us-ascii?Q?DBv93KeS4+Ry89+zIM8cTzsTm6zceWbEOihPreB21TXugnK/GoDJqiXirg+i?=
 =?us-ascii?Q?Quq3AAhr/TrAbdbDptNslmkJZg2oiI4nICNVSGWYoApLPN4kv+a98V6vf+sN?=
 =?us-ascii?Q?b8Q3HiZh/7m9ADF98d3xzw6i818UgChZUWt62+WOOdIGg4m/APvHPDDwV44o?=
 =?us-ascii?Q?W5xRcL5PMZW/j/pz1VBQzYO5ryhxV3BKZHB5B7m0sQK4jsqV+BxtCho8QRod?=
 =?us-ascii?Q?idxY9IahsYIIqi8/adeqR8GIRub2UtUG8cNMQwkIywH5cSGfCc20Mae55yPp?=
 =?us-ascii?Q?T3obNAIK1DeUVNo1PuqlkzNxYPUF6XDvE43LDWR7cl9eeMPOdaRN7nBRlTIl?=
 =?us-ascii?Q?sNSWNSo8hOQtaRuXRK8qN5q53pffuec5wDClFlvOfqTLH7q70+h8NIvmYMxH?=
 =?us-ascii?Q?Ptb5RGTPJzOhDAiSfICdsk+05CWbcG1T6Ummv8D5KzL5705zAZA4dT1F8cp7?=
 =?us-ascii?Q?BxDT+3QFB0EvfvPLNjEfPbd+tJm05ddmWNFjd+/CqXhsEEjAn7oMQO/x4cB5?=
 =?us-ascii?Q?BLhk52aJLA3RV+vpJkI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WMF4z38fAYTr2oYTdh1O9NXbLxlTn/pT4tn9xeoPjcp971KCnKE5Bbc43bDD?=
 =?us-ascii?Q?l/Aq4aD0bg3o2RIs1YjGAW1cFUQeescDgEm4Yy9bEJzB8ufAx1P0yUmCB/br?=
 =?us-ascii?Q?IQ7vSMPiaN3XSeqe0O9bkBzb+Oppe3xaANAWzjSqxLHdVLTXsasKM5+JoMzN?=
 =?us-ascii?Q?rlVgLgLpEljkqYaSvwkNgFI0RlIi/ELHiC64TUylOfORwm9/RUC3xS6lyjN2?=
 =?us-ascii?Q?llOGngrdLLmbcyDbL1QZRO6foJHB6IbyDC7Lm6GQxChgYT147+N+K3KU/War?=
 =?us-ascii?Q?NBIN4Zz0Qoh4TkcCv36D8WbXd9njhmYhphEc2LvZ35BPtyCJYS5Ru6gV3gR1?=
 =?us-ascii?Q?v4BMlOnaTHNw9C8BSqSmAzv+AFz2UD4ckYGDRT25lernzRMZtDjhpf/WSwbp?=
 =?us-ascii?Q?1+hC4iGoOMrnSUetg1jGpM0yWqDe6l7dSyChiaYdeaJPmiSalXu1ungFuo+O?=
 =?us-ascii?Q?e4mcFIWKoSKOlvUgVEsFm6Kb0Gy20qojF9Wcst7GiSGNnhrs7Dze8wg57fzk?=
 =?us-ascii?Q?pAFQr3b5ddB8DrB3eQTn71PdlIV/9Q8YRwx5V0qL9lDqcQiuY15wp2BIQ2aj?=
 =?us-ascii?Q?TDL1W9zJO1b4PiLg0gUTMkzwTAEtvWQLRdi8Hoaho9leJd5QF1wMfpnZ6Df8?=
 =?us-ascii?Q?SmcR2+Kts73NkbG4MhC5PgZuUWDKG4qopjqngBsAETjKH9r5BzSNi3a/Mfpw?=
 =?us-ascii?Q?WBbVFL+9MYUFBtThj0fHX+Yzs+BHpQ6ayXKMJNeqzwp05pCGArCGUlCWMqef?=
 =?us-ascii?Q?7hqqMektKjiTRIs97R3EcHEvCYsbjDA9ZOz2S1S9Ahr7FTGTOn4+c/Udhif1?=
 =?us-ascii?Q?ZPF49+CPBv+OqUjj8mMochzbeXrwdXlq5DM7hUTP2q6l9YgLApdu4woSCiJH?=
 =?us-ascii?Q?j1eeqSREnfwGsb9uls60wu458Kea32/C98FQSaR8SWyWwR98x6P/uXOdNU2p?=
 =?us-ascii?Q?mvUolscTBbwzI+WpUNgKFJ1A5tf/8jujq7n0soiXJFZa4GnErJIl6hnD833y?=
 =?us-ascii?Q?EoX0Shv2/sStPPB0OoYI/6nsz8q1q4fl96UTEingbSYBUSisFL+DU3jMDZhl?=
 =?us-ascii?Q?AJ/sRDcveDzaU1YtkjjLDhAt6cP8ZqMrSNbh4ZmE8ylRo1Q8Lw1PZW822ljn?=
 =?us-ascii?Q?5HD416gSQM0/f9NSiI+RbdaU9tnG7VuR+LjWbEbx93+0c5aBS3PKfvgU0sm5?=
 =?us-ascii?Q?sEmQKZk6PtkGKUowtwPwHozWKItyrG7mxotNoTJFLo4VyFeRpBNlqMecjnXE?=
 =?us-ascii?Q?2CE47IHTgrzDTCvzCx4BwVc7nFQ00L2MjdwswAi5r4MYdjL6cs0HWgl7bO6w?=
 =?us-ascii?Q?P66OTdam0oN7+EjYD7Z6iR5AqR+seXXiGLkz+RPWqRA1z2Lqt0gw2nwTn9bU?=
 =?us-ascii?Q?gbZPkIdcjmv73QBwsVXIbJnvTPnt2Z8hwPZANqa75xDhVZRemW41Y6MvCmzn?=
 =?us-ascii?Q?FCYar0TTgFJcf4CHVy4QlUTvywbMMPOG4dr4EPUl9nV2qBa5MLYNTD8IAUCU?=
 =?us-ascii?Q?KLEbnRJQXQBPeOeNCAl6p8jY9vDKf+jI6z9mZvY3LAzOjtvxTfYhoqI2RDvy?=
 =?us-ascii?Q?AJFatyhr6WFWwppW6VAxjHGnGsnWKSx1AJ1+BfkwuZPrgbb/DRk+oxw8hOJv?=
 =?us-ascii?Q?rIOtZTdiyG4G6HoXgZ5rb2L2P5UQsAm4xmSucGrmwOwetG0o/hjijG3Mh0fW?=
 =?us-ascii?Q?i6q2p5Q1GMb7lwAizizm+pIa1eQFz84X657Oad+IEygb1gNEtrL0PMxvzfue?=
 =?us-ascii?Q?bryWC+WuYe9oy2f5X0SCzWuWk+YeWwgJ0hpEWXORl22zf25ws/oI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 25680db4-00a1-409c-9fdf-08de68abe455
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:54:21.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq+XBdBtw2vlwoAARys5CNeDx7/FwhFL/XOJpuHCqIi4tlT/KCsIg3VFUPAao5wpGdTq2iB4rihi4UhTyzGj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8874-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 367BA11BA01
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 01:36:29PM +0100, Niklas Cassel wrote:
> On Mon, Feb 09, 2026 at 09:53:14PM +0900, Koichiro Den wrote:
> > pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> > the interrupt handler with request_threaded_irq(). On failures before
> > the IRQ is successfully requested (e.g. no free BAR,
> > request_threaded_irq() failure), the error path jumps to
> > err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> > 
> > pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> > doorbell virq, which can trigger "Trying to free already-free IRQ"
> > warnings when the IRQ was never requested.
> > 
> > Track whether the doorbell IRQ has been successfully requested and only
> > call free_irq() when it has.
> > 
> > Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 6952ee418622..23034f548c90 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -86,6 +86,7 @@ struct pci_epf_test {
> >  	bool			dma_private;
> >  	const struct pci_epc_features *epc_features;
> >  	struct pci_epf_bar	db_bar;
> > +	bool			db_irq_requested;
> >  	size_t			bar_size[PCI_STD_NUM_BARS];
> >  };
> >  
> > @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> >  	struct pci_epf *epf = epf_test->epf;
> >  
> > -	free_irq(epf->db_msg[0].virq, epf_test);
> > +	if (epf_test->db_irq_requested && epf->db_msg) {
> > +		free_irq(epf->db_msg[0].virq, epf_test);
> > +		epf_test->db_irq_requested = false;
> > +	}
> >  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> >  
> >  	pci_epf_free_doorbell(epf);
> > @@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	if (bar < BAR_0)
> >  		goto err_doorbell_cleanup;
> >  
> > +	epf_test->db_irq_requested = false;
> > +
> >  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> >  				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> >  				   "pci-ep-test-doorbell", epf_test);
> 
> Another bug in pci_epf_test_enable_doorbell():
> 
> Since we reuse the BAR size, and use dynamic inbound mapping,
> what if the returned DB offset is larger than epf->bar[bar].size ?
> 
> I think we need something like this before calling pci_epc_set_bar():
> 
> if (reg->doorbell_offset >= epf->bar[bar].size)
>     goto err_doorbell_cleanup;

Right, I remember this coming up in another thread.

The reason I didn't include the fix in this series, even though I added
Patch #6 and #7, is mainly about how those relate to Patch #8. The
doorbell_offset issue feels orthogonal to Patch #8 to me.

- the issue addressed by Patch #6 is more likely to be hit once Patch #8 is
  applied, depending on the platform, compared to the existing MSI
  doorbell-only setup.
- without Patch #7, Patch #8 could silently mask the issue, which might
  make it look like it includes unrelated changes. I felt that keeping the
  fix separate from the functional change would make the series clearer and
  easier to reason about, so I added Patch #7.
  
If there are no objections from either of you, I'm happy to include a fix
patch for this in v7.

Best regards,
Koichiro

> 
> 
> 
> Kind regards,
> Niklas

