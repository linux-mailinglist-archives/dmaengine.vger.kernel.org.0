Return-Path: <dmaengine+bounces-8414-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAnCGsovcGkSXAAAu9opvQ
	(envelope-from <dmaengine+bounces-8414-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:45:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 132EA4F4DB
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C1B3A0F8F4
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 01:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7989B311964;
	Wed, 21 Jan 2026 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LXiijxHg"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231130E825;
	Wed, 21 Jan 2026 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959861; cv=fail; b=pv5pPcOCCMbI+ThV3Hveiri8+ttJdgOI6mkI2iSxlm5n7Mvv64IQO59VusP6wQBBElq6AUIRLHGQB0qYWapi1bfWPWi46eYOOPyH04yi+viPJu26Fc1Nl/Y8vqT3eVBwBLoXwCJD+jKzBFVQDpfD//tF4j70a2m5JN+PIPOPk8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959861; c=relaxed/simple;
	bh=8god/nDl85lBTe/kx5w1gXFhuGHVQyTOtysalX6fUZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGpNxIvQAl9eWVpRDxsgKBr8p3O1aGrBKD1LHiOZAjz/raM7A514T/gYCwXR6DBYHix9nmjiKNUOjHEp3XbF4fKahs05djYuJ4WAlCKg9Mwd1kGXfIf/7ulfbUkXEa2GoG6qJQAbx5ofpOBRpp4N7KsmKnzTPtXpdWem07ihfdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LXiijxHg; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDYDLa18a+gBMkVVLfrgwl+Tu2zE4jzulr+Kh64sxiwZalNi6Pugxbwh4ZukX7eUKkMO+7xK/nZEUvw9FLq+bAwDGhdSn0rDaOG++hc1BEgOpaSMNKwRcSWu7pJiZKN5fPycVCVnhF5CxfD5y4i8ObWnN8wLfretf5nkpp8jsg+iFzBrMlfh4WCCm0SAmOWRssRr4MXtTiFGJSHrnCnd4FZM7zLw0jAYflhpIBYy8gr01pMF1Xz/qlP5z/31u2FdM21rxa5u4++0Anx6bByaRn5uDp9gJ80HChxIUz0Bwq3dpNQQRkeyBGfGL4m8zkwus7iyA0lb5g8t62ODNpBYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LCSDnM4C182OdOzkUxJYvCagDrYwbTTqyRIr43EvIA=;
 b=svTK5QUmHaV8OcAUhKopJsu8/jNXnuaWvXXf0kvMoXO4/WtzAs6Dksv3YAL7c120rDXV6EJZMKDy/HDB2EAFP7906huFWeUO+9iaYF2zLHNmpxvt3dc+bJ2V5Eh/wfwwCRpEFLTyzQPPzyBbtttnLBHrNpiSAlfuzF2MzDb49SoPEnBfr94sUlNn1GB9vZL6gf79xlKtUdXiMBjmM4j8j/Fe12k/3bncZYWa0LCa7wGCj+4xo417+KT1D5DMLzq5lF0w/x5YXv9d4c+c2Zv1PTfwK/pEaFotGcnD1kaSI5V5AW5jbAURf3ztJGFBIW0KQdkKHuVZ3DsRM/XIcuRo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LCSDnM4C182OdOzkUxJYvCagDrYwbTTqyRIr43EvIA=;
 b=LXiijxHg5ZEYSx5qbG+wxxIRL/t5BA51abou+NF+wcau5gIHQ2LcV52KEqCvqwQmMKDXl32IOmqzGCMZJ5S9LkNA78sijELkmPQ1mBF0Baxv7ZvqOoHmBHWwcuiFa/Ixkx8bb5lTF6eMFBhFyRfwjAalooDwE29wL/m95MUqwGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5505.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:253::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 01:44:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 01:44:08 +0000
Date: Wed, 21 Jan 2026 10:44:07 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 11/38] NTB: core: Add .get_dma_dev() to ntb_dev_ops
Message-ID: <mfvy2vvs2272mq5qsstpluiir4ww4sdp22mj34viizr4dgwjt5@qhy2cr4rrjm3>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-12-den@valinux.co.jp>
 <aW6PbmKpYVxHrnJE@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6PbmKpYVxHrnJE@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:405:370::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4e2808-671a-49ba-650f-08de588e918a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qVfo3yJ7SpK72YE6YeaZiY4HrtF8M9AjcqA7sUX6foFPHUgPgSASHDtHgkNs?=
 =?us-ascii?Q?yVUnGw0LKh7WcgUm1kkdY41rpJVcUbqH1jOhHfgVkqtDED0MYDynIkiHJDAl?=
 =?us-ascii?Q?YagP0fr5JqLJJIKrDSpVg7vB2/TttI9fWq2iTayUf+CiUUJx2PrM1J600HYO?=
 =?us-ascii?Q?7W0puC7gR5YdKpaZPwkADak9xzNOtcV9nZvMyI4D7v4a8LyzMpil/DXLn8hp?=
 =?us-ascii?Q?2XT+EWun9P9VWnp5sNepwLZB3nURrKovPy/tGLIdGQ8bgBSnjEmpGBbzWWQy?=
 =?us-ascii?Q?dnTQFv6sZZCysSSSCbJc1fVfMQ1W5oOumI16Iw6KePJzwuuDy70SivrTqHr3?=
 =?us-ascii?Q?axWEcAnXzexJTqRJharcgP2+stBbUXwxN7Ka0fenIT1DhX3eR8U+1iGHX67V?=
 =?us-ascii?Q?13kN7ERN+qEgeOpaEAzA9oyPav+1+flHb2fgaQxNXGEJ3O6o19PSutmOQj7T?=
 =?us-ascii?Q?51+QX9Ez8l1i6/UL7V2HNTJnURzUSjX1BCDoUd8T1kN/klXg5BovF8JM9/Ns?=
 =?us-ascii?Q?ptHJ/h8i/9Bk2clUIqCj79psp/Y8/NyXk4Qe6jOK5p64xiX5eBNWWkIBaLUY?=
 =?us-ascii?Q?vlB7rG9TkTHWX7QYTGVeKXZG/97k7N+6tA1XypNOAq36EaLCmaxfIOsIULCM?=
 =?us-ascii?Q?DzXctk4tnWYLTQeZIQ9LshxhfWz77/mC+s/6nYiD3C4/UwWLIIFvPWsGGR8p?=
 =?us-ascii?Q?tZHtFndgI7xzqafT4YPuKyzBmJo5+koVJ/QzOsVfzp1KDLoUgumMkbQVhF8C?=
 =?us-ascii?Q?THomSOSKNHOq4v2AgUqIs2xBakkoEDimsl9ra5SZAP0JRAp1+JVSK9++puYX?=
 =?us-ascii?Q?WA9lAo3QVDnlc2Ujaknuakp17ADoSAR5iy53ttzpOXcs5ETzBF0O9KJzm+7K?=
 =?us-ascii?Q?c4AmFRaNEFmFnTqEW/AbWmb/+WN27mHUFlPDH1Ucdjltpe9/h1jMSKyTZuTD?=
 =?us-ascii?Q?Tni97dr+a9f8vMKWSXuRRubsVklObSwZHWTWKjM2xnsggt+8kHFZTXzAk60O?=
 =?us-ascii?Q?PgJ1WTHYOcLrF2X0oTkjnkekFMtpJ+vvIZaq1cJdYjhz1qqMUATwGUkfysjb?=
 =?us-ascii?Q?0xZklyvvipnCCrlr0cGIV7QztY5ueB3W3HQFlnYJOR5WojZnNZzDHzwCjaaQ?=
 =?us-ascii?Q?Ye3NfcZYaURF6RL32GEh79i/5dsPlJwTZjfpunWreeT4whOs7+VWQtsAxdCh?=
 =?us-ascii?Q?U1bP4pKu42VWY6Ycr3HRYt3r4q+RcbwuzTqksoWytBbeVoE8uU70UOtjB25/?=
 =?us-ascii?Q?hkmeImNscabwyPw4EgYVKhMWFMIGzjuNpdqQ/Gjf+4tYsxTLh+gu97Q9Oa7t?=
 =?us-ascii?Q?g1MHe6K29d+JYs9h9bbgMBYohUbAKz57M9aBfK66zrRkVmZlPEf+hsuSGMU5?=
 =?us-ascii?Q?Dxvoki1Q++/p92PJ3ZOwCNUuLSrE3dQkeMg90B/GOurTntbqopFsQmb/tVIJ?=
 =?us-ascii?Q?jl5N6+gQf+YVuNsc+qo//t+8qKbZ7qj4hvYiYJ8+dkGdPfOi0/eHiJH2qgl8?=
 =?us-ascii?Q?Y9aiXBiO7Iom6Yuutl5NjcHhhYbirBa4RcUZf1p7QktxYWONg7VJewQ4HQfX?=
 =?us-ascii?Q?hPE3iy7mA4PpfJfehoc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVOeHicPzteWZojxzgvg/34mFvj0stMNXah06BIqogI1p5Zi7R3RimF77DVG?=
 =?us-ascii?Q?1bXYpkhXXU8ie02IPU7Wbb8kHSXR/ATH/wvClIC13ohFN2y4T0MbqkVqghFT?=
 =?us-ascii?Q?3izHtqESUECCFKciLn+7joCYrkBFlRiaHxTqlqBzEn1O1Cr2UHe9mw1l/Roo?=
 =?us-ascii?Q?McQGN6V7Jw5+B+HPQ/tnSrUMgcpE8omjjSuFwTKXFOlqgmAchGpJ4eQ1shPh?=
 =?us-ascii?Q?tpDhsAEBCKBVbvm+C2QyMt5MJiZEVQTycgoIuVFeJWCCPHLvfJE23Rpkg0ik?=
 =?us-ascii?Q?1SrcllyeckUv01clBNgdVt/3TzSKXx9jqPwsIQpQVrVJIFmZ09Qbdset0sKn?=
 =?us-ascii?Q?QAOlMNrdVkviyq3bLafDF0yoQMcsGNwDp7WNGzOr5hXKFyvbAIVE8O8MNf3n?=
 =?us-ascii?Q?oeclut73k5EuL1/W2kjPGsyu0emyzSymFCYxUu13sEHzo6L3BMI8tbw7x0ez?=
 =?us-ascii?Q?5KF00e8PhaALYfFkOqQ0xX4ernNi+NKWFgtCITeCaV1bU8cY8qCZt8l+QhBJ?=
 =?us-ascii?Q?WO85QHYUFJxjq/0bSWO+fFOqFQBfpMcSoOvx3McxgByL+w8hm2yJaNB5Nqyv?=
 =?us-ascii?Q?MdCk4e1MChyp5PpTmYIv+V/nK8P4Gci93qnphaCxBC4JpUi4BBhtn+3E+rXq?=
 =?us-ascii?Q?4G7pHG9kQzI25u6McjL0uh7WCj2tKVq7UE5dlrazNv6BiGljJm0T3on67yHU?=
 =?us-ascii?Q?tUar4sygJgGUCEYAr3+jMNE1MDyohBuCpi800lX2R8iApePK6p4QSIY0Ff0I?=
 =?us-ascii?Q?pMTewXT7OdHW6JxfH159Hq7gJEn6KWzRQVMg/JlX11bJHmgYpboLvXwM5n89?=
 =?us-ascii?Q?9hqUIrFUOrlm/+0PdrYCSzLR1iqgZxiUJhz5SGAL4u+fnm1yzrPl4Dc7jKi5?=
 =?us-ascii?Q?6+Hinl6nzChp84ZQjijLSu+W8jzf5iLRFiN0NZ6ZmgxlU+kZbXAjWg6x4G9S?=
 =?us-ascii?Q?N3aQCSxskKOsyB3UBz57CyFOahjS6JpZNluRN9Fu0Whqt8aWo65JUwlXeKnW?=
 =?us-ascii?Q?SBobt9KKD1yOOoG1qO48mtTH1nFz7CmO6biCei3PoQqXmigjfTJypER2XOpJ?=
 =?us-ascii?Q?7jZYtSenZbKBtELG9BlF4ALOY7M7o4YAdrqxXzo1MnAkUT8yb9tJkopBcU3p?=
 =?us-ascii?Q?d/FdyGCpA/j76Wg6kxHcEZ0HFwb2RExcxNTRyDKaiceW4cDqT2Z1zUC2ba4L?=
 =?us-ascii?Q?zjHBu8aYgFwzTNuZvEnf7TPmDYxg1MAH3QQs7BwiPqusMA69b9YyExclFkMw?=
 =?us-ascii?Q?4mfNeoLP0ARyr/HwPCtff7X+pSLjhCznLrrNCyCwbvFEd5ShraQli58mvFEC?=
 =?us-ascii?Q?s5jYF1NM/uO35ah+xVW0NBBq6pqhHMJISx/kUa3BUQo8wQn4ny/rWCjIvhjl?=
 =?us-ascii?Q?tNDzbUsEIWzLeDnMs/CsqbLHTl6Hojwcln2g9oUgpLclk/8MrxUBaNp32uoI?=
 =?us-ascii?Q?UHN4Hvl7nZv9xqiG9RK6P4UV1hidlo4Mfmzh41Y9OLwmjgwP6mxLf/TCwh+0?=
 =?us-ascii?Q?ku7D8TRLrM1SJewyczuyCHoUzcKbkvyccrJA7R+I2KnONdvXKou676KWkZQn?=
 =?us-ascii?Q?kZps8wWQrTje3NiVqq5EgI4HGs4luoVgLRcVZffI6uEoDVb0pKbLGgIU9fw7?=
 =?us-ascii?Q?kcbV+XCQTAA/UJBL8o89hnNSPZJaGeFxJXAgyuZaKMnl/1ULrfC05uXy/0s7?=
 =?us-ascii?Q?AoJPZe/5wsyk9GfXReJW8EenJD1AsRyP8XSBq7mTRmCSksqIfKkMVsgUEz9Y?=
 =?us-ascii?Q?PBxvcYNiJI+Nvzl2NEFuBQ0e6+sgjCfsYF1+2tJJb7wczcRXJjQo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4e2808-671a-49ba-650f-08de588e918a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 01:44:08.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ax8hho5BL3oqZ/pTiqPCgEnR5f9HtwWyAsXMyDPlxaHZovptWz5GL+k5XB1lqOsgE3UK81T0ShrFvv0tQMA4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5505
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8414-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 132EA4F4DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 03:09:18PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:13PM +0900, Koichiro Den wrote:
> > Not all NTB implementations are able to naturally do DMA mapping through
> > the NTB PCI device itself (e.g. due to IOMMU topology or non-PCI backing
> > devices).
> >
> > Add an optional .get_dma_dev() callback and helper so clients can use
> > the appropriate struct device for DMA API allocations and mappings.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  include/linux/ntb.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> > index aa888219732a..7ac8cb13e90d 100644
> > --- a/include/linux/ntb.h
> > +++ b/include/linux/ntb.h
> > @@ -262,6 +262,7 @@ struct ntb_mw_subrange {
> >   * @msg_clear_mask:	See ntb_msg_clear_mask().
> >   * @msg_read:		See ntb_msg_read().
> >   * @peer_msg_write:	See ntb_peer_msg_write().
> > + * @get_dma_dev:	See ntb_get_dma_dev().
> >   * @get_private_data:	See ntb_get_private_data().
> >   */
> >  struct ntb_dev_ops {
> > @@ -339,6 +340,7 @@ struct ntb_dev_ops {
> >  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
> >  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
> >  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> > +	struct device *(*get_dma_dev)(struct ntb_dev *ntb);
> >  	void *(*get_private_data)(struct ntb_dev *ntb);
> >  };
> >
> > @@ -405,6 +407,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> >  		!ops->peer_msg_write == !ops->msg_count		&&
> >
> >  		/* Miscellaneous optional callbacks */
> > +		/* ops->get_dma_dev				&& */
> >  		/* ops->get_private_data			&& */
> >  		1;
> >  }
> > @@ -1614,6 +1617,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
> >  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
> >  }
> >
> > +/**
> > + * ntb_get_dma_dev() - get the device suitable for DMA mapping
> > + * @ntb:	NTB device context.
> > + *
> > + * Retrieve a struct device which is suitable for DMA mapping.
> > + *
> > + * Return: Pointer to struct device.
> > + */
> > +static inline struct device __maybe_unused *ntb_get_dma_dev(struct ntb_dev *ntb)
> 
> I remember if there are inline,  needn't __maybe_unused.

My bad, I'll drop it.

Thanks,
Koichiro

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > +{
> > +	if (!ntb->ops->get_dma_dev)
> > +		return ntb->dev.parent;
> > +	return ntb->ops->get_dma_dev(ntb);
> > +}
> > +
> >  /**
> >   * ntb_get_private_data() - get private data specific to the hardware driver
> >   * @ntb:	NTB device context.
> > --
> > 2.51.0
> >

