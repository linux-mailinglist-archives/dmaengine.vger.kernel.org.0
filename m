Return-Path: <dmaengine+bounces-8751-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lRDqGaQ/hGng1wMAu9opvQ
	(envelope-from <dmaengine+bounces-8751-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:58:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7122EF2D7
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEF38300E3C4
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2C0355056;
	Thu,  5 Feb 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oYqw+Xe9"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020141.outbound.protection.outlook.com [52.101.229.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D42BE053;
	Thu,  5 Feb 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274719; cv=fail; b=a2y3mqOlOnE2rrvDIot6934E+SXNViEqZMB7QI/hd09v4xekDchFrs1h7y+o5kXqSktsNTFgnft7A2ePYbfWarMajYSM/65Le5DlB0cVZH/WaK2KVjVum0TpN+y9MT5/X2EQWhtrHYuLO7vkxarZs8Jia7usOo+4Qlk5ow6fbrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274719; c=relaxed/simple;
	bh=O3RfPqMUsZyZyB+NNl+Eq8KlAhJtWQsfq7Mc4WdV9dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l0fzfdEqRTXOw7gmpItTWBYyHtpbl6CwbNnsPMLN2QKNqgFeBtoXPtZ9W2XsqNRzi24j45A64Rx+kxb2ntAJ/VYCFUIV+pir64zOY4Xg8vHLhjfOva1DRUQ9/2rseokeE01andMqLVS4oEzkkSiUxIcELRA+qNHGDcEVeuRftNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oYqw+Xe9; arc=fail smtp.client-ip=52.101.229.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6n1p2cgZB/g3Z5lboUJ39txd+D3IxkNY6+MuX8fImEnzaZaI1X5Byrbg69t/WMisIt7aJXIIGNeuufuaCYQW/iEdPl1XkaIjGzp/ovrLuwfi3PAb+JHv5tI+nEoj8v7/Yb0A1FJF+eayi9SGLbmeQ/3ZDRK16rLrZTwuZhsZEYtGZaHCHWYsAo6A6jma1ji0RqtrLP8zyoJsjPVC/gEUCJFMa2PJlgYTgL7uTU3DoT1c9mV0sQ4TlrRreakeNKYdpto+P+X9LY97ybHQ2fUkMfpa/stAtoUaN4qfa3zaA7eqmnmlErGA1KYiPRe4FqpiiSx2No0HpEAs9nbHO+kHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXs1Z/ZdJzaRFl69GEvyPCNFO8dWADvAADYMzwEYiVo=;
 b=RwMyr+llav9wH2nBpCBs4I1OBz7yjG6A7ICAuvtP+v7mxv/uuQtt9a2jxGZmRFAWsikXDTVCnQpaBw+v5NiqX+YAVd0GUzZDRTNcKplRGupXWUjM72waP0IZmKjfg5tZ6i3THnV2n1wMECgiQur4oMnZPYMACPNr80g0FpgCSqmUa3DOWxMjbb/jktBCyfhasGHW4mPhpkKAr2bfDro78rM/WSIIwtfaSeA5GlwqiUeQ/omPdKgG6HruVg6fkp1kgpqJZc583xpgFlYp8a2U9feCzhwktPRf6fO1Vbrg+iZac25Yc8dl1xozU9u5KgP7HVcVRnZIywBjb22AoWP/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXs1Z/ZdJzaRFl69GEvyPCNFO8dWADvAADYMzwEYiVo=;
 b=oYqw+Xe9smPg4uHCEfJwj1WRo3vmJ357t1mB2Q8+kVZ9orR0eL2F9rjVCfZCytODjhNeBMnHVyf9QrqBHhqQO2qIdbtkxYKPxNztc+6CSgBp5hdPjRMlcDImmx9cR22W9uDcfIWvmOADD/BHwxPg0L8QE1M8hWT7QRBcB5YvjLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4012.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:58:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 06:58:36 +0000
Date: Thu, 5 Feb 2026 15:58:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/11] PCI: dwc: ep: Report integrated DWC eDMA remote
 resources
Message-ID: <szak7xkmj7j36jyjyqj3t56uytdubabk4tet6yrgiqa54gwafq@kynruthmumcu>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-9-den@valinux.co.jp>
 <aYOKo1Ep9g9xxeQr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOKo1Ep9g9xxeQr@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a48844f-0795-490c-7e17-08de6483fbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?obhENAxYqMm01G8s4n77FIf1NL/yHF4Iof4iNdBDp2PVZCklPL2rebDBbPFd?=
 =?us-ascii?Q?pRHHDHtXFgYIsN8ySV0T/jNsyzb2BOTbpnp32IN4PO7Qt04WoaD4gOKPfoAV?=
 =?us-ascii?Q?hdzPJYHgXmCkNjP6ImzXfMHj3eIsdz4i/pxuMqB+LmnmeHaPIdQauceZlM0b?=
 =?us-ascii?Q?K0fg5eN+RFujuvj0o8zdJgLB6fn3fw/yKJVBUuA4lTdl/az2S36evjBpOmcp?=
 =?us-ascii?Q?gEW9bFwuPApMrXfQqlj0JpaX7B+7nNQgTajVhgtXSy2s9ANRpbrkb7lFpwH9?=
 =?us-ascii?Q?K5Hq0EyG4crAF9TwYHIrqnnfVf87Y9kEWjwm0LjSaOIcO7tbm6YugWDNuIC5?=
 =?us-ascii?Q?epWpBNF1D1S3ZWi0eRf1vmApccgdpsHfBQx8Vi70kLiwSFtCVss/ejJ9rJEJ?=
 =?us-ascii?Q?S8xAek5gP8kFnO517VmPDfcLgdPkTHwjOwwpM4LxA5WCjs/IYMpxOY+7couC?=
 =?us-ascii?Q?PwPiKE4c7oUxK2fYFz6X9CP2VOps3PxrtDOO+X+6P+zVnWYS+g9zgcGCbBNF?=
 =?us-ascii?Q?Lf+XrHWIv/Cvbq29XynB/pXH5QZYUeg8ufVN8aFmslzzKpBcH13NkicA7Mem?=
 =?us-ascii?Q?npHhDXP1TzPoO0z/bXFtGBPsYs4kxuKrkbDUX97J11cAfv4WpTk2/EMNzIUz?=
 =?us-ascii?Q?yX9e1Y5giBsGbhLBXi4GpUCggyn4uoTn2S2wsTLxQhZZcWLl1I1Ewv7/vo40?=
 =?us-ascii?Q?2T4/9a19BOjFo7I2bfytpvBclN+IzpBafzYhLppk0qJcYpAzK6fyG3nOy5Pd?=
 =?us-ascii?Q?EuB1dpO4gjU5CWGF6FWBADjRchgC/lq71VH6KRHBPTAUI4vlROsHOKpnJfxv?=
 =?us-ascii?Q?KA8m3E44EVs89PyeDH185HWTizY1AGrbaC1u6b/FRXQ8Tn3cbGLcPwX++W24?=
 =?us-ascii?Q?MIvuM0CoY52KRzMD66HjMCnRqddf0DiUjAqymoBb+x5ZlWNdDkrqgOXJS3ih?=
 =?us-ascii?Q?pRFZtz25rY50PR6GqM+4KKI1VutZDysnud5JhJwcZCR7cL7Ke7jbimhB8hHn?=
 =?us-ascii?Q?3B9+rro9MfgSmTeq1LrQIcQZNxKEmZ+xK9HmxMftJMH0IwlL2XubhSIIY0rk?=
 =?us-ascii?Q?+GO4tAUmccilH876KDqIjSJcA1H9XpOSCMZ4PGRRg4jb454nROVGy6ZEjEzY?=
 =?us-ascii?Q?HIc3bGYnBgXHeyisoY3fcvbzpVoaRc2OHBxQWGQHM1i4KyOrh/YXtQ0fOFkK?=
 =?us-ascii?Q?RItQZMtTN/3NZGAG3atuj1CmChxxMtcIt08bYRQEgvQfJTz5QO7d7mEEvdYa?=
 =?us-ascii?Q?ebkA/7T88WZ4u5Kvvp7Tzbt46YmVrpR4NNeUSAtsA6Wl1prqMkBJdwoEY1+l?=
 =?us-ascii?Q?l1G3jgylXaWU99zU9YIBEwPu3XQSfp7KRuyNwWdBtur7lUbtzYi5BtU+Ocu6?=
 =?us-ascii?Q?dVAESctJGTIrnn6rhf7VybGo9DAHyGQczJYekauRK8DtKBLmTlGcL1d8UkPc?=
 =?us-ascii?Q?c4eQF17oVRz570wez2rrBP2Bc81wHPcQRUcyvTghvK5CkxF5Y+sBrfZF348t?=
 =?us-ascii?Q?3AAxoQpQdwTDZtDfR4ae1BCnt52tRiI9gbh0osx/0AWPv3y257gXqRl3Xn6t?=
 =?us-ascii?Q?20Iy1uJd0pFT483GxURHrAQpnxie5c9KWACOU6adBXKg9zB8MoCAFcAlgXnG?=
 =?us-ascii?Q?5F5ufsOCukKXKiEN2TmJGgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/tFIeZOB1CXTLnkAhW87zdJIM9e+iP1eurC2RRd+cI/hdHVkjzzu8gfhTu97?=
 =?us-ascii?Q?a/W3bvsU5iMJmz7VuzFEZknCBihm1823RipqwtvNHEZI8uKYkG9dUxKbSY48?=
 =?us-ascii?Q?eBzhrzUOGgC3ZLNZNi7OoBsoX7zqDNeNf8JgHVdY+OylEsGidQd09SpaC4Ej?=
 =?us-ascii?Q?wPd5obJf5Fm8sVuiiLURQtUk4Gxo+Gl4GXVgbvCsgUKQtVNBUSwoL5kYRGKv?=
 =?us-ascii?Q?ejX8nX//K40p6X189AUaP0oclogpuN823n1bsBpCGqPBwDG4gGI/e9HHA54k?=
 =?us-ascii?Q?bivJPqEjICXcQu+8Vab+PG3r9Hpi/NmEcbINrVeZDDUPGTS4kDgbH9Dp2mai?=
 =?us-ascii?Q?GnTVJFUFuYq6UHLj9KAH7ofc9pPPvV/wU3gW+Pr+8eDkImzUMq+e4jlICWiF?=
 =?us-ascii?Q?vJQ97h5ebIVagCCiGXG8YZ3ubojKBhaiOGizYQmR3jAGRep/go+DhpKwWqls?=
 =?us-ascii?Q?Hv8pj78fYEfYmdLqlUimRQZnxsnWdH+lVo8gErOixupITTzqhMFqIZNJoEi3?=
 =?us-ascii?Q?ANoildwdm+FZ5EnsF388pvLRWNNIwJ8CZFuLsSLGXfTCf2P6jwBX/QEU2uHo?=
 =?us-ascii?Q?WQkWCQ8COl5Vgvk36juccqCQ0icw7KZ993tKqs404WC4Jy4i++r4FjcFvbLi?=
 =?us-ascii?Q?EA7s8M2mtRk4yEYZ1DFqfAf7DK7WTM8IioNFz/89H//Cmce00HOVYbpKK1O9?=
 =?us-ascii?Q?woBE0fDsqssXic3IPQx1qj/lJTBgNIQG3WnGUOawBrM1CCIZ4gIqynIotKzk?=
 =?us-ascii?Q?art91h1JDkqWfoiG5hhEVHJRzEyPqbbNm3lGiw0aB2A8aT4+5v6+Ci12FMYO?=
 =?us-ascii?Q?o+SRY5TGLWYJp8uYtn4qYlkEd/FT79f1p2cYAMHTUIJhVH8SZWQL5rkDXNYQ?=
 =?us-ascii?Q?DjiIzKtvtJ9JmqD1xIWj4us48YQM2qItwQ6sxtuRwKv4fn/6p5RC02NdfeBX?=
 =?us-ascii?Q?gnKtVtJHaEI/EetA7Piq1hlb9j0aU4UCd95Gpfa2JrOK8THNT9kZd3sdICj6?=
 =?us-ascii?Q?etv5lQ/ol6UefYxcNiQyJeGKfX0/9ByDIWYfPheqM/XygWFWXNCquDBuTv8z?=
 =?us-ascii?Q?8audSYhNz7fKmReCe6gQcCr7NsErmx54WLQe8EWBpZl88G/TAEEG6uW8vwEO?=
 =?us-ascii?Q?zxLKScEiwfbyS7cr8gcMe557P1x+ZhAtZvLQTkhCc2ul9v+EibZRn50TyAlg?=
 =?us-ascii?Q?PkyKWF/I19Wt3httRkZauOB8jGq+2k5l36SsE/9BdA5XmnmtmiPpPmfC+uSr?=
 =?us-ascii?Q?AK2iAaJFr3tlDT/fl+3YCUYdjQ5jSNbHFol592xWnPVegQPDvJusOKEFG6Sz?=
 =?us-ascii?Q?pewVEUeex567eb4kQ1SvDQrj8iFSBENtfUOOq8KuvbOozpVhEmYE8SrhFU70?=
 =?us-ascii?Q?gNMIAxSuKAwVPE7Mq9wuEAZlq4CR2E4Ey4dDd5Orq+tFbbiU6RO0Cs16x+m+?=
 =?us-ascii?Q?n4qUeEtKanH0rpfn3hPz5zTN6GYLavHmgWTtYpUL56Z9+3yi32lNC/M+DxI5?=
 =?us-ascii?Q?YBb7AwXVLJ7K2uTInMYckMX85UbIt3j+5Lgvcn5JgJUwKzd/cq2k9goQ18YG?=
 =?us-ascii?Q?JqamI9KAYx3+fTidmnafzaWvUGtf+8Yzw3XsiTOjfQ/3U7/7johR183LL9F0?=
 =?us-ascii?Q?I7P1qRJGBNJWCvMW7rQVBajl12R85pS7Brkd9vk0S0GPe2t9q8L1AZvNtD1W?=
 =?us-ascii?Q?fHIBEZGHBBQ2N05NDYFwD8idrP/Rjftgq+KN12mkCDi2op3j4066RGigXIT3?=
 =?us-ascii?Q?2+WI0kiBff3iD5ATaK1dOui8DxOh2KjDUaQBuj+cvWTITbvC93qe?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a48844f-0795-490c-7e17-08de6483fbc4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:58:36.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p14iDVYOQ4ezjLC1PzeYb/fyTfCCyFtu7m1t6saTCeSKN/AeobcYm10GiH+NRUmyLFyNhLxV4Vl98IZPL5hEvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4012
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8751-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7122EF2D7
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:06:27PM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 11:54:36PM +0900, Koichiro Den wrote:
> > Implement pci_epc_ops.get_remote_resources() for the DesignWare PCIe
> > endpoint controller. Report:
> > - the integrated eDMA control MMIO window
> > - the per-channel linked-list regions for read/write engines
> >
> > This allows endpoint function drivers to discover and map or inform
> > these resources to a remote peer using the generic EPC API.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7e7844ff0f7e..5c0dcbf18d07 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -808,6 +808,79 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
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
> > +	int ll_cnt = 0, needed, idx = 0;
> > +	resource_size_t dma_size;
> > +	phys_addr_t dma_phys;
> > +	unsigned int i;
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

^[1] count-query implementation

> > +
> > +	if (num_resources < needed)
> > +		return -ENOSPC;
> 
> How to predict how many 'num_resources' needs?  provide
> dw_pcie_ep_get_resource_number()?
> 
> Or dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>                              struct pci_epc_remote_resource *resources,
>                              int *num_resources)
> 
> return number_resource validate.  if resources is NULL, just return how
> many resource needed.

This is already supported by the current implementation: in
dw_pcie_ep_get_remote_resources(), if resources is NULL (or num_resources
is 0), it returns the number of entries required (see [1] above). Callers
can therefore first query the count and then call again with a properly
sized array.

This behavior is also documented in the core API added in [PATCH v3 06/11]
(pci_epc_get_remote_resources()).

    + * Return:
  > + *   * >= 0: number of resources returned (or required, if @resources is NULL)
    + *   * -EOPNOTSUPP: backend does not support remote resource queries
    + *   * other -errno on failure
    + */
    +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
    +                            struct pci_epc_remote_resource *resources,
    +                            int num_resources)

Thanks,
Koichiro

> 
> Frank
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
> > +		resources[idx++] = (struct pci_epc_remote_resource) {
> > +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> > +			.phys_addr = edma->ll_region_wr[i].paddr,
> > +			.size = edma->ll_region_wr[i].sz,
> > +			.u.dma_chan_desc.hw_chan_id = i,
> > +			.u.dma_chan_desc.ep2rc = true,
> > +		};
> > +	}
> > +
> > +	/* One LL region per read channel */
> > +	for (i = 0; i < edma->ll_rd_cnt; i++) {
> > +		if (!edma->ll_region_rd[i].sz)
> > +			continue;
> > +
> > +		resources[idx++] = (struct pci_epc_remote_resource) {
> > +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> > +			.phys_addr = edma->ll_region_rd[i].paddr,
> > +			.size = edma->ll_region_rd[i].sz,
> > +			.u.dma_chan_desc.hw_chan_id = i,
> > +			.u.dma_chan_desc.ep2rc = false,
> > +		};
> > +	}
> > +
> > +	return idx;
> > +}
> > +
> >  static const struct pci_epc_ops epc_ops = {
> >  	.write_header		= dw_pcie_ep_write_header,
> >  	.set_bar		= dw_pcie_ep_set_bar,
> > @@ -823,6 +896,7 @@ static const struct pci_epc_ops epc_ops = {
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

