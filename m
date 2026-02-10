Return-Path: <dmaengine+bounces-8860-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JD+FmeOimmwLwAAu9opvQ
	(envelope-from <dmaengine+bounces-8860-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 02:48:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB721116125
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 02:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D4253012258
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 01:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B3B28466C;
	Tue, 10 Feb 2026 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Tnqw1Maw"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132035898;
	Tue, 10 Feb 2026 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688088; cv=fail; b=NmeswKczaYb7Z1LEpvWJYDn/4NFZw+aQZY5CeOC6f8P2bw/hji1t5ZX0G8RYLjs3ttpw1Uf2WA+ev0s1BkMx4DKbcx6EMWAtMpYgqzDCHdEW1JR6q52/iCRII2W68ULIv/21sapEOt+vbG+mf/vNn0RxJ1+cIixQNKeAKzVkdEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688088; c=relaxed/simple;
	bh=BpGFMhU0/MiH0NbXB0jk3eANN0ZM9IZ1qdN7+L10Yu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X4Q8wAjeYSNAlzCqBsntKbI15z5RfKOT95C+q6iAJWFnaENvbvAkup4V9BXb6ag8XCVr7bhFtCCqD0CAxHKD0prsZ1Jg7AQFMJg4QmX2ArMbfMFvAVdivhwlHXPFXDT2NKJbW/wZWd6JPbOu3Gg5VcHaIddf0ASxEkqb/JNE9OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Tnqw1Maw; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwlLY6LAoR59WkRwgxXPLZ7nOMIVvoMIIy2oKsMj3DhNUqXD0+WTSS8kbmN7nn0vYeaKJljJwKp4DZ631ApObsoNUqNASzCMDzkJsVtrHKsGrIyWfsaZxoWtSsUO2BIqWTiuoZp0rmwZ4wBRf6baBmJGEHQZbt04xSfx1Bu2BNtvmMIvxG+wqowD7yAsCu8LhhP3HTxGMQE7VS7JI5wfzkm0bb2p5qhJrd1L3QjmYvYxrVXhX0NTiq6dpfRk+MY+c/IxyHruD/42pB+jKvBDMPfjSpD3afKWYo9GTfGHGWoZGeI2PSalqPsAtu8otbS5DoSx/CG2P3IwUDiCmHqVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FymbhbVCFR5x8tHVuIDtry0jghGs9Lk9lvJA2qyRbIo=;
 b=DPM9NZbr1fky7AgpX1VPBHbC/P51J8E2zZCKL6RzBjGljLK25rF3WL5Tcze8lWWLOeBHS355BXt7e3QV/1AmV0CX1Uu9nFnXMXAoz23O9cQXeN42N7I7xbW0E6E26PbOTBMXpIQ9NEXyulSX80aX43Ab2qElEtiu1V7dpfXMi+/ytTFLSXnjBC2fPpY1Db184YIeNDHgYix1cJTffypEngLrourgr5BpYnL+51f39iH7OnV+DP6cE5uBtLY3/uTQqO4NdM1yaXDxx/lX3afbq7Wr2RDExSrwuyJxd4ply8jTuuVh2HfwwJbWTs8yvU3KBdTPv7h5q3BEx9KAKOltAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FymbhbVCFR5x8tHVuIDtry0jghGs9Lk9lvJA2qyRbIo=;
 b=Tnqw1MawEacfrUhpfrFPQ6i6w+kGzABKR1oQ73eFIge3tbTEKK1XHW9Ll2LI0DmQGXArXEZ/CNia6NM+uSdo+BFBzY+KHXRlowhrsMsykFifoqg7N+B12dNJaLozv2oL6yHHKsCYUHofNo0kM1AVyeggdBvyrae5ojOGBwXPpRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4317.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 01:48:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 01:48:03 +0000
Date: Tue, 10 Feb 2026 10:48:01 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] dmaengine: dw-edma: Cache per-channel IRQ and
 emulation doorbell offset
Message-ID: <5qagzbpffis6mpv2efpdk4fn35i4jcfdzuggvqoagqjpjxiogt@dzcdo3qwhrtj>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-3-den@valinux.co.jp>
 <aYoHtP5dsEHQEm7c@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoHtP5dsEHQEm7c@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 767bcb21-7181-4ee5-276f-08de68466d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQt7K8ZqR0jICkMadCNG8UabEXouYyykdHLnESrCRO84OWO1U8q40SaYQs6w?=
 =?us-ascii?Q?ckuVy2ObIQeFVTAWHwCQ4mEKSRKcDcbRn/ljF0G+3unn6KMDZIgC/WVPeI4E?=
 =?us-ascii?Q?aAVBW59Tl0eLYHRsKid/CsDZDbqJd5zbiBU0Ct+h70CmW5wssZMNz3oTXs/7?=
 =?us-ascii?Q?HGMh837O8eKFhiU+lBGUN5LiceCG1EyqTbCF7IyFw5IG6WY5iCRKlrJSGD6H?=
 =?us-ascii?Q?j9oB6LndxIbxDg6QRaBI5B6/WPFTKEMD/AgKK647UGDT9mZMOxkxmDTgsDnN?=
 =?us-ascii?Q?9lxEypIpDYf6Mxmzu2wfrwAZQL/lQHw1dJhXTwtv8AWQD4z2cZ+MGGRD6FCN?=
 =?us-ascii?Q?ybZHiZShkuIR9cMdwIlcxycbpeL5L4OvirgbaK+ftqKveabOgu0C+Pzl1hiw?=
 =?us-ascii?Q?Lld8e7P3ct9f0jusrCLhGxYavza6pBjwZceMPn64w7pQfefr8WkLl3qTyRO2?=
 =?us-ascii?Q?1AmeRxqlNFJi3SMKnVAjEAl168XHCs4r5YrrVCgrC1ifC1Y0sdiAtoLUfBUz?=
 =?us-ascii?Q?kMdanV/o0GRtT222C25SKT7unUtilT8z/grP+1RQ1R3yrXKB9rh2fvxlxDqu?=
 =?us-ascii?Q?kYScYZFO7tuALXU676RGwn50lgxm5V0k5dMN+1SCdZGcoYaTUKFAFbbftAds?=
 =?us-ascii?Q?lJsISMpFkRLDvCx9Fj22IPr++I+ebW+vCVtxNpSl1OOtCOW9+Hqh0pzWrWWz?=
 =?us-ascii?Q?vP4V0DS67PavckUwyaC053137tPaAPhMmcwzf12qNSAWb+EnYLlsaFnn8P8E?=
 =?us-ascii?Q?cjzlMFMa/dLSDEdIXTm5S7kagHxVvL+4gKYTMInmouHHT0aSeQi5vTI/WLvj?=
 =?us-ascii?Q?cui4bZU48BiAwzhRXYvcJzTBKZdnmTpQSA+7ISJBNhsCC3/JcZjd/k6gKILW?=
 =?us-ascii?Q?M7FtBcDoeGJSUePBFyrEiKwSbTEW6OMw8RkOH1rAXIUfx3drEZNuEwbLLsN+?=
 =?us-ascii?Q?2n9ioNa2tNHFENUIFt8S/4yBW0mShhTUzhHICk/SYeAdxO55GoALsoSDMNCX?=
 =?us-ascii?Q?iJWCKyDky0sB0gh3myNSMV+3dnmMK/xeVkN0FJBZ5NFqw04g6cAdHKKgnMta?=
 =?us-ascii?Q?aa0KOp788sbfLIw0Td8D/JuswUuTPbwz+6y21z5a4DjV0omYmVMmZhb2RXQ1?=
 =?us-ascii?Q?rWCg2oQVUOtHsZEPzuQy7YRKV6NZSbv9d8pld0g53MUaC+jAQg6oIybX3acn?=
 =?us-ascii?Q?5XQUuouArCs2QiR2MzEjEt89aWJ7V4URybfI6lkm6XYC5mvgVndlfXt5o3eD?=
 =?us-ascii?Q?sy8TAhji98UQNG5aSBlDo/1/+p1ccxBviyw8tSYfza4pG+NjHOrv5hupUJw3?=
 =?us-ascii?Q?Jrv7Sv7aRPXjnecojZaeDrFKy50cBIqc1OSGc/rnYPNMuvOcIixTazk0kieq?=
 =?us-ascii?Q?rPX+izOyYYERCj7eNB+803Bj3xUdmshBvyNBtngGpj1BCRWlcs9s47tDZ3bU?=
 =?us-ascii?Q?54AZuGbe1g3ZDSaOMr8zSQ8hcGRDRJMfMSqhSyBLEg7++OPtdvUq1YBybsbi?=
 =?us-ascii?Q?Uw5TVQ3f9QN6PUb2MwHJCvE/D8TdBA5j3SQNz48oGhFXR6GqAZYrS/sAB77e?=
 =?us-ascii?Q?CuczTqQ2pR+gHgGAhcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JlJB7VNQMs5BpvNlFyfVSftJ463q0GkXTbeVZYQilv2OvnSLV5WPEGOerX0P?=
 =?us-ascii?Q?Obk7dr9JStyhwESWhzUHkXYxpk/Y/kzNWxvkkj+thjlWjchrm1RiAy0IGDur?=
 =?us-ascii?Q?sfxQ+h8jq3UMlps1ZQotmKXsnzfaCLz9owAAsafP9/sDC0mS7STxx6NOusJR?=
 =?us-ascii?Q?kDXmiopobv6S9q6Yrh4Kr/FhW/Vp8xzC79ibptVas3FiTbJYwI3OX0o+Oh/v?=
 =?us-ascii?Q?xGGejkEEaEZaOtx+y4KvmompxYvRl2ctsTV9PsGCWl80o7MJfL0NxRGiiNd5?=
 =?us-ascii?Q?rhu5j3CCiJMxg+rNUtEtkp7xprB82AAUOJJd0dKT/p8Y4udPSTS1CGReMSJO?=
 =?us-ascii?Q?GaaWpIW9X+2625K3Nnx1JwfTfEiT9PHdgS8FwTT23IY9xXPX0R0yYq5QsZXe?=
 =?us-ascii?Q?OeXhf83gquxbGRVYZGvygA1z+kS1eE0RyRBuanP9xx8gi5uzUJIfSHF6uoi0?=
 =?us-ascii?Q?v23m9v8O4c0vn7rKVBogNsmQ/l4nBf+40xMG7oolkJp4EeDVkefCDYwOB2ca?=
 =?us-ascii?Q?SPKkvE54a9omeVFQWvCSLeiy4lpaHD3NjTKxLFzTI24gCX/NNtKoBXLwQUjv?=
 =?us-ascii?Q?qVUIEhWKAzupm0SpoMZHLV2u7tlKUFHxc3ju0z7UYmGbLIqfUAPEUOSPZoJt?=
 =?us-ascii?Q?ebhrSYByYpN/zLNQG1Xrb7m7YkWRaA3ZeW3FWlRtrz3iNsUcE0Si59clg2KE?=
 =?us-ascii?Q?u5HvX09C939CEM3/tbrxSfmpSb+x2L0q0PYUurBGLbENjQK2NNp4sLHLKbzJ?=
 =?us-ascii?Q?dZbScP+ir8pBMiOITCkwHauttV8VFpKNDJH8pY4BHDjidChWOELLFF/QpHHX?=
 =?us-ascii?Q?P9zAR1RC0rO+Uk6iQevcKuDmoZw7UugPqB7gwKISHFK8L1TBx5EgPWgl/zrI?=
 =?us-ascii?Q?HOqIdIe9ox9Ii2G3TnGVPSEt+8/0yFqXgz1jS/FmWbVKwwMC+SR/JFAyYKHW?=
 =?us-ascii?Q?sA/WCvBjKG7+XZStgh8XlmuYhkKGzBgZWlpeRgugP441VacqyzRGKSoPMChq?=
 =?us-ascii?Q?ZpMj+GM5l+q3bpamwMBcCso/jUmtcXAUnWadUpoQ04xYhiVuKYoX45v/Slop?=
 =?us-ascii?Q?xRPH4LaY0a+GeTkZfoop+WidKZrBNXGdQ02bHyFgN+pVAeAT9vamkRbbF8AX?=
 =?us-ascii?Q?4Yz5iBXvIDK+fBVZr274SlfSybmcXZGzlYBwr9KPI0g51OyllKkeB1RQfdZ2?=
 =?us-ascii?Q?JaYu/ch13dE1IDQFQ4sp8XHyZ+gkSd6Upr+4AkL6CaFA+RjlKuNyytvN0DED?=
 =?us-ascii?Q?sdta1q/Z7JruPmC+Fbxm6qscNTre5DAaJQvIFbU9ERO4xDpQQ/OFcN+Q+izM?=
 =?us-ascii?Q?DDXG1mzKHRF+mknKFqouXuDPR5E+tyYJ78IqYCQHCnfoKagUxw5nd/csxtd0?=
 =?us-ascii?Q?YEOoPJrVvTGDVVVmut8UAZhqYFJfMTTlWYti4ipM/459UCoXZ3Pos/h425uW?=
 =?us-ascii?Q?qaqYqdyhpYhLg0+9NkIhFQMRqmSFL7M+V/s9M5tseceiGfDHFkpe/kKnMpe7?=
 =?us-ascii?Q?rS2V6PSXPDV14wy+2KxSXEY1uCll9tCgZL5rmuATiqWYw6xzakI+SkjCh6oX?=
 =?us-ascii?Q?xHlGr6T6vLE4cpMSkDLHiE6Vy8INbM/ccZLs2lcoDmzJcJisaMUeConCZhG3?=
 =?us-ascii?Q?s/qQqbBQOPCExo28stjHqvb29jtH1BdfKof+CLyoG4ZPvxqOXlRDXLaYpDcw?=
 =?us-ascii?Q?SMvgQjyN4OK1aRftFWnQyH0gnva1TBjD/r6F0YZV7Pqgruuf78AwkVFusPpo?=
 =?us-ascii?Q?7G7TYseeChSkU9wC29nmREyTkZOL83GSR0kSUcemTtriYJ8q6Bf7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 767bcb21-7181-4ee5-276f-08de68466d3a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 01:48:02.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdvJ/J0jibGad+wDNLxlP1Cv6a8AvdYSyEqxCS0O7x11OziE/CaqaXKgb0og2d8MXZFQdeHV55HT0MvFtQoWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4317
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8860-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: BB721116125
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:13:40AM -0500, Frank Li wrote:
> On Mon, Feb 09, 2026 at 09:53:10PM +0900, Koichiro Den wrote:
> > Some DesignWare PCIe endpoint controllers integrate a DesignWare
> > eDMA/HDMA instance. In remote eDMA use cases (e.g. exposing the eDMA
> > MMIO window and per-channel linked-list regions to a peer via BARs),
> > consumers need a stable way to discover:
> >   - the Linux IRQ number associated with a given channel's interrupt
> >     vector,
> >   - an offset within the eDMA register window that can be used as an
> >     interrupt-emulation doorbell for that channel.
> >
> > Store the requested Linux IRQ number in struct dw_edma_irq at IRQ
> > request time and cache per-channel metadata in struct dw_edma_chip
> > (ch_info_wr/rd) during channel setup. Add a core callback, .ch_info(),
> > to fill core-specific metadata such as the doorbell register offset;
> > implement it for the v0 eDMA core (use rd_int_status as a suitable
> > doorbell target) and provide a placeholder for HDMA until the correct
> > offset is known.
> >
> > No functional change for normal DMA operation. This only makes the
> > metadata available to controller/platform drivers that need to expose or
> > consume eDMA-related resources.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    |  9 +++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h    |  9 +++++++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 11 +++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c |  8 ++++++++
> >  include/linux/dma/edma.h              | 17 +++++++++++++++++
> >  5 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index fe131abf1ca3..bd5ff4a4431a 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -760,6 +760,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  {
> >  	struct dw_edma_chip *chip = dw->chip;
> >  	struct device *dev = chip->dev;
> > +	struct dw_edma_ch_info *info;
> >  	struct dw_edma_chan *chan;
> >  	struct dw_edma_irq *irq;
> >  	struct dma_device *dma;
> > @@ -779,9 +780,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		if (i < dw->wr_ch_cnt) {
> >  			chan->id = i;
> >  			chan->dir = EDMA_DIR_WRITE;
> > +			info = &chip->ch_info_wr[chan->id];
> >  		} else {
> >  			chan->id = i - dw->wr_ch_cnt;
> >  			chan->dir = EDMA_DIR_READ;
> > +			info = &chip->ch_info_rd[chan->id];
> >  		}
> >
> >  		chan->configured = false;
> > @@ -807,6 +810,10 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >
> >  		irq = &dw->irq[pos];
> >
> > +		/* cache channel-specific info */
> > +		dw_edma_core_ch_info(dw, chan, info);
> > +		info->irq = irq->irq;
> > +
> >  		if (chan->dir == EDMA_DIR_WRITE)
> >  			irq->wr_mask |= BIT(chan->id);
> >  		else
> > @@ -910,6 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >  		if (irq_get_msi_desc(irq))
> >  			get_cached_msi_msg(irq, &dw->irq[0].msi);
> >
> > +		dw->irq[0].irq = irq;
> >  		dw->nr_irqs = 1;
> >  	} else {
> >  		/* Distribute IRQs equally among all channels */
> > @@ -936,6 +944,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >
> >  			if (irq_get_msi_desc(irq))
> >  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> > +			dw->irq[i].irq = irq;
> >  		}
> >
> >  		dw->nr_irqs = i;
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 50b87b63b581..82f8f3b38752 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -93,6 +93,7 @@ struct dw_edma_irq {
> >  	u32				wr_mask;
> >  	u32				rd_mask;
> >  	struct dw_edma			*dw;
> > +	int				irq;
> >  };
> >
> >  struct dw_edma {
> > @@ -127,6 +128,7 @@ struct dw_edma_core_ops {
> >  	void (*ch_config)(struct dw_edma_chan *chan);
> >  	void (*debugfs_on)(struct dw_edma *dw);
> >  	void (*ack_emulated_irq)(struct dw_edma *dw);
> > +	void (*ch_info)(struct dw_edma_chan *chan, struct dw_edma_ch_info *info);
> >  };
> >
> >  struct dw_edma_sg {
> > @@ -216,4 +218,11 @@ static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
> >  	return 0;
> >  }
> >
> > +static inline void
> > +dw_edma_core_ch_info(struct dw_edma *dw, struct dw_edma_chan *chan,
> > +		     struct dw_edma_ch_info *info)
> > +{
> > +	dw->core->ch_info(chan, info);
> > +}
> > +
> >  #endif /* _DW_EDMA_CORE_H */
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 82b9c063c10f..0b8d4b6a5e26 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -519,6 +519,16 @@ static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
> >  	SET_BOTH_32(dw, int_clear, 0);
> >  }
> >
> > +static void dw_edma_v0_core_ch_info(struct dw_edma_chan *chan,
> > +				    struct dw_edma_ch_info *info)
> > +{
> > +	/*
> > +	 * rd_int_status is chosen arbitrarily, but wr_int_status would be
> > +	 * equally suitable.
> > +	 */
> > +	info->db_offset = offsetof(struct dw_edma_v0_regs, rd_int_status);
> > +}
> > +
> >  static const struct dw_edma_core_ops dw_edma_v0_core = {
> >  	.off = dw_edma_v0_core_off,
> >  	.ch_count = dw_edma_v0_core_ch_count,
> > @@ -528,6 +538,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
> >  	.ch_config = dw_edma_v0_core_ch_config,
> >  	.debugfs_on = dw_edma_v0_core_debugfs_on,
> >  	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
> > +	.ch_info = dw_edma_v0_core_ch_info,
> >  };
> >
> >  void dw_edma_v0_core_register(struct dw_edma *dw)
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index e3f8db4fe909..1076b394c45f 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -283,6 +283,13 @@ static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
> >  	dw_hdma_v0_debugfs_on(dw);
> >  }
> >
> > +static void dw_hdma_v0_core_ch_info(struct dw_edma_chan *chan,
> > +				    struct dw_edma_ch_info *info)
> > +{
> > +	/* Implement once the correct offset is known. */
> > +	info->db_offset = ~0;
> > +}
> > +
> >  static const struct dw_edma_core_ops dw_hdma_v0_core = {
> >  	.off = dw_hdma_v0_core_off,
> >  	.ch_count = dw_hdma_v0_core_ch_count,
> > @@ -291,6 +298,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
> >  	.start = dw_hdma_v0_core_start,
> >  	.ch_config = dw_hdma_v0_core_ch_config,
> >  	.debugfs_on = dw_hdma_v0_core_debugfs_on,
> > +	.ch_info = dw_hdma_v0_core_ch_info,
> >  };
> >
> >  void dw_hdma_v0_core_register(struct dw_edma *dw)
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 3080747689f6..921250204a08 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -60,6 +60,19 @@ enum dw_edma_chip_flags {
> >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> >  };
> >
> > +/**
> > + * struct dw_edma_ch_info - DW eDMA channel metadata
> > + * @irq:	Linux IRQ number used by this channel's interrupt vector
> > + * @db_offset:	offset within the eDMA register window that can be used as
> > + *		an interrupt-emulation doorbell for this channel
> > + */
> > +struct dw_edma_ch_info {
> > +	int			irq;
> > +
> > +	/* Fields below are filled in by dw_edma_core_ops->ch_info() */
> > +	resource_size_t		db_offset;
> > +};
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:		 struct device of the eDMA controller
> > @@ -96,6 +109,10 @@ struct dw_edma_chip {
> >  	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> >  	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> >
> > +	/* cached channel info */
> > +	struct dw_edma_ch_info	ch_info_wr[EDMA_MAX_WR_CH];
> > +	struct dw_edma_ch_info	ch_info_rd[EDMA_MAX_RD_CH];
> > +
> 
> suppose this info only used in side dw edma driver, so it should be in
> dw_edma.
> 
> dw_edma_chip is useful to exchange informaiton between EPC/PCI controller
> and dma engine when call dw_edma_probe().

These cached values are consumed on the EPC side, while struct dw_edma is
opaque there. Putting them into struct dw_edma would require an exported
accessor (again), which I was hoping to avoid. Does that sound reasonable
to you?

Thanks for the review,
Koichiro

> 
> Frand
> 
> >  	enum dw_edma_map_format	mf;
> >
> >  	struct dw_edma		*dw;
> > --
> > 2.51.0
> >

