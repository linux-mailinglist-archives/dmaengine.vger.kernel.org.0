Return-Path: <dmaengine+bounces-8466-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDSHD/WXc2lgxQAAu9opvQ
	(envelope-from <dmaengine+bounces-8466-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 16:47:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE977F13
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 16:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47AE4304C346
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B740B2FB630;
	Fri, 23 Jan 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O+F/fIzF"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280529E116;
	Fri, 23 Jan 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183071; cv=fail; b=CPlT41rCXY6Ohb0Kb479OjwhaECXXpeC55AbQhstWSq1lGB3d3U1QskfHHVFJiRY47fihZ/0nHEjrERjMK4c3VpstqdhBvUuHcJBh5MDnhAg9zWviaNNcems9N8HoeLr4jcFijuKc7nv21w6gUI0TF43IFIZ1hINvH0g0F8fLjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183071; c=relaxed/simple;
	bh=rKJ5UuaFuSoXw/2UX7gAjx6eeRhtccOlNgvMWPNOL5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=auPqJstbT5eYp5CogUPvBAsyci7hkQDzgKm5ZINFSitDq9u0hAwTTwlSxe/bqS+VQ47hM13fsKtMc7UvGkaMCZObsbBQBPLGDNihwm7Vba1kJq8pKFigMFwIkqIkMaRW4cQT9i0S1gtzipaqc7ffu8sGcr48DXbsdfRZbkbSMM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O+F/fIzF; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRM/+bm5XQihhkB5hjyqUqjCVOnTNiOKKn7ZdHCSEZpbVX69dJ6ZnPBtpcZsAOvEQECxYhR3cnwFpGse/1T6hf0y/JFJfQojnyoQOc/8OFQ3qSrtTq7voPxXB64b8+7m+NL1ia9jIl5hXYuUR2dia4USlaRizWKyz6njKKah/MPn9NoUIRGW/f6jQytJI9d3m8nSu1g8tGMWIOyU4jOUCVedRbTHYlQOr2IJCkg5Ao0Vrixdn0uDs3kRuYbksUP7IQPkNifk8ojLhGOzsAzZcHWfcNx3Llhk1g6XC1WfBDjNqSl4LgKgxovSTdYoNReDLxy6GL914ncdgnqT40e66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEQfaxLV5MEBoCeP7sZ3Nv2muYNLcFn2zU0whd1lgEw=;
 b=gAzCmOCa6BZzB+/KaDQdyT44QZzu8v9ZKdWIi7BrCFwSQR4tQaKQApo31n5/h/FbY6w8sf43eo1YIVhiI2Yjj4rGQjA3v715rCi1vIRMlpgCgMQX1uGW24yG/NFg+ywa4BXTN/nARMjgzWf4VNmzpdYhy4MiAbk36V1/qHTa9rYLJs2/7B64nEwlkG3S57uN+aIBymEIg/YvbZ7OeWxBB5O55EoxNaSpX6KZM+aGUtB7xcfnFuVzbffDpdEHpKCzESw5uaTdwa1PzOc3mH0JbPWt2yqTsG1zHju6xwATcNra0pXV3tMZnYCtTnGTdJmzeX3CnYyUkw5tWkz3bxLd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEQfaxLV5MEBoCeP7sZ3Nv2muYNLcFn2zU0whd1lgEw=;
 b=O+F/fIzFTfnUftOmScTvj2XQBqp3KmMAk/gJHPI5JeUbl7iC6H7uCcRB157EFaRVEHdSMm5yDrd7A6OFN+Nh9L5lDgZefoWyLtUoVYpv6PEoK7qNrIxM9WLjo6WMFcC/U7NVcM+DsViSr1X6ZVJ9VxKawcX5zfu3h20XUj7WQTA0cn7o5F2srcq7ao3h56sBwlgbP2FJZy6xPwREEztgZlEHXICn5r64IE7lNRl9Ra1Dm9yzOEMr62kuhyyOfSsuLUnx7YegM7kaUqeC8I60QVNznIplEwl+nYPmxO2ffdGVKPhQr5cLmdGF4ubL0MxGcDC8djcilO1a6BJ3ZtS/5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 23 Jan
 2026 15:44:24 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.005; Fri, 23 Jan 2026
 15:44:24 +0000
Date: Fri, 23 Jan 2026 10:44:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, dave.jiang@intel.com,
	cassel@kernel.org, mani@kernel.org, kwilczynski@kernel.org,
	kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be,
	robh@kernel.org, jdmason@kudzu.us, allenbh@gmail.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	iommu@lists.linux.dev, ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 02/38] dmaengine: dw-edma: Add per-channel
 interrupt routing control
Message-ID: <aXOXTpWbJ4IxrjuC@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-3-den@valinux.co.jp>
 <aW0SVx11WCxfTHoY@lizhi-Precision-Tower-5810>
 <32egn4uhx3dll5es4nzpivg5rdv3hvvrceyznsnnnbbyze7qxu@5z6w45v3jwyf>
 <aXD4ncvjZWljUyxe@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXD4ncvjZWljUyxe@vaman>
X-ClientProxiedBy: SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::25) To PAXPR04MB8957.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|PAXPR04MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6992a0-b806-48da-33a2-08de5a96485f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UCtihTFfhxUsu43l94ZAJKnSupKuMlLi35tK/ppjYm2hkagUqn5Dv6pe1eIv?=
 =?us-ascii?Q?eGZdDmg5Tp+oWccqBI1ojg60Eeltf4KBKC2iOXk3PZrDTaiAJxZrHKeo4YMO?=
 =?us-ascii?Q?Wbd/PsJIDC316hVcuXbSCRsUM/riJqm2MFfefoweYahOlNC0ljMonX5EAZZZ?=
 =?us-ascii?Q?8xFeYm9pe3vSu8mG4RcAFKX8Jis71XsUmKC5IZMLm8IdHKtlHQZDexkG17L3?=
 =?us-ascii?Q?wEBtfJFgls3etewFA4dDyzm+FWQhtXDqUUoMld2nLORl+dg77LmwH7PN0Fu+?=
 =?us-ascii?Q?QrGY/KovOvKUWESDdx/WqtfGJlI9qElP8yF0/Wuo6dXXcOlAoC8RqrIB1+3a?=
 =?us-ascii?Q?uBpKM4NDaZqb1q2qHpiE8MnxZP2GuG8eU6Q6D9Gb4sgipKz6WQnziPKPcGb6?=
 =?us-ascii?Q?O58c7By7Hq0OQ/L60Gpik+AYbA/tagTk3DzCJwW5mr7LSldYts5FS37NPvOY?=
 =?us-ascii?Q?I8LyvX+eq1G6xmk1+pbd35rZRoCjMR3N7aMmzZ8CoUcJMFrV5SJa1K9b5Msf?=
 =?us-ascii?Q?U/C7nVg4BEoB+wUgKQDRz8kFGhlBIAwI0/ZCMNtrEGTlSu9uHQSb/jYLjl+i?=
 =?us-ascii?Q?0DIE3JuqcXlyltzKjWkHE393N12u/SeG6OWtECDgbXgM/KXnA4UVhKSzr1NH?=
 =?us-ascii?Q?CFs5WIP43lKMLA2Wrp7bWDSLS8je3BP7NKCc/A8Q0WzB6NrUnl6UHhIYAQDj?=
 =?us-ascii?Q?ZJRg/0mJyAETIaFgOc1141CLp7px0HHUOn1bxEQeG4dqzxFdyC/5/EsGTsgO?=
 =?us-ascii?Q?YQK8h3YaQrZfSqF1tXVlYdALcPbloEv/Ldox6V3Wmps2D6z89DS+Vyvb2mMS?=
 =?us-ascii?Q?6Ir2nsqMucSsF/jr3Kuorv3XHMC/YHKMIMCOV7H0dKig0jMy93ZpdYX0ZNEw?=
 =?us-ascii?Q?IbBLI9dd5baf2LjNoV9ugS3uLJg3dg0ZiYmo4PQgHBFtc9qIXYL9IcvytUrT?=
 =?us-ascii?Q?2G8zURL8p77SZVmbNAagQ39Gc3H2fUyqdnEX1U0VqOctWjCeXbNUM6s6/pTd?=
 =?us-ascii?Q?acgmzdhBP4x9N+9WD2OLYTXqsl6YQyZXchTsSZRe66U6i5cA5A1Ktrh1N7f/?=
 =?us-ascii?Q?WZx4VN6awEhgPyi/xgcododV8FR8h8aViRro0f8nXwjAU8R01WPDPDIFqzKS?=
 =?us-ascii?Q?diQu5ng0NjKUhn+fawuL/9DUGO9kYDs6Mp/fwjZEH/GxWuL4ApvSXknGHWUS?=
 =?us-ascii?Q?vpOonX/joecm8oMUKwD+5F1Ta1sN0qJNRZozG0RbLexEsFwkuja5l7C6k957?=
 =?us-ascii?Q?wEWqt5HNG+SCey+DNdQ+zDybzVMdV0XdYVv/3jUlj7kI8nrmakcfI7KXtnsn?=
 =?us-ascii?Q?EuMaObqwfhnoQMRnDEaedT6RfyW27qVN0x33sEGMREvWV0ZKEw1HbeHl+cSm?=
 =?us-ascii?Q?qRAqizdCrKEah3zL+lWnWIDne1gWZwDpWaj7lCdl2M9IVJ4HX9rXW16OKqDJ?=
 =?us-ascii?Q?QOlyJI218FUKiO50D/0EJbounyCOmNz8111gfgF/Xj84aZ1uJgyXjuJHstZ5?=
 =?us-ascii?Q?DQGMYUtsHvOx4qLnO5+CZ8xtE8G1SObLTjRDDQli1C2z1FnLh9r2u3QG8e+l?=
 =?us-ascii?Q?ZYJbtcLW2AW6HsocuEXxWbcM0Z5oe4jquKemh6Qp390zOk+KmOf6ukQkmn+q?=
 =?us-ascii?Q?A6TXJjKyd7JmkfYV8wx0ILI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1MW+vIYu8E1T+qDauSdZnORtB2M8aU9dPYublzZavxq3JACumEsXtT+ruXbU?=
 =?us-ascii?Q?0eRUmMRPtyb9Aq3eqkmgeyroMd574vFpjRT1TNEGqFOhYz3jarjgAYdejIrD?=
 =?us-ascii?Q?WrJBsdoEqtJXJlVnDFgyv1QUsloHPwSlS9bd6nQTn9AjiydJrj+EI/bhsl7e?=
 =?us-ascii?Q?c9kqc6xE8MbfvazSFDvq+qTs+ZD1zSTtsVXSndbnUNhXoezhaYwAN/6BbfBA?=
 =?us-ascii?Q?v7evsdsEVQl2EqWcjEVYgd8GnIGc+10YCuD5QkIGukv1QBOJYXjYNM18bc/T?=
 =?us-ascii?Q?GeGM6eJGbpKtybSvMvq784t9ceYIwLpOJWl3hkPkiKm4Yee2T3nLrhG2JBFB?=
 =?us-ascii?Q?2ho7d7U5iqYwMClxLC28mEuvWZ7pBlmkCWey4/qlZOOPRDOo+kjYCnwTdCUK?=
 =?us-ascii?Q?jIgr2u/tHKaTxXBgH31pXS6cYTIIYx7XF36eJoQsOdLIFh/kAy2wcAq7Sa90?=
 =?us-ascii?Q?w+5kRgXXjo4rnLDPMVO8BmQkRO+5woP7zq44HBt9yCqXvRZ/1vltbJ+uApZX?=
 =?us-ascii?Q?Ln26pdnsmeop9cywar7wchnF5XYjcptHMtPBdZzh03PIjcEQVCXbOkKVY292?=
 =?us-ascii?Q?j9NIMqv/yZXIraWErBH/I5zDhri/OsPIpIxVni/qUxogcgWfYu2GM5q7s5e9?=
 =?us-ascii?Q?Y3qXAOIZWhWfJxpZkn8KSdXrc2B6Gs7K6AYmUkK50LIZ6vykfSuoAuXQhNMT?=
 =?us-ascii?Q?eKiK54PIWO9bAUBJoN6BzyyMP1gJOh1qyflfsQnc6PHurw0tqJqIQbgOQCGv?=
 =?us-ascii?Q?qmhyM9NxYApzveeTb5BqcS53wtJYCiQvh5jinVkSZQzDWH8p+N0mpD22Tg//?=
 =?us-ascii?Q?c7jRUv7mMiX41p1kqHRSLZ1mvyfUOBiryv9Ug6JSDXY6QRwSxoyy4HBw8jbQ?=
 =?us-ascii?Q?FMwPB1Fe83dlRMwuEbQPjACVstU4JyD+Bj4276XnG6ckjejHCn5dcoTEco4X?=
 =?us-ascii?Q?huFHmMwmXZ71jNpTLLMUbuEDmxwpLjB4NfWCzQRFHi0epOVzWEo7syp9yGdN?=
 =?us-ascii?Q?5PTAzDfYLereNn4DNiBLiKcMWIATV4gpxvAdOS5/dlSeRLFgiwW31k4/1rjp?=
 =?us-ascii?Q?Bi0NlrB5/OzTmwvGIrkFMTq3D488KXkaqinuvMan2ST/4DkGj2x22Xz5gTWA?=
 =?us-ascii?Q?FcOxpm/hntgW4C3dQQWrphvFXjmoT1jy+IpY7/HctvJ6qEXaQa1XQI+lfbnD?=
 =?us-ascii?Q?6ZCDt47lPxPerfasgIzOxiTkJpcssD67z34Ij3YXJBAWdQT1Cn/WmBwbaf6H?=
 =?us-ascii?Q?JEn0wAob1DqMu8Qi5YHa2gKPICkD8jRSjdttKMukPG8fJDUu37F9AzE9DfJQ?=
 =?us-ascii?Q?pwp0UBfqWGxhcm3/Ryiozx4lYDgW5LpQU9jqriD8msJWbYGH8+eV1tWJElQ/?=
 =?us-ascii?Q?meAvORnOj3hzBZkZtxau5BmSgxbT61vvQFO9essuZHf7toFYE4Lk8yF4W2UH?=
 =?us-ascii?Q?HS3KaGvxXUNceqtZ+TzcyMnepuP22GkBIPbdH4du8rGncv/gdtElTObqqABo?=
 =?us-ascii?Q?YQyy9Z6Fmro1Mvxm4lBlgkeBXFRas9PkJmYlE7fm1Wo7YKX9RhWEi1wHQ18z?=
 =?us-ascii?Q?gwRr2RMyecPUfYqRcl6VCQidKCR9/Y++GHSK8u2fNS/X+kIGRCvFUqUERMY5?=
 =?us-ascii?Q?0Gcj68RCkQdafBcNclEiFIJON9p/VXYajqBVOEktxNmWjo3ZGsLTPFeGGSfO?=
 =?us-ascii?Q?mefEUYxvH1yGt7tx2oEVOK043ijQZ7rFc6mBjw/VPoWo1JCr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6992a0-b806-48da-33a2-08de5a96485f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:44:24.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hb8aXWOYbr5d7ROMFmv9nyiL2jsMw12uzjZQ7I8Uec2BqGsrtftH7nqJ2Yh8sK6fANoWGB+oUh/F2hUqXNPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8877
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8466-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[valinux.co.jp,intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synopsys.com:email]
X-Rspamd-Queue-Id: D8FE977F13
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 09:32:37PM +0530, Vinod Koul wrote:
> On 19-01-26, 23:26, Koichiro Den wrote:
> > On Sun, Jan 18, 2026 at 12:03:19PM -0500, Frank Li wrote:
> > > On Sun, Jan 18, 2026 at 10:54:04PM +0900, Koichiro Den wrote:
> > > > DesignWare EP eDMA can generate interrupts both locally and remotely
> > > > (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> > > > completions should be handled locally, remotely, or both. Unless
> > > > carefully configured, the endpoint and host would race to ack the
> > > > interrupt.
> > > >
> > > > Introduce a per-channel interrupt routing mode and export small APIs to
> > > > configure and query it. Update v0 programming so that RIE and local
> > > > done/abort interrupt masking follow the selected mode. The default mode
> > > > keeps the original behavior, so unless the new APIs are explicitly used,
> > > > no functional changes.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c    | 52 +++++++++++++++++++++++++++
> > > >  drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++-----
> > > >  include/linux/dma/edma.h              | 44 +++++++++++++++++++++++
> > > >  4 files changed, 116 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index b9d59c3c0cb4..059b3996d383 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -768,6 +768,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > > >  		chan->configured = false;
> > > >  		chan->request = EDMA_REQ_NONE;
> > > >  		chan->status = EDMA_ST_IDLE;
> > > > +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> > > >
> > > >  		if (chan->dir == EDMA_DIR_WRITE)
> > > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > > > @@ -1062,6 +1063,57 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > > >
> > > > +int dw_edma_chan_irq_config(struct dma_chan *dchan,
> > > > +			    enum dw_edma_ch_irq_mode mode)
> > > > +{
> > > > +	struct dw_edma_chan *chan;
> > > > +
> > > > +	switch (mode) {
> > > > +	case DW_EDMA_CH_IRQ_DEFAULT:
> > > > +	case DW_EDMA_CH_IRQ_LOCAL:
> > > > +	case DW_EDMA_CH_IRQ_REMOTE:
> > > > +		break;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (!dchan || !dchan->device)
> > > > +		return -ENODEV;
> > > > +
> > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > +	if (!chan)
> > > > +		return -ENODEV;
> > > > +
> > > > +	chan->irq_mode = mode;
> > > > +
> > > > +	dev_vdbg(chan->dw->chip->dev, "Channel: %s[%u] set irq_mode=%u\n",
> > > > +		 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > > > +		 chan->id, mode);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
> > > > +
> > > > +bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
> > > > +{
> > > > +	struct dw_edma_chan *chan;
> > > > +	struct dw_edma *dw;
> > > > +
> > > > +	if (!dchan || !dchan->device)
> > > > +		return false;
> > > > +
> > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > +	if (!chan)
> > > > +		return false;
> > > > +
> > > > +	dw = chan->dw;
> > > > +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> > > > +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> > > > +	else
> > > > +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
> > > > +
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > > > index 71894b9e0b15..8458d676551a 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > > @@ -81,6 +81,8 @@ struct dw_edma_chan {
> > > >
> > > >  	struct msi_msg			msi;
> > > >
> > > > +	enum dw_edma_ch_irq_mode	irq_mode;
> > > > +
> > > >  	enum dw_edma_request		request;
> > > >  	enum dw_edma_status		status;
> > > >  	u8				configured;
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > index 2850a9df80f5..80472148c335 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > > >  	for_each_set_bit(pos, &val, total) {
> > > >  		chan = &dw->chan[pos + off];
> > > >
> > > > -		dw_edma_v0_core_clear_done_int(chan);
> > > > -		done(chan);
> > > > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > > > +			dw_edma_v0_core_clear_done_int(chan);
> > > > +			done(chan);
> > > > +		}
> > > >
> > > >  		ret = IRQ_HANDLED;
> > > >  	}
> > > > @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > > >  	for_each_set_bit(pos, &val, total) {
> > > >  		chan = &dw->chan[pos + off];
> > > >
> > > > -		dw_edma_v0_core_clear_abort_int(chan);
> > > > -		abort(chan);
> > > > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > > > +			dw_edma_v0_core_clear_abort_int(chan);
> > > > +			abort(chan);
> > > > +		}
> > > >
> > > >  		ret = IRQ_HANDLED;
> > > >  	}
> > > > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > > >  		j--;
> > > >  		if (!j) {
> > > >  			control |= DW_EDMA_V0_LIE;
> > > > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > > > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> > > >  				control |= DW_EDMA_V0_RIE;
> > > >  		}
> > > >
> > > > @@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > >  				break;
> > > >  			}
> > > >  		}
> > > > -		/* Interrupt unmask - done, abort */
> > > > +		/* Interrupt mask/unmask - done, abort */
> > > >  		raw_spin_lock_irqsave(&dw->lock, flags);
> > > >
> > > >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > > > -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > > -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> > > > +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > > +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > +		} else {
> > > > +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > > +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > +		}
> > > >  		SET_RW_32(dw, chan->dir, int_mask, tmp);
> > > >  		/* Linked list error */
> > > >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index ffad10ff2cd6..6f50165ac084 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -60,6 +60,23 @@ enum dw_edma_chip_flags {
> > > >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> > > >  };
> > > >
> > > > +/*
> > > > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > > > + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> > > > + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
> > > > + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> > > > + *
> > > > + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> > > > + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> > > > + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> > > > + * Write Interrupt Generation".
> > > > + */
> > > > +enum dw_edma_ch_irq_mode {
> > > > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > > > +	DW_EDMA_CH_IRQ_LOCAL,
> > > > +	DW_EDMA_CH_IRQ_REMOTE,
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > > >   * @dev:		 struct device of the eDMA controller
> > > > @@ -105,6 +122,22 @@ struct dw_edma_chip {
> > > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > > +/**
> > > > + * dw_edma_chan_irq_config - configure per-channel interrupt routing
> > > > + * @chan: DMA channel obtained from dma_request_channel()
> > > > + * @mode: interrupt routing mode
> > > > + *
> > > > + * Returns 0 on success, -EINVAL for invalid @mode, or -ENODEV if @chan does
> > > > + * not belong to the DesignWare eDMA driver.
> > > > + */
> > > > +int dw_edma_chan_irq_config(struct dma_chan *chan,
> > > > +			    enum dw_edma_ch_irq_mode mode);
> > > > +
> > > > +/**
> > > > + * dw_edma_chan_ignore_irq - tell whether local IRQ handling should be ignored
> > > > + * @chan: DMA channel obtained from dma_request_channel()
> > > > + */
> > > > +bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> > > >  #else
> > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > >  {
> > > > @@ -115,6 +148,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > > >  {
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +static inline int dw_edma_chan_irq_config(struct dma_chan *chan,
> > > > +					  enum dw_edma_ch_irq_mode mode)
> > > > +{
> > > > +	return -ENODEV;
> > > > +}
> > > > +
> > > > +static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
> > > > +{
> > > > +	return false;
> > > > +}
> > >
> > > I think it'd better go thought
> > >
> > > struct dma_slave_config {
> > > 	...
> > >         void *peripheral_config;
> > > 	size_t peripheral_size;
> > >
> > > };
> > >
> > > So DMA consumer can use standard DMAengine API, dmaengine_slave_config().
> >
> > Using .peripheral_config wasn't something I had initially considered, but I
> > agree that this is preferable in the sense that it avoids introducing the
> > additional exported APIs. I'm not entirely sure whether it's clean to use
> > it for non-peripheral settings in the strict sense, but there seem to be
> > precedents such as stm32_mdma_dma_config, so I guess it seems acceptable.
> > If I'm missing something, please correct me.
>
> Strictly speaking slave config should be used for peripheral transfers.
> For memcpy users (this seems more like that), I would argue slave config
> does not make much sense.

It is not memcpy because one side address is not visible. It is really
hard to define the difference between memcpy and slave transfer because
- some slave transfer use MMIO, both side address increase, not like
tranditional FIFO. it makes more like memcpy.
- althougth it look like memcpy, but some slave have limitation, like need
4 bytpe alignment, there are limitation about burst length each time.
Generally, memcpy have not such limitation (except from dmaengine itself).
- slave address may not visialable at one side system.

So dw-edma don't use prep_memcpy, which use prep_sg to do data transfer.

Frank
>
> --
> ~Vinod

